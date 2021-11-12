Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3C44DFBB
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 02:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhKLB3U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 20:29:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12710 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234295AbhKLB3T (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 20:29:19 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC1DjBd020322
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:26:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=s5VqcLgoRk7ZX4w8ea0dFTsmN220BBOgMUr4viJdCZM=;
 b=PTS2KqTitLOamAG2Db0xfGLraSglDEufNRsVy6YQI2DkJZxQVfHv10fuWC6awUxXarSY
 ooa0zS8yuCU1tJ50Ur/yrR61oeN7/2jhnNQ5XpuRYJTmdHZcYexf5nEy9HTr84b1oAt+
 meMX8Lh3F/WKf8M5cYMmfm91lLd8dPpDvfs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9dtk06ac-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:26:29 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 17:26:28 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3427C24C5B31; Thu, 11 Nov 2021 17:26:20 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 03/10] bpftool: Support BTF_KIND_TYPE_TAG
Date:   Thu, 11 Nov 2021 17:26:20 -0800
Message-ID: <20211112012620.1505506-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112012604.1504583-1-yhs@fb.com>
References: <20211112012604.1504583-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 30S_BPMammm61sgBStIzV6DzlZZ0OXj1
X-Proofpoint-GUID: 30S_BPMammm61sgBStIzV6DzlZZ0OXj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=880 malwarescore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpftool support for BTF_KIND_TYPE_TAG.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 223ac7676027..c7e3b0b0029e 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -39,6 +39,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =3D=
 {
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
 	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
+	[BTF_KIND_TYPE_TAG]	=3D "TYPE_TAG",
 };
=20
 struct btf_attach_point {
@@ -142,6 +143,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_RESTRICT:
 	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_TYPE_TAG:
 		if (json_output)
 			jsonw_uint_field(w, "type_id", t->type);
 		else
--=20
2.30.2

