Return-Path: <bpf+bounces-7356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E393C775F9D
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AF9281C42
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E05718C30;
	Wed,  9 Aug 2023 12:44:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E317FFB;
	Wed,  9 Aug 2023 12:44:33 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09021BDA;
	Wed,  9 Aug 2023 05:44:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe23319695so18114245e9.0;
        Wed, 09 Aug 2023 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585071; x=1692189871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUrJqJfUUQQBrqSXP7Dl6CLg1z//SQw+Nn6QflXfcAc=;
        b=dMd+ypHkPDAjJ76oYf1mXRMKNIxl+V1v9I/5ZWsFO4aAluh8kHojgEvP7mYcLHqXjp
         zKro49ILQK/Ht0vSWBNrohJNJ5tWvAEHh3x6rqbQopXiMIxFqC5En1sd0bvl9eUzYbz2
         /z0mCw8RRrCb+u1Xll0XrTd/Z4XRKblj30eMqt0aPezuz6EVnkCjeonW96DL6ZZDhZbh
         /wINkd+rv7WzuANGoXNX1Dyjq50i+Of4Ndm/ituTUdHKUbXvspJ/Ht3YP3bH8EfJy0Zh
         7OPDaYcSaBZXHudEc6bbuq7GcG5WfGUfF/l8aPUY9DqQk/riFp8nmPmOCNaHmD3+vRwm
         POow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585071; x=1692189871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUrJqJfUUQQBrqSXP7Dl6CLg1z//SQw+Nn6QflXfcAc=;
        b=K+fqZyJfGBKEh5cdYZcxl69fBYIqDPltXcwvB4iUVpMUfIuHNo+gtFqNQ40srz9GrF
         xNA3gfhub9+1t2XELAvIUnmPBDJHKMLeDo7XFRI8Y8swRKi61XNhslGtjNnkUUB0nojF
         w0mId086qBQj+4UKdfXKXqibJrzQuLB3dJbFqjPp4BJfBHersNqVcEgQnI9ntyfN4LOD
         5SbZy1We3bODp1yRNlK5Qo/a+Nk8FS1tOLzVoxso79G9RVfZ1ocXi5ioCXOAibu6ckeg
         Td0DR4sG4gCz2nRc13+Wv32lNypdWJ8GVJv3T/ekiidL2XtSVHmxYo4mtWdC/iWD1Yfa
         0zqw==
X-Gm-Message-State: AOJu0Yyyc6u+cIeXKJ84p6LolnP6Sn3uVGPjmX9mTRjkOEtsSgcOgLx6
	ogcP607AG5HsSmu6h+Pq3/0=
X-Google-Smtp-Source: AGHT+IEhKOEN0hnVuJkb8gEGPcTsQZXI4c5WZz+G9XvG3RcLtOlzNt+DbEh1IHLtaHR2zSZPRT6PmA==
X-Received: by 2002:a5d:534d:0:b0:317:3da0:7606 with SMTP id t13-20020a5d534d000000b003173da07606mr1597297wrv.4.1691585071028;
        Wed, 09 Aug 2023 05:44:31 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:30 -0700 (PDT)
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
Subject: [PATCH bpf-next 07/10] selftests/xsk: add option to run single test
Date: Wed,  9 Aug 2023 14:43:40 +0200
Message-Id: <20230809124343.12957-8-magnus.karlsson@gmail.com>
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

Add a command line option to be able to run a single test. This option
(-t) takes a number from the list of tests available with the "-l"
option. Here are two examples:

Run test number 2, the "receive single packet" test in all available modes:

./test_xsk.sh -t 2

Run test number 21, the metadata copy test in zero-copy mode only

./test_xsh.sh -t 21 -m zc

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh  | 10 ++++++-
 tools/testing/selftests/bpf/xskxceiver.c | 38 +++++++++++++++++++-----
 tools/testing/selftests/bpf/xskxceiver.h |  3 ++
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 00a504f0929a..94b4b86d5239 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -76,12 +76,15 @@
 #
 # Run test suite in a specific mode only [skb,drv,zc]
 #   sudo ./test_xsk.sh -m MODE
+#
+# Run a specific test from the test suite
+#   sudo ./test_xsk.sh -t TEST_NAME
 
 . xsk_prereqs.sh
 
 ETH=""
 
-while getopts "vi:dm:l" flag
+while getopts "vi:dm:lt:" flag
 do
 	case "${flag}" in
 		v) verbose=1;;
@@ -89,6 +92,7 @@ do
 		i) ETH=${OPTARG};;
 		m) MODE=${OPTARG};;
 		l) list=1;;
