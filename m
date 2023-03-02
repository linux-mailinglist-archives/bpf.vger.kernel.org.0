Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADB66A8D1C
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCBXfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 18:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCBXfi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:35:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098C4303CE
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:35:36 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KVNiC021135
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:35:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=caa/FkPpN3jpLxMKin40dcKuasBISl3kdVuOH/DD31k=;
 b=Ss57BPR5Swblgng8TtjRBIiHCu7P88arTPrF1ENyTSirZVM1OpmWUMR8R2jhrjmIpn4K
 qp9AMzkGof4mY/l9F+puwY7PVj9ghiaJzgosFNJ3PjSwEXnPnokkEtJ1spUHBofd4Tp5
 wCxns/KFjR5NF6tPPtMfjAhGYXIikot0z8c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2xg6kk91-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:35:36 -0800
Received: from twshared33736.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:35:34 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id C62C018582242; Thu,  2 Mar 2023 15:35:29 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 bpf-next] selftests/bpf: Add -Wuninitialized flag to bpf prog flags
Date:   Thu, 2 Mar 2023 15:35:28 -0800
Message-ID: <20230302233528.532299-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LzpmQr5wbwweghBZb-Tj4uyaPNVUe2WB
X-Proofpoint-ORIG-GUID: LzpmQr5wbwweghBZb-Tj4uyaPNVUe2WB
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Per C99 standard [0], Section 6.7.8, Paragraph 10:

  If an object that has automatic storage duration is not initialized
  explicitly, its value is indeterminate.

And in the same document, in appendix "J.2 Undefined behavior":

  The behavior is undefined in the following circumstances:
  [...]
  The value of an object with automatic storage duration is used while
  it is indeterminate (6.2.4, 6.7.8, 6.8).

This means that use of an uninitialized stack variable is undefined
behavior, and therefore that clang can choose to do a variety of scary
things, such as not generating bytecode for "bunch of useful code" in
the below example:

  void some_func()
  {
    int i;
    if (!i)
      return;
    // bunch of useful code
  }

To add insult to injury, if some_func above is a helper function for
some BPF program, clang can choose to not generate an "exit" insn,
causing verifier to fail with "last insn is not an exit or jmp". Going
from that verification failure to the root cause of uninitialized use
is certain to be frustrating.

This patch adds -Wuninitialized to the cflags for selftest BPF progs and
fixes up existing instances of uninitialized use.

  [0]: https://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Cc: David Vernet <void@manifault.com>
Cc: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
Changelog:

v1 -> v2: https://lore.kernel.org/bpf/20230302231924.344383-1-davemarchevsk=
y@fb.com/
  * Return 1 instead of -1 from tc prog (Alexei)
  * Add David Vernet ack

 tools/testing/selftests/bpf/Makefile                   |  2 +-
 tools/testing/selftests/bpf/progs/rbtree.c             |  2 +-
 tools/testing/selftests/bpf/progs/rbtree_fail.c        |  5 +++--
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c      |  2 +-
 .../testing/selftests/bpf/progs/test_sk_lookup_kern.c  |  2 +-
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c   | 10 +++++-----
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index f40606a85a0f..eab3cf5399f5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -357,7 +357,7 @@ BPF_CFLAGS =3D -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(=
MENDIAN) 		\
 	     -I$(abspath $(OUTPUT)/../usr/include)
=20
 CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES) \
-	       -Wno-compare-distinct-pointer-types
+	       -Wno-compare-distinct-pointer-types -Wuninitialized
=20
 $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS +=3D -fno-inline
 $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS +=3D -fno-inline
diff --git a/tools/testing/selftests/bpf/progs/rbtree.c b/tools/testing/sel=
ftests/bpf/progs/rbtree.c
index e5db1a4287e5..4c90aa6abddd 100644
--- a/tools/testing/selftests/bpf/progs/rbtree.c
+++ b/tools/testing/selftests/bpf/progs/rbtree.c
@@ -75,7 +75,7 @@ SEC("tc")
 long rbtree_add_and_remove(void *ctx)
 {
 	struct bpf_rb_node *res =3D NULL;
-	struct node_data *n, *m;
+	struct node_data *n, *m =3D NULL;
=20
 	n =3D bpf_obj_new(typeof(*n));
 	if (!n)
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testin=
g/selftests/bpf/progs/rbtree_fail.c
index bf3cba115897..4614cd7bfa46 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -232,8 +232,9 @@ long rbtree_api_first_release_unlock_escape(void *ctx)
=20
 	bpf_spin_lock(&glock);
 	res =3D bpf_rbtree_first(&groot);
-	if (res)
-		n =3D container_of(res, struct node_data, node);
+	if (!res)
+		return 1;
+	n =3D container_of(res, struct node_data, node);
 	bpf_spin_unlock(&glock);
=20
 	bpf_spin_lock(&glock);
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/=
tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index 2fbef3cc7ad8..2dde8e3fe4c9 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -48,7 +48,7 @@ SEC("?lsm.s/bpf")
 __failure __msg("arg#0 expected pointer to stack or dynptr_ptr")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int=
 size)
 {
-	unsigned long val;
+	unsigned long val =3D 0;
=20
 	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
 					  (struct bpf_dynptr *)val, NULL);
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tool=
s/testing/selftests/bpf/progs/test_sk_lookup_kern.c
index b502e5c92e33..6ccf6d546074 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
@@ -23,8 +23,8 @@ static struct bpf_sock_tuple *get_tuple(void *data, __u64=
 nh_off,
 					bool *ipv4)
 {
 	struct bpf_sock_tuple *result;
+	__u64 ihl_len =3D 0;
 	__u8 proto =3D 0;
-	__u64 ihl_len;
=20
 	if (eth_proto =3D=3D bpf_htons(ETH_P_IP)) {
 		struct iphdr *iph =3D (struct iphdr *)(data + nh_off);
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/t=
esting/selftests/bpf/progs/test_tunnel_kern.c
index 508da4a23c4f..95b4aa0928ba 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -324,11 +324,11 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 SEC("tc")
 int vxlan_set_tunnel_dst(struct __sk_buff *skb)
 {
-	int ret;
 	struct bpf_tunnel_key key;
 	struct vxlan_metadata md;
 	__u32 index =3D 0;
 	__u32 *local_ip =3D NULL;
+	int ret =3D 0;
=20
 	local_ip =3D bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
@@ -363,11 +363,11 @@ int vxlan_set_tunnel_dst(struct __sk_buff *skb)
 SEC("tc")
 int vxlan_set_tunnel_src(struct __sk_buff *skb)
 {
-	int ret;
 	struct bpf_tunnel_key key;
 	struct vxlan_metadata md;
 	__u32 index =3D 0;
 	__u32 *local_ip =3D NULL;
+	int ret =3D 0;
=20
 	local_ip =3D bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
@@ -494,9 +494,9 @@ SEC("tc")
 int ip6vxlan_set_tunnel_dst(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
-	int ret;
 	__u32 index =3D 0;
 	__u32 *local_ip;
+	int ret =3D 0;
=20
 	local_ip =3D bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
@@ -525,9 +525,9 @@ SEC("tc")
 int ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
-	int ret;
 	__u32 index =3D 0;
 	__u32 *local_ip;
+	int ret =3D 0;
=20
 	local_ip =3D bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
@@ -556,9 +556,9 @@ SEC("tc")
 int ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
-	int ret;
 	__u32 index =3D 0;
 	__u32 *local_ip;
+	int ret =3D 0;
=20
 	local_ip =3D bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
--=20
2.30.2

