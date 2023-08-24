Return-Path: <bpf+bounces-8470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF33A786F28
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48E22814B6
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72A14A81;
	Thu, 24 Aug 2023 12:29:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696514276;
	Thu, 24 Aug 2023 12:29:55 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714D198B;
	Thu, 24 Aug 2023 05:29:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fef6cee938so5161345e9.0;
        Thu, 24 Aug 2023 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880188; x=1693484988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4uN+lgxCSm7OqOec667C66GtGuDJIKL5++Lk9K2L2E=;
        b=QnW8smjaoQ9fLNcr3By921mfHPg/56vh0bOpfLmpB6lnzOaB3tNAb5tAOsbEDeB9fX
         wOMY9ELkX5tWxNK5gmNA23q/hCxF8pBTHlzg7YfjAwLE8YFtUNTsE+wf8wjUUHUA2zwe
         I6oIFfTR98tms/gGRTgMMCyYHq2TKESDaoR6PQBy2GINDMzY/bKtBrx+1Dy8mZTBamBO
         vXMIql3Mz/OS8UenjnOHbOR1EJgXtpUDyyBZHfSFwQxpItXbltB4l+Lopmclas+J5B7p
         ZREr3bgvVi9QmT0+CE1FrV0V67svK2oqb+/iGfnMzAavsIe7+2OFhBWnMNHyJC7t+riP
         5X/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880188; x=1693484988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4uN+lgxCSm7OqOec667C66GtGuDJIKL5++Lk9K2L2E=;
        b=WAgM+pkv/EQUH1tQjVVskgplrurHLA6DQaIPaJvk2gZ24ClCfhr60+PfFbvH1MOAih
         qEAGCl0WYDEZcHhxYzwLXnecNE1PBFHh53ObsMWYUxwpyjnUsworUMeb2nqpWI8mx+ae
         2P8ehtePY54QIFgWWmPqVAqNQS0vq6Ds6f0EnV9q/5kqjkrbhzRhXQQOf3dvADEhQWMs
         yGVkuOlBjp5MY0NnicULA4hVwGh7VlJhaV4YdROnSGIua1YEa7Y3kalrz+38qvsn1yIZ
         wV5w/rGRAi1mBcHkh0wdQAYNYqn5liibyh4tzkWdKv94ESqrELvmxHpkj/76O+kqhbFt
         OefA==
X-Gm-Message-State: AOJu0Ywr2IcKCl55sD7Wynl8DHEe65Yb4PVLrUAWxjm5QP6yA64E8Guf
	Nnrczx6ALnKNkUx5lyjPICY=
X-Google-Smtp-Source: AGHT+IG8qDI9/euS1D3A7HRsAKqYmJi10OKXR2hGl6kJAmivh0wzU0Fyxf5OuIvpSzrRjX8BQuqGKw==
X-Received: by 2002:a05:600c:15c2:b0:3fb:aadc:41dc with SMTP id v2-20020a05600c15c200b003fbaadc41dcmr12258530wmf.4.1692880188203;
        Thu, 24 Aug 2023 05:29:48 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 07/11] selftests/xsk: add option to run single test
Date: Thu, 24 Aug 2023 14:28:49 +0200
Message-Id: <20230824122853.3494-8-magnus.karlsson@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 tools/testing/selftests/bpf/test_xsk.sh  | 10 +++-
 tools/testing/selftests/bpf/xskxceiver.c | 58 ++++++++++++++++--------
 tools/testing/selftests/bpf/xskxceiver.h |  3 ++
 3 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 489101922984..b7186ae48497 100755
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
 		m) XSKTEST_MODE=${OPTARG};;
 		l) list=1;;
+		t) XSKTEST_TEST=${OPTARG};;
 	esac
 done
 
@@ -170,6 +174,10 @@ if [ -n "$XSKTEST_MODE" ]; then
 	ARGS+="-m ${XSKTEST_MODE} "
 fi
 
+if [ -n "$XSKTEST_TEST" ]; then
+	ARGS+="-t ${XSKTEST_TEST} "
+fi
+
 retval=$?
 test_status $retval "${TEST_NAME}"
 
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index a063b9af7fff..6eca5f95a3e0 100644
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
 
@@ -390,16 +394,20 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 								strlen("zc")))) {
 				opt_mode = TEST_MODE_ZC;
 			} else {
-				usage(basename(argv[0]));
-				ksft_exit_xfail();
+				print_usage(argv);
 			}
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
@@ -2330,8 +2338,8 @@ int main(int argc, char **argv)
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
+	u32 i, j, failed_tests = 0, nb_tests;
 	int modes = TEST_MODE_SKB + 1;
-	u32 i, j, failed_tests = 0;
 	struct test_spec test;
 	bool shared_netdev;
 
@@ -2353,15 +2361,17 @@ int main(int argc, char **argv)
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


