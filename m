Return-Path: <bpf+bounces-7358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DADA775FA4
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11465280D42
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FAD198BF;
	Wed,  9 Aug 2023 12:44:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E12182A4;
	Wed,  9 Aug 2023 12:44:40 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEEB19A1;
	Wed,  9 Aug 2023 05:44:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe23319695so18114525e9.0;
        Wed, 09 Aug 2023 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585078; x=1692189878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Daga65Saxn8lUhaPrHDRPk4encj5FyjP/ZTSakJvhfA=;
        b=AT4QQwmlm65yiwXYNUjIkmiKr0ZtrKtPoTrF9DFMON33H6YBz8cRdcq7B64qiBq+zK
         0srLBEEKUseFk/xceUOuJEml82ohxSqzU1zh5CYg5TYNWsAi0JQZPhrjJjUV8T9YVtcT
         0imT4g8Jvl0pe1M0ggltmkr8SobJf4gnlFYWmus5Q0oVsfzOBAIzd0V+X3FHA+ZiCv/v
         sa/y52QjDLK7QYNXw0MXgHKuYXTCpXu86s8AOGkheTRjZRw7VgsHi+paYlLqRPi04Cvh
         Y76kDwSUytROQ/PcVIAT5eMM68q76W1ZkHlysOH+cFU11jiB5NkVCS7ugm4/nX3gFbMM
         EoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585078; x=1692189878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Daga65Saxn8lUhaPrHDRPk4encj5FyjP/ZTSakJvhfA=;
        b=ADBO+vhtKuSzgRb1xb9aTYjZmQHNq8el6yFbsp7dib2tAPbwN4JvOep1PHna8SH2V5
         8PkeQrVAh9PJPJq77uqiH0HRYxBd2A/7fy+mmxrtC+t8uwc8MnQFbiO1RMKg6nLaO8Aw
         UFgsqaNSPsZw3tsvWkBiAYx/uEKr2w8WcyBDcA7RNih/WOWmtmKHbXSQx9fPPFcfsODx
         2gg8kJv90pa2SJCx5FquFWEWk0KdI4o1WY9sTVLwpAT5YTXJ182J9VZsq6Q5th8ccK+Z
         TU9N1M37VzfqChQr6TeFgr7tLdtxMDwZdI5LcolLb/v4ZHFED9maTQcfAkSHmMUg0o2O
         C2Ng==
X-Gm-Message-State: AOJu0YxoMCSYUdo/lbZspcF1LzStpZazgF11MJM9zVvkkZ3VxWzvzK4N
	5vQy5g0V4G6qtj1kRbjoNGc=
X-Google-Smtp-Source: AGHT+IHoeHuiNN0DyqSm07Mxs63vb0S5sE1hi6b1VF1VpPdnHyqk63VzSUGwE1PwTEgNIt2RnfPraQ==
X-Received: by 2002:adf:e70d:0:b0:317:ec2e:5a07 with SMTP id c13-20020adfe70d000000b00317ec2e5a07mr1801328wrm.0.1691585077720;
        Wed, 09 Aug 2023 05:44:37 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:37 -0700 (PDT)
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
Subject: [PATCH bpf-next 09/10] selftests/xsk: fail single test instead of all tests
Date: Wed,  9 Aug 2023 14:43:42 +0200
Message-Id: <20230809124343.12957-10-magnus.karlsson@gmail.com>
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
index 7c19aef1dcc9..ffa8905a66f1 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -949,36 +949,42 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
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
@@ -1026,11 +1032,14 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
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
@@ -1051,12 +1060,10 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
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
@@ -1140,7 +1147,9 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
 	buffer_len = pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
 	/* pkts_in_flight might be negative if many invalid packets are sent */
 	if (pkts_in_flight >= (int)((umem_size(umem) - BATCH_SIZE * buffer_len) / buffer_len)) {
-		kick_tx(xsk);
+		ret = kick_tx(xsk);
+		if (ret)
+			return TEST_FAILURE;
 		return TEST_CONTINUE;
 	}
 
@@ -1323,7 +1332,9 @@ static int validate_rx_dropped(struct ifobject *ifobject)
 	struct xdp_statistics stats;
 	int err;
 
-	kick_rx(ifobject->xsk);
+	err = kick_rx(ifobject->xsk);
+	if (err)
+		return TEST_FAILURE;
 
 	err = get_xsk_stats(xsk, &stats);
 	if (err)
@@ -1349,7 +1360,9 @@ static int validate_rx_full(struct ifobject *ifobject)
 	int err;
 
 	usleep(1000);
-	kick_rx(ifobject->xsk);
+	err = kick_rx(ifobject->xsk);
+	if (err)
+		return TEST_FAILURE;
 
 	err = get_xsk_stats(xsk, &stats);
 	if (err)
@@ -1368,7 +1381,9 @@ static int validate_fill_empty(struct ifobject *ifobject)
 	int err;
 
 	usleep(1000);
-	kick_rx(ifobject->xsk);
+	err = kick_rx(ifobject->xsk);
+	if (err)
+		return TEST_FAILURE;
 
 	err = get_xsk_stats(xsk, &stats);
 	if (err)
@@ -1777,7 +1792,7 @@ static int testapp_bidirectional(struct test_spec *test)
 	return res;
 }
 
-static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
+static int swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
 {
 	int ret;
 
@@ -1788,7 +1803,9 @@ static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj
 
 	ret = xsk_update_xskmap(ifobj_rx->xskmap, ifobj_rx->xsk->xsk);
 	if (ret)
-		exit_with_error(errno);
+		return TEST_FAILURE;
+
+	return TEST_PASS;
 }
 
 static int testapp_xdp_prog_cleanup(struct test_spec *test)
@@ -1798,7 +1815,8 @@ static int testapp_xdp_prog_cleanup(struct test_spec *test)
 	if (testapp_validate_traffic(test))
 		return TEST_FAILURE;
 
-	swap_xsk_resources(test->ifobj_tx, test->ifobj_rx);
+	if (swap_xsk_resources(test->ifobj_tx, test->ifobj_rx))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -1999,11 +2017,15 @@ static int testapp_xdp_metadata_copy(struct test_spec *test)
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


