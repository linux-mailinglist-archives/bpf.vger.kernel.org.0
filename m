Return-Path: <bpf+bounces-61744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98A2AEB1D2
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 10:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB53189A611
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EAB27F005;
	Fri, 27 Jun 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6YyhJWS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436E26B2A9;
	Fri, 27 Jun 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014685; cv=none; b=iye6vIIYAbb4+Nr9qKBI37Y95BX+VD1I05Klqsx1zYDpgpk8kjUhTn6M9MIkbXG3db77dU0GUFvwKYDMH8CrM9aEcVrrmqeOymy3F7yhnkH1uiQ63FfojDdGTdDp0m7K9T/T3pV57W+X3tQx3omHsvCTIv4RhGKSBHC/3hdpd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014685; c=relaxed/simple;
	bh=GwR5h5hZV9IJbIRzMS8FCaMSDeX38+bD1G0UmDDaZSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QxHz4GTzWh3NNsOclaPXfyctLLgB5RrgulViPEAvqQN1g0aD4Xn+Yg3ilthRb43VXIfjnOE8OLXPxrDVDxXepCbLgZU7MLYMciKvEd1VlIqDPqvzDO6qfWi8WTEmxbbd7tD+RwrrNMqnBztXjD2Tpc5ev5VI4gQFCXMYVA8G1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6YyhJWS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-749248d06faso1831883b3a.2;
        Fri, 27 Jun 2025 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751014683; x=1751619483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FDuK74Xm3kedCV1ItfdO1xMrIIuqhzHB1IVHE1yK0Q=;
        b=O6YyhJWSd2CY5yqQRZzavcMOfQDKxbocawVQ5lZTpPvEZmXmL9Q+wg2VzI8V9qxjqd
         8Bso7YLS48q27okYZggDS6jiNvzIfsQImwULWe78/JhHD/3M5dJNo9rwvo889IKPbDzv
         VcxDtaWpAqQcfJxGqBMSAVoFi7pgEMruKARuez3uRlfnNJlidi5z7kgFnnvuN/NQL4XG
         tlRClpupnFvTS5s1SoFpHtxPd4WDEoILNH9pAzf1FjNVPISDVy4dLyRAsihMqBrPEgrE
         HhRc/kP1foaabK+fL+4QHMLXQo5Z3sZQ3jnxCiP8jK/5RoU5IooQ/Q5SWAgA0tL7cMyA
         ikPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751014683; x=1751619483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FDuK74Xm3kedCV1ItfdO1xMrIIuqhzHB1IVHE1yK0Q=;
        b=mSER8PtLYIzg3aRWWnCa1LTMJkL1VBgnUaX0lk3SJytbdRrMy9HcMjCEqf8yrsQMOt
         6tUQ9XnbzXdpeDJjBrrnXYOWErU6q+RNUJWYh2hwdFYs6qdtwMv2LvLV27slXW7pBSYq
         NaKHA8g1oBjLmN2FKm0VvR9NF50abrEToX1Jmiu0BXNdwEKRMKYVwtkVds+5UsOJQ4tQ
         oAQgFxku3o+aDSMfOCuRjWQbIyE35YEtzByDvACqTPeQrUjhSGgmV/hht8SQsLnLrHHG
         v8pznF0NyF/uGFAcuj9Vg7PhsHH5K4/sDQeBIcQpGVM23HnAF8ztWsPH+g4eCVgz1ax5
         hLYg==
X-Forwarded-Encrypted: i=1; AJvYcCUUhaN2b477X1895jZve4dk9plBg2Hbi5sqBmE6U+vQ+9rmpeFeq4snSTHqXNhbuW/wACM4oPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxksZWco/Z4sb282IZ3GSsK0S3sA44RPHNJh4uyqv+rceRy8RK+
	c1mcaWs4wDow0RDkzex/Zk4Qj5/jpEk+p8riUt5vWgG4dA6bzex1VDHu
X-Gm-Gg: ASbGnctFgdTeoY6vckblgyG4g2/z9Q9GFit7ibo6MvztZ04s6mvlbA/EJmkDZgL9QiE
	OChGNfIIgh4kl1Ka+lvFW564YMt9TY++XpqCKShv1FRehqt8NxSyEmNS9bmbz2jzWl8ERMIyMLC
	Sl8OfEkNW2dViw9K/ZXUTT1GRUunW6uwogmjtEt0AiJGlx/vecciICeyAHCis5s0T8DNX4iM/g3
	IlJaN9SQNDRUbgpJukR8+hEw7OaGM/XIQOjR4l/TC0nzN/oRPTaJJ0DxIyTOHXWKDYBGxXAMkGC
	pRemoD+e3LaDX8PLhj2BUCGhPn/mnPh32ekXtA6YMmpPeAnmwIY2jAoopVfR5vxlQ2WgowqBdFW
	Jjnk8ZFtKltVl6Fv0NwXvU4QHjHwp5KS9hQ==
X-Google-Smtp-Source: AGHT+IFPiODx938sy2q0m20JlJolIWdDJTu7QWmuPxNihRrkvTzgYJ1vmQagb/Irc5ArIUa8o5yoKQ==
X-Received: by 2002:a05:6a21:6b0f:b0:21f:5361:d7f7 with SMTP id adf61e73a8af0-220a18343cdmr4066173637.31.1751014682946;
        Fri, 27 Jun 2025 01:58:02 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b3d9sm1728170b3a.2.2025.06.27.01.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:58:02 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/2] selftests/bpf: check if the global consumer updates in time
