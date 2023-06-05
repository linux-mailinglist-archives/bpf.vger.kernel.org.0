Return-Path: <bpf+bounces-1834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5C7229DB
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 16:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597031C20960
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190BB2412F;
	Mon,  5 Jun 2023 14:45:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8981EA6F;
	Mon,  5 Jun 2023 14:45:46 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28D69E;
	Mon,  5 Jun 2023 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685976341; x=1717512341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jkNDV86ODGm9R0Aa+m/0irCSy4OWS+19X4x1SbULFkU=;
  b=ScTGXEcqe2cMd2v1ncBh3o24otZ9S/veMZuirOYie2FUNZtAOGe7+xkC
   EU0jN8ZeMo5bIpsFtFAolqYKxh2gCqbDNqSzCSf8Ih0mX7yIFDq5HxcYz
   AS9V/hYFwZ7GTemsajbrOUrFiG6PtnwLfpFEGAN5cuZXh043f+SwV5pv/
   7FdFuB6c0M4nLTssDpAfodRapRgBTbpThJdxmf98Jk0Q9ug/nxLjOyyIK
   c69NkXStGv5itBhg9DuWbUQc85eUVj27XDh673nT3k+XZHs1lBmkzLTUu
   yn4gABDfPEQZpkUPYCXKfzm7dZCfcTJuXmfx+YETWs8HexXrA6C5vqNdD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442758008"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="442758008"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 07:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="798464391"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="798464391"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jun 2023 07:45:38 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	maciej.fijalkowski@intel.com,
	simon.horman@corigine.com
Subject: [PATCH v3 bpf-next 17/22] selftests/xsk: add basic multi-buffer test
Date: Mon,  5 Jun 2023 16:44:28 +0200
Message-Id: <20230605144433.290114-18-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230605144433.290114-1-maciej.fijalkowski@intel.com>
References: <20230605144433.290114-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Add the first basic multi-buffer test that sends a stream of 9K
packets and validates that they are received at the other end. In
order to enable sending and receiving multi-buffer packets, code that
sets the MTU is introduced as well as modifications to the XDP
programs so that they signal that they are multi-buffer enabled.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/include/uapi/linux/if_xdp.h             |   6 +
 tools/include/uapi/linux/netdev.h             |   3 +-
 .../selftests/bpf/progs/xsk_xdp_progs.c       |   4 +-
 tools/testing/selftests/bpf/xsk.c             | 136 +++++++++++++++++-
 tools/testing/selftests/bpf/xsk.h             |   2 +
 tools/testing/selftests/bpf/xskxceiver.c      |  67 +++++++++
 tools/testing/selftests/bpf/xskxceiver.h      |   6 +
 7 files changed, 220 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 80245f5b4dd7..73a47da885dc 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -25,6 +25,12 @@
  * application.
  */
 #define XDP_USE_NEED_WAKEUP (1 << 3)
+/* By setting this option, userspace application indicates that it can
+ * handle multiple descriptors per packet thus enabling xsk core to split
+ * multi-buffer XDP frames into multiple Rx descriptors. Without this set
+ * such frames will be dropped by xsk.
+ */
+#define XDP_USE_SG     (1 << 4)
 
 /* Flags for xsk_umem_config flags */
 #define XDP_UMEM_UNALIGNED_CHUNK_FLAG (1 << 0)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 639524b59930..c1e59bfbae41 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -33,8 +33,9 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
+	NETDEV_XDP_ACT_ZC_SG = 128,
 
