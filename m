Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD82403155
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 01:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347298AbhIGXCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 19:02:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58028 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347209AbhIGXCl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 19:02:41 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187MwRwq008626
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 16:01:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LjXv+3rDXgR4moHeWRPdLKLs0q2p/zNS9ELHqkIlwic=;
 b=JtMsEMcXZL9fz9ueWO0XzAmZTO9JAyCj4Uu9AFihdhiFH4P6Y8FQq49TcyTgf2cSyN2j
 PL0NHqNRRkMvxRp+TJ7PVtZa4sQZWaXfnyflMHW2Ly0RRXwz3vc3mnPHTnNdHGa/4Y4G
 i6ywx3IULixf5cq6XBOo/+azoBma8IgZ6Ec= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpgj76w-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 16:01:34 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:01:20 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E6B5A6E0C0D7; Tue,  7 Sep 2021 16:01:16 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/9] selftests/bpf: test libbpf API function btf__add_tag()
Date:   Tue, 7 Sep 2021 16:01:16 -0700
Message-ID: <20210907230116.1959597-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907230050.1957493-1-yhs@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: tiV2TPZ_UdNX8Ew5VyFnzXQMA-h9zBOa
X-Proofpoint-GUID: tiV2TPZ_UdNX8Ew5VyFnzXQMA-h9zBOa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add btf_write tests with btf__add_tag() function.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/btf_helpers.c     |  7 +++++-
 .../selftests/bpf/prog_tests/btf_write.c      | 23 +++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/se=
lftests/bpf/btf_helpers.c
index b692e6ead9b5..20dc8f4cb884 100644
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
+		fprintf(out, " type_id=3D%u, comp_id=3D%d",
+			t->type, btf_kflag(t) ? -1 : (int)btf_tag(t)->comp_id);
+		break;
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_write.c
index 022c7d89d6f4..d20db7814ed1 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -281,5 +281,28 @@ void test_btf_write() {
 		     "[17] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
 		     "\ttype_id=3D1 offset=3D4 size=3D8", "raw_dump");
=20
+	/* TAG */
+	id =3D btf__add_tag(btf, "tag1", -1, 16);
+	ASSERT_EQ(id, 18, "tag_id");
+	t =3D btf__type_by_id(btf, 18);
+	ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "tag1", "tag_name");
+	ASSERT_EQ(btf_kind(t), BTF_KIND_TAG, "tag_kind");
+	ASSERT_EQ(btf_kflag(t), true, "tag_kflag");
+	ASSERT_EQ(t->type, 16, "tag_type");
+	ASSERT_EQ(btf_tag(t)->comp_id, 0, "tag_comp_id");
+	ASSERT_STREQ(btf_type_raw_dump(btf, 18),
+		     "[18] TAG 'tag1' type_id=3D16, comp_id=3D-1", "raw_dump");
+
+	id =3D btf__add_tag(btf, "tag2", 1, 14);
+	ASSERT_EQ(id, 19, "tag_id");
+	t =3D btf__type_by_id(btf, 19);
+	ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "tag2", "tag_name");
+	ASSERT_EQ(btf_kind(t), BTF_KIND_TAG, "tag_kind");
+	ASSERT_EQ(btf_kflag(t), false, "tag_kflag");
+	ASSERT_EQ(t->type, 14, "tag_type");
+	ASSERT_EQ(btf_tag(t)->comp_id, 1, "tag_comp_id");
+	ASSERT_STREQ(btf_type_raw_dump(btf, 19),
+		     "[19] TAG 'tag2' type_id=3D14, comp_id=3D1", "raw_dump");
+
 	btf__free(btf);
 }
--=20
2.30.2

