Return-Path: <bpf+bounces-7352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71136775F86
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B71C280F81
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8E118AFA;
	Wed,  9 Aug 2023 12:44:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D518008;
	Wed,  9 Aug 2023 12:44:20 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59419A1;
	Wed,  9 Aug 2023 05:44:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-317604e2bdfso1113617f8f.0;
        Wed, 09 Aug 2023 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585057; x=1692189857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bAc3FB/hA3X34MdDF0xzAaWT9uoxJ3Ja5Em+PxTX2U=;
        b=h+WKzNgYmXa4IfMolUuje8t7/84As6HS/r5wXmu41AfSRgQT9Qgmrux0hxKD5Lrh98
         2ysfXkHo+hjH8vamXEojgmD86N53Q159q1G104qf2HiLfonQXNKutvd1wpqgRGDVsu47
         NQADyiwmzB8uDlQ1Qisb4FVD2Zx7gMtBt0+2ukI+ybgcERVVjfw2F/wEo9QcpAheEHEV
         P2rV55c0b771QJ0G8Yn2jH0lQQAmrCldBe8/J7zbIGJCBJXgxvHdstA7vd648+PQKt/2
         QFNCFYo8wnod7aBe+F6ml7OkE3+PgAKab7h33SBJ8fUWYiNQtuKUI8Vf2W7n+MsHnLJm
         kdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585057; x=1692189857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bAc3FB/hA3X34MdDF0xzAaWT9uoxJ3Ja5Em+PxTX2U=;
        b=VjeHjhRuXvn/mPBMCbnW18syPYFAaZXOOczUWpVkXV1zRukGfEH6YMYGyJCVCrPqDz
         EUl6i0ty0dDSNYsycjCGLpzWI+20fCn15UfucXMsDJ4wQxBMoi+Ve32FUhbiB14Sy9E/
         M9AqhCL2K1VDUzhNCB3gc1WGNOhaTiPpStJn1aZjeXZ5nsKhatMgMHgSCWkxBOXzQ9ot
         ms2ibRH7puemNoLFd0ixvCjOifqs6WjKyt0x/BpoDYa4hUDEGR/pwf3+6LNlnlZlOm+H
         81JUOXRQZR2c71ahDO+MrxCwUb5DfcUahsbzeGIJahzjkjhoAIMk3jWeCeWXbXtxQ7x+
         Z7Iw==
X-Gm-Message-State: AOJu0YxK2nbbxS7fDWtGXoYv01xr6lTOKobY2CC1nw0GP1ZJfybJTUGj
	hciS321UPhl2RfTXxJLjEUo=
X-Google-Smtp-Source: AGHT+IF+IZ5vSowQoAfIh2ul3pUrtWUu91TvFFd1g4x7mw5dcJGWUVN/JaU51A1XpS1/D+7SM/LEZw==
X-Received: by 2002:adf:e892:0:b0:317:5f08:32a3 with SMTP id d18-20020adfe892000000b003175f0832a3mr1639877wrm.6.1691585057385;
        Wed, 09 Aug 2023 05:44:17 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:17 -0700 (PDT)
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
Subject: [PATCH bpf-next 03/10] selftests/xsk: add option to only run tests in a single mode
Date: Wed,  9 Aug 2023 14:43:36 +0200
Message-Id: <20230809124343.12957-4-magnus.karlsson@gmail.com>
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
index 2aa5a3445056..4ec621f4d3db 100755
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
 
+if [ ! -z $MODE ]; then
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
2.34.1


