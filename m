Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825C253C1A6
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiFCCAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 22:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiFCCAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 22:00:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A6396A1
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 19:00:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2530qxb2022195
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 19:00:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=sp3U1HSD/aJThxsm3jYAyPeKxudSj1m1ADsCx0XKWLs=;
 b=Ju+2FxlKzjiootyWnDo6qsGVmb4RWkky0F+7a76/Q/kxKQaQqdpL3g6R10BzecANhXIy
 CMVVM4oH007O7OAPmE+MQVFaLkPEfkn/YQwsc3EA1V9uPRVnziY0FLcNmSKWtqbW69hy
 09xIqfmcFh7Vji/Bb4bTESa018OGtoXzSIA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ge5vcvs4x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 19:00:10 -0700
Received: from twshared17349.03.ash7.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 19:00:09 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3EC6EB299FB4; Thu,  2 Jun 2022 18:59:58 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 12/18] selftests/bpf: Fix selftests failure
Date:   Thu, 2 Jun 2022 18:59:58 -0700
Message-ID: <20220603015958.1192140-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603015855.1187538-1-yhs@fb.com>
References: <20220603015855.1187538-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vxnGWRrMir9ggL4QRtgHevMxPUM9gdaO
X-Proofpoint-ORIG-GUID: vxnGWRrMir9ggL4QRtgHevMxPUM9gdaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_01,2022-06-02_01,2022-02-23_01
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

