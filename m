Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE269412A46
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhIUBdL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 21:33:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7244 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhIUBcz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 21:32:55 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwWqF006002
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 18:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=X36ME8e7f0R2qzKkpq3fXg6QJ01K7Au7LTLQ9SxZJTA=;
 b=atnnFFvetAQUbjohXdXIelYApk9h9lqNwVdbZTOynJ+BH4VlemoolyMoCYuKGUW+pL+w
 w1yBgm937BaT6IyH21cI6wECcCPm+cyPO7c6ekugNnmiQkYyVhvpVP+8pPsR+2JYf0X+
 iRrXU9IdkiTBc+KCeLOO0k8SS+rx00L3LS8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6v27uns2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 18:31:27 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 18:31:25 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 5C6E32940D2A; Mon, 20 Sep 2021 18:31:22 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 3/4] bpf: selftest: A bpf prog that has a 32bit scalar spill
Date:   Mon, 20 Sep 2021 18:31:22 -0700
Message-ID: <20210921013122.1037548-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921013102.1035356-1-kafai@fb.com>
References: <20210921013102.1035356-1-kafai@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: uLcatKMzTcyorLCL0Re2JZSN6Z9sR4cK
X-Proofpoint-ORIG-GUID: uLcatKMzTcyorLCL0Re2JZSN6Z9sR4cK
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_11,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is a simplified example that can trigger a 32bit scalar spill.
The const scalar is refilled and added to a skb->data later.
Since the reg state of the 32bit scalar spill is not saved now,
adding the refilled reg to skb->data and then comparing it with
skb->data_end cannot verify the skb->data access.

With the earlier verifier patch and the llvm patch [1].  The verifier
can correctly verify the bpf prog.

