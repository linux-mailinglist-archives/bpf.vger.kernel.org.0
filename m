Return-Path: <bpf+bounces-10353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013EA7A59AC
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 08:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96661C20D76
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 06:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE623588A;
	Tue, 19 Sep 2023 06:04:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4EF180
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 06:03:58 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D36FC
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:03:57 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J3YsPD007749
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:03:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t73uy1ndu-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:03:56 -0700
Received: from twshared27355.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 18 Sep 2023 23:03:53 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id F00F024985086; Mon, 18 Sep 2023 23:03:44 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        Song Liu
	<song@kernel.org>
Subject: [PATCH bpf 1/2] s390/bpf: Let arch_prepare_bpf_trampoline return program size
Date: Mon, 18 Sep 2023 23:02:57 -0700
Message-ID: <20230919060258.3237176-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919060258.3237176-1-song@kernel.org>
References: <20230919060258.3237176-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CeHgicEH-LORlIzCRTtl-i74GRwfNcky
X-Proofpoint-GUID: CeHgicEH-LORlIzCRTtl-i74GRwfNcky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

arch_prepare_bpf_trampoline() for s390 currently returns 0 on success. Th=
is
is not a problem for regular trampoline. However, struct_ops relies on th=
e
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
---
 arch/s390/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index de2fb12120d2..2861e3360aff 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2513,7 +2513,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image,
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