-	NETDEV_XDP_ACT_MASK = 127,
+	NETDEV_XDP_ACT_MASK = 255,
 };
 
 enum {
diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index a630c95c7471..ac76e7363776 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -15,12 +15,12 @@ struct {
 static unsigned int idx;
 int count = 0;
 
-SEC("xdp") int xsk_def_prog(struct xdp_md *xdp)
+SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
 }
 
-SEC("xdp") int xsk_xdp_drop(struct xdp_md *xdp)
+SEC("xdp.frags") int xsk_xdp_drop(struct xdp_md *xdp)
 {
 	/* Drop every other packet */
 	if (idx++ % 2)
diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index 687d83e707f8..d9fb2b730a2c 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -18,17 +18,19 @@
 #include <linux/ethtool.h>
 #include <linux/filter.h>
 #include <linux/if_ether.h>
+#include <linux/if_link.h>
 #include <linux/if_packet.h>
 #include <linux/if_xdp.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
 #include <linux/sockios.h>
 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/socket.h>
 #include <sys/types.h>
-#include <linux/if_link.h>
 
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
@@ -81,6 +83,12 @@ struct xsk_socket {
 	int fd;
 };
 
+struct nl_mtu_req {
+	struct nlmsghdr nh;
+	struct ifinfomsg msg;
+	char             buf[512];
+};
+
 int xsk_umem__fd(const struct xsk_umem *umem)
 {
 	return umem ? umem->fd : -EINVAL;
@@ -286,6 +294,132 @@ bool xsk_is_in_mode(u32 ifindex, int mode)
 	return false;
 }
 
+/* Lifted from netlink.c in tools/lib/bpf */
+static int netlink_recvmsg(int sock, struct msghdr *mhdr, int flags)
+{
+	int len;
+
+	do {
+		len = recvmsg(sock, mhdr, flags);
+	} while (len < 0 && (errno == EINTR || errno == EAGAIN));
+
+	if (len < 0)
+		return -errno;
+	return len;
+}
+
+/* Lifted from netlink.c in tools/lib/bpf */
+static int alloc_iov(struct iovec *iov, int len)
+{
+	void *nbuf;
+
+	nbuf = realloc(iov->iov_base, len);
+	if (!nbuf)
+		return -ENOMEM;
+
+	iov->iov_base = nbuf;
+	iov->iov_len = len;
+	return 0;
+}
+
+/* Original version lifted from netlink.c in tools/lib/bpf */
+static int netlink_recv(int sock)
+{
+	struct iovec iov = {};
+	struct msghdr mhdr = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	bool multipart = true;
+	struct nlmsgerr *err;
+	struct nlmsghdr *nh;
+	int len, ret;
+
+	ret = alloc_iov(&iov, 4096);
+	if (ret)
+		goto done;
+
+	while (multipart) {
+		multipart = false;
+		len = netlink_recvmsg(sock, &mhdr, MSG_PEEK | MSG_TRUNC);
+		if (len < 0) {
+			ret = len;
+			goto done;
+		}
+
+		if (len > iov.iov_len) {
+			ret = alloc_iov(&iov, len);
+			if (ret)
+				goto done;
+		}
+
+		len = netlink_recvmsg(sock, &mhdr, 0);
+		if (len < 0) {
+			ret = len;
+			goto done;
+		}
+
+		if (len == 0)
+			break;
+
+		for (nh = (struct nlmsghdr *)iov.iov_base; NLMSG_OK(nh, len);
+		     nh = NLMSG_NEXT(nh, len)) {
+			if (nh->nlmsg_flags & NLM_F_MULTI)
+				multipart = true;
+			switch (nh->nlmsg_type) {
+			case NLMSG_ERROR:
+				err = (struct nlmsgerr *)NLMSG_DATA(nh);
+				if (!err->error)
+					continue;
+				ret = err->error;
+				goto done;
+			case NLMSG_DONE:
+				ret = 0;
+				goto done;
+			default:
+				break;
+			}
+		}
+	}
+	ret = 0;
+done:
+	free(iov.iov_base);
+	return ret;
+}
+
+int xsk_set_mtu(int ifindex, int mtu)
+{
+	struct nl_mtu_req req;
+	struct rtattr *rta;
+	int fd, ret;
+
+	fd = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
+	if (fd < 0)
+		return fd;
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+	req.nh.nlmsg_type = RTM_NEWLINK;
+	req.msg.ifi_family = AF_UNSPEC;
+	req.msg.ifi_index = ifindex;
+	rta = (struct rtattr *)(((char *)&req) + NLMSG_ALIGN(req.nh.nlmsg_len));
+	rta->rta_type = IFLA_MTU;
+	rta->rta_len = RTA_LENGTH(sizeof(unsigned int));
+	req.nh.nlmsg_len = NLMSG_ALIGN(req.nh.nlmsg_len) + RTA_LENGTH(sizeof(mtu));
+	memcpy(RTA_DATA(rta), &mtu, sizeof(mtu));
+
+	ret = send(fd, &req, req.nh.nlmsg_len, 0);
+	if (ret < 0) {
+		close(fd);
+		return errno;
+	}
+
+	ret = netlink_recv(fd);
+	close(fd);
+	return ret;
+}
+
 int xsk_attach_xdp_program(struct bpf_program *prog, int ifindex, u32 xdp_flags)
 {
 	int prog_fd;
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
index 8da8d557768b..d93200fdaa8d 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/bpf/xsk.h
@@ -239,6 +239,8 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 int xsk_umem__delete(struct xsk_umem *umem);
 void xsk_socket__delete(struct xsk_socket *xsk);
 
+int xsk_set_mtu(int ifindex, int mtu);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 5e29e8850488..a6a148d1d78f 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -49,6 +49,7 @@
  *    h. tests for invalid and corner case Tx descriptors so that the correct ones
  *       are discarded and let through, respectively.
  *    i. 2K frame size tests
+ *    j. If multi-buffer is supported, send 9k packets divided into 3 frames
  *
  * Total tests: 12
  *
@@ -77,6 +78,7 @@
 #include <linux/if_link.h>
 #include <linux/if_ether.h>
 #include <linux/mman.h>
+#include <linux/netdev.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <locale.h>
@@ -253,6 +255,8 @@ static int __xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_i
 	cfg.bind_flags = ifobject->bind_flags;
 	if (shared)
 		cfg.bind_flags |= XDP_SHARED_UMEM;
+	if (ifobject->pkt_stream && ifobject->mtu > MAX_ETH_PKT_SIZE)
+		cfg.bind_flags |= XDP_USE_SG;
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
 	rxr = ifobject->rx_on ? &xsk->rx : NULL;
@@ -415,6 +419,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	test->total_steps = 1;
 	test->nb_sockets = 1;
 	test->fail = false;
+	test->mtu = MAX_ETH_PKT_SIZE;
 	test->xdp_prog_rx = ifobj_rx->xdp_progs->progs.xsk_def_prog;
 	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
 	test->xdp_prog_tx = ifobj_tx->xdp_progs->progs.xsk_def_prog;
@@ -468,6 +473,26 @@ static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *x
 	test->xskmap_tx = xskmap_tx;
 }
 
+static int test_spec_set_mtu(struct test_spec *test, int mtu)
+{
+	int err;
+
+	if (test->ifobj_rx->mtu != mtu) {
+		err = xsk_set_mtu(test->ifobj_rx->ifindex, mtu);
+		if (err)
+			return err;
+		test->ifobj_rx->mtu = mtu;
+	}
+	if (test->ifobj_tx->mtu != mtu) {
+		err = xsk_set_mtu(test->ifobj_tx->ifindex, mtu);
+		if (err)
+			return err;
+		test->ifobj_tx->mtu = mtu;
+	}
+
+	return 0;
+}
+
 static void pkt_stream_reset(struct pkt_stream *pkt_stream)
 {
 	if (pkt_stream)
@@ -1516,6 +1541,25 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 				      struct ifobject *ifobj2)
 {
 	pthread_t t0, t1;
+	int err;
+
+	if (test->mtu > MAX_ETH_PKT_SIZE) {
+		if (test->mode == TEST_MODE_ZC && (!ifobj1->multi_buff_zc_supp ||
+						   (ifobj2 && !ifobj2->multi_buff_zc_supp))) {
+			ksft_test_result_skip("Multi buffer for zero-copy not supported.\n");
+			return TEST_SKIP;
+		}
+		if (test->mode != TEST_MODE_ZC && (!ifobj1->multi_buff_supp ||
+						   (ifobj2 && !ifobj2->multi_buff_supp))) {
+			ksft_test_result_skip("Multi buffer not supported.\n");
+			return TEST_SKIP;
+		}
+	}
+	err = test_spec_set_mtu(test, test->mtu);
+	if (err) {
+		ksft_print_msg("Error, could not set mtu.\n");
+		exit_with_error(err);
+	}
 
 	if (ifobj2) {
 		if (pthread_barrier_init(&barr, NULL, 2))
@@ -1725,6 +1769,15 @@ static int testapp_single_pkt(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_multi_buffer(struct test_spec *test)
+{
+	test_spec_set_name(test, "RUN_TO_COMPLETION_9K_PACKETS");
+	test->mtu = MAX_ETH_JUMBO_SIZE;
+	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
+
+	return testapp_validate_traffic(test);
+}
+
 static int testapp_invalid_desc(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_tx->umem;
@@ -1858,6 +1911,7 @@ static bool hugepages_present(void)
 static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *src_mac,
 		       thread_func_t func_ptr)
 {
+	LIBBPF_OPTS(bpf_xdp_query_opts, query_opts);
 	int err;
 
 	memcpy(ifobj->dst_mac, dst_mac, ETH_ALEN);
@@ -1873,6 +1927,16 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 
 	if (hugepages_present())
 		ifobj->unaligned_supp = true;
+
+	err = bpf_xdp_query(ifobj->ifindex, XDP_FLAGS_DRV_MODE, &query_opts);
+	if (err) {
+		ksft_print_msg("Error querrying XDP capabilities\n");
+		exit_with_error(-err);
+	}
+	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
+		ifobj->multi_buff_supp = true;
+	if (query_opts.feature_flags & NETDEV_XDP_ACT_ZC_SG)
+		ifobj->multi_buff_zc_supp = true;
 }
 
 static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_type type)
@@ -1905,6 +1969,9 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		test_spec_set_name(test, "RUN_TO_COMPLETION");
 		ret = testapp_validate_traffic(test);
 		break;
+	case TEST_TYPE_RUN_TO_COMPLETION_MB:
+		ret = testapp_multi_buffer(test);
+		break;
 	case TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT:
 		test_spec_set_name(test, "RUN_TO_COMPLETION_SINGLE_PKT");
 		ret = testapp_single_pkt(test);
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 310b48ad8a3a..cfc7c572fd2c 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -38,6 +38,7 @@
 #define MAX_TEARDOWN_ITER 10
 #define PKT_HDR_SIZE (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
 #define MIN_PKT_SIZE 64
+#define MAX_ETH_PKT_SIZE 1518
 #define MAX_ETH_JUMBO_SIZE 9000
 #define USLEEP_MAX 10000
 #define SOCK_RECONF_CTR 10
@@ -84,6 +85,7 @@ enum test_type {
 	TEST_TYPE_BPF_RES,
 	TEST_TYPE_XDP_DROP_HALF,
 	TEST_TYPE_XDP_METADATA_COUNT,
+	TEST_TYPE_RUN_TO_COMPLETION_MB,
 	TEST_TYPE_MAX
 };
 
@@ -142,6 +144,7 @@ struct ifobject {
 	struct bpf_program *xdp_prog;
 	enum test_mode mode;
 	int ifindex;
+	int mtu;
 	u32 bind_flags;
 	bool tx_on;
 	bool rx_on;
@@ -152,6 +155,8 @@ struct ifobject {
 	bool shared_umem;
 	bool use_metadata;
 	bool unaligned_supp;
+	bool multi_buff_supp;
+	bool multi_buff_zc_supp;
 	u8 dst_mac[ETH_ALEN];
 	u8 src_mac[ETH_ALEN];
 };
@@ -165,6 +170,7 @@ struct test_spec {
 	struct bpf_program *xdp_prog_tx;
 	struct bpf_map *xskmap_rx;
 	struct bpf_map *xskmap_tx;
+	int mtu;
 	u16 total_steps;
 	u16 current_step;
 	u16 nb_sockets;
-- 
2.34.1