Here is the snippet of the verifier log that leads to verifier conclusion
that the packet data is unsafe to read.
67: R0=3Dinv1 R1=3Dinv17 R2=3Dpkt(id=3D0,off=3D62,r=3D102,imm=3D0) R3=3Dinv=
P2 R4=3Dpkt(id=3D0,off=3D68,r=3D102,imm=3D0) R5=3Dinv1 R6=3Dpkt(id=3D0,off=
=3D0,r=3D102,imm=3D0) R7=3Dpkt_end(id=3D0,off=3D0,imm=3D0) R8=3Dinv17 R9=3D=
inv102 R10=3Dfp0
67: (63) *(u32 *)(r10 -16) =3D r9
68: R0=3Dinv1 R1=3Dinv17 R2=3Dpkt(id=3D0,off=3D62,r=3D102,imm=3D0) R3=3Dinv=
P2 R4=3Dpkt(id=3D0,off=3D68,r=3D102,imm=3D0) R5=3Dinv1 R6=3Dpkt(id=3D0,off=
=3D0,r=3D102,imm=3D0) R7=3Dpkt_end(id=3D0,off=3D0,imm=3D0) R8=3Dinv17 R9=3D=
inv102 R10=3Dfp0 fp-16=3D????mmmm
...
74: R0_w=3Dmap_value_or_null(id=3D2,off=3D0,ks=3D16,vs=3D1,imm=3D0) R5_w=3D=
inv1 R6=3Dpkt(id=3D0,off=3D0,r=3D102,imm=3D0) R7=3Dpkt_end(id=3D0,off=3D0,i=
mm=3D0) R8=3Dinv17 R9_w=3Dinv1 R10=3Dfp0 fp-16=3D????mmmm
74: (61) r9 =3D *(u32 *)(r10 -16)
75: R0_w=3Dmap_value_or_null(id=3D2,off=3D0,ks=3D16,vs=3D1,imm=3D0) R5_w=3D=
inv1 R6=3Dpkt(id=3D0,off=3D0,r=3D102,imm=3D0) R7=3Dpkt_end(id=3D0,off=3D0,i=
mm=3D0) R8=3Dinv17 R9_w=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0=
; 0xffffffff)) R10=3Dfp0 fp-16=3D????mmmm
75: (bc) w1 =3D w9
76: R0_w=3Dmap_value_or_null(id=3D2,off=3D0,ks=3D16,vs=3D1,imm=3D0) R1_w=3D=
inv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R5_w=3Dinv1=
 R6=3Dpkt(id=3D0,off=3D0,r=3D102,imm=3D0) R7=3Dpkt_end(id=3D0,off=3D0,imm=
=3D0) R8=3Dinv17 R9_w=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; =
0xffffffff)) R10=3Dfp0 fp-16=3D????mmmm
76: (0f) r6 +=3D r1
last_idx 76 first_idx 67
regs=3D2 stack=3D0 before 75: (bc) w1 =3D w9
regs=3D200 stack=3D0 before 74: (61) r9 =3D *(u32 *)(r10 -16)
77: R0_w=3Dmap_value_or_null(id=3D2,off=3D0,ks=3D16,vs=3D1,imm=3D0) R1_w=3D=
invP(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R5_w=3Dinv=
1 R6_w=3Dpkt(id=3D3,off=3D0,r=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0=
xffffffff)) R7=3Dpkt_end(id=3D0,off=3D0,imm=3D0) R8=3Dinv17 R9_w=3Dinv(id=
=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0 fp-16=
=3D????mmmm
...
99: R0=3Dinv1 R1=3DinvP(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xff=
ffffff)) R5=3Dinv1 R6=3Dpkt(id=3D3,off=3D0,r=3D0,umax_value=3D4294967295,va=
r_off=3D(0x0; 0xffffffff)) R7=3Dpkt_end(id=3D0,off=3D0,imm=3D0) R8_w=3DinvP=
17 R9=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R10=
=3Dfp0 fp-16=3D????mmmm
99: (bf) r1 =3D r6
100: R0=3Dinv1 R1_w=3Dpkt(id=3D3,off=3D0,r=3D0,umax_value=3D4294967295,var_=
off=3D(0x0; 0xffffffff)) R5=3Dinv1 R6=3Dpkt(id=3D3,off=3D0,r=3D0,umax_value=
=3D4294967295,var_off=3D(0x0; 0xffffffff)) R7=3Dpkt_end(id=3D0,off=3D0,imm=
=3D0) R8_w=3DinvP17 R9=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0;=
 0xffffffff)) R10=3Dfp0 fp-16=3D????mmmm
100: (07) r1 +=3D 8
101: R0=3Dinv1 R1_w=3Dpkt(id=3D3,off=3D8,r=3D0,umax_value=3D4294967295,var_=
off=3D(0x0; 0xffffffff)) R5=3Dinv1 R6=3Dpkt(id=3D3,off=3D0,r=3D0,umax_value=
=3D4294967295,var_off=3D(0x0; 0xffffffff)) R7=3Dpkt_end(id=3D0,off=3D0,imm=
=3D0) R8_w=3DinvP17 R9=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0;=
 0xffffffff)) R10=3Dfp0 fp-16=3D????mmmm
101: (b4) w0 =3D 1
102: R0_w=3Dinv1 R1_w=3Dpkt(id=3D3,off=3D8,r=3D0,umax_value=3D4294967295,va=
r_off=3D(0x0; 0xffffffff)) R5=3Dinv1 R6=3Dpkt(id=3D3,off=3D0,r=3D0,umax_val=
ue=3D4294967295,var_off=3D(0x0; 0xffffffff)) R7=3Dpkt_end(id=3D0,off=3D0,im=
m=3D0) R8_w=3DinvP17 R9=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0=
; 0xffffffff)) R10=3Dfp0 fp-16=3D????mmmm
102: (2d) if r1 > r7 goto pc-38
 R0_w=3Dinv1 R1_w=3Dpkt(id=3D3,off=3D8,r=3D0,umax_value=3D4294967295,var_of=
f=3D(0x0; 0xffffffff)) R5=3Dinv1 R6=3Dpkt(id=3D3,off=3D0,r=3D0,umax_value=
=3D4294967295,var_off=3D(0x0; 0xffffffff)) R7=3Dpkt_end(id=3D0,off=3D0,imm=
=3D0) R8_w=3DinvP17 R9=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0;=
 0xffffffff)) R10=3Dfp0 fp-16=3D????mmmm
