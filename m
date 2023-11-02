Return-Path: <bpf+bounces-13992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB37DF8B0
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A911C1C20F9D
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC68D200BF;
	Thu,  2 Nov 2023 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B616FAE
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:27:03 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9582194
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:27:01 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A2GVjEb002779
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 10:27:01 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3u3ytfeuun-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 10:27:00 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:26:56 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 258853AD283D9; Thu,  2 Nov 2023 10:26:42 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf] bpf: fix bpf_dynptr_slice() returning ERR_PTR() on erro
Date: Thu, 2 Nov 2023 10:26:40 -0700
Message-ID: <20231102172640.3790869-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LeV1Icab9p3FvTe4yPXuI1jWRPCJsHEG
X-Proofpoint-ORIG-GUID: LeV1Icab9p3FvTe4yPXuI1jWRPCJsHEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_07,2023-11-02_03,2023-05-22_02

Let's fix it for real this time. It shouldn't just detect ERR_PTR()
return from bpf_xdp_pointer(), but also turn that into NULL to follow
bpf_dynptr_slice() contract.

Fixes: 5426700e6841 ("bpf: fix bpf_dynptr_slice() to stop return an ERR_P=
TR.")
Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr=
")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 56b0c1f678ee..04049097176c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2309,7 +2309,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf=
_dynptr_kern *ptr, u32 offset
 	{
 		void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offset + offset, len=
);
 		if (!IS_ERR_OR_NULL(xdp_ptr))
-			return xdp_ptr;
+			return NULL;
=20
 		if (!buffer__opt)
 			return NULL;
--=20
2.34.1


