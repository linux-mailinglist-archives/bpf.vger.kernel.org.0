Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F013FD800
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 12:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhIAKtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 06:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbhIAKtC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 06:49:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E6DC061575;
        Wed,  1 Sep 2021 03:48:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t15so3776100wrg.7;
        Wed, 01 Sep 2021 03:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYnkjvotk/MpzM9rkR18s0IoSoRw+1ELJDU4lKnmO2E=;
        b=GFPr3eY7fzj58L81k6+CnvMxMGR2M2tJ/4dxV7StXRThGXfj1488pL9UAjrQvIZxdJ
         432j13GOFmXuPAxzd/wmWF67oUgBgd2i6J08QyWWsQKgnNef6c1yuqS/mg631XTq4sPe
         0uvsOW36yTMELIqTQoe9sTKdtxZdqmkqn5PdS/FGPwokGkPbkkOAISVFj04N+zeSc3N/
         jpED7xZlTsyR7uOhy/uLHwOrN7jmwEKM2e1FkfH7yEDbglZC1jPqeXplowxX5BKtvQ3w
         CDfyHS5LM2G9MUwwtwQG/SebNxmvN2JSUGkU/9OfW1GoPjhEj+pBk56kDHTE23jia7gM
         MqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYnkjvotk/MpzM9rkR18s0IoSoRw+1ELJDU4lKnmO2E=;
        b=lf9TL2UlwUnypSY31eX/HFLJZ83/S7HxhzCoSdwmR/KeVryGwWkf6ggtM2xUPZsKiN
         XPQE3+47GNoIbLv5lEfdbFLboSYypxN96KdYVsQ5W/EAPyMhEnwCoP/jsUMSjp3nUVpc
         qa8J+O5b6cj522oh0V+787DaifuijXEaWCXGjO18HBPTMdvk6zlkB+X5TcKFRpr11PMh
         I5LDjUamhGlXIW6+O48rw1cBw/miPCE+miWX/fSrh6wJbgkMUmI8FsaSjAiV0Hf0bej1
         c4ExEs60BxG3FJfcz16q3WtJFSf6j+dEEAK2iMY0P38SfLqbjLIBj9Hmhp16u/NnJSoW
         /FNQ==
X-Gm-Message-State: AOAM532zoppjUZA0p/nXThP18X/LtB5fsekpnhyFJlWUctLx5TlEzaJl
        tfYbb2lx+FH/zzOa8STB03c=
X-Google-Smtp-Source: ABdhPJzSvD02MU0iXjO/LIKBESUm4QQW79DQ4X9pE/D3ArisjJvlPTJmHBceBrWDjCnJ/zzM+J2/4g==
X-Received: by 2002:adf:e0cc:: with SMTP id m12mr38725141wri.62.1630493283226;
        Wed, 01 Sep 2021 03:48:03 -0700 (PDT)
Received: from localhost.localdomain (h-46-59-47-246.A165.priv.bahnhof.se. [46.59.47.246])
        by smtp.gmail.com with ESMTPSA id r12sm21530843wrv.96.2021.09.01.03.48.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:48:02 -0700 (PDT)
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
To:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com
Cc:     jonathan.lemon@gmail.com, ciara.loftus@intel.com,
        bpf@vger.kernel.org, yhs@fb.com, andrii@kernel.org
Subject: [PATCH bpf-next 03/20] selftests: xsk: introduce test specifications
Date:   Wed,  1 Sep 2021 12:47:15 +0200
Message-Id: <20210901104732.10956-4-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210901104732.10956-1-magnus.karlsson@gmail.com>
References: <20210901104732.10956-1-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

Introduce a test specification to be able to concisely describe a
test. Currently, a test is implemented by sprinkling test specific if
statements here and there, which is not scalable or easy to
understand. The end goal with this patch set is to come to the point
in which a test is completely specified by a test specification that
can easily be constructed in a single function so that new tests can
be added without too much trouble. This test specification will be run
by a test runner that has no idea about tests. It just executes the
what test specification states.

