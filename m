Return-Path: <bpf+bounces-7355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00995775F98
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246B91C2120C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2EB18C21;
	Wed,  9 Aug 2023 12:44:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C910E18C1A;
	Wed,  9 Aug 2023 12:44:30 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13E19A1;
	Wed,  9 Aug 2023 05:44:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso846626f8f.1;
        Wed, 09 Aug 2023 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585068; x=1692189868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl0MWdj1q8FpSjpCmsSntZu6I7OhmqGQSjhOB79B9DE=;
        b=NATcmFkmXbmvXYiUDRcR2BlKp2IBPSN++BqJ5sbWuc9C8qtCpRn8eoFqjyFkCg+gPm
         841Cvz07aTqnFdd6lih+n9GOqnwXMcVDlTa19VIXz5EvwIvlzI7RMoCDIP6CtnsFx9FL
         o6gYgaST39Ff12xTOTxFs/urbZYwBUh08mepnI60aqPqEl7vAq7GvLO91DyJC4vXl/Qz
         slWL6VXNGsc6HALDqS7KfASx+uy7sMu6niRI6zsi/DZlHMcv+QGfNzOHFoA076Uuhmpu
         Q9jkgyy54NV/o4+gZXf9LPzYg9kkdGY3NMameGQI953ZLUcZx1FI87HTSOdajQsPSwhA
         dh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585068; x=1692189868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl0MWdj1q8FpSjpCmsSntZu6I7OhmqGQSjhOB79B9DE=;
        b=ic1PHhCVdnXk41wqvUEyU/yGuaOnF0aMwddXl8Fqetv3yY5DwruCkDP6E5Y4U40U3M
         YVNw+tLZsepV/Vl+emX1Ey6dp3uVoB4r4JOcHY7XdUiPQCAs9is6N5fgSW+vhcxS4+iw
         urUtr5wqdu01Mtfuei067PYe3sq3s/0Yi2wWBiMERRQAhmAGSCY9PXuJYDJzYgaywwjC
         v3/kwcIfzv6ZQ24B5l9PSJ78MFoG2pbRo5fa5SMR3xc0pv1oSvAVlU3Nc2PzYpv73Xhy
         DRnR9aHgzkxXWH+whb6YjX4nA64H8Yz8jwhqun2bcLtQ30SfXx9BP3Po+7dkbBDmMYQa
         JL1Q==
X-Gm-Message-State: AOJu0Yw7yFXZCRDDkEhqckRySRA8CthqIBUf+rgG70xIK4CNQ8fC1vQ9
	7vDxTmq9yoH3tgJfBgVeBrg=
X-Google-Smtp-Source: AGHT+IGj3hzVo6ThAIpchxXdT5uhRV/HPqMeQFhr3hzCfVCBSqZ8yRT5UUfqCs2CWJ1luIKz69uYfQ==
X-Received: by 2002:a5d:538a:0:b0:317:7238:336a with SMTP id d10-20020a5d538a000000b003177238336amr1499133wrv.5.1691585067729;
        Wed, 09 Aug 2023 05:44:27 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:27 -0700 (PDT)
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
Subject: [PATCH bpf-next 06/10] selftests/xsk: add option that lists all tests
Date: Wed,  9 Aug 2023 14:43:39 +0200
Message-Id: <20230809124343.12957-7-magnus.karlsson@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Add a command line option (-l) that lists all the tests. The number
before the test will be used in the next commit for specifying a
single test to run. Here is an example of the output:

Tests:
0: SEND_RECEIVE
1: SEND_RECEIVE_2K_FRAME
2: SEND_RECEIVE_SINGLE_PKT
3: POLL_RX
4: POLL_TX
5: POLL_RXQ_FULL
6: POLL_TXQ_FULL
7: SEND_RECEIVE_UNALIGNED
:
:

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh    | 11 +++++++++-
 tools/testing/selftests/bpf/xsk_prereqs.sh | 10 +++++----
 tools/testing/selftests/bpf/xskxceiver.c   | 24 ++++++++++++++++++++--
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 4ec621f4d3db..00a504f0929a 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -81,13 +81,14 @@
 
 ETH=""
 
