Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D605A8131
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiHaP1M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHaP1I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 11:27:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C16D83F4
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:06 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEgxew024424
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=J51H2jWPWJgMMTraJhawhVMDXJ8Qg7vhM9/Mzk7kYPk=;
 b=cLe0SXCpWPohxIx1pv4ybZYiev8kBXCwnY1+sCdu7N6pLGzQISGnt+otMrXOZT+NRBpd
 ZYkSZPS1kGcsBtI//OIqqTIEcBNz9AfJunvR5S2pPe4kWCFlrtYxt9L9/tPIUuuVP7SM
 hhljlbJlw6s2I58UqAPXGNehQ1sGUUqr3Ig= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9ae4jm8h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:06 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 08:27:05 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 956A4ECDED00; Wed, 31 Aug 2022 08:27:02 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 4/8] bpf: arm64: No support of struct argument in trampoline programs
Date:   Wed, 31 Aug 2022 08:27:02 -0700
Message-ID: <20220831152702.2079066-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831152641.2077476-1-yhs@fb.com>
References: <20220831152641.2077476-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RXhVivtKdgvXB-F3jj2nBRG3swGiBbuT
X-Proofpoint-GUID: RXhVivtKdgvXB-F3jj2nBRG3swGiBbuT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ARM64 does not support struct argument for trampoline based
bpf programs yet.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/arm64/net/bpf_jit_comp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 389623ae5a91..30f76178608b 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1970,7 +1970,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image,
 				u32 flags, struct bpf_tramp_links *tlinks,
 				void *orig_call)
 {
-	int ret;
+	int i, ret;
 	int nargs =3D m->nr_args;
 	int max_insns =3D ((long)image_end - (long)image) / AARCH64_INSN_SIZE;
 	struct jit_ctx ctx =3D {
@@ -1982,6 +1982,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image,
 	if (nargs > 8)
 		return -ENOTSUPP;
=20
+	/* don't support struct argument */
+	for (i =3D 0; i < MAX_BPF_FUNC_ARGS; i++) {
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+			return -ENOTSUPP;
+	}
+
 	ret =3D prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
 	if (ret < 0)
 		return ret;
--=20
2.30.2

