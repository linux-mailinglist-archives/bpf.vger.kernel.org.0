Return-Path: <bpf+bounces-8469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF0786F26
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B841C20E39
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530713AF8;
	Thu, 24 Aug 2023 12:29:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD29413AE1;
	Thu, 24 Aug 2023 12:29:53 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86219AD;
	Thu, 24 Aug 2023 05:29:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fef6cee938so5161245e9.0;
        Thu, 24 Aug 2023 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880186; x=1693484986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRDBfM7pnU+yFu+VLjEVOoLbPT7nBZRhYTkI8qOiIo0=;
        b=NKgyAY4Wh0cj/z6hSqB4FN9OxLGazqJN9p1bWvICqXUQFxrt8WFl717uH20SYaRd4D
         a/nYtIirSj9ClkbAvOpKXsJEWmpr7rIyzL2ozinzce3GbHxgKPGVDE9irRsVFzD83XNv
         ub6VOURY4QUoxGN6FjG6FLJ9Cq4X9oZq2JL7+dC3kIG8EFyLkZzcipXipoIzMF+7ZNRV
         81rMxiygMscDzJfdLj9VwypTzcftZ9/bt4WZZbL5rKRBZPuYqy8j0aVl+pdzmMdG2FXW
         kJmWx2hmkE08jE5RyjsXlCNXiNiNVN/Y7hJEsMvkdNrJGZkxxN6REpp8mafbqYOq62fp
         iXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880186; x=1693484986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRDBfM7pnU+yFu+VLjEVOoLbPT7nBZRhYTkI8qOiIo0=;
        b=WOwfa0Iy13XQuvL72ZSP+07sEI0JCmzWeJmOPFgzmMQHGihqoJz15HVOiYf1mvKhei
         8YG5PgtAqThDQgWM88A3DBH2Hg84Dg7Lt3FQCCVthPgZfwXSLCeG29k1omBvfsc4re2Y
         6QQuxDOJr06F6XjxaB8IzaOcWZaOY9yPHx9KRpNK8mjVvzxhurHvMgm4qNUZflSRG94F
         l0lEArVh3zAcn0236ljiGkwjDmky+8ysKw6XQgVMXbATZWAzRkRsQ8OFAhbkR4VfvH6/
         uOiVjvmPAzbWn9eZagn299HdL5ObXgpoUzDX3r5Xnualc6GAMJ3Z4OP3OiIyvkQSfRAU
         qj6w==
X-Gm-Message-State: AOJu0YyqBwLmAXnxPLjcardkU+1ihBUKHiI8i+DKBW5HYl/oykiGvwq5
	aJmAaAjCfH03FJWekEVg5uQ=
X-Google-Smtp-Source: AGHT+IFgF4mfvfT0G7xpzqENneBhwm1QJ3xaP9cAQ5CQZCMaUEnlSzk/xEwHyAVsGz7twwtDpEwiPw==
X-Received: by 2002:a05:600c:15c2:b0:3fb:aadc:41dc with SMTP id v2-20020a05600c15c200b003fbaadc41dcmr12258442wmf.4.1692880185839;
        Thu, 24 Aug 2023 05:29:45 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 06/11] selftests/xsk: add option that lists all tests
Date: Thu, 24 Aug 2023 14:28:48 +0200
Message-Id: <20230824122853.3494-7-magnus.karlsson@gmail.com>
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
index 5ae2b3c27e21..489101922984 100755
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
 		m) XSKTEST_MODE=${OPTARG};;
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
2.34.1