103: R0_w=3Dinv1 R1_w=3Dpkt(id=3D3,off=3D8,r=3D0,umax_value=3D4294967295,va=
r_off=3D(0x0; 0xffffffff)) R5=3Dinv1 R6=3Dpkt(id=3D3,off=3D0,r=3D0,umax_val=
ue=3D4294967295,var_off=3D(0x0; 0xffffffff)) R7=3Dpkt_end(id=3D0,off=3D0,im=
m=3D0) R8_w=3DinvP17 R9=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0=
; 0xffffffff)) R10=3Dfp0 fp-16=3D????mmmm
103: (69) r7 =3D *(u16 *)(r6 +0)
invalid access to packet, off=3D0 size=3D2, R6(id=3D3,off=3D0,r=3D0)
R6 offset is outside of the packet

[1]: https://reviews.llvm.org/D109073

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../selftests/bpf/prog_tests/xdpwall.c        |  15 +
 tools/testing/selftests/bpf/progs/xdpwall.c   | 302 ++++++++++++++++++
 2 files changed, 317 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdpwall.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdpwall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdpwall.c b/tools/testi=
ng/selftests/bpf/prog_tests/xdpwall.c
new file mode 100644
index 000000000000..d263fd0a7860
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdpwall.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include "test_progs.h"
+#include "xdpwall.skel.h"
+
+void test_xdpwall(void)
+{
+	struct xdpwall *skel;
+
+	skel =3D xdpwall__open_and_load();
+	ASSERT_OK_PTR(skel, "skel");
+
+	xdpwall__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdpwall.c b/tools/testing/se=
lftests/bpf/progs/xdpwall.c
new file mode 100644
index 000000000000..314a8d6beff0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdpwall.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <stdbool.h>
+#include <stdint.h>
+#include <linux/stddef.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/bpf.h>
+#include <linux/types.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+enum pkt_parse_err {
+	NO_ERR,
+	BAD_IP6_HDR,
+	BAD_IP4GUE_HDR,
+	BAD_IP6GUE_HDR,
+};
+
+enum pkt_flag {
+	TUNNEL =3D 0x1,
+	TCP_SYN =3D 0x2,
+	QUIC_INITIAL_FLAG =3D 0x4,
+	TCP_ACK =3D 0x8,
+	TCP_RST =3D 0x10
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16);
+	__type(key, struct in6_addr);
+	__type(value, bool);
+} v6_addr_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 16);
+	__type(key, int);
+	__type(value, __u8);
+} tcp_port_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 16);
+	__type(key, int);
+	__type(value, __u16);
+} udp_port_map SEC(".maps");
+
+enum ip_type { V4 =3D 1, V6 =3D 2 };
+
+struct fw_match_info {
+	__u8 v4_src_ip_match;
+	__u8 v6_src_ip_match;
+	__u8 v4_src_prefix_match;
+	__u8 v4_dst_prefix_match;
+	__u8 v6_src_prefix_match;
+	__u8 tcp_dp_match;
+	__u16 udp_sp_match;
+	__u16 udp_dp_match;
+	bool is_tcp;
+	bool is_tcp_syn;
+	bool is_link_local_v6;
+};
+
+struct pkt_info {
+	enum ip_type type;
+	union {
+		struct iphdr *ipv4;
+		struct ipv6hdr *ipv6;
+	} ip;
+	int sport;
+	int dport;
+	__u16 trans_hdr_offset;
+	__u8 proto;
+	__u8 flags;
+};
+
+static __always_inline struct ethhdr *parse_ethhdr(void *data, void *data_=
end)
+{
+	struct ethhdr *eth =3D data;
+
+	if (eth + 1 > data_end)
+		return NULL;
+
+	return eth;
+}
+
+static __always_inline void
+filter_src_ip6(struct pkt_info *info, struct fw_match_info *match_info)
+{
+	if (info->type =3D=3D V6 &&
+	    bpf_map_lookup_elem(&v6_addr_map, &info->ip.ipv6->saddr))
+		match_info->v6_src_ip_match =3D true;
+}
+
+static __always_inline void *
+get_transport_hdr(__u16 offset, void *data, void *data_end)
+{
+	if (offset > 255 || data + offset > data_end)
+		return NULL;
+
+	return data + offset;
+}
+
+static __always_inline bool tcphdr_only_contains_flag(struct tcphdr *tcp,
+						      __u32 FLAG)
+{
+	return (tcp_flag_word(tcp) &
+		(TCP_FLAG_ACK | TCP_FLAG_RST | TCP_FLAG_SYN | TCP_FLAG_FIN)) =3D=3D FLAG;
+}
+
+static __always_inline void set_tcp_flags(struct pkt_info *info,
+					  struct tcphdr *tcp) {
+	if (tcphdr_only_contains_flag(tcp, TCP_FLAG_SYN))
+		info->flags |=3D TCP_SYN;
+	else if (tcphdr_only_contains_flag(tcp, TCP_FLAG_ACK))
+		info->flags |=3D TCP_ACK;
+	else if (tcphdr_only_contains_flag(tcp, TCP_FLAG_RST))
+		info->flags |=3D TCP_RST;
+}
+
+static __always_inline bool
+parse_tcp(struct pkt_info *info, void *transport_hdr, void *data_end)
+{
+	struct tcphdr *tcp =3D transport_hdr;
+
+	if (tcp + 1 > data_end)
+		return false;
+
+	info->sport =3D bpf_ntohs(tcp->source);
+	info->dport =3D bpf_ntohs(tcp->dest);
+	set_tcp_flags(info, tcp);
+
+	return true;
+}
+
+static __always_inline bool
+parse_udp(struct pkt_info *info, void *transport_hdr, void *data_end)
+{
+	struct udphdr *udp =3D transport_hdr;
+
+	if (udp + 1 > data_end)
+		return false;
+
+	info->sport =3D bpf_ntohs(udp->source);
+	info->dport =3D bpf_ntohs(udp->dest);
+
+	return true;
+}
+
+static __always_inline __u8 filter_tcp_port(int port)
+{
+	__u8 *leaf =3D bpf_map_lookup_elem(&tcp_port_map, &port);
+
+	return leaf ? *leaf : 0;
+}
+
+static __always_inline __u16 filter_udp_port(int port)
+{
+	__u16 *leaf =3D bpf_map_lookup_elem(&udp_port_map, &port);
+
+	return leaf ? *leaf : 0;
+}
+
+static __always_inline bool
+filter_transport_hdr(void *transport_hdr, void *data_end,
+		     struct pkt_info *info, struct fw_match_info *match_info)
+{
+	if (info->proto =3D=3D IPPROTO_TCP) {
+		if (!parse_tcp(info, transport_hdr, data_end))
+			return false;
+
+		match_info->is_tcp =3D true;
+		match_info->is_tcp_syn =3D (info->flags & TCP_SYN) > 0;
+
+		match_info->tcp_dp_match =3D filter_tcp_port(info->dport);
+	} else if (info->proto =3D=3D IPPROTO_UDP) {
+		if (!parse_udp(info, transport_hdr, data_end))
+			return false;
+
+		match_info->udp_dp_match =3D filter_udp_port(info->dport);
+		match_info->udp_sp_match =3D filter_udp_port(info->sport);
+	}
+
+	return true;
+}
+
+static __always_inline __u8
+parse_gue_v6(struct pkt_info *info, struct ipv6hdr *ip6h, void *data_end)
+{
+	struct udphdr *udp =3D (struct udphdr *)(ip6h + 1);
+	void *encap_data =3D udp + 1;
+
+	if (udp + 1 > data_end)
+		return BAD_IP6_HDR;
+
+	if (udp->dest !=3D bpf_htons(6666))
+		return NO_ERR;
+
+	info->flags |=3D TUNNEL;
+
+	if (encap_data + 1 > data_end)
+		return BAD_IP6GUE_HDR;
+
+	if (*(__u8 *)encap_data & 0x30) {
+		struct ipv6hdr *inner_ip6h =3D encap_data;
+
+		if (inner_ip6h + 1 > data_end)
+			return BAD_IP6GUE_HDR;
+
+		info->type =3D V6;
+		info->proto =3D inner_ip6h->nexthdr;
+		info->ip.ipv6 =3D inner_ip6h;
+		info->trans_hdr_offset +=3D sizeof(struct ipv6hdr) + sizeof(struct udphd=
r);
+	} else {
+		struct iphdr *inner_ip4h =3D encap_data;
+
+		if (inner_ip4h + 1 > data_end)
+			return BAD_IP6GUE_HDR;
+
+		info->type =3D V4;
+		info->proto =3D inner_ip4h->protocol;
+		info->ip.ipv4 =3D inner_ip4h;
+		info->trans_hdr_offset +=3D sizeof(struct iphdr) + sizeof(struct udphdr);
+	}
+
+	return NO_ERR;
+}
+
+static __always_inline __u8 parse_ipv6_gue(struct pkt_info *info,
+					   void *data, void *data_end)
+{
+	struct ipv6hdr *ip6h =3D data + sizeof(struct ethhdr);
+
+	if (ip6h + 1 > data_end)
+		return BAD_IP6_HDR;
+
+	info->proto =3D ip6h->nexthdr;
+	info->ip.ipv6 =3D ip6h;
+	info->type =3D V6;
+	info->trans_hdr_offset =3D sizeof(struct ethhdr) + sizeof(struct ipv6hdr);
+
+	if (info->proto =3D=3D IPPROTO_UDP)
+		return parse_gue_v6(info, ip6h, data_end);
+
+	return NO_ERR;
+}
+
+SEC("xdp")
+int edgewall(struct xdp_md *ctx)
+{
+	void *data_end =3D (void *)(long)(ctx->data_end);
+	void *data =3D (void *)(long)(ctx->data);
+	struct fw_match_info match_info =3D {};
+	struct pkt_info info =3D {};
+	__u8 parse_err =3D NO_ERR;
+	void *transport_hdr;
+	struct ethhdr *eth;
+	bool filter_res;
+	__u32 proto;
+
+	eth =3D parse_ethhdr(data, data_end);
+	if (!eth)
+		return XDP_DROP;
+
+	proto =3D eth->h_proto;
+	if (proto !=3D bpf_htons(ETH_P_IPV6))
+		return XDP_DROP;
+
+	if (parse_ipv6_gue(&info, data, data_end))
+		return XDP_DROP;
+
+	if (info.proto =3D=3D IPPROTO_ICMPV6)
+		return XDP_PASS;
+
+	if (info.proto !=3D IPPROTO_TCP && info.proto !=3D IPPROTO_UDP)
+		return XDP_DROP;
+
+	filter_src_ip6(&info, &match_info);
+
+	transport_hdr =3D get_transport_hdr(info.trans_hdr_offset, data,
+					  data_end);
+	if (!transport_hdr)
+		return XDP_DROP;
+
+	filter_res =3D filter_transport_hdr(transport_hdr, data_end,
+					  &info, &match_info);
+	if (!filter_res)
+		return XDP_DROP;
+
+	if (match_info.is_tcp && !match_info.is_tcp_syn)
+		return XDP_PASS;
+
+	return XDP_DROP;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
--=20
2.30.2

