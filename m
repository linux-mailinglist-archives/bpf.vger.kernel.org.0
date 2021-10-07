Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5F425D31
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 22:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhJGU0k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 16:26:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233385AbhJGU0k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Oct 2021 16:26:40 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197Jsxpm028802
        for <bpf@vger.kernel.org>; Thu, 7 Oct 2021 13:24:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=zbqXOPpEvnf0FaFMPANU4UVlnA3lATzOy+6vHx5IdQg=;
 b=XAM7cf0/MZHQTNNmOVI6Vpex22X0/OG669VI9VKVhfyMsmTk9ieitVyTTDgcLFLg0cwU
 ssV6HxWyREe6f5XZuRQRU9+0nCsX27HXTXjkOmSdfy4/22Z7uq1T4CJxQxOWKn8M34ua
 WAzH1cIZgYoiI4SwxVfV2pbXoqojl6x+Hvg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bj7fa87g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 13:24:46 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 7 Oct 2021 13:23:30 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 50E687B12C6E; Thu,  7 Oct 2021 13:23:20 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: remove SEC("version") from test progs
Date:   Thu, 7 Oct 2021 13:23:19 -0700
Message-ID: <20211007202319.1153540-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: hanNXiIWjGsT7u2zF4thbyeOjtzvMuRE
X-Proofpoint-ORIG-GUID: hanNXiIWjGsT7u2zF4thbyeOjtzvMuRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since commit 6c4fc209fcf9d ("bpf: remove useless version check for prog
load") these "version" sections, which result in bpf_attr.kern_version
being set, have been unnecessary.

Remove them so that it's obvious to folks using selftests as a guide that
"modern" BPF progs don't need this section.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c  | 1 -
 tools/testing/selftests/bpf/progs/connect4_prog.c              | 1 -
 tools/testing/selftests/bpf/progs/connect6_prog.c              | 1 -
 tools/testing/selftests/bpf/progs/connect_force_port4.c        | 1 -
 tools/testing/selftests/bpf/progs/connect_force_port6.c        | 1 -
 tools/testing/selftests/bpf/progs/dev_cgroup.c                 | 1 -
 tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c         | 1 -
 tools/testing/selftests/bpf/progs/map_ptr_kern.c               | 1 -
 tools/testing/selftests/bpf/progs/netcnt_prog.c                | 1 -
 tools/testing/selftests/bpf/progs/sendmsg4_prog.c              | 1 -
 tools/testing/selftests/bpf/progs/sendmsg6_prog.c              | 1 -
 tools/testing/selftests/bpf/progs/sockmap_parse_prog.c         | 1 -
 tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c       | 1 -
 tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c       | 1 -
 tools/testing/selftests/bpf/progs/sockopt_inherit.c            | 1 -
 tools/testing/selftests/bpf/progs/tcp_rtt.c                    | 1 -
 tools/testing/selftests/bpf/progs/test_btf_haskv.c             | 1 -
 tools/testing/selftests/bpf/progs/test_btf_newkv.c             | 1 -
 tools/testing/selftests/bpf/progs/test_btf_nokv.c              | 1 -
 tools/testing/selftests/bpf/progs/test_l4lb.c                  | 1 -
 tools/testing/selftests/bpf/progs/test_map_in_map.c            | 1 -
 tools/testing/selftests/bpf/progs/test_pinning.c               | 1 -
 tools/testing/selftests/bpf/progs/test_pinning_invalid.c       | 1 -
 tools/testing/selftests/bpf/progs/test_pkt_access.c            | 1 -
 tools/testing/selftests/bpf/progs/test_queue_stack_map.h       | 1 -
 tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c | 1 -
 tools/testing/selftests/bpf/progs/test_sk_lookup.c             | 1 -
 tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c    | 1 -
 tools/testing/selftests/bpf/progs/test_skb_ctx.c               | 1 -
 tools/testing/selftests/bpf/progs/test_sockmap_kern.h          | 1 -
 tools/testing/selftests/bpf/progs/test_sockmap_listen.c        | 1 -
 tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c   | 1 -
 tools/testing/selftests/bpf/progs/test_static_linked1.c        | 1 -
 tools/testing/selftests/bpf/progs/test_static_linked2.c        | 1 -
 tools/testing/selftests/bpf/progs/test_tcp_estats.c            | 1 -
 tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c           | 1 -
 tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c        | 1 -
 tools/testing/selftests/bpf/progs/test_tracepoint.c            | 1 -
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c           | 1 -
 tools/testing/selftests/bpf/progs/test_xdp.c                   | 1 -
 tools/testing/selftests/bpf/progs/test_xdp_loop.c              | 1 -
 tools/testing/selftests/bpf/progs/test_xdp_redirect.c          | 1 -
 42 files changed, 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.=
c b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
index 3f757e30d7a0..88638315c582 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
@@ -14,7 +14,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
=20
-int _version SEC("version") =3D 1;
 char _license[] SEC("license") =3D "GPL";
=20
 __u16 g_serv_port =3D 0;
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/te=
sting/selftests/bpf/progs/connect4_prog.c
index a943d394fd3a..cf432a527d49 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -31,7 +31,6 @@
 #define IFNAMSIZ 16
 #endif
=20
-int _version SEC("version") =3D 1;
=20
 __attribute__ ((noinline))
 int do_bind(struct bpf_sock_addr *ctx)
diff --git a/tools/testing/selftests/bpf/progs/connect6_prog.c b/tools/te=
sting/selftests/bpf/progs/connect6_prog.c
index 506d0f81a375..612aa5d39db0 100644
--- a/tools/testing/selftests/bpf/progs/connect6_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect6_prog.c
@@ -24,7 +24,6 @@
=20
 #define DST_REWRITE_PORT6	6666
=20
-int _version SEC("version") =3D 1;
=20
 SEC("cgroup/connect6")
 int connect_v6_prog(struct bpf_sock_addr *ctx)
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port4.c b/to=
ols/testing/selftests/bpf/progs/connect_force_port4.c
index a979aaef2a76..27a632dd382e 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port4.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port4.c
@@ -13,7 +13,6 @@
 #include <bpf_sockopt_helpers.h>
=20
 char _license[] SEC("license") =3D "GPL";
-int _version SEC("version") =3D 1;
=20
 struct svc_addr {
 	__be32 addr;
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port6.c b/to=
ols/testing/selftests/bpf/progs/connect_force_port6.c
index afc8f1c5a9d6..19cad93e612f 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port6.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port6.c
@@ -12,7 +12,6 @@
 #include <bpf_sockopt_helpers.h>
=20
 char _license[] SEC("license") =3D "GPL";
-int _version SEC("version") =3D 1;
=20
 struct svc_addr {
 	__be32 addr[4];
diff --git a/tools/testing/selftests/bpf/progs/dev_cgroup.c b/tools/testi=
ng/selftests/bpf/progs/dev_cgroup.c
index 8924e06bdef0..79b54a4fa244 100644
--- a/tools/testing/selftests/bpf/progs/dev_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/dev_cgroup.c
@@ -57,4 +57,3 @@ int bpf_prog1(struct bpf_cgroup_dev_ctx *ctx)
 }
=20
 char _license[] SEC("license") =3D "GPL";
-__u32 _version SEC("version") =3D LINUX_VERSION_CODE;
diff --git a/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c b/too=
ls/testing/selftests/bpf/progs/get_cgroup_id_kern.c
index 6b42db2fe391..68587b1de34e 100644
--- a/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c
+++ b/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c
@@ -37,4 +37,3 @@ int trace(void *ctx)
 }
=20
 char _license[] SEC("license") =3D "GPL";
-__u32 _version SEC("version") =3D 1; /* ignored by tracepoints, required=
 by libbpf.a */
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/tes=
ting/selftests/bpf/progs/map_ptr_kern.c
index d1d304c980f0..b1b711d9b214 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -683,5 +683,4 @@ int cg_skb(void *ctx)
 	return 1;
 }
