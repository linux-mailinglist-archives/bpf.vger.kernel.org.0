Return-Path: <bpf+bounces-72001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E4EC04C1A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 09:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142D43A9D2B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74BB2E7180;
	Fri, 24 Oct 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PNFARNyz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC02E4247;
	Fri, 24 Oct 2025 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291255; cv=none; b=i1irYDwWbJa4FwrnQUZ+6ATo0uAiSwDtG2WXj2zGNZXPwYnvRCwxkH9hmqX0y0kqSuCM6a6uCkE6hEqjUDrNWLD5LcMlyqTVpNAQM2cIJYnH78YZEuI8Zz64Dtn56wjwQrJwT6RVgNWmJ/xOSlxdAMnpBRS33Vt8MnCAvR4Mkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291255; c=relaxed/simple;
	bh=e3Bzn/zRAHMwfa+E7GcFVugl21A2byjLQkhXpL3qit8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwaNH+c4+fTbVEU9TG8zd4ZO7I54f6/95rHV9V//rELTnoldVbjJgt9o3FgUPHz3wfI/FwHWJFfo+9IojsOHPZmOIZatjWJSz7S8voPK3gVoIul0K1+KUdo2IOQ2nEviZRDbyT3MBCv1I/8qkySV/KJftMgk1ZAdArzVNgHcB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PNFARNyz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3OEhf014739;
	Fri, 24 Oct 2025 07:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9mh3U
	ovcXD48UAarJiwc+LKwvUH2cvOkPVP7gvuxHIU=; b=PNFARNyzQiU0pdt7xOsy2
	p3mbWiZfAI9ICMbw1uzvKvdIdHus8HnME+KJSEkLdBgsOY1nmXFDnk3jS0/ZcDyY
	Iuv9/t5tl6td107CbFxTXOz00P1VCYD12FrTaUG0+leH3uPU2nsWg2uMzLmlkwtu
	+p2lRDiSRwWNXRnkUR70S02uObYi9bkqi09IPF5ANp3Qzj7aDr7+cKZ3an3hS36p
	O22wg3HyjxKLUAmsqksYDLj6ktlZG7HJYfhRKbA+DWv2sEkIO1fIixBKUgb8i0S+
	+rhB3nyXA+toG4mPwZG/wOJtJupJZenXy74fOuOTxWkfN2N0JAz0+lKEeOoYC9PV
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xstymdcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O6HeJ8022289;
	Fri, 24 Oct 2025 07:33:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm4dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59O7XYwf019356;
	Fri, 24 Oct 2025 07:33:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-127.vpn.oracle.com [10.154.57.127])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49v1bgm48v-2;
	Fri, 24 Oct 2025 07:33:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 1/5] dwarf_loader: Add parameters list to inlined expansion
Date: Fri, 24 Oct 2025 08:33:24 +0100
Message-ID: <20251024073328.370457-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251024073328.370457-1-alan.maguire@oracle.com>
References: <20251024073328.370457-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240065
X-Proofpoint-GUID: YVpJTmDNcfJ3XZRP-aL2mdMkYJle6iUo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA1MCBTYWx0ZWRfX14qEoTX166Si
 O2GBgB6TKnLkmKMRg56yH4wnF2Q5JpGXjLR5doxT1Ce8qfyoMhO3uplTDanqkDOlhmoT24tMpFy
 KYk6znQdyJRQWL12rFdesG0Vjjsc+8XvW3mXuCknaOKfVrJNISV0/QOoq+iYuKm8DxAfXb+WFdv
 LzyxYpj8bCMROmwNjlvhKGBo6KIokRQ2Hz4R5FMuAOd+6QM3Pl/UZjg2YDQzckn6Ikamys+bzeN
 85WTBmH/+kauHmkscV0/As8qlas+MIut6RY2I054sUsPjHSVBawQGsKrYOwSR3fTIw2UKQN7DTq
 HcbTZ3nnB9OB7L4vLOHbriuWXnI/kBbG0BCNjiwvoDnrLbJjdXxDv/urbH4actrcixGmH2bDQB0
 83m+kjZwCElLoXNBAbw+BZrZZmg3smJN9a6q4HV31VbyaX7F/eM=
X-Authority-Analysis: v=2.4 cv=OdeVzxTY c=1 sm=1 tr=0 ts=68fb2bd4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=yPCof4ZbAAAA:8
 a=y2Md5b060ufhYWlxjJQA:9 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: YVpJTmDNcfJ3XZRP-aL2mdMkYJle6iUo

