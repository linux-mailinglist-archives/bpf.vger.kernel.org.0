Return-Path: <bpf+bounces-9890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9426379E5B8
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CB62821AD
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC871EA7D;
	Wed, 13 Sep 2023 11:03:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78E1EA72;
	Wed, 13 Sep 2023 11:03:19 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D03219A6;
	Wed, 13 Sep 2023 04:03:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f8ddc349bso534838f8f.1;
        Wed, 13 Sep 2023 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694602997; x=1695207797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Pi680Wj7G553Tfv0OcwqtudV7EOV/EVjwhaEfJCihA=;
        b=iTCk722up/WKZvRIqvzXi1sgOuic+Lr0ZEjJqdcfv+LyMpKcAbbSLKdm3f7eiSHCIm
         fDRTaGiSWZADzmdZWkHxmLl7kyKDcEyR5r7grZ19nBOUGU39I/1g4Y/5ghs/7RvTbw0+
         f7erf1sENQOp6T9dvTvYRs4HWZ0QJ2yAzyqIXQfEbXSHG8mQ407TyXJ0ITNp0SvUot/s
         y+Dc4ZLklDS8FQKoD/PvzA0FM/TLpHB0RBV/28acgiTVOqumiStd0tUNj9ndCHtvfeOG
         m6XpcP1V8Aeh+RyC+yKxrmmG3x9YYrsrlJ+DODPG9K4k1K1qaALhNjAetaRH5FjXb9to
         o5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602997; x=1695207797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Pi680Wj7G553Tfv0OcwqtudV7EOV/EVjwhaEfJCihA=;
        b=VRI7Iwm4fgWSelRa05cFP6u+f2mxZLA9WKrUoODz1M2EyrfDR7bivK1f2FQRmz+oro
         SJFo1/0UiEjSfBe6bEA3sJSW0mMNkHwwJSbc8G7c0ZtOc2EJ+365kD4q9vgHy16Tj7TT
         S6mNOem867Z38d0shLOzyrwhIIX3gHutlAQPg0ldf0A2HG5+oUFJXx8HuFFKlFa+8WR8
         /FFXnZIoP3Nu1jaHshbgNWa11S8+xZJHuZIthlZqbF3BgKgOJ66iw36EFuHb/hs4+OO1
         w9zSaJI8S/rPrfUXupGCdxhsVjsueAvliPoAOBYyvUsxYcvvYsINs8tSvnkBDptC7yBo
         ktXA==
X-Gm-Message-State: AOJu0Yybfm/FyCTQA337v+AYc3i3Qmq0pMTT/DR2PSsijMJGfQVOVSvc
	fIbMcfWfj3ajcK0poAvc4zo=
X-Google-Smtp-Source: AGHT+IFL7nj4qWGhsG5I9UDE6OlpJRamQ09EX0x6Ft12Qjxa4/v/RZXZIJ5cG6yclkS8W3j5XSJQOQ==
X-Received: by 2002:adf:f98a:0:b0:31f:a096:6e18 with SMTP id f10-20020adff98a000000b0031fa0966e18mr1651539wrr.6.1694602996877;
        Wed, 13 Sep 2023 04:03:16 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm15255289wrv.111.2023.09.13.04.03.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:03:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 03/10] selftests/xsk: add option to only run tests in a single mode
Date: Wed, 13 Sep 2023 13:02:25 +0200
Message-ID: <20230913110248.30597-4-magnus.karlsson@gmail.com>
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
index 2aa5a3445056..85e7a7e843f7 100755
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
+		m) MODE=${OPTARG};;
 	esac
 done
 
@@ -153,6 +157,10 @@ if [[ $verbose -eq 1 ]]; then
 	ARGS+="-v "
 fi
 
+if [ -n "$MODE" ]; then
+	ARGS+="-m ${MODE} "
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
2.42.0


