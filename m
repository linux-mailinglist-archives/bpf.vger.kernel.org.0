Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D4968DEB7
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 18:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjBGRQy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 12:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjBGRQK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 12:16:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EDD3F2B8
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 09:15:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317GntAQ000474;
        Tue, 7 Feb 2023 17:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=zIM+HVKLls9G1bN3egEigqSGrty/e7m7lE8+ol/DB1Q=;
 b=Y3dVfDuuEvvnmmZGJVaw2LD8/W7hJOwEvvJ8YOoZVufdhikDe8R2OI0U3M6d+H+Gxv6j
 kk2temCPftcmKhZREozfJfQlD5GOdI+IivewZ+SaY2pEL0bO5oj+0vrPjs+FMropEeR2
 Wl9rI0pP3oYLc4YsgjmCygBpHVQNhTMyyxXcaxqyjg+8M0hZUib3n55SJI9n7wixCZd1
 Ba1zCKKyZeQg1FNIuM/qpP0vpozHDi/N8fr0po4HDmGd5fmKmfqDvxr2I4B2ctMcGmZ0
 l41B+OCdP4Dxq28hdOL6x4YBuUVN9gssSqHtbBeqSEWw06A/p19xv6fL2QXU5G5mmVxH vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy165k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317GYuab007922;
        Tue, 7 Feb 2023 17:15:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt6e7sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317HF7gO007936;
        Tue, 7 Feb 2023 17:15:11 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-168-65.vpn.oracle.com [10.175.168.65])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt6e7g6-2;
        Tue, 07 Feb 2023 17:15:11 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 1/8] dwarf_loader: Help spotting functions with optimized-out parameters
Date:   Tue,  7 Feb 2023 17:14:55 +0000
Message-Id: <1675790102-23037-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_09,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070153
X-Proofpoint-GUID: Z37Kza1V4x2DmoCKP8cqLx9365W2hU8m
X-Proofpoint-ORIG-GUID: Z37Kza1V4x2DmoCKP8cqLx9365W2hU8m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Compilation generates DWARF at several stages, and often the later DWARF
representations more accurately represent optimizations that have
occurred during compilation.

In particular, parameter representations can be spotted by their
abstract origin references to the original parameter, but they often
have more accurate location information.  In most cases, the parameter
locations will match calling conventions, and be registers for the first
6 parameters on x86_64, first 8 on ARM64 etc.  If the parameter is not a
register when it should be however, it is likely passed via the stack or
the compiler has used a constant representation instead.  The latter can
often be spotted by checking for a DW_AT_const_value attribute, as noted
by Eduard.

In addition, absence of a location tag (either across the abstract
origin reference and the original parameter, or in the standalone
parameter description) is evidence of an optimized-out parameter.
Presence of a location tag is stored in the parameter description and
shared between abstract tags and their original referents.

This change adds a field to parameters and their associated ftype to
note if a parameter has been optimized out.  Having this information
allows us to skip such functions, as their presence in CUs makes BTF
encoding impossible.

Committer notes:

Changed the NR_REGISTER_PARAMS definition from a if/elif/endif for the
native architecture into a function that uses the ELF header e_machine
to find the target architecture, to allow for cross builds.

Also avoided looking at location expression in parameter__new() when the
param_idx argument is -1, as is the case when creating 'struct
parameter' instances for DW_TAG_subroutine_type, since we don't have
such info, only for the 'struct parameter' instances created from
DW_TAG_subprogram.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Timo Beckers <timo@incline.eu>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/1675088985-20300-2-git-send-email-alan.maguire@oracle.com
Link: https://lore.kernel.org/r/9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com # DW_OP_reg0 is the first register on aarch64
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++---
 dwarves.h      |   6 ++-
 2 files changed, 128 insertions(+), 8 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 5a74035..7aaf1d4 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -52,6 +52,10 @@
 #define DW_OP_addrx 0xa1
 #endif
 