From: Thierry Treyer <ttreyer@meta.com>

The parameters of inlined expansions are stored in the lexblock tag
list, making it difficult to iterate over the parameters of a given
inlined expansion.

Add a list of parameters to 'struct inline_expansion', so the parameters
are stored in their expansion instead of the lexblock.

Omitted the storage of struct location in parameters here as a later
patch will persist location information until after CUs have gone;
this is necessary to ensure we can delay adding it until base BTF
has been generated.

Signed-off-by: Thierry Treyer <ttreyer@meta.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 164 +++++++++++++++++++++++++++++--------------------
 dwarves.c      |  26 ++++++++
 dwarves.h      |   6 ++
 3 files changed, 129 insertions(+), 67 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 79be3f5..e19414d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1297,6 +1297,9 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
 
 		if (parm->has_loc) {
+			struct location location;
+			attr_location(die, &location.expr, &location.exprlen);
+
 			int expected_reg = cu->register_params[param_idx];
 			int actual_reg = parameter__reg(&attr, expected_reg);
 
@@ -1374,6 +1377,8 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin);
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
+		exp->nr_parms = 0;
+		INIT_LIST_HEAD(&exp->parms);
 
 		if (!cu->has_addr_info)
 			goto out;
@@ -1794,6 +1799,7 @@ static struct tag *die__create_new_string_type(Dwarf_Die *die, struct cu *cu)
 static struct tag *die__create_new_parameter(Dwarf_Die *die,
 					     struct ftype *ftype,
 					     struct lexblock *lexblock,
+					     struct inline_expansion *exp,
 					     struct cu *cu, struct conf_load *conf,
 					     int param_idx)
 {
@@ -1808,15 +1814,16 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
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
@@ -1884,7 +1891,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
 			tag__print_not_supported(die);
 			continue;
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
+			tag = die__create_new_parameter(die, ftype, NULL, NULL, cu, conf, -1);
 			break;
 		case DW_TAG_unspecified_parameters:
 			ftype->unspec_parms = 1;
@@ -2136,10 +2143,13 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
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
@@ -2179,6 +2189,7 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 			 *
 			 * cu__tag_not_handled(cu, die);
 			 */
+			tag = die__create_new_parameter(die, NULL, lexblock, exp, cu, conf, parm_idx++);
 			continue;
 		case DW_TAG_inlined_subroutine:
 			tag = die__create_new_inline_expansion(die, lexblock, cu, conf);
@@ -2230,7 +2241,7 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
 	if (exp == NULL)
 		return NULL;
 
-	if (die__process_inline_expansion(die, lexblock, cu, conf) != 0) {
+	if (die__process_inline_expansion(die, exp, lexblock, cu, conf) != 0) {
 		tag__free(&exp->ip.tag, cu);
 		return NULL;
 	}
@@ -2315,7 +2326,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 			continue;
 		}
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
+			tag = die__create_new_parameter(die, ftype, lexblock, NULL, cu, conf, param_idx++);
 			break;
 		case DW_TAG_variable:
 			tag = die__create_new_variable(die, cu, conf, 0);
@@ -2607,54 +2618,85 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
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
+	ftype__recode_dwarf_types(dtag__tag(ftype), cu);
+
+	struct tag *pos;
+	struct inline_expansion *exp = tag__inline_expansion(tag);
+	list_for_each_entry(pos, &exp->parms, node)
+		parameter__recode_dwarf_type(tag__parameter(pos), cu);
+	exp->ip.tag.type = ftype->small_id;
 }
 
 static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
@@ -2671,18 +2713,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
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
@@ -2862,12 +2893,11 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 
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
index ef93239..2232ee7 100644
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
index 21d4166..4e91e8f 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -823,6 +823,8 @@ struct inline_expansion {
 	struct ip_tag	 ip;
 	size_t		 size;
 	uint64_t	 high_pc;
+	struct list_head parms;
+	uint16_t   nr_parms;
 };
 
 static inline struct inline_expansion *
@@ -831,6 +833,9 @@ static inline struct inline_expansion *
 	return (struct inline_expansion *)tag;
 }
 
+struct parameter;
+void inline_expansion__add_parameter(struct inline_expansion *exp, struct parameter *parm);
+
 struct label {
 	struct ip_tag	 ip;
 	const char	 *name;
@@ -941,6 +946,7 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
 struct parameter {
 	struct tag tag;
 	const char *name;
+	struct location location;
 	uint8_t optimized:1;
 	uint8_t unexpected_reg:1;
 	uint8_t has_loc:1;
-- 
2.39.3


