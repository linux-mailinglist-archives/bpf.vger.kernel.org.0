Return-Path: <bpf+bounces-56055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066F5A90C30
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493FF1890368
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD28224B10;
	Wed, 16 Apr 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9w+gBfb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F5217712;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831267; cv=none; b=sL8R2+ZnnqqfqKpCiJFfKzLO4c/Qc/MCO8c2R+eDISpDiFXA9BeCY3XG5HZGhWP1B+35mMNBUGq7i3D79BbOKSyyA1QcTXSoM4PTp79bAadLh0WbCWCVKkPnWZpimHYepC7METpiKwpMe9zaw1t5OpBuQ11eJZ1bo6lOGSEZJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831267; c=relaxed/simple;
	bh=Lhtpn16V8YwbUjT/n7MhlvePq4SQzUPVC5K3c/nMgvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhuoBXb7fq1T4QLe17IVLtHzYVdP2Fo0tuRyEdyAcFuGVUboWheNvQ1kI+a9xpuYb4QNbrtTYaipznQXhYA32XVp4M11robbukrhdM0bquckNQqCAErP50ozOwgxUJIQm0z9ONV3CnA6aRWmBpMAdps6BcnCXAQXET/RLDUGez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9w+gBfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D8C7C4CEED;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831267;
	bh=Lhtpn16V8YwbUjT/n7MhlvePq4SQzUPVC5K3c/nMgvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T9w+gBfbEJzoCShNHtWHj5nwsHgku1y6L6kCA7Y6t3Len5XpsNCPMoBIK+Mcfkl0o
	 VLRannn0ehMqhRMn5AIynizlRwj3xSf/fLkp7GC/EM8izEsO4YLRF6sW4ZfL/HodwP
	 i2McqjtKjiepuWOQoltZUsTrt688iea7/WfnVVNzbKH7ilkaG22h/2wr/+r7ffCP+d
	 pPzIq6XIT2gEzyOQHrnfp51ETxnY9X/cZtyWnX8X85zn7giMqneU2daZqHSZlrBgzu
	 kkolXALvO4naW7DOhisDHi/30AHCo2zYCPYrn6YDf8ZMB2RKlYXNEjS/BuO/IPLFE+
	 OjXdHIz9xcaCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296ACC369C9;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
From: Thierry Treyer via B4 Relay <devnull+ttreyer.meta.com@kernel.org>
Date: Wed, 16 Apr 2025 19:20:35 +0000
Subject: [PATCH RFC 1/3] dwarf_loader: Add parameters list to inlined
 expansion
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-btf_inline-v1-1-e4bd2f8adae5@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
In-Reply-To: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
To: dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc: Thierry Treyer <ttreyer@meta.com>, acme@kernel.org, ast@kernel.org, 
 yhs@meta.com, andrii@kernel.org, ihor.solodrai@linux.dev, 
 songliubraving@meta.com, alan.maguire@oracle.com, mykolal@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744831265; l=14299;
 i=ttreyer@meta.com; s=20250416; h=from:subject:message-id;
 bh=KRjj5XcMWGamVrhTIaliZ44bd3FXiuifuRRXXxEDL9M=;
 b=HfDpNEV/AgTaSWbxB+jOOb1YjMUwUgqpUlHK/+RVnS1TS8fc1NClrGyda5lWXgbdFFYZbSHxa
 bEapQs9u2LUDKlxf9ryM7tAxoPv0BV358xKfhpbwpGbR+aJIusk8B47
X-Developer-Key: i=ttreyer@meta.com; a=ed25519;
 pk=2NAyAkZ6zhou7+5zqr5ikv3g5BfFbkznGzvzfKv1nbU=
X-Endpoint-Received: by B4 Relay for ttreyer@meta.com/20250416 with
 auth_id=382
X-Original-From: Thierry Treyer <ttreyer@meta.com>
Reply-To: ttreyer@meta.com

From: Thierry Treyer <ttreyer@meta.com>

The parameters of inlined expansions are stored in the lexblock tag
list, making it difficult to iterate over the parameters of a given
inlined expansion.

Add a list of parameters to 'struct inline_expansion', so the parameters
are stored in their expansion instead of the lexblock.

Add location to 'struct parameter', so their location expression can be
referenced when consuming the DWARF.
Parameters with a constant value have their value stored in the location
too: 'location.expr' is set to NULL and 'location.exprlen' is set to the
constant's value.

