Return-Path: <bpf+bounces-62291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B399AAF7715
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C60167DC4
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F92E9EDA;
	Thu,  3 Jul 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUWHZ1SK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7142E8E0B;
	Thu,  3 Jul 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552250; cv=none; b=RFlCkg8pApvOCXomOlGoBqHYB6MJzxEOKg5qQFQtlBkD4ctBO8IP1UIOUclPvC1HBCW0bEOLQJ1ImcV/EVsUX4sP8erVr/I/yAfXR+Fql8AbA8KrTSZS8OFWcnvzx5M33MWxXmjpJIXpTIBOJuRj+JazDOVBCYrNxAoV0FW6bG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552250; c=relaxed/simple;
	bh=r+D/dl/k/UTq/AIOuM/9Y3jD7sTZ4+BC+L1TGUByhD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c49SRWwVK7Um7lhEDmopGf9KceTYPafA6HW4qgiSXaw1NnL7DxBtEDPbW3l6jpaGslUO5jVmibD4wIRb/9nPo30ud2cJgYP8xJ3i6+JdAWFsgtZM4+TpwjVS3cY0sFGxW+bR2qVFNQIsOpbyH2Ho/Jr+/cwqI/+YlMdH2BzcWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUWHZ1SK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747e41d5469so6299837b3a.3;
        Thu, 03 Jul 2025 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751552248; x=1752157048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW+XZo4iC+tV8YHIg8uTa/P2x4K5W/XO4BwZmsp7CVU=;
        b=JUWHZ1SKg6g83HXCYXwY3CkUzlC+S9ceyL16t3BXhfQCJJoQNv1XN36SeAqku5fWnU
         OWN2jWOUGEOiu0YOLL1JvRjSqMhIse6EpPsP8EWytoUTNHpGNHKQrjyDZyFt2EwXmMjN
         uNuRpSXXTTz5py1OCgXCQHOUugTchLqkgtFBBuXy0naTpm/XveL7hz+fpZlG/hj8cmXR
         LRp2xLlAViPuzgVBQO3sVcCSNo4tsboub9fa++CSrEV/Tto1Sw7jFD1djAyCmFAWaS8x
         xvpWewHkonrZ6WhW8zOBGghe5G8L3Dpjq4dxgD/KP6lHZ6r2I5fa0bABMdQFYuSJ5En1
         0E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552248; x=1752157048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW+XZo4iC+tV8YHIg8uTa/P2x4K5W/XO4BwZmsp7CVU=;
        b=m16zJx3fWE3l8ZH2W/qkEnHp9tIB/5nfJ0oA99jJoXhSL4BywIr7YODDLF6HYTZGu+
         pq3EmoeVJNzh8NOlRGDh4PmDU0A6+fXUBLlKHMzwB78qIEKuxOy9L8AjfeLYj1jjspSo
         sa+RfmJmuiO8q1my77Nv9L+gCI6dqaFnj1qUW7OdmATgankyUGS+v+yJxMmD9LY8j4q0
         Fr7XrPylyHFiQF5iFEzlOXC4aKi9F0xLRB5Ln2O9tB6lLal/HbGW7YxkxtWcCijf3dEr
         N5exye5BO/znI5PgwuQc65V6UqujbroDbJA/h/nKnNzUIzGlJDQz/PmV/KZB7VVyMIE2
         /Nfg==
X-Forwarded-Encrypted: i=1; AJvYcCVR10upnSX+KWrF5kmaFbMQKzY0SoTqgwTF5ooogpBZN5wOELFXerwKW0SgMpC/LGzQs5osHFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhA6gtVQOzqpG/KGAxeQD4J/+s/Sewbpq5e3i5aakKNWJ6FIZ
	52qyftRGZlJwvLW4mId6RMAyaockAyjCjguW9O+F+U+EvbVH8loBB8nCM09+w5azc8k=
X-Gm-Gg: ASbGncvjeYtmT5B8V4qgxn5YpJxZ8QdpamrRiMAkdZrIHVOk2LJnCie2+VejlNMQGz4
	y/P1X/4Ugs4yjS4IFMAooyFn0E7l132owfVgAbO8ftgrOUB6ycSfg457YEz2TgML5ejJhyzHdbn
	sdkjrhHPm8JzKiOLaxrNdoEPPEWx286NDaX4DCZseqslsp8QdTC4ocqLkKopWT/ezon+PKDEz1K
	sZELi4SkYmv9A6fr7pdJtq28jHMvnolR+ArxS3Wc/8glIYkv0Q2RzmjAUennaDNZcbGuABuNEMg
	9uKIkEL/H+xo2m2H6tVNEsLVdgnPcKvUVRuhrNNAausUFrwWv6ge5CQKDxkjipta+qo2mkNPmF5
	PwXD5YBCzATTkRhjfUXjVWg==
X-Google-Smtp-Source: AGHT+IFj2C+YaYW/pNHy3MMqQWVNtNjVNwHAjvHoqnzHPYy1GUZ8tJ2qkqvfYUeicEDMMaHG9RRL1g==
X-Received: by 2002:a05:6a20:7344:b0:21a:da01:e0cf with SMTP id adf61e73a8af0-222d7e8294cmr12109325637.22.1751552248408;
        Thu, 03 Jul 2025 07:17:28 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.26.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da818sm13800150a12.61.2025.07.03.07.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:17:28 -0700 (PDT)
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
Subject: [PATCH net-next v6 2/2] selftests/bpf: add a new test to check the consumer update case
Date: Thu,  3 Jul 2025 22:17:12 +0800
Message-Id: <20250703141712.33190-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250703141712.33190-1-kerneljasonxing@gmail.com>
References: <20250703141712.33190-1-kerneljasonxing@gmail.com>
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
v6
Link: https://lore.kernel.org/all/20250702112815.50746-1-kerneljasonxing@gmail.com/
1. filter out and skip TEST_MODE_ZC test.

v5
Link: https://lore.kernel.org/all/20250627085745.53173-1-kerneljasonxing@gmail.com/
1. use the initial approach to add a new testcase
2. add a new flag 'check_consumer' to see if the check is needed
---
 tools/testing/selftests/bpf/xskxceiver.c | 56 +++++++++++++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h |  1 +
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 0ced4026ee44..a29de0713f19 100644
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
@@ -2613,6 +2649,23 @@ static int testapp_adjust_tail_grow_mb(struct test_spec *test)
 				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
 }
 
+static int testapp_tx_queue_consumer(struct test_spec *test)
+{
+	int nr_packets;
+
+	if (test->mode == TEST_MODE_ZC) {
+		ksft_test_result_skip("Can not run TX_QUEUE_CONSUMER test for ZC mode\n");
+		return TEST_SKIP;
+	}
+
+	nr_packets = MAX_TX_BUDGET_DEFAULT + 1;
+	pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
+	test->ifobj_tx->xsk->batch_size = nr_packets;
+	test->ifobj_tx->xsk->check_consumer = true;
+
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2723,6 +2776,7 @@ static const struct test_spec tests[] = {
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


