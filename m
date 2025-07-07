Return-Path: <bpf+bounces-62532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE62AFB7FC
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9753E16EE60
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5657F21ABBD;
	Mon,  7 Jul 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="iQsqCm/i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33722135CE
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903482; cv=none; b=Ic9KwCjGvQPHksPcYx3nF9kvv2ZcWwYh8Ic2gQOlN94ZnKb96AJD5BRX/F7aK0uJASMHkrkqL/Urpl+VGFIdZGh+ATeJKBfDg6/X942Ssl46Q+HGo3pLCrCfsmQ22dDgbr+0OGhZS8soe5FDU31zqqxgU+ovjvysMVd1WqLL10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903482; c=relaxed/simple;
	bh=fyehYhxa8G/73wUbDFErCIWrrsV+XEDbPV1wHnsjius=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCNG60BxrWM6a7sca7/dwfFzHHV8fgwrzcRYvQnsm8LV6fdk9/T4x0Pwf8bvHNdIMD3+TZ6cqK+5hav6XUG4t7MzcYbBj6IYnXKe8xBeGnXTC9vjNymnEYDwYaSPez+pxpBq0muc3kbJboXX0dPX5c7KcdZDyreF37/YNaffStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=iQsqCm/i; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23c71b21f72so4261865ad.2
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903479; x=1752508279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=iQsqCm/iwqRFjtN65yUtN4Mw6rI339gfr/ypCMVQWh4h+a2S2hVYXJDTMbgk4aTK0G
         CBvPefdyn83ljzrF7Kjsajqs9FbSx8OIpeoIZIWigD+xoT41/MXLAvyrJMq/bJH6tYPc
         S6xDwvROnlEFDQJsYLKb+4M42YlRWv8DOewDDsWPoy2nuasykXBRXzPIUp5aS/X99/zf
         oWg8nX27TzKZCkjIMx/9Ll++vQ1/ZU7uEpUef4WBCUiLy4rwjxFxeSSa0+64kq4NxW+f
         PIgrpgV5g4uH7IpX5+fNuYUypUGGETjrLJse0FSWOtXIefAlmxp1XuUrgM0Za69LY6J5
         TwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903479; x=1752508279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=gD8OJ6yVPzESBuXjmogIKTTCSdYSFJjLs6b2pVdZAX7ninwiGYscToEz0D4t1BKghC
         EDUu501Bkwj1irjV4VKb2OlGnWbWnxJgaovjfvJXEnm8zXlfKENhuGcTbNNDsDIhUNix
         bC5sDri/CesXFjE15xOTiy1gtpsKCG+sgt2VP4etC4Sl5qOFcT/OuCq57/4eeXHSTpxv
         WswtvljLJKkMbuwGi3xCNQmTgicJ2R7Dv0DDoHka5tdM2lQhoYk1rXm/4gytr04BV8AE
         WDMdNy5y0vuqAWnmdDUlDYhXrR+jZhazr5KfN6CslcGsq/iG2QgiU5gGsSsHbGpDaIw8
         AJZA==
X-Forwarded-Encrypted: i=1; AJvYcCXcM+euIc3dXcuTIP6qTjm6HWqTPbBntVKP1Mg7gLgdwue7Io5tpGZ7TGAxKhy/CbyxU2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAov/NgvXH5NK1yMb46LYJxyYtk3a+llyo06X5QGvgkmOAFPn
	ap6/5MLOI0U10ULQ2EmLxbKd4/Mr+yN/UIDsjPCjkrAe2Z1BY/hXwzs6DDR32P/JJ+U=
X-Gm-Gg: ASbGncsfnfC+AwualWzJ60PEl18BpwmQetZTYH8119COcaTnp8qsesfGdheLo7oe2s1
	uodI+clE2Vez1PxgOLxshIWoLs6vudzFGEvOZ8IsydSgxuuflZ+6PytAJ+KyBaTTuklZnupcweu
	qFRU/h8NEDeB1KbkJLb5byaxwUyDb1Q0V7VzPNFLLwHgu7SZyPl4u7Xe69hitKh7uGmyRjnBNI9
	mDJMg4vXE+ooWIdZJ6wTdY5UbA0Wg2i3WPOvBc4vRC6cb7WIL4SAE9AJfg5yiPKSCmdRXXOfj8d
	aQYoasPB7op/Cdwdsb2bJu/+a5n/HlVrH25LSuzR8uhSAvFw104=
X-Google-Smtp-Source: AGHT+IFNwPOQ0+Ea+Zf477ylL1WBkeOblKh1A0EwysSZGArW8OtPPY1it65xHTOVu1d6Q2EsvdbwmA==
X-Received: by 2002:a17:902:da84:b0:235:1ae7:a9ab with SMTP id d9443c01a7336-23c8723fc2cmr75987945ad.3.1751903479164;
        Mon, 07 Jul 2025 08:51:19 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:18 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v4 bpf-next 09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Mon,  7 Jul 2025 08:50:57 -0700
Message-ID: <20250707155102.672692-10-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for bucket resume tests for established TCP sockets by making
the number of ehash buckets configurable. Subsequent patches force all
established sockets into the same bucket by setting ehash_buckets to
one.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 4e15a0c2f237..18da2d901af7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -6,6 +6,7 @@
 #include "sock_iter_batch.skel.h"
 
 #define TEST_NS "sock_iter_batch_netns"
+#define TEST_CHILD_NS "sock_iter_batch_child_netns"
 
 static const int init_batch_size = 16;
 static const int nr_soreuse = 4;
@@ -304,6 +305,7 @@ struct test_case {
 		     int *socks, int socks_len, struct sock_count *counts,
 		     int counts_len, struct bpf_link *link, int iter_fd);
 	const char *description;
+	int ehash_buckets;
 	int init_socks;
 	int max_socks;
 	int sock_type;
@@ -410,13 +412,25 @@ static struct test_case resume_tests[] = {
 static void do_resume_test(struct test_case *tc)
 {
 	struct sock_iter_batch *skel = NULL;
+	struct sock_count *counts = NULL;
 	static const __u16 port = 10001;
+	struct nstoken *nstoken = NULL;
 	struct bpf_link *link = NULL;
-	struct sock_count *counts;
 	int err, iter_fd = -1;
 	const char *addr;
 	int *fds = NULL;
 
+	if (tc->ehash_buckets) {
+		SYS_NOFAIL("ip netns del " TEST_CHILD_NS);
+		SYS(done, "sysctl -w net.ipv4.tcp_child_ehash_entries=%d",
+		    tc->ehash_buckets);
+		SYS(done, "ip netns add %s", TEST_CHILD_NS);
+		SYS(done, "ip -net %s link set dev lo up", TEST_CHILD_NS);
+		nstoken = open_netns(TEST_CHILD_NS);
+		if (!ASSERT_OK_PTR(nstoken, "open_child_netns"))
+			goto done;
+	}
+
 	counts = calloc(tc->max_socks, sizeof(*counts));
 	if (!ASSERT_OK_PTR(counts, "counts"))
 		goto done;
@@ -453,6 +467,9 @@ static void do_resume_test(struct test_case *tc)
 	tc->test(tc->family, tc->sock_type, addr, port, fds, tc->init_socks,
 		 counts, tc->max_socks, link, iter_fd);
 done:
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " TEST_CHILD_NS);
+	SYS_NOFAIL("sysctl -w net.ipv4.tcp_child_ehash_entries=0");
 	free(counts);
 	free_fds(fds, tc->init_socks);
 	if (iter_fd >= 0)
-- 
2.43.0


