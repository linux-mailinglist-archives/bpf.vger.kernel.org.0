Return-Path: <bpf+bounces-9990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E3279FF41
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D283281EDE
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081CD20B36;
	Thu, 14 Sep 2023 08:49:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037920B0B;
	Thu, 14 Sep 2023 08:49:39 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3667791;
	Thu, 14 Sep 2023 01:49:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-404724ec0dcso898405e9.1;
        Thu, 14 Sep 2023 01:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681377; x=1695286177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQQ8W7dTHfeE7O02ojs1+zPGe26GnI77MO8cdAMaFVo=;
        b=brw0gSXJ+8aLKwA+2J0RErs2UowFMH93QUl/Na+UvP4PYtzT2zFfg1+Pb3kuuiEmMF
         IusU4quKrYh5fxC3NNJqA9k1+hTA64ggfbwA7OBrHXKeJkjeA5DjUJEy0Wv8u90eUXiH
         HU3WSyjvduPXV/c/EKvfzOy/JzO8jv4iBHeCvXozPb8L7aYQKJpWwmBa5gWEFKdnO3r3
         JvbQbqY1M0fG/gKnZ7IcGpuJckbHtHohT9y79RznSDuRBlxK63QqBtpLsmwUGcM/EQEX
         674QgToSfloCSfg59PHErGUWBSjIcGLaQAYn6gfbXHNH1+ga2BmEQodpD5CcgqiyY3li
         //ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681377; x=1695286177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQQ8W7dTHfeE7O02ojs1+zPGe26GnI77MO8cdAMaFVo=;
        b=Gn+4EtcAA6yC+1T7oQBaSsd21DN19mlyDtHxVOICjcwmuVurhuilf+/Iq71zm62ocg
         CXdotnoVDDrKwk1xjlcB2JEBljKk6OffgtlSsr8EwdjgwG3xTvDV3vDNoHcX3evpcRiG
         J8OldfuRQkJTddI402Zux31KO6daZs4j3EfA13spZOVvc/wuZ9dHvi9RYl6VbV3Tj2+t
         3EtOUV+37SWkbOfsVkJtRae9vKj3tN7WuGYzUuVV35hQzmh6Sjd1eE1BcNdzYMpESyX5
         joUY7/w+tfz2PZFvGTJ0JuuWvDb4kYRDTfUgNdFvD1Fq855ROsJV92vDpqDfJ0kAsqkz
         fazQ==
X-Gm-Message-State: AOJu0YzTTcsqnnQqUb6mIyPfOL4PazD6hULWuUiZawml7HCUuItjSQ7e
	VbNrzIQLAO0B+b//FtDdGzA=
X-Google-Smtp-Source: AGHT+IF5SXhNnxNzthytQqVeGTI78oCvUz6+CAlrpKtiPX4lO+Zt749afV6OZXgpRQRzPl8B9m+dbw==
X-Received: by 2002:a05:600c:1c86:b0:401:d8a4:17b0 with SMTP id k6-20020a05600c1c8600b00401d8a417b0mr4087573wms.2.1694681377583;
        Thu, 14 Sep 2023 01:49:37 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 07/10] selftests/xsk: add option to run single test
Date: Thu, 14 Sep 2023 10:48:54 +0200
Message-ID: <20230914084900.492-8-magnus.karlsson@gmail.com>
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

Add a command line option to be able to run a single test. This option
(-t) takes a number from the list of tests available with the "-l"
option. Here are two examples:

Run test number 2, the "receive single packet" test in all available modes:

./test_xsk.sh -t 2

Run test number 21, the metadata copy test in skb mode only

./test_xsh.sh -t 21 -m skb

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh  | 10 ++++-
 tools/testing/selftests/bpf/xskxceiver.c | 56 +++++++++++++++---------
 tools/testing/selftests/bpf/xskxceiver.h |  3 ++
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index cb215a83b622..296006ea6e9c 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -79,12 +79,15 @@
 #
 # List available tests
 #   ./test_xsk.sh -l
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
@@ -92,6 +95,7 @@ do
 		i) ETH=${OPTARG};;
 		m) MODE=${OPTARG};;
 		l) list=1;;
+		t) TEST=${OPTARG};;
 	esac
 done
 
@@ -170,6 +174,10 @@ if [ -n "$MODE" ]; then
 	ARGS+="-m ${MODE} "
 fi
 
