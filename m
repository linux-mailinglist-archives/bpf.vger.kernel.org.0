Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C85353A7
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 20:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbiEZSzu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348661AbiEZSzr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 14:55:47 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44700C9ED2
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:46 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QInucL022435
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=sp3U1HSD/aJThxsm3jYAyPeKxudSj1m1ADsCx0XKWLs=;
 b=FPWNzrAtIB+H0D2VJyqA/D/qn5dxgbZdDJsRkcc+8wV3GRJHpRpiaw9LuPHlq6R51nM0
 x6iBch5rKgBMUr7QFH6Ml5tnfLxdp7AKR19QD4NMXHe/+edIZM54dwkXvU6JryC2YW8X
 Jb0frYBrgex14a89o4y9FzbxiRgzI0Or4Ko= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ga5x8ux1a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:45 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 26 May 2022 11:55:44 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A2394AD83DBA; Thu, 26 May 2022 11:55:35 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 12/18] selftests/bpf: Fix selftests failure
Date:   Thu, 26 May 2022 11:55:35 -0700
Message-ID: <20220526185535.2551085-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526185432.2545879-1-yhs@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ixV2nB-hR0xUMInPC4ktTZnb-Wpqwy-p
X-Proofpoint-GUID: ixV2nB-hR0xUMInPC4ktTZnb-Wpqwy-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_10,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

