Return-Path: <bpf+bounces-62103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9AAF13D9
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF414E3CF7
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E82528EF;
	Wed,  2 Jul 2025 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msxUOoWv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DB264A97;
	Wed,  2 Jul 2025 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455714; cv=none; b=VB4xPpn9Pr60ik/djGFdJddLJ+CTlkloe9RoBCgd81HS9iA+plEu2s7gDgRleCbLRdwrg+G4J0+r4+suHJzPrEuEzft2VwFY03Ry10k9MjfsAQzgoUuqxH4+24QmG/wSIl0wh2F6BIhmP9pMSvTWEOv048qUJWJvkFbfXHWOn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455714; c=relaxed/simple;
	bh=kWH382/+ZoJmAT1WqFl/tz5Qqbz2wECQGVuMdCwSWS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYm19FzDg3svhaOEPBEukmTBVQTsdHUh0EP7PLdfVj3VIXC6RdVRBq52paqIAvwQhO+krncSlSQNtzp95G5yw4+zQxik+57QdA1kFT7uSscS6Qivc4gT34Rdgd/j97W8HKAyMknVok9eEuUDrEWJUHBzWbh6XhTavEC0ib18egE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msxUOoWv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748e378ba4fso8930732b3a.1;
        Wed, 02 Jul 2025 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751455712; x=1752060512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baQmUrBFVMs6vWAyIr7eEc04gvdQTh7J0L0biqHw2ik=;
        b=msxUOoWv3Ik2n5poU2CcD08RLGJpCEHMvI5OZXc/Z6gOgQibTAXVJ5fI94ENCE+Nj7
         VSTIcXKLoBN1dK+AeGVpnONUDHYJugsYqk7Rzg7r8nHPNy73dZGsu5CZPZ458/Kr2Hae
         tAVSC6D2R4iNmxRf72+vmfHO5hiIuQp0lFpwKC4UKLJfiCg2XWfXjqCS4Odc+DekDpwa
         5hEHf848Li9ungi8aJFesRuYpj7T0r2KKk+PYncEUsYySEZt4nW4RXYqLr8SeJhSCB0p
         ekxVjOhLZjWD/TrMueeaAsyHex1XrjZJqPiIaoqiqKv4x+OJX/Xmu9sWJz+A4E5wB+7d
         gqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455712; x=1752060512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baQmUrBFVMs6vWAyIr7eEc04gvdQTh7J0L0biqHw2ik=;
        b=VuCbPp0uVq7NFJS8csS9rpeQU3S2pEN+L7ofD0Dr3KHLi3xOJHyzftrCeUsneaNpZw
         HnVZNyX1fpgoRPDB+2ev6Ed/+3omPRG/kyelyX6yMKtBNlFzHE2PIsGY0K7+rXWNFt9K
         +CWTep3zfyzJa1m5CABCMfS9bJpYex5rnjb722tDR/juxJoBkEMz9DKJ0TxZo4TVC0iG
         eWd9pXUbQDS+1mgtFAhdCZNGrcXyNvx+g0CyARtCHGFNdisCyc9ZQu1yrI1tqhJ7+Gqi
         LiPZ1IoQqzLE/kij9w0U/NOLKkrc7QvPiQ5kR6RazT9+g5Z23Jeqi4xLPCJtp4nDxb2L
         bKcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlmGMQtObSw8g4ontIFwz4e0UpVUXLj+AfwlQi3MpNiyqLFpn0csExNoeTNL/YJhjaCorcNHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbL3/os2dE6/MzNnmMp/QW8fa6j1dwjMQg1A7IYCFARWeK6W+h
	7yplToJr/3fyDuU8VIr0MwWwkgETcaZiWIYs72+7Hx/gaU1P7BLEZb2F
X-Gm-Gg: ASbGncsmJp1guFrGKTWDsixINKX6pGk4OPlZjSoQ1tifK3utE45B8UQ7B06W3qCxQyU
	n+PxYKDzUBmkZlPuxOBMh4ZBB0JSRgAVM3rCQmDfyty4RCpCFm0n7dG+2IOSjuOOuHQK8GrNxBr
	7LBSoolasZeBaDAeTqsn7S7U5zGqNajUE/VoeALwQ2SkTHd+iDRWE692jsz07fWJD0x3XCfVvH9
	ibE9Jtn+syxH0qUjYALkvx8DMLi9HLf/bgWCxBfDo9gQpjTnGB91+vBK0upSyMFtc68p4jJJeON
	p7zKJq958ut506bb5OPc/wG4nl9JXAIIhqn5Z97b5VwTXssKFh7MyuBeOv69IBIfnkJltZo+tpC
	W82RQ3IoO1s+xwqIjKEKl6QScf40PTmO5lQ==