+		t) TEST=${OPTARG};;
 	esac
 done
 
@@ -166,6 +170,10 @@ if [ ! -z $MODE ]; then
 	ARGS+="-m ${MODE} "
 fi
 
+if [ ! -z $TEST ]; then
+	ARGS+="-t ${TEST} "
+fi
+
 retval=$?
 test_status $retval "${TEST_NAME}"
 
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index a063b9af7fff..38ec66292e03 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -110,6 +110,7 @@ static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
 static bool opt_verbose;
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
+static u32 opt_run_test = RUN_ALL_TESTS;
 
 static void __exit_with_error(int error, const char *file, const char *func, int line)
 {
@@ -316,6 +317,7 @@ static struct option long_options[] = {
 	{"verbose", no_argument, 0, 'v'},
 	{"mode", required_argument, 0, 'm'},
 	{"list", no_argument, 0, 'l'},
+	{"test", required_argument, 0, 'y'},
 	{0, 0, 0, 0}
 };
 
@@ -328,7 +330,8 @@ static void usage(const char *prog)
 		"  -v, --verbose        Verbose output\n"
 		"  -b, --busy-poll      Enable busy poll\n"
 		"  -m, --mode           Run only mode skb, drv, or zc\n"
-		"  -l, --list           List all available tests\n";
+		"  -l, --list           List all available tests\n"
+		"  -t, --test           Run a specific test. Enter number from -l option\n";
 
 	ksft_print_msg(str, prog);
 }
@@ -350,7 +353,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "i:vbm:l", long_options, &option_index);
+		c = getopt_long(argc, argv, "i:vbm:lt:", long_options, &option_index);
 		if (c == -1)
 			break;
 
@@ -397,6 +400,9 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 		case 'l':
 			opt_print_tests = true;
 			break;
+		case 't':
+			opt_run_test = atol(optarg);
+			break;
 		default:
 			usage(basename(argv[0]));
 			ksft_exit_xfail();
@@ -2330,8 +2336,8 @@ int main(int argc, char **argv)
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
+	u32 i, j, failed_tests = 0, nb_tests;
 	int modes = TEST_MODE_SKB + 1;
-	u32 i, j, failed_tests = 0;
 	struct test_spec test;
 	bool shared_netdev;
 
@@ -2353,6 +2359,10 @@ int main(int argc, char **argv)
 		print_tests();
 		ksft_exit_xpass();
 	}
+	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= ARRAY_SIZE(tests)) {
+		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
+		ksft_exit_xfail();
+	}
 
 	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
 	ifobj_tx->shared_umem = shared_netdev;
@@ -2380,19 +2390,31 @@ int main(int argc, char **argv)
 	test.tx_pkt_stream_default = tx_pkt_stream_default;
 	test.rx_pkt_stream_default = rx_pkt_stream_default;
 
+	if (opt_run_test == RUN_ALL_TESTS)
+		nb_tests = ARRAY_SIZE(tests);
+	else
+		nb_tests = 1;
 	if (opt_mode == TEST_MODE_ALL)
-		ksft_set_plan(modes * ARRAY_SIZE(tests));
+		ksft_set_plan(modes * nb_tests);
 	else
-		ksft_set_plan(ARRAY_SIZE(tests));
+		ksft_set_plan(nb_tests);
 
 	for (i = 0; i < modes; i++) {
 		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
 			continue;
 
-		for (j = 0; j < ARRAY_SIZE(tests); j++) {
-			test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
+		if (opt_run_test == RUN_ALL_TESTS) {
+			for (j = 0; j < ARRAY_SIZE(tests); j++) {
+				test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
+				run_pkt_test(&test);
+				usleep(USLEEP_MAX);
+
+				if (test.fail)
+					failed_tests++;
+			}
+		} else {
+			test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[opt_run_test]);
 			run_pkt_test(&test);
-			usleep(USLEEP_MAX);
 
 			if (test.fail)
 				failed_tests++;
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 3a71d490db3e..8015aeea839d 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -5,6 +5,8 @@
 #ifndef XSKXCEIVER_H_
 #define XSKXCEIVER_H_
 
+#include <limits.h>
+
 #include "xsk_xdp_progs.skel.h"
 
 #ifndef SOL_XDP
@@ -56,6 +58,7 @@
 #define XSK_DESC__MAX_SKB_FRAGS 18
 #define HUGEPAGE_SIZE (2 * 1024 * 1024)
 #define PKT_DUMP_NB_TO_PRINT 16
+#define RUN_ALL_TESTS UINT_MAX
 
 #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
 
-- 
2.34.1


