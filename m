Return-Path: <bpf+bounces-7481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DB4778054
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 20:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BFC281F81
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 18:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7B20FAE;
	Thu, 10 Aug 2023 18:35:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15320CA8
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 18:35:29 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830832703
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 11:35:28 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AHSglm019502
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 11:35:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/Rc/2MsEKjjIMoKBSpSJJZRfb+VTBhWebr22HjG7nh4=;
 b=F/ZgEuJw0BP1X2kHEo6JKI9T50FerC0rDtLLHEwzyiRTAce9GxF37fPJObdGPfubI8kl
 JM3HRe/B+qukTnFIX2YAxCrmNggVYKa0XVFPJqPj3KWnnj1XVL/JER1prd1bSAqJ6MHq
 +n14k4Azw2TYmOzKy12QMEN/SsWdhL5SyMQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sd0w7kc26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 11:35:27 -0700
Received: from twshared17985.02.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 11:35:26 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 3ABBE2274BE4B; Thu, 10 Aug 2023 11:35:15 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: Explicitly emit BTF for struct bpf_iter_num, not btf_iter_num
Date: Thu, 10 Aug 2023 11:35:11 -0700
Message-ID: <20230810183513.684836-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810183513.684836-1-davemarchevsky@fb.com>
References: <20230810183513.684836-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EyUtfUoIe98Y4LFN64hI4oBMZAJr6HbG
X-Proofpoint-GUID: EyUtfUoIe98Y4LFN64hI4oBMZAJr6HbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 6018e1f407cc ("bpf: implement numbers iterator") added the
BTF_TYPE_EMIT line that this patch is modifying. The struct btf_iter_num
doesn't exist, so only a forward declaration is emitted in BTF:

  FWD 'btf_iter_num' fwd_kind=3Dstruct

Since that commit was probably hoping to ensure that struct bpf_iter_num
is emitted in vmlinux BTF, this patch changes it to the correct type.

This isn't marked "Fixes" because the extraneous btf_iter_num FWD wasn't
causing any issues that I noticed, aside from mild confusion when I
looked through the code.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/bpf_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 96856f130cbf..20ef64445754 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -793,7 +793,7 @@ __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num =
*it, int start, int end)
 	BUILD_BUG_ON(sizeof(struct bpf_iter_num_kern) !=3D sizeof(struct bpf_it=
er_num));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) !=3D __alignof__(str=
uct bpf_iter_num));
=20
-	BTF_TYPE_EMIT(struct btf_iter_num);
+	BTF_TYPE_EMIT(struct bpf_iter_num);
=20
 	/* start =3D=3D end is legit, it's an empty range and we'll just get NU=
LL
 	 * on first (and any subsequent) bpf_iter_num_next() call
--=20
2.34.1