This patch introduces the test specification and, as a start, puts the
two interface objects in there, one containing the packet stream to be
sent and the other one the packet stream that is supposed to be
received for a test to pass. The global variables containing these can
then be eliminated. The following patches will convert each existing
test into a test specification and add the needed fields into it and
the functionality in the test runner that act on the test
specification. At the end, the test runner should contain no test
specific code and each test should be described in a single simple
function.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 203 ++++++++++++++---------
 tools/testing/selftests/bpf/xdpxceiver.h |   7 +-
 2 files changed, 126 insertions(+), 84 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index edf5b6cc6998..a6bcc7453860 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -336,45 +336,43 @@ static int switch_namespace(const char *nsname)
 	return nsfd;
 }
 
-static int validate_interfaces(void)
+static bool validate_interface(struct ifobject *ifobj)
 {
-	bool ret = true;
-
-	for (int i = 0; i < MAX_INTERFACES; i++) {
-		if (!strcmp(ifdict[i]->ifname, "")) {
-			ret = false;
-			ksft_test_result_fail("ERROR: interfaces: -i <int>,<ns> -i <int>,<ns>.");
-		}
-	}
-	return ret;
+	if (!strcmp(ifobj->ifname, ""))
+		return false;
+	return true;
 }
 
-static void parse_command_line(int argc, char **argv)
+static void parse_command_line(struct test_spec *test, int argc, char **argv)
 {
-	int option_index, interface_index = 0, c;
+	struct ifobject *ifobj;
+	u32 interface_nb = 0;
+	int option_index, c;
 
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "i:Dv", long_options, &option_index);
+		char *sptr, *token;
 
+		c = getopt_long(argc, argv, "i:Dv", long_options, &option_index);
 		if (c == -1)
 			break;
 
 		switch (c) {
 		case 'i':
-			if (interface_index == MAX_INTERFACES)
+			if (interface_nb == 0)
+				ifobj = test->ifobj_tx;
+			else if (interface_nb == 1)
+				ifobj = test->ifobj_rx;
+			else
 				break;
-			char *sptr, *token;
 
 			sptr = strndupa(optarg, strlen(optarg));
-			memcpy(ifdict[interface_index]->ifname,
-			       strsep(&sptr, ","), MAX_INTERFACE_NAME_CHARS);
+			memcpy(ifobj->ifname, strsep(&sptr, ","), MAX_INTERFACE_NAME_CHARS);
 			token = strsep(&sptr, ",");
 			if (token)
-				memcpy(ifdict[interface_index]->nsname, token,
-				       MAX_INTERFACES_NAMESPACE_CHARS);
-			interface_index++;
+				memcpy(ifobj->nsname, token, MAX_INTERFACES_NAMESPACE_CHARS);
+			interface_nb++;
 			break;
 		case 'D':
 			opt_pkt_dump = true;
@@ -387,11 +385,44 @@ static void parse_command_line(int argc, char **argv)
 			ksft_exit_xfail();
 		}
 	}
+}
 
-	if (!validate_interfaces()) {
-		usage(basename(argv[0]));
-		ksft_exit_xfail();
+static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
+			     struct ifobject *ifobj_rx)
+{
+	u32 i, j;
+
+	for (i = 0; i < MAX_INTERFACES; i++) {
+		struct ifobject *ifobj = i ? ifobj_rx : ifobj_tx;
+
+		ifobj->umem = &ifobj->umem_arr[0];
+		ifobj->xsk = &ifobj->xsk_arr[0];
+
+		if (i == tx)
+			ifobj->fv.vector = tx;
+		else
+			ifobj->fv.vector = rx;
+
+		for (j = 0; j < MAX_SOCKETS; j++) {
+			memset(&ifobj->umem_arr[j], 0, sizeof(ifobj->umem_arr[j]));
+			memset(&ifobj->xsk_arr[j], 0, sizeof(ifobj->xsk_arr[j]));
+		}
 	}
+
+	test->ifobj_tx = ifobj_tx;
+	test->ifobj_rx = ifobj_rx;
+}
+
+static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
+			   struct ifobject *ifobj_rx)
+{
+	memset(test, 0, sizeof(*test));
+	__test_spec_init(test, ifobj_tx, ifobj_rx);
+}
+
+static void test_spec_reset(struct test_spec *test)
+{
+	__test_spec_init(test, test->ifobj_tx, test->ifobj_rx);
 }
 
 static struct pkt *pkt_stream_get_pkt(struct pkt_stream *pkt_stream, u32 pkt_nb)