Signed-off-by: Thierry Treyer <ttreyer@meta.com>
---
 dwarf_loader.c | 167 ++++++++++++++++++++++++++++++++++-----------------------
 dwarves.c      |  26 +++++++++
 dwarves.h      |   6 +++
 3 files changed, 132 insertions(+), 67 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 84122d04e42cab53c5598ae62b750a43e187e11d..24ac9afceb3793c165d3e92cfdfaf27ab67fd4d6 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1297,6 +1297,8 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
 
 		if (parm->has_loc) {
+			attr_location(die, &parm->location.expr, &parm->location.exprlen);
+
 			int expected_reg = cu->register_params[param_idx];
 			int actual_reg = parameter__reg(&attr, expected_reg);
 
@@ -1312,6 +1314,8 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 				parm->unexpected_reg = 1;
 		} else if (has_const_value) {
 			parm->optimized = 1;
+			parm->location.expr = NULL;
+			parm->location.exprlen = attr_numeric(die, DW_AT_const_value);
 		}
 	}
 
@@ -1374,6 +1378,8 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin);
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
+		exp->nr_parms = 0;
+		INIT_LIST_HEAD(&exp->parms);
 
 		if (!cu->has_addr_info)
 			goto out;
@@ -1794,6 +1800,7 @@ static struct tag *die__create_new_string_type(Dwarf_Die *die, struct cu *cu)
 static struct tag *die__create_new_parameter(Dwarf_Die *die,
 					     struct ftype *ftype,
 					     struct lexblock *lexblock,
+					     struct inline_expansion *exp,
 					     struct cu *cu, struct conf_load *conf,
 					     int param_idx)
 {
@@ -1808,15 +1815,16 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 			if (add_child_llvm_annotations(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
 				return NULL;
 		}
+	} else if (exp != NULL) {
+		/*
+		 * Inline expansion stores the parameters in a list to emit
+		 * .BTF_inline parameter location.
+		 */
+		inline_expansion__add_parameter(exp, parm);
 	} else {
 		/*
-		 * DW_TAG_formal_parameters on a non DW_TAG_subprogram nor
-		 * DW_TAG_subroutine_type tag happens sometimes, likely due to
-		 * compiler optimizing away a inline expansion (at least this
-		 * was observed in some cases, such as in the Linux kernel
-		 * current_kernel_time function circa 2.6.20-rc5), keep it in
-		 * the lexblock tag list because it can be referenced as an
-		 * DW_AT_abstract_origin in another DW_TAG_formal_parameter.
+		 * Keep it in the lexblock tag list because it can be referenced
+		 * as an DW_AT_abstract_origin in another DW_TAG_formal_parameter.
 		*/
 		lexblock__add_tag(lexblock, &parm->tag);
 	}
@@ -1884,7 +1892,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
 			tag__print_not_supported(die);
 			continue;
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
+			tag = die__create_new_parameter(die, ftype, NULL, NULL, cu, conf, -1);
 			break;
 		case DW_TAG_unspecified_parameters:
 			ftype->unspec_parms = 1;
@@ -2136,10 +2144,13 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
 						    struct lexblock *lexblock,
 						    struct cu *cu, struct conf_load *conf);
 
