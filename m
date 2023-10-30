Return-Path: <bpf+bounces-13640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D37DC196
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 22:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C71C20B86
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 21:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2E1C2BD;
	Mon, 30 Oct 2023 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ue7cds++"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884F1A736
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 21:07:15 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170CDD
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:07:12 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39UIur7h000497
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:07:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=asp6YdHyWwBnL8uN67LjUVXm9K5m7yO6bA6/LKK6FCE=;
 b=Ue7cds++cbp7yVAheiQwsi6Ql8vpwAuB397Sv8bjDsfMIuEzdhGa2tQ7TUB5o39MoPyn
 y4aD7XsmqcnFmtYHsSeDESuSGlIsjbS8VqcFn9Uj/+FpqP82GFjfo3IMpzdWb6g98UF0
 SNn7iItm9dPnUN/3OiVWuymM96JO4iLqhaw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u2j748v54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:07:11 -0700
Received: from twshared5337.08.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:07:10 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 2F9142688A483; Mon, 30 Oct 2023 14:06:45 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH v1 bpf-next] bpf: Add __bpf_kfunc_{start,end}_defs macros
Date: Mon, 30 Oct 2023 14:06:38 -0700
Message-ID: <20231030210638.2415306-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: GHXuujlSO-blBUoucAPKRNGXYmpIU1Xw
X-Proofpoint-ORIG-GUID: GHXuujlSO-blBUoucAPKRNGXYmpIU1Xw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02

BPF kfuncs are meant to be called from BPF programs. Accordingly, most
kfuncs are not called from anywhere in the kernel, which the
-Wmissing-prototypes warning is unhappy about. We've peppered
__diag_ignore_all("-Wmissing-prototypes", ... everywhere kfuncs are
defined in the codebase to suppress this warning.

This patch adds two macros meant to bound one or many kfunc definitions.
All existing kfunc definitions which use these __diag calls to suppress
-Wmissing-prototypes are migrated to use the newly-introduced macros.
A new __diag_ignore_all - for "-Wmissing-declarations" - is added to the
__bpf_kfunc_start_defs macro based on feedback from Andrii on an earlier
version of this patch [0] and another recent mailing list thread [1].

In the future we might need to ignore different warnings or do other
kfunc-specific things. This change will make it easier to make such
modifications for all kfunc defs.

  [0]: https://lore.kernel.org/bpf/CAEf4BzaE5dRWtK6RPLnjTW-MW9sx9K3Fn6uwqCT=
ChK2Dcb1Xig@mail.gmail.com/
  [1]: https://lore.kernel.org/bpf/ZT+2qCc%2FaXep0%2FLf@krava/

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>
---

This patch was submitted earlier as part of task_vma
iter series: https://lore.kernel.org/bpf/20231013204426.1074286-6-davemarch=
evsky@fb.com/

This separate submission addresses Andrii's comments from
that thread.

 include/linux/btf.h              |  9 +++++++++
 kernel/bpf/bpf_iter.c            |  6 ++----
 kernel/bpf/cpumask.c             |  6 ++----
 kernel/bpf/helpers.c             |  6 ++----
 kernel/bpf/map_iter.c            |  6 ++----
 kernel/bpf/task_iter.c           |  6 ++----
 kernel/trace/bpf_trace.c         |  6 ++----
 net/bpf/test_run.c               |  7 +++----
 net/core/filter.c                | 13 ++++---------
 net/core/xdp.c                   |  6 ++----
 net/ipv4/fou_bpf.c               |  6 ++----
 net/netfilter/nf_conntrack_bpf.c |  6 ++----
 net/netfilter/nf_nat_bpf.c       |  6 ++----
 net/xfrm/xfrm_interface_bpf.c    |  6 ++----
 14 files changed, 38 insertions(+), 57 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index c2231c64d60b..dc5ce962f600 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -84,6 +84,15 @@
  */
 #define __bpf_kfunc __used noinline
=20
+#define __bpf_kfunc_start_defs()					       \
+	__diag_push();							       \
+	__diag_ignore_all("-Wmissing-declarations",			       \
+			  "Global kfuncs as their definitions will be in BTF");\
+	__diag_ignore_all("-Wmissing-prototypes",			       \
+			  "Global kfuncs as their definitions will be in BTF")
+
+#define __bpf_kfunc_end_defs() __diag_pop()
+
 /*
  * Return the name of the passed struct, if exists, or halt the build if f=
or
  * example the structure gets renamed. In this way, developers have to rev=
isit
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 833faa04461b..0fae79164187 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -782,9 +782,7 @@ struct bpf_iter_num_kern {
 	int end; /* final value, exclusive */
 } __aligned(8);
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc_start_defs();
=20
 __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int e=
