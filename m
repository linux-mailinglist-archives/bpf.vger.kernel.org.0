Return-Path: <bpf+bounces-3085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ACC739323
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 01:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7776628143D
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B671DDC4;
	Wed, 21 Jun 2023 23:38:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC31D2CF
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 23:38:48 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A0E1731
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:38:46 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LIAW7I009679
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:38:46 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rbwvnpe43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:38:45 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:38:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id A3238333E88F5; Wed, 21 Jun 2023 16:38:32 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v3 bpf-next 11/14] bpf: take into account BPF token when fetching helper protos
Date: Wed, 21 Jun 2023 16:38:06 -0700
Message-ID: <20230621233809.1941811-12-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621233809.1941811-1-andrii@kernel.org>
References: <20230621233809.1941811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jcJOcYjzehiY6fTHbK95VxgdQr4IL-B4
X-Proofpoint-ORIG-GUID: jcJOcYjzehiY6fTHbK95VxgdQr4IL-B4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_13,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Instead of performing unconditional system-wide bpf_capable() and
perfmon_capable() calls inside bpf_base_func_proto() function (and other
similar ones) to determine eligibility of a given BPF helper for a given
program, use previously recorded BPF token during BPF_PROG_LOAD command
handling to inform the decision.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 drivers/media/rc/bpf-lirc.c |  2 +-
 include/linux/bpf.h         |  5 +++--
 kernel/bpf/cgroup.c         |  6 +++---
 kernel/bpf/helpers.c        |  6 +++---
 kernel/bpf/syscall.c        |  5 +++--
 kernel/trace/bpf_trace.c    |  2 +-
 net/core/filter.c           | 32 ++++++++++++++++----------------
 net/ipv4/bpf_tcp_ca.c       |  2 +-
 net/netfilter/nf_bpf_link.c |  2 +-
 9 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index fe17c7f98e81..6d07693c6b9f 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -110,7 +110,7 @@ lirc_mode2_func_proto(enum bpf_func_id func_id, const=
 struct bpf_prog *prog)
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
 	case BPF_FUNC_trace_printk:
-		if (perfmon_capable())
+		if (bpf_token_capable(prog->aux->token, CAP_PERFMON))
 			return bpf_get_trace_printk_proto();
 		fallthrough;
 	default:
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 64dcdc18f09a..0e8680e639cb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2358,7 +2358,8 @@ int btf_check_type_match(struct bpf_verifier_log *l=
og, const struct bpf_prog *pr
 struct bpf_prog *bpf_prog_by_id(u32 id);
 struct bpf_link *bpf_link_by_id(u32 id);
=20
-const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_i=
d);
+const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_i=
d,
+						 const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
 void bpf_cgrp_storage_free(struct cgroup *cgroup);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
@@ -2615,7 +2616,7 @@ static inline int btf_struct_access(struct bpf_veri=
fier_log *log,
 }
=20
 static inline const struct bpf_func_proto *
-bpf_base_func_proto(enum bpf_func_id func_id)
+bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *pro=
g)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..39d6cfb6f304 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1615,7 +1615,7 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, con=
st struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -2173,7 +2173,7 @@ sysctl_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -2330,7 +2330,7 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, con=
st struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9e80efa59a5d..6a740af48908 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1663,7 +1663,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_s=
tr_proto __weak;
 const struct bpf_func_proto bpf_task_pt_regs_proto __weak;
=20
 const struct bpf_func_proto *
-bpf_base_func_proto(enum bpf_func_id func_id)
+bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *pro=
g)
 {
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
@@ -1714,7 +1714,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		break;
 	}
=20
-	if (!bpf_capable())
+	if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 		return NULL;
=20
 	switch (func_id) {
@@ -1772,7 +1772,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		break;
 	}
=20
-	if (!perfmon_capable())
+	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
 		return NULL;
=20
 	switch (func_id) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 364b1efca301..c6a40c90176a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5424,7 +5424,7 @@ static const struct bpf_func_proto bpf_sys_bpf_prot=
o =3D {
 const struct bpf_func_proto * __weak
 tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog =
*prog)
 {
-	return bpf_base_func_proto(func_id);
+	return bpf_base_func_proto(func_id, prog);
 }
=20
 BPF_CALL_1(bpf_sys_close, u32, fd)
@@ -5474,7 +5474,8 @@ syscall_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_sys_bpf:
-		return !perfmon_capable() ? NULL : &bpf_sys_bpf_proto;
+		return !bpf_token_capable(prog->aux->token, CAP_PERFMON)
+		       ? NULL : &bpf_sys_bpf_proto;
 	case BPF_FUNC_btf_find_by_name_kind:
 		return &bpf_btf_find_by_name_kind_proto;
 	case BPF_FUNC_sys_close:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc41e6ac9fe..f5382d8bb690 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1511,7 +1511,7 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
diff --git a/net/core/filter.c b/net/core/filter.c
index 428df050d021..59e5f41f2d5b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -83,7 +83,7 @@
 #include <net/netfilter/nf_conntrack_bpf.h>
=20
 static const struct bpf_func_proto *
-bpf_sk_base_func_proto(enum bpf_func_id func_id);
+bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog);
=20
 int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int =
len)
 {
@@ -7739,7 +7739,7 @@ sock_filter_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -7822,7 +7822,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
 			return NULL;
 		}
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -7841,7 +7841,7 @@ sk_filter_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_skb_event_output_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8028,7 +8028,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, con=
st struct bpf_prog *prog)
 #endif
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8087,7 +8087,7 @@ xdp_func_proto(enum bpf_func_id func_id, const stru=
ct bpf_prog *prog)
 #endif
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
=20
 #if IS_MODULE(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_M=
ODULES)
@@ -8148,7 +8148,7 @@ sock_ops_func_proto(enum bpf_func_id func_id, const=
 struct bpf_prog *prog)
 		return &bpf_tcp_sock_proto;
 #endif /* CONFIG_INET */
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8190,7 +8190,7 @@ sk_msg_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8234,7 +8234,7 @@ sk_skb_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 		return &bpf_skc_lookup_tcp_proto;
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8245,7 +8245,7 @@ flow_dissector_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
 	case BPF_FUNC_skb_load_bytes:
 		return &bpf_flow_dissector_load_bytes_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8272,7 +8272,7 @@ lwt_out_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 	case BPF_FUNC_skb_under_cgroup:
 		return &bpf_skb_under_cgroup_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -11103,7 +11103,7 @@ sk_reuseport_func_proto(enum bpf_func_id func_id,
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -11285,7 +11285,7 @@ sk_lookup_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -11619,7 +11619,7 @@ const struct bpf_func_proto bpf_sock_from_file_pr=
oto =3D {
 };
=20
 static const struct bpf_func_proto *
-bpf_sk_base_func_proto(enum bpf_func_id func_id)
+bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
 {
 	const struct bpf_func_proto *func;
=20
@@ -11648,10 +11648,10 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id=
)
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
=20
-	if (!perfmon_capable())
+	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
 		return NULL;
=20
 	return func;
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 4406d796cc2f..0a3a60e7c282 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -193,7 +193,7 @@ bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index c36da56d756f..d7786ea9c01a 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -219,7 +219,7 @@ static bool nf_is_valid_access(int off, int size, enu=
m bpf_access_type type,
 static const struct bpf_func_proto *
 bpf_nf_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-	return bpf_base_func_proto(func_id);
+	return bpf_base_func_proto(func_id, prog);
 }
=20
 const struct bpf_verifier_ops netfilter_verifier_ops =3D {
--=20
2.34.1


