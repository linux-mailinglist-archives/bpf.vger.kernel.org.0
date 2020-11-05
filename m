Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84022A8A47
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 23:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbgKEW7E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 17:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbgKEW6h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 17:58:37 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4DBC061A4A
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 14:58:36 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k18so3152496wmj.5
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 14:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMcFW95G8fkznbcNMh9DZ4j06RhSQWUhozGzIcGrvhA=;
        b=Kki+hqkEHc06t8PRC7IYqOfjy+Qoci7jCk9bKS9kx1H41SBaPll1DNW8S0dmjHn8T7
         9tyLf7ylgubRx/iods4ii3Ng9+KIuL8N7dJSFIgBzSlZCB9UX46Abqw/B8aMeUDnk/3n
         BPtKgxWpMdx1lVtAfdrJd9M6C+V0FW4bSE80s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMcFW95G8fkznbcNMh9DZ4j06RhSQWUhozGzIcGrvhA=;
        b=W/9ER6j0yBx1Hz6utbnRds5OpWoAKOdSIlzQhY2UfFqlounMPmVMYXPLmLAfXyXXk/
         50EYy9sZgOippU4FUe4I+ZLMvIUdget9mxMrk9cM8HLLobEvAvzUpIuZ6I4BDQsPesxU
         n4Q06FmCHQqqtt6Vzb80NgTVa0ygmzZGzpAWT2IAMpoYV8vFIfRyTlMPAcXpxGZAoMWZ
         Et0xoIgEWZ31zhztciXlG7IEtIZFHdOv3JHahXOCKLZoThrrQYLNcKzMeYRzDEzjk+2J
         b7ob5MDTJAJNP7JVd9uY6IbaIEU1zIXPbYUsuBwt2nosKj3IK/2UwgMV88nCtvxCcPPk
         0dSg==
X-Gm-Message-State: AOAM531+G49BTEW622CowWnvP09Sz9bLMdioVB/xgBN8rFT3Y6RRh66I
        iKt40ha14MQDdYfcvydqXDkCWQ==
X-Google-Smtp-Source: ABdhPJzX5h1s9o36QUguPz4PtHeJBrSwb2t5UlMGjhncXw+ljqzSzvRXag42oXm5tJO8M53D8F3+FQ==
X-Received: by 2002:a1c:3846:: with SMTP id f67mr5103728wma.33.1604617115725;
        Thu, 05 Nov 2020 14:58:35 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f19sm3977366wml.21.2020.11.05.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:58:34 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v5 6/9] bpf: Fix tests for local_storage
Date:   Thu,  5 Nov 2020 22:58:24 +0000
Message-Id: <20201105225827.2619773-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105225827.2619773-1-kpsingh@chromium.org>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The {inode,sk}_storage_result checking if the correct value was retrieved
was being clobbered unconditionally by the return value of the
bpf_{inode,sk}_storage_delete call.

Also, consistently use the newly added BPF_LOCAL_STORAGE_GET_F_CREATE
flag.

Acked-by: Song Liu <songliubraving@fb.com>
Fixes: cd324d7abb3d ("bpf: Add selftests for local_storage")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../selftests/bpf/progs/local_storage.c       | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 0758ba229ae0..09529e33be98 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -58,20 +58,22 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct dummy_storage *storage;
+	int err;
 
 	if (pid != monitored_pid)
 		return 0;
 
 	storage = bpf_inode_storage_get(&inode_storage_map, victim->d_inode, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
+					BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
-	if (storage->value == DUMMY_STORAGE_VALUE)
+	if (storage->value != DUMMY_STORAGE_VALUE)
 		inode_storage_result = -1;
 
-	inode_storage_result =
-		bpf_inode_storage_delete(&inode_storage_map, victim->d_inode);
+	err = bpf_inode_storage_delete(&inode_storage_map, victim->d_inode);
+	if (!err)
+		inode_storage_result = err;
 
 	return 0;
 }
@@ -82,19 +84,23 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct dummy_storage *storage;
+	int err;
 
 	if (pid != monitored_pid)
 		return 0;
 
 	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
-	if (storage->value == DUMMY_STORAGE_VALUE)
+	if (storage->value != DUMMY_STORAGE_VALUE)
 		sk_storage_result = -1;
 
-	sk_storage_result = bpf_sk_storage_delete(&sk_storage_map, sock->sk);
+	err = bpf_sk_storage_delete(&sk_storage_map, sock->sk);
+	if (!err)
+		sk_storage_result = err;
+
 	return 0;
 }
 
@@ -109,7 +115,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 		return 0;
 
 	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
@@ -131,7 +137,7 @@ int BPF_PROG(file_open, struct file *file)
 		return 0;
 
 	storage = bpf_inode_storage_get(&inode_storage_map, file->f_inode, 0,
-				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+					BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
-- 
2.29.1.341.ge80a0c044ae-goog

