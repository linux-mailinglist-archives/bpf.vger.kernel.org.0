Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77349679BAA
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 15:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjAXOXz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 09:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbjAXOXy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 09:23:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4C37F13
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 06:23:51 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ODI2tq026732;
        Tue, 24 Jan 2023 13:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=kiXRasoYTr/qWeDfho2jTnTv9ttAwukbNpppe2PGAls=;
 b=YEWEnyYr6UI/9y99G2MdY6cXAK1Ft/xzMVToCkCq3kQ3U5kkXaZr6ZSDRRGayGBw7b8y
 lts3QdVYvzbkj9Q52hjV/7CudkDxjj0sMQWEuLapCdoa9htLQCwrs68XblJtx7YHW291
 qWdylogp3ku/kwGbMVc3DuZ43WTOqgUB65sm8Cq6GnNaxu95ygw2Db6fAaJTShKIClaK
 W3ahnpbDKIUpkX/Nl4XO0h8phU0t5m3IlcJNELvl+qwqaOHcEFwELEjrRDY8b+kLPqj9
 7B0BYE0vbKT9aiOSObZMlSUUfKItl0ZQ0ESSdcPDxIv1Vr5rAfcAW/fb/Rsy1Wj8ihzx Tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n0wbtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OBmpLN021339;
        Tue, 24 Jan 2023 13:45:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gbr5t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30ODjZ41037951;
        Tue, 24 Jan 2023 13:45:55 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-161-98.vpn.oracle.com [10.175.161.98])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n86gbr5fj-6;
        Tue, 24 Jan 2023 13:45:55 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 5/5] btf_encoder: skip BTF encoding of static functions with inconsistent prototypes
Date:   Tue, 24 Jan 2023 13:45:31 +0000
Message-Id: <1674567931-26458-6-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: uuol-4J1kywZ8jPqPHYC8FPTvcuo6y2t
X-Proofpoint-ORIG-GUID: uuol-4J1kywZ8jPqPHYC8FPTvcuo6y2t
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two static functions in different CUs can share the same name but
have different function prototypes.  In such a case BTF has no
way currently to map which function description matches which
function site, so it is safer to eliminate such duplicates by
using the same global matching procedure used to identify
functions with optimized-out parameters.  Protoype checking
is done by comparing parameter numbers and then names.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++----------
 dwarves.h     |  1 +
 2 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index a86b099..e0acd29 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -786,21 +786,39 @@ static int function__compare(const void *a, const void *b)
 	return strcmp(function__name(fa), function__name(fb));
 }
 
+#define BTF_ENCODER_MAX_PARAMETERS	10
+
 struct btf_encoder_state {
 	struct btf_encoder *encoder;
 	uint32_t type_id_off;
+	bool got_parameter_names;
+	const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
 };
 