X-Google-Smtp-Source: AGHT+IEpeubqCuQRfa+AMQQUbfxg86xPOQtYSrQ7zkHeROnXnPocgF7rPL4h1zSVDxHFbuz23smKVA==
X-Received: by 2002:a05:6a20:3d07:b0:220:b0dc:24f2 with SMTP id adf61e73a8af0-222d7eee222mr4941385637.34.1751455712251;
        Wed, 02 Jul 2025 04:28:32 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57f7e6bsm14437529b3a.179.2025.07.02.04.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:28:31 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 2/2] selftests/bpf: add a new test to check the consumer update case
Date: Wed,  2 Jul 2025 19:28:15 +0800
Message-Id: <20250702112815.50746-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250702112815.50746-1-kerneljasonxing@gmail.com>
References: <20250702112815.50746-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The subtest sends 33 packets at one time on purpose to see if xsk
exitting __xsk_generic_xmit() updates the global consumer of tx queue
when reaching the max loop (max_tx_budget, 32 by default). The number 33
can avoid xskq_cons_peek_desc() updates the consumer when it's about to
quit sending, to accurately check if the issue that the first patch
resolves remains. The new case will not check this issue in zero copy
mode.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v5
Link: https://lore.kernel.org/all/20250627085745.53173-1-kerneljasonxing@gmail.com/
1. use the initial approach to add a new testcase
2. add a new flag 'check_consumer' to see if the check is needed
---
 tools/testing/selftests/bpf/xskxceiver.c | 51 +++++++++++++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h |  1 +
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 0ced4026ee44..ed12a55ecf2a 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -109,6 +109,8 @@
 
 #include <network_helpers.h>
 
+#define MAX_TX_BUDGET_DEFAULT 32
+
 static bool opt_verbose;
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
@@ -1091,11 +1093,45 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
 	return true;
 }
 
+static u32 load_value(u32 *counter)
+{
+	return __atomic_load_n(counter, __ATOMIC_ACQUIRE);
+}
+
+static bool kick_tx_with_check(struct xsk_socket_info *xsk, int *ret)
+{
+	u32 max_budget = MAX_TX_BUDGET_DEFAULT;
+	u32 cons, ready_to_send;
+	int delta;
+
+	cons = load_value(xsk->tx.consumer);
+	ready_to_send = load_value(xsk->tx.producer) - cons;
+	*ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
+
+	delta = load_value(xsk->tx.consumer) - cons;
+	/* By default, xsk should consume exact @max_budget descs at one
+	 * send in this case where hitting the max budget limit in while
+	 * loop is triggered in __xsk_generic_xmit(). Please make sure that
+	 * the number of descs to be sent is larger than @max_budget, or
+	 * else the tx.consumer will be updated in xskq_cons_peek_desc()
+	 * in time which hides the issue we try to verify.
+	 */
+	if (ready_to_send > max_budget && delta != max_budget)
+		return false;
+
+	return true;
+}
+
 static int kick_tx(struct xsk_socket_info *xsk)
 {
 	int ret;
 
-	ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
+	if (xsk->check_consumer) {
+		if (!kick_tx_with_check(xsk, &ret))
+			return TEST_FAILURE;
+	} else {
+		ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
+	}
 	if (ret >= 0)
 		return TEST_PASS;
 	if (errno == ENOBUFS || errno == EAGAIN || errno == EBUSY || errno == ENETDOWN) {
@@ -2613,6 +2649,18 @@ static int testapp_adjust_tail_grow_mb(struct test_spec *test)
 				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
 }
 
+static int testapp_tx_queue_consumer(struct test_spec *test)
+{
+	int nr_packets = MAX_TX_BUDGET_DEFAULT + 1;
+
+	pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
+	test->ifobj_tx->xsk->batch_size = nr_packets;
+	if (!(test->mode & TEST_MODE_ZC))
+		test->ifobj_tx->xsk->check_consumer = true;
+
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2723,6 +2771,7 @@ static const struct test_spec tests[] = {
 	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
 	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
 	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
+	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
 	};
 
 static void print_tests(void)
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 67fc44b2813b..4df3a5d329ac 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -95,6 +95,7 @@ struct xsk_socket_info {
 	u32 batch_size;
 	u8 dst_mac[ETH_ALEN];
 	u8 src_mac[ETH_ALEN];
+	bool check_consumer;
 };
 
 struct pkt {
-- 
2.41.3


