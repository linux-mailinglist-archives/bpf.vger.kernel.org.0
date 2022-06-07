Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5253F60B
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 08:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiFGG0N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 02:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiFGG0M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 02:26:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6FDC9EC9
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 23:26:11 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25751UY4023227
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 23:26:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GcN76aLgOUnblFFynj0lKz1qn62lp3tfI8frwTq4gPw=;
 b=PaZ0vUy4DbHN8t7RBbVqj9cBHCwkAkc7m6/uLf6YbbBln5TKlQJPHWTbhcXQeP00MeTH
 LukbE8VdwT8Q1L19kk+ZBOHcjDt1LKT3FfFxFUe26mPUTT2awIqWH3fF6I8mcCZ8PYym
 gMAy7fYl+HFCWy/IMU0kkbwsElcI1m7ceOk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ghtny1msq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 23:26:10 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 23:26:10 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 755AAB520F44; Mon,  6 Jun 2022 23:26:05 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v5 02/17] libbpf: Permit 64bit relocation value
Date:   Mon, 6 Jun 2022 23:26:05 -0700
Message-ID: <20220607062605.3716779-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607062554.3716237-1-yhs@fb.com>
References: <20220607062554.3716237-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wJgf6Kotn4NiKsllIxISjYBR5JSXJZww
X-Proofpoint-GUID: wJgf6Kotn4NiKsllIxISjYBR5JSXJZww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_02,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the libbpf limits the relocation value to be 32bit
since all current relocations have such a limit. But with
BTF_KIND_ENUM64 support, the enum value could be 64bit.
So let us permit 64bit relocation value in libbpf.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/relo_core.c | 49 +++++++++++++++++++++------------------
 tools/lib/bpf/relo_core.h |  4 ++--
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index d8ab4c61cb61..0dce5644877b 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -583,7 +583,7 @@ static int bpf_core_spec_match(struct bpf_core_spec *=
local_spec,
 static int bpf_core_calc_field_relo(const char *prog_name,
 				    const struct bpf_core_relo *relo,
 				    const struct bpf_core_spec *spec,
-				    __u32 *val, __u32 *field_sz, __u32 *type_id,
+				    __u64 *val, __u32 *field_sz, __u32 *type_id,
 				    bool *validate)
 {
 	const struct bpf_core_accessor *acc;
@@ -708,7 +708,7 @@ static int bpf_core_calc_field_relo(const char *prog_=
name,
=20
 static int bpf_core_calc_type_relo(const struct bpf_core_relo *relo,
 				   const struct bpf_core_spec *spec,
-				   __u32 *val, bool *validate)
+				   __u64 *val, bool *validate)
 {
 	__s64 sz;
=20
@@ -751,7 +751,7 @@ static int bpf_core_calc_type_relo(const struct bpf_c=
ore_relo *relo,
=20
 static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
 				      const struct bpf_core_spec *spec,
-				      __u32 *val)
+				      __u64 *val)
 {
 	const struct btf_type *t;
 	const struct btf_enum *e;
@@ -929,7 +929,7 @@ int bpf_core_patch_insn(const char *prog_name, struct=
 bpf_insn *insn,
 			int insn_idx, const struct bpf_core_relo *relo,
 			int relo_idx, const struct bpf_core_relo_res *res)
 {
-	__u32 orig_val, new_val;
+	__u64 orig_val, new_val;
 	__u8 class;
=20
 	class =3D BPF_CLASS(insn->code);
@@ -954,28 +954,30 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
 		if (BPF_SRC(insn->code) !=3D BPF_K)
 			return -EINVAL;
 		if (res->validate && insn->imm !=3D orig_val) {
-			pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: =
got %u, exp %u -> %u\n",
+			pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: =
got %u, exp %llu -> %llu\n",
 				prog_name, relo_idx,
-				insn_idx, insn->imm, orig_val, new_val);
+				insn_idx, insn->imm, (unsigned long long)orig_val,
+				(unsigned long long)new_val);
 			return -EINVAL;
 		}
 		orig_val =3D insn->imm;
 		insn->imm =3D new_val;
-		pr_debug("prog '%s': relo #%d: patched insn #%d (ALU/ALU64) imm %u -> =
%u\n",
+		pr_debug("prog '%s': relo #%d: patched insn #%d (ALU/ALU64) imm %llu -=
> %llu\n",
 			 prog_name, relo_idx, insn_idx,
-			 orig_val, new_val);
+			 (unsigned long long)orig_val, (unsigned long long)new_val);
 		break;
 	case BPF_LDX:
 	case BPF_ST:
 	case BPF_STX:
 		if (res->validate && insn->off !=3D orig_val) {
-			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDX/ST/STX) value:=
 got %u, exp %u -> %u\n",
-				prog_name, relo_idx, insn_idx, insn->off, orig_val, new_val);
+			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDX/ST/STX) value:=
 got %u, exp %llu -> %llu\n",
