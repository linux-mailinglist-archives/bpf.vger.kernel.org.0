Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7671D3E69
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgENUET (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 16:04:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20408 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgENUET (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 16:04:19 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EJtQiE004819
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xESHysaCVJMXDw3mj9vgorPNUKQSp9zBjHMAKUv5K2Q=;
 b=cpgqRvmT9gCO2ofKViFSynNBmqUArDX6ouD2F8mURzFt/qBuQsGbsS51Jzl7pp7IIv+i
 +HPi7522/iGG26WKbWczfzH0he3iAmQ0kTboRK8o1qeb09AjhD/2AaTUwiyps2q+be+6
 FaSIrTyk8z0sdZsuVWb9zVG9VA8iUSgbW9Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x75jf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:17 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 13:04:16 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id B541937009C6; Thu, 14 May 2020 13:04:14 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 3/5] bpf: Introduce bpf_sk_{,ancestor_}cgroup_id helpers
Date:   Thu, 14 May 2020 13:03:47 -0700
Message-ID: <f5884981249ce911f63e9b57ecd5d7d19154ff39.1589486450.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1589486450.git.rdna@fb.com>
References: <cover.1589486450.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_07:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=13 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140176
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With having ability to lookup sockets in cgroup skb programs it becomes
useful to access cgroup id of retrieved sockets so that policies can be
implemented based on origin cgroup of such socket.

For example, a container running in a cgroup can have cgroup skb ingress
program that can lookup peer socket that is sending packets to a process
inside the container and decide whether those packets should be allowed
or denied based on cgroup id of the peer.

More specifically such ingress program can implement intra-host policy
"allow incoming packets only from this same container and not from any
other container on same host" w/o relying on source IP addresses since
quite often it can be the case that containers share same IP address on
the host.

Introduce two new helpers for this use-case: bpf_sk_cgroup_id() and
bpf_sk_ancestor_cgroup_id().

These helpers are similar to existing bpf_skb_{,ancestor_}cgroup_id
helpers with the only difference that sk is used to get cgroup id
instead of skb, and share code with them.

See documentation in UAPI for more details.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/bpf.h       | 36 +++++++++++++++++++-
 net/core/filter.c              | 60 +++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h | 36 +++++++++++++++++++-
 3 files changed, 121 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bfb31c1be219..130367ed10af 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3121,6 +3121,38 @@ union bpf_attr {
  * 		0 on success, or a negative error in case of failure:
  *
  *		**-EOVERFLOW** if an overflow happened: The same object will be trie=
d again.
+ *
+ * u64 bpf_sk_cgroup_id(struct bpf_sock *sk)
+ *	Description
+ *		Return the cgroup v2 id of the socket *sk*.
+ *
+ *		*sk* must be a non-**NULL** pointer to a full socket, e.g. one
+ *		returned from **bpf_sk_lookup_xxx**\ (),
+ *		**bpf_sk_fullsock**\ (), etc. The format of returned id is
+ *		same as in **bpf_skb_cgroup_id**\ ().
+ *
+ *		This helper is available only if the kernel was compiled with
+ *		the **CONFIG_SOCK_CGROUP_DATA** configuration option.
+ *	Return
+ *		The id is returned or 0 in case the id could not be retrieved.
+ *
+ * u64 bpf_sk_ancestor_cgroup_id(struct bpf_sock *sk, int ancestor_level=
)
+ *	Description
+ *		Return id of cgroup v2 that is ancestor of cgroup associated
+ *		with the *sk* at the *ancestor_level*.  The root cgroup is at
+ *		*ancestor_level* zero and each step down the hierarchy
+ *		increments the level. If *ancestor_level* =3D=3D level of cgroup
+ *		associated with *sk*, then return value will be same as that
+ *		of **bpf_sk_cgroup_id**\ ().
+ *
+ *		The helper is useful to implement policies based on cgroups
+ *		that are upper in hierarchy than immediate cgroup associated
+ *		with *sk*.
+ *
+ *		The format of returned id and helper limitations are same as in
+ *		**bpf_sk_cgroup_id**\ ().
+ *	Return
+ *		The id is returned or 0 in case the id could not be retrieved.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3250,7 +3282,9 @@ union bpf_attr {
 	FN(sk_assign),			\
 	FN(ktime_get_boot_ns),		\
 	FN(seq_printf),			\
-	FN(seq_write),
+	FN(seq_write),			\
+	FN(sk_cgroup_id),		\
+	FN(sk_ancestor_cgroup_id),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
diff --git a/net/core/filter.c b/net/core/filter.c
index f88df77d0ad4..648bbce74861 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4003,16 +4003,22 @@ static const struct bpf_func_proto bpf_skb_under_=
cgroup_proto =3D {
 };
=20
 #ifdef CONFIG_SOCK_CGROUP_DATA
+static inline u64 __bpf_sk_cgroup_id(struct sock *sk)
+{
+	struct cgroup *cgrp;
+
+	cgrp =3D sock_cgroup_ptr(&sk->sk_cgrp_data);
+	return cgroup_id(cgrp);
+}
+
 BPF_CALL_1(bpf_skb_cgroup_id, const struct sk_buff *, skb)
 {
 	struct sock *sk =3D skb_to_full_sk(skb);
-	struct cgroup *cgrp;
=20
 	if (!sk || !sk_fullsock(sk))
 		return 0;
=20
-	cgrp =3D sock_cgroup_ptr(&sk->sk_cgrp_data);
-	return cgroup_id(cgrp);
+	return __bpf_sk_cgroup_id(sk);
 }
=20
 static const struct bpf_func_proto bpf_skb_cgroup_id_proto =3D {
@@ -4022,16 +4028,12 @@ static const struct bpf_func_proto bpf_skb_cgroup=
_id_proto =3D {
 	.arg1_type      =3D ARG_PTR_TO_CTX,
 };
=20
-BPF_CALL_2(bpf_skb_ancestor_cgroup_id, const struct sk_buff *, skb, int,
-	   ancestor_level)
+static inline u64 __bpf_sk_ancestor_cgroup_id(struct sock *sk,
+					      int ancestor_level)
 {
-	struct sock *sk =3D skb_to_full_sk(skb);
 	struct cgroup *ancestor;
 	struct cgroup *cgrp;
=20
-	if (!sk || !sk_fullsock(sk))
-		return 0;
-
 	cgrp =3D sock_cgroup_ptr(&sk->sk_cgrp_data);
 	ancestor =3D cgroup_ancestor(cgrp, ancestor_level);
 	if (!ancestor)
@@ -4040,6 +4042,17 @@ BPF_CALL_2(bpf_skb_ancestor_cgroup_id, const struc=
t sk_buff *, skb, int,
 	return cgroup_id(ancestor);
 }
=20
+BPF_CALL_2(bpf_skb_ancestor_cgroup_id, const struct sk_buff *, skb, int,
+	   ancestor_level)
+{
+	struct sock *sk =3D skb_to_full_sk(skb);
+
+	if (!sk || !sk_fullsock(sk))
+		return 0;
+
+	return __bpf_sk_ancestor_cgroup_id(sk, ancestor_level);
+}
+
 static const struct bpf_func_proto bpf_skb_ancestor_cgroup_id_proto =3D =
{
 	.func           =3D bpf_skb_ancestor_cgroup_id,
 	.gpl_only       =3D false,
@@ -4047,6 +4060,31 @@ static const struct bpf_func_proto bpf_skb_ancesto=
r_cgroup_id_proto =3D {
 	.arg1_type      =3D ARG_PTR_TO_CTX,
 	.arg2_type      =3D ARG_ANYTHING,
 };
+
+BPF_CALL_1(bpf_sk_cgroup_id, struct sock *, sk)
+{
+	return __bpf_sk_cgroup_id(sk);
+}
+
+static const struct bpf_func_proto bpf_sk_cgroup_id_proto =3D {
+	.func           =3D bpf_sk_cgroup_id,
+	.gpl_only       =3D false,
+	.ret_type       =3D RET_INTEGER,
+	.arg1_type      =3D ARG_PTR_TO_SOCKET,
+};
+
+BPF_CALL_2(bpf_sk_ancestor_cgroup_id, struct sock *, sk, int, ancestor_l=
evel)
+{
+	return __bpf_sk_ancestor_cgroup_id(sk, ancestor_level);
+}
+
+static const struct bpf_func_proto bpf_sk_ancestor_cgroup_id_proto =3D {
+	.func           =3D bpf_sk_ancestor_cgroup_id,
+	.gpl_only       =3D false,
+	.ret_type       =3D RET_INTEGER,
+	.arg1_type      =3D ARG_PTR_TO_SOCKET,
+	.arg2_type      =3D ARG_ANYTHING,
+};
 #endif
=20
 static unsigned long bpf_xdp_copy(void *dst_buff, const void *src_buff,
@@ -6159,6 +6197,10 @@ cg_skb_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 		return &bpf_skb_cgroup_id_proto;
 	case BPF_FUNC_skb_ancestor_cgroup_id:
 		return &bpf_skb_ancestor_cgroup_id_proto;
+	case BPF_FUNC_sk_cgroup_id:
+		return &bpf_sk_cgroup_id_proto;
+	case BPF_FUNC_sk_ancestor_cgroup_id:
+		return &bpf_sk_ancestor_cgroup_id_proto;
 #endif
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index bfb31c1be219..130367ed10af 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3121,6 +3121,38 @@ union bpf_attr {
  * 		0 on success, or a negative error in case of failure:
  *
  *		**-EOVERFLOW** if an overflow happened: The same object will be trie=
d again.
+ *
+ * u64 bpf_sk_cgroup_id(struct bpf_sock *sk)
+ *	Description
+ *		Return the cgroup v2 id of the socket *sk*.
+ *
+ *		*sk* must be a non-**NULL** pointer to a full socket, e.g. one
+ *		returned from **bpf_sk_lookup_xxx**\ (),
+ *		**bpf_sk_fullsock**\ (), etc. The format of returned id is
+ *		same as in **bpf_skb_cgroup_id**\ ().
+ *
+ *		This helper is available only if the kernel was compiled with
+ *		the **CONFIG_SOCK_CGROUP_DATA** configuration option.
+ *	Return
+ *		The id is returned or 0 in case the id could not be retrieved.
+ *
+ * u64 bpf_sk_ancestor_cgroup_id(struct bpf_sock *sk, int ancestor_level=
)
+ *	Description
+ *		Return id of cgroup v2 that is ancestor of cgroup associated
+ *		with the *sk* at the *ancestor_level*.  The root cgroup is at
+ *		*ancestor_level* zero and each step down the hierarchy
+ *		increments the level. If *ancestor_level* =3D=3D level of cgroup
+ *		associated with *sk*, then return value will be same as that
+ *		of **bpf_sk_cgroup_id**\ ().
+ *
+ *		The helper is useful to implement policies based on cgroups
+ *		that are upper in hierarchy than immediate cgroup associated
+ *		with *sk*.
+ *
+ *		The format of returned id and helper limitations are same as in
+ *		**bpf_sk_cgroup_id**\ ().
+ *	Return
+ *		The id is returned or 0 in case the id could not be retrieved.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3250,7 +3282,9 @@ union bpf_attr {
 	FN(sk_assign),			\
 	FN(ktime_get_boot_ns),		\
 	FN(seq_printf),			\
-	FN(seq_write),
+	FN(seq_write),			\
+	FN(sk_cgroup_id),		\
+	FN(sk_ancestor_cgroup_id),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
--=20
2.24.1

