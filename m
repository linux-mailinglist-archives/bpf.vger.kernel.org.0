Return-Path: <bpf+bounces-8465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561C786F0E
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D551C2037D
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F138C11CB0;
	Thu, 24 Aug 2023 12:29:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD4111B2;
	Thu, 24 Aug 2023 12:29:40 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7C171A;
	Thu, 24 Aug 2023 05:29:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fef3c3277fso6884095e9.1;
        Thu, 24 Aug 2023 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880177; x=1693484977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKocKVkqUz9oK7Yr55YQegYi48PRT/ogXdoEf9SUJ3I=;
        b=RgevClVxwkFpH6h5OoO49A1seLVngXkdLP29ThKaJDDKcj17iKwsQyqTg4NUbwQQBR
         MN7qRQIUxKhz2KZkBw5FJsQCV0c3/q3sM56XC/w/UZOvIm1FmhMrdUr56j8SHobHBphK
         QEAzrIeltg7F6dE/y13pf9RzgDTZhpZycWvFhxXTvE/9UmswMJB69gWReCGx9BPsAkv5
         B1q+0DAUm/GsW9+JCuTjEsYPgieswpI1GA5HLuwiR3pfCDIYwYRKw7AZ2uC7IK/ekXbi
         WhJT4/dMnPp9MQbQNi8Rk70yQmVTDOdMBXw09KfrDBG5fPTAt6vLGlvQZRkAdoOPHY1V
         vBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880177; x=1693484977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKocKVkqUz9oK7Yr55YQegYi48PRT/ogXdoEf9SUJ3I=;
        b=UuE3O9oS53AE5c4GzZU+YTL/FHo1puxxD82eQ05nXlmCkCHmt2s/rDv7gplP53KCow
         EMz5NNLRWLF3f/+ZKQ+g1hZIfxqZQ2P525x+DOHmYvbRq5hfXzHtvhfzZvJ7f3Du7ohq
         ubA5lM9eK30/3TmP5cBpxQkJ4khOGdpPfdAJUFQiEbU9Wph4WelEWds2J0gNp6R8NUrk
         yz/snNuX9LdvDTsUnycVD7Rhyel050X2FmgtBPt1hb16RFnSTImnBcrRQ/JznlOmflv0
         jW/ogkZWRFhdwIoheF1LRVEja/16o7C8WXx58Qq9RQRZ8t/ogIMPjeEU6QuZLzYAUx/c
         fllQ==
X-Gm-Message-State: AOJu0YxkVBzLGwXq+hdthjdICaDVHDh41rIt7Nsm/8S4mj4cM6jl/c5l
	VDpBaHdZZvn/GrIF0mPTGiY=
X-Google-Smtp-Source: AGHT+IE/uFdZJLd3X08AYF5XS554ubNq/QFLcVZ+i6eSdDgEBV6QOK24UEm3vekR4BxpsUylghYPnQ==
X-Received: by 2002:a05:600c:4511:b0:401:b0f8:c26a with SMTP id t17-20020a05600c451100b00401b0f8c26amr683481wmo.4.1692880176462;
        Thu, 24 Aug 2023 05:29:36 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 02/11] selftests/xsk: add timeout for Tx thread
Date: Thu, 24 Aug 2023 14:28:44 +0200
Message-Id: <20230824122853.3494-3-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824122853.3494-1-magnus.karlsson@gmail.com>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
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