+#ifndef EM_RISCV
+#define EM_RISCV	243
+#endif
+
 static pthread_mutex_t libdw__lock = PTHREAD_MUTEX_INITIALIZER;
 
 static uint32_t hashtags__bits = 12;
@@ -992,13 +996,98 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
 	return member;
 }
 
-static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+/* How many function parameters are passed via registers?  Used below in
+ * determining if an argument has been optimized out or if it is simply
+ * an argument > cu__nr_register_params().  Making cu__nr_register_params()
+ * return 0 allows unsupported architectures to skip tagging optimized-out
+ * values.
+ */
+static int arch__nr_register_params(const GElf_Ehdr *ehdr)
+{
+	switch (ehdr->e_machine) {
+	case EM_S390:	 return 5;
+	case EM_SPARC:
+	case EM_SPARCV9:
+	case EM_X86_64:	 return 6;
+	case EM_AARCH64:
+	case EM_ARC:
+	case EM_ARM:
+	case EM_MIPS:
+	case EM_PPC:
+	case EM_PPC64:
+	case EM_RISCV:	 return 8;
+	default:	 break;
+	}
+
+	return 0;
+}
+
+static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
+					struct conf_load *conf, int param_idx)
 {
 	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
 
 	if (parm != NULL) {
+		bool has_const_value;
+		Dwarf_Attribute attr;
+		struct location loc;
+
 		tag__init(&parm->tag, cu, die);
 		parm->name = attr_string(die, DW_AT_name, conf);
+
+		if (param_idx >= cu->nr_register_params || param_idx < 0)
+			return parm;
+		/* Parameters which use DW_AT_abstract_origin to point at
+		 * the original parameter definition (with no name in the DIE)
+		 * are the result of later DWARF generation during compilation
+		 * so often better take into account if arguments were
+		 * optimized out.
+		 *
+		 * By checking that locations for parameters that are expected
+		 * to be passed as registers are actually passed as registers,
+		 * we can spot optimized-out parameters.
+		 *
+		 * It can also be the case that a parameter DIE has
+		 * a constant value attribute reflecting optimization or
+		 * has no location attribute.
+		 *
+		 * From the DWARF spec:
+		 *
+		 * "4.1.10
+		 *
+		 * A DW_AT_const_value attribute for an entry describing a
+		 * variable or formal parameter whose value is constant and not
+		 * represented by an object in the address space of the program,
+		 * or an entry describing a named constant. (Note
+		 * that such an entry does not have a location attribute.)"
+		 *
+		 * So we can also use the absence of a location for a parameter
+		 * as evidence it has been optimized out.  This info will
+		 * need to be shared between a parameter and any abstract
+		 * origin references however, since gcc can have location
+		 * information in the parameter that refers back to the original
+		 * via abstract origin, so we need to share location presence
+		 * between these parameter representations.  See
+		 * ftype__recode_dwarf_types() below for how this is handled.
+		 */
+		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
+		has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
+		if (parm->has_loc &&
+		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
+			loc.exprlen != 0) {
+			Dwarf_Op *expr = loc.expr;
+
+			switch (expr->atom) {
+			case DW_OP_reg0 ... DW_OP_reg31:
+			case DW_OP_breg0 ... DW_OP_breg31:
+				break;
+			default:
+				parm->optimized = 1;
+				break;
+			}
+		} else if (has_const_value) {
+			parm->optimized = 1;
+		}
 	}
 
 	return parm;
@@ -1450,7 +1539,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 					     struct cu *cu, struct conf_load *conf,
 					     int param_idx)
 {
-	struct parameter *parm = parameter__new(die, cu, conf);
+	struct parameter *parm = parameter__new(die, cu, conf, param_idx);
 
 	if (parm == NULL)
 		return NULL;
@@ -2194,6 +2283,7 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
 
 	ftype__for_each_parameter(type, pos) {
 		struct dwarf_tag *dpos = pos->tag.priv;
+		struct parameter *opos;
 		struct dwarf_tag *dtype;
 
 		if (dpos->type.off == 0) {
@@ -2207,8 +2297,18 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
 				tag__print_abstract_origin_not_found(&pos->tag);
 				continue;
 			}
-			pos->name = tag__parameter(dtype->tag)->name;
+			opos = tag__parameter(dtype->tag);
+			pos->name = opos->name;
 			pos->tag.type = dtype->tag->type;
+			/* share location information between parameter and
+			 * abstract origin; if neither have location, we will
+			 * mark the parameter as optimized out.
+			 */
+			if (pos->has_loc)
+				opos->has_loc = pos->has_loc;
+
+			if (pos->optimized)
+				opos->optimized = pos->optimized;
 			continue;
 		}
 
@@ -2478,18 +2578,33 @@ out:
 	return 0;
 }
 
