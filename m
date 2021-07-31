Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F83DC8F3
	for <lists+bpf@lfdr.de>; Sun,  1 Aug 2021 01:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhGaXdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Jul 2021 19:33:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhGaXdU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 31 Jul 2021 19:33:20 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16VNV1CL002725
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 16:33:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qPbAusvCC0vh9RayS6aiS56SFbsZ7sV1bLYIoeqAG5w=;
 b=iUdnFzDKP0OfGD06YemxPJOeLdzfcGyAdG1S2HZ0Yc9kGCXbxHiLsbnyR5GAISofq5e8
 xj9H9itMh4KlylnDev2O0MHEtyet7q3APfIcZTvY64rbZ4F53HKIP2cs1cl7ocCNFxbN
 R2aEQLVDJQCWsFY+W9uSsWqSc52NgYHxvKE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a51ut2rj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 16:33:13 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 16:33:11 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 9608D4B69755; Sat, 31 Jul 2021 16:31:09 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 1/1] bpf: migrate cgroup_bpf to internal cgroup_bpf_attach_type enum
Date:   Sat, 31 Jul 2021 16:30:56 -0700
Message-ID: <20210731233056.850105-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210731233056.850105-1-davemarchevsky@fb.com>
References: <20210731233056.850105-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aMZ-nkQdMlWO2LEeex8tt3lilZHlGjvf
X-Proofpoint-GUID: aMZ-nkQdMlWO2LEeex8tt3lilZHlGjvf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-31_05:2021-07-30,2021-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107310137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add an enum (cgroup_bpf_attach_type) containing only valid cgroup_bpf
attach types and a function to map bpf_attach_type values to the new
enum. Inspired by netns_bpf_attach_type.

Then, migrate cgroup_bpf to use cgroup_bpf_attach_type wherever
possible.  Functionality is unchanged as attach_type_to_prog_type
switches in bpf/syscall.c were preventing non-cgroup programs from
making use of the invalid cgroup_bpf array slots.

As a result struct cgroup_bpf uses 504 fewer bytes relative to when its
arrays were sized using MAX_BPF_ATTACH_TYPE.

bpf_cgroup_storage is notably not migrated as struct
bpf_cgroup_storage_key is part of uapi and contains a bpf_attach_type
member which is not meant to be opaque. Similarly, bpf_cgroup_link
continues to report its bpf_attach_type member to userspace via fdinfo
and bpf_link_info.

To ease disambiguation, bpf_attach_type variables are renamed from
'type' to 'atype' when changed to cgroup_bpf_attach_type.

Regarding testing: biggest concerns here are 1) attach/detach/run for
programs which shouldn't map to a cgroup_bpf_attach_type should continue
to not involve cgroup_bpf codepaths; and 2) attach types that should be
mapped to a cgroup_bpf_attach_type do so correctly and run as expected.

Existing selftests cover both scenarios well. The udp_limit selftest
specifically validates the 2nd case - BPF_CGROUP_INET_SOCK_RELEASE is
larger than MAX_CGROUP_BPF_ATTACH_TYPE so if it were not correctly
mapped to CG_BPF_CGROUP_INET_SOCK_RELEASE the test would fail.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf-cgroup.h     | 200 +++++++++++++++++++++++----------
 include/uapi/linux/bpf.h       |   2 +-
 kernel/bpf/cgroup.c            | 154 +++++++++++++++----------
 net/ipv4/af_inet.c             |   6 +-
 net/ipv4/udp.c                 |   2 +-
 net/ipv6/af_inet6.c            |   6 +-
 net/ipv6/udp.c                 |   2 +-
 tools/include/uapi/linux/bpf.h |   2 +-
 8 files changed, 243 insertions(+), 131 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a74cd1c3bd87..0fdd8931ec5a 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -23,9 +23,91 @@ struct ctl_table_header;
 struct task_struct;
=20
 #ifdef CONFIG_CGROUP_BPF
