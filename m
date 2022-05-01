Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636CC516743
	for <lists+bpf@lfdr.de>; Sun,  1 May 2022 21:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350163AbiEATET (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 May 2022 15:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351379AbiEATEP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 May 2022 15:04:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2432A19004
        for <bpf@vger.kernel.org>; Sun,  1 May 2022 12:00:49 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241AdpOx017510
        for <bpf@vger.kernel.org>; Sun, 1 May 2022 12:00:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=D9k97TqdTc3U2OnH3waWW5pltbnsVDne6AzzmBDBY1Q=;
 b=Or0aPQGYjjmDsUo9sy3EYUkibx3y47oncQBeIaFe9dDtXHwmjRti+/iSqaYPsExgjdbv
 ft8XRkcgs1JgtcU8XGoIoqaNP5zU3lgYkd2YJyICiAqaWZ8sOcpez6Zmpqf/6Bmu594M
 1zXkzBseJoaiyTSUDxXGVrGXkIkX5Rs7uKM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs2tmwmm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 01 May 2022 12:00:48 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 1 May 2022 12:00:47 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 376ED9C01F86; Sun,  1 May 2022 12:00:44 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 08/12] selftests/bpf: Add BTF_KIND_ENUM64 unit tests
Date:   Sun, 1 May 2022 12:00:44 -0700
Message-ID: <20220501190044.2579654-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220501190002.2576452-1-yhs@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dDhRNTJTfMxX_bt7OoLhgKx8SzAfNA3a
X-Proofpoint-ORIG-GUID: dDhRNTJTfMxX_bt7OoLhgKx8SzAfNA3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-01_07,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add unit tests for basic BTF_KIND_ENUM64 encoding.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 38 ++++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |  1 +
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index 8e068e06b3e8..2af2ce5ec165 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4052,6 +4052,44 @@ static struct btf_raw_test raw_tests[] =3D {
 	.btf_load_err =3D true,
 	.err_str =3D "Type tags don't precede modifiers",
 },
+{
+	.descr =3D "enum64 test #1",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),			/* [1] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 2), 8),	/* [2]=
 */
+		BTF_ENUM64_ENC(NAME_TBD, 0, 0),
+		BTF_ENUM64_ENC(NAME_TBD, 1, 1),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0a\0b\0c"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 8,
+	.key_type_id =3D 1,
+	.value_type_id =3D 2,
+	.max_entries =3D 1,
+},
+{
+	.descr =3D "enum64 test #2, invalid size",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),			/* [1] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 2), 4),	/* [2]=
 */
+		BTF_ENUM64_ENC(NAME_TBD, 0, 0),
+		BTF_ENUM64_ENC(NAME_TBD, 1, 1),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0a\0b\0c"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 8,
+	.key_type_id =3D 1,
+	.value_type_id =3D 2,
+	.max_entries =3D 1,
+	.btf_load_err =3D true,
+	.err_str =3D "Unexpected size",
+},
=20
 }; /* struct btf_raw_test raw_tests[] */
=20
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selft=
ests/bpf/test_btf.h
index 128989bed8b7..240abfca2a8b 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -39,6 +39,7 @@
 #define BTF_MEMBER_ENC(name, type, bits_offset)	\
 	(name), (type), (bits_offset)
 #define BTF_ENUM_ENC(name, val) (name), (val)
+#define BTF_ENUM64_ENC(name, hi32, lo32) (name), (hi32), (lo32)
 #define BTF_MEMBER_OFFSET(bitfield_size, bits_offset) \
 	((bitfield_size) << 24 | (bits_offset))
=20
--=20
2.30.2