Date: Fri, 27 Jun 2025 16:57:45 +0800
Message-Id: <20250627085745.53173-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250627085745.53173-1-kerneljasonxing@gmail.com>
References: <20250627085745.53173-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch only checks non-zc mode and non STAT_TX_INVALID testcase. The
conditions are included in check_consumer().

The policy of testing the issue is to recognize the max budget case where
the number of descs in the tx queue is larger than the default max budget,
namely, 32, to make sure that 1) the max_batch error is triggered in
__xsk_generic_xmit(), 2) xskq_cons_peek_desc() doesn't have the chance
to update the global state of consumer at last. Hitting max budget case
is just one of premature exit cases but has the same result/action in
__xsk_generic_xmit().

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 60 +++++++++++++++++++-----
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 0ced4026ee44..694b0c0e1217 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -109,6 +109,8 @@
 
 #include <network_helpers.h>
 
+#define MAX_TX_BUDGET_DEFAULT 32
+
 static bool opt_verbose;
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
@@ -1091,11 +1093,34 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
 	return true;
 }
 
-static int kick_tx(struct xsk_socket_info *xsk)
+static u32 load_value(u32 *a)
 {
-	int ret;
+	return __atomic_load_n(a, __ATOMIC_ACQUIRE);
+}
+
+static int kick_tx_with_check(struct xsk_socket_info *xsk)
+{
+	int ret, cons_delta;
+	u32 prev_cons;
 
+	prev_cons = load_value(xsk->tx.consumer);
 	ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
+	cons_delta = load_value(xsk->tx.consumer) - prev_cons;
+	if (cons_delta != MAX_TX_BUDGET_DEFAULT)
+		return TEST_FAILURE;
+
+	return ret;
+}
+
+static int kick_tx(struct xsk_socket_info *xsk, bool check_cons)
+{
+	u32 ready_to_send = load_value(xsk->tx.producer) - load_value(xsk->tx.consumer);
+	int ret;
+
+	if (!check_cons || ready_to_send <= MAX_TX_BUDGET_DEFAULT)
+		ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
+	else
+		ret = kick_tx_with_check(xsk);
 	if (ret >= 0)
 		return TEST_PASS;
 	if (errno == ENOBUFS || errno == EAGAIN || errno == EBUSY || errno == ENETDOWN) {
@@ -1116,14 +1141,14 @@ static int kick_rx(struct xsk_socket_info *xsk)
 	return TEST_PASS;
 }
 
-static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
+static int complete_pkts(struct xsk_socket_info *xsk, int batch_size, bool check_cons)
 {
 	unsigned int rcvd;
 	u32 idx;
 	int ret;
 
 	if (xsk_ring_prod__needs_wakeup(&xsk->tx)) {
-		ret = kick_tx(xsk);
+		ret = kick_tx(xsk, check_cons);
 		if (ret)
 			return TEST_FAILURE;
 	}
@@ -1323,7 +1348,17 @@ static int receive_pkts(struct test_spec *test)
 	return TEST_PASS;
 }
 
-static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
+bool check_consumer(struct test_spec *test)
+{
+	if (test->mode & TEST_MODE_ZC ||
+	    !strncmp("STAT_TX_INVALID", test->name, MAX_TEST_NAME_SIZE))
+		return false;
+
+	return true;
+}
+
+static int __send_pkts(struct test_spec *test, struct ifobject *ifobject,
+		       struct xsk_socket_info *xsk, bool timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
@@ -1336,7 +1371,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 	/* pkts_in_flight might be negative if many invalid packets are sent */
 	if (pkts_in_flight >= (int)((umem_size(umem) - xsk->batch_size * buffer_len) /
 	    buffer_len)) {
-		ret = kick_tx(xsk);
+		ret = kick_tx(xsk, check_consumer(test));
 		if (ret)
 			return TEST_FAILURE;
 		return TEST_CONTINUE;
@@ -1365,7 +1400,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 			}
 		}
 
-		complete_pkts(xsk, xsk->batch_size);
+		complete_pkts(xsk, xsk->batch_size, check_consumer(test));
 	}
 
 	for (i = 0; i < xsk->batch_size; i++) {
@@ -1437,7 +1472,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 	}
 
 	if (!timeout) {
-		if (complete_pkts(xsk, i))
+		if (complete_pkts(xsk, i, check_consumer(test)))
 			return TEST_FAILURE;
 
 		usleep(10);
@@ -1447,7 +1482,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 	return TEST_CONTINUE;
 }
 
-static int wait_for_tx_completion(struct xsk_socket_info *xsk)
+static int wait_for_tx_completion(struct xsk_socket_info *xsk, bool check_cons)
 {
 	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
 	int ret;
@@ -1466,7 +1501,7 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 			return TEST_FAILURE;
 		}
 
-		complete_pkts(xsk, xsk->batch_size);
+		complete_pkts(xsk, xsk->batch_size, check_cons);
 	}
 
 	return TEST_PASS;
@@ -1492,7 +1527,7 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 				__set_bit(i, bitmap);
 				continue;
 			}
-			ret = __send_pkts(ifobject, &ifobject->xsk_arr[i], timeout);
+			ret = __send_pkts(test, ifobject, &ifobject->xsk_arr[i], timeout);
 			if (ret == TEST_CONTINUE && !test->fail)
 				continue;
 
@@ -1502,7 +1537,8 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 			if (ret == TEST_PASS && timeout)
 				return ret;
 
-			ret = wait_for_tx_completion(&ifobject->xsk_arr[i]);
+			ret = wait_for_tx_completion(&ifobject->xsk_arr[i],
+						     check_consumer(test));
 			if (ret)
 				return TEST_FAILURE;
 		}
-- 
2.41.3


