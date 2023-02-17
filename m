Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6569B7B9
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 03:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjBRCVX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 21:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBRCVW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 21:21:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAAA3C798
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 18:20:45 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HLiK5m018685;
        Fri, 17 Feb 2023 23:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=uY8A8Ab5OqP4T84k6W+KiL6WAXHM5fpgmFvE3b+ePcY=;
 b=hk5l3gn2ML3ZnDWhttAWGnr/GpChq8tKXvGZERQjSQZHd6nHgZz3g+ugZi/DSd3Hkkyh
 m200tV9ihOMst9814r3v7yqiuoZf7TwrEzkYwHULRWJwE9W26kPci6qqV1uK/pi7sSH6
 G4JGJDHgBsm8lVkLEDxQSc1nw2i5VCT1f8HTGiAsjiamhGMf2FDOYCQxLdNIw8YDMC1S
 Ko82eEeoG1ghREtuOtt0iWIQcBtbEspJvVl/fCe4JOHiLuQqyw2PMpuq2+rsCuCcEUJn
 cjmDbKetOOco39D4/uoOfCv9CqgOe3Eu4IL8w5V6GyPsSWfaJjfvOemR6u+7d+FF6ot7 bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32cq6gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HN5A2o015370;
        Fri, 17 Feb 2023 23:10:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fas7tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HNAcmM007180;
        Fri, 17 Feb 2023 23:10:42 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-171-27.vpn.oracle.com [10.175.171.27])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1fas7py-2;
        Fri, 17 Feb 2023 23:10:42 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, olsajiri@gmail.com, ast@kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 1/4] dwarf_loader: mark functions that do not use expected registers for params
Date:   Fri, 17 Feb 2023 23:10:30 +0000
Message-Id: <1676675433-10583-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
References: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_15,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170202
X-Proofpoint-GUID: xN6WLC0LCcZdoiohrSsbL3kRaDYxvtFV
X-Proofpoint-ORIG-GUID: xN6WLC0LCcZdoiohrSsbL3kRaDYxvtFV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Calling conventions dictate which registers are used for
function parameters.

When a function is optimized however, we need to ensure that
the non-optimized parameters do not violate expectations about
register use as this would violate expectations for tracing.
At CU initialization, create a mapping from parameter index
to expected DW_OP_reg, and use it to validate parameters
match with expectations.  A parameter which is passed via
the stack, as a constant, or uses an unexpected register,
violates these expectations and it (and the associated
function) are marked as having unexpected register mapping.

Note though that there is as exception here that needs to
be handled; when a (typedef) struct is passed as a parameter,
it can use multiple registers so will throw off later register
expectations.  Exempt functions that have unexpected
register usage _and_ struct parameters (examples are found
in the "tracing_struct" test).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++---
 dwarves.h      |   5 +++
 2 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index acdb68d..014e130 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1022,6 +1022,51 @@ static int arch__nr_register_params(const GElf_Ehdr *ehdr)
 	return 0;
 }
 
+/* map from parameter index (0 for first, ...) to expected DW_OP_reg.
+ * This will allow us to identify cases where optimized-out parameters
+ * interfere with expectations about register contents on function
+ * entry.
+ */
+static void arch__set_register_params(const GElf_Ehdr *ehdr, struct cu *cu)
+{
+	memset(cu->register_params, -1, sizeof(cu->register_params));
+
+	switch (ehdr->e_machine) {
+	case EM_S390:
+		/* https://github.com/IBM/s390x-abi/releases/download/v1.6/lzsabi_s390x.pdf */
+		cu->register_params[0] = DW_OP_reg2;	// %r2
+		cu->register_params[1] = DW_OP_reg3;	// %r3
+		cu->register_params[2] = DW_OP_reg4;	// %r4
+		cu->register_params[3] = DW_OP_reg5;	// %r5
+		cu->register_params[4] = DW_OP_reg6;	// %r6
+		return;
+	case EM_X86_64:
+		/* //en.wikipedia.org/wiki/X86_calling_conventions#System_V_AMD64_ABI */
+		cu->register_params[0] = DW_OP_reg5;	// %rdi
+		cu->register_params[1] = DW_OP_reg4;	// %rsi
+		cu->register_params[2] = DW_OP_reg1;	// %rdx
+		cu->register_params[3] = DW_OP_reg2;	// %rcx
+		cu->register_params[4] = DW_OP_reg8;	// %r8
+		cu->register_params[5] = DW_OP_reg9;	// %r9
+		return;
+	case EM_ARM:
+		/* https://github.com/ARM-software/abi-aa/blob/main/aapcs32/aapcs32.rst#machine-registers */
+	case EM_AARCH64:
+		/* https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#machine-registers */
+		cu->register_params[0] = DW_OP_reg0;
+		cu->register_params[1] = DW_OP_reg1;
+		cu->register_params[2] = DW_OP_reg2;
+		cu->register_params[3] = DW_OP_reg3;
+		cu->register_params[4] = DW_OP_reg4;
+		cu->register_params[5] = DW_OP_reg5;
+		cu->register_params[6] = DW_OP_reg6;
+		cu->register_params[7] = DW_OP_reg7;
+		return;
+	default:
+		return;
+	}
+}
+
 static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 					struct conf_load *conf, int param_idx)
 {
@@ -1075,18 +1120,28 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 		if (parm->has_loc &&
 		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
 			loc.exprlen != 0) {
+			int expected_reg = cu->register_params[param_idx];
 			Dwarf_Op *expr = loc.expr;
 
 			switch (expr->atom) {
 			case DW_OP_reg0 ... DW_OP_reg31:
+				/* mark parameters that use an unexpected
+				 * register to hold a parameter; these will
+				 * be problematic for users of BTF as they
+				 * violate expectations about register
+				 * contents.
+				 */
+				if (expected_reg >= 0 && expected_reg != expr->atom)
+					parm->unexpected_reg = 1;
+				break;
 			case DW_OP_breg0 ... DW_OP_breg31:
 				break;
 			default:
-				parm->optimized = 1;
+				parm->unexpected_reg = 1;
 				break;
 			}
 		} else if (has_const_value) {
-			parm->optimized = 1;
+			parm->unexpected_reg = 1;
 		}
 	}
 
