Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A04403152
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 01:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347179AbhIGXC0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 19:02:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53546 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347209AbhIGXC0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 19:02:26 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187N0bUx013638
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 16:01:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GPgZChJxsIeDuot07XXtlyDBe1m/kxEkiSs3nQDzSJs=;
 b=VmV/7oC5sfhBqu36Pm7NI/droytEf2iz2a1YDxJnNX/EQD7y7KHiIsuTezhAXMZ9MdcH
 CJX1Pu+W1cVxWahLDhtXq59L6FiZeGM+LQZnDiG9boC4lWETAT5Ir3Wq+yKDLmIYcFvW
 LIx/LqeMPQWtJS9tpkGeWOUZx9rrklvgSFA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcqfj824-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 16:01:18 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:01:17 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 890C86E0C0C7; Tue,  7 Sep 2021 16:01:11 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/9] bpftool: add support for BTF_KIND_TAG
Date:   Tue, 7 Sep 2021 16:01:11 -0700
Message-ID: <20210907230111.1959279-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907230050.1957493-1-yhs@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 6z9NPqQZVN9B1S3n1d4PVvX57F-lkncn
X-Proofpoint-GUID: 6z9NPqQZVN9B1S3n1d4PVvX57F-lkncn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109070145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

added bpftool support to dump BTF_KIND_TAG information.
The new bpftool will be used in later patches to dump
btf in the test bpf program object file.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/btf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index f7e5ff3586c9..89c17ea62d8e 100644
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
@@ -347,6 +348,23 @@ static int dump_btf_type(const struct btf *btf, __u3=
2 id,
 			printf(" size=3D%u", t->size);
 		break;
 	}
+	case BTF_KIND_TAG: {
+		const struct btf_tag *tag =3D (const void *)(t + 1);
+
+
+		if (json_output) {
+			jsonw_uint_field(w, "type_id", t->type);
+			if (btf_kflag(t))
+				jsonw_int_field(w, "comp_id", -1);
+			else
+				jsonw_uint_field(w, "comp_id", tag->comp_id);
+		} else if (btf_kflag(t)) {
+			printf(" type_id=3D%u, comp_id=3D-1", t->type);
+		} else {
+			printf(" type_id=3D%u, comp_id=3D%u", t->type, tag->comp_id);
+		}
+		break;
+	}
 	default:
 		break;
 	}
--=20
2.30.2

