Return-Path: <bpf+bounces-61507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 238C3AE7EC0
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 12:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF09D1708C9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B62BF00E;
	Wed, 25 Jun 2025 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6vFSnzJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798CB2BDC38;
	Wed, 25 Jun 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846241; cv=none; b=H5IkNc9yfs7F9UBc40O6pjEoupj5Rox7orWBlQdeazuLTUPREx6QJsDZBSKQSZGIu9xBEFMirLQsmTp5lMK9CwDBVGkJSd+1K0BZ/jztIBTwBKXHsq1k6/tpjyLyTka7XlwUF1KzPHRNqZ+raPbm65aUU2ptg5Z5L7/rASjck0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846241; c=relaxed/simple;
	bh=UPIyeW9W3kqd6AdVIfdrUFGW9GSHoK6qYZPW1Bg4fWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFQevkXTQgEtwUx3BbFOOjENBem6v5rYt++J4D++9RRkdTl3aViJm+QyYLvvXY0W87i43eUGdG2IHbfcVSTdcd2PyViAfeImOBvOC4KJ/cMb3wv33iypgw7PcXVH5fRWVSawhs1nq9fWCZ1fgQoMXyZ7kXSWf7+ob4GAiB9Nx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6vFSnzJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso3614750a91.1;
        Wed, 25 Jun 2025 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750846239; x=1751451039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AGCyX14dEKx9XCAcpASiiI7DxVWDRzZMzeJaYAUn4M=;
        b=I6vFSnzJ6K5h2ErIEZMq7l8+oWjT6TZ5YZYQrvMY1Mk4htcrXiWLmwT68VcXeDlGCP
         3TneJ0jYZgcyY1FVRP+0Rd7zRB5rxfy/N1hMGnSFaeY1wupIbeTiCe5YXqnaRMoXoM/J
         rryEQ+n+DYfkToUbpUJEXPYPE719oFvqxP43PyJhJj05RdxoCwv4tGp7efAgkP4axUKg
         vy+797xTsRGEB6GQkb3z4w4y63N+cPqT/mHv4KK9q+Oz6FEiA0y29QrGYRimSitlKOUT
         /kfiaUcBKeCFmzTkvNCUNEeDzLHwRSZQ/EYO00iXu8WkRGXpKCscYeVbkp5s45X8zDKP
         5btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846239; x=1751451039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AGCyX14dEKx9XCAcpASiiI7DxVWDRzZMzeJaYAUn4M=;
        b=ixM5jZIVBj0OQithTX0JI6lAQZYuIAPzXaZlb6zQPo92U0DVkJigyDH/xxguDT3Cgq
         hVSKOlljAULBGV/RiWLJVG7YIPaQDBQXTxG/l17ItI1SX3IUOQe71ee7Tu52uNj66HrA
         wCnTrP8bXmhgrCdqhfUC1y7D7sKk/1HlWUOHrO+HfWB2V/DCiSu5wvlR2Or9PvW6TT1H
         SYMgg9yFO2jU1anrqr6ThZ2ypzp046VvRjruaRJmXNBCodrIUXvQyE6VaQ2w9Zg6nXya
         NSnrG7NZZpIUbEX7z/5vGFR+GGwT4HPFtPa++iwMxf3hXo8QjkBPwmIdLeWSs5eMzyjz
         IySg==
X-Forwarded-Encrypted: i=1; AJvYcCXLd5Rb7RMHce4C9kDrz1Uh94OzJxq6UR6GLdUSL3iPi0SE3jwI080WeOoILEptH+S0KVwnAlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrh6Yq5WiX7lMuBtHFRK1c/APeHCkdjo7rj0H2wLc4PGdQzLzF
	H7G2shmUsm2R8UZSsCZThIaWHLZdMFVeJHiq1gILLri4BFZXAKDjaSNg
