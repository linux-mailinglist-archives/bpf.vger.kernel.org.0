Return-Path: <bpf+bounces-9896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B5979E5C9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157D32824A0
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5D81F92A;
	Wed, 13 Sep 2023 11:03:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F061F923;
	Wed, 13 Sep 2023 11:03:30 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC319AD;
	Wed, 13 Sep 2023 04:03:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c49de7a41so978016f8f.1;
        Wed, 13 Sep 2023 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694603008; x=1695207808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t72HiI4Z7SbW3FYbs4ZUinBtLhT6crPjLU7yzdxo9Lg=;
        b=ddwl5xButHuuIGbwDUxxvGvYamCC889Bmf9/Qt4Y5LE+BOIuvK/57Q3CCrzsin7Wza
         g/SO55+R4gG1Hhh3MpHsuj0FvW7n/L1bNuMONDjezCbT25pLFMKNAiovQ+ncYF6SxdU5
         9Yn2G7GLkAXfgRvHj13mv1mH9chASRTKTk2Fwot1KauS1gLnGeE7CvBEczpjXbZqH6eR
         R3rZrSyldiRgpaSRCgSShGtqUwlvbM/qnvtr+/SCmYEtE6woprqu734WfWjYHMHejq+X
         y8Vbu6OOX+Y+S7hOvWYhmfiVYgFWjnZB+SkfZ8MTCfzKOkCJTbmBJqt3wZK4NI3sF9eL
         6WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694603008; x=1695207808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t72HiI4Z7SbW3FYbs4ZUinBtLhT6crPjLU7yzdxo9Lg=;
        b=MZ0IPH38XCZODSt1W5BKOOBuVaUtEkCOdZAy6TgTxjrqNfkSszPiqlnYn4+hyl8ChU
         rgsoP+vsE43330Y2A8LyaDcIeoRGlWAMxgrLa1EJTMkb9w02j93ef0t/mGasA3/ueOOC
         pNOxS1e7EFC+6W4+W1ZVMurjYUYY7JBs1JrVI3ayctv9kAyCtEprbyB1ELekLiizbNa3
         tILDXesTKnA/JyOLGg5n7lds8DWj3IGPslKtyijXHG38A/HiW72M10aocVf2mR38UsbD
         JsdPjC+qfhiDFjQNrDAtmDpN5662lQ1cJjpl+G0DUb9kpSME/HD2iX3c4q2LRZ9GkzBi
         lnpg==
X-Gm-Message-State: AOJu0YyieM+E/CLIRQbl+Fqka3xJgARvflRNSs1kydvO2MxT1krgBXS2
	9BapjOUylB1wPcbOrW7/J6E=
X-Google-Smtp-Source: AGHT+IFZYM2HA/xwEhoBdjU06Sehocv1Gdvy6Apdxae7kOgdBUuUWQnFZ+ehuV8J5ujR8MJHSSsu+g==
X-Received: by 2002:a5d:4243:0:b0:31d:3669:1c51 with SMTP id s3-20020a5d4243000000b0031d36691c51mr1570646wrr.5.1694603007915;
        Wed, 13 Sep 2023 04:03:27 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm15255289wrv.111.2023.09.13.04.03.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:03:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 09/10] selftests/xsk: fail single test instead of all tests
Date: Wed, 13 Sep 2023 13:02:31 +0200
Message-ID: <20230913110248.30597-10-magnus.karlsson@gmail.com>
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

In a number of places at en error, exit_with_error() is called that
terminates the whole test suite. This is not always desirable as it
would be more logical to only fail that test and then go along with
the other ones. So change this in a number of places in which I
thought it would be more logical to just fail the test in
question. Examples of this are in code that is only used by a single
test.

Also delete a pointless if-statement in receive_pkts() that has an
exit_with_error() in it. It can never occur since the return value is
an unisnged and the test is for less than zero.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 70 ++++++++++++++++--------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 1a0bb058877c..9883e610ff63 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -951,36 +951,42 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
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
@@ -1028,11 +1034,14 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
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
@@ -1053,12 +1062,10 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
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
@@ -1142,7 +1149,9 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
 	buffer_len = pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
 	/* pkts_in_flight might be negative if many invalid packets are sent */
 	if (pkts_in_flight >= (int)((umem_size(umem) - BATCH_SIZE * buffer_len) / buffer_len)) {
-		kick_tx(xsk);
+		ret = kick_tx(xsk);
+		if (ret)
+			return TEST_FAILURE;
 		return TEST_CONTINUE;
 	}
 
@@ -1325,7 +1334,9 @@ static int validate_rx_dropped(struct ifobject *ifobject)
 	struct xdp_statistics stats;
 	int err;
 
-	kick_rx(ifobject->xsk);
+	err = kick_rx(ifobject->xsk);
+	if (err)
+		return TEST_FAILURE;
 
 	err = get_xsk_stats(xsk, &stats);
 	if (err)
@@ -1351,7 +1362,9 @@ static int validate_rx_full(struct ifobject *ifobject)
 	int err;
 
 	usleep(1000);
-	kick_rx(ifobject->xsk);
+	err = kick_rx(ifobject->xsk);
+	if (err)
+		return TEST_FAILURE;
 
 	err = get_xsk_stats(xsk, &stats);
 	if (err)
@@ -1370,7 +1383,9 @@ static int validate_fill_empty(struct ifobject *ifobject)
 	int err;
 
 	usleep(1000);
-	kick_rx(ifobject->xsk);
+	err = kick_rx(ifobject->xsk);
+	if (err)
+		return TEST_FAILURE;
 
 	err = get_xsk_stats(xsk, &stats);
 	if (err)
@@ -1779,7 +1794,7 @@ static int testapp_bidirectional(struct test_spec *test)
 	return res;
 }
 
-static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
+static int swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
 {
 	int ret;
 
@@ -1790,7 +1805,9 @@ static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj
 
 	ret = xsk_update_xskmap(ifobj_rx->xskmap, ifobj_rx->xsk->xsk);
 	if (ret)
-		exit_with_error(errno);
+		return TEST_FAILURE;
+
+	return TEST_PASS;
 }
 
 static int testapp_xdp_prog_cleanup(struct test_spec *test)
@@ -1800,7 +1817,8 @@ static int testapp_xdp_prog_cleanup(struct test_spec *test)
 	if (testapp_validate_traffic(test))
 		return TEST_FAILURE;
 
-	swap_xsk_resources(test->ifobj_tx, test->ifobj_rx);
+	if (swap_xsk_resources(test->ifobj_tx, test->ifobj_rx))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2001,11 +2019,15 @@ static int testapp_xdp_metadata_copy(struct test_spec *test)
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


