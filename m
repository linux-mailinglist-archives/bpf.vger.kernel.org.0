Return-Path: <bpf+bounces-571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A646703E11
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 22:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F83B281340
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 20:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D7619536;
	Mon, 15 May 2023 20:02:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5458D2E4
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 20:02:19 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634FE707
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:02:18 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJxTgQ032442
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:02:17 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj830e3xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:02:17 -0700
Received: from twshared18891.17.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 13:02:16 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 110CB30BBEB1F; Mon, 15 May 2023 13:02:08 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf] samples/bpf: use canonical fallthrough pseudo-keyword in hbm.c
Date: Mon, 15 May 2023 13:02:07 -0700
Message-ID: <20230515200207.2541162-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Q51JeJDRpnNSlFF2Ce13vaIzmCSCoeqU
X-Proofpoint-ORIG-GUID: Q51JeJDRpnNSlFF2Ce13vaIzmCSCoeqU
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rename now unsupported __fallthrough into fallthrough ([0]) in
samples/bpf/hbm.c to fix samples/bpf compilation.

  [0] https://www.kernel.org/doc/html/latest/process/deprecated.html?highli=
ght=3Dfallthrough#implicit-switch-case-fall-through

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 samples/bpf/hbm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index 6448b7826107..7ddf25e9d098 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -498,7 +498,7 @@ int main(int argc, char **argv)
 					"Option -%c requires an argument.\n\n",
 					optopt);
 		case 'h':
-			__fallthrough;
+			fallthrough;
 		default:
 			Usage();
 			return 0;
--=20
2.34.1