-static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
+static int die__process_inline_expansion(Dwarf_Die *die,
+					  struct inline_expansion *exp, struct lexblock *lexblock,
+					  struct cu *cu, struct conf_load *conf)
 {
 	Dwarf_Die child;
 	struct tag *tag;
+	int parm_idx = 0;
 
 	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
 		return 0;
@@ -2179,6 +2190,7 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 			 *
 			 * cu__tag_not_handled(cu, die);
 			 */
+			tag = die__create_new_parameter(die, NULL, lexblock, exp, cu, conf, parm_idx++);
 			continue;
 		case DW_TAG_inlined_subroutine:
 			tag = die__create_new_inline_expansion(die, lexblock, cu, conf);
@@ -2230,7 +2242,7 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
 	if (exp == NULL)
 		return NULL;
 
-	if (die__process_inline_expansion(die, lexblock, cu, conf) != 0) {
+	if (die__process_inline_expansion(die, exp, lexblock, cu, conf) != 0) {
 		tag__free(&exp->ip.tag, cu);
 		return NULL;
 	}
@@ -2315,7 +2327,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 			continue;
 		}
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
+			tag = die__create_new_parameter(die, ftype, lexblock, NULL, cu, conf, param_idx++);
 			break;
 		case DW_TAG_variable:
 			tag = die__create_new_variable(die, cu, conf, 0);
@@ -2607,54 +2619,87 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
 #define tag__print_abstract_origin_not_found(tag) \
 	__tag__print_abstract_origin_not_found(tag, __func__, __LINE__)
 
+static void parameter__recode_dwarf_type(struct parameter *parm, struct cu *cu)
+{
+	struct dwarf_cu *dcu = cu->priv;
+	struct dwarf_tag *dparm = tag__dwarf(&parm->tag);
+
+	if (dparm->type == 0) {
+		if (dparm->abstract_origin == 0) {
+			/* Function without parameters */
+			parm->tag.type = 0;
+			return;
+		}
+		// FIXME: Should this use find_type_by_ref instead?
+		struct dwarf_tag *dtype = dwarf_cu__find_tag_by_ref(dcu, dparm, abstract_origin);
+		if (dtype == NULL) {
+			tag__print_abstract_origin_not_found(&parm->tag);
+			return;
+		}
+		struct parameter *oparm = tag__parameter(dtag__tag(dtype));
+		parm->name = oparm->name;
+		parm->tag.type = dtag__tag(dtype)->type;
+		/* Share location information between parameter and abstract origin;
+		 * if neither have location, we will mark the parameter as optimized out.
+		 * Also share info regarding unexpected register use for parameters.
+		 */
+		if (parm->has_loc)
+			oparm->has_loc = parm->has_loc;
+
+		if (parm->optimized)
+			oparm->optimized = parm->optimized;
+		if (parm->unexpected_reg)
+			oparm->unexpected_reg = parm->unexpected_reg;
+		return;
+	}
+
+	struct dwarf_tag *dtype = dwarf_cu__find_type_by_ref(dcu, dparm, type);
+	if (dtype == NULL) {
+		tag__print_type_not_found(&parm->tag);
+		return;
+	}
+	parm->tag.type = dtype->small_id;
+}
+
 static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
 {
 	struct parameter *pos;
-	struct dwarf_cu *dcu = cu->priv;
 	struct ftype *type = tag__ftype(tag);
 
-	ftype__for_each_parameter(type, pos) {
-		struct dwarf_tag *dpos = tag__dwarf(&pos->tag);
-		struct parameter *opos;
-		struct dwarf_tag *dtype;
-
-		if (dpos->type == 0) {
-			if (dpos->abstract_origin == 0) {
-				/* Function without parameters */
-				pos->tag.type = 0;
-				continue;
-			}
-			dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, abstract_origin);
-			if (dtype == NULL) {
-				tag__print_abstract_origin_not_found(&pos->tag);
-				continue;
-			}
-			opos = tag__parameter(dtag__tag(dtype));
-			pos->name = opos->name;
-			pos->tag.type = dtag__tag(dtype)->type;
-			/* share location information between parameter and
-			 * abstract origin; if neither have location, we will
-			 * mark the parameter as optimized out.  Also share
-			 * info regarding unexpected register use for
-			 * parameters.
-			 */
-			if (pos->has_loc)
-				opos->has_loc = pos->has_loc;
+	ftype__for_each_parameter(type, pos)
+		parameter__recode_dwarf_type(pos, cu);
+}
 
-			if (pos->optimized)
-				opos->optimized = pos->optimized;
-			if (pos->unexpected_reg)
-				opos->unexpected_reg = pos->unexpected_reg;
-			continue;
-		}
+static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
+{
+	struct dwarf_cu *dcu = cu->priv;
+	struct dwarf_tag *dtag = tag__dwarf(tag);
 
-		dtype = dwarf_cu__find_type_by_ref(dcu, dpos, type);
-		if (dtype == NULL) {
-			tag__print_type_not_found(&pos->tag);
-			continue;
-		}
-		pos->tag.type = dtype->small_id;
+	/* DW_TAG_inlined_subroutine is an special case as dwarf_tag->id is
+	 * in fact an abtract origin, i.e. must be looked up in the tags_table,
+	 * not in the types_table.
+	 */
+	struct dwarf_tag *ftype = NULL;
+	if (dtag->type != 0)
+		ftype = dwarf_cu__find_tag_by_ref(dcu, dtag, type);
+	else
+		ftype = dwarf_cu__find_tag_by_ref(dcu, dtag, abstract_origin);
+	if (ftype == NULL) {
+		if (dtag->type != 0)
+			tag__print_type_not_found(tag);
+		else
+			tag__print_abstract_origin_not_found(tag);
+		return;
 	}
+
+	// TODO: Is ftype a prototype or a function?
+	ftype__recode_dwarf_types(dtag__tag(ftype), cu);
+
+	struct tag *pos;
+	struct inline_expansion *exp = tag__inline_expansion(tag);
+	list_for_each_entry(pos, &exp->parms, node)
+		parameter__recode_dwarf_type(tag__parameter(pos), cu);
+	exp->ip.tag.type = ftype->small_id;
 }
 
 static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
@@ -2671,18 +2716,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 			lexblock__recode_dwarf_types(tag__lexblock(pos), cu);
 			continue;
 		case DW_TAG_inlined_subroutine:
-			if (dpos->type != 0)
-				dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, type);
-			else
-				dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, abstract_origin);
-			if (dtype == NULL) {
-				if (dpos->type != 0)
-					tag__print_type_not_found(pos);
-				else
-					tag__print_abstract_origin_not_found(pos);
-				continue;
-			}
-			ftype__recode_dwarf_types(dtag__tag(dtype), cu);
+			inline_expansion__recode_dwarf_types(pos, cu);
 			continue;
 
 		case DW_TAG_formal_parameter:
