Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE35A58182A
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiGZRMD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 13:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbiGZRMC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 13:12:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E226B1D0EF
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:01 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QGXxLu002852
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DxciTCI/czOxJ3Xm+YNnXqXfIqv74dD4skpZ7aRuGZU=;
 b=E9xu7kroeG+OZONUEjcNwa+e3U0QhTmrvL5p0AKFDixbDM0qKPyjpikgzrpIkxTo5e5a
 T6fZfJl70DKE1zmhxWEZ7Os6L513KUazL9TNlX4ardfX/hEWDtRnXksBvPVS2pGYcNHN
 n69dmo20pc5vvxNqaUc9eHbZI/pSv/LYiTQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hj9jmbum7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:01 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:12:00 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id CC1F6D40EA66; Tue, 26 Jul 2022 10:11:56 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 5/7] bpf: arm64: No support of struct value argument
Date:   Tue, 26 Jul 2022 10:11:56 -0700
Message-ID: <20220726171156.713564-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726171129.708371-1-yhs@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Y2RkAzblWRaIzqWYP8gefLhnWJfvLWum
X-Proofpoint-ORIG-GUID: Y2RkAzblWRaIzqWYP8gefLhnWJfvLWum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ARM64 does not support struct value argument for trampoline based
bpf programs yet.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 7ca8779ae34f..27bda6b755ae 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1982,6 +1982,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image,
 	if (nargs > 8)
 		return -ENOTSUPP;
=20
+	/* don't support struct argument */
+	if (m->struct_arg_bsize[0])
+		return -ENOTSUPP;
+
 	ret =3D prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
 	if (ret < 0)
 		return ret;
--=20
2.30.2

