Return-Path: <bpf+bounces-10888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554E7AF39B
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 21:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 04506282011
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FE94734E;
	Tue, 26 Sep 2023 19:00:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8D3B7B0
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 19:00:45 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6DF199
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:43 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 38QIgQJ9018173
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:43 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3tc4r2r7bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:42 -0700
Received: from twshared7604.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 26 Sep 2023 12:00:40 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 214C9250068B9; Tue, 26 Sep 2023 12:00:31 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        <bjorn@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 5/8] bpf, x86: Adjust arch_prepare_bpf_trampoline return value
Date: Tue, 26 Sep 2023 12:00:17 -0700
Message-ID: <20230926190020.1111575-6-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926190020.1111575-1-song@kernel.org>
References: <20230926190020.1111575-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: VjmW6RsgTB0hBjChFHdEHS9pRcQ91CKi
X-Proofpoint-ORIG-GUID: VjmW6RsgTB0hBjChFHdEHS9pRcQ91CKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

x86's implementation of arch_prepare_bpf_trampoline() requires
BPF_INSN_SAFETY buffer space between end of program and image_end. OTOH,
the return value does not include BPF_INSN_SAFETY. This doesn't cause any
real issue at the moment. However, "image" of size retval is not enough f=
or
arch_prepare_bpf_trampoline(). This will cause confusion when we introduc=
e
a new helper arch_bpf_trampoline_size(). To avoid future confusion, adjus=
t
the return value to include BPF_INSN_SAFETY.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc239..5f7528cac344 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2671,7 +2671,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 		ret =3D -EFAULT;
 		goto cleanup;
 	}
-	ret =3D prog - (u8 *)image;
+	ret =3D prog - (u8 *)image + BPF_INSN_SAFETY;
=20
 cleanup:
 	kfree(branches);
--=20
2.34.1