=20
-__u32 _version SEC("version") =3D 1;
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/netcnt_prog.c b/tools/test=
ing/selftests/bpf/progs/netcnt_prog.c
index 43649bce4c54..f718b2c212dc 100644
--- a/tools/testing/selftests/bpf/progs/netcnt_prog.c
+++ b/tools/testing/selftests/bpf/progs/netcnt_prog.c
@@ -68,4 +68,3 @@ int bpf_nextcnt(struct __sk_buff *skb)
 }
=20
 char _license[] SEC("license") =3D "GPL";
-__u32 _version SEC("version") =3D LINUX_VERSION_CODE;
diff --git a/tools/testing/selftests/bpf/progs/sendmsg4_prog.c b/tools/te=
sting/selftests/bpf/progs/sendmsg4_prog.c
index ac5abc34cde8..2c24e7bb6747 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
@@ -18,7 +18,6 @@
 #define DST_PORT		4040
 #define DST_REWRITE_PORT4	4444
=20
-int _version SEC("version") =3D 1;
=20
 SEC("cgroup/sendmsg4")
 int sendmsg_v4_prog(struct bpf_sock_addr *ctx)
diff --git a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c b/tools/te=
sting/selftests/bpf/progs/sendmsg6_prog.c
index 24694b1a8d82..f85a08c996f4 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
@@ -22,7 +22,6 @@
=20
 #define DST_REWRITE_PORT6	6666