+enum cgroup_bpf_attach_type {
+	CG_BPF_INVALID =3D -1,
+	CG_BPF_CGROUP_INET_INGRESS =3D 0,
+	CG_BPF_CGROUP_INET_EGRESS,
+	CG_BPF_CGROUP_INET_SOCK_CREATE,
+	CG_BPF_CGROUP_SOCK_OPS,
+	CG_BPF_CGROUP_DEVICE,
+	CG_BPF_CGROUP_INET4_BIND,
+	CG_BPF_CGROUP_INET6_BIND,
+	CG_BPF_CGROUP_INET4_CONNECT,
+	CG_BPF_CGROUP_INET6_CONNECT,
+	CG_BPF_CGROUP_INET4_POST_BIND,
+	CG_BPF_CGROUP_INET6_POST_BIND,
+	CG_BPF_CGROUP_UDP4_SENDMSG,
+	CG_BPF_CGROUP_UDP6_SENDMSG,
+	CG_BPF_CGROUP_SYSCTL,
+	CG_BPF_CGROUP_UDP4_RECVMSG,
+	CG_BPF_CGROUP_UDP6_RECVMSG,
+	CG_BPF_CGROUP_GETSOCKOPT,
+	CG_BPF_CGROUP_SETSOCKOPT,
+	CG_BPF_CGROUP_INET4_GETPEERNAME,
+	CG_BPF_CGROUP_INET6_GETPEERNAME,
+	CG_BPF_CGROUP_INET4_GETSOCKNAME,
+	CG_BPF_CGROUP_INET6_GETSOCKNAME,
+	CG_BPF_CGROUP_INET_SOCK_RELEASE,
+	MAX_CGROUP_BPF_ATTACH_TYPE
+};
+
+static inline enum cgroup_bpf_attach_type
+to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
+{
+	switch (attach_type) {
+	case BPF_CGROUP_INET_INGRESS:
+		return CG_BPF_CGROUP_INET_INGRESS;
+	case BPF_CGROUP_INET_EGRESS:
+		return CG_BPF_CGROUP_INET_EGRESS;
+	case BPF_CGROUP_INET_SOCK_CREATE:
+		return CG_BPF_CGROUP_INET_SOCK_CREATE;
+	case BPF_CGROUP_SOCK_OPS:
+		return CG_BPF_CGROUP_SOCK_OPS;
+	case BPF_CGROUP_DEVICE:
+		return CG_BPF_CGROUP_DEVICE;
+	case BPF_CGROUP_INET4_BIND:
+		return CG_BPF_CGROUP_INET4_BIND;
+	case BPF_CGROUP_INET6_BIND:
+		return CG_BPF_CGROUP_INET6_BIND;
+	case BPF_CGROUP_INET4_CONNECT:
+		return CG_BPF_CGROUP_INET4_CONNECT;
+	case BPF_CGROUP_INET6_CONNECT:
+		return CG_BPF_CGROUP_INET6_CONNECT;
+	case BPF_CGROUP_INET4_POST_BIND:
+		return CG_BPF_CGROUP_INET4_POST_BIND;
+	case BPF_CGROUP_INET6_POST_BIND:
+		return CG_BPF_CGROUP_INET6_POST_BIND;
+	case BPF_CGROUP_UDP4_SENDMSG:
+		return CG_BPF_CGROUP_UDP4_SENDMSG;
+	case BPF_CGROUP_UDP6_SENDMSG:
+		return CG_BPF_CGROUP_UDP6_SENDMSG;
+	case BPF_CGROUP_SYSCTL:
+		return CG_BPF_CGROUP_SYSCTL;
+	case BPF_CGROUP_UDP4_RECVMSG:
+		return CG_BPF_CGROUP_UDP4_RECVMSG;
+	case BPF_CGROUP_UDP6_RECVMSG:
+		return CG_BPF_CGROUP_UDP6_RECVMSG;
+	case BPF_CGROUP_GETSOCKOPT:
+		return CG_BPF_CGROUP_GETSOCKOPT;
+	case BPF_CGROUP_SETSOCKOPT:
+		return CG_BPF_CGROUP_SETSOCKOPT;
+	case BPF_CGROUP_INET4_GETPEERNAME:
+		return CG_BPF_CGROUP_INET4_GETPEERNAME;
+	case BPF_CGROUP_INET6_GETPEERNAME:
+		return CG_BPF_CGROUP_INET6_GETPEERNAME;
+	case BPF_CGROUP_INET4_GETSOCKNAME:
+		return CG_BPF_CGROUP_INET4_GETSOCKNAME;
+	case BPF_CGROUP_INET6_GETSOCKNAME:
+		return CG_BPF_CGROUP_INET6_GETSOCKNAME;
+	case BPF_CGROUP_INET_SOCK_RELEASE:
+		return CG_BPF_CGROUP_INET_SOCK_RELEASE;
+	default:
+		return CG_BPF_INVALID;
+	}
+}
=20
-extern struct static_key_false cgroup_bpf_enabled_key[MAX_BPF_ATTACH_TYP=
E];
-#define cgroup_bpf_enabled(type) static_branch_unlikely(&cgroup_bpf_enab=
led_key[type])
+extern struct static_key_false cgroup_bpf_enabled_key[MAX_CGROUP_BPF_ATT=
ACH_TYPE];
+#define cgroup_bpf_enabled(atype) static_branch_unlikely(&cgroup_bpf_ena=
bled_key[atype])
=20
 #define for_each_cgroup_storage_type(stype) \
 	for (stype =3D 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
@@ -67,15 +149,15 @@ struct bpf_prog_array;
=20
 struct cgroup_bpf {
 	/* array of effective progs in this cgroup */
-	struct bpf_prog_array __rcu *effective[MAX_BPF_ATTACH_TYPE];
+	struct bpf_prog_array __rcu *effective[MAX_CGROUP_BPF_ATTACH_TYPE];
=20
 	/* attached progs to this cgroup and attach flags
 	 * when flags =3D=3D 0 or BPF_F_ALLOW_OVERRIDE the progs list will
 	 * have either zero or one element
 	 * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_PROGS
 	 */
-	struct list_head progs[MAX_BPF_ATTACH_TYPE];
-	u32 flags[MAX_BPF_ATTACH_TYPE];
+	struct list_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
+	u32 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
=20
 	/* list of cgroup shared storages */
 	struct list_head storages;
@@ -115,28 +197,28 @@ int cgroup_bpf_query(struct cgroup *cgrp, const uni=
on bpf_attr *attr,
=20
 int __cgroup_bpf_run_filter_skb(struct sock *sk,
 				struct sk_buff *skb,
-				enum bpf_attach_type type);
+				enum cgroup_bpf_attach_type atype);
=20
 int __cgroup_bpf_run_filter_sk(struct sock *sk,
-			       enum bpf_attach_type type);
+			       enum cgroup_bpf_attach_type atype);
=20
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
-				      enum bpf_attach_type type,
+				      enum cgroup_bpf_attach_type atype,
 				      void *t_ctx,
 				      u32 *flags);
=20
 int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 				     struct bpf_sock_ops_kern *sock_ops,
-				     enum bpf_attach_type type);
+				     enum cgroup_bpf_attach_type atype);
=20
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 min=
or,
-				      short access, enum bpf_attach_type type);
+				      short access, enum cgroup_bpf_attach_type atype);
=20
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
 				   char **buf, size_t *pcount, loff_t *ppos,
-				   enum bpf_attach_type type);
+				   enum cgroup_bpf_attach_type atype);
=20
 int __cgroup_bpf_run_filter_setsockopt(struct sock *sock, int *level,
 				       int *optname, char __user *optval,
@@ -179,9 +261,9 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *=
map, void *key,
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
 	int __ret =3D 0;							      \
-	if (cgroup_bpf_enabled(BPF_CGROUP_INET_INGRESS))		      \
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_INET_INGRESS))		      \
 		__ret =3D __cgroup_bpf_run_filter_skb(sk, skb,		      \
-						    BPF_CGROUP_INET_INGRESS); \
+						    CG_BPF_CGROUP_INET_INGRESS); \
 									      \
 	__ret;								      \
 })
