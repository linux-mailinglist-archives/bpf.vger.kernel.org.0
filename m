Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0212F21B7
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 22:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbhAKVY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 16:24:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbhAKVY2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 16:24:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B48C722D06;
        Mon, 11 Jan 2021 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610400228;
        bh=GL1pR0GnhN8JThEE4X5ym/IOUfYEZ+UbWkN81zbY3SU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M288OvnR/DClOU3zvM0dH9VB2R/EvZsK+DHKp63DlxTN6nBpY9L1ssmgp6CIddrMJ
         Hta7mtTgiDd5j+TlS/yCB0Yxtc9D5Tp8awZQDgcfx79j9vEdvM43hieKnPwNsfuMfv
         PM8Dm8pBJ0mYZM/hQRuDRrPkJPardf02M9glzAo3iwfRrgMnnGkaLyqpJwintJJLUH
         xJGur2EWYB2YhRN7F99zue/ZHc3dulnmrdmh6FrSDL/Baax6RTvD5dh6XvrjoshVR7
         q1UsTAwUUFIYeF9erZfi4Fhp853v2dGRJUOzZ2d0OrtVcgljxXt1v3XtQTUsHKrV2D
         1BxCKBI7JHAMA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Gilad Reti <gilad.reti@gmail.com>, Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v2 2/3] bpf: local storage helpers should check nullness of owner ptr passed
Date:   Mon, 11 Jan 2021 21:23:39 +0000
Message-Id: <20210111212340.86393-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210111212340.86393-1-kpsingh@kernel.org>
References: <20210111212340.86393-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier allows ARG_PTR_TO_BTF_ID helper arguments to be NULL, so
helper implementations need to check this before dereferencing them.
This was already fixed for the socket storage helpers but not for task
and inode.

The issue can be reproduced by attaching an LSM program to
inode_rename hook (called when moving files) which tries to get the
inode of the new file without checking for its nullness and then trying
to move an existing file to a new path:

  mv existing_file new_file_does_not_exist

The report including the sample program and the steps for reproducing
the bug:

  https://lore.kernel.org/bpf/CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com

Fixes: 4cf1bc1f1045 ("bpf: Implement task local storage")
Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
Reported-by: Gilad Reti <gilad.reti@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/bpf_inode_storage.c | 5 ++++-
 kernel/bpf/bpf_task_storage.c  | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 6edff97ad594..dbc1dbdd2cbf 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -176,7 +176,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 	 * bpf_local_storage_update expects the owner to have a
 	 * valid storage pointer.
 	 */
-	if (!inode_storage_ptr(inode))
+	if (!inode || !inode_storage_ptr(inode))
 		return (unsigned long)NULL;
 
 	sdata = inode_storage_lookup(inode, map, true);
@@ -200,6 +200,9 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 BPF_CALL_2(bpf_inode_storage_delete,
 	   struct bpf_map *, map, struct inode *, inode)
 {
+	if (!inode)
+		return -EINVAL;
+
 	/* This helper must only called from where the inode is gurranteed
 	 * to have a refcount and cannot be freed.
 	 */
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 4ef1959a78f2..e0da0258b732 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -218,7 +218,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 	 * bpf_local_storage_update expects the owner to have a
 	 * valid storage pointer.
 	 */
-	if (!task_storage_ptr(task))
+	if (!task || !task_storage_ptr(task))
 		return (unsigned long)NULL;
 
 	sdata = task_storage_lookup(task, map, true);
@@ -243,6 +243,9 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
 	   task)
 {
+	if (!task)
+		return -EINVAL;
+
 	/* This helper must only be called from places where the lifetime of the task
 	 * is guaranteed. Either by being refcounted or by being protected
 	 * by an RCU read-side critical section.
-- 
2.30.0.284.gd98b1dd5eaa7-goog

