Return-Path: <bpf+bounces-1356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533E713706
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 00:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BE91C20901
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 22:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634F19516;
	Sat, 27 May 2023 22:31:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5489461
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 22:31:57 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC8B9
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 15:31:52 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34RAGkQA019387
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 15:31:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=K9SVwWttCTfJ3oTGZFJpk7HrOtqS4NA76Vr2OcdYRKY=;
 b=CKfr5iiim3KNUAiTTgU4Dwk5ts5AeO+09lTmr3Q/MZVnBbhXLMA+gKtpEZWqBiVVGsi8
 zvj4nG5ZNC7apYhFA+C3jLUzERn0HfP/CO7upwC3OtLf6u9ajIbc4zI3UakR+EPklg91
 4jdpWVba4M4AqxccLtWgViHPjqdaay8vm3A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qufm12qqw-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 15:31:51 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 15:31:49 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id CF7442058461A; Sat, 27 May 2023 15:31:37 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai
 Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a test where map key_type_id with decl_tag type
Date: Sat, 27 May 2023 15:31:37 -0700
Message-ID: <20230527223137.1580717-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527223132.1580338-1-yhs@fb.com>
References: <20230527223132.1580338-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pt_vOpNMBRe0wSFLI76h5_qff21sjg5u
X-Proofpoint-ORIG-GUID: pt_vOpNMBRe0wSFLI76h5_qff21sjg5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-27_16,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a selftest where map creation key type_id is a decl_tag
pointing to a struct. Without previous patch, a kernel warning will
appear similar to the one in the previous patch. With the previous
patch, the kernel warning is silenced.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index 210d643fda6c..69521e1dc330 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3990,6 +3990,26 @@ static struct btf_raw_test raw_tests[] =3D {
 	.btf_load_err =3D true,
 	.err_str =3D "Invalid arg#1",
 },
+{
+	.descr =3D "decl_tag test #18, struct member, decl_tag as the value typ=
e",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(0, 2, 8),			/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 1, 32),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, -1),		/* [3] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0m1\0m2\0tag"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 8,
+	.key_type_id =3D 1,
+	.value_type_id =3D 3,
+	.max_entries =3D 1,
+	.map_create_err =3D true,
+},
 {
 	.descr =3D "type_tag test #1",
 	.raw_types =3D {
--=20
2.34.1