@@ -842,8 +873,10 @@ static void *worker_testapp_validate_rx(void *arg)
 	pthread_exit(NULL);
 }
 
-static void testapp_validate(void)
+static void testapp_validate_traffic(struct test_spec *test)
 {
+	struct ifobject *ifobj_tx = test->ifobj_tx;
+	struct ifobject *ifobj_rx = test->ifobj_rx;
 	bool bidi = test_type == TEST_TYPE_BIDI;
 	bool bpf = test_type == TEST_TYPE_BPF_RES;
 	struct pkt_stream *pkt_stream;
@@ -855,18 +888,18 @@ static void testapp_validate(void)
 		pkt_stream = pkt_stream_generate(DEFAULT_PKT_CNT, XSK_UMEM__INVALID_FRAME_SIZE);
 	else
 		pkt_stream = pkt_stream_generate(DEFAULT_PKT_CNT, PKT_SIZE);
-	ifdict_tx->pkt_stream = pkt_stream;
-	ifdict_rx->pkt_stream = pkt_stream;
+	ifobj_tx->pkt_stream = pkt_stream;
+	ifobj_rx->pkt_stream = pkt_stream;
 
 	/*Spawn RX thread */
-	pthread_create(&t0, NULL, ifdict_rx->func_ptr, ifdict_rx);
+	pthread_create(&t0, NULL, ifobj_rx->func_ptr, ifobj_rx);
 
 	pthread_barrier_wait(&barr);
 	if (pthread_barrier_destroy(&barr))
 		exit_with_error(errno);
 
 	/*Spawn TX thread */
-	pthread_create(&t1, NULL, ifdict_tx->func_ptr, ifdict_tx);
+	pthread_create(&t1, NULL, ifobj_tx->func_ptr, ifobj_tx);
 
 	pthread_join(t1, NULL);
 	pthread_join(t0, NULL);
@@ -875,80 +908,82 @@ static void testapp_validate(void)
 		print_ksft_result();
 }
 
-static void testapp_teardown(void)
+static void testapp_teardown(struct test_spec *test)
 {
 	int i;
 
 	for (i = 0; i < MAX_TEARDOWN_ITER; i++) {
-		print_verbose("Creating socket\n");
-		testapp_validate();
+		testapp_validate_traffic(test);
+		test_spec_reset(test);
 	}
 
 	print_ksft_result();
 }
 
-static void swap_vectors(struct ifobject *ifobj1, struct ifobject *ifobj2)
+static void swap_directions(struct ifobject **ifobj1, struct ifobject **ifobj2)
 {
-	void *(*tmp_func_ptr)(void *) = ifobj1->func_ptr;
-	enum fvector tmp_vector = ifobj1->fv.vector;
+	thread_func_t tmp_func_ptr = (*ifobj1)->func_ptr;
+	enum fvector tmp_vector = (*ifobj1)->fv.vector;
+	struct ifobject *tmp_ifobj = (*ifobj1);
 
-	ifobj1->func_ptr = ifobj2->func_ptr;
-	ifobj1->fv.vector = ifobj2->fv.vector;
+	(*ifobj1)->func_ptr = (*ifobj2)->func_ptr;
+	(*ifobj1)->fv.vector = (*ifobj2)->fv.vector;
 
-	ifobj2->func_ptr = tmp_func_ptr;
-	ifobj2->fv.vector = tmp_vector;
+	(*ifobj2)->func_ptr = tmp_func_ptr;
+	(*ifobj2)->fv.vector = tmp_vector;
 
-	ifdict_tx = ifobj1;
-	ifdict_rx = ifobj2;
+	*ifobj1 = *ifobj2;
+	*ifobj2 = tmp_ifobj;
 }
 