+if [ -n "$TEST" ]; then
+	ARGS+="-t ${TEST} "
+fi
+
 retval=$?
 test_status $retval "${TEST_NAME}"
 
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 289fae654bab..fba42edc3961 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -110,6 +110,7 @@ static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
 static bool opt_verbose;
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
+static u32 opt_run_test = RUN_ALL_TESTS;
 
 static void __exit_with_error(int error, const char *file, const char *func, int line)
 {
@@ -316,10 +317,11 @@ static struct option long_options[] = {
 	{"verbose", no_argument, 0, 'v'},
 	{"mode", required_argument, 0, 'm'},
 	{"list", no_argument, 0, 'l'},
+	{"test", required_argument, 0, 't'},
 	{0, 0, 0, 0}
 };
 
-static void usage(const char *prog)
+static void print_usage(char **argv)
 {
 	const char *str =
 		"  Usage: xskxceiver [OPTIONS]\n"
@@ -328,9 +330,11 @@ static void usage(const char *prog)
 		"  -v, --verbose        Verbose output\n"
 		"  -b, --busy-poll      Enable busy poll\n"
 		"  -m, --mode           Run only mode skb, drv, or zc\n"
-		"  -l, --list           List all available tests\n";
+		"  -l, --list           List all available tests\n"
+		"  -t, --test           Run a specific test. Enter number from -l option.\n";
 
-	ksft_print_msg(str, prog);
+	ksft_print_msg(str, basename(argv[0]));
+	ksft_exit_xfail();
 }
 
 static bool validate_interface(struct ifobject *ifobj)
@@ -350,7 +354,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "i:vbm:l", long_options, &option_index);
+		c = getopt_long(argc, argv, "i:vbm:lt:", long_options, &option_index);
 		if (c == -1)
 			break;
 
@@ -380,23 +384,26 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			ifobj_rx->busy_poll = true;
 			break;
 		case 'm':
-			if (!strncmp("skb", optarg, strlen(optarg))) {
+			if (!strncmp("skb", optarg, strlen(optarg)))
 				opt_mode = TEST_MODE_SKB;
-			} else if (!strncmp("drv", optarg, strlen(optarg))) {
+			else if (!strncmp("drv", optarg, strlen(optarg)))
 				opt_mode = TEST_MODE_DRV;
-			} else if (!strncmp("zc", optarg, strlen(optarg))) {
+			else if (!strncmp("zc", optarg, strlen(optarg)))
 				opt_mode = TEST_MODE_ZC;
-			} else {
-				usage(basename(argv[0]));
-				ksft_exit_xfail();
-			}
+			else
+				print_usage(argv);
 			break;
 		case 'l':
 			opt_print_tests = true;
 			break;
+		case 't':
+			errno = 0;
+			opt_run_test = strtol(optarg, NULL, 0);
+			if (errno)
+				print_usage(argv);
+			break;
 		default:
-			usage(basename(argv[0]));
-			ksft_exit_xfail();
+			print_usage(argv);
 		}
 	}
 }
@@ -2327,8 +2334,8 @@ int main(int argc, char **argv)
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
+	u32 i, j, failed_tests = 0, nb_tests;
 	int modes = TEST_MODE_SKB + 1;
-	u32 i, j, failed_tests = 0;
 	struct test_spec test;
 	bool shared_netdev;
 
@@ -2350,15 +2357,17 @@ int main(int argc, char **argv)
 		print_tests();
 		ksft_exit_xpass();
 	}
+	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= ARRAY_SIZE(tests)) {
+		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
+		ksft_exit_xfail();
+	}
 
 	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
 	ifobj_tx->shared_umem = shared_netdev;
 	ifobj_rx->shared_umem = shared_netdev;
 
-	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx)) {
-		usage(basename(argv[0]));
-		ksft_exit_xfail();
-	}
+	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx))
+		print_usage(argv);
 
 	if (is_xdp_supported(ifobj_tx->ifindex)) {
 		modes++;
@@ -2377,8 +2386,12 @@ int main(int argc, char **argv)
 	test.tx_pkt_stream_default = tx_pkt_stream_default;
 	test.rx_pkt_stream_default = rx_pkt_stream_default;
 
+	if (opt_run_test == RUN_ALL_TESTS)
+		nb_tests = ARRAY_SIZE(tests);
+	else
+		nb_tests = 1;
 	if (opt_mode == TEST_MODE_ALL) {
-		ksft_set_plan(modes * ARRAY_SIZE(tests));
+		ksft_set_plan(modes * nb_tests);
 	} else {
 		if (opt_mode == TEST_MODE_DRV && modes <= TEST_MODE_DRV) {
 			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
@@ -2389,7 +2402,7 @@ int main(int argc, char **argv)
 			ksft_exit_xfail();
 		}
 
-		ksft_set_plan(ARRAY_SIZE(tests));
+		ksft_set_plan(nb_tests);
 	}
 
 	for (i = 0; i < modes; i++) {
@@ -2397,6 +2410,9 @@ int main(int argc, char **argv)
 			continue;
 
 		for (j = 0; j < ARRAY_SIZE(tests); j++) {
+			if (opt_run_test != RUN_ALL_TESTS && j != opt_run_test)
+				continue;
+
 			test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
 			run_pkt_test(&test);
 			usleep(USLEEP_MAX);
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
2.42.0


