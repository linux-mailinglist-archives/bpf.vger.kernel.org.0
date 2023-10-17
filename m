Return-Path: <bpf+bounces-12455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3117CC8F2
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D98B211B3
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48762D02E;
	Tue, 17 Oct 2023 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/FkTEv3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE22D034
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:35:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749E3AB;
	Tue, 17 Oct 2023 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697560541; x=1729096541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SZ9crw7KBkf4KNA2a8gcrC2IT6umgARNKh65AO/ygBY=;
  b=h/FkTEv3r0drj7UmSVtMATMqii5R224yycHAyiAoC5RHW/O+moBZp7Kh
   KKALFHyjBd2xQu0AcNxOaXEBa0V2MJLG+0M0bVBm3IvYn2rX9k1D716it
   fmgZOSvm8wL5kScc9BOcqRoBY2rztqP+BxYZCD64TCsGwSIneH6XIZ9ih
   DrsS5hnGcjh1TDr/gVkUynpiMbzrJ+7+Dhtuu4OaZmlhEngMYmOUEkSZF
   4iFtPzP/qMfrgvW2ri7wGe12Cv7Yx66OC0xTXfXxT96wK0BegCppQq/eK
   gf9Eq6gdwt2SLs1798jfnVP4QK/1ADAdGXTrOCv1jcADCRp4g5IojfuX+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383049121"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="383049121"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822050148"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="822050148"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2023 09:35:37 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8AF5333E87;
	Tue, 17 Oct 2023 17:35:35 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next v2] selftests/bpf: add options and frags to xdp_hw_metadata
Date: Tue, 17 Oct 2023 18:27:57 +0200
Message-ID: <20231017162800.24080-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a follow-up to the commit 9b2b86332a9b ("bpf: Allow to use kfunc
XDP hints and frags together").

The are some possible implementations problems that may arise when
providing metadata specifically for multi-buffer packets, therefore there
must be a possibility to test such option separately.

Add an option to use multi-buffer AF_XDP xdp_hw_metadata and mark used XDP
program as capable to use frags.

As for now, xdp_hw_metadata accepts no options, so add simple option
parsing logic and a help message.

For quick reference, also add an ingress packet generation command to the
help message. The command comes from [0].

Example of output for multi-buffer packet:

xsk_ring_cons__peek: 1
0xead018: rx_desc[15]->addr=10000000000f000 addr=f100 comp_addr=f000
rx_hash: 0x5789FCBB with RSS type:0x29
rx_timestamp:  1696856851535324697 (sec:1696856851.5353)
XDP RX-time:   1696856843158256391 (sec:1696856843.1583)
	delta sec:-8.3771 (-8377068.306 usec)
AF_XDP time:   1696856843158413078 (sec:1696856843.1584)
	delta sec:0.0002 (156.687 usec)
0xead018: complete idx=23 addr=f000
xsk_ring_cons__peek: 1
0xead018: rx_desc[16]->addr=100000000008000 addr=8100 comp_addr=8000
0xead018: complete idx=24 addr=8000
xsk_ring_cons__peek: 1
0xead018: rx_desc[17]->addr=100000000009000 addr=9100 comp_addr=9000 EoP
0xead018: complete idx=25 addr=9000

Metadata is printed for the first packet only.

[0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.com/

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
V1 -> V2: drop gen_socket_config(), remove extra spaces in help message

 .../selftests/bpf/progs/xdp_hw_metadata.c     |  2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 78 ++++++++++++++++---
 2 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 63d7de6c6bbb..8767d919c881 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -21,7 +21,7 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
 
-SEC("xdp")
+SEC("xdp.frags")
 int rx(struct xdp_md *ctx)
 {
 	void *data, *data_meta, *data_end;
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 17c980138796..17c0f92ff160 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -26,6 +26,7 @@
 #include <linux/sockios.h>
 #include <sys/mman.h>
 #include <net/if.h>
+#include <ctype.h>
 #include <poll.h>
 #include <time.h>
 
@@ -47,6 +48,7 @@ struct xsk {
 };
 
 struct xdp_hw_metadata *bpf_obj;
+__u16 bind_flags = XDP_COPY;
 struct xsk *rx_xsk;
 const char *ifname;
 int ifindex;
@@ -60,7 +62,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 	const struct xsk_socket_config socket_config = {
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
-		.bind_flags = XDP_COPY,
+		.bind_flags = bind_flags,
 	};
 	const struct xsk_umem_config umem_config = {
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
@@ -263,11 +265,14 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 			verify_skb_metadata(server_fd);
 
 		for (i = 0; i < rxq; i++) {
+			bool first_seg = true;
+			bool is_eop = true;
+
 			if (fds[i].revents == 0)
 				continue;
 
 			struct xsk *xsk = &rx_xsk[i];
-
+peek:
 			ret = xsk_ring_cons__peek(&xsk->rx, 1, &idx);
 			printf("xsk_ring_cons__peek: %d\n", ret);
 			if (ret != 1)
@@ -276,12 +281,19 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 			rx_desc = xsk_ring_cons__rx_desc(&xsk->rx, idx);
 			comp_addr = xsk_umem__extract_addr(rx_desc->addr);
 			addr = xsk_umem__add_offset_to_addr(rx_desc->addr);
-			printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx\n",
-			       xsk, idx, rx_desc->addr, addr, comp_addr);
-			verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
-					    clock_id);
+			is_eop = !(rx_desc->options & XDP_PKT_CONTD);
+			printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx%s\n",
+			       xsk, idx, rx_desc->addr, addr, comp_addr, is_eop ? " EoP" : "");
+			if (first_seg) {
+				verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
+						    clock_id);
+				first_seg = false;
+			}
+
 			xsk_ring_cons__release(&xsk->rx, 1);
 			refill_rx(xsk, comp_addr);
+			if (!is_eop)
+				goto peek;
 		}
 	}
 
@@ -404,6 +416,53 @@ static void timestamping_enable(int fd, int val)
 		error(1, errno, "setsockopt(SO_TIMESTAMPING)");
 }
 
+static void print_usage(void)
+{
+	const char *usage =
+		"Usage: xdp_hw_metadata [OPTIONS] [IFNAME]\n"
+		"  -m    Enable multi-buffer XDP for larger MTU\n"
+		"  -h    Display this help and exit\n\n"
+		"Generate test packets on the other machine with:\n"
+		"  echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
+
+	printf("%s", usage);
+}
+
+static void read_args(int argc, char *argv[])
+{
+	char opt;
+
+	while ((opt = getopt(argc, argv, "mh")) != -1) {
+		switch (opt) {
+		case 'm':
+			bind_flags |= XDP_USE_SG;
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
@@ -413,13 +472,8 @@ int main(int argc, char *argv[])
 
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


