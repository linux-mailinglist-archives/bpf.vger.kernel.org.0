Return-Path: <bpf+bounces-8466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C43786F10
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E741C20E45
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50712B6A;
	Thu, 24 Aug 2023 12:29:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4990125B1;
	Thu, 24 Aug 2023 12:29:43 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F6519AC;
	Thu, 24 Aug 2023 05:29:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fef244772bso8790345e9.1;
        Thu, 24 Aug 2023 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880179; x=1693484979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nq9HC5xtoW5L3fzV5f5SQ1zv2vYzduxNQ5l0XN5JAgA=;
        b=Dc4j0HP7ACE5uuaqYZ6K1FJPq00PmbiDeWVyqQTvmcomFMQd0+3KJEap8aAHKVUwg2
         t5DGIdYWkhSdnjFAdgEY2Ckr+CsWnTyCCxh8Em6MXdbw6BFzdJgBVuKBfVWE28LTjoWI
         ESvGYAPUagEeEsG/6F9/4II8lFSB6PjwKfTHnzIgvGFimJheauQ7a+tNRnlfQlonOTup
         rYOSVu5KcSKqdtCLkQ5aKcAz1gjwsDdWI7Hx0UfiOLGv/yiOVb9aAkGB4bf7+aJas0r0
         wm6DO82nxJV7i/zffRlPy1aat8/h3WiqUxYJ9gcWhuAwsgw905f8XTzc8jAdoO382AdI
         EyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880179; x=1693484979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq9HC5xtoW5L3fzV5f5SQ1zv2vYzduxNQ5l0XN5JAgA=;
        b=cRDPybjgL8Aq2CFyG0VQfNJh694iWijhgQC0RaerNaOr+2NLWizSH9SQRwYLNze4eD
         VcyUDzLnNWAvpuK/pgZDU013GUdePBXFCyQNob9h6Az/K9YpeumqzbnflicDgwt4CV12
         1xsT4CQi5Ne+POfrzmGLC+J8U5OSCZH/7n3d3iagtn7VwifL30bhKCjwWvA5YGahtCk5
         U3RnrYVp+Lmn73GCwHqSnpacDYOkeRhR4pBE2l7g7KRjws1VkJzauSnaGgQE8ziCLJdh
         ADbgW/NeLTV5sq2EEwK1Uux/YbqJuRcK6p/BrT1jidOT4SXzchC2aDXCpgUStAv3aBq2
         baYA==
X-Gm-Message-State: AOJu0Yx4Tk7Jfg1gy+NVuesipLLxHBh5CgfuEOeqc7poGigL4ByTVNq2
	+gKeXHn665WltTW5S++xZZo=
X-Google-Smtp-Source: AGHT+IGkstmLkJ+piuAl1doQ2N0I55quuEAcvsV9aIZzHY/yZFdt8ZG/WoEA3MdOrDuxVI6NQQHTNQ==
X-Received: by 2002:a05:600c:3d1a:b0:3fe:4d2d:f79b with SMTP id bh26-20020a05600c3d1a00b003fe4d2df79bmr12680632wmb.4.1692880178728;
        Thu, 24 Aug 2023 05:29:38 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 03/11] selftests/xsk: add option to only run tests in a single mode
Date: Thu, 24 Aug 2023 14:28:45 +0200
Message-Id: <20230824122853.3494-4-magnus.karlsson@gmail.com>
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

Add an option -m on the command line that allows the user to run the
tests in a single mode instead of all of them. Valid modes are skb,
drv, and zc (zero-copy). An example:

To run test suite in drv mode only:

./test_xsk.sh -m drv

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh  | 10 ++++++-
 tools/testing/selftests/bpf/xskxceiver.c | 34 +++++++++++++++++++++---
 tools/testing/selftests/bpf/xskxceiver.h |  4 +--
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 2aa5a3445056..5ae2b3c27e21 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -73,17 +73,21 @@
 #
 # Run test suite for physical device in loopback mode
 #   sudo ./test_xsk.sh -i IFACE
+#
+# Run test suite in a specific mode only [skb,drv,zc]
+#   sudo ./test_xsk.sh -m MODE
 
 . xsk_prereqs.sh
 
 ETH=""
 
