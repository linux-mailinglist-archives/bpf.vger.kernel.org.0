Return-Path: <bpf+bounces-8422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3721B786430
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 02:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FDA1C20D5A
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33515CC;
	Thu, 24 Aug 2023 00:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B110E6
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 00:00:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CBD10E4
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:00:35 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NLNgZH001992
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:00:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sn2106dp3-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:00:35 -0700
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 23 Aug 2023 17:00:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6436736BE4D9E; Wed, 23 Aug 2023 17:00:19 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Lorenz Bauer
	<lmb@isovalent.com>
Subject: [PATCH bpf-next 2/2] libbpf: fix signedness determination in CO-RE relo handling logic
Date: Wed, 23 Aug 2023 17:00:16 -0700
Message-ID: <20230824000016.2658017-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824000016.2658017-1-andrii@kernel.org>
References: <20230824000016.2658017-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0DDzDcQIQqMGXC_SBTx0Lgn1MimmmdUA
X-Proofpoint-ORIG-GUID: 0DDzDcQIQqMGXC_SBTx0Lgn1MimmmdUA
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_16,2023-08-22_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extracting btf_int_encoding() is only meaningful for BTF_KIND_INT, so we
need to check that first before inferring signedness.

Closes: https://github.com/libbpf/libbpf/issues/704
Reported-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/relo_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index a26b2f5fa0fc..63a4d5ad12d1 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -776,7 +776,7 @@ static int bpf_core_calc_field_relo(const char *prog_na=
me,
 		break;
 	case BPF_CORE_FIELD_SIGNED:
 		*val =3D (btf_is_any_enum(mt) && BTF_INFO_KFLAG(mt->info)) ||
-		       (btf_int_encoding(mt) & BTF_INT_SIGNED);
+		       (btf_is_int(mt) && (btf_int_encoding(mt) & BTF_INT_SIGNED));
 		if (validate)
 			*validate =3D true; /* signedness is never ambiguous */
 		break;
--=20
2.34.1


