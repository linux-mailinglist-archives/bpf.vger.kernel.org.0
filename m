Return-Path: <bpf+bounces-9992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CBD79FF64
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998FD281D4F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09040224D9;
	Thu, 14 Sep 2023 08:49:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5785224CF;
	Thu, 14 Sep 2023 08:49:43 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED1491;
	Thu, 14 Sep 2023 01:49:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40471c054f9so1123795e9.0;
        Thu, 14 Sep 2023 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681381; x=1695286181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMo8Yi4fbOrRpYZGBTJ6oJJGAQpVSVllnRuyhvU3Ftw=;
        b=nyvzr1Bi5S9PkOdA9GSgHKW6PN6kTGCQWcClqsNdaYA842M3l6lJ+kZ2oErBC8I1z2
         X6CI6DFELGT2Ihpn9H7H+hlUQu4dX52cxcjKFupaDTO4PUEICLK91nME4aqGIFThB6Mc
         4Shh/BlyTph0TcK5ZG4+4djJSpQRVq/IO/8bTYD80oHoKE5yexH+qobXoqy+qmJUudWw
         o0uDYWKvE8NJ76HJjDOR39wJh+mMSaXp1ckjWHKcXqnt5SyQZRz1HNyadQb5zGqDD+wC
         SmIkzw2y478dI+3u+pqo6qXBSxxQRPErf7HGxMm5lXn3oXGQpHnwvDAkihTAFmOMtwW4
         Xjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681381; x=1695286181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMo8Yi4fbOrRpYZGBTJ6oJJGAQpVSVllnRuyhvU3Ftw=;
        b=H1xx9/HIWxApGLh9JV/DL47EluCPEYhUbn/j7lFCkpvjvrFHZpzl7BZqNFvkMts9Ho
         R71p8ZWU9WH87+cg4+hO6xkQWGs6qmpdvnE5k+woSheeASU8JdN/ECGHlKNNhNbg0YzJ
         QGsdm+EyGyNOHKvCgUtMv5WoF0qc6v3O8lB1WQXwlEtZ4Ttb1S3gst21DTg7J8IlYjCa
         1VhUoAUM6ax7SJzwylYOAI+I2sZQ+qdwWnjpD/uBb+36pjzSLFwI4Dg4L2pkGAvPlrEQ
         dXR2Uex+AUvG6mminY5YDOqSOaid0A70Sk7enlgkU7eqorIICG6K5zEC6ysX+2cw2g97
         WGkw==
X-Gm-Message-State: AOJu0YyWRLJsfU+SfgWaWxG9ffv8EXFDPXsmCIi04YcK5QfETCAfE95u
	dtJV7Qv9jOg9bjHZKhg7bb0=
X-Google-Smtp-Source: AGHT+IEhl32fSSdD5ad5LBFjgLGFpPCnw+dEMe0eb1EcoqDIiGFeWFih7+q3y5CHdsatnSzcgK6B8A==
X-Received: by 2002:a5d:5308:0:b0:317:5f08:329f with SMTP id e8-20020a5d5308000000b003175f08329fmr4024872wrv.1.1694681381258;
        Thu, 14 Sep 2023 01:49:41 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 09/10] selftests/xsk: fail single test instead of all tests
Date: Thu, 14 Sep 2023 10:48:56 +0200
Message-ID: <20230914084900.492-10-magnus.karlsson@gmail.com>
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

In a number of places at en error, exit_with_error() is called that
terminates the whole test suite. This is not always desirable as it
would be more logical to only fail that test and then go along with
the other ones. So change this in a number of places in which I
thought it would be more logical to just fail the test in
question. Examples of this are in code that is only used by a single
test.

Also delete a pointless if-statement in receive_pkts() that has an
exit_with_error() in it. It can never occur since the return value is
an unsigned and the test is for less than zero.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 70 ++++++++++++++++--------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index cc39a20951ff..d64061d647ae 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -947,36 +947,42 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
 	return true;
 }
 
-static void kick_tx(struct xsk_socket_info *xsk)
+static int kick_tx(struct xsk_socket_info *xsk)
 {
 	int ret;
 
 	ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
 	if (ret >= 0)
-		return;
+		return TEST_PASS;
 	if (errno == ENOBUFS || errno == EAGAIN || errno == EBUSY || errno == ENETDOWN) {
 		usleep(100);
-		return;
+		return TEST_PASS;
 	}
-	exit_with_error(errno);
+	return TEST_FAILURE;
 }
 