+void parameter_names__get(struct ftype *ftype, size_t nr_parameters, const char **parameter_names)
+{
+	struct parameter *parameter;
+	int i = 0;
+
+	ftype__for_each_parameter(ftype, parameter) {
+		if (i >= nr_parameters)
+			break;
+		parameter_names[i++] = parameter__name(parameter);
+	}
+}
+
 /*
- * static functions with suffixes are not added yet - we need to
- * observe across all CUs to see if the static function has
- * optimized parameters in any CU, since in such a case it should
- * not be included in the final BTF.  NF_HOOK.constprop.0() is
- * a case in point - it has optimized-out parameters in some CUs
- * but not others.  In order to have consistency (since we do not
- * know which instance the BTF-specified function signature will
- * apply to), we simply skip adding functions which have optimized
- * out parameters anywhere.
+ * static functions are not added yet - we need to observe across
+ * all CUs to see if the static function has optimized-out parameters
+ * in any CU, or inconsistent function prototypes; in either case,
+ * it should not be included in the final BTF.  For the optimized-out
+ * case, NF_HOOK.constprop.0() is a case in point - it has optimized-out
+ * parameters in some CUs but not others.  Similarly, a static function
+ * like enable_store() has inconsistent function prototypes in different
+ * CUs so should not be present.  In order to have consistency (since
+ * we do not know which instance the BTF-specified function signature
+ * will apply to), we simply skip adding functions which have
+ * optimized-out parameters/inconsistent function prototypes anywhere.
  */
 static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn)
 {
@@ -819,13 +837,51 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	}
 	/* If we find an existing entry, we want to merge observations
 	 * across both functions, checking that the "seen optimized-out
-	 * parameters" status is reflected in our tree entry.
+	 * parameters"/inconsistent proto status is reflected in tree entry.
 	 * If the entry is new, record encoder state required
 	 * to add the local function later (encoder + type_id_off)
-	 * such that we can add the function later.
+	 * such that we can add the function later.  Parameter names are
+	 * also stored in state to speed up multiple static function
+	 * comparisons.
 	 */
 	if (*nodep != fn) {
-		(*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
+		struct function *ofn = *nodep;
+
+		ofn->proto.optimized_parms |= fn->proto.optimized_parms;
+		/* compare parameters to see if signatures match */
+
+		if (ofn->proto.inconsistent_proto)
+			goto out;
+
+		if (ofn->proto.nr_parms != fn->proto.nr_parms) {
+			ofn->proto.inconsistent_proto = 1;
+			goto out;
+		}
+		if (ofn->proto.nr_parms > 0) {
+			struct btf_encoder_state *state = ofn->priv;
+			const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
+			int i;
+
+			if (!state->got_parameter_names) {
+				parameter_names__get(&ofn->proto, BTF_ENCODER_MAX_PARAMETERS,
+						     state->parameter_names);
+				state->got_parameter_names = true;
+			}
+			parameter_names__get(&fn->proto, BTF_ENCODER_MAX_PARAMETERS,
+					     parameter_names);
+			for (i = 0; i < ofn->proto.nr_parms; i++) {
+				if (!state->parameter_names[i]) {
+					if (!parameter_names[i])
+						continue;
+				} else if (parameter_names[i]) {
+					if (strcmp(state->parameter_names[i],
+						   parameter_names[i]) == 0)
+						continue;
+				}
+				ofn->proto.inconsistent_proto = 1;
+				goto out;
+			}
+		}
 	} else {
 		struct btf_encoder_state *state = zalloc(sizeof(*state));
 
@@ -898,10 +954,12 @@ static void btf_encoder__add_saved_func(const void *nodep, const VISIT which,
 	/* we can safely free encoder state since we visit each node once */
 	free(fn->priv);
 	fn->priv = NULL;
-	if (fn->proto.optimized_parms) {
+	if (fn->proto.optimized_parms || fn->proto.inconsistent_proto) {
 		if (encoder->verbose)
-			printf("skipping addition of '%s' due to optimized-out parameters\n",
-			       function__name(fn));
+			printf("skipping addition of '%s' due to %s\n",
+			       function__name(fn),
+			       fn->proto.optimized_parms ? "optimized-out parameters" :
+							   "multiple inconsistent function prototypes");
 	} else {
 		btf_encoder__add_func(encoder, fn);
 	}
@@ -1775,6 +1833,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		 */
 		if (fn->declaration)
 			continue;
+		if (!fn->external)
+			save = true;
 		if (!ftype__has_arg_names(&fn->proto))
 			continue;
 		if (encoder->functions.cnt) {
@@ -1790,7 +1850,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			if (func) {
 				if (func->generated)
 					continue;
-				func->generated = true;
+				if (!save)
+					func->generated = true;
 			} else if (encoder->functions.suffix_cnt) {
 				/* falling back to name.isra.0 match if no exact
 				 * match is found; only bother if we found any
diff --git a/dwarves.h b/dwarves.h
index 1ad1b3b..9b80262 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -830,6 +830,7 @@ struct ftype {
 	uint16_t	 nr_parms;
 	uint8_t		 unspec_parms:1; /* just one bit is needed */
 	uint8_t		 optimized_parms:1;
+	uint8_t		 inconsistent_proto:1;
 };
 
 static inline struct ftype *tag__ftype(const struct tag *tag)
-- 
1.8.3.1

