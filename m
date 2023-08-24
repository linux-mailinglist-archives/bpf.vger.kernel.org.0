Return-Path: <bpf+bounces-8472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E894786F30
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82142815FE
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68E15497;
	Thu, 24 Aug 2023 12:29:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C615488;
	Thu, 24 Aug 2023 12:29:57 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A250819AD;
	Thu, 24 Aug 2023 05:29:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401314e7838so1061035e9.1;
        Thu, 24 Aug 2023 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880193; x=1693484993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WMcXaWB8ADPyc9rBPl+xE+wcO1I3lwvWbjNrw+ZS/A=;
        b=Us/MT9iUJ263KTqCCBf7AALKi+dNwu5t37kh6bOjXU6dKi9hdq14ZKD5Pv1qsi0Qp8
         zU5rKyRJJ1YpXcotBu4mh4C9G2j22zi76ZjnxPUxlsuLLDO3Ag1hKzpa2Jlx2VmMUeAe
         7hT0nZsyoWUQKg/gyrnmRdpFbZDYrtejGNI0Sx1lbmuUcsROI5Yhs59J1O5z0OEATYwV
         CVM6F9qo26flQlioLQcv5f64aC1ZwOEXXx8rc1ag2ewNPhBamuCIwww+AxAdLLWsIuKs
         Hb6cfPeVv6E958LnYqzZSyv3q3hIOgUeNLkrpV6l40zKUQdnkJONrGLU5r8RbKflP66U
         KGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880193; x=1693484993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WMcXaWB8ADPyc9rBPl+xE+wcO1I3lwvWbjNrw+ZS/A=;
        b=XitN3Nu4ehdrqUX8t7rmjRcGKSRpOrXWqNN6ChwrPMbeVtcb0F3ykGUZiag+TwvMAv
         jEHze80cBraZoYAIUZ1iiTHzMbkuCXHHtYE/B52ZUu0y8gPBOr8KeobVtyFoLeSU7LNs
         m5phAzM9UhAMUoaYm7epndAQJR8CR3zkcNgZXsjv5flIrNzI7a3VpPrB/k/ewu9DC3DP
         1ivR31dsS9mDPNcC/DTri9dWjkvlQwIzapUQ89DVeauI5Pw4SDj9hKx90RkonIIEcxsR
         DNP4wIrd4Rv82qh3/g8icGf3bJhGDnjH4yL/YDFjLs+HrfoyRXTfH3BMnhfRnGS6wY6T
         PAEQ==
X-Gm-Message-State: AOJu0YzV7vnm9lXP9m8mM5iNG2k76eXs4KYDx40BKkikR7H9/aqmRIBI
	UfsA5uIIKh7mYfoDma4qIgc=
X-Google-Smtp-Source: AGHT+IGGEbBbB421L/cPU0hkeNaeFcXOo9araOiqP75VfmB7uxFZNeIxJf2bx0nWF6D0/36zi0J4Sw==
X-Received: by 2002:a7b:c459:0:b0:3fe:5228:b78c with SMTP id l25-20020a7bc459000000b003fe5228b78cmr12299050wmi.1.1692880192881;
        Thu, 24 Aug 2023 05:29:52 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 09/11] selftests/xsk: fail single test instead of all tests
Date: Thu, 24 Aug 2023 14:28:51 +0200
Message-Id: <20230824122853.3494-10-magnus.karlsson@gmail.com>
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

In a number of places at en error, exit_with_error() is called that
terminates the whole test suite. This is not always desirable as it
would be more logical to only fail that test and then go along with
the other ones. So change this in a number of places in which I though
it would be more logical to just fail the test in question. Examples
of this are in code that is only used by a single test.

Also delete a pointless if-statement in receive_pkts() that has an
exit_with_error() in it. It can never occur since the return value is
an unisnged and the test is for less than zero.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 70 ++++++++++++++++--------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 2cb5fdf0188e..19db9a827c30 100644
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
2.34.1