nd)
 {
@@ -843,4 +841,4 @@ __bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_n=
um *it)
 	s->cur =3D s->end =3D 0;
 }
=20
-__diag_pop();
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 6983af8e093c..e01c741e54e7 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -34,9 +34,7 @@ static bool cpu_valid(u32 cpu)
 	return cpu < nr_cpu_ids;
 }
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global kfuncs as their definitions will be in BTF");
+__bpf_kfunc_start_defs();
=20
 /**
  * bpf_cpumask_create() - Create a mutable BPF cpumask.
@@ -407,7 +405,7 @@ __bpf_kfunc u32 bpf_cpumask_any_and_distribute(const st=
ruct cpumask *src1,
 	return cpumask_any_and_distribute(src1, src2);
 }
=20
-__diag_pop();
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(cpumask_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e46ac288a108..0e4657606eaa 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1886,9 +1886,7 @@ void bpf_rb_root_free(const struct btf_field *field, =
void *rb_root,
 	}
 }
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc_start_defs();
=20
 __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 {
@@ -2505,7 +2503,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
=20
-__diag_pop();
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(generic_btf_ids)
 #ifdef CONFIG_KEXEC_CORE
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 6fc9dae9edc8..6abd7c5df4b3 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -193,9 +193,7 @@ static int __init bpf_map_iter_init(void)
=20
 late_initcall(bpf_map_iter_init);
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc_start_defs();
=20
 __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
 {
@@ -213,7 +211,7 @@ __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf=
_map *map)
 	return ret;
 }
=20
-__diag_pop();
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(bpf_map_iter_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_map_sum_elem_count, KF_TRUSTED_ARGS)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 59e747938bdb..19518f5ba7a3 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -824,9 +824,7 @@ struct bpf_iter_task_vma_kern {
 	struct bpf_iter_task_vma_kern_data *data;
 } __attribute__((aligned(8)));
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc_start_defs();
=20
 __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 				      struct task_struct *task, u64 addr)
@@ -892,7 +890,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_i=
ter_task_vma *it)
 	}
 }
=20
-__diag_pop();
+__bpf_kfunc_end_defs();
=20
 struct bpf_iter_css_task {
 	__u64 __opaque[1];
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index df697c74d519..84e8a0f6e4e0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1252,9 +1252,7 @@ static const struct bpf_func_proto bpf_get_func_arg_c=
nt_proto =3D {
 };
=20
 #ifdef CONFIG_KEYS
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "kfuncs which will be used in BPF programs");
+__bpf_kfunc_start_defs();
=20
 /**
  * bpf_lookup_user_key - lookup a key by its serial
@@ -1404,7 +1402,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf=
_dynptr_kern *data_ptr,
 }
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
=20
-__diag_pop();
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(key_sig_kfunc_set)
 BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEE=
PABLE)
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0841f8d82419..c9fdcc5cdce1 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -503,9 +503,8 @@ static int bpf_test_finish(const union bpf_attr *kattr,
  * architecture dependent calling conventions. 7+ can be supported in the
  * future.
  */
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc_start_defs();
+
 __bpf_kfunc int bpf_fentry_test1(int a)
 {
 	return a + 1;
@@ -605,7 +604,7 @@ __bpf_kfunc void bpf_kfunc_call_memb_release(struct pro=
g_test_member *p)
 {
 }
=20
-__diag_pop();
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
diff --git a/net/core/filter.c b/net/core/filter.c
index 21d75108c2e9..383f96b0a1c7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11767,9 +11767,7 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 	return func;
 }
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
 				    struct bpf_dynptr_kern *ptr__uninit)
 {
@@ -11816,7 +11814,7 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct b=
pf_sock_addr_kern *sa_kern,
=20
 	return 0;
 }
