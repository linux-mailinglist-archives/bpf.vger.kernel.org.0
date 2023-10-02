Return-Path: <bpf+bounces-11213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E87B57F3
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 144902812A3
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5431CF89;
	Mon,  2 Oct 2023 16:35:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C3199B2;
	Mon,  2 Oct 2023 16:35:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC7BD3;
	Mon,  2 Oct 2023 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696264544; x=1727800544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HtXXSaxIUxjHE1Wz5boFHGVVOcQNpMLjN6igcpPHakg=;
  b=LctUeXF7rJMP8vVce4TKdDzuj069+/MrH7A/0VRLJH9S/3DqvVI5zzx+
   +FYkJ08XYpXM1oiLGV4JxeI03OSBm+MtLEGf9ZygXgO5yILHKkxkkOgTY
   Q+a2iQMw/y4XJyRkW3ZNoiroNdY6bDJxdgfRI5B1X6snNwObLHcKGyU05
   UyNcH426c5CJ18N7YZEjUjdalOtXsnH3lyQ6BPDX09geulhMDCnzrhGaY
   j6rAeVlv0vOvfRJtyFN7cU/k7u4O7XiYsjdRabLdsZ3NRQvOSLyHKVIDN
   YQeo2dq46Vgv5nKoGy/MUwipElLTg34kChhKJR+fJ9em2k/Z5Jp2pfbcJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4259637"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="4259637"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754107462"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754107462"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 02 Oct 2023 09:35:10 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 559EC43C38;
	Mon,  2 Oct 2023 17:35:07 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: add options and ZC mode to xdp_hw_metadata
Date: Mon,  2 Oct 2023 18:26:50 +0200
Message-ID: <20231002162653.297318-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By default, xdp_hw_metadata runs in AF_XDP copy mode. However, hints are
also supposed to be supported in ZC mode, which is usually implemented
separately in driver, and so needs to be tested too.

Add an option to run xdp_hw_metadata in ZC mode.

As for now, xdp_hw_metadata accepts no options, so add simple option
parsing logic and a help message.

For quick reference, also add an ingress packet generation command to the
help message. The command comes from [0].

[0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.com/

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 59 ++++++++++++++++---
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 613321eb84c1..c1d1b161a964 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -26,6 +26,7 @@
 #include <linux/sockios.h>
 #include <sys/mman.h>
 #include <net/if.h>
+#include <ctype.h>
 #include <poll.h>
 #include <time.h>
 
@@ -49,6 +50,7 @@ struct xsk {
 struct xdp_hw_metadata *bpf_obj;
 struct xsk *rx_xsk;
 const char *ifname;
+bool zero_copy;
 int ifindex;
 int rxq;
 
@@ -60,7 +62,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 	const struct xsk_socket_config socket_config = {
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
-		.bind_flags = XDP_COPY,
+		.bind_flags = zero_copy ? XDP_ZEROCOPY : XDP_COPY,
 	};
 	const struct xsk_umem_config umem_config = {
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
@@ -404,6 +406,54 @@ static void timestamping_enable(int fd, int val)
 		error(1, errno, "setsockopt(SO_TIMESTAMPING)");
 }
 
+static void print_usage(void)
+{
+	const char *usage =
+		"  Usage: xdp_hw_metadata [OPTIONS] [IFNAME]\n"
+		"  Options:\n"
+		"  -z            Run AF_XDP in ZC mode (copy mode is used by default)\n"
+		"  -h            Display this help and exit\n\n"
+		"  Generate test packets on other machine with:\n"
+		"    echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
+
+	printf("%s", usage);
+}
+
+static void read_args(int argc, char *argv[])
+{
+	char opt;
+
+	while ((opt = getopt(argc, argv, "zh")) != -1) {
+		switch (opt) {
+		case 'z':
+			zero_copy = true;
+			break;
+		case 'h':
+			print_usage();
+			exit(0);
+		case '?':
+			if (isprint(optopt))
+				fprintf(stderr, "Unknown option: -%c\n", optopt);
+			fallthrough;
+		default:
+			print_usage();
+			error(-1, opterr, "Command line options error");
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No device name provided\n");
+		print_usage();
+		exit(-1);
+	}
+
+	ifname = argv[optind];
+	ifindex = if_nametoindex(ifname);
+
+	if (!ifname)
+		error(-1, errno, "Invalid interface name");
+}
+
 int main(int argc, char *argv[])
 {
 	clockid_t clock_id = CLOCK_TAI;
@@ -413,13 +463,8 @@ int main(int argc, char *argv[])
 
 	struct bpf_program *prog;
 
-	if (argc != 2) {
-		fprintf(stderr, "pass device name\n");
-		return -1;
-	}
+	read_args(argc, argv);
 
-	ifname = argv[1];
-	ifindex = if_nametoindex(ifname);
 	rxq = rxq_num(ifname);
 
 	printf("rxq: %d\n", rxq);
-- 
2.41.0


