Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7568DEB9
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 18:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjBGRQ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 12:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjBGRQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 12:16:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDCE3D917
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 09:15:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317GntAT000474;
        Tue, 7 Feb 2023 17:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=u/BJqxdNNBiN5bw20onBnHiSZ4eo9N/D6gUUi5ML8pQ=;
 b=tXLujS3okwZKhO8r1IEMRqv0EEXwWTcf9KRTS38URjVhMN3VVd/TN2kcvw4ofAmap6AQ
 djxtmOijOPxla7/v3PGlbu+u2JJadcDb7l88tv+cdJ6nkLVGlrhU7aBBSOdon2qqO6dW
 XoZHrpTO8c9UZUlDhGK9EH8lUXMCEoIGGGcamL0t7Wjk6tqrsMJwOTQyHclLKUjTkEz8
 DhWh1n0mxsee/1ZHotUBnoRDPALRWROSkV+wkG0Jd2PAVvwXJ367ul2i0QPbNDQJ2Eia
 bnB3ifiBRy9QCAqvIa9ZMWaEvawW+c406SzgY09LUkhbmO27Uqi+qLtzusFNnpZzGtPB zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy165kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317GWgYM008568;
        Tue, 7 Feb 2023 17:15:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt6e82q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317HF7gS007936;
        Tue, 7 Feb 2023 17:15:19 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-168-65.vpn.oracle.com [10.175.168.65])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt6e7g6-4;
        Tue, 07 Feb 2023 17:15:18 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 3/8] btf_encoder: Refactor function addition into dedicated btf_encoder__add_func
Date:   Tue,  7 Feb 2023 17:14:57 +0000
Message-Id: <1675790102-23037-4-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 130eRyGik6BxXKZNrg1Fom1J0brm5tYM
X-Proofpoint-ORIG-GUID: 130eRyGik6BxXKZNrg1Fom1J0brm5tYM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This will be useful for postponing local function addition later on.
As part of this, store the type id offset and unspecified type in
the encoder, as this will simplify late addition of local functions.

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
---
 btf_encoder.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9063342..71f67ae 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -764,6 +764,31 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
 	return id;
 }
 
+static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
+{
+	int btf_fnproto_id, btf_fn_id, tag_type_id;
+	struct llvm_annotation *annot;
+	const char *name;
+
+	btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
+	name = function__name(fn);
+	btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
+	if (btf_fnproto_id < 0 || btf_fn_id < 0) {
+		printf("error: failed to encode function '%s'\n", function__name(fn));
+		return -1;
+	}
+	list_for_each_entry(annot, &fn->annots, node) {
+		tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id,
+							annot->component_idx);
+		if (tag_type_id < 0) {
+			fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
+				annot->value, name, annot->component_idx);
+			return -1;
+		}
+	}
+	return 0;
+}
+
 /*
  * This corresponds to the same macro defined in
  * include/linux/kallsyms.h
@@ -1589,8 +1614,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	}
 
 	cu__for_each_function(cu, core_id, fn) {
-		int btf_fnproto_id, btf_fn_id;
-		const char *name;
 
 		/*
 		 * Skip functions that:
@@ -1620,24 +1643,9 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 				continue;
 		}
 
-		btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
-		name = function__name(fn);
-		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
-		if (btf_fnproto_id < 0 || btf_fn_id < 0) {
-			err = -1;
-			printf("error: failed to encode function '%s'\n", function__name(fn));
+		err = btf_encoder__add_func(encoder, fn);
+		if (err)
 			goto out;
-		}
-
-		list_for_each_entry(annot, &fn->annots, node) {
-			tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id, annot->component_idx);
-			if (tag_type_id < 0) {
-				fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
-					annot->value, name, annot->component_idx);
-				goto out;
-			}
-		}
-
 	}
 
 	if (!encoder->skip_encoding_vars)
-- 
2.31.1