@@ -189,54 +271,54 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map=
 *map, void *key,
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)			       \
 ({									       \
 	int __ret =3D 0;							       \
-	if (cgroup_bpf_enabled(BPF_CGROUP_INET_EGRESS) && sk && sk =3D=3D skb->=
sk) { \
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_INET_EGRESS) && sk && sk =3D=3D sk=
b->sk) { \
 		typeof(sk) __sk =3D sk_to_full_sk(sk);			       \
 		if (sk_fullsock(__sk))					       \
 			__ret =3D __cgroup_bpf_run_filter_skb(__sk, skb,	       \
-						      BPF_CGROUP_INET_EGRESS); \
+						      CG_BPF_CGROUP_INET_EGRESS); \
 	}								       \
 	__ret;								       \
 })
=20
-#define BPF_CGROUP_RUN_SK_PROG(sk, type)				       \
+#define BPF_CGROUP_RUN_SK_PROG(sk, atype)				       \
 ({									       \
 	int __ret =3D 0;							       \
-	if (cgroup_bpf_enabled(type)) {					       \
-		__ret =3D __cgroup_bpf_run_filter_sk(sk, type);		       \
+	if (cgroup_bpf_enabled(atype)) {					       \
+		__ret =3D __cgroup_bpf_run_filter_sk(sk, atype);		       \
 	}								       \
 	__ret;								       \
 })
=20
 #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk)				       \
-	BPF_CGROUP_RUN_SK_PROG(sk, BPF_CGROUP_INET_SOCK_CREATE)
+	BPF_CGROUP_RUN_SK_PROG(sk, CG_BPF_CGROUP_INET_SOCK_CREATE)
=20
 #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk)			       \
-	BPF_CGROUP_RUN_SK_PROG(sk, BPF_CGROUP_INET_SOCK_RELEASE)
+	BPF_CGROUP_RUN_SK_PROG(sk, CG_BPF_CGROUP_INET_SOCK_RELEASE)
=20
 #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk)				       \
-	BPF_CGROUP_RUN_SK_PROG(sk, BPF_CGROUP_INET4_POST_BIND)
+	BPF_CGROUP_RUN_SK_PROG(sk, CG_BPF_CGROUP_INET4_POST_BIND)
=20
 #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk)				       \
-	BPF_CGROUP_RUN_SK_PROG(sk, BPF_CGROUP_INET6_POST_BIND)
+	BPF_CGROUP_RUN_SK_PROG(sk, CG_BPF_CGROUP_INET6_POST_BIND)
=20
-#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, type)				       \
+#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype)				       \
 ({									       \
 	u32 __unused_flags;						       \
 	int __ret =3D 0;							       \
-	if (cgroup_bpf_enabled(type))					       \
-		__ret =3D __cgroup_bpf_run_filter_sock_addr(sk, uaddr, type,     \
+	if (cgroup_bpf_enabled(atype))					       \
+		__ret =3D __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
 							  NULL,		       \
 							  &__unused_flags);    \
 	__ret;								       \
 })
=20
-#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, type, t_ctx)		       \
+#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx)		       \
 ({									       \
 	u32 __unused_flags;						       \
 	int __ret =3D 0;							       \
-	if (cgroup_bpf_enabled(type))	{				       \
+	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret =3D __cgroup_bpf_run_filter_sock_addr(sk, uaddr, type,     \
+		__ret =3D __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
 							  t_ctx,	       \
 							  &__unused_flags);    \
 		release_sock(sk);					       \
@@ -249,13 +331,13 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map=
 *map, void *key,
  * (at bit position 0) is to indicate CAP_NET_BIND_SERVICE capability ch=
eck
  * should be bypassed (BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE).
  */
-#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, type, bind_flags)	=
       \
+#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, bind_flags)=
	       \
 ({									       \
 	u32 __flags =3D 0;						       \
 	int __ret =3D 0;							       \
-	if (cgroup_bpf_enabled(type))	{				       \
+	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret =3D __cgroup_bpf_run_filter_sock_addr(sk, uaddr, type,     \
+		__ret =3D __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
 							  NULL, &__flags);     \
 		release_sock(sk);					       \
 		if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)	       \
@@ -265,33 +347,33 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map=
 *map, void *key,
 })
=20
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk)				       \
-	((cgroup_bpf_enabled(BPF_CGROUP_INET4_CONNECT) ||		       \
-	  cgroup_bpf_enabled(BPF_CGROUP_INET6_CONNECT)) &&		       \
+	((cgroup_bpf_enabled(CG_BPF_CGROUP_INET4_CONNECT) ||		       \
+	  cgroup_bpf_enabled(CG_BPF_CGROUP_INET6_CONNECT)) &&		       \
 	 (sk)->sk_prot->pre_connect)
=20
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr)			       \
-	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, BPF_CGROUP_INET4_CONNECT)
+	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CG_BPF_CGROUP_INET4_CONNECT)
=20
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr)			       \
-	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, BPF_CGROUP_INET6_CONNECT)
+	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CG_BPF_CGROUP_INET6_CONNECT)
=20
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_INET4_CONNECT, NULL)
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CG_BPF_CGROUP_INET4_CONNECT, NUL=
L)
=20
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_INET6_CONNECT, NULL)
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CG_BPF_CGROUP_INET6_CONNECT, NUL=
L)
=20
 #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, t_ctx)		       =
\
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_UDP4_SENDMSG, t_ctx)
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CG_BPF_CGROUP_UDP4_SENDMSG, t_ct=
x)
=20
 #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx)		       =
