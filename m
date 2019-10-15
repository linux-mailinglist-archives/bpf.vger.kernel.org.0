Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D6FD7F09
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2019 20:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfJOS3k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Oct 2019 14:29:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40024 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727179AbfJOS3k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Oct 2019 14:29:40 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9FIP40h013581
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 11:29:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Wth3TblfuH52Y0mxIF7mfv4B8sqkOzoY1xhg+p0m1PE=;
 b=WzczzczbO7laKm+XxRfXqc8Gu6i76SeYSpURjhfdgmeq8Vp7yE38GZzTTkm29BTVOXiP
 fb1tyaiUmY3ckj13E/0nxAt0Zh83aLOKDhi6ZOegcl38AR3WTWy7NYRhHZX/SX8/5jdz
 mNinOcHGS7t27fcaA0wyrQkloqcokJafLJY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vnf1whk8n-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 11:29:39 -0700
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 15 Oct 2019 11:28:56 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 76E24861983; Tue, 15 Oct 2019 11:28:56 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 3/5] libbpf: add support for field existance CO-RE relocation
Date:   Tue, 15 Oct 2019 11:28:47 -0700
Message-ID: <20191015182849.3922287-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015182849.3922287-1-andriin@fb.com>
References: <20191015182849.3922287-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_06:2019-10-15,2019-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=8 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910150156
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for BPF_FRK_EXISTS relocation kind to detect existence of
captured field in a destination BTF, allowing conditional logic to
handle incompatible differences between kernels.

