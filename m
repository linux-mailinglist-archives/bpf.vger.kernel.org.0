Return-Path: <bpf+bounces-7351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE09775F82
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E7E280F09
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF618AE2;
	Wed,  9 Aug 2023 12:44:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3D182A9;
	Wed,  9 Aug 2023 12:44:16 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF319A1;
	Wed,  9 Aug 2023 05:44:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3177d3bdfb3so1545088f8f.0;
        Wed, 09 Aug 2023 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585054; x=1692189854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKocKVkqUz9oK7Yr55YQegYi48PRT/ogXdoEf9SUJ3I=;
        b=lntG8e7gBT/Ii801nRXf0S4++LfPhH4J7Q6FETEmzN07IQbVxHcIksR5JT7Ef1gA/E
         cGsgHeeQGOKRfasaa5B/cXCubbQIDKYYlQNGI4gFOJR2gfmcxohb9UBYyXrer9n/jYPw
         JSw8XrB6qagkd7rmWy227sZHSSmC0RxZ+Ob9x5tS+joezz6RUXmLAtKsby5Z+9h/xDqx
         oCj9W8sJ/MJXJzOgCF3TTL2Sz+NCONSjC/GIaAzQ+E9jbS4lGwq4wBPcmdj5GOlsoTEM
         pep4M+y9md6Rt3hCL8TZlxErq+6SXN1pH5vqpNN9o3lzxCl56nobmBSnJ0mZjdzsf+M2
         AI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585054; x=1692189854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKocKVkqUz9oK7Yr55YQegYi48PRT/ogXdoEf9SUJ3I=;
        b=kgKf9z5faazOK9Zo6gmjhfCuVoiox2MhD8gQTLaMubBqxrVUMLL1/rce/IPppKDMCW
         Ihorq2fRo5Uw6VOA4peO+MXStszN4WwrX0RIpgoqvFfr2xsokLdnhQ/Q8CnOY0jGlUbz
         GUMkjV06TH4gPePgi2sMpI2e2xlIs3+TbUGPdYhBv9KJrxXVUHM+An5QcGf0bddCUfYA
         PcCnanII43HcY6HTyEjOOp2phNrF17K1wP2zK6M/SRHCyD7GihQ3vi61BdXIFMMiuAhq
         m7Ly5YuxlR8gmBoj8zucd/8ixfVwgLvdF2X9L/UccPiqpWdd7RBKiV1uVSD11ZBpXjy7
         w/yQ==
X-Gm-Message-State: AOJu0YweSVpzWnPD1nzN4fEoKzXg6LyGL/wpr319sbg9unP9f/B4/CIp
	/BPRwLoQq7Izqpb5U/g5NQ8=
X-Google-Smtp-Source: AGHT+IH5YNNN7hvWKWb8PKipUS47VKog2qFKobn/bXrBVp3ST+rpAmkRHk1uegEHqCkd8nDgOf968Q==
X-Received: by 2002:a5d:62c7:0:b0:317:57ec:4c3d with SMTP id o7-20020a5d62c7000000b0031757ec4c3dmr1744783wrv.0.1691585054012;
        Wed, 09 Aug 2023 05:44:14 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:13 -0700 (PDT)
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
	jolsa@kernel.org
Subject: [PATCH bpf-next 02/10] selftests/xsk: add timeout for Tx thread
Date: Wed,  9 Aug 2023 14:43:35 +0200
Message-Id: <20230809124343.12957-3-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124343.12957-1-magnus.karlsson@gmail.com>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
2.34.1