+				prog_name, relo_idx, insn_idx, insn->off, (unsigned long long)orig_v=
al,
+				(unsigned long long)new_val);
 			return -EINVAL;
 		}
 		if (new_val > SHRT_MAX) {
-			pr_warn("prog '%s': relo #%d: insn #%d (LDX/ST/STX) value too big: %u=
\n",
-				prog_name, relo_idx, insn_idx, new_val);
+			pr_warn("prog '%s': relo #%d: insn #%d (LDX/ST/STX) value too big: %l=
lu\n",
+				prog_name, relo_idx, insn_idx, (unsigned long long)new_val);
 			return -ERANGE;
 		}
 		if (res->fail_memsz_adjust) {
@@ -987,8 +989,9 @@ int bpf_core_patch_insn(const char *prog_name, struct=
 bpf_insn *insn,
=20
 		orig_val =3D insn->off;
 		insn->off =3D new_val;
-		pr_debug("prog '%s': relo #%d: patched insn #%d (LDX/ST/STX) off %u ->=
 %u\n",
-			 prog_name, relo_idx, insn_idx, orig_val, new_val);
+		pr_debug("prog '%s': relo #%d: patched insn #%d (LDX/ST/STX) off %llu =
-> %llu\n",
+			 prog_name, relo_idx, insn_idx, (unsigned long long)orig_val,
+			 (unsigned long long)new_val);
=20
 		if (res->new_sz !=3D res->orig_sz) {
 			int insn_bytes_sz, insn_bpf_sz;
@@ -1026,18 +1029,18 @@ int bpf_core_patch_insn(const char *prog_name, st=
ruct bpf_insn *insn,
=20
 		imm =3D insn[0].imm + ((__u64)insn[1].imm << 32);
 		if (res->validate && imm !=3D orig_val) {
-			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: go=
t %llu, exp %u -> %u\n",
+			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: go=
t %llu, exp %llu -> %llu\n",
 				prog_name, relo_idx,
 				insn_idx, (unsigned long long)imm,
-				orig_val, new_val);
+				(unsigned long long)orig_val, (unsigned long long)new_val);
 			return -EINVAL;
 		}
=20
 		insn[0].imm =3D new_val;
-		insn[1].imm =3D 0; /* currently only 32-bit values are supported */
-		pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -=
> %u\n",
+		insn[1].imm =3D new_val >> 32;
+		pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -=
> %llu\n",
 			 prog_name, relo_idx, insn_idx,
-			 (unsigned long long)imm, new_val);
+			 (unsigned long long)imm, (unsigned long long)new_val);
 		break;
 	}
 	default:
@@ -1261,10 +1264,12 @@ int bpf_core_calc_relo_insn(const char *prog_name=
,
 			 * decision and value, otherwise it's dangerous to
 			 * proceed due to ambiguity
 			 */
-			pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %u !=3D=
 %s %u\n",
+			pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %llu =
!=3D %s %llu\n",
 				prog_name, relo_idx,
-				cand_res.poison ? "failure" : "success", cand_res.new_val,
-				targ_res->poison ? "failure" : "success", targ_res->new_val);
+				cand_res.poison ? "failure" : "success",
+				(unsigned long long)cand_res.new_val,
+				targ_res->poison ? "failure" : "success",
+				(unsigned long long)targ_res->new_val);
 			return -EINVAL;
 		}
=20
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 073039d8ca4f..7df0da082f2c 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -46,9 +46,9 @@ struct bpf_core_spec {
=20
 struct bpf_core_relo_res {
 	/* expected value in the instruction, unless validate =3D=3D false */
-	__u32 orig_val;
+	__u64 orig_val;
 	/* new value that needs to be patched up to */
-	__u32 new_val;
+	__u64 new_val;
 	/* relocation unsuccessful, poison instruction, but don't fail load */
 	bool poison;
 	/* some relocations can't be validated against orig_val */
--=20
2.30.2

