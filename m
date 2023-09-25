Return-Path: <bpf+bounces-10792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 545377AE109
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id A37E2B209A1
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF9250F2;
	Mon, 25 Sep 2023 21:53:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2F2421C
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:53:49 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A91112
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:53:48 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 38PKHCmY019214
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:53:47 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3taqndx0e1-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:53:47 -0700
Received: from twshared7604.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 25 Sep 2023 14:53:42 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id C507B24F3942D; Mon, 25 Sep 2023 14:53:30 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        Song
 Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 1/8] s390/bpf: Let arch_prepare_bpf_trampoline return program size
Date: Mon, 25 Sep 2023 14:53:17 -0700
Message-ID: <20230925215324.2962716-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925215324.2962716-1-song@kernel.org>
References: <20230925215324.2962716-1-song@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: So3iWOt-xNo0DV_XDdR-e5WgA8JvRdeG
X-Proofpoint-ORIG-GUID: So3iWOt-xNo0DV_XDdR-e5WgA8JvRdeG
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
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
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