-static void testapp_bidi(void)
+static void testapp_bidi(struct test_spec *test)
 {
 	for (int i = 0; i < MAX_BIDI_ITER; i++) {
 		print_verbose("Creating socket\n");
-		testapp_validate();
+		testapp_validate_traffic(test);
 		if (!second_step) {
 			print_verbose("Switching Tx/Rx vectors\n");
-			swap_vectors(ifdict[1], ifdict[0]);
+			swap_directions(&test->ifobj_rx, &test->ifobj_tx);
 		}
 		second_step = true;
 	}
 
-	swap_vectors(ifdict[0], ifdict[1]);
+	swap_directions(&test->ifobj_rx, &test->ifobj_tx);
 
 	print_ksft_result();
 }
 
-static void swap_xsk_res(void)
+static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
 {
-	xsk_socket__delete(ifdict_tx->xsk->xsk);
-	xsk_umem__delete(ifdict_tx->umem->umem);
-	xsk_socket__delete(ifdict_rx->xsk->xsk);
-	xsk_umem__delete(ifdict_rx->umem->umem);
-	ifdict_tx->umem = &ifdict_tx->umem_arr[1];
-	ifdict_tx->xsk = &ifdict_tx->xsk_arr[1];
-	ifdict_rx->umem = &ifdict_rx->umem_arr[1];
-	ifdict_rx->xsk = &ifdict_rx->xsk_arr[1];
+	xsk_socket__delete(ifobj_tx->xsk->xsk);
+	xsk_umem__delete(ifobj_tx->umem->umem);
+	xsk_socket__delete(ifobj_rx->xsk->xsk);
+	xsk_umem__delete(ifobj_rx->umem->umem);
+	ifobj_tx->umem = &ifobj_tx->umem_arr[1];
+	ifobj_tx->xsk = &ifobj_tx->xsk_arr[1];
+	ifobj_rx->umem = &ifobj_rx->umem_arr[1];
+	ifobj_rx->xsk = &ifobj_rx->xsk_arr[1];
 }
 
-static void testapp_bpf_res(void)
+static void testapp_bpf_res(struct test_spec *test)
 {
 	int i;
 
 	for (i = 0; i < MAX_BPF_ITER; i++) {
 		print_verbose("Creating socket\n");
-		testapp_validate();
+		testapp_validate_traffic(test);
 		if (!second_step)
-			swap_xsk_res();
+			swap_xsk_resources(test->ifobj_tx, test->ifobj_rx);
 		second_step = true;
 	}
 
 	print_ksft_result();
 }
 
-static void testapp_stats(void)
+static void testapp_stats(struct test_spec *test)
 {
 	for (int i = 0; i < STAT_TEST_TYPE_MAX; i++) {
+		test_spec_reset(test);
 		stat_test_type = i;
 
 		/* reset defaults */
@@ -968,7 +1003,7 @@ static void testapp_stats(void)
 		default:
 			break;
 		}
-		testapp_validate();
+		testapp_validate_traffic(test);
 	}
 
 	print_ksft_result();
@@ -992,16 +1027,11 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 	ifobj->dst_port = dst_port;
 	ifobj->src_port = src_port;
 
-	if (vector == tx)
-		ifdict_tx = ifobj;
-	else
-		ifdict_rx = ifobj;
-
 	ifobj->fv.vector = vector;
 	ifobj->func_ptr = func_ptr;
 }
 
