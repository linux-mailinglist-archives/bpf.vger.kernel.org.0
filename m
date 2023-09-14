Return-Path: <bpf+bounces-9986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C3779FF0A
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7571F22803
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D25E15E85;
	Thu, 14 Sep 2023 08:49:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7615E86;
	Thu, 14 Sep 2023 08:49:33 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE2591;
	Thu, 14 Sep 2023 01:49:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40471c054f9so1123495e9.0;
        Thu, 14 Sep 2023 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681370; x=1695286170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK5IaVMY+rHXj+KD1BZtJfh+e5R9HCPBgHI5uuZgq6g=;
        b=Xk6vxrtHwHMMEtN/9TGe0PPQFoUA04faAeDUWAcxUfZfG1HoFJlKyMfpwDOlsm+ST9
         C9+1gfWUIqaSqOsbj1nz6Ci4tTtlCauB51+bXyjKsyvx81wsb2/JTg3daFFMr1xHvcfI
         kIrAeESb4tgBQ8N9wCkvHCF6IbJpKdFux9jQPvE3SGHjh4jCNVzYgAljYRdWywcjZrUS
         rziuGhyTjI4V0aQ3MJePL81lTz/rPMqpW8/p/Oubk8JyjrcNT7K8YlWsQYq4sogqdmDu
         skoBLZHU4Ho44z3SIPDJyHcfn/cYJetNtIAgWoYLoDOqLYQ2gV3MDtww9xw72aZWgE5o
         ztIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681370; x=1695286170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK5IaVMY+rHXj+KD1BZtJfh+e5R9HCPBgHI5uuZgq6g=;
        b=cSd6Gg0pRkniewXuzWa+7kdS541QFsyjnc70oHAB98nLO9jggSVCS2suJRi0bY/ecV
         Qp9r7+q/3P1i7xQUJ9S+H7XPDT1N6Cpv7pDID89mhvfsmmEzMPJU9JO66fcN2MmjtoD8
         EvNQ9/Qj1ZImgnHcyU7zP2Qp0ZmtKMamsn0iaHe/R/41jo2n6MaksNwb+H/ZB0SV1hbT
         gmp2jB9olb7uR4bbKRe7SHFxX5SwXESkY+5Y0DcW8s3zJAMq4V1JqVEXqBYCi5MpwCjg
         BC7u1oacIs4dc8VS6xX11KskZ/tf8ENdy+GVSGxLBa+1bd/ycHe4AFJJH9vgkXs0pvof
         o6bQ==
X-Gm-Message-State: AOJu0YzIJ845+IwfTPsWVrIhy3Fz4AJle3NXI9Tx6aqbcGq/dXS+5bL1
	0uoR63FxEerbzG+kuVS3LNc=
X-Google-Smtp-Source: AGHT+IHOk7iWBI8OJ67SpyOOwcSkVzagpvFn1aAKBbJa05HPSMnu7du9M4LXEwmfMmSGkB1ph6iJ7A==
X-Received: by 2002:a05:600c:5404:b0:401:b9fb:5acd with SMTP id he4-20020a05600c540400b00401b9fb5acdmr4145932wmb.3.1694681370434;
        Thu, 14 Sep 2023 01:49:30 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 03/10] selftests/xsk: add option to only run tests in a single mode
Date: Thu, 14 Sep 2023 10:48:50 +0200
Message-ID: <20230914084900.492-4-magnus.karlsson@gmail.com>
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

Add an option -m on the command line that allows the user to run the
tests in a single mode instead of all of them. Valid modes are skb,
drv, and zc (zero-copy). An example:

To run test suite in drv mode only:

./test_xsk.sh -m drv

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh  | 10 +++++-
 tools/testing/selftests/bpf/xskxceiver.c | 41 +++++++++++++++++++++---
 tools/testing/selftests/bpf/xskxceiver.h |  4 +--
 3 files changed, 47 insertions(+), 8 deletions(-)

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
index 514fe994e02b..64a671fca54a 100644
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
 
@@ -371,6 +376,18 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			ifobj_tx->busy_poll = true;
 			ifobj_rx->busy_poll = true;
 			break;
+		case 'm':
+			if (!strncmp("skb", optarg, strlen(optarg))) {
+				opt_mode = TEST_MODE_SKB;
+			} else if (!strncmp("drv", optarg, strlen(optarg))) {
+				opt_mode = TEST_MODE_DRV;
+			} else if (!strncmp("zc", optarg, strlen(optarg))) {
+				opt_mode = TEST_MODE_ZC;
+			} else {
+				usage(basename(argv[0]));
+				ksft_exit_xfail();
+			}
+			break;
 		default:
 			usage(basename(argv[0]));
 			ksft_exit_xfail();
@@ -2365,9 +2382,25 @@ int main(int argc, char **argv)
 	test.tx_pkt_stream_default = tx_pkt_stream_default;
 	test.rx_pkt_stream_default = rx_pkt_stream_default;
 
-	ksft_set_plan(modes * TEST_TYPE_MAX);
+	if (opt_mode == TEST_MODE_ALL) {
+		ksft_set_plan(modes * TEST_TYPE_MAX);
+	} else {
+		if (opt_mode == TEST_MODE_DRV && modes <= TEST_MODE_DRV) {
+			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
+			ksft_exit_xfail();
+		}
+		if (opt_mode == TEST_MODE_ZC && modes <= TEST_MODE_ZC) {
+			ksft_print_msg("Error: zero-copy mode not supported.\n");
+			ksft_exit_xfail();
+		}
+
+		ksft_set_plan(TEST_TYPE_MAX);
+	}
 
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


