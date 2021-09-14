Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA20D40BB6F
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhINWcB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:32:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31522 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235429AbhINWcB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 18:32:01 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EG1fSu016081
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=EQAo/Uwt1WrnlheGWcc6x/8MuboezbDLDHojDT13/4g=;
 b=Bvog6GCZZOMoE+pphlR+6b9YJERFomeKXoNj+cTJYUGBYZYVmURRKDaP0o5nFblvmj1+
 Rwaad0qVNR6nEFcpN+jhk7n+sHKhFSEaM1UpaG5ubFI2BFeX9rO2Ym/PCKLqMubXS8Eu
 ZlNjBfxfgm2Nrdln9BfBAXxhYT6vbm8Ws3k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2s334m2w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:42 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 15:30:41 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id A360A738223A; Tue, 14 Sep 2021 15:30:36 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 06/11] selftests/bpf: test libbpf API function btf__add_tag()
Date:   Tue, 14 Sep 2021 15:30:36 -0700
Message-ID: <20210914223036.247560-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
References: <20210914223004.244411-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: eKbafCgcTk_Aq0p-UJoti1ji3_j-wRA1
X-Proofpoint-ORIG-GUID: eKbafCgcTk_Aq0p-UJoti1ji3_j-wRA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=967 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add btf_write tests with btf__add_tag() function.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/btf_helpers.c     |  7 ++++++-
 .../selftests/bpf/prog_tests/btf_write.c      | 21 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/se=
lftests/bpf/btf_helpers.c
index b692e6ead9b5..ce103fb0ad1b 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -24,11 +24,12 @@ static const char * const btf_kind_str_mapping[] =3D =
{
 	[BTF_KIND_VAR]		=3D "VAR",
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
+	[BTF_KIND_TAG]		=3D "TAG",
 };
=20
 static const char *btf_kind_str(__u16 kind)
 {
-	if (kind > BTF_KIND_DATASEC)
+	if (kind > BTF_KIND_TAG)
 		return "UNKNOWN";
 	return btf_kind_str_mapping[kind];
 }
@@ -177,6 +178,10 @@ int fprintf_btf_type_raw(FILE *out, const struct btf=
 *btf, __u32 id)
 	case BTF_KIND_FLOAT:
 		fprintf(out, " size=3D%u", t->size);
 		break;
+	case BTF_KIND_TAG:
+		fprintf(out, " type_id=3D%u component_idx=3D%d",
+			t->type, btf_tag(t)->component_idx);
+		break;
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_write.c
index 022c7d89d6f4..76548eecce2c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -281,5 +281,26 @@ void test_btf_write() {
 		     "[17] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
 		     "\ttype_id=3D1 offset=3D4 size=3D8", "raw_dump");
=20
+	/* TAG */
+	id =3D btf__add_tag(btf, "tag1", 16, -1);
+	ASSERT_EQ(id, 18, "tag_id");
+	t =3D btf__type_by_id(btf, 18);
+	ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "tag1", "tag_value")=
;
+	ASSERT_EQ(btf_kind(t), BTF_KIND_TAG, "tag_kind");
+	ASSERT_EQ(t->type, 16, "tag_type");
+	ASSERT_EQ(btf_tag(t)->component_idx, -1, "tag_component_idx");
+	ASSERT_STREQ(btf_type_raw_dump(btf, 18),
+		     "[18] TAG 'tag1' type_id=3D16 component_idx=3D-1", "raw_dump");
+
+	id =3D btf__add_tag(btf, "tag2", 14, 1);
+	ASSERT_EQ(id, 19, "tag_id");
+	t =3D btf__type_by_id(btf, 19);
+	ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "tag2", "tag_value")=
;
+	ASSERT_EQ(btf_kind(t), BTF_KIND_TAG, "tag_kind");
+	ASSERT_EQ(t->type, 14, "tag_type");
+	ASSERT_EQ(btf_tag(t)->component_idx, 1, "tag_component_idx");
+	ASSERT_STREQ(btf_type_raw_dump(btf, 19),
+		     "[19] TAG 'tag2' type_id=3D14 component_idx=3D1", "raw_dump");
+
 	btf__free(btf);
 }
--=20
2.30.2