\
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_UDP6_SENDMSG, t_ctx)
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CG_BPF_CGROUP_UDP6_SENDMSG, t_ct=
x)
=20
 #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr)			\
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_UDP4_RECVMSG, NULL)
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CG_BPF_CGROUP_UDP4_RECVMSG, NULL=
)
=20
 #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr)			\
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_UDP6_RECVMSG, NULL)
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CG_BPF_CGROUP_UDP6_RECVMSG, NULL=
)
=20
 /* The SOCK_OPS"_SK" macro should be used when sock_ops->sk is not a
  * fullsock and its parent fullsock cannot be traced by
@@ -311,33 +393,33 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map=
 *map, void *key,
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(sock_ops, sk)			\
 ({									\
 	int __ret =3D 0;							\
-	if (cgroup_bpf_enabled(BPF_CGROUP_SOCK_OPS))			\
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_SOCK_OPS))			\
 		__ret =3D __cgroup_bpf_run_filter_sock_ops(sk,		\
 							 sock_ops,	\
-							 BPF_CGROUP_SOCK_OPS); \
+							 CG_BPF_CGROUP_SOCK_OPS); \
 	__ret;								\
 })
=20
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops)				       \
 ({									       \
 	int __ret =3D 0;							       \
-	if (cgroup_bpf_enabled(BPF_CGROUP_SOCK_OPS) && (sock_ops)->sk) {       =
\
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_SOCK_OPS) && (sock_ops)->sk) {    =
   \
 		typeof(sk) __sk =3D sk_to_full_sk((sock_ops)->sk);	       \
 		if (__sk && sk_fullsock(__sk))				       \
 			__ret =3D __cgroup_bpf_run_filter_sock_ops(__sk,	       \
 								 sock_ops,     \
-							 BPF_CGROUP_SOCK_OPS); \
+							 CG_BPF_CGROUP_SOCK_OPS); \
 	}								       \
 	__ret;								       \
 })
=20
-#define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor, access)	  =
    \
+#define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access)	 =
     \
 ({									      \
 	int __ret =3D 0;							      \
-	if (cgroup_bpf_enabled(BPF_CGROUP_DEVICE))			      \
-		__ret =3D __cgroup_bpf_check_dev_permission(type, major, minor, \
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_DEVICE))			      \
+		__ret =3D __cgroup_bpf_check_dev_permission(atype, major, minor, \
 							  access,	      \
-							  BPF_CGROUP_DEVICE); \
+							  CG_BPF_CGROUP_DEVICE); \
 									      \
 	__ret;								      \
 })
@@ -346,10 +428,10 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map=
 *map, void *key,
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, buf, count, pos) =
 \
 ({									       \
 	int __ret =3D 0;							       \
-	if (cgroup_bpf_enabled(BPF_CGROUP_SYSCTL))			       \
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_SYSCTL))			       \
 		__ret =3D __cgroup_bpf_run_filter_sysctl(head, table, write,     \
 						       buf, count, pos,        \
-						       BPF_CGROUP_SYSCTL);     \
+						       CG_BPF_CGROUP_SYSCTL);     \
 	__ret;								       \
 })
=20
@@ -357,7 +439,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *=
map, void *key,
 				       kernel_optval)			       \
 ({									       \
 	int __ret =3D 0;							       \
-	if (cgroup_bpf_enabled(BPF_CGROUP_SETSOCKOPT))			       \
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_SETSOCKOPT))			       \
 		__ret =3D __cgroup_bpf_run_filter_setsockopt(sock, level,	       \
 							   optname, optval,    \
 							   optlen,	       \
@@ -368,7 +450,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *=
map, void *key,
 #define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)			       \
 ({									       \
 	int __ret =3D 0;							       \
-	if (cgroup_bpf_enabled(BPF_CGROUP_GETSOCKOPT))			       \
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_GETSOCKOPT))			       \
 		get_user(__ret, optlen);				       \
 	__ret;								       \
 })
@@ -377,7 +459,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *=
map, void *key,
 				       max_optlen, retval)		       \
 ({									       \
 	int __ret =3D retval;						       \
-	if (cgroup_bpf_enabled(BPF_CGROUP_GETSOCKOPT))			       \
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_GETSOCKOPT))			       \
 		if (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
 		    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
 					tcp_bpf_bypass_getsockopt,	       \
@@ -392,7 +474,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *=
map, void *key,
 					    optlen, retval)		       \
 ({									       \
 	int __ret =3D retval;						       \
-	if (cgroup_bpf_enabled(BPF_CGROUP_GETSOCKOPT))			       \
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_GETSOCKOPT))			       \
 		__ret =3D __cgroup_bpf_run_filter_getsockopt_kern(	       \
 			sock, level, optname, optval, optlen, retval);	       \
 	__ret;								       \
@@ -451,14 +533,14 @@ static inline int bpf_percpu_cgroup_storage_update(=
struct bpf_map *map,
 	return 0;
 }
=20
-#define cgroup_bpf_enabled(type) (0)
-#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, type, t_ctx) ({ 0; })
+#define cgroup_bpf_enabled(atype) (0)
+#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx) ({ 0; })
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk,skb) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, type, flags) ({ 0;=
 })
+#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, flags) ({ 0=
; })
 #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr) ({ 0; })
@@ -470,7 +552,7 @@ static inline int bpf_percpu_cgroup_storage_update(st=
ruct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0;=
 })
+#define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) (=
{ 0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0;=
 })
 #define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2db6925e04f4..fba49a37c437 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -84,7 +84,7 @@ struct bpf_lpm_trie_key {
=20
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
-	__u32	attach_type;		/* program attach type */
+	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
 };
=20
 union bpf_iter_link_info {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b567ca46555c..d4eb94154c82 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -19,7 +19,7 @@
=20
 #include "../cgroup/cgroup-internal.h"
=20
-DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_BPF_ATTACH_TYP=
E);
+DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATT=
ACH_TYPE);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
=20
 void cgroup_bpf_offline(struct cgroup *cgrp)
