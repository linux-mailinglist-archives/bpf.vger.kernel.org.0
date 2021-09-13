Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5754097E5
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 17:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244807AbhIMPxS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 11:53:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47540 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244551AbhIMPxK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 11:53:10 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DF56W0014477
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:51:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=28VJ10Z+eSw1xnnp1vygxI4sjGr1JlObrqe5+oV+l8A=;
 b=RDJ2ivVTdESAAeDnzO/cvf1djxG2+x5OSXuQ1MNu9DXAtXzjgACnUvf17SeEbwqGZ9BH
 /0I41mXK2fbVS/qP+8xKR+ChFI5RQuStTq9TjMZzICZVTbiGAd+UCXBoF3e7mWnxETlN
 V+heFMmzPwulX+px+necWlUPmnofExw7ePs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1vfcux2e-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:51:53 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 08:51:50 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7CC367279073; Mon, 13 Sep 2021 08:51:50 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 05/11] bpftool: add support for BTF_KIND_TAG
Date:   Mon, 13 Sep 2021 08:51:50 -0700
Message-ID: <20210913155150.3727112-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913155122.3722704-1-yhs@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: _MRB44QWRmDVC3t9Izqc0DjqDcG5MX5Q
X-Proofpoint-ORIG-GUID: _MRB44QWRmDVC3t9Izqc0DjqDcG5MX5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_07,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added bpftool support to dump BTF_KIND_TAG information.
The new bpftool will be used in later patches to dump
btf in the test bpf program object file.

Currently, the tags are not emitted with
  bpftool btf dump file <path> format c
and they are silently ignored.  The tag information is
mostly used in the kernel for verification purpose and the kernel
uses its own btf to check. With adding these tags
to vmlinux.h, tags will be encoded in program's btf but
they will not be used by the kernel, at least for now.
So let us delay adding these tags to format C header files
until there is a real need.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/btf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index f7e5ff3586c9..49743ad96851 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -37,6 +37,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =3D=
 {
 	[BTF_KIND_VAR]		=3D "VAR",
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
+	[BTF_KIND_TAG]		=3D "TAG",
 };
=20
 struct btf_attach_table {
@@ -347,6 +348,17 @@ static int dump_btf_type(const struct btf *btf, __u3=
2 id,
 			printf(" size=3D%u", t->size);
 		break;
 	}
+	case BTF_KIND_TAG: {
+		const struct btf_tag *tag =3D (const void *)(t + 1);
+
+		if (json_output) {
+			jsonw_uint_field(w, "type_id", t->type);
+			jsonw_int_field(w, "component_idx", tag->component_idx);
+		} else {
+			printf(" type_id=3D%u component_idx=3D%d", t->type, tag->component_id=
x);
+		}
+		break;
+	}
 	default:
 		break;
 	}
--=20
2.30.2

