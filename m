Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA712CED35
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 12:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgLDLiC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 06:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbgLDLiC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 06:38:02 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE1C08ED7E
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 03:36:25 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k10so5250906wmi.3
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 03:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyRQtwUVPchseVZD4yOUMEQ+9v0rbAcMPCLy6LkBBi4=;
        b=R4iT+bIdHdbh7tMQOgwRv7QFGFII1EnEAImngVOC0Q6JhCVjtZfrWeny5oVnQWvFua
         6QMhniYAz7CGis6YLEayxrXKmtoAIlTeZKC8Mpi+4wvAlvFMO2KxRkwT+Y9tTIU6J/y3
         ftW1DEVbT4ZV/uTfl77S9F5Y+9IXUvArxWSGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyRQtwUVPchseVZD4yOUMEQ+9v0rbAcMPCLy6LkBBi4=;
        b=Co9ryvbTYXhRa5uphm9CqcDe1VDT4pzr4WX6qrkCuQJhoHCrlR49N2pttLW9vW8vwW
         7mjpuG6xG4mSVVxAMRGo7y0S3C8z1z834pdsyBLF5fBtstic4IThqQGJmvI+NNE4ThVe
         lcT81gd0CCJ7IpDYeTkAlZlhTj4ux9KiVuFDxurW9DML6K/cbDvxJrcN9G6usRFEo5uU
         NijwmFw4MhhtHr4fBpuzRftByWgiPmp5ZIme3/pJcI4SP5mYCnBCsPVHfyWttXU52Y9d
         E9gWSUSUQI5v4KAwQFgFbrmfltHMRF4Yk6Sqiv9B8pWNtykD92rMN2bnLMTDyQuJVCBM
         Y8iQ==
X-Gm-Message-State: AOAM532uapf3w8/bv6UNT5Rn6UdDm8bt5txLu83lv/fg5WAkNM2PT6UJ
        /Fnt3meqevNCQVIEoavGkGI0Dovb5YPcvg==
X-Google-Smtp-Source: ABdhPJxBHDiSFpvIwBZ3LLjsOLJAR5gRmNeAmLao09rLtZBdZ4kuV10hwlCDTkzz3vRgp9eZtQZb9A==
X-Received: by 2002:a1c:810c:: with SMTP id c12mr3786940wmd.96.1607081783713;
        Fri, 04 Dec 2020 03:36:23 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id j6sm3202750wrq.38.2020.12.04.03.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 03:36:23 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 6/6] selftests/bpf: Test bpf_sk_storage_get in tcp iterators
Date:   Fri,  4 Dec 2020 12:36:09 +0100
Message-Id: <20201204113609.1850150-6-revest@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201204113609.1850150-1-revest@google.com>
References: <20201204113609.1850150-1-revest@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This extends the existing bpf_sk_storage_get test where a socket is
created and tagged with its creator's pid by a task_file iterator.

A TCP iterator is now also used at the end of the test to negate the
values already stored in the local storage. The test therefore expects
-getpid() to be stored in the local storage.

Signed-off-by: Florent Revest <revest@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c        | 18 ++++++++++++++++--
 .../progs/bpf_iter_bpf_sk_storage_helpers.c    | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 9336d0f18331..0e586368948d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -978,6 +978,8 @@ static void test_bpf_sk_storage_delete(void)
 /* This creates a socket and its local storage. It then runs a task_iter BPF
  * program that replaces the existing socket local storage with the tgid of the
  * only task owning a file descriptor to this socket, this process, prog_tests.
+ * It then runs a tcp socket iterator that negates the value in the existing
+ * socket local storage, the test verifies that the resulting value is -pid.
  */
 static void test_bpf_sk_storage_get(void)
 {
@@ -994,6 +996,10 @@ static void test_bpf_sk_storage_get(void)
 	if (CHECK(sock_fd < 0, "socket", "errno: %d\n", errno))
 		goto out;
 
+	err = listen(sock_fd, 1);
+	if (CHECK(err != 0, "listen", "errno: %d\n", errno))
+		goto close_socket;
+
 	map_fd = bpf_map__fd(skel->maps.sk_stg_map);
 
 	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
@@ -1003,9 +1009,17 @@ static void test_bpf_sk_storage_get(void)
 	do_dummy_read(skel->progs.fill_socket_owner);
 
 	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
-	CHECK(err || val != getpid(), "bpf_map_lookup_elem",
+	if (CHECK(err || val != getpid(), "bpf_map_lookup_elem",
+	    "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
+	    getpid(), val, err))
+		goto close_socket;
+
+	do_dummy_read(skel->progs.negate_socket_local_storage);
+
+	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
+	CHECK(err || val != -getpid(), "bpf_map_lookup_elem",
 	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
-	      getpid(), val, err);
+	      -getpid(), val, err);
 
 close_socket:
 	close(sock_fd);
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
index dde53df37de8..6cecab2b32ba 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
@@ -45,3 +45,21 @@ int fill_socket_owner(struct bpf_iter__task_file *ctx)
 
 	return 0;
 }
+
+SEC("iter/tcp")
+int negate_socket_local_storage(struct bpf_iter__tcp *ctx)
+{
+	struct sock_common *sk_common = ctx->sk_common;
+	int *sock_tgid;
+
+	if (!sk_common)
+		return 0;
+
+	sock_tgid = bpf_sk_storage_get(&sk_stg_map, sk_common, 0, 0);
+	if (!sock_tgid)
+		return 0;
+
+	*sock_tgid = -*sock_tgid;
+
+	return 0;
+}
-- 
2.29.2.576.ga3fc446d84-goog

