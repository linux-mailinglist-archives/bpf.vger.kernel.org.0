Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C372F21B8
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 22:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbhAKVYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 16:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbhAKVYa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 16:24:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68BB922D07;
        Mon, 11 Jan 2021 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610400229;
        bh=N+tuxWx87vPmund4vW5LaY2745TK4fZDCWZpeXqaJ6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXdium/6+TbzyqKL2mSkXBbkVFCQi8sDeVOdJoNRBtIaLPW+sVF+6eTUIQFK3vAjc
         4eZdFiASJbN8IS2tQmRjPUPZj0wwtNQLLZ5giuAu80wv9dUTxOwQunsqDeTY2r7bUo
         JScZlgt9XCFjPkk5FZvaFPAUGKXbU1R5xtRjvvYho4dhdAajHCYloFDjbUTEABbpvn
         Bzv15fgOcpx7XPfYRDX7ORGylaMT3fLkE8yQDZutCQqpXsTjJO18YUbB5oBE3iiZEB
         IsXx0FXJc6H3RqOY+nkM43xL4/AsLIw/j2jkHfCv8VrvVROSDm/wiQqEiagfHxvYul
         GGztqUqGZchKA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf v2 3/3] bpf: Fix typo in bpf_inode_storage.c
Date:   Mon, 11 Jan 2021 21:23:40 +0000
Message-Id: <20210111212340.86393-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210111212340.86393-1-kpsingh@kernel.org>
References: <20210111212340.86393-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix "gurranteed" -> "guaranteed" in bpf_inode_storage.c

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/bpf_inode_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index dbc1dbdd2cbf..2f0597320b6d 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -183,7 +183,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 	if (sdata)
 		return (unsigned long)sdata->data;
 
-	/* This helper must only called from where the inode is gurranteed
+	/* This helper must only called from where the inode is guaranteed
 	 * to have a refcount and cannot be freed.
 	 */
 	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
@@ -203,7 +203,7 @@ BPF_CALL_2(bpf_inode_storage_delete,
 	if (!inode)
 		return -EINVAL;
 
-	/* This helper must only called from where the inode is gurranteed
+	/* This helper must only called from where the inode is guaranteed
 	 * to have a refcount and cannot be freed.
 	 */
 	return inode_storage_delete(inode, map);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

