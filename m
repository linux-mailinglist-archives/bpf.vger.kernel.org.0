Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACCF5A3B20
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 04:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiH1CzR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 22:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiH1CzO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 22:55:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A359827168
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:10 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27RJWOOu017840
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=J51H2jWPWJgMMTraJhawhVMDXJ8Qg7vhM9/Mzk7kYPk=;
 b=Z5Lx5dqCN8topE/XzCmWeOrL8R+3WZgsPejRVZjQs2i7qjBH6KSFrdR/e8bg5jlObCQN
 kvnGUBRC07UfL17IqyW3HXhlw9/8fROsw5cGo6pNvDtL01XPAUAR0+LWmo+FyQHOTUio
 75T4gwZTeMuLq8Ml7NYg72IHHcfUC7MldsQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j7exy3763-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:09 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 27 Aug 2022 19:55:08 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 64611EA7480F; Sat, 27 Aug 2022 19:54:59 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 4/7] bpf: arm64: No support of struct argument in trampoline programs
Date:   Sat, 27 Aug 2022 19:54:59 -0700
Message-ID: <20220828025459.144471-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220828025438.142798-1-yhs@fb.com>
References: <20220828025438.142798-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: udQDAk9gvhR1ZbpFjLXpu846bZiaQPiU
X-Proofpoint-ORIG-GUID: udQDAk9gvhR1ZbpFjLXpu846bZiaQPiU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
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