=20
-int _version SEC("version") =3D 1;
=20
 SEC("cgroup/sendmsg6")
 int sendmsg_v6_prog(struct bpf_sock_addr *ctx)
diff --git a/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c b/too=
ls/testing/selftests/bpf/progs/sockmap_parse_prog.c
index ca283af80d4e..b82ebc5b2644 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
@@ -2,7 +2,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
=20
-int _version SEC("version") =3D 1;
=20
 SEC("sk_skb1")
 int bpf_prog1(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c b/t=
ools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c
index eeaf6e75c9a2..20869422d373 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c
@@ -3,7 +3,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
=20
-int _version SEC("version") =3D 1;
=20
 SEC("sk_msg1")
 int bpf_prog1(struct sk_msg_md *msg)
diff --git a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c b/t=
ools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
index 73872c535cbb..f2f4c84a806b 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
@@ -2,7 +2,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
=20
-int _version SEC("version") =3D 1;
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
diff --git a/tools/testing/selftests/bpf/progs/sockopt_inherit.c b/tools/=
testing/selftests/bpf/progs/sockopt_inherit.c
index c6d428a8d785..9fb241b97291 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_inherit.c
@@ -3,7 +3,6 @@
 #include <bpf/bpf_helpers.h>
=20
 char _license[] SEC("license") =3D "GPL";
-__u32 _version SEC("version") =3D 1;
=20
 #define SOL_CUSTOM			0xdeadbeef
 #define CUSTOM_INHERIT1			0
diff --git a/tools/testing/selftests/bpf/progs/tcp_rtt.c b/tools/testing/=
selftests/bpf/progs/tcp_rtt.c
index 0cb3204ddb18..0988d79f1587 100644
--- a/tools/testing/selftests/bpf/progs/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/progs/tcp_rtt.c
@@ -3,7 +3,6 @@
 #include <bpf/bpf_helpers.h>
=20
 char _license[] SEC("license") =3D "GPL";
-__u32 _version SEC("version") =3D 1;
=20
 struct tcp_rtt_storage {
 	__u32 invoked;
diff --git a/tools/testing/selftests/bpf/progs/test_btf_haskv.c b/tools/t=
esting/selftests/bpf/progs/test_btf_haskv.c
index 31538c9ed193..4f91a81480c8 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_haskv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_haskv.c
@@ -4,7 +4,6 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_legacy.h"
=20
-int _version SEC("version") =3D 1;
=20
 struct ipv_counts {
 	unsigned int v4;
diff --git a/tools/testing/selftests/bpf/progs/test_btf_newkv.c b/tools/t=
esting/selftests/bpf/progs/test_btf_newkv.c
index 6c5560162746..d0c2dbd811f2 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_newkv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_newkv.c
@@ -4,7 +4,6 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_legacy.h"
=20
-int _version SEC("version") =3D 1;
=20
 struct ipv_counts {
 	unsigned int v4;
diff --git a/tools/testing/selftests/bpf/progs/test_btf_nokv.c b/tools/te=
sting/selftests/bpf/progs/test_btf_nokv.c
index 506da7fd2da2..09d55e0efe5e 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_nokv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_nokv.c
@@ -3,7 +3,6 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
=20
-int _version SEC("version") =3D 1;
=20
 struct ipv_counts {
 	unsigned int v4;
diff --git a/tools/testing/selftests/bpf/progs/test_l4lb.c b/tools/testin=
g/selftests/bpf/progs/test_l4lb.c
index 33493911d87a..b51621946f2d 100644
--- a/tools/testing/selftests/bpf/progs/test_l4lb.c
+++ b/tools/testing/selftests/bpf/progs/test_l4lb.c
@@ -21,7 +21,6 @@
 #include "test_iptunnel_common.h"
 #include <bpf/bpf_endian.h>
=20
-int _version SEC("version") =3D 1;
=20
 static inline __u32 rol32(__u32 word, unsigned int shift)
 {
diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/=
testing/selftests/bpf/progs/test_map_in_map.c
index a6d91932dcd5..f416032ba858 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
@@ -47,5 +47,4 @@ int xdp_mimtest0(struct xdp_md *ctx)
 	return XDP_PASS;
 }
=20
-int _version SEC("version") =3D 1;
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_pinning.c b/tools/tes=
ting/selftests/bpf/progs/test_pinning.c
index 4ef2630292b2..eff949ecc100 100644
--- a/tools/testing/selftests/bpf/progs/test_pinning.c
+++ b/tools/testing/selftests/bpf/progs/test_pinning.c
@@ -3,7 +3,6 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
=20
-int _version SEC("version") =3D 1;
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
diff --git a/tools/testing/selftests/bpf/progs/test_pinning_invalid.c b/t=
ools/testing/selftests/bpf/progs/test_pinning_invalid.c
index 5412e0c732c7..248442a06938 100644
--- a/tools/testing/selftests/bpf/progs/test_pinning_invalid.c
+++ b/tools/testing/selftests/bpf/progs/test_pinning_invalid.c
@@ -3,7 +3,6 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
=20
-int _version SEC("version") =3D 1;
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/=
testing/selftests/bpf/progs/test_pkt_access.c
index 3cfd88141ddc..0558544e1ff0 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -15,7 +15,6 @@
 #include <bpf/bpf_endian.h>
=20
 #define barrier() __asm__ __volatile__("": : :"memory")
-int _version SEC("version") =3D 1;
=20
 /* llvm will optimize both subprograms into exactly the same BPF assembl=
y
  *
diff --git a/tools/testing/selftests/bpf/progs/test_queue_stack_map.h b/t=
ools/testing/selftests/bpf/progs/test_queue_stack_map.h
index 4dd9806ad73b..4fa32369f188 100644
--- a/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
+++ b/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
@@ -8,7 +8,6 @@
 #include <linux/pkt_cls.h>
 #include <bpf/bpf_helpers.h>
=20
-int _version SEC("version") =3D 1;
=20
 struct {
 	__uint(type, MAP_TYPE);
diff --git a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern=
.c b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
index 0f9bc258225e..bb1f3a2c06b2 100644
--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -15,7 +15,6 @@
 #include <bpf/bpf_helpers.h>
 #include "test_select_reuseport_common.h"
=20
-int _version SEC("version") =3D 1;
=20
 #ifndef offsetof
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/t=
esting/selftests/bpf/progs/test_sk_lookup.c
index 48534d810391..19d2465d9442 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -644,4 +644,3 @@ int multi_prog_redir2(struct bpf_sk_lookup *ctx)
 }
=20
 char _license[] SEC("license") =3D "Dual BSD/GPL";
-__u32 _version SEC("version") =3D 1;
diff --git a/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c =
b/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
index 552f2090665c..46d7ce1d568c 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
@@ -42,6 +42,5 @@ int log_cgroup_id(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
=20
-int _version SEC("version") =3D 1;
=20
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/tes=
ting/selftests/bpf/progs/test_skb_ctx.c
index ba4dab09d19c..1d61b36e6067 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -3,7 +3,6 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
=20
-int _version SEC("version") =3D 1;
 char _license[] SEC("license") =3D "GPL";
=20
 SEC("skb_ctx")
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tool=
s/testing/selftests/bpf/progs/test_sockmap_kern.h
index 1858435de7aa..2966564b8497 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
@@ -361,5 +361,4 @@ int bpf_prog10(struct sk_msg_md *msg)
 	return SK_DROP;
 }
=20
-int _version SEC("version") =3D 1;
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/to=
ols/testing/selftests/bpf/progs/test_sockmap_listen.c
index 00f1456aaeda..325c9f193432 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
@@ -116,5 +116,4 @@ int prog_reuseport(struct sk_reuseport_md *reuse)
 	return verdict;
 }
=20
-int _version SEC("version") =3D 1;
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c=
 b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
index 7449fdb1763b..36a707e7c7a7 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
@@ -73,4 +73,3 @@ int oncpu(struct random_urandom_args *args)
 }
=20
 char _license[] SEC("license") =3D "GPL";
-__u32 _version SEC("version") =3D 1; /* ignored by tracepoints, required=
 by libbpf.a */
diff --git a/tools/testing/selftests/bpf/progs/test_static_linked1.c b/to=
ols/testing/selftests/bpf/progs/test_static_linked1.c
index 4f0b612e1661..4c3869bb73c4 100644
--- a/tools/testing/selftests/bpf/progs/test_static_linked1.c
+++ b/tools/testing/selftests/bpf/progs/test_static_linked1.c
@@ -27,4 +27,3 @@ int handler1(const void *ctx)
 }
=20
 char LICENSE[] SEC("license") =3D "GPL";
-int VERSION SEC("version") =3D 1;
diff --git a/tools/testing/selftests/bpf/progs/test_static_linked2.c b/to=
ols/testing/selftests/bpf/progs/test_static_linked2.c
index 766ebd502a60..7d15c361cb8c 100644
--- a/tools/testing/selftests/bpf/progs/test_static_linked2.c
+++ b/tools/testing/selftests/bpf/progs/test_static_linked2.c
@@ -28,4 +28,3 @@ int handler2(const void *ctx)
=20
 /* different name and/or type of the variable doesn't matter */
 char _license[] SEC("license") =3D "GPL";
-int _version SEC("version") =3D 1;
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_estats.c b/tools/=
testing/selftests/bpf/progs/test_tcp_estats.c
index adc83a54c352..2c5c602c6011 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_estats.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
@@ -255,4 +255,3 @@ int _dummy_tracepoint(struct dummy_tracepoint_args *a=
rg)
 }
=20
 char _license[] SEC("license") =3D "GPL";
-__u32 _version SEC("version") =3D 1; /* ignored by tracepoints, required=
 by libbpf.a */
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools=
/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index 94f50f7e94d6..3ded05280757 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -16,7 +16,6 @@
 #include "test_tcpbpf.h"
=20
 struct tcpbpf_globals global =3D {};
-int _version SEC("version") =3D 1;
=20
 /**
  * SOL_TCP is defined in <netinet/tcp.h> while
diff --git a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c b/to=
ols/testing/selftests/bpf/progs/test_tcpnotify_kern.c
index 24e9344994ef..f307deba6332 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
@@ -28,7 +28,6 @@ struct {
 	__type(value, __u32);
 } perf_event_map SEC(".maps");
=20
-int _version SEC("version") =3D 1;
=20
 SEC("sockops")
 int bpf_testcb(struct bpf_sock_ops *skops)
diff --git a/tools/testing/selftests/bpf/progs/test_tracepoint.c b/tools/=
testing/selftests/bpf/progs/test_tracepoint.c
index 4b825ee122cf..ce6974016f53 100644
--- a/tools/testing/selftests/bpf/progs/test_tracepoint.c
+++ b/tools/testing/selftests/bpf/progs/test_tracepoint.c
@@ -23,4 +23,3 @@ int oncpu(struct sched_switch_args *ctx)
 }
=20
 char _license[] SEC("license") =3D "GPL";
-__u32 _version SEC("version") =3D 1; /* ignored by tracepoints, required=
 by libbpf.a */
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools=
/testing/selftests/bpf/progs/test_tunnel_kern.c
index e7b673117436..ee37d8c25205 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -26,7 +26,6 @@
 		bpf_trace_printk(fmt, sizeof(fmt), __LINE__, ret); \
 	} while (0)
=20
-int _version SEC("version") =3D 1;
=20
 struct geneve_opt {
 	__be16	opt_class;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing=
/selftests/bpf/progs/test_xdp.c
index e6aa2fc6ce6b..106710738053 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp.c
@@ -20,7 +20,6 @@
 #include <bpf/bpf_endian.h>
 #include "test_iptunnel_common.h"
=20
-int _version SEC("version") =3D 1;
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/te=
sting/selftests/bpf/progs/test_xdp_loop.c
index 27eb52dda92c..818b8e3911c4 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
@@ -16,7 +16,6 @@
 #include <bpf/bpf_endian.h>
 #include "test_iptunnel_common.h"
=20
-int _version SEC("version") =3D 1;
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_redirect.c b/tool=
s/testing/selftests/bpf/progs/test_xdp_redirect.c
index a5337cd9400b..00fe9c1a15bc 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
@@ -12,7 +12,6 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
=20
-int _version SEC("version") =3D 1;
=20
 SEC("redirect_to_111")
 int xdp_redirect_to_111(struct xdp_md *xdp)
--=20
2.30.2

