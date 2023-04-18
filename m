Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640FF6E55B2
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjDRAWI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Apr 2023 20:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjDRAWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:22:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A594C21
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:05 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLHqhM012311
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:05 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q1c681f6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:05 -0700
Received: from twshared32017.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 17:22:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id ACF382E4F3563; Mon, 17 Apr 2023 17:21:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/6] libbpf: misc internal libbpf clean ups around log fixup
Date:   Mon, 17 Apr 2023 17:21:43 -0700
Message-ID: <20230418002148.3255690-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418002148.3255690-1-andrii@kernel.org>
References: <20230418002148.3255690-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bvfuQNQ0gzwOY8cBhnkAbdXiFPwh4Wng
X-Proofpoint-GUID: bvfuQNQ0gzwOY8cBhnkAbdXiFPwh4Wng
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

Normalize internal constants, field names, and comments related to log
fixup. Also add explicit `ext_idx` alias for relocation where relocation
is pointing to extern description for additional information.

No functional changes, just a clean up before subsequent additions.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49cd304ae3bc..a382ed3586bd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -333,6 +333,7 @@ struct reloc_desc {
 		struct {
 			int map_idx;
 			int sym_off;
+			int ext_idx;
 		};
 	};
 };
@@ -4042,7 +4043,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		else
 			reloc_desc->type = RELO_EXTERN_LD64;
 		reloc_desc->insn_idx = insn_idx;
-		reloc_desc->sym_off = i; /* sym_off stores extern index */
+		reloc_desc->ext_idx = i;
 		return 0;
 	}
 
@@ -5811,8 +5812,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 }
 
 /* base map load ldimm64 special constant, used also for log fixup logic */
-#define MAP_LDIMM64_POISON_BASE 2001000000
-#define MAP_LDIMM64_POISON_PFX "200100"
+#define POISON_LDIMM64_MAP_BASE 2001000000
+#define POISON_LDIMM64_MAP_PFX "200100"
 
 static void poison_map_ldimm64(struct bpf_program *prog, int relo_idx,
 			       int insn_idx, struct bpf_insn *insn,
@@ -5834,7 +5835,7 @@ static void poison_map_ldimm64(struct bpf_program *prog, int relo_idx,
 		 * invalid func unknown#2001000123
 		 * where lower 123 is map index into obj->maps[] array
 		 */
-		insn->imm = MAP_LDIMM64_POISON_BASE + map_idx;
+		insn->imm = POISON_LDIMM64_MAP_BASE + map_idx;
 
 		insn++;
 	}
@@ -5885,7 +5886,7 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 			}
 			break;
 		case RELO_EXTERN_LD64:
-			ext = &obj->externs[relo->sym_off];
+			ext = &obj->externs[relo->ext_idx];
 			if (ext->type == EXT_KCFG) {
 				if (obj->gen_loader) {
 					insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
@@ -5907,7 +5908,7 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 			}
 			break;
 		case RELO_EXTERN_CALL:
-			ext = &obj->externs[relo->sym_off];
+			ext = &obj->externs[relo->ext_idx];
 			insn[0].src_reg = BPF_PSEUDO_KFUNC_CALL;
 			if (ext->is_set) {
 				insn[0].imm = ext->ksym.kernel_btf_id;
@@ -7022,13 +7023,13 @@ static void fixup_log_missing_map_load(struct bpf_program *prog,
 				       char *buf, size_t buf_sz, size_t log_sz,
 				       char *line1, char *line2, char *line3)
 {
-	/* Expected log for failed and not properly guarded CO-RE relocation:
+	/* Expected log for failed and not properly guarded map reference:
 	 * line1 -> 123: (85) call unknown#2001000345
 	 * line2 -> invalid func unknown#2001000345
 	 * line3 -> <anything else or end of buffer>
 	 *
 	 * "123" is the index of the instruction that was poisoned.
-	 * "345" in "2001000345" are map index in obj->maps to fetch map name.
+	 * "345" in "2001000345" is a map index in obj->maps to fetch map name.
 	 */
 	struct bpf_object *obj = prog->obj;
 	const struct bpf_map *map;
@@ -7038,7 +7039,7 @@ static void fixup_log_missing_map_load(struct bpf_program *prog,
 	if (sscanf(line1, "%d: (%*d) call unknown#%d\n", &insn_idx, &map_idx) != 2)
 		return;
 
-	map_idx -= MAP_LDIMM64_POISON_BASE;
+	map_idx -= POISON_LDIMM64_MAP_BASE;
 	if (map_idx < 0 || map_idx >= obj->nr_maps)
 		return;
 	map = &obj->maps[map_idx];
@@ -7070,20 +7071,21 @@ static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_s
 		if (!cur_line)
 			return;
 
-		/* failed CO-RE relocation case */
 		if (str_has_pfx(cur_line, "invalid func unknown#195896080\n")) {
 			prev_line = find_prev_line(buf, cur_line);
 			if (!prev_line)
 				continue;
 
+			/* failed CO-RE relocation case */
 			fixup_log_failed_core_relo(prog, buf, buf_sz, log_sz,
 						   prev_line, cur_line, next_line);
 			return;
-		} else if (str_has_pfx(cur_line, "invalid func unknown#"MAP_LDIMM64_POISON_PFX)) {
+		} else if (str_has_pfx(cur_line, "invalid func unknown#"POISON_LDIMM64_MAP_PFX)) {
 			prev_line = find_prev_line(buf, cur_line);
 			if (!prev_line)
 				continue;
 
+			/* reference to uncreated BPF map */
 			fixup_log_missing_map_load(prog, buf, buf_sz, log_sz,
 						   prev_line, cur_line, next_line);
 			return;
@@ -7098,7 +7100,7 @@ static int bpf_program_record_relos(struct bpf_program *prog)
 
 	for (i = 0; i < prog->nr_reloc; i++) {
 		struct reloc_desc *relo = &prog->reloc_desc[i];
-		struct extern_desc *ext = &obj->externs[relo->sym_off];
+		struct extern_desc *ext = &obj->externs[relo->ext_idx];
 		int kind;
 
 		switch (relo->type) {
-- 
2.34.1

