Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D93436B9B
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJUT64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 15:58:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231857AbhJUT6y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 15:58:54 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LJatZc028608
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oz4uCYdwZA0C5C/wS6QB20G18IF0NGQR20QM2mze4Kc=;
 b=DZUGSuUYIPcIJPuK6K2tFAwwnPzZULwVSpCiAB5DlacicubYWguSr/a1ivx/kJtGBW7j
 P7rOBIx8uCCSuLPdH2VtJLt/5K9/Q6COfZoGUu/o6SdV8bqgOCxdmuA8JzwNHJxW4lUb
 0ppcpDAvj0jscv7SQc8DfOwfEE42Ogu7CPA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bu90qbmvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:37 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 21 Oct 2021 12:56:36 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 32D661516815; Thu, 21 Oct 2021 12:56:28 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/5] bpf: add BTF_KIND_DECL_TAG typedef support
Date:   Thu, 21 Oct 2021 12:56:28 -0700
Message-ID: <20211021195628.4018847-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021195622.4018339-1-yhs@fb.com>
References: <20211021195622.4018339-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: MlBYPck7b7pL7mFx37RFp_BADjLgPmVn
X-Proofpoint-ORIG-GUID: MlBYPck7b7pL7mFx37RFp_BADjLgPmVn
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_05,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 mlxlogscore=792 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The llvm patches ([1], [2]) added support to attach btf_decl_tag
attributes to typedef declarations. This patch added
support in kernel.

  [1] https://reviews.llvm.org/D110127
  [2] https://reviews.llvm.org/D112259

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9059053088b9..dbc3ad07e21b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -468,7 +468,7 @@ static bool btf_type_is_decl_tag(const struct btf_type =
*t)
 static bool btf_type_is_decl_tag_target(const struct btf_type *t)
 {
 	return btf_type_is_func(t) || btf_type_is_struct(t) ||
-	       btf_type_is_var(t);
+	       btf_type_is_var(t) || btf_type_is_typedef(t);
 }
=20
 u32 btf_nr_types(const struct btf *btf)
@@ -3885,7 +3885,7 @@ static int btf_decl_tag_resolve(struct btf_verifier_e=
nv *env,
=20
 	component_idx =3D btf_type_decl_tag(t)->component_idx;
 	if (component_idx !=3D -1) {
-		if (btf_type_is_var(next_type)) {
+		if (btf_type_is_var(next_type) || btf_type_is_typedef(next_type)) {
 			btf_verifier_log_type(env, v->t, "Invalid component_idx");
 			return -EINVAL;
 		}
--=20
2.30.2

