Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81B22A8150
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 15:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgKEOsl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 09:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbgKEOsG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:06 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8161C0613D4
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 06:48:05 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id a71so1807034edf.9
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 06:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMcFW95G8fkznbcNMh9DZ4j06RhSQWUhozGzIcGrvhA=;
        b=Jj8NkJKLrQadnid/9EocChYwe0TMH2kAPB93JW6WYqx7s5VtZVHUSJMFG2RybSw2Gl
         oDF4MLUAmCM13RdCSQ/fGfDP7bnVDUkwqs7t2Bl4NLPOzuCAYjiXKAFWNguR5NmrGXCR
         PyJRFM5TaEUuehW+iSrLnFD/IQ4W2pPB5UdCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMcFW95G8fkznbcNMh9DZ4j06RhSQWUhozGzIcGrvhA=;
        b=d9mve1T93sysSnUJNqqRCn3LSduey6bNA64So9yjEWlmhVYvE4iLfFUZO6wnEPJDpz
         qoTgyL+6wjP0msB2IZX3aevHzsuCyk0zhPdYpZxBPES0caORR38rSGuLpR0goPZ2Ahjp
         tIJiMng5ECfj137c1Y2F9SebvP9R0qONmKZwoRe+wYDLE8sqUL+tQluI3jt0fQ9KkBIP
         heu6Ut1dmt+ubaXf+Yo7OLdnuE/1outPKUQurMU/99pr2s2GCs/Y1exBZ48qcBlIBdQB
         vFM+XnJr7InVTSzG1SqnmFmB+cp3+Jj4RPIiE5+W/2C+EVj3NlK48MMKxEZjN2TuIWui
         ujCg==
X-Gm-Message-State: AOAM531TqJWnPyxfl838mpQt0nxL9m5TGPkfFdfgsIQHIjHVZ8kzMy/F
        Ng4oZFRInpbr+Z8F7SnvwHcEaw==
X-Google-Smtp-Source: ABdhPJyAGtUh+HHX+TR/NDOktSPXjhpnuF5ETvx3uqgipDjNyBj/XfzLGBDVd4jKJ85f+6UMcm1ZMQ==
X-Received: by 2002:a05:6402:a53:: with SMTP id bt19mr2924240edb.26.1604587684432;
        Thu, 05 Nov 2020 06:48:04 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id z13sm1075870ejp.30.2020.11.05.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:48:03 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v4 6/9] bpf: Fix tests for local_storage
Date:   Thu,  5 Nov 2020 15:47:52 +0100
Message-Id: <20201105144755.214341-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105144755.214341-1-kpsingh@chromium.org>
References: <20201105144755.214341-1-kpsingh@chromium.org>
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

