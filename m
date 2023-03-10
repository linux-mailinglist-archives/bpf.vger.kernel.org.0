Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68E06B4B5E
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 16:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCJPnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 10:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjCJPmf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 10:42:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C639B14DA0B
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 07:29:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAsR5J008483;
        Fri, 10 Mar 2023 14:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=CGvSUrhfZOFum3e8EAeCRT1YAnPgrEAcp0iauA/dqWc=;
 b=VPrO/IRnqmhnjq3oqnPc0a/Mo6aMtsmmsuS38ERJFPOdAztX7JdpT1/rqSC5OGRUF7og
 FQzD11qoM3UJ7XKTVpTg1BvbFBS+M1Wy2QXRowA7bkBO6Z5bTKsjcPMojU0h7LY1PFFE
 CkpUwZyVbky5UXhul9OVrJKIQQFf/EHZn5utcpUJUbyam42FtE846lBmcvtvYyYl7908
 CmhnzQjcKSOsEL+8I+NygvSEsrmwclO3Acsc398IQXgUiBKkhVXyD+yQDCqoSyW07bqG
 I/Cd+0u/mLPzBuR8KkLi7Otr5XP+zE14QcpTD+vMmCBhn0FwbLK2+euoywRSE7LqbA6l NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cnc50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:51:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AEMSsu021509;
        Fri, 10 Mar 2023 14:51:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fub0e15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:51:05 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32AEosCR013152;
        Fri, 10 Mar 2023 14:51:05 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-184-199.vpn.oracle.com [10.175.184.199])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6fub0dkf-4;
        Fri, 10 Mar 2023 14:51:04 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 3/3] btf_encoder: compare functions via prototypes not parameter names
Date:   Fri, 10 Mar 2023 14:50:50 +0000
Message-Id: <1678459850-16140-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100121
X-Proofpoint-GUID: wGzOI2I6NUKSm_FFU-H0SFlMV9xtgHd1
X-Proofpoint-ORIG-GUID: wGzOI2I6NUKSm_FFU-H0SFlMV9xtgHd1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Parameter names are a brittle choice for comparing function prototypes.
As noted by Jiri [1], a function can have a weak definition in one
CU with differing names from another definition, and because we require
name-based matches, we can omit functions unnecessarily.  Using a
conf_fprintf that omits parameter names, generate function prototypes
for string comparison instead.

[1] https://lore.kernel.org/bpf/ZAsBYpsBV0wvkhh0@krava/

Reported-by: Jira Olsa <olsajiri@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 67 +++++++++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 07a9dc5..65f6e71 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -33,13 +33,13 @@
 #include <search.h> /* for tsearch(), tfind() and tdestroy() */
 #include <pthread.h>
 
-#define BTF_ENCODER_MAX_PARAMETERS	12
+#define BTF_ENCODER_MAX_PROTO	512
 
 /* state used to do later encoding of saved functions */
 struct btf_encoder_state {
 	uint32_t type_id_off;
-	bool got_parameter_names;
-	const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
+	bool got_proto;
+	char proto[BTF_ENCODER_MAX_PROTO];
 };
 
 struct elf_function {
@@ -798,25 +798,25 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
 	return id;
 }
 
-static void parameter_names__get(struct ftype *ftype, size_t nr_parameters,
-				 const char **parameter_names)
+static bool proto__get(struct function *func, char *proto, size_t len)
 {
-	struct parameter *parameter;
-	int i = 0;
-
-	ftype__for_each_parameter(ftype, parameter) {
-		if (i >= nr_parameters)
-			return;
-		parameter_names[i++] = parameter__name(parameter);
-	}
+	const struct conf_fprintf conf = {
+						.name_spacing = 23,
+						.type_spacing = 26,
+						.emit_stats = 0,
+						.no_parm_names = 1,
+						.skip_emitting_errors = 1,
+						.skip_emitting_modifier = 1,
+					};
+
+	return function__prototype_conf(func, func->priv, &conf, proto, len) != NULL;
 }
 
 static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func, struct function *f2)
 {
-	const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
+	char proto[BTF_ENCODER_MAX_PROTO];
 	struct function *f1 = func->function;
 	const char *name;
-	int i;
 
 	if (!f1)
 		return false;
@@ -833,33 +833,27 @@ static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func,
 	if (f1->proto.nr_parms == 0)
 		return true;
 
-	if (!func->state.got_parameter_names) {
-		parameter_names__get(&f1->proto, BTF_ENCODER_MAX_PARAMETERS,
-				     func->state.parameter_names);
-		func->state.got_parameter_names = true;
-	}
-	parameter_names__get(&f2->proto, BTF_ENCODER_MAX_PARAMETERS, parameter_names);
-	for (i = 0; i < f1->proto.nr_parms && i < BTF_ENCODER_MAX_PARAMETERS; i++) {
-		if (!func->state.parameter_names[i]) {
-			if (!parameter_names[i])
-				continue;
-		} else if (parameter_names[i]) {
-			if (strcmp(func->state.parameter_names[i], parameter_names[i]) == 0)
-				continue;
-		}
-		if (encoder->verbose) {
-			printf("function mismatch for '%s'(%s): parameter #%d '%s' != '%s'\n",
-			       name, f1->alias ?: name, i,
-			       func->state.parameter_names[i] ?: "<null>",
-			       parameter_names[i] ?: "<null>");
+	if (f1->proto.tag.type == f2->proto.tag.type)
+		return true;
+
+	if (!func->state.got_proto)
+		func->state.got_proto = proto__get(f1, func->state.proto, sizeof(func->state.proto));
+
+	if (proto__get(f2, proto, sizeof(proto))) {
+		if (strcmp(func->state.proto, proto) != 0) {
+			if (encoder->verbose)
+				printf("function mismatch for '%s'('%s'): '%s' != '%s'\n",
+				       name, f1->alias ?: name,
+				       func->state.proto, proto);
+			return false;
 		}
-		return false;
 	}
 	return true;
 }
 
 static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
 {
+	fn->priv = encoder->cu;
 	if (func->function) {
 		struct function *existing = func->function;
 
@@ -1022,7 +1016,8 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 	}
 	encoder->functions.entries[encoder->functions.cnt].generated = false;
 	encoder->functions.entries[encoder->functions.cnt].function = NULL;
-	encoder->functions.entries[encoder->functions.cnt].state.got_parameter_names = false;
+	encoder->functions.entries[encoder->functions.cnt].state.got_proto = false;
+	encoder->functions.entries[encoder->functions.cnt].state.proto[0] = '\0';
 	encoder->functions.entries[encoder->functions.cnt].state.type_id_off = 0;
 	encoder->functions.cnt++;
 	return 0;
-- 
1.8.3.1