-while getopts "vi:d" flag
+while getopts "vi:dm:" flag
 do
 	case "${flag}" in
 		v) verbose=1;;
 		d) debug=1;;
 		i) ETH=${OPTARG};;
+		m) XSKTEST_MODE=${OPTARG};;
 	esac
 done
 
@@ -153,6 +157,10 @@ if [[ $verbose -eq 1 ]]; then
 	ARGS+="-v "
 fi
 
+if [ -n "$XSKTEST_MODE" ]; then
+	ARGS+="-m ${XSKTEST_MODE} "
+fi
+
 retval=$?
 test_status $retval "${TEST_NAME}"
 
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 514fe994e02b..9f79c2b6aa97 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -107,6 +107,9 @@
 static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
 static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
 
+static bool opt_verbose;
+static enum test_mode opt_mode = TEST_MODE_ALL;
+
 static void __exit_with_error(int error, const char *file, const char *func, int line)
 {
 	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error,
@@ -310,17 +313,19 @@ static struct option long_options[] = {
 	{"interface", required_argument, 0, 'i'},
 	{"busy-poll", no_argument, 0, 'b'},
 	{"verbose", no_argument, 0, 'v'},
+	{"mode", required_argument, 0, 'm'},
 	{0, 0, 0, 0}
 };
 
 static void usage(const char *prog)
 {
 	const char *str =
-		"  Usage: %s [OPTIONS]\n"
+		"  Usage: xskxceiver [OPTIONS]\n"
 		"  Options:\n"
 		"  -i, --interface      Use interface\n"
 		"  -v, --verbose        Verbose output\n"
-		"  -b, --busy-poll      Enable busy poll\n";
+		"  -b, --busy-poll      Enable busy poll\n"
+		"  -m, --mode           Run only mode skb, drv, or zc\n";
 
 	ksft_print_msg(str, prog);
 }
@@ -342,7 +347,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "i:vb", long_options, &option_index);
+		c = getopt_long(argc, argv, "i:vbm:", long_options, &option_index);
 		if (c == -1)
 			break;
 
@@ -371,6 +376,21 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			ifobj_tx->busy_poll = true;
 			ifobj_rx->busy_poll = true;
 			break;
+		case 'm':
+			if (!strncmp("skb", optarg, min_t(size_t, strlen(optarg),
+							  strlen("skb")))) {
+				opt_mode = TEST_MODE_SKB;
+			} else if (!strncmp("drv", optarg, min_t(size_t, strlen(optarg),
+								 strlen("drv")))) {
+				opt_mode = TEST_MODE_DRV;
+			} else if (!strncmp("zc", optarg, min_t(size_t, strlen(optarg),
+								strlen("zc")))) {
+				opt_mode = TEST_MODE_ZC;
+			} else {
+				usage(basename(argv[0]));
+				ksft_exit_xfail();
+			}
+			break;
 		default:
 			usage(basename(argv[0]));
 			ksft_exit_xfail();
@@ -2365,9 +2385,15 @@ int main(int argc, char **argv)
 	test.tx_pkt_stream_default = tx_pkt_stream_default;
 	test.rx_pkt_stream_default = rx_pkt_stream_default;
 
-	ksft_set_plan(modes * TEST_TYPE_MAX);
+	if (opt_mode == TEST_MODE_ALL)
+		ksft_set_plan(modes * TEST_TYPE_MAX);
+	else
+		ksft_set_plan(TEST_TYPE_MAX);
 
 	for (i = 0; i < modes; i++) {
+		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
+			continue;
+
 		for (j = 0; j < TEST_TYPE_MAX; j++) {
 			test_spec_init(&test, ifobj_tx, ifobj_rx, i);
 			run_pkt_test(&test, i, j);
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 233b66cef64a..1412492e9618 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -63,7 +63,7 @@ enum test_mode {
 	TEST_MODE_SKB,
 	TEST_MODE_DRV,
 	TEST_MODE_ZC,
-	TEST_MODE_MAX
+	TEST_MODE_ALL
 };
 
 enum test_type {
@@ -98,8 +98,6 @@ enum test_type {
 	TEST_TYPE_MAX
 };
 
-static bool opt_verbose;
-
 struct xsk_umem_info {
 	struct xsk_ring_prod fq;
 	struct xsk_ring_cons cq;
-- 
2.34.1


