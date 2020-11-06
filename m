Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F422A947F
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 11:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgKFKh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 05:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgKFKhz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:55 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B521C0613CF
        for <bpf@vger.kernel.org>; Fri,  6 Nov 2020 02:37:55 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so859501wmh.4
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2020 02:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMcFW95G8fkznbcNMh9DZ4j06RhSQWUhozGzIcGrvhA=;
        b=BhJRhK2+++FIVXyHuJTbje/CZKQUURrrko4YSLPOlUmFZcEz9O80tS/ldPwwLbHvUa
         fgMIbcyvhM1aaD0IEug22To7BHAcRaRyt2kGb9AYCjZDzO4SPBsIUVevD6GewJeqF3lG
         h+S2Bi1aLoAHI+pogTKxShnlFWZipEYXIY/68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMcFW95G8fkznbcNMh9DZ4j06RhSQWUhozGzIcGrvhA=;
        b=d7HepJr5BMScn9XSkEMA+BV4xHRu8qWE4NbsD2euGXSt6YHqSrgVNpVX14TSVUaJUH
         BVks8fJ3bDn3mmqcTFkVn9DLv2fR28IVmJMhGjEHL+l56btf6VCRRR9HBU/eRK86tinH
         xjL8NpC2xAMK6q5NekC1/NskZRfh81rFCGUpEEyZ14/HBjNf15Pyd1W82vKueZgllNUs
         aWtYhOBJ801zSa3KOCVYdzd4e7Z93KmJBCvTlHeB7I30y/5F1d0O2tPi6037/NfIRs2Q
         kAXmpGEVyCd7U7egfIXu8OI3Hn4y09ubbKVLYb950blCfxvMJuX92DOn/IW4Hec0mvuS
         AzvQ==
X-Gm-Message-State: AOAM5321SkFvWveCOp9/+OkhReDbfgL/atffgHQhkTYV8qG1pIcf7U6g
        1JUjoj8wcJwS02EpJ4wMOT4uiw==
X-Google-Smtp-Source: ABdhPJweVZseMP+ykfOBlXbAOdKCTUUrGL9ab1sfP5bsgoC7o3WAZ33liA6y5usnRe0fDf8WLuuwpw==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr1673463wmi.2.1604659074058;
        Fri, 06 Nov 2020 02:37:54 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:53 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 6/9] bpf: Fix tests for local_storage
Date:   Fri,  6 Nov 2020 10:37:44 +0000
Message-Id: <20201106103747.2780972-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106103747.2780972-1-kpsingh@chromium.org>
References: <20201106103747.2780972-1-kpsingh@chromium.org>
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

