Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FB129BF95
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1815604AbgJ0RD1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 13:03:27 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46524 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1815586AbgJ0RD0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 13:03:26 -0400
Received: by mail-ej1-f65.google.com with SMTP id t25so3243385ejd.13
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKpbp5tLKrx4E3kA/suf0qS9QFr5GErugOK/qmWT90k=;
        b=BcP2nYHJR8nnViNjfk9KQSLLFH0I14xpcUhZIZlbeqeigAfm8RwiGwuhQqGsx8NDet
         R7w38I2bqUd7+x8cienEONRDgEMnthkwRSv1omGHMuOT+3r/cny6ixGIhf9ioy9KULi2
         GXhrsXSx5CuvV2GyUFERiqNjK7GXZ6PGJgVvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKpbp5tLKrx4E3kA/suf0qS9QFr5GErugOK/qmWT90k=;
        b=JkWmcQYTviQL9uM61LOnr3/4D7AMEYp0czei8Yj6XkKfR8OVomNe4aPSL8uhYLCC/A
         1syl4tWXFJvRTChoy8rHDPdU5J3NTp5hdZXxaNruYmEHMF1BaesNKyjKdrbbwYq+PO9P
         /KjiqMJwWQOhTFWp8oKVJsxHClFeaMhS4m5RjU5uuspLBUYTVFH+P4LcrqiCWbuP0KuG
         lfztuf0SWIhlJwEo43ilS93cJ0vftbbcaT5LJse2uTMf4TH3vWKKOOZF/lfV2ja6PCF1
         CvG8v/WnajOavNnGZLbQcuous3mwOHC/YN9OlQRzdgP1ABgTFHcekDbTASi2uQO0jQHf
         CdUQ==
X-Gm-Message-State: AOAM531JUGtMtY1BE4J/ryB88WzZJ0C1+Ofrili9N8RhWmYpNhwpGuGc
        wSnEKMz6lwMkvrXCDM86ZNz2QQ==
X-Google-Smtp-Source: ABdhPJwHw9Z60FvOYgOEz0hdLYfuotw+LejiDOIBfN0kXfj7WFC4coGSFAKpf5Y4+Qgqq5fvjmBIMg==
X-Received: by 2002:a17:907:366:: with SMTP id rs6mr3357069ejb.352.1603818204524;
        Tue, 27 Oct 2020 10:03:24 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id ba6sm1315006edb.61.2020.10.27.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:03:23 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 3/5] bpf: Fix tests for local_storage
Date:   Tue, 27 Oct 2020 18:03:15 +0100
Message-Id: <20201027170317.2011119-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
In-Reply-To: <20201027170317.2011119-1-kpsingh@chromium.org>
References: <20201027170317.2011119-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The {inode,sk}_storage_result checking if the correct value was retrieved
was being clobbered unconditionally by the return value of the
bpf_{inode,sk}_storage_delete call.

Fixes: cd324d7abb3d ("bpf: Add selftests for local_storage")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../testing/selftests/bpf/progs/local_storage.c  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 0758ba229ae0..a3d034eb768e 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -58,6 +58,7 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct dummy_storage *storage;
+	int err;
 
 	if (pid != monitored_pid)
 		return 0;
@@ -67,11 +68,12 @@ int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
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
@@ -82,6 +84,7 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct dummy_storage *storage;
+	int err;
 
 	if (pid != monitored_pid)
 		return 0;
@@ -91,10 +94,13 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
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
 
-- 
2.29.0.rc2.309.g374f81d7ae-goog

