Return-Path: <bpf+bounces-78715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E79D1913B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5CDD3072B2B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE13904C2;
	Tue, 13 Jan 2026 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3MdKc7f"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BD3904D0;
	Tue, 13 Jan 2026 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310068; cv=none; b=WLY9b+69JAowpucI5OgMpQHIn0E69qq7hK/xCn22AFTN1qABl5iY07LpgYtNTGORZXqD+SaN8++pCWPmoWS2Q85EwWwkXd+3MIYYcSw4dj1q9ywyXorIZCxiWuePvKWoWhiL4bEXm7/lpmy6Ew5wYnbcK4V+JXvq6QIuShiMezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310068; c=relaxed/simple;
	bh=E4/Yx11eXNJpbX3sQaht6IfswmyS34VBlKPFSuAsuz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYi5Y5NNQjMSwUktyjFEUMoU5oDVy0H1EQmGUWdfT55XqFl22jCyxkohJgpfitpF3UdEnPzqXYzdgybBdLovhwWmpU4JJNjv5/0BhfxwuLknLY5Pr/kbWUjjlG5iRZZ2NnocHp9+3WaYjpHIxRKktEBEWVduoZNYPZ9ZLx5oeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I3MdKc7f; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gZrh2395850;
	Tue, 13 Jan 2026 13:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=oGTj9
	+Tv2jYLLY1xUzvyxQQAlcHGdolJLPDI6JzmOnk=; b=I3MdKc7f6DlGrvRpPxDJR
	aDRLJJKLPsxy7J0yse2EsNup0g0pWKyQlf6iyNRNLzXd0aGfHy9D8FmIl4RZpYq+
	1OuLDXaHUvXpUsdw/z6h2xYKKEdcJ+OLfCYU2+E+CbfgOqD16x/NaMi4pnDCKNxi
	ZrdsUcEf4G3xb9XeXOGmamBSJW+jDomQKp6F+uayQy5HxAkCD0e/YyKcu2aepXDs
	W7l9mfT0uv8ssdNqRbhSSCjsTsqJzA0F9towSchFGIWOUgD64ocJ1JVjWixEAFFh
	UHJHUfn7gd4FoldYm2A2nx9nUx4Dn2MFcA0OhatX8UzntRs/rEKVAuf51hM2/tZd
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkqq53cjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:14:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DC3Z5G004244;
	Tue, 13 Jan 2026 13:14:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7jg7mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:14:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60DDEBYX037732;
	Tue, 13 Jan 2026 13:14:17 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-89.vpn.oracle.com [10.154.50.89])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7jg7a6-4;
	Tue, 13 Jan 2026 13:14:17 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 3/4] btf_encoder: Add true_signature feature support for "."-suffixed functions
Date: Tue, 13 Jan 2026 13:13:51 +0000
Message-ID: <20260113131352.2395024-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260113131352.2395024-1-alan.maguire@oracle.com>
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130111
X-Proofpoint-ORIG-GUID: uSXz8Uxuwtj8hq0odhlB9jtGQf63kZd_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExMSBTYWx0ZWRfXxRNyuUROsvkY
 LQW30cJ3c9+oI06MM75w+XkAXgSDKDQ3gGi3QxKSvw505/p4XTL2k25qe0E48xRWC2nqMdBiKEo
 EDJ79wLtl1JWfQAKaQ6ELn1dpeSX7XhOKDh4TNny2KO/0zfDL90kRqfImv8t+jP73yICPyZXdIG
 4FiMk3hhTkSrkfcBsFTdAkfpNhN/YSyCn6lZRGPKeitRViMv20nqXd/VaBeRo7QEZZ3CtFKrcjI
 vEaHDYjAwPH5Jz4WZHGKEeDjjpVh6wFWI6H1xLz7UYVdPynQIwhA5cIwWoI+DRNUuOmvY/Gnjj8
 AeeNZqp4SyfYUNJprIK8FXV+igJ416z7yh3l4rURJAtpgetHtBHNGnAed43K3dp0sI19eCPlXS0
 JL+jZLbgTVK/yY188LeCXaBMmXJuyUboQXO1khF98n8mE+7/vf1xsqjuZlj/zo3mtdyCczQ/uh5
 IjfmGA6S+hInBSaD+xeBn669ULwWdwiL+vpcRADQ=
X-Authority-Analysis: v=2.4 cv=J9KnLQnS c=1 sm=1 tr=0 ts=6966452b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=jHOTcd2ZEYIbsR5NF4AA:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: uSXz8Uxuwtj8hq0odhlB9jtGQf63kZd_

Currently we collate function information by name and add functions
provided there are no inconsistencies across various representations.

For true_signature support - where we wish to add the real signature
of a function even if it differs from source level - we need to do
a few things:

1. For "."-suffixed functions, we need to match from DWARF->ELF;
   we can do this via the address associated with the function.
   In doing this, we can then be confident that the debug info
   for foo.isra.0 is the right info for the function at that
   address.

2. When adding saved functions we need to look for such cases
   and provided they do not violate other constraints around BTF
   representation - unexpected reg usage for function, uncertain
   parameter location or ambiguous address - we add them with
   their "."-suffixed name.  The latter can be used as a signal
   that the function is transformed from the original.

Doing this adds 500 functions to BTF.  These are traceable with
their "."-suffix names and because we have excluded ambiguous
address cases we know exactly which function address they refer
to.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-----
 dwarves.h     |  1 +
 pahole.c      |  1 +
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5bc61cb..01fd469 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
 	int16_t component_idx;
 };
 
+struct elf_function_sym {
+	const char *name;
+	uint64_t addr;
+};
+
 /* state used to do later encoding of saved functions */
 struct btf_encoder_func_state {
 	struct elf_function *elf;
+	struct elf_function_sym *sym;
+	uint64_t addr;
 	uint32_t type_id_off;
 	uint16_t nr_parms;
 	uint16_t nr_annots;
@@ -94,11 +101,6 @@ struct btf_encoder_func_state {
 	struct btf_encoder_func_annot *annots;
 };
 
-struct elf_function_sym {
-	const char *name;
-	uint64_t addr;
-};
-
 struct elf_function {
 	char		*name;
 	struct elf_function_sym *syms;
@@ -145,7 +147,8 @@ struct btf_encoder {
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
 			  gen_distilled_base,
-			  encode_attributes;
+			  encode_attributes,
+			  true_signature;
 	uint32_t	  array_index_id;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
@@ -1271,14 +1274,34 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 			goto out;
 		}
 	}
+	if (encoder->true_signature && fn->lexblock.ip.addr) {
+		int i;
+
+		for (i = 0; i < func->sym_cnt; i++) {
+			if (fn->lexblock.ip.addr != func->syms[i].addr)
+				continue;
+			/* Only need to record address for '.'-suffixed
+			 * functions, since we only currently need true
+			 * signatures for them.
+			 */
+			if (!strchr(func->syms[i].name, '.'))
+				continue;
+			state->sym = &func->syms[i];
+			break;
+		}
+	}
 	state->inconsistent_proto = ftype->inconsistent_proto;
 	state->unexpected_reg = ftype->unexpected_reg;
 	state->optimized_parms = ftype->optimized_parms;
 	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
 	state->reordered_parm = ftype->reordered_parm;
 	ftype__for_each_parameter(ftype, param) {
-		const char *name = parameter__name(param) ?: "";
+		const char *name;
 
+		/* No location info + reordered means optimized out. */
+		if (ftype->reordered_parm && !param->has_loc)
+			continue;
+		name = parameter__name(param) ?: "";
 		str_off = btf__add_str(btf, name);
 		if (str_off < 0) {
 			err = str_off;
@@ -1367,6 +1390,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 
 	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
 	name = func->name;
+	if (encoder->true_signature && state->sym)
+		name = state->sym->name;
+
 	if (btf_fnproto_id >= 0)
 		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
 						      name, false);
@@ -1509,6 +1535,38 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
 			j++;
 
+		/* Add true signatures for case where we have an exact
+		 * symbol match by address from DWARF->ELF and have a
+		 * "." suffixed name.
+		 */
+		if (encoder->true_signature) {
+			int k;
+
+			for (k = i; k < nr_saved_fns; k++) {
+				struct btf_encoder_func_state *true_state = &saved_fns[k];
+
+				if (state->elf != true_state->elf)
+					break;
+				if (!true_state->sym)
+					continue;
+				/* Unexpected reg, uncertain parm loc and
+				 * ambiguous address mean we cannot trust fentry.
+				 */
+				if (true_state->unexpected_reg ||
+				    true_state->uncertain_parm_loc ||
+				    true_state->ambiguous_addr)
+					continue;
+				err = btf_encoder__add_func(encoder, true_state);
+				if (err < 0)
+					goto out;
+				break;
+			}
+		}
+
+		/* True symbol that was handled above; skip. */
+		if (state->sym)
+			continue;
+
 		/* do not exclude functions with optimized-out parameters; they
 		 * may still be _called_ with the right parameter values, they
 		 * just do not _use_ them.  Only exclude functions with
@@ -2585,6 +2643,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
 		encoder->encode_attributes = conf_load->btf_attributes;
+		encoder->true_signature = conf_load->true_signature;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index 78bedf5..d7c6474 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -101,6 +101,7 @@ struct conf_load {
 	bool			btf_decl_tag_kfuncs;
 	bool			btf_gen_distilled_base;
 	bool			btf_attributes;
+	bool			true_signature;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index ef01e58..02a0d19 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1234,6 +1234,7 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
 				      attributes_check),
+	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.43.5