-static void kick_rx(struct xsk_socket_info *xsk)
+static int kick_rx(struct xsk_socket_info *xsk)
 {
 	int ret;
 
 	ret = recvfrom(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, NULL);
 	if (ret < 0)
-		exit_with_error(errno);
+		return TEST_FAILURE;
+
+	return TEST_PASS;
 }
 
 static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 {
 	unsigned int rcvd;
 	u32 idx;
+	int ret;
 
-	if (xsk_ring_prod__needs_wakeup(&xsk->tx))
-		kick_tx(xsk);
+	if (xsk_ring_prod__needs_wakeup(&xsk->tx)) {
+		ret = kick_tx(xsk);
+		if (ret)
+			return TEST_FAILURE;
+	}
 
 	rcvd = xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
 	if (rcvd) {
@@ -1024,11 +1030,14 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
 			return TEST_FAILURE;
 		}
 
-		kick_rx(xsk);
+		ret = kick_rx(xsk);
+		if (ret)
+			return TEST_FAILURE;
+
 		if (ifobj->use_poll) {
 			ret = poll(fds, 1, POLL_TMOUT);
 			if (ret < 0)
-				exit_with_error(errno);
+				return TEST_FAILURE;
 
 			if (!ret) {
 				if (!is_umem_valid(test->ifobj_tx))
@@ -1049,12 +1058,10 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
 		if (ifobj->use_fill_ring) {
 			ret = xsk_ring_prod__reserve(&umem->fq, rcvd, &idx_fq);
 			while (ret != rcvd) {
-				if (ret < 0)
-					exit_with_error(-ret);
 				if (xsk_ring_prod__needs_wakeup(&umem->fq)) {
 					ret = poll(fds, 1, POLL_TMOUT);
 					if (ret < 0)
-						exit_with_error(errno);
+						return TEST_FAILURE;
 				}
 				ret = xsk_ring_prod__reserve(&umem->fq, rcvd, &idx_fq);
 			}
@@ -1138,7 +1145,9 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
 	buffer_len = pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
 	/* pkts_in_flight might be negative if many invalid packets are sent */
 	if (pkts_in_flight >= (int)((umem_size(umem) - BATCH_SIZE * buffer_len) / buffer_len)) {
-		kick_tx(xsk);
+		ret = kick_tx(xsk);
+		if (ret)
+			return TEST_FAILURE;
 		return TEST_CONTINUE;
 	}
 
@@ -1321,7 +1330,9 @@ static int validate_rx_dropped(struct ifobject *ifobject)
 	struct xdp_statistics stats;
 	int err;
 
-	kick_rx(ifobject->xsk);
+	err = kick_rx(ifobject->xsk);
+	if (err)
+		return TEST_FAILURE;
 
 	err = get_xsk_stats(xsk, &stats);
 	if (err)
@@ -1347,7 +1358,9 @@ static int validate_rx_full(struct ifobject *ifobject)
 	int err;
 
 	usleep(1000);
-	kick_rx(ifobject->xsk);
+	err = kick_rx(ifobject->xsk);
+	if (err)
+		return TEST_FAILURE;
 
 	err = get_xsk_stats(xsk, &stats);
 	if (err)
@@ -1366,7 +1379,9 @@ static int validate_fill_empty(struct ifobject *ifobject)
 	int err;
 
 	usleep(1000);
-	kick_rx(ifobject->xsk);
+	err = kick_rx(ifobject->xsk);
+	if (err)
+		return TEST_FAILURE;
 
 	err = get_xsk_stats(xsk, &stats);
 	if (err)
@@ -1775,7 +1790,7 @@ static int testapp_bidirectional(struct test_spec *test)
 	return res;
 }
 
-static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
+static int swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
 {
 	int ret;
 
@@ -1786,7 +1801,9 @@ static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj
 
 	ret = xsk_update_xskmap(ifobj_rx->xskmap, ifobj_rx->xsk->xsk);
 	if (ret)
-		exit_with_error(errno);
+		return TEST_FAILURE;
+
+	return TEST_PASS;
 }
 
 static int testapp_xdp_prog_cleanup(struct test_spec *test)
@@ -1796,7 +1813,8 @@ static int testapp_xdp_prog_cleanup(struct test_spec *test)
 	if (testapp_validate_traffic(test))
 		return TEST_FAILURE;
 
-	swap_xsk_resources(test->ifobj_tx, test->ifobj_rx);
+	if (swap_xsk_resources(test->ifobj_tx, test->ifobj_rx))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -1997,11 +2015,15 @@ static int testapp_xdp_metadata_copy(struct test_spec *test)
 	test->ifobj_rx->use_metadata = true;
 
 	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
-	if (!data_map || !bpf_map__is_internal(data_map))
-		exit_with_error(ENOMEM);
+	if (!data_map || !bpf_map__is_internal(data_map)) {
+		ksft_print_msg("Error: could not find bss section of XDP program\n");
+		return TEST_FAILURE;
+	}
 
-	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count, BPF_ANY))
-		exit_with_error(errno);
+	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count, BPF_ANY)) {
+		ksft_print_msg("Error: could not update count element\n");
+		return TEST_FAILURE;
+	}
 
 	return testapp_validate_traffic(test);
 }
-- 
2.42.0


