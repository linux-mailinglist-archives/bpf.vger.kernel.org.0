Return-Path: <bpf+bounces-9989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B779FF37
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE381F21C42
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2120B26;
	Thu, 14 Sep 2023 08:49:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB520B0B;
	Thu, 14 Sep 2023 08:49:38 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EEA91;
	Thu, 14 Sep 2023 01:49:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401e6ce2d9fso2038085e9.1;
        Thu, 14 Sep 2023 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681376; x=1695286176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uHwZUh1Pqwr68CzPSNrcu026ql9RF+nbsIeT6rz6gM=;
        b=V2Dt47hYtLnX+hsrkd5PjkdPGR5+br8YX0UDYcr9kawTD9N9chGiqpIvpnHEagWms4
         4Y8nY21vNzWizvTtstV97E3aKI5CdokY7Q/xe/wYkRZ/2dpLdn4EpnoqPvyCWMkqGWtW
         zCTMFADCdrGG2i58B7ZKEetrOG55AUyve1vlXU68HAIA5i/PYtolpgRtsKaAS65opqku
         lXppTJKxcPhnF4DHo0CNtUkWECSVvmQ+RW7b9hv+YHYilsKi67rHJsOVWyHrZzd5rCaD
         TRQLn9gzjjqFwBqFdeD8W7Scd7CaLEUHGdsAzo0spLT+fmx5xsaTz3T6vmqbBjq1r4aE
         muTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681376; x=1695286176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uHwZUh1Pqwr68CzPSNrcu026ql9RF+nbsIeT6rz6gM=;
        b=qthRGpzKaIJgdtVSxxWFEGCEwQUr9bhzusnDsum4M50dzbxHFyHACY5CsWxV2YWAfz
         UUyeQhcQqMQyXYLZJKfI0UFpfTC5LOazvER4JK7REPPqnGMZNlrha18tGqpkYgvfBDn3
         PfEEtSxwa1IEGUX3n52OkgYThLpAs3M1872lD4Lq6VXeoPb3ubaPD1nxX5AIKMH8PCLv
         X1ntYXJpicUTTY5L41UMhABJMvgeJGQKGAySDYP31nfTBEBYcNRYywceBDWBWnLVsMl6
         M1KIIYf9HshbLN0kLw08FxadHxlT69aJGO1D0Q+laZbVeFjiLyJYvAB73uOg2HLkZgDG
         KdwA==
X-Gm-Message-State: AOJu0YyUtF3Yqdb0OE++nNXBtyHoN+0/siTztALarBimwKi2VzHw3ofD
	r4LKGeCNyuYw1ZdI3e24S5Y=
X-Google-Smtp-Source: AGHT+IH/P/9hmXj6C4I8kB1UbNonO3gyI196GiWgC3Wc94TrpHxKklhiN8DNNsYgSuyot2e0F8+yiA==
X-Received: by 2002:a05:600c:1d26:b0:3fe:21a6:a18 with SMTP id l38-20020a05600c1d2600b003fe21a60a18mr4186926wms.3.1694681375793;
        Thu, 14 Sep 2023 01:49:35 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 06/10] selftests/xsk: add option that lists all tests
Date: Thu, 14 Sep 2023 10:48:53 +0200
Message-ID: <20230914084900.492-7-magnus.karlsson@gmail.com>
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
index 38d4c036060d..289fae654bab 100644
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
 
@@ -388,6 +391,9 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 				ksft_exit_xfail();
 			}
 			break;
+		case 'l':
+			opt_print_tests = true;
+			break;
 		default:
 			usage(basename(argv[0]));
 			ksft_exit_xfail();
@@ -2307,6 +2313,15 @@ static const struct test_spec tests[] = {
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
@@ -2331,6 +2346,11 @@ int main(int argc, char **argv)
 
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


