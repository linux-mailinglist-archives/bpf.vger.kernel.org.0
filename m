Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567CE2A49E1
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 16:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgKCPcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 10:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgKCPbo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:44 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30928C0613D1
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 07:31:44 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w1so19046918wrm.4
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W//uNFyJ3Fc4rXwdibbFHTLW0zEiZsD6VR7KpCWu9Ds=;
        b=mWx7nW/UumWz9TOMC3JtPF03kXyRqWXUJQ0qylouHjGzG72492RLI4EjBTEIyQaxGm
         oFEOhRacT/zkHUFKFOgc/uI2otaJJC5ViBGSjk2cSxIWztBiOaoqV95A4J9zKMWqy1Ff
         FJiFauVJvtjcul/uS2mAI5AFwBzIBb3Qz5AT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W//uNFyJ3Fc4rXwdibbFHTLW0zEiZsD6VR7KpCWu9Ds=;
        b=Uz5hjiuRpue3cZq2qigj+PgBBSOWiEjOc3j4anaACuY6M/BxWNpAPkwiXZPfl6uLef
         cIbcD6jFfIkKI5Po9iv/LuUkJRrIpxZLQCCvkEnlPyjbruwDlmNObiCqny7OmgX4FSxk
         DIV4L9xqRqBaXbgEXCjnif9zLqBRDTdPTGiw89Z8N8C8G/5HAh9fEzRhk/kDDyvAen/S
         xQLS0rD9l+jyQIYtEzhbeMQDLf+sPDBw8gJrh5oyxHQ3DBiTJxUAO7NtrhylbZgbn6Xl
         x9vchArdWObZ0Zncwv7ALF+4K567L1b9WS46wPs80YOM+nZlteAQnS9eC3B13vul/Uig
         MAwg==
X-Gm-Message-State: AOAM530lyr4OYHM0CsLgV8hB4a8gI4qAKAP0JAadGDU8IQUqqJcE0ShZ
        U5arzuN+E7/l36UISL8/3Y11vQ==
X-Google-Smtp-Source: ABdhPJzeA+97yHuJjpbukfcf6giWcxJpzGk+zyGfyQ5IHSrPZ1pVqYVZ4F9iR+TmOswROEAmnhaB7Q==
X-Received: by 2002:adf:f1c8:: with SMTP id z8mr28895672wro.371.1604417502937;
        Tue, 03 Nov 2020 07:31:42 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:42 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 5/8] bpf: Fix tests for local_storage
Date:   Tue,  3 Nov 2020 16:31:29 +0100
Message-Id: <20201103153132.2717326-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103153132.2717326-1-kpsingh@chromium.org>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
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

