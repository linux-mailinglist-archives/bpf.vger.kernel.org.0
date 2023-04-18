Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B19A6E55B5
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDRAWL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Apr 2023 20:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDRAWI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:22:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626204C2F
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:06 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33I0041x004030
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:05 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3q1g9d030b-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:05 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Apr 2023 17:22:03 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CCDA62E4F358B; Mon, 17 Apr 2023 17:21:55 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 3/6] libbpf: improve handling of unresolved kfuncs
Date:   Mon, 17 Apr 2023 17:21:45 -0700
Message-ID: <20230418002148.3255690-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418002148.3255690-1-andrii@kernel.org>
References: <20230418002148.3255690-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MWt7llKttHC49asSrTQEVTTimQsWB3bR
X-Proofpoint-GUID: MWt7llKttHC49asSrTQEVTTimQsWB3bR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, libbpf leaves `call #0` instruction for __weak unresolved
kfuncs, which might lead to a confusing verifier log situations, where
invalid `call #0` will be treated as successfully validated.

We can do better. Libbpf already has an established mechanism of
poisoning instructions that failed some form of resolution (e.g., CO-RE
relocation and BPF map set to not be auto-created). Libbpf doesn't fail
them outright to allow users to guard them through other means, and as
long as BPF verifier can prove that such poisoned instructions cannot be
ever reached, this doesn't consistute an invalid BPF program. If user
didn't guard such code, libbpf will extract few pieces of information to
tie such poisoned instructions back to additional information about what
entitity wasn't resolved (e.g., BPF map name, or CO-RE relocation
information).

__weak unresolved kfuncs fit this model well, so this patch extends
libbpf with poisioning and log fixup logic for kfunc calls.

Note, this poisoning is done only for kfunc *calls*, not kfunc address
resolution (ldimm64 instructions). The former cannot be ever valid, if
reached, so it's safe to poison them. The latter is a valid mechanism to
check if __weak kfunc ksym was resolved, and do necessary guarding and
work arounds based on this result, supported in most recent kernels. As
such, libbpf keeps such ldimm64 instructions as loading zero, never
poisoning them.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 72 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0a11563067b3..2600d8384252 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5841,6 +5841,30 @@ static void poison_map_ldimm64(struct bpf_program *prog, int relo_idx,
 	}
 }
 
+/* unresolved kfunc call special constant, used also for log fixup logic */
+#define POISON_CALL_KFUNC_BASE 2002000000
+#define POISON_CALL_KFUNC_PFX "2002"
+
+static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
+			      int insn_idx, struct bpf_insn *insn,
+			      int ext_idx, const struct extern_desc *ext)
+{
+	pr_debug("prog '%s': relo #%d: poisoning insn #%d that calls kfunc '%s'\n",
+		 prog->name, relo_idx, insn_idx, ext->name);
+
+	/* we turn kfunc call into invalid helper call with identifiable constant */
+	insn->code = BPF_JMP | BPF_CALL;
+	insn->dst_reg = 0;
+	insn->src_reg = 0;
+	insn->off = 0;
+	/* if this instruction is reachable (not a dead code),
+	 * verifier will complain with something like:
+	 * invalid func unknown#2001000123
+	 * where lower 123 is extern index into obj->externs[] array
+	 */
+	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
+}
+
 /* Relocate data references within program code:
  *  - map references;
  *  - global variable references;
@@ -5913,9 +5937,9 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 			if (ext->is_set) {
 				insn[0].imm = ext->ksym.kernel_btf_id;
 				insn[0].off = ext->ksym.btf_fd_idx;
-			} else { /* unresolved weak kfunc */
-				insn[0].imm = 0;
-				insn[0].off = 0;
+			} else { /* unresolved weak kfunc call */
+				poison_kfunc_call(prog, i, relo->insn_idx, insn,
+						  relo->ext_idx, ext);
 			}
 			break;
 		case RELO_SUBPROG_ADDR:
@@ -7052,6 +7076,39 @@ static void fixup_log_missing_map_load(struct bpf_program *prog,
 	patch_log(buf, buf_sz, log_sz, line1, line3 - line1, patch);
 }
 
+static void fixup_log_missing_kfunc_call(struct bpf_program *prog,
+					 char *buf, size_t buf_sz, size_t log_sz,
+					 char *line1, char *line2, char *line3)
+{
+	/* Expected log for failed and not properly guarded kfunc call:
+	 * line1 -> 123: (85) call unknown#2002000345
+	 * line2 -> invalid func unknown#2002000345
+	 * line3 -> <anything else or end of buffer>
+	 *
+	 * "123" is the index of the instruction that was poisoned.
+	 * "345" in "2002000345" is an extern index in obj->externs to fetch kfunc name.
+	 */
+	struct bpf_object *obj = prog->obj;
+	const struct extern_desc *ext;
+	int insn_idx, ext_idx;
+	char patch[128];
+
+	if (sscanf(line1, "%d: (%*d) call unknown#%d\n", &insn_idx, &ext_idx) != 2)
+		return;
+
+	ext_idx -= POISON_CALL_KFUNC_BASE;
+	if (ext_idx < 0 || ext_idx >= obj->nr_extern)
+		return;
+	ext = &obj->externs[ext_idx];
+
+	snprintf(patch, sizeof(patch),
+		 "%d: <invalid kfunc call>\n"
+		 "kfunc '%s' is referenced but wasn't resolved\n",
+		 insn_idx, ext->name);
+
+	patch_log(buf, buf_sz, log_sz, line1, line3 - line1, patch);
+}
+
 static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz)
 {
 	/* look for familiar error patterns in last N lines of the log */
@@ -7089,6 +7146,15 @@ static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_s
 			fixup_log_missing_map_load(prog, buf, buf_sz, log_sz,
 						   prev_line, cur_line, next_line);
 			return;
+		} else if (str_has_pfx(cur_line, "invalid func unknown#"POISON_CALL_KFUNC_PFX)) {
+			prev_line = find_prev_line(buf, cur_line);
+			if (!prev_line)
+				continue;
+
+			/* reference to unresolved kfunc */
+			fixup_log_missing_kfunc_call(prog, buf, buf_sz, log_sz,
+						     prev_line, cur_line, next_line);
+			return;
 		}
 	}
 }
-- 
2.34.1

