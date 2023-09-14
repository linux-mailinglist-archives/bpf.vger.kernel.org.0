Return-Path: <bpf+bounces-9985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1E879FF05
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049961F227E6
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A262615EA3;
	Thu, 14 Sep 2023 08:49:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7C15E86;
	Thu, 14 Sep 2023 08:49:31 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5691;
	Thu, 14 Sep 2023 01:49:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-402ba03c754so2197275e9.0;
        Thu, 14 Sep 2023 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681369; x=1695286169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK3DdqhE57yLQUwMe7Dn0zw5j7ZU8/ZFz0lGjuSV7SM=;
        b=X8f5SHvhSzI7Bj08FngrLYDIr1PIiVjtn+ZouimLLzXkhtbZWVyV44CquUtAojjJUS
         le+9Daw9t0F25JZZWirYW6yN5uarU5BSfBTfLavunsx46dTovPE4gpQX18nTQMSzEyUu
         +YFfpaslLdxXrLiYPCebtGhB4mrGVjV0qQPgYHMLzWG0tXdWJ05V6B4aJ7026bm3E2uA
         3P1bQk6nCJAghI3VvvCkIw6Z5ldd4CAkwXGCzshLkThvuVG/5gnp5ZYLRhCIZyYInEGq
         bI8eVvdgvo2KPEsJonis7CKRgR/uHvlSiklLC1eIyBIoaa27dGtQlfpwev3XOd3RqCyD
         /STw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681369; x=1695286169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KK3DdqhE57yLQUwMe7Dn0zw5j7ZU8/ZFz0lGjuSV7SM=;
        b=bhWv0KAxbacdf5F2adTKp1u3JMbTtT1LdTqQ8N+SSmwU6U7/734GkT/LY5rcwrNhIX
         54FmUM6bi7YP6072a9Kn5ROJLh+rw7YAIcQUjtK8vIR6lAVfyvTRAduMX4v8ngro+XqP
         S+LbvbNbeKW/uBE1xbvhJ/g6VhrThTLZRtQWjnUapibagZ7R3B0/4BR08hc4Aq8uS8Hj
         jTFV7UkBh+X0Vervnmmv3uh5OlTco6tJoRk6DnEKJHRAU2KZ3AOelmcAuRws+iNviPzD
         VXGPv8xp5HzUPgssfRKrw3umrx7mvTdILqYAVwA+Ho3Podu3QnWu23TNXwhubTSSGQzx
         J6oA==
X-Gm-Message-State: AOJu0Yz7PjBT4QAKNfbQ9Z+NMA0GKi4HBTKNKEqlBVIs+Cnqt2cZDe3o
	Oga7iDh37l9ANyHZcbZ2WpI=
X-Google-Smtp-Source: AGHT+IEws6QsBgU4AOTgvsNocPDgXHa+OE3Va+cdMpQVGpuIvL8eZfltQSBd8CrKjEIjYMpYPZSMrg==
X-Received: by 2002:a05:600c:792:b0:401:db82:3eda with SMTP id z18-20020a05600c079200b00401db823edamr4040598wmo.1.1694681368624;
        Thu, 14 Sep 2023 01:49:28 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 02/10] selftests/xsk: add timeout for Tx thread
Date: Thu, 14 Sep 2023 10:48:49 +0200
Message-ID: <20230914084900.492-3-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914084900.492-1-magnus.karlsson@gmail.com>
References: <20230914084900.492-1-magnus.karlsson@gmail.com>
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