@@ -2302,13 +2357,17 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
 			pos->tag.type = dtype->tag->type;
 			/* share location information between parameter and
 			 * abstract origin; if neither have location, we will
-			 * mark the parameter as optimized out.
+			 * mark the parameter as optimized out.  Also share
+			 * info regarding unexpected register use for
+			 * parameters.
 			 */
 			if (pos->has_loc)
 				opos->has_loc = pos->has_loc;
 
 			if (pos->optimized)
 				opos->optimized = pos->optimized;
+			if (pos->unexpected_reg)
+				opos->unexpected_reg = pos->unexpected_reg;
 			continue;
 		}
 
@@ -2584,6 +2643,27 @@ out:
 	return 0;
 }
 
+static bool param__is_struct(struct cu *cu, struct tag *tag)
+{
+	const struct dwarf_tag *dtag = tag->priv;
+	struct dwarf_tag *dtype = dwarf_cu__find_type_by_ref(cu->priv, &dtag->type);
+	struct tag *type;
+
+	if (!dtype)
+		return false;
+	type = dtype->tag;
+
+	switch (type->tag) {
+	case DW_TAG_structure_type:
+		return true;
+	case DW_TAG_typedef:
+		/* handle "typedef struct" */
+		return param__is_struct(cu, type);
+	default:
+		return false;
+	}
+}
+
 static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 {
 	struct ptr_table *pt = &cu->functions_table;
@@ -2593,6 +2673,7 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 		struct tag *tag = pt->entries[i];
 		struct parameter *pos;
 		struct function *fn = tag__function(tag);
+		bool has_unexpected_reg = false, has_struct_param = false;
 
 		/* mark function as optimized if parameter is, or
 		 * if parameter does not have a location; at this
@@ -2600,12 +2681,29 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 		 * abstract origins for cases where a parameter
 		 * location is not stored in the original function
 		 * parameter tag.
+		 *
+		 * Also mark functions which, due to optimization,
+		 * use an unexpected register for a parameter.
+		 * Exception is functions which have a struct
+		 * as a parameter, as multiple registers may
+		 * be used to represent it, throwing off register
+		 * to parameter mapping.
 		 */
 		ftype__for_each_parameter(&fn->proto, pos) {
-			if (pos->optimized || !pos->has_loc) {
+			if (pos->optimized || !pos->has_loc)
 				fn->proto.optimized_parms = 1;
-				break;
+
+			if (pos->unexpected_reg)
+				has_unexpected_reg = true;
+		}
+		if (has_unexpected_reg) {
+			ftype__for_each_parameter(&fn->proto, pos) {
+				has_struct_param = param__is_struct(cu, &pos->tag);
+				if (has_struct_param)
+					break;
 			}
+			if (!has_struct_param)
+				fn->proto.unexpected_reg = 1;
 		}
 
 		if (tag == NULL || tag->type != 0)
@@ -2917,6 +3015,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
 
 	cu->little_endian = ehdr.e_ident[EI_DATA] == ELFDATA2LSB;
 	cu->nr_register_params = arch__nr_register_params(&ehdr);
+	arch__set_register_params(&ehdr, cu);
 	return 0;
 }
 
diff --git a/dwarves.h b/dwarves.h
index 24a1909..5074cf8 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -234,6 +234,8 @@ struct debug_fmt_ops {
 	bool		   has_alignment_info;
 };
 
+#define ARCH_MAX_REGISTER_PARAMS	8
+
 /*
  * unspecified_type: If this CU has a DW_TAG_unspecified_type, as BTF doesn't have a representation for this
  * 		     and thus we need to check functions returning this to convert it to void.
@@ -265,6 +267,7 @@ struct cu {
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
 	uint8_t		 nr_register_params;
+	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	uint16_t	 language;
 	unsigned long	 nr_inline_expansions;
 	size_t		 size_inline_expansions;
@@ -812,6 +815,7 @@ struct parameter {
 	struct tag tag;
 	const char *name;
 	uint8_t optimized:1;
+	uint8_t unexpected_reg:1;
 	uint8_t has_loc:1;
 };
 
@@ -834,6 +838,7 @@ struct ftype {
 	uint16_t	 nr_parms;
 	uint8_t		 unspec_parms:1; /* just one bit is needed */
 	uint8_t		 optimized_parms:1;
+	uint8_t		 unexpected_reg:1;
 	uint8_t		 processed:1;
 	uint8_t		 inconsistent_proto:1;
 };
-- 
2.31.1

