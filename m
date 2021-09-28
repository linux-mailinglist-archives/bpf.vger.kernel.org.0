Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9651441B491
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbhI1Q6U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Sep 2021 12:58:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43334 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241942AbhI1Q6S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 12:58:18 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SFQLPu016420
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:38 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bc5pegqtt-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:36 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:56:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 58AB350F9BF7; Tue, 28 Sep 2021 09:20:42 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 02/10] selftests/bpf: normalize XDP section names in selftests
Date:   Tue, 28 Sep 2021 09:19:38 -0700
Message-ID: <20210928161946.2512801-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928161946.2512801-1-andrii@kernel.org>
References: <20210928161946.2512801-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Uas27eRqamXHEVrpiJqbeAmft_VXTwpn
X-Proofpoint-GUID: Uas27eRqamXHEVrpiJqbeAmft_VXTwpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=967 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109280099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert almost all SEC("xdp_blah") uses to strict SEC("xdp") to comply
with strict libbpf 1.0 logic of exact section name match for XDP program
types. There is only one exception, which is only tested through
iproute2 and defines multiple XDP programs within the same BPF object.
Given iproute2 still works in non-strict libbpf mode and it doesn't have
means to specify XDP programs by its name (not section name/title),
leave that single file alone for now until iproute2 gains lookup by
function/program name.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_map_in_map.c          | 2 +-
 .../selftests/bpf/progs/test_tcp_check_syncookie_kern.c      | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c                 | 2 +-
 .../testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c  | 2 +-
 .../selftests/bpf/progs/test_xdp_adjust_tail_shrink.c        | 4 +---
 tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c  | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_link.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
 .../selftests/bpf/progs/test_xdp_with_cpumap_helpers.c       | 4 ++--
 .../selftests/bpf/progs/test_xdp_with_devmap_helpers.c       | 4 ++--
 tools/testing/selftests/bpf/progs/xdp_dummy.c                | 2 +-
 tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c  | 4 ++--
 tools/testing/selftests/bpf/progs/xdping_kern.c              | 4 ++--
 tools/testing/selftests/bpf/test_tcp_check_syncookie.sh      | 2 +-
 tools/testing/selftests/bpf/test_xdp_redirect.sh             | 4 ++--
 tools/testing/selftests/bpf/test_xdp_redirect_multi.sh       | 2 +-
 tools/testing/selftests/bpf/test_xdp_veth.sh                 | 4 ++--
 tools/testing/selftests/bpf/xdping.c                         | 5 ++---
 19 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
index 1cfeb940cf9f..5f0e0bfc151e 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
@@ -23,7 +23,7 @@ struct {
 	__uint(value_size, sizeof(__u32));
 } mim_hash SEC(".maps");
 
