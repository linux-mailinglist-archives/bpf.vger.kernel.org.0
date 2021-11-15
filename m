Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2D34509D2
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 17:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhKOQmy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 11:42:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231695AbhKOQmv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Nov 2021 11:42:51 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFFNhd4028748
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 08:39:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=V2fURqrfx3yc5dC2QjkEtKooP4Vh4/gEWKIS+LxosIA=;
 b=JLmM9T4NtczkT+kgkA9X9hII911VmdrhripxlBvJ7HehJ45MuJFkwUFOo/66QMEQaZRZ
 XRbUBkHm9XYV9ET51QX9AGuO+VeqGNaZy6o5NrGKcteGNS/CI1HK9FOsAabVTiVWwSTd
 /dqNJ3m48lQ1ikHw50Owd0a3pNL2O9HMY60= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cb34ayjb3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 08:39:46 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 15 Nov 2021 08:39:41 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id CF90727673E1; Mon, 15 Nov 2021 08:39:37 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/2] libbpf: fix a couple of missed btf_type_tag handling in btf.c
Date:   Mon, 15 Nov 2021 08:39:37 -0800
Message-ID: <20211115163937.3922235-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115163932.3921753-1-yhs@fb.com>
References: <20211115163932.3921753-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: aJgIVZ789oduKTDuAsUgCnyelfhPiqd-
X-Proofpoint-ORIG-GUID: aJgIVZ789oduKTDuAsUgCnyelfhPiqd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_10,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150086
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 2dc1e488e5cd ("libbpf: Support BTF_KIND_TYPE_TAG") added
BTF_KIND_TYPE_TAG support. But to test vmlinux build with
  #define __user __attribute__((btf_type_tag("user")))
I need to sync libbpf repo and manually copy libbpf sources
to pahole. To simplify process, I used BTF_KIND_RESTRICT to
simulate BTF_KIND_TYPE_TAG with vmlinux build as "restrict"
modifier is barely used in kernel. But this approach missed
one case in dedup with structures where BTF_KIND_RESTRICT is
handled and BTF_KIND_TYPE_TAG is not handled in
btf_dedup_is_equiv(), and this will result in pahole dedup
failure. This patch fixed this issue and a selftest is added in
the subsequent patch to test this scenario.

The other missed handling is in btf__resolve_size().
Currently the compiler always emit like PTR->TYPE_TAG->...
so in practice we don't hit the missing BTF_KIND_TYPE_TAG handling
issue with compiler generated code. But let us added
case BTF_KIND_TYPE_TAG in the switch statement
to be future proof.

Fixes: 2dc1e488e5cd ("libbpf: Support BTF_KIND_TYPE_TAG")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index fadf089ae8fe..b6be579e0dc6 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -610,6 +610,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 =
type_id)
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_VAR:
 		case BTF_KIND_DECL_TAG:
+		case BTF_KIND_TYPE_TAG:
 			type_id =3D t->type;
 			break;
 		case BTF_KIND_ARRAY:
@@ -4023,6 +4024,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, =
__u32 cand_id,
 	case BTF_KIND_PTR:
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
+	case BTF_KIND_TYPE_TAG:
 		if (cand_type->info !=3D canon_type->info)
 			return 0;
 		return btf_dedup_is_equiv(d, cand_type->type, canon_type->type);
--=20
2.30.2

