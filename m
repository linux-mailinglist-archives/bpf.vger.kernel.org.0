Return-Path: <bpf+bounces-1193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24E6710129
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 00:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637971C20D3A
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 22:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3437881F;
	Wed, 24 May 2023 22:55:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200F8498
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 22:55:24 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF990
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:22 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHRoZu029231
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:21 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qsde0e538-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:21 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 15:55:19 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B666F3149A89F; Wed, 24 May 2023 15:55:06 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 3/3] bpf: don't require bpf_capable() for GET_INFO_BY_FD
Date: Wed, 24 May 2023 15:54:21 -0700
Message-ID: <20230524225421.1587859-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524225421.1587859-1-andrii@kernel.org>
References: <20230524225421.1587859-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BMI3raIbAdjf7lOOj7w9druVNdTmyLLu
X-Proofpoint-ORIG-GUID: BMI3raIbAdjf7lOOj7w9druVNdTmyLLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_15,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The rest of BPF subsystem follows the rule that if process managed to
get BPF object FD, then it has an ownership of this object, and thus can
query any information about it, or update it. Doing something special in
GET_INFO_BY_FD operation based on bpf_capable() goes against that
philosophy, so drop the check and unify the approach with the rest of
bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1d74c0a8d903..b07453ce10e7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4022,17 +4022,6 @@ static int bpf_prog_get_info_by_fd(struct file *fi=
le,
=20
 	info.verified_insns =3D prog->aux->verified_insns;
=20
-	if (!bpf_capable()) {
-		info.jited_prog_len =3D 0;
-		info.xlated_prog_len =3D 0;
-		info.nr_jited_ksyms =3D 0;
-		info.nr_jited_func_lens =3D 0;
-		info.nr_func_info =3D 0;
-		info.nr_line_info =3D 0;
-		info.nr_jited_line_info =3D 0;
-		goto done;
-	}
-
 	ulen =3D info.xlated_prog_len;
 	info.xlated_prog_len =3D bpf_prog_insn_size(prog);
 	if (info.xlated_prog_len && ulen) {
--=20
2.34.1


