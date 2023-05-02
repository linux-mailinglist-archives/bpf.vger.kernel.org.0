Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677736F4D6F
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjEBXJW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 May 2023 19:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjEBXJV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:09:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B6A35AA
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:09:19 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JXMXE014899
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 16:09:19 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qak8d9vbt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 16:09:19 -0700
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 16:09:17 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7A7942FD4BDD6; Tue,  2 May 2023 16:06:39 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 08/10] bpf: use recorded BPF prog effective caps when fetching helper protos
Date:   Tue, 2 May 2023 16:06:17 -0700
Message-ID: <20230502230619.2592406-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502230619.2592406-1-andrii@kernel.org>
References: <20230502230619.2592406-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6Y3vy4EMuSh8wt4yBhytPzS5hScB2WKi
X-Proofpoint-ORIG-GUID: 6Y3vy4EMuSh8wt4yBhytPzS5hScB2WKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of performing extra bpf_capable() and perfmon_capable() calls
inside bpf_base_func_proto() function (and other similar ones) to
determine eligibility of a given BPF helper for a given program, use
previously recorded effective capabilities of the verified program given
to it during BPF_PROG_LOAD command handling.

This prevents any potential races and makes
prog->aux->{bpf,perfmon}_capable the source of truth for decisions on
what BPF program is allowed to use.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 drivers/media/rc/bpf-lirc.c |  2 +-
 include/linux/bpf.h         |  5 +++--
 kernel/bpf/cgroup.c         |  6 +++---
 kernel/bpf/helpers.c        |  6 +++---
 kernel/bpf/syscall.c        |  4 ++--
 kernel/trace/bpf_trace.c    |  2 +-
 net/core/filter.c           | 32 ++++++++++++++++----------------
 net/ipv4/bpf_tcp_ca.c       |  2 +-
 net/netfilter/nf_bpf_link.c |  2 +-
 9 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index fe17c7f98e81..f580326f7a96 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -110,7 +110,7 @@ lirc_mode2_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
 	case BPF_FUNC_trace_printk:
-		if (perfmon_capable())
+		if (prog->aux->perfmon_capable)
 			return bpf_get_trace_printk_proto();
 		fallthrough;
 	default:
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 44ccfea0f73b..a5832a69f24e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2328,7 +2328,8 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 struct bpf_prog *bpf_prog_by_id(u32 id);
 struct bpf_link *bpf_link_by_id(u32 id);
 
-const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
+const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id,
+						 const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
 void bpf_cgrp_storage_free(struct cgroup *cgroup);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
@@ -2567,7 +2568,7 @@ static inline int btf_struct_access(struct bpf_verifier_log *log,
 }
 
 static inline const struct bpf_func_proto *
-bpf_base_func_proto(enum bpf_func_id func_id)
+bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a06e118a9be5..097fc69acfe9 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1615,7 +1615,7 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
 
@@ -2158,7 +2158,7 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
 
@@ -2315,7 +2315,7 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb6b4637ebf2..020e03f625b5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1663,7 +1663,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_str_proto __weak;
 const struct bpf_func_proto bpf_task_pt_regs_proto __weak;
 
 const struct bpf_func_proto *
-bpf_base_func_proto(enum bpf_func_id func_id)
+bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
@@ -1714,7 +1714,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		break;
 	}
 
-	if (!bpf_capable())
+	if (!prog->aux->bpf_capable)
 		return NULL;
 
 	switch (func_id) {
@@ -1772,7 +1772,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		break;
 	}
 
-	if (!perfmon_capable())
+	if (!prog->aux->perfmon_capable)
 		return NULL;
 
 	switch (func_id) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 839f69d75297..6dac69c6ec26 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5331,7 +5331,7 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
 const struct bpf_func_proto * __weak
 tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-	return bpf_base_func_proto(func_id);
+	return bpf_base_func_proto(func_id, prog);
 }
 
 BPF_CALL_1(bpf_sys_close, u32, fd)
@@ -5381,7 +5381,7 @@ syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_sys_bpf:
-		return !perfmon_capable() ? NULL : &bpf_sys_bpf_proto;
+		return !prog->aux->perfmon_capable ? NULL : &bpf_sys_bpf_proto;
 	case BPF_FUNC_btf_find_by_name_kind:
 		return &bpf_btf_find_by_name_kind_proto;
 	case BPF_FUNC_sys_close:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8deb22a99abe..f79606347e4f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1511,7 +1511,7 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
 
diff --git a/net/core/filter.c b/net/core/filter.c
index d9ce04ca22ce..8e282797e658 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -83,7 +83,7 @@
 #include <net/netfilter/nf_conntrack_bpf.h>
 
 static const struct bpf_func_proto *
-bpf_sk_base_func_proto(enum bpf_func_id func_id);
+bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 
 int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int len)
 {
@@ -7724,7 +7724,7 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
 
@@ -7807,7 +7807,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 			return NULL;
 		}
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
 
@@ -7826,7 +7826,7 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_skb_event_output_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
 
@@ -8013,7 +8013,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #endif
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
 
@@ -8072,7 +8072,7 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #endif
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 
 #if IS_MODULE(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)
@@ -8133,7 +8133,7 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_tcp_sock_proto;
 #endif /* CONFIG_INET */
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
 
@@ -8175,7 +8175,7 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
 
@@ -8219,7 +8219,7 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skc_lookup_tcp_proto;
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
 
@@ -8230,7 +8230,7 @@ flow_dissector_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_load_bytes:
 		return &bpf_flow_dissector_load_bytes_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
 
@@ -8257,7 +8257,7 @@ lwt_out_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_under_cgroup:
 		return &bpf_skb_under_cgroup_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
 
@@ -11088,7 +11088,7 @@ sk_reuseport_func_proto(enum bpf_func_id func_id,
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
 
@@ -11270,7 +11270,7 @@ sk_lookup_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
 
@@ -11604,7 +11604,7 @@ const struct bpf_func_proto bpf_sock_from_file_proto = {
 };
 
 static const struct bpf_func_proto *
-bpf_sk_base_func_proto(enum bpf_func_id func_id)
+bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	const struct bpf_func_proto *func;
 
@@ -11633,10 +11633,10 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 
-	if (!perfmon_capable())
+	if (!prog->aux->perfmon_capable)
 		return NULL;
 
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
 
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index c36da56d756f..d7786ea9c01a 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -219,7 +219,7 @@ static bool nf_is_valid_access(int off, int size, enum bpf_access_type type,
 static const struct bpf_func_proto *
 bpf_nf_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-	return bpf_base_func_proto(func_id);
+	return bpf_base_func_proto(func_id, prog);
 }
 
 const struct bpf_verifier_ops netfilter_verifier_ops = {
-- 
2.34.1

