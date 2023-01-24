Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82019679A82
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 14:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjAXNtf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 08:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjAXNtW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 08:49:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306404A1EC
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 05:47:11 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ODI0vn020819;
        Tue, 24 Jan 2023 13:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=6YmgzfREeWWPe+FbqSOX6JR1RgoKQWvYthiYsgCt1EQ=;
 b=kwkUeKV7AzqvNJgXJeBGty4+AygjdOtwx3WbOM5qXFgSvsD8+Mubo60OUY9LBoKEht3m
 YOfrCp8qYfvPNX2YZOJSYE4+YVZF1KMXW6Ey2++7zW9DPAWVsK2jyEVqMFmUzhE+Y9QR
 2J9XFJ7selEREyACBIytfhzF9TqUSJ59zLKU2zYTuvWVDGd4qkVIrhTOlApwshoCyqN6
 jSQYoj++Xt2jFgVNZ6eDx4HbNV20s6O9+vE3N+KTwmqscQ9HKbHecbMvolf841GlGLZ8
 rZaK0i5Sx9E22AviqFMsbplsqquUS+ovCrVa1PqVWLGrELJ+3hB3bpq9HLCTyWYwzheQ Pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u2wc5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OBmnFx021016;
        Tue, 24 Jan 2023 13:45:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gbr5jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30ODjZ3r037951;
        Tue, 24 Jan 2023 13:45:39 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-161-98.vpn.oracle.com [10.175.161.98])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n86gbr5fj-2;
        Tue, 24 Jan 2023 13:45:39 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/5] dwarves: help dwarf loader spot functions with optimized-out parameters
Date:   Tue, 24 Jan 2023 13:45:27 +0000
Message-Id: <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240125
X-Proofpoint-GUID: unTRRNDAhYmCDQsvtnDJmMdWnNIcf-Nd
X-Proofpoint-ORIG-GUID: unTRRNDAhYmCDQsvtnDJmMdWnNIcf-Nd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Compilation generates DWARF at several stages, and often the
later DWARF representations more accurately represent optimizations
that have occurred during compilation.

In particular, parameter representations can be spotted by their
abstract origin references to the original parameter, but they
often have more accurate location information.  In most cases,
the parameter locations will match calling conventions, and be
registers for the first 6 parameters on x86_64, first 8 on ARM64
etc.  If the parameter is not a register when it should be however,
it is likely passed via the stack or the compiler has used a
constant representation instead.

This change adds a field to parameters and their associated
ftype to note if a parameter has been optimized out.  Having
this information allows us to skip such functions, as their
presence in CUs makes BTF encoding impossible.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 dwarves.h      |  4 +++-
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 5a74035..0220f1d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -992,13 +992,67 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
 	return member;
 }
 
-static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+/* How many function parameters are passed via registers?  Used below in
+ * determining if an argument has been optimized out or if it is simply
+ * an argument > NR_REGISTER_PARAMS.  Setting NR_REGISTER_PARAMS to 0
+ * allows unsupported architectures to skip tagging optimized-out
+ * values.
+ */
+#if defined(__x86_64__)
+#define NR_REGISTER_PARAMS      6
+#elif defined(__s390__)
+#define NR_REGISTER_PARAMS	5
+#elif defined(__aarch64__)
+#define NR_REGISTER_PARAMS      8
+#elif defined(__mips__)
+#define NR_REGISTER_PARAMS	8
+#elif defined(__powerpc__)
+#define NR_REGISTER_PARAMS	8
+#elif defined(__sparc__)
+#define NR_REGISTER_PARAMS	6
+#elif defined(__riscv) && __riscv_xlen == 64
+#define NR_REGISTER_PARAMS	8
+#elif defined(__arc__)
+#define NR_REGISTER_PARAMS	8
+#else
+#define NR_REGISTER_PARAMS      0
+#endif
+
+static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
+					struct conf_load *conf, int param_idx)
 {
 	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
 
 	if (parm != NULL) {
+		struct location loc;
+
 		tag__init(&parm->tag, cu, die);
 		parm->name = attr_string(die, DW_AT_name, conf);
+
+		/* Parameters which use DW_AT_abstract_origin to point at
+		 * the original parameter definition (with no name in the DIE)
+		 * are the result of later DWARF generation during compilation
+		 * so often better take into account if arguments were
+		 * optimized out.
+		 *
+		 * By checking that locations for parameters that are expected
+		 * to be passed as registers are actually passed as registers,
+		 * we can spot optimized-out parameters.
+		 */
+		if (param_idx < NR_REGISTER_PARAMS && !parm->name &&
+		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
+		    loc.exprlen != 0) {
+			Dwarf_Op *expr = loc.expr;
+
+			switch (expr->atom) {
+			case DW_OP_reg1 ... DW_OP_reg31:
+			case DW_OP_breg0 ... DW_OP_breg31:
+				break;
+			default:
+				parm->optimized = true;
+				break;
+			}
+		}
 	}
 
 	return parm;
@@ -1450,7 +1504,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 					     struct cu *cu, struct conf_load *conf,
 					     int param_idx)
 {
-	struct parameter *parm = parameter__new(die, cu, conf);
+	struct parameter *parm = parameter__new(die, cu, conf, param_idx);
 
 	if (parm == NULL)
 		return NULL;
@@ -2209,6 +2263,10 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
 			}
 			pos->name = tag__parameter(dtype->tag)->name;
 			pos->tag.type = dtype->tag->type;
+			if (pos->optimized) {
+				tag__parameter(dtype->tag)->optimized = pos->optimized;
+				type->optimized_parms = 1;
+			}
 			continue;
 		}
 
@@ -2219,6 +2277,20 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
 		}
 		pos->tag.type = dtype->small_id;
 	}
+	/* if parameters were optimized out, set flag for the ftype this
+	 * function tag referred to via abstract origin.
+	 */
+	if (type->optimized_parms) {
+		struct dwarf_tag *dtype = type->tag.priv;
+		struct dwarf_tag *dftype;
+
+		dftype = dwarf_cu__find_tag_by_ref(dcu, &dtype->abstract_origin);
+		if (dftype && dftype->tag) {
+			struct ftype *ftype = tag__ftype(dftype->tag);
+
+			ftype->optimized_parms = 1;
+		}
+	}
 }
 
 static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
diff --git a/dwarves.h b/dwarves.h
index 589588e..1ad1b3b 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -808,6 +808,7 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
 struct parameter {
 	struct tag tag;
 	const char *name;
+	bool optimized;
 };
 
 static inline struct parameter *tag__parameter(const struct tag *tag)
@@ -827,7 +828,8 @@ struct ftype {
 	struct tag	 tag;
 	struct list_head parms;
 	uint16_t	 nr_parms;
-	uint8_t		 unspec_parms; /* just one bit is needed */
+	uint8_t		 unspec_parms:1; /* just one bit is needed */
+	uint8_t		 optimized_parms:1;
 };
 
 static inline struct ftype *tag__ftype(const struct tag *tag)
-- 
1.8.3.1

