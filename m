Return-Path: <bpf+bounces-10885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E47AF397
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 21:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D443D281C43
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA43D39F;
	Tue, 26 Sep 2023 19:00:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01442AB56
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 19:00:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741CF1BD
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:35 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QIgbtk012306
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tc4h1gdm8-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:34 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 26 Sep 2023 12:00:33 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 431C125006882; Tue, 26 Sep 2023 12:00:27 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        <bjorn@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 1/8] s390/bpf: Let arch_prepare_bpf_trampoline return program size
Date: Tue, 26 Sep 2023 12:00:13 -0700
Message-ID: <20230926190020.1111575-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926190020.1111575-1-song@kernel.org>
References: <20230926190020.1111575-1-song@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: O350gdWB0jvlk6OGEH8AVD-oFe5CeX-A
X-Proofpoint-GUID: O350gdWB0jvlk6OGEH8AVD-oFe5CeX-A
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

arch_prepare_bpf_trampoline() for s390 currently returns 0 on success. This
is not a problem for regular trampoline. However, struct_ops relies on the
return value to advance "image" pointer:

bpf_struct_ops_map_update_elem() {
    ...
    for_each_member(i, t, member) {
        ...
        err =3D bpf_struct_ops_prepare_trampoline();
        ...
        image +=3D err;
    }
}

When arch_prepare_bpf_trampoline returns 0 on success, all members of the
struct_ops will point to the same trampoline (the last one).

Fix this by returning the program size in arch_prepare_bpf_trampoline (on
success). This is the same behavior as other architectures.

Signed-off-by: Song Liu <song@kernel.org>
Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Link: https://lore.kernel.org/r/20230919060258.3237176-2-song@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 9ed0a13865ca..fd1936a63878 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2652,7 +2652,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_imag=
e *im, void *image,
 			return -E2BIG;
 	}
=20
-	return ret;
+	return tjit.common.prg;
 }
=20
 bool bpf_jit_supports_subprog_tailcalls(void)
--=20
2.34.1