-static int cu__resolve_func_ret_types(struct cu *cu)
+static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 {
 	struct ptr_table *pt = &cu->functions_table;
 	uint32_t i;
 
 	for (i = 0; i < pt->nr_entries; ++i) {
 		struct tag *tag = pt->entries[i];
+		struct parameter *pos;
+		struct function *fn = tag__function(tag);
+
+		/* mark function as optimized if parameter is, or
+		 * if parameter does not have a location; at this
+		 * point location presence has been marked in
+		 * abstract origins for cases where a parameter
+		 * location is not stored in the original function
+		 * parameter tag.
+		 */
+		ftype__for_each_parameter(&fn->proto, pos) {
+			if (pos->optimized || !pos->has_loc) {
+				fn->proto.optimized_parms = 1;
+				break;
+			}
+		}
 
 		if (tag == NULL || tag->type != 0)
 			continue;
 
-		struct function *fn = tag__function(tag);
 		if (!fn->abstract_origin)
 			continue;
 
@@ -2612,7 +2727,7 @@ static int die__process_and_recode(Dwarf_Die *die, struct cu *cu, struct conf_lo
 	if (ret != 0)
 		return ret;
 
-	return cu__resolve_func_ret_types(cu);
+	return cu__resolve_func_ret_types_optimized(cu);
 }
 
 static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
@@ -2753,6 +2868,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
 		return DWARF_CB_ABORT;
 
 	cu->little_endian = ehdr.e_ident[EI_DATA] == ELFDATA2LSB;
+	cu->nr_register_params = arch__nr_register_params(&ehdr);
 	return 0;
 }
 
@@ -3132,7 +3248,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 	 * encoded in another subprogram through abstract_origin
 	 * tag. Let us visit all subprograms again to resolve this.
 	 */
-	if (cu__resolve_func_ret_types(cu) != LSK__KEEPIT)
+	if (cu__resolve_func_ret_types_optimized(cu) != LSK__KEEPIT)
 		goto out_abort;
 
 	if (cus__finalize(cus, cu, conf, NULL) == LSK__STOP_LOADING)
diff --git a/dwarves.h b/dwarves.h
index 589588e..1cd95f7 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -262,6 +262,7 @@ struct cu {
 	uint8_t		 has_addr_info:1;
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
+	uint8_t		 nr_register_params;
 	uint16_t	 language;
 	unsigned long	 nr_inline_expansions;
 	size_t		 size_inline_expansions;
@@ -808,6 +809,8 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
 struct parameter {
 	struct tag tag;
 	const char *name;
+	uint8_t optimized:1;
+	uint8_t has_loc:1;
 };
 
 static inline struct parameter *tag__parameter(const struct tag *tag)
@@ -827,7 +830,8 @@ struct ftype {
 	struct tag	 tag;
 	struct list_head parms;
 	uint16_t	 nr_parms;
-	uint8_t		 unspec_parms; /* just one bit is needed */
+	uint8_t		 unspec_parms:1; /* just one bit is needed */
+	uint8_t		 optimized_parms:1;
 };
 
 static inline struct ftype *tag__ftype(const struct tag *tag)
-- 
2.31.1

