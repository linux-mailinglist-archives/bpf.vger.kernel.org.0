Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E034F9E42
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiDHUgz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Apr 2022 16:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiDHUgx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 16:36:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960990CF6
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 13:34:46 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 238JaBxA023643
        for <bpf@vger.kernel.org>; Fri, 8 Apr 2022 13:34:46 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fagmemr3k-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 13:34:46 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 13:34:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AFE7A16FC5A27; Fri,  8 Apr 2022 13:34:40 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/3] libbpf: support target-less SEC() definitions for BTF-backed programs
Date:   Fri, 8 Apr 2022 13:34:32 -0700
Message-ID: <20220408203433.2988727-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408203433.2988727-1-andrii@kernel.org>
References: <20220408203433.2988727-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _0EBaNs4PrP_KslKwRFZAfKCfpC9Tjur
X-Proofpoint-ORIG-GUID: _0EBaNs4PrP_KslKwRFZAfKCfpC9Tjur
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_08,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to previous patch, support target-less definitions like
SEC("fentry"), SEC("freplace"), etc. For such BTF-backed program types
it is expected that user will specify BTF target programmatically at
runtime using bpf_program__set_attach_target() *before* load phase. If
not, libbpf will report this as an error.

Aslo use SEC_ATTACH_BTF flag instead of explicitly listing a set of
types that are expected to require attach_btf_id. This was an accidental
omission during custom SEC() support refactoring.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 49 +++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 81911a1e1f3e..76c0b3a5cde9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6628,17 +6628,32 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
 		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
 
-	if (def & SEC_DEPRECATED)
+	if (def & SEC_DEPRECATED) {
 		pr_warn("SEC(\"%s\") is deprecated, please see https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#bpf-program-sec-annotation-deprecations for details\n",
 			prog->sec_name);
+	}
 
-	if ((prog->type == BPF_PROG_TYPE_TRACING ||
-	     prog->type == BPF_PROG_TYPE_LSM ||
-	     prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
+	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
 		const char *attach_name;
 
-		attach_name = strchr(prog->sec_name, '/') + 1;
+		attach_name = strchr(prog->sec_name, '/');
+		if (!attach_name) {
+			/* if BPF program is annotated with just SEC("fentry")
+			 * (or similar) without declaratively specifying
+			 * target, then it is expected that target will be
+			 * specified with bpf_program__set_attach_target() at
+			 * runtime before BPF object load step. If not, then
+			 * there is nothing to load into the kernel as BPF
+			 * verifier won't be able to validate BPF program
+			 * correctness anyways.
+			 */
+			pr_warn("prog '%s': no BTF-based attach target is specified, use bpf_program__set_attach_target()\n",
+				prog->name);
+			return -EINVAL;
+		}
+		attach_name++; /* skip over / */
+
 		err = libbpf_find_attach_btf_id(prog, attach_name, &btf_obj_fd, &btf_type_id);
 		if (err)
 			return err;
@@ -8684,18 +8699,18 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("raw_tp+",		RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("raw_tracepoint.w+",	RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("raw_tp.w+",		RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
-	SEC_DEF("tp_btf/",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
-	SEC_DEF("fentry/",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
-	SEC_DEF("fmod_ret/",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
-	SEC_DEF("fexit/",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),
-	SEC_DEF("fentry.s/",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
-	SEC_DEF("fmod_ret.s/",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
-	SEC_DEF("fexit.s/",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
-	SEC_DEF("freplace/",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
-	SEC_DEF("lsm/",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
-	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
-	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
-	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
+	SEC_DEF("tp_btf+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fentry+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fmod_ret+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fexit+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
+	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("iter+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
+	SEC_DEF("iter.s+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
 	SEC_DEF("xdp.frags/devmap",	XDP, BPF_XDP_DEVMAP, SEC_XDP_FRAGS),
 	SEC_DEF("xdp/devmap",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
-- 
2.30.2