@@ -113,12 +113,12 @@ static void cgroup_bpf_release(struct work_struct *=
work)
 	struct list_head *storages =3D &cgrp->bpf.storages;
 	struct bpf_cgroup_storage *storage, *stmp;
=20
-	unsigned int type;
+	unsigned int atype;
=20
 	mutex_lock(&cgroup_mutex);
=20
-	for (type =3D 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
-		struct list_head *progs =3D &cgrp->bpf.progs[type];
+	for (atype =3D 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
+		struct list_head *progs =3D &cgrp->bpf.progs[atype];
 		struct bpf_prog_list *pl, *pltmp;
=20
 		list_for_each_entry_safe(pl, pltmp, progs, node) {
@@ -128,10 +128,10 @@ static void cgroup_bpf_release(struct work_struct *=
work)
 			if (pl->link)
 				bpf_cgroup_link_auto_detach(pl->link);
 			kfree(pl);
-			static_branch_dec(&cgroup_bpf_enabled_key[type]);
+			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 		}
 		old_array =3D rcu_dereference_protected(
-				cgrp->bpf.effective[type],
+				cgrp->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
 		bpf_prog_array_free(old_array);
 	}
@@ -196,7 +196,7 @@ static u32 prog_list_length(struct list_head *head)
  * if parent has overridable or multi-prog, allow attaching
  */
 static bool hierarchy_allows_attach(struct cgroup *cgrp,
-				    enum bpf_attach_type type)
+				    enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup *p;
=20
@@ -204,12 +204,12 @@ static bool hierarchy_allows_attach(struct cgroup *=
cgrp,
 	if (!p)
 		return true;
 	do {
-		u32 flags =3D p->bpf.flags[type];
+		u32 flags =3D p->bpf.flags[atype];
 		u32 cnt;
=20
 		if (flags & BPF_F_ALLOW_MULTI)
 			return true;
-		cnt =3D prog_list_length(&p->bpf.progs[type]);
+		cnt =3D prog_list_length(&p->bpf.progs[atype]);
 		WARN_ON_ONCE(cnt > 1);
 		if (cnt =3D=3D 1)
 			return !!(flags & BPF_F_ALLOW_OVERRIDE);
@@ -225,7 +225,7 @@ static bool hierarchy_allows_attach(struct cgroup *cg=
rp,
  * to programs in this cgroup
  */
 static int compute_effective_progs(struct cgroup *cgrp,
-				   enum bpf_attach_type type,
+				   enum cgroup_bpf_attach_type atype,
 				   struct bpf_prog_array **array)
 {
 	struct bpf_prog_array_item *item;
@@ -236,8 +236,8 @@ static int compute_effective_progs(struct cgroup *cgr=
p,
=20
 	/* count number of effective programs by walking parents */
 	do {
-		if (cnt =3D=3D 0 || (p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
-			cnt +=3D prog_list_length(&p->bpf.progs[type]);
+		if (cnt =3D=3D 0 || (p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
+			cnt +=3D prog_list_length(&p->bpf.progs[atype]);
 		p =3D cgroup_parent(p);
 	} while (p);
=20
@@ -249,10 +249,10 @@ static int compute_effective_progs(struct cgroup *c=
grp,
 	cnt =3D 0;
 	p =3D cgrp;
 	do {
-		if (cnt > 0 && !(p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
+		if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
 			continue;
=20
-		list_for_each_entry(pl, &p->bpf.progs[type], node) {
+		list_for_each_entry(pl, &p->bpf.progs[atype], node) {
 			if (!prog_list_prog(pl))
 				continue;
=20
@@ -269,10 +269,10 @@ static int compute_effective_progs(struct cgroup *c=
grp,
 }
=20
 static void activate_effective_progs(struct cgroup *cgrp,
-				     enum bpf_attach_type type,
+				     enum cgroup_bpf_attach_type atype,
 				     struct bpf_prog_array *old_array)
 {
-	old_array =3D rcu_replace_pointer(cgrp->bpf.effective[type], old_array,
+	old_array =3D rcu_replace_pointer(cgrp->bpf.effective[atype], old_array=
,
 					lockdep_is_held(&cgroup_mutex));
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
@@ -328,7 +328,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 }
=20
 static int update_effective_progs(struct cgroup *cgrp,
-				  enum bpf_attach_type type)
+				  enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup_subsys_state *css;
 	int err;
@@ -340,7 +340,7 @@ static int update_effective_progs(struct cgroup *cgrp=
,
 		if (percpu_ref_is_zero(&desc->bpf.refcnt))
 			continue;
=20
-		err =3D compute_effective_progs(desc, type, &desc->bpf.inactive);
+		err =3D compute_effective_progs(desc, atype, &desc->bpf.inactive);
 		if (err)
 			goto cleanup;
 	}
@@ -357,7 +357,7 @@ static int update_effective_progs(struct cgroup *cgrp=
,
 			continue;
 		}
=20
-		activate_effective_progs(desc, type, desc->bpf.inactive);
+		activate_effective_progs(desc, atype, desc->bpf.inactive);
 		desc->bpf.inactive =3D NULL;
 	}
=20
@@ -436,11 +436,12 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 			enum bpf_attach_type type, u32 flags)
 {
 	u32 saved_flags =3D (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI)=
);
-	struct list_head *progs =3D &cgrp->bpf.progs[type];
+	struct list_head *progs;
 	struct bpf_prog *old_prog =3D NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D {};
 	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D=
 {};
 	struct bpf_prog_list *pl;
+	enum cgroup_bpf_attach_type atype;
 	int err;
=20
 	if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI)) ||
@@ -454,10 +455,16 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 		/* replace_prog implies BPF_F_REPLACE, and vice versa */
 		return -EINVAL;
=20
-	if (!hierarchy_allows_attach(cgrp, type))
+	atype =3D to_cgroup_bpf_attach_type(type);
+	if (atype < 0)
+		return -EINVAL;
+
+	progs =3D &cgrp->bpf.progs[atype];
+
+	if (!hierarchy_allows_attach(cgrp, atype))
 		return -EPERM;
=20
-	if (!list_empty(progs) && cgrp->bpf.flags[type] !=3D saved_flags)
+	if (!list_empty(progs) && cgrp->bpf.flags[atype] !=3D saved_flags)
 		/* Disallow attaching non-overridable on top
 		 * of existing overridable in this cgroup.
 		 * Disallow attaching multi-prog if overridable or none
@@ -490,16 +497,16 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	pl->prog =3D prog;
 	pl->link =3D link;
 	bpf_cgroup_storages_assign(pl->storage, storage);
-	cgrp->bpf.flags[type] =3D saved_flags;
+	cgrp->bpf.flags[atype] =3D saved_flags;
=20
-	err =3D update_effective_progs(cgrp, type);
+	err =3D update_effective_progs(cgrp, atype);
 	if (err)
 		goto cleanup;
=20
 	if (old_prog)
 		bpf_prog_put(old_prog);
 	else
-		static_branch_inc(&cgroup_bpf_enabled_key[type]);
+		static_branch_inc(&cgroup_bpf_enabled_key[atype]);
 	bpf_cgroup_storages_link(new_storage, cgrp, type);
 	return 0;
=20
@@ -520,7 +527,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
  * all descendant cgroups. This function is guaranteed to succeed.
  */
 static void replace_effective_prog(struct cgroup *cgrp,
-				   enum bpf_attach_type type,
+				   enum cgroup_bpf_attach_type atype,
 				   struct bpf_cgroup_link *link)
 {
 	struct bpf_prog_array_item *item;
@@ -539,10 +546,10 @@ static void replace_effective_prog(struct cgroup *c=
grp,
=20
 		/* find position of link in effective progs array */
 		for (pos =3D 0, cg =3D desc; cg; cg =3D cgroup_parent(cg)) {
-			if (pos && !(cg->bpf.flags[type] & BPF_F_ALLOW_MULTI))
+			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
 				continue;
=20
-			head =3D &cg->bpf.progs[type];
+			head =3D &cg->bpf.progs[atype];
 			list_for_each_entry(pl, head, node) {
 				if (!prog_list_prog(pl))
 					continue;
@@ -554,7 +561,7 @@ static void replace_effective_prog(struct cgroup *cgr=
p,
 found:
 		BUG_ON(!cg);
 		progs =3D rcu_dereference_protected(
-				desc->bpf.effective[type],
+				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
 		item =3D &progs->items[pos];
 		WRITE_ONCE(item->prog, link->link.prog);
@@ -574,11 +581,18 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp=
,
 				struct bpf_cgroup_link *link,
 				struct bpf_prog *new_prog)
 {
-	struct list_head *progs =3D &cgrp->bpf.progs[link->type];
+	struct list_head *progs;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
+	enum cgroup_bpf_attach_type atype;
 	bool found =3D false;
=20
+	atype =3D to_cgroup_bpf_attach_type(link->type);
+	if (atype < 0)
+		return -EINVAL;
+
+	progs =3D &cgrp->bpf.progs[atype];
+
 	if (link->link.prog->type !=3D new_prog->type)
 		return -EINVAL;
=20
@@ -592,7 +606,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 		return -ENOENT;
=20
 	old_prog =3D xchg(&link->link.prog, new_prog);
-	replace_effective_prog(cgrp, link->type, link);
+	replace_effective_prog(cgrp, atype, link);
 	bpf_prog_put(old_prog);
 	return 0;
 }
@@ -667,12 +681,20 @@ static struct bpf_prog_list *find_detach_entry(stru=
ct list_head *progs,
 int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 			struct bpf_cgroup_link *link, enum bpf_attach_type type)
 {
-	struct list_head *progs =3D &cgrp->bpf.progs[type];
-	u32 flags =3D cgrp->bpf.flags[type];
+	struct list_head *progs;
+	u32 flags;
 	struct bpf_prog_list *pl;
 	struct bpf_prog *old_prog;
+	enum cgroup_bpf_attach_type atype;
 	int err;
=20
+	atype =3D to_cgroup_bpf_attach_type(type);
+	if (atype < 0)
+		return -EINVAL;
+
+	progs =3D &cgrp->bpf.progs[atype];
+	flags =3D cgrp->bpf.flags[atype];
+
 	if (prog && link)
 		/* only one of prog or link can be specified */
 		return -EINVAL;
@@ -686,7 +708,7 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct b=
pf_prog *prog,
 	pl->prog =3D NULL;
 	pl->link =3D NULL;
=20
-	err =3D update_effective_progs(cgrp, type);
+	err =3D update_effective_progs(cgrp, atype);
 	if (err)
 		goto cleanup;
=20
@@ -695,10 +717,10 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct=
 bpf_prog *prog,
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
-		cgrp->bpf.flags[type] =3D 0;
+		cgrp->bpf.flags[atype] =3D 0;
 	if (old_prog)
 		bpf_prog_put(old_prog);
-	static_branch_dec(&cgroup_bpf_enabled_key[type]);
+	static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 	return 0;
=20
 cleanup:
@@ -714,13 +736,21 @@ int __cgroup_bpf_query(struct cgroup *cgrp, const u=
nion bpf_attr *attr,
 {
 	__u32 __user *prog_ids =3D u64_to_user_ptr(attr->query.prog_ids);
 	enum bpf_attach_type type =3D attr->query.attach_type;
-	struct list_head *progs =3D &cgrp->bpf.progs[type];
-	u32 flags =3D cgrp->bpf.flags[type];
+	enum cgroup_bpf_attach_type atype;
+	struct list_head *progs;
+	u32 flags;
 	struct bpf_prog_array *effective;
 	struct bpf_prog *prog;
 	int cnt, ret =3D 0, i;
=20
-	effective =3D rcu_dereference_protected(cgrp->bpf.effective[type],
+	atype =3D to_cgroup_bpf_attach_type(type);
+	if (atype < 0)
+		return -EINVAL;
+
+	progs =3D &cgrp->bpf.progs[atype];
+	flags =3D cgrp->bpf.flags[atype];
+
+	effective =3D rcu_dereference_protected(cgrp->bpf.effective[atype],
 					      lockdep_is_held(&cgroup_mutex));
=20
 	if (attr->query.query_flags & BPF_F_QUERY_EFFECTIVE)
@@ -925,14 +955,14 @@ int cgroup_bpf_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
 	link->cgroup =3D cgrp;
 	link->type =3D attr->link_create.attach_type;
=20
-	err  =3D bpf_link_prime(&link->link, &link_primer);
+	err =3D bpf_link_prime(&link->link, &link_primer);
 	if (err) {
 		kfree(link);
 		goto out_put_cgroup;
 	}
=20
-	err =3D cgroup_bpf_attach(cgrp, NULL, NULL, link, link->type,
-				BPF_F_ALLOW_MULTI);
+	err =3D cgroup_bpf_attach(cgrp, NULL, NULL, link,
+				link->type, BPF_F_ALLOW_MULTI);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_cgroup;
@@ -986,7 +1016,7 @@ int cgroup_bpf_prog_query(const union bpf_attr *attr=
,
  */
 int __cgroup_bpf_run_filter_skb(struct sock *sk,
 				struct sk_buff *skb,
-				enum bpf_attach_type type)
+				enum cgroup_bpf_attach_type atype)
 {
 	unsigned int offset =3D skb->data - skb_network_header(skb);
 	struct sock *save_sk;
@@ -1008,11 +1038,11 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 	/* compute pointers for the bpf prog */
 	bpf_compute_and_save_data_end(skb, &saved_data_end);
=20
-	if (type =3D=3D BPF_CGROUP_INET_EGRESS) {
+	if (atype =3D=3D CG_BPF_CGROUP_INET_EGRESS) {
 		ret =3D BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(
-			cgrp->bpf.effective[type], skb, __bpf_prog_run_save_cb);
+			cgrp->bpf.effective[atype], skb, __bpf_prog_run_save_cb);
 	} else {
-		ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], skb,
+		ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[atype], skb,
 					  __bpf_prog_run_save_cb);
 		ret =3D (ret =3D=3D 1 ? 0 : -EPERM);
 	}
@@ -1038,12 +1068,12 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_skb);
  * and if it returned !=3D 1 during execution. In all other cases, 0 is =
returned.
  */
 int __cgroup_bpf_run_filter_sk(struct sock *sk,
-			       enum bpf_attach_type type)
+			       enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup *cgrp =3D sock_cgroup_ptr(&sk->sk_cgrp_data);
 	int ret;
=20
-	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], sk, BPF_PROG_RUN)=
;
+	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[atype], sk, BPF_PROG_RUN=
);
 	return ret =3D=3D 1 ? 0 : -EPERM;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
@@ -1065,7 +1095,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  */
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
-				      enum bpf_attach_type type,
+				      enum cgroup_bpf_attach_type atype,
 				      void *t_ctx,
 				      u32 *flags)
 {
@@ -1090,7 +1120,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *=
sk,
 	}
=20
 	cgrp =3D sock_cgroup_ptr(&sk->sk_cgrp_data);
-	ret =3D BPF_PROG_RUN_ARRAY_FLAGS(cgrp->bpf.effective[type], &ctx,
+	ret =3D BPF_PROG_RUN_ARRAY_FLAGS(cgrp->bpf.effective[atype], &ctx,
 				       BPF_PROG_RUN, flags);
=20
 	return ret =3D=3D 1 ? 0 : -EPERM;
@@ -1115,19 +1145,19 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
  */
 int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 				     struct bpf_sock_ops_kern *sock_ops,
-				     enum bpf_attach_type type)
+				     enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup *cgrp =3D sock_cgroup_ptr(&sk->sk_cgrp_data);
 	int ret;
=20
-	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], sock_ops,
+	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[atype], sock_ops,
 				 BPF_PROG_RUN);
 	return ret =3D=3D 1 ? 0 : -EPERM;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_ops);
=20
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 min=
or,
-				      short access, enum bpf_attach_type type)
+				      short access, enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup *cgrp;
 	struct bpf_cgroup_dev_ctx ctx =3D {
@@ -1139,7 +1169,7 @@ int __cgroup_bpf_check_dev_permission(short dev_typ=
e, u32 major, u32 minor,
=20
 	rcu_read_lock();
 	cgrp =3D task_dfl_cgroup(current);
-	allow =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx,
+	allow =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[atype], &ctx,
 				   BPF_PROG_RUN);
 	rcu_read_unlock();
=20
@@ -1231,7 +1261,7 @@ const struct bpf_verifier_ops cg_dev_verifier_ops =3D=
 {
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
 				   char **buf, size_t *pcount, loff_t *ppos,
-				   enum bpf_attach_type type)
+				   enum cgroup_bpf_attach_type atype)
 {
 	struct bpf_sysctl_kern ctx =3D {
 		.head =3D head,
@@ -1271,7 +1301,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table=
_header *head,
=20
 	rcu_read_lock();
 	cgrp =3D task_dfl_cgroup(current);
-	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx, BPF_PROG_RU=
N);
+	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[atype], &ctx, BPF_PROG_R=
UN);
 	rcu_read_unlock();
=20
 	kfree(ctx.cur_val);
@@ -1289,7 +1319,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table=
_header *head,
=20
 #ifdef CONFIG_NET
 static bool __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
-					     enum bpf_attach_type attach_type)
+					     enum cgroup_bpf_attach_type attach_type)
 {
 	struct bpf_prog_array *prog_array;
 	bool empty;
@@ -1364,7 +1394,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock =
*sk, int *level,
 	 * attached to the hook so we don't waste time allocating
 	 * memory and locking the socket.
 	 */
-	if (__cgroup_bpf_prog_array_is_empty(cgrp, BPF_CGROUP_SETSOCKOPT))
+	if (__cgroup_bpf_prog_array_is_empty(cgrp, CG_BPF_CGROUP_SETSOCKOPT))
 		return 0;
=20
 	/* Allocate a bit more than the initial user buffer for
@@ -1385,7 +1415,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock =
*sk, int *level,
 	}
=20
 	lock_sock(sk);
-	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_SETSOCKOPT],
+	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[CG_BPF_CGROUP_SETSOCKOPT=
],
 				 &ctx, BPF_PROG_RUN);
 	release_sock(sk);
=20
@@ -1460,7 +1490,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock =
*sk, int level,
 	 * attached to the hook so we don't waste time allocating
 	 * memory and locking the socket.
 	 */
-	if (__cgroup_bpf_prog_array_is_empty(cgrp, BPF_CGROUP_GETSOCKOPT))
+	if (__cgroup_bpf_prog_array_is_empty(cgrp, CG_BPF_CGROUP_GETSOCKOPT))
 		return retval;
=20
 	ctx.optlen =3D max_optlen;
@@ -1495,7 +1525,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock =
*sk, int level,
 	}
=20
 	lock_sock(sk);
-	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
+	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[CG_BPF_CGROUP_GETSOCKOPT=
],
 				 &ctx, BPF_PROG_RUN);
 	release_sock(sk);
=20
@@ -1556,7 +1586,7 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct =
sock *sk, int level,
 	 * be called if that data shouldn't be "exported".
 	 */
=20
-	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
+	ret =3D BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[CG_BPF_CGROUP_GETSOCKOPT=
],
 				 &ctx, BPF_PROG_RUN);
 	if (!ret)
 		return -EPERM;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 54648181dd56..3ff88699daef 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -452,7 +452,7 @@ int inet_bind(struct socket *sock, struct sockaddr *u=
addr, int addr_len)
 	 * changes context in a wrong way it will be caught.
 	 */
 	err =3D BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
-						 BPF_CGROUP_INET4_BIND, &flags);
+						 CG_BPF_CGROUP_INET4_BIND, &flags);
 	if (err)
 		return err;
=20
@@ -781,7 +781,7 @@ int inet_getname(struct socket *sock, struct sockaddr=
 *uaddr,
 		sin->sin_port =3D inet->inet_dport;
 		sin->sin_addr.s_addr =3D inet->inet_daddr;
 		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin,
-					    BPF_CGROUP_INET4_GETPEERNAME,
+					    CG_BPF_CGROUP_INET4_GETPEERNAME,
 					    NULL);
 	} else {
 		__be32 addr =3D inet->inet_rcv_saddr;
@@ -790,7 +790,7 @@ int inet_getname(struct socket *sock, struct sockaddr=
 *uaddr,
 		sin->sin_port =3D inet->inet_sport;
 		sin->sin_addr.s_addr =3D addr;
 		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin,
-					    BPF_CGROUP_INET4_GETSOCKNAME,
+					    CG_BPF_CGROUP_INET4_GETSOCKNAME,
 					    NULL);
 	}
 	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 62cd4cd52e84..0f65e91265a7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1130,7 +1130,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg=
, size_t len)
 		rcu_read_unlock();
 	}
=20
-	if (cgroup_bpf_enabled(BPF_CGROUP_UDP4_SENDMSG) && !connected) {
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_UDP4_SENDMSG) && !connected) {
 		err =3D BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
 					    (struct sockaddr *)usin, &ipc.addr);
 		if (err)
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 2389ff702f51..6e98e1615f8f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -454,7 +454,7 @@ int inet6_bind(struct socket *sock, struct sockaddr *=
uaddr, int addr_len)
 	 * changes context in a wrong way it will be caught.
 	 */
 	err =3D BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
-						 BPF_CGROUP_INET6_BIND, &flags);
+						 CG_BPF_CGROUP_INET6_BIND, &flags);
 	if (err)
 		return err;
=20
@@ -531,7 +531,7 @@ int inet6_getname(struct socket *sock, struct sockadd=
r *uaddr,
 		if (np->sndflow)
 			sin->sin6_flowinfo =3D np->flow_label;
 		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin,
-					    BPF_CGROUP_INET6_GETPEERNAME,
+					    CG_BPF_CGROUP_INET6_GETPEERNAME,
 					    NULL);
 	} else {
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
@@ -540,7 +540,7 @@ int inet6_getname(struct socket *sock, struct sockadd=
r *uaddr,
 			sin->sin6_addr =3D sk->sk_v6_rcv_saddr;
 		sin->sin6_port =3D inet->inet_sport;
 		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin,
-					    BPF_CGROUP_INET6_GETSOCKNAME,
+					    CG_BPF_CGROUP_INET6_GETSOCKNAME,
 					    NULL);
 	}
 	sin->sin6_scope_id =3D ipv6_iface_scope_id(&sin->sin6_addr,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 0cc7ba531b34..4086d3ba6d55 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1462,7 +1462,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *m=
sg, size_t len)
 		fl6.saddr =3D np->saddr;
 	fl6.fl6_sport =3D inet->inet_sport;
=20
-	if (cgroup_bpf_enabled(BPF_CGROUP_UDP6_SENDMSG) && !connected) {
+	if (cgroup_bpf_enabled(CG_BPF_CGROUP_UDP6_SENDMSG) && !connected) {
 		err =3D BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
 					   (struct sockaddr *)sin6, &fl6.saddr);
 		if (err)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 2db6925e04f4..fba49a37c437 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -84,7 +84,7 @@ struct bpf_lpm_trie_key {
=20
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
-	__u32	attach_type;		/* program attach type */
+	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
 };
=20
 union bpf_iter_link_info {
--=20
2.30.2