@@ -2862,12 +2896,11 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 
 	case DW_TAG_namespace:
 		return namespace__recode_dwarf_types(tag, cu);
-	/* Damn, DW_TAG_inlined_subroutine is an special case
-           as dwarf_tag->id is in fact an abtract origin, i.e. must be
-	   looked up in the tags_table, not in the types_table.
-	   The others also point to routines, so are in tags_table */
 	case DW_TAG_inlined_subroutine:
+		inline_expansion__recode_dwarf_types(tag, cu);
+		return 0;
 	case DW_TAG_imported_module:
+	  /* Modules point to routines, so are in tags_table */
 		dtype = dwarf_cu__find_tag_by_ref(cu->priv, dtag, type);
 		goto check_type;
 	/* Can be for both types and non types */
diff --git a/dwarves.c b/dwarves.c
index ef93239d26827711e23b405dd113986867d18507..2232ee713d57a92a700be56be7b7e1128741e24a 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -203,6 +203,20 @@ void formal_parameter_pack__delete(struct formal_parameter_pack *pack, struct cu
 	cu__tag_free(cu, &pack->tag);
 }
 
+static void parameter__delete(struct parameter *parm, struct cu *cu);
+
+static void inline_expansion__delete(struct inline_expansion *exp, struct cu *cu)
+{
+	if (exp == NULL)
+		return;
+
+	struct tag *parm, *n;
+	list_for_each_entry_safe_reverse(parm, n, &exp->parms, node) {
+		list_del_init(&parm->node);
+		parameter__delete(tag__parameter(parm), cu);
+	}
+}
+
 void tag__delete(struct tag *tag, struct cu *cu)
 {
 	if (tag == NULL)
@@ -225,6 +239,8 @@ void tag__delete(struct tag *tag, struct cu *cu)
 		ftype__delete(tag__ftype(tag), cu);		break;
 	case DW_TAG_subprogram:
 		function__delete(tag__function(tag), cu); break;
+	case DW_TAG_inlined_subroutine:
+		inline_expansion__delete(tag__inline_expansion(tag), cu); break;
 	case DW_TAG_lexical_block:
 		lexblock__delete(tag__lexblock(tag), cu); break;
 	case DW_TAG_GNU_template_parameter_pack:
@@ -1514,6 +1530,12 @@ void formal_parameter_pack__add(struct formal_parameter_pack *pack, struct param
 	list_add_tail(&param->tag.node, &pack->params);
 }
 
+void inline_expansion__add_parameter(struct inline_expansion *exp, struct parameter *parm)
+{
+	++exp->nr_parms;
+	list_add_tail(&parm->tag.node, &exp->parms);
+}
+
 void lexblock__add_tag(struct lexblock *block, struct tag *tag)
 {
 	list_add_tail(&tag->node, &block->tags);
@@ -2116,6 +2138,10 @@ static int list__for_all_tags(struct list_head *list, struct cu *cu,
 			if (list__for_all_tags(&tag__lexblock(pos)->tags,
 					       cu, iterator, cookie))
 				return 1;
+		} else if (pos->tag == DW_TAG_inlined_subroutine) {
+			if (list__for_all_tags(&tag__inline_expansion(pos)->parms,
+					       cu, iterator, cookie))
+				return 1;
 		}
 
 		if (iterator(pos, cu, cookie))
diff --git a/dwarves.h b/dwarves.h
index 8234e1a09128c667a2a516dccb6d7c6a194f8c5b..38efd6a6e2b0b0e5a571a8d12bbec33502509d8b 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -811,6 +811,8 @@ struct inline_expansion {
 	struct ip_tag	 ip;
 	size_t		 size;
 	uint64_t	 high_pc;
+	struct list_head parms;
+	uint16_t   nr_parms;
 };
 
 static inline struct inline_expansion *
@@ -819,6 +821,9 @@ static inline struct inline_expansion *
 	return (struct inline_expansion *)tag;
 }
 
+struct parameter;
+void inline_expansion__add_parameter(struct inline_expansion *exp, struct parameter *parm);
+
 struct label {
 	struct ip_tag	 ip;
 	const char	 *name;
@@ -929,6 +934,7 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
 struct parameter {
 	struct tag tag;
 	const char *name;
+	struct location location;
 	uint8_t optimized:1;
 	uint8_t unexpected_reg:1;
 	uint8_t has_loc:1;

-- 
2.47.1