-__diag_pop();
+__bpf_kfunc_end_defs();
=20
 int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
 			       struct bpf_dynptr_kern *ptr__uninit)
@@ -11879,10 +11877,7 @@ static int __init bpf_kfunc_init(void)
 }
 late_initcall(bpf_kfunc_init);
=20
-/* Disables missing prototype warnings */
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc_start_defs();
=20
 /* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
  *
@@ -11916,7 +11911,7 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common=
 *sock)
 	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
 }
=20
-__diag_pop()
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(bpf_sk_iter_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
diff --git a/net/core/xdp.c b/net/core/xdp.c
index df4789ab512d..b6f1d6dab3f2 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -696,9 +696,7 @@ struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf)
 	return nxdpf;
 }
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc_start_defs();
=20
 /**
  * bpf_xdp_metadata_rx_timestamp - Read XDP frame RX timestamp.
@@ -738,7 +736,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct x=
dp_md *ctx, u32 *hash,
 	return -EOPNOTSUPP;
 }
=20
-__diag_pop();
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(xdp_metadata_kfunc_ids)
 #define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name, KF_T=
RUSTED_ARGS)
diff --git a/net/ipv4/fou_bpf.c b/net/ipv4/fou_bpf.c
index 3760a14b6b57..4da03bf45c9b 100644
--- a/net/ipv4/fou_bpf.c
+++ b/net/ipv4/fou_bpf.c
@@ -22,9 +22,7 @@ enum bpf_fou_encap_type {
 	FOU_BPF_ENCAP_GUE,
 };
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in BTF");
+__bpf_kfunc_start_defs();
=20
 /* bpf_skb_set_fou_encap - Set FOU encap parameters
  *
@@ -100,7 +98,7 @@ __bpf_kfunc int bpf_skb_get_fou_encap(struct __sk_buff *=
skb_ctx,
 	return 0;
 }
=20
-__diag_pop()
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(fou_kfunc_set)
 BTF_ID_FLAGS(func, bpf_skb_set_fou_encap)
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_=
bpf.c
index b21799d468d2..475358ec8212 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -230,9 +230,7 @@ static int _nf_conntrack_btf_struct_access(struct bpf_v=
erifier_log *log,
 	return 0;
 }
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in nf_conntrack BTF");
+__bpf_kfunc_start_defs();
=20
 /* bpf_xdp_ct_alloc - Allocate a new CT entry
  *
@@ -467,7 +465,7 @@ __bpf_kfunc int bpf_ct_change_status(struct nf_conn *nf=
ct, u32 status)
 	return nf_ct_change_status_common(nfct, status);
 }
=20
-__diag_pop()
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(nf_ct_kfunc_set)
 BTF_ID_FLAGS(func, bpf_xdp_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 141ee7783223..6e3b2f58855f 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -12,9 +12,7 @@
 #include <net/netfilter/nf_conntrack_core.h>
 #include <net/netfilter/nf_nat.h>
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in nf_nat BTF");
+__bpf_kfunc_start_defs();
=20
 /* bpf_ct_set_nat_info - Set source or destination nat address
  *
@@ -54,7 +52,7 @@ __bpf_kfunc int bpf_ct_set_nat_info(struct nf_conn___init=
 *nfct,
 	return nf_nat_setup_info(ct, &range, manip) =3D=3D NF_DROP ? -ENOMEM : 0;
 }
=20
-__diag_pop()
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(nf_nat_kfunc_set)
 BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index d74f3fd20f2b..7d5e920141e9 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -27,9 +27,7 @@ struct bpf_xfrm_info {
 	int link;
 };
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in xfrm_interface BTF");
+__bpf_kfunc_start_defs();
=20
 /* bpf_skb_get_xfrm_info - Get XFRM metadata
  *
@@ -93,7 +91,7 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *s=
kb_ctx, const struct bp
 	return 0;
 }
=20
-__diag_pop()
+__bpf_kfunc_end_defs();
=20
 BTF_SET8_START(xfrm_ifc_kfunc_set)
 BTF_ID_FLAGS(func, bpf_skb_get_xfrm_info)
--=20
2.34.1