X-Gm-Gg: ASbGncsD+W8krQmVSkvJbAXsaHQPQRyTcGgQSdiNSfLVQQpQJ4k2fSwk5BPDXay3iZz
	sWVymqWN3+6o/CkoJYGrHj3Q5N1hq++XcnqeV5DWlrkcD7NQXyXvjFtsLIxjQbAdI0OR3Eb4GVG
	WdTpMWEMxxwiXPCA/0KuRbpfpGGTunyxncET+u054ngBf+eHe4Ij2IF+S6Yv1iMtwo0osvbGIkX
	+59pr/tv7q+yg4kRJDtOCkMhET9gk1NYib3HJZvlTJJvH7fGxbUjzM9W15/8h5hZ+KA0l8FS/vD
	nHbCkv8qHAjq77ydNg+dsWI4fHIjZngDSk0wlAgeGx8GFR4J1fisvwGF+i0hB1DO2qnZd1TIZt1
	pfXoZQDLFFKTLiZ0hGV+kHAJsn9CkZZGODw==
X-Google-Smtp-Source: AGHT+IEO2URLiZhS8bYplN02TdS3MALXZtd23O3nEBxnjrTt+qbG0lWZZUEDHqCbaGnbVZkiy6P/fg==
X-Received: by 2002:a17:90b:55c4:b0:313:23ed:6ff with SMTP id 98e67ed59e1d1-315f25edccamr3164926a91.1.1750846238651;
        Wed, 25 Jun 2025 03:10:38 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5437a0bsm1328838a91.35.2025.06.25.03.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:10:38 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/2] selftests/bpf: check if the global consumer of tx queue updates after send call
Date: Wed, 25 Jun 2025 18:10:14 +0800
Message-Id: <20250625101014.45066-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250625101014.45066-1-kerneljasonxing@gmail.com>
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
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
can avoid xskq_cons_peek_desc() updates the consumer, to accurately
check if the issue that the first patch resolves remains.

Speaking of the selftest implementation, it's not possible to use the
normal validation_func to check if the issue happens because the whole
send packets logic will call the sendto multiple times such that we're
unable to detect in time.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 30 ++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 0ced4026ee44..f7aa83706bc7 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -109,6 +109,8 @@
 
 #include <network_helpers.h>
 
+#define MAX_TX_BUDGET_DEFAULT 32
+
 static bool opt_verbose;
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
@@ -1323,7 +1325,8 @@ static int receive_pkts(struct test_spec *test)
 	return TEST_PASS;
 }
 
-static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
+static int __send_pkts(struct test_spec *test, struct ifobject *ifobject,
+		       struct xsk_socket_info *xsk, bool timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
@@ -1437,9 +1440,21 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 	}
 
 	if (!timeout) {
+		int prev_tx_consumer;
+
+		if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NAME_SIZE))
+			prev_tx_consumer = *xsk->tx.consumer;
+
 		if (complete_pkts(xsk, i))
 			return TEST_FAILURE;
 
+		if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NAME_SIZE)) {
+			int delta = *xsk->tx.consumer - prev_tx_consumer;
+
+			if (delta != MAX_TX_BUDGET_DEFAULT)
+				return TEST_FAILURE;
+		}
+
 		usleep(10);
 		return TEST_PASS;
 	}
@@ -1492,7 +1507,7 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 				__set_bit(i, bitmap);
 				continue;
 			}
-			ret = __send_pkts(ifobject, &ifobject->xsk_arr[i], timeout);
+			ret = __send_pkts(test, ifobject, &ifobject->xsk_arr[i], timeout);
 			if (ret == TEST_CONTINUE && !test->fail)
 				continue;
 
@@ -2613,6 +2628,16 @@ static int testapp_adjust_tail_grow_mb(struct test_spec *test)
 				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
 }
 
+static int testapp_tx_queue_consumer(struct test_spec *test)
+{
+	int nr_packets = MAX_TX_BUDGET_DEFAULT + 1;
+
+	pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
+	test->ifobj_tx->xsk->batch_size = nr_packets;
+
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2723,6 +2748,7 @@ static const struct test_spec tests[] = {
 	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
 	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
 	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
+	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
 	};
 
 static void print_tests(void)
-- 
2.41.3