-while getopts "vi:dm:" flag
+while getopts "vi:dm:l" flag
 do
 	case "${flag}" in
 		v) verbose=1;;
 		d) debug=1;;
 		i) ETH=${OPTARG};;
 		m) MODE=${OPTARG};;
+		l) list=1;;
 	esac
 done
 
@@ -157,6 +158,10 @@ if [[ $verbose -eq 1 ]]; then
 	ARGS+="-v "
 fi
 
+if [[ $list -eq 1 ]]; then
+	ARGS+="-l "
+fi
+
 if [ ! -z $MODE ]; then
 	ARGS+="-m ${MODE} "
 fi
@@ -183,6 +188,10 @@ else
 	cleanup_iface ${ETH} ${MTU}
 fi
 
+if [[ $list -eq 1 ]]; then
+    exit
+fi
+
 TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
 busy_poll=1
 
diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/bpf/xsk_prereqs.sh
index 29175682c44d..47c7b8064f38 100755
--- a/tools/testing/selftests/bpf/xsk_prereqs.sh
+++ b/tools/testing/selftests/bpf/xsk_prereqs.sh
@@ -83,9 +83,11 @@ exec_xskxceiver()
 	fi
 
 	./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}
-
 	retval=$?
-	test_status $retval "${TEST_NAME}"
-	statusList+=($retval)
-	nameList+=(${TEST_NAME})
+
+	if [[ $list -ne 1 ]]; then
+	    test_status $retval "${TEST_NAME}"
+	    statusList+=($retval)
+	    nameList+=(${TEST_NAME})
+	fi
 }
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index b1d0c69f21b8..a063b9af7fff 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -108,6 +108,7 @@ static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
 static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
 
 static bool opt_verbose;
+static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
 
 static void __exit_with_error(int error, const char *file, const char *func, int line)
@@ -314,6 +315,7 @@ static struct option long_options[] = {
 	{"busy-poll", no_argument, 0, 'b'},
 	{"verbose", no_argument, 0, 'v'},
 	{"mode", required_argument, 0, 'm'},
+	{"list", no_argument, 0, 'l'},
 	{0, 0, 0, 0}
 };
 
@@ -325,7 +327,8 @@ static void usage(const char *prog)
 		"  -i, --interface      Use interface\n"
 		"  -v, --verbose        Verbose output\n"
 		"  -b, --busy-poll      Enable busy poll\n"
-		"  -m, --mode           Run only mode skb, drv, or zc\n";
+		"  -m, --mode           Run only mode skb, drv, or zc\n"
+		"  -l, --list           List all available tests\n";
 
 	ksft_print_msg(str, prog);
 }
@@ -347,7 +350,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "i:vbm:", long_options, &option_index);
+		c = getopt_long(argc, argv, "i:vbm:l", long_options, &option_index);
 		if (c == -1)
 			break;
 
@@ -391,6 +394,9 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 				ksft_exit_xfail();
 			}
 			break;
+		case 'l':
+			opt_print_tests = true;
+			break;
 		default:
 			usage(basename(argv[0]));
 			ksft_exit_xfail();
@@ -2310,6 +2316,15 @@ static const struct test_spec tests[] = {
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 };
 
+static void print_tests(void)
+{
+	u32 i;
+
+	printf("Tests:\n");
+	for (i = 0; i < ARRAY_SIZE(tests); i++)
+		printf("%u: %s\n", i, tests[i].name);
+}
+
 int main(int argc, char **argv)
 {
 	struct pkt_stream *rx_pkt_stream_default;
@@ -2334,6 +2349,11 @@ int main(int argc, char **argv)
 
 	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
 
+	if (opt_print_tests) {
+		print_tests();
+		ksft_exit_xpass();
+	}
+
 	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
 	ifobj_tx->shared_umem = shared_netdev;
 	ifobj_rx->shared_umem = shared_netdev;
-- 
2.34.1


