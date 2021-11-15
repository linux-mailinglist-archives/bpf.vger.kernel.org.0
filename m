Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE84509D1
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 17:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhKOQmy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 11:42:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37072 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231697AbhKOQmv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Nov 2021 11:42:51 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFGTrba026242
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 08:39:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TByBUj3iFyAscIUEXgZABT5+1vuazU5mFBWEzfDJDvE=;
 b=C4XDVBMrO5JSUzMjRgtoj1wyMsq6fZVTkUenaGxcVkJnuVQvNhdEACE5TUEy6U5sKwQc
 uKXosLqkh7+XF+sRELvOb9wRiRgNr50CgyzOyYj2WUlv5zDYt6IRnxAljQqf7jDqNDZw
 dwK7PqItUOSiwvHrJhLMbNQzvOVWuJrQMzM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cbu4982u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 08:39:49 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 15 Nov 2021 08:39:48 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 142C227673EA; Mon, 15 Nov 2021 08:39:43 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add a dedup selftest with equivalent structure types
Date:   Mon, 15 Nov 2021 08:39:43 -0800
Message-ID: <20211115163943.3922547-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115163932.3921753-1-yhs@fb.com>
References: <20211115163932.3921753-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ZXcWQWNgtpu-emClsYcJcmJD4ePiwZUs
X-Proofpoint-ORIG-GUID: ZXcWQWNgtpu-emClsYcJcmJD4ePiwZUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_10,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=745 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150086
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Without previous libbpf patch, the following error will occur:
  $ ./test_progs -t btf
  ...
  do_test_dedup:FAIL:check btf_dedup failed errno:-22#13/205 btf/dedup: b=
tf_type_tag #5, struct:FAIL

And the previfous libbpf patch fixed the issue.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index 4aa6343dc4c8..f9326a13badb 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7352,6 +7352,32 @@ static struct btf_dedup_test dedup_tests[] =3D {
 		BTF_STR_SEC("\0tag1"),
 	},
 },
+{
+	.descr =3D "dedup: btf_type_tag #5, struct",
+	.input =3D {
+		.raw_types =3D {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),				/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),					/* [2] */
+			BTF_TYPE_ENC(NAME_NTH(2), BTF_INFO_ENC(BTF_KIND_STRUCT, 1, 1), 4),	/*=
 [3] */
+			BTF_MEMBER_ENC(NAME_NTH(3), 2, BTF_MEMBER_OFFSET(0, 0)),
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),					/* [4] */
+			BTF_TYPE_ENC(NAME_NTH(2), BTF_INFO_ENC(BTF_KIND_STRUCT, 1, 1), 4),	/*=
 [5] */
+			BTF_MEMBER_ENC(NAME_NTH(3), 4, BTF_MEMBER_OFFSET(0, 0)),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0t\0m"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),				/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),					/* [2] */
+			BTF_TYPE_ENC(NAME_NTH(2), BTF_INFO_ENC(BTF_KIND_STRUCT, 1, 1), 4),	/*=
 [3] */
+			BTF_MEMBER_ENC(NAME_NTH(3), 2, BTF_MEMBER_OFFSET(0, 0)),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0t\0m"),
+	},
+},
=20
 };
=20
--=20
2.30.2

