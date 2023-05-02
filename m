Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB486F4D73
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjEBXJm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 May 2023 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjEBXJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:09:37 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C82F3AB1
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:09:31 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JX2DN031661
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 16:09:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qatf9fbm3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 16:09:30 -0700
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 16:09:15 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 953E32FD4BE5E; Tue,  2 May 2023 16:06:43 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 10/10] bpf: consistenly use program's recorded capabilities in BPF verifier
Date:   Tue, 2 May 2023 16:06:19 -0700
Message-ID: <20230502230619.2592406-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502230619.2592406-1-andrii@kernel.org>
References: <20230502230619.2592406-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LtclJOKAThZlx1-xghzQZnkiD8GcWE9S
X-Proofpoint-ORIG-GUID: LtclJOKAThZlx1-xghzQZnkiD8GcWE9S
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

Remove remaining direct queries to perfmon_capable() and bpf_capable()
in BPF verifier logic and instead use prog->aux->{bpf,perfmon}_capable
values. This enables to have one place where permissions are checked
and granted for any given BPF program, and after that BPF subsystem will
consistently use the decision.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h    | 16 ++++++++--------
 include/linux/filter.h |  2 +-
 kernel/bpf/core.c      |  2 +-
 kernel/bpf/verifier.c  | 17 ++++++++++-------
 net/core/filter.c      |  4 ++--
 5 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 785b720358f5..8a2af67039fc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2048,26 +2048,26 @@ bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 
 extern int sysctl_unprivileged_bpf_disabled;
 
-static inline bool bpf_allow_ptr_leaks(void)
+static inline bool bpf_allow_ptr_leaks(const struct bpf_prog *prog)
 {
-	return perfmon_capable();
+	return prog->aux->perfmon_capable;
 }
 
-static inline bool bpf_allow_uninit_stack(void)
+static inline bool bpf_allow_uninit_stack(const struct bpf_prog *prog)
 {
-	return perfmon_capable();
+	return prog->aux->perfmon_capable;
 }
 
-static inline bool bpf_bypass_spec_v1(void)
+static inline bool bpf_bypass_spec_v1(const struct bpf_prog *prog)
 {
-	return perfmon_capable();
+	return prog->aux->perfmon_capable;
 }
 
 int bpf_array_adjust_for_spec_v1(union bpf_attr *attr);
 
-static inline bool bpf_bypass_spec_v4(void)
+static inline bool bpf_bypass_spec_v4(const struct bpf_prog *prog)
 {
-	return perfmon_capable();
+	return prog->aux->perfmon_capable;
 }
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9c207d9848e9..95ce7c4ab28d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1112,7 +1112,7 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
 		return false;
 	if (!bpf_jit_harden)
 		return false;
-	if (bpf_jit_harden == 1 && bpf_capable())
+	if (bpf_jit_harden == 1 && prog->aux->bpf_capable)
 		return false;
 
 	return true;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4d057d39c286..c0d60da7e0e0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -661,7 +661,7 @@ static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
 void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
 	if (!bpf_prog_kallsyms_candidate(fp) ||
-	    !bpf_capable())
+	    !fp->aux->bpf_capable)
 		return;
 
 	bpf_prog_ksym_set_addr(fp);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 481aaf189183..7be0abc196db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17194,6 +17194,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
 		func[i]->aux->size_poke_tab = prog->aux->size_poke_tab;
 
+		/* inherit main prog's effective capabilities */
+		func[i]->aux->bpf_capable = prog->aux->bpf_capable;
+		func[i]->aux->perfmon_capable = prog->aux->perfmon_capable;
+
 		for (j = 0; j < prog->aux->size_poke_tab; j++) {
 			struct bpf_jit_poke_descriptor *poke;
 
@@ -18878,7 +18882,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
-	is_priv = bpf_capable();
+
+	env->allow_ptr_leaks = bpf_allow_ptr_leaks(*prog);
+	env->allow_uninit_stack = bpf_allow_uninit_stack(*prog);
+	env->bypass_spec_v1 = bpf_bypass_spec_v1(*prog);
+	env->bypass_spec_v4 = bpf_bypass_spec_v4(*prog);
+	env->bpf_capable = is_priv = (*prog)->aux->bpf_capable;
 
 	bpf_get_btf_vmlinux();
 
@@ -18910,12 +18919,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
 		env->strict_alignment = false;
 
-	env->allow_ptr_leaks = bpf_allow_ptr_leaks();
-	env->allow_uninit_stack = bpf_allow_uninit_stack();
-	env->bypass_spec_v1 = bpf_bypass_spec_v1();
-	env->bypass_spec_v4 = bpf_bypass_spec_v4();
-	env->bpf_capable = bpf_capable();
-
 	if (is_priv)
 		env->test_state_freq = attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 8e282797e658..8a7e86230f2a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8432,7 +8432,7 @@ static bool cg_skb_is_valid_access(int off, int size,
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-		if (!bpf_capable())
+		if (!prog->aux->bpf_capable)
 			return false;
 		break;
 	}
@@ -8444,7 +8444,7 @@ static bool cg_skb_is_valid_access(int off, int size,
 		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
 			break;
 		case bpf_ctx_range(struct __sk_buff, tstamp):
-			if (!bpf_capable())
+			if (!prog->aux->bpf_capable)
 				return false;
 			break;
 		default:
-- 
2.34.1