-static void run_pkt_test(int mode, int type)
+static void run_pkt_test(struct test_spec *test, int mode, int type)
 {
 	test_type = type;
 
@@ -1027,19 +1057,19 @@ static void run_pkt_test(int mode, int type)
 
 	switch (test_type) {
 	case TEST_TYPE_STATS:
-		testapp_stats();
+		testapp_stats(test);
 		break;
 	case TEST_TYPE_TEARDOWN:
-		testapp_teardown();
+		testapp_teardown(test);
 		break;
 	case TEST_TYPE_BIDI:
-		testapp_bidi();
+		testapp_bidi(test);
 		break;
 	case TEST_TYPE_BPF_RES:
-		testapp_bpf_res();
+		testapp_bpf_res(test);
 		break;
 	default:
-		testapp_validate();
+		testapp_validate_traffic(test);
 		break;
 	}
 }
@@ -1079,36 +1109,47 @@ static void ifobject_delete(struct ifobject *ifobj)
 int main(int argc, char **argv)
 {
 	struct rlimit _rlim = { RLIM_INFINITY, RLIM_INFINITY };
-	int i, j;
+	struct ifobject *ifobj_tx, *ifobj_rx;
+	struct test_spec test;
+	u32 i, j;
 
 	if (setrlimit(RLIMIT_MEMLOCK, &_rlim))
 		exit_with_error(errno);
 
-	for (i = 0; i < MAX_INTERFACES; i++) {
-		ifdict[i] = ifobject_create();
-		if (!ifdict[i])
-			exit_with_error(ENOMEM);
-	}
+	ifobj_tx = ifobject_create();
+	if (!ifobj_tx)
+		exit_with_error(ENOMEM);
+	ifobj_rx = ifobject_create();
+	if (!ifobj_rx)
+		exit_with_error(ENOMEM);
+
+	test_spec_init(&test, ifobj_tx, ifobj_rx);
 
 	setlocale(LC_ALL, "");
 
-	parse_command_line(argc, argv);
+	parse_command_line(&test, argc, argv);
+
+	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx)) {
+		usage(basename(argv[0]));
+		ksft_exit_xfail();
+	}
 
-	init_iface(ifdict[tx], MAC1, MAC2, IP1, IP2, UDP_PORT1, UDP_PORT2, tx,
+	init_iface(ifobj_tx, MAC1, MAC2, IP1, IP2, UDP_PORT1, UDP_PORT2, tx,
 		   worker_testapp_validate_tx);
-	init_iface(ifdict[rx], MAC2, MAC1, IP2, IP1, UDP_PORT2, UDP_PORT1, rx,
+	init_iface(ifobj_rx, MAC2, MAC1, IP2, IP1, UDP_PORT2, UDP_PORT1, rx,
 		   worker_testapp_validate_rx);
 
 	ksft_set_plan(TEST_MODE_MAX * TEST_TYPE_MAX);
 
 	for (i = 0; i < TEST_MODE_MAX; i++)
 		for (j = 0; j < TEST_TYPE_MAX; j++) {
-			run_pkt_test(i, j);
+			test_spec_init(&test, ifobj_tx, ifobj_rx);
+			run_pkt_test(&test, i, j);
 			usleep(USLEEP_MAX);
 		}
 
-	for (i = 0; i < MAX_INTERFACES; i++)
-		ifobject_delete(ifdict[i]);
+	ifobject_delete(ifobj_tx);
+	ifobject_delete(ifobj_rx);
 
 	ksft_exit_pass();
 	return 0;
diff --git a/tools/testing/selftests/bpf/xdpxceiver.h b/tools/testing/selftests/bpf/xdpxceiver.h
index 799d524eb425..e279aa893438 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.h
+++ b/tools/testing/selftests/bpf/xdpxceiver.h
@@ -137,9 +137,10 @@ struct ifobject {
 	u8 src_mac[ETH_ALEN];
 };
 
-static struct ifobject *ifdict[MAX_INTERFACES];
-static struct ifobject *ifdict_rx;
-static struct ifobject *ifdict_tx;
+struct test_spec {
+	struct ifobject *ifobj_tx;
+	struct ifobject *ifobj_rx;
+};
 
 /*threads*/
 pthread_barrier_t barr;
-- 
2.29.0

