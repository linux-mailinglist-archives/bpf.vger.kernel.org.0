Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97486547F3C
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 07:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiFMFpa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 01:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbiFMFoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 01:44:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E229C13D39
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 22:43:20 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25CCfg0k019411
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 22:43:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=1Et9sD425wjUkkvcQvbRk7BSmebj5+XQNNZzVBmcpp4=;
 b=JY7Jay1GUNYJ2z0tg0fjk80TEjNqJCs6Zf6+V8jyYZunLMt6GLI88nnwWKAFhmoe/8W9
 XFGaM2CDYC+Mr1hyVWK4d+k3kyIvPZC5TFWjneGuLcvJwLeDWQnjQmCHUlptmyNX5Z2S
 ebb/MuQ8kg+BBd4BVcEVWMUwLsb5zOeqLT4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gmpj86pbc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 22:43:19 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 12 Jun 2022 22:43:18 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 394EEB89B522; Sun, 12 Jun 2022 22:43:14 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: Fix an unsigned < 0 bug
Date:   Sun, 12 Jun 2022 22:43:14 -0700
Message-ID: <20220613054314.1251905-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: QQTJJ2gJBuyjh7JusXehJMHOTtoSMWEq
X-Proofpoint-ORIG-GUID: QQTJJ2gJBuyjh7JusXehJMHOTtoSMWEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_02,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii reported a bug with the following information:
  2859 	if (enum64_placeholder_id =3D=3D 0) {
  2860 		enum64_placeholder_id =3D btf__add_int(btf, "enum64_placeholder"=
, 1, 0);
  >>>     CID 394804:  Control flow issues  (NO_EFFECT)
  >>>     This less-than-zero comparison of an unsigned value is never tr=
ue. "enum64_placeholder_id < 0U".
  2861 		if (enum64_placeholder_id < 0)
  2862 			return enum64_placeholder_id;
  2863    	...

Here enum64_placeholder_id declared as '__u32' so enum64_placeholder_id <=
 0
is always false.

Declare enum64_placeholder_id as 'int' in order to capture the potential
error properly.

Fixes: f2a625889bb8("libbpf: Add enum64 sanitization")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0781fae58a06..d989b0a17a89 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2786,7 +2786,7 @@ static int bpf_object__sanitize_btf(struct bpf_obje=
ct *obj, struct btf *btf)
 	bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
-	__u32 enum64_placeholder_id =3D 0;
+	int enum64_placeholder_id =3D 0;
 	struct btf_type *t;
 	int i, j, vlen;
=20
--=20
2.30.2

