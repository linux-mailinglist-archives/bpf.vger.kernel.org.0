Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653704097EA
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbhIMPxd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 11:53:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238348AbhIMPx1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 11:53:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DF4wi6008987
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:52:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dVanrpvPEH621OgUUZWO5fWpr65o4aW9ll93KGhRDf0=;
 b=XDcShqUlN7aU8h5CvnL4KbowEsNdVEzm91Ezua+VG1hIHoyVI++aNlzr/mMvJLsGkkiK
 Jcb55moof1GZLjDGigV7Cy669dzb6nK0N5KRbTutgHHX+sHP9gx3IGgNHQ2p4F1Tsmzz
 cwVW8SPCP5mHZuLU+X88Zb12tbX+sdtd5CQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1wh83q57-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:52:11 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 08:52:00 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B82CC7279085; Mon, 13 Sep 2021 08:51:55 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 06/11] selftests/bpf: test libbpf API function btf__add_tag()
Date:   Mon, 13 Sep 2021 08:51:55 -0700
Message-ID: <20210913155155.3727843-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913155122.3722704-1-yhs@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: GycFBdJj9w9eUUGZOTp7Z0h4cuRW-hs-
X-Proofpoint-GUID: GycFBdJj9w9eUUGZOTp7Z0h4cuRW-hs-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_07,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 clxscore=1015 mlxlogscore=973 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add btf_write tests with btf__add_tag() function.

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

