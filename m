Return-Path: <bpf+bounces-9889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD179E5B3
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A710E28210F
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363A1E538;
	Wed, 13 Sep 2023 11:03:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A821E51F;
	Wed, 13 Sep 2023 11:03:17 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95319B3;
	Wed, 13 Sep 2023 04:03:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f85854b9eso646865f8f.0;
        Wed, 13 Sep 2023 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694602995; x=1695207795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK3DdqhE57yLQUwMe7Dn0zw5j7ZU8/ZFz0lGjuSV7SM=;
        b=K8pfBN9kfmSpsa7HlGliyHVxDluT7//tGkm3ndptuoFmkYzrO3UxZs2xWqwrYxCzkV
         h9pjsYKXqBwar4KNnhuyotIYtfWpellFWiy1hDUP+9Rz3x/Oeacn9D5b++MZIIEhsbIQ
         Q+6V15hWGCdxnaoJHai61QgQu0U2Qx3hU4cJw/6WtQlLlSGzRx0Ac2ZZGqcYPXxbjL/L
         d+Jkhdymi8AHPBoa8G0mpRmP0++IkvKQxOibgd4XO3WjQCd63OB7yQuQPABPv8WcIYki
         BmzkdYkfeee/K8u/AP7EeV9Yd9J3UQqF48GZpEXOXGIjXq8aNYeTZbzJETuAskxGhNhK
         w6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602995; x=1695207795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KK3DdqhE57yLQUwMe7Dn0zw5j7ZU8/ZFz0lGjuSV7SM=;
        b=axksNlkfiWjO+lKNdv3qttmuZrZOZMeMxBnHuxzjV9U1RpatyGywdMrpKFRf9sFGLG
         XlNYDT8HhVHPuV6Z5QgSeFdU60poR7vD5mGrvkxsHYfEpC0FKssf2euJKJUlCBUSVXop
         lIKTukY3Qt1Wx2MS3GSVMy+Rj+bKbyXSuAyC3gjhC0xo2pQ5XU11EJgWhaDMdfhHMxTo
         SC12XaPLMJvoa0S+mkg5hfcW+lbEw0219/BGjLn0WFSUHVzrq2DWZZ1+ORADENpK4S3L
         74kgbXA5hxPOgX9asoNT3tkthA14fCxuY/IaDydK/vHPYvY+MLrYgJ7Dnf34q+ZnhGik
         +0pg==
X-Gm-Message-State: AOJu0YxMDEWLU7NzwAqDtdHeZ5tTRH8DFh26OxsY0wV6122O57A8YHaU
	4l9kxuXZEj+E0+nxMWgp0zOlx3S7b2Ol9vLg
X-Google-Smtp-Source: AGHT+IGQDCHXBMMuKTeoOpKloEo9xNSMjmZW8NwqpAWDWkf8EeYNTihH/BKjQwnjKNN6F9JbA3BVNw==
X-Received: by 2002:a5d:5308:0:b0:317:5f08:329f with SMTP id e8-20020a5d5308000000b003175f08329fmr1818621wrv.1.1694602995046;
        Wed, 13 Sep 2023 04:03:15 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm15255289wrv.111.2023.09.13.04.03.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:03:14 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	bpf@vger.kernel.org,
	yhs@fb.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [PATCH bpf-next v3 02/10] selftests/xsk: add timeout for Tx thread
Date: Wed, 13 Sep 2023 13:02:24 +0200
Message-ID: <20230913110248.30597-3-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913110248.30597-1-magnus.karlsson@gmail.com>
References: <20230913110248.30597-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magnus Karlsson <magnus.karlsson@intel.com>

Add a timeout for the transmission thread. If packets are not
completed properly, for some reason, the test harness would previously
get stuck forever in a while loop. But with this patch, this timeout
will trigger, flag the test as a failure, and continue with the next
test.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 26 ++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index c595c0b65417..514fe994e02b 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1216,10 +1216,29 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
 	return TEST_CONTINUE;
 }
 
-static void wait_for_tx_completion(struct xsk_socket_info *xsk)
+static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 {
-	while (xsk->outstanding_tx)
+	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	int ret;
+
+	ret = gettimeofday(&tv_now, NULL);
+	if (ret)
+		exit_with_error(errno);
+	timeradd(&tv_now, &tv_timeout, &tv_end);
+
+	while (xsk->outstanding_tx) {
+		ret = gettimeofday(&tv_now, NULL);
+		if (ret)
+			exit_with_error(errno);
+		if (timercmp(&tv_now, &tv_end, >)) {
+			ksft_print_msg("ERROR: [%s] Transmission loop timed out\n", __func__);
+			return TEST_FAILURE;
+		}
+
 		complete_pkts(xsk, BATCH_SIZE);
+	}
+
+	return TEST_PASS;
 }
 
 static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
@@ -1242,8 +1261,7 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 			return ret;
 	}
 
-	wait_for_tx_completion(ifobject->xsk);
-	return TEST_PASS;
+	return wait_for_tx_completion(ifobject->xsk);
 }
 
 static int get_xsk_stats(struct xsk_socket *xsk, struct xdp_statistics *stats)
-- 
2.42.0


