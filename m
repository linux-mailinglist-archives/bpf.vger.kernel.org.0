Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE0F2ED5C7
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 18:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbhAGRiP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 12:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728966AbhAGRiP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 12:38:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65733233FD;
        Thu,  7 Jan 2021 17:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610041054;
        bh=2hX1cRD2A7aZ85vx9504qeSWNT13L9QYSeFCOzb/17I=;
        h=From:To:Cc:Subject:Date:From;
        b=DYZosgkg9scHB7gboFjA0cDDjyQ+QmZ122XnN+d5xn98uWGbZCVJ3PjH7AAB9udSt
         Ls96YzPivQQv0ahGsuOmP/BlP2HFEofolmFuzovj4k4rX6Y+YUnZHc0jGPPjWbvDhb
         urAmuVH9WWlx+EaotDtwmDJAD9pAtCv9lCco66ljy8iPSrXO/LA7mYLHteiNJ5pFEZ
         aS/sscvK6TqGRm65GbUPtdziw0E2hc6lxSIuKrSYJemK0jta7/ObnOjBSbgz0+/Dxd
         vhW2O/agwSDOrbjK8lRGserXHpF8+qs1QU3KsNlDxOYNBfH6VnS648E6a+lEdaxvbg
         Fl3TT+HE0xPBg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf] bpf: local storage helpers should check nullness of owner ptr passed
Date:   Thu,  7 Jan 2021 17:37:29 +0000
Message-Id: <20210107173729.2667975-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
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

