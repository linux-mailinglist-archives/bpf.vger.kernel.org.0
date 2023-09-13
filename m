Return-Path: <bpf+bounces-9893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05A079E5C2
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69A5282386
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7961F175;
	Wed, 13 Sep 2023 11:03:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761E1F16E;
	Wed, 13 Sep 2023 11:03:24 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8819AD;
	Wed, 13 Sep 2023 04:03:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f7c87353eso777073f8f.0;
        Wed, 13 Sep 2023 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694603002; x=1695207802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dY+HZwfvKK7Hm1OJ9V4uwvNoNR0PsppLgxDH8qqbdM8=;
        b=maQEl9AkkLjfJyO+Ba+aPBYu3XeWgiL+lxEkjgU8vXJ2VmpAxptuUXWX8mXt84Mo7E
         nTeEeTC7Qy87fXOhkzkq5rUaUVnCDLrR9m2rn1COvHRATNO+0SX/5Bq8sTw0wfmAsUaT
         EZb6vs1qzJvbFOwZfBldWedCJV31V9gr2i8O1j8GhxKptK/PgcH7w5c4xZ+7DGfmV5E7
         VD70j83LotmL7IyF87Pt6EzOY5lk08d0/u55JOGRG/VanDoeTqyzSU70OeTKR8PReXGK
         71IslZYde6ChljgdbAyq49rT1L0liCN+zvrQ2XODpfWHPPuRpGWL7vDZy1Wt10XpqIPl
         23dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694603002; x=1695207802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY+HZwfvKK7Hm1OJ9V4uwvNoNR0PsppLgxDH8qqbdM8=;
        b=vZxE9icJYPWxLfkbcvIVzimyUXo1Ypgp8bkc1NUknCaHhihDMsnGUoYGHPlgsY2Qqg
         em+DXL1JJaIG01GoBmn95ZbmIK9jvFWm8l9TDe9HIOmM6nNc1pQzRjjdOxxjqMWfPFve
         61pbQOLhu0yj6dq64C/cg7e3MmqYGQHg4LnaKbvoEWPdmf58P2/9jp8OTd9NOF6FCwMr
         Y51mhhkze5uAnrpqtDGwaGSf3aBTrCg/t4XW4plPLEl/B1d+ACnTEyEVq9GBpC3M1lo6
         K0rkOoqJ1lUyXYzR35syD6ad8yjwGZk9LRFKx4+4QO1UtiW+dbzel9Md1SVV5YL1NJ3j
         o6lA==
X-Gm-Message-State: AOJu0YzxwpUIqqJBkaiAKLUp9vX3Z8Eg9SgQSKOK7cRZaYLYFneO9aIj
	NW8k56VPtf3vEI6LmvirCJM=
X-Google-Smtp-Source: AGHT+IEdhdlkIAOC6ClDMrP+pa9SJhjHpsY7lRQ6PWpydv63Scx0GYWNjVik2oAAhKgrH2C5iTQr1w==
X-Received: by 2002:adf:e80a:0:b0:31f:84c9:d75f with SMTP id o10-20020adfe80a000000b0031f84c9d75fmr1633790wrm.4.1694603002442;
        Wed, 13 Sep 2023 04:03:22 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm15255289wrv.111.2023.09.13.04.03.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:03:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 06/10] selftests/xsk: add option that lists all tests
Date: Wed, 13 Sep 2023 13:02:28 +0200
Message-ID: <20230913110248.30597-7-magnus.karlsson@gmail.com>
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
 tools/testing/selftests/bpf/test_xsk.sh    | 15 +++++++++++++-
 tools/testing/selftests/bpf/xsk_prereqs.sh | 10 +++++----
 tools/testing/selftests/bpf/xskxceiver.c   | 24 ++++++++++++++++++++--
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 85e7a7e843f7..cb215a83b622 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -76,18 +76,22 @@
 #
 # Run test suite in a specific mode only [skb,drv,zc]
 #   sudo ./test_xsk.sh -m MODE
+#
+# List available tests
+#   ./test_xsk.sh -l
 
 . xsk_prereqs.sh
 
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
 
@@ -135,6 +139,11 @@ setup_vethPairs() {
 	ip link set ${VETH0} up
 }
 
+if [[ $list -eq 1 ]]; then
+        ./${XSKOBJ} -l
+        exit
+fi
+
 if [ ! -z $ETH ]; then
 	VETH0=${ETH}
 	VETH1=${ETH}
@@ -183,6 +192,10 @@ else
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
2.42.0