Also introduce opt-in relaxed CO-RE relocation handling option, which
makes libbpf emit warning for failed relocations, but proceed with other
relocations. Instruction, for which relocation failed, is patched with
(u32)-1 value.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 74 +++++++++++++++++++++++++++++++++---------
 tools/lib/bpf/libbpf.h |  4 ++-
 2 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index db3308b91806..8d565590ce05 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -249,6 +249,7 @@ struct bpf_object {
 
 	bool loaded;
 	bool has_pseudo_calls;
+	bool relaxed_core_relocs;
 
 	/*
 	 * Information when doing elf related work. Only valid if fd
@@ -2771,26 +2772,54 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
 
 /*
  * Patch relocatable BPF instruction.
- * Expected insn->imm value is provided for validation, as well as the new
- * relocated value.
+ *
+ * Patched value is determined by relocation kind and target specification.
+ * For field existence relocation target spec will be NULL if field is not
+ * found.
+ * Expected insn->imm value is determined using relocation kind and local
+ * spec, and is checked before patching instruction. If actual insn->imm value
+ * is wrong, bail out with error.
  *
  * Currently three kinds of BPF instructions are supported:
  * 1. rX = <imm> (assignment with immediate operand);
  * 2. rX += <imm> (arithmetic operations with immediate operand);
- * 3. *(rX) = <imm> (indirect memory assignment with immediate operand).
- *
- * If actual insn->imm value is wrong, bail out.
  */
-static int bpf_core_reloc_insn(struct bpf_program *prog, int insn_off,
-			       __u32 orig_off, __u32 new_off)
+static int bpf_core_reloc_insn(struct bpf_program *prog,
+			       const struct bpf_field_reloc *relo,
+			       const struct bpf_core_spec *local_spec,
+			       const struct bpf_core_spec *targ_spec)
 {
+	__u32 orig_val, new_val;
 	struct bpf_insn *insn;
 	int insn_idx;
 	__u8 class;
 
-	if (insn_off % sizeof(struct bpf_insn))
+	if (relo->insn_off % sizeof(struct bpf_insn))
 		return -EINVAL;
-	insn_idx = insn_off / sizeof(struct bpf_insn);
+	insn_idx = relo->insn_off / sizeof(struct bpf_insn);
+
+	switch (relo->kind) {
+	case BPF_FIELD_BYTE_OFFSET:
+		orig_val = local_spec->offset;
+		if (targ_spec) {
+			new_val = targ_spec->offset;
+		} else {
+			pr_warning("prog '%s': patching insn #%d w/ failed reloc, imm %d -> %d\n",
+				   bpf_program__title(prog, false), insn_idx,
+				   orig_val, -1);
+			new_val = (__u32)-1;
+		}
+		break;
+	case BPF_FIELD_EXISTS:
+		orig_val = 1; /* can't generate EXISTS relo w/o local field */
+		new_val = targ_spec ? 1 : 0;
+		break;
+	default:
+		pr_warning("prog '%s': unknown relo %d at insn #%d'\n",
+			   bpf_program__title(prog, false),
+			   relo->kind, insn_idx);
+		return -EINVAL;
+	}
 
 	insn = &prog->insns[insn_idx];
 	class = BPF_CLASS(insn->code);
@@ -2798,12 +2827,12 @@ static int bpf_core_reloc_insn(struct bpf_program *prog, int insn_off,
 	if (class == BPF_ALU || class == BPF_ALU64) {
 		if (BPF_SRC(insn->code) != BPF_K)
 			return -EINVAL;
-		if (insn->imm != orig_off)
+		if (insn->imm != orig_val)
 			return -EINVAL;
-		insn->imm = new_off;
+		insn->imm = new_val;
 		pr_debug("prog '%s': patched insn #%d (ALU/ALU64) imm %d -> %d\n",
 			 bpf_program__title(prog, false),
-			 insn_idx, orig_off, new_off);
+			 insn_idx, orig_val, new_val);
 	} else {
 		pr_warning("prog '%s': trying to relocate unrecognized insn #%d, code:%x, src:%x, dst:%x, off:%x, imm:%x\n",
 			   bpf_program__title(prog, false),
@@ -2811,6 +2840,7 @@ static int bpf_core_reloc_insn(struct bpf_program *prog, int insn_off,
 			   insn->off, insn->imm);
 		return -EINVAL;
 	}
+
 	return 0;
 }
 
@@ -3087,15 +3117,26 @@ static int bpf_core_reloc_field(struct bpf_program *prog,
 		cand_ids->data[j++] = cand_spec.spec[0].type_id;
 	}
 
-	cand_ids->len = j;
-	if (cand_ids->len == 0) {
+	/*
+	 * For BPF_FIELD_EXISTS relo or when relaxed CO-RE reloc mode is
+	 * requested, it's expected that we might not find any candidates.
+	 * In this case, if field wasn't found in any candidate, the list of
+	 * candidates shouldn't change at all, we'll just handle relocating
+	 * appropriately, depending on relo's kind.
+	 */
+	if (j > 0)
+		cand_ids->len = j;
+
+	if (j == 0 && !prog->obj->relaxed_core_relocs &&
+	    relo->kind != BPF_FIELD_EXISTS) {
 		pr_warning("prog '%s': relo #%d: no matching targets found for [%d] %s + %s\n",
 			   prog_name, relo_idx, local_id, local_name, spec_str);
 		return -ESRCH;
 	}
 
-	err = bpf_core_reloc_insn(prog, relo->insn_off,
-				  local_spec.offset, targ_spec.offset);
+	/* bpf_core_reloc_insn should know how to handle missing targ_spec */
+	err = bpf_core_reloc_insn(prog, relo, &local_spec,
+				  j ? &targ_spec : NULL);
 	if (err) {
 		pr_warning("prog '%s': relo #%d: failed to patch insn at offset %d: %d\n",
 			   prog_name, relo_idx, relo->insn_off, err);
@@ -3587,6 +3628,7 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 	if (IS_ERR(obj))
 		return obj;
 
+	obj->relaxed_core_relocs = OPTS_GET(opts, relaxed_core_relocs, false);
 	relaxed_maps = OPTS_GET(opts, relaxed_maps, false);
 
 	CHECK_ERR(bpf_object__elf_init(obj), err, out);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 667e6853e51f..53ce212764e0 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -96,8 +96,10 @@ struct bpf_object_open_opts {
 	const char *object_name;
 	/* parse map definitions non-strictly, allowing extra attributes/data */
 	bool relaxed_maps;
+	/* process CO-RE relocations non-strictly, allowing them to fail */
+	bool relaxed_core_relocs;
 };
-#define bpf_object_open_opts__last_field relaxed_maps
+#define bpf_object_open_opts__last_field relaxed_core_relocs
 
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
 LIBBPF_API struct bpf_object *
-- 
2.17.1

