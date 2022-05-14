Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F383B526EE3
	for <lists+bpf@lfdr.de>; Sat, 14 May 2022 09:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiENDNi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 23:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiENDNh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 23:13:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E234A026
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:35 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24E16oOO019395
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+oSmLyzwecJ4KlzsbLeYRAYTxV+K9YsNqGvhETr+iy8=;
 b=Jlg9Dv41kcUc+1iUIYmMovMKg3Dz7W+BUkMQ6KXqNTgfSxvGPb75GqPOqfF81pGAavoy
 0aw1Xydotgf6qZ4oEBH87neSED8EiZBunn2jdZonq7UClAoNwiHsCZDDP0bEUrN4g4pu
 EGLTZq+sQaTjDUVpsi08ylpVTTxcQm0xRD4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g1cx9fphx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:34 -0700
Received: from twshared41237.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 20:13:28 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 9B534A45F53F; Fri, 13 May 2022 20:13:24 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 12/18] selftests/bpf: Fix selftests failure
Date:   Fri, 13 May 2022 20:13:24 -0700
Message-ID: <20220514031324.3245558-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220514031221.3240268-1-yhs@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: N49hb2Eh0gMsR2KYbDR5S9p1DxjhHEoE
X-Proofpoint-GUID: N49hb2Eh0gMsR2KYbDR5S9p1DxjhHEoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_11,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kflag is supported now for BTF_KIND_ENUM.
So remove the test which tests verifier failure
due to existence of kflag.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index ba5bde53d418..8e068e06b3e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -2896,26 +2896,6 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid btf_info kind_flag",
 },
=20
-{
-	.descr =3D "invalid enum kind_flag",
-	.raw_types =3D {
-		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
-		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ENUM, 1, 1), 4),	/* [2] */
-		BTF_ENUM_ENC(NAME_TBD, 0),
-		BTF_END_RAW,
-	},
-	BTF_STR_SEC("\0A"),
-	.map_type =3D BPF_MAP_TYPE_ARRAY,
-	.map_name =3D "enum_type_check_btf",
-	.key_size =3D sizeof(int),
-	.value_size =3D sizeof(int),
-	.key_type_id =3D 1,
-	.value_type_id =3D 1,
-	.max_entries =3D 4,
-	.btf_load_err =3D true,
-	.err_str =3D "Invalid btf_info kind_flag",
-},
-
 {
 	.descr =3D "valid fwd kind_flag",
 	.raw_types =3D {
--=20
2.30.2

