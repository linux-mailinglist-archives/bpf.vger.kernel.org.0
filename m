Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6892C5981
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 17:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403947AbgKZQpy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 11:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391563AbgKZQpq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 11:45:46 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B8C0617A7
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:45:45 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so2812774wrv.6
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8OIjsoCGUrG5WzInzx7EjrjpLAoCJHAB1p5aT6+rCM=;
        b=dfG6QgYG3wMRF+1qrcQJ+2Msv84PvbSL3jc039gEML/SehncbRgKiAD/bpJSolPlDj
         EUxqAunSuZOxiDOtzmUVHLn9dtIljEgKQIbc3HLznqCnP4h+38i+5ksLWz2ffeLaCxdC
         Y9ifZ94RpLOLRqR4Dywo9EY8vXYTQYzsRuEjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8OIjsoCGUrG5WzInzx7EjrjpLAoCJHAB1p5aT6+rCM=;
        b=Qz/UiVNtEORT3dd9SJcc7xQejdbnn1DuTOGn7JeBhEE/7lRZR2YKvLQ7Vb3eBJqtZr
         K2yMZ2cct6UvLt5IB0h5LZp2Q5CwM4/kH9daWUb7AgOgpDmbeaV0H5/JqKKp/Fqt0wiC
         ozKYL9/gC6rov1xxnSH7XrCL5Un9vwy9qYPSkuos7SnTIW7kWw6HvkLpHwS455oloB2K
         GCVlQUrAzW1ducntNUjN+eJ47HqrQ4amI6jWHMQvNYfFNAZuudTp0391b1T6DZ7fQBMT
         empDVb2HDEyOaFfTsnrPrbzaF+wSO9gAKqus3mdZT7UfiTL8y+CHlT+wiCRvxsyLPlJG
         6yNQ==
X-Gm-Message-State: AOAM533xSRRjwKc7GhHXRq5zX7B+jopyix7mJb11trwnZK7BhH44kOTE
        c1PAhdlIyCMDJnVAPfgcRObc8mk1/mgP+7NJ
X-Google-Smtp-Source: ABdhPJzSNy5KWDcCBURNPLt/CBHQyRh/dh9G9EIGL7pKRAi9DE7KKXVSit7SVTmAprKpY/ovGLEU5A==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr4833460wro.287.1606409144239;
        Thu, 26 Nov 2020 08:45:44 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id f17sm8805824wmh.10.2020.11.26.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 08:45:43 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 6/6] bpf: Test bpf_sk_storage_get in tcp iterators
Date:   Thu, 26 Nov 2020 17:44:49 +0100
Message-Id: <20201126164449.1745292-6-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201126164449.1745292-1-revest@google.com>
References: <20201126164449.1745292-1-revest@google.com>
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
---
 .../selftests/bpf/prog_tests/bpf_iter.c        | 13 +++++++++++++
 .../progs/bpf_iter_bpf_sk_storage_helpers.c    | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 9336d0f18331..b8362147c9e3 100644
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
+		goto out;
+
 	map_fd = bpf_map__fd(skel->maps.sk_stg_map);
 
 	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
@@ -1007,6 +1013,13 @@ static void test_bpf_sk_storage_get(void)
 	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
 	      getpid(), val, err);
 
+	do_dummy_read(skel->progs.negate_socket_local_storage);
+
+	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
+	CHECK(err || val != -getpid(), "bpf_map_lookup_elem",
+	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
+	      -getpid(), val, err);
+
 close_socket:
 	close(sock_fd);
 out:
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
index d7a7a802d172..b3f0cb139c55 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
@@ -46,3 +46,21 @@ int fill_socket_owner(struct bpf_iter__task_file *ctx)
 	return 0;
 }
 
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
+
-- 
2.29.2.454.gaff20da3a2-goog