-SEC("xdp_mimtest")
+SEC("xdp")
 int xdp_mimtest0(struct xdp_md *ctx)
 {
 	int value = 123;
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c b/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
index 47cbe2eeae43..fac7ef99f9a6 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
@@ -156,7 +156,7 @@ int check_syncookie_clsact(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("xdp/check_syncookie")
+SEC("xdp")
 int check_syncookie_xdp(struct xdp_md *ctx)
 {
 	check_syncookie(ctx, (void *)(long)ctx->data,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
index 31f9bce37491..e6aa2fc6ce6b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp.c
@@ -210,7 +210,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
 	return XDP_TX;
 }
 
-SEC("xdp_tx_iptunnel")
+SEC("xdp")
 int _xdp_tx_iptunnel(struct xdp_md *xdp)
 {
 	void *data_end = (void *)(long)xdp->data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
index 3d66599eee2e..199c61b7d062 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
@@ -2,7 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-SEC("xdp_adjust_tail_grow")
+SEC("xdp")
 int _xdp_adjust_tail_grow(struct xdp_md *xdp)
 {
 	void *data_end = (void *)(long)xdp->data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
index 22065a9cfb25..b7448253d135 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
@@ -9,9 +9,7 @@
 #include <linux/if_ether.h>
 #include <bpf/bpf_helpers.h>
 
-int _version SEC("version") = 1;
-
-SEC("xdp_adjust_tail_shrink")
+SEC("xdp")
 int _xdp_adjust_tail_shrink(struct xdp_md *xdp)
 {
 	void *data_end = (void *)(long)xdp->data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
index b360ba2bd441..807bf895f42c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
@@ -5,7 +5,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-SEC("xdp_dm_log")
+SEC("xdp")
 int xdpdm_devlog(struct xdp_md *ctx)
 {
 	char fmt[] = "devmap redirect: dev %u -> dev %u len %u\n";
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_link.c b/tools/testing/selftests/bpf/progs/test_xdp_link.c
index eb93ea95d1d8..ee7d6ac0f615 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_link.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_link.c
@@ -5,7 +5,7 @@
 
 char LICENSE[] SEC("license") = "GPL";
 
-SEC("xdp/handler")
+SEC("xdp")
 int xdp_handler(struct xdp_md *xdp)
 {
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
index fcabcda30ba3..27eb52dda92c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
@@ -206,7 +206,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
 	return XDP_TX;
 }
 
-SEC("xdp_tx_iptunnel")
+SEC("xdp")
 int _xdp_tx_iptunnel(struct xdp_md *xdp)
 {
 	void *data_end = (void *)(long)xdp->data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index 3a67921f62b5..596c4e71bf3a 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -797,7 +797,7 @@ static int process_packet(void *data, __u64 off, void *data_end,
 	return XDP_DROP;
 }
 
-SEC("xdp-test-v4")
+SEC("xdp")
 int balancer_ingress_v4(struct xdp_md *ctx)
 {
 	void *data = (void *)(long)ctx->data;
@@ -816,7 +816,7 @@ int balancer_ingress_v4(struct xdp_md *ctx)
 		return XDP_DROP;
 }
 
-SEC("xdp-test-v6")
+SEC("xdp")
 int balancer_ingress_v6(struct xdp_md *ctx)
 {
 	void *data = (void *)(long)ctx->data;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
index 59ee4f182ff8..532025057711 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
@@ -12,13 +12,13 @@ struct {
 	__uint(max_entries, 4);
 } cpu_map SEC(".maps");
 
-SEC("xdp_redir")
+SEC("xdp")
 int xdp_redir_prog(struct xdp_md *ctx)
 {
 	return bpf_redirect_map(&cpu_map, 1, 0);
 }
 
-SEC("xdp_dummy")
+SEC("xdp")
 int xdp_dummy_prog(struct xdp_md *ctx)
 {
 	return XDP_PASS;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
index 0ac086497722..1e6b9c38ea6d 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
@@ -9,7 +9,7 @@ struct {
 	__uint(max_entries, 4);
 } dm_ports SEC(".maps");
 
-SEC("xdp_redir")
+SEC("xdp")
 int xdp_redir_prog(struct xdp_md *ctx)
 {
 	return bpf_redirect_map(&dm_ports, 1, 0);
@@ -18,7 +18,7 @@ int xdp_redir_prog(struct xdp_md *ctx)
 /* invalid program on DEVMAP entry;
  * SEC name means expected attach type not set
  */
-SEC("xdp_dummy")
+SEC("xdp")
 int xdp_dummy_prog(struct xdp_md *ctx)
 {
 	return XDP_PASS;
diff --git a/tools/testing/selftests/bpf/progs/xdp_dummy.c b/tools/testing/selftests/bpf/progs/xdp_dummy.c
index ea25e8881992..d988b2e0cee8 100644
--- a/tools/testing/selftests/bpf/progs/xdp_dummy.c
+++ b/tools/testing/selftests/bpf/progs/xdp_dummy.c
@@ -4,7 +4,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-SEC("xdp_dummy")
+SEC("xdp")
 int xdp_dummy_prog(struct xdp_md *ctx)
 {
 	return XDP_PASS;
diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
index 880debcbcd65..8395782b6e0a 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
@@ -34,7 +34,7 @@ struct {
 	__uint(max_entries, 128);
 } mac_map SEC(".maps");
 
-SEC("xdp_redirect_map_multi")
+SEC("xdp")
 int xdp_redirect_map_multi_prog(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
@@ -63,7 +63,7 @@ int xdp_redirect_map_multi_prog(struct xdp_md *ctx)
 }
 
 /* The following 2 progs are for 2nd devmap prog testing */
-SEC("xdp_redirect_map_ingress")
+SEC("xdp")
 int xdp_redirect_map_all_prog(struct xdp_md *ctx)
 {
 	return bpf_redirect_map(&map_egress, 0,
diff --git a/tools/testing/selftests/bpf/progs/xdping_kern.c b/tools/testing/selftests/bpf/progs/xdping_kern.c
index 6b9ca40bd1f4..4ad73847b8a5 100644
--- a/tools/testing/selftests/bpf/progs/xdping_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdping_kern.c
@@ -86,7 +86,7 @@ static __always_inline int icmp_check(struct xdp_md *ctx, int type)
 	return XDP_TX;
 }
 
-SEC("xdpclient")
+SEC("xdp")
 int xdping_client(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
@@ -150,7 +150,7 @@ int xdping_client(struct xdp_md *ctx)
 	return XDP_TX;
 }
 
-SEC("xdpserver")
+SEC("xdp")
 int xdping_server(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh b/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
index 9b3617d770a5..fed765157c53 100755
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
@@ -77,7 +77,7 @@ TEST_IF=lo
 MAX_PING_TRIES=5
 BPF_PROG_OBJ="${DIR}/test_tcp_check_syncookie_kern.o"
 CLSACT_SECTION="clsact/check_syncookie"
-XDP_SECTION="xdp/check_syncookie"
+XDP_SECTION="xdp"
 BPF_PROG_ID=0
 PROG="${DIR}/test_tcp_check_syncookie_user"
 
diff --git a/tools/testing/selftests/bpf/test_xdp_redirect.sh b/tools/testing/selftests/bpf/test_xdp_redirect.sh
index c033850886f4..57c8db9972a6 100755
--- a/tools/testing/selftests/bpf/test_xdp_redirect.sh
+++ b/tools/testing/selftests/bpf/test_xdp_redirect.sh
@@ -52,8 +52,8 @@ test_xdp_redirect()
 		return 0
 	fi
 
-	ip -n ns1 link set veth11 $xdpmode obj xdp_dummy.o sec xdp_dummy &> /dev/null
-	ip -n ns2 link set veth22 $xdpmode obj xdp_dummy.o sec xdp_dummy &> /dev/null
+	ip -n ns1 link set veth11 $xdpmode obj xdp_dummy.o sec xdp &> /dev/null
+	ip -n ns2 link set veth22 $xdpmode obj xdp_dummy.o sec xdp &> /dev/null
 	ip link set dev veth1 $xdpmode obj test_xdp_redirect.o sec redirect_to_222 &> /dev/null
 	ip link set dev veth2 $xdpmode obj test_xdp_redirect.o sec redirect_to_111 &> /dev/null
 
diff --git a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh b/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
index 1538373157e3..351955c2bdfd 100755
--- a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
+++ b/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
@@ -88,7 +88,7 @@ setup_ns()
 		# Add a neigh entry for IPv4 ping test
 		ip -n ns$i neigh add 192.0.2.253 lladdr 00:00:00:00:00:01 dev veth0
 		ip -n ns$i link set veth0 $mode obj \
-			xdp_dummy.o sec xdp_dummy &> /dev/null || \
+			xdp_dummy.o sec xdp &> /dev/null || \
 			{ test_fail "Unable to load dummy xdp" && exit 1; }
 		IFACES="$IFACES veth$i"
 		veth_mac[$i]=$(ip link show veth$i | awk '/link\/ether/ {print $2}')
diff --git a/tools/testing/selftests/bpf/test_xdp_veth.sh b/tools/testing/selftests/bpf/test_xdp_veth.sh
index 995278e684b6..a3a1eaee26ea 100755
--- a/tools/testing/selftests/bpf/test_xdp_veth.sh
+++ b/tools/testing/selftests/bpf/test_xdp_veth.sh
@@ -107,9 +107,9 @@ ip link set dev veth1 xdp pinned $BPF_DIR/progs/redirect_map_0
 ip link set dev veth2 xdp pinned $BPF_DIR/progs/redirect_map_1
 ip link set dev veth3 xdp pinned $BPF_DIR/progs/redirect_map_2
 
-ip -n ns1 link set dev veth11 xdp obj xdp_dummy.o sec xdp_dummy
+ip -n ns1 link set dev veth11 xdp obj xdp_dummy.o sec xdp
 ip -n ns2 link set dev veth22 xdp obj xdp_tx.o sec xdp
-ip -n ns3 link set dev veth33 xdp obj xdp_dummy.o sec xdp_dummy
+ip -n ns3 link set dev veth33 xdp obj xdp_dummy.o sec xdp
 
 trap cleanup EXIT
 
diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
index 842d9155d36c..79a3453dab25 100644
--- a/tools/testing/selftests/bpf/xdping.c
+++ b/tools/testing/selftests/bpf/xdping.c
@@ -178,9 +178,8 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	main_prog = bpf_object__find_program_by_title(obj,
-						      server ? "xdpserver" :
-							       "xdpclient");
+	main_prog = bpf_object__find_program_by_name(obj,
+						     server ? "xdping_server" : "xdping_client");
 	if (main_prog)
 		prog_fd = bpf_program__fd(main_prog);
 	if (!main_prog || prog_fd < 0) {
-- 
2.30.2

