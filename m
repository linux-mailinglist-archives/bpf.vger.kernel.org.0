Return-Path: <bpf+bounces-591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BD770423E
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 02:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877AC1C20CB9
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8717D5;
	Tue, 16 May 2023 00:20:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7776A20
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 00:20:29 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE288A62
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:20:28 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FMktZ7003788
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:20:28 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj5vr8ect-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:20:28 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 17:20:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9FC3830BF0BEA; Mon, 15 May 2023 17:17:20 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf] samples/bpf: drop unnecessary fallthrough
Date: Mon, 15 May 2023 17:17:18 -0700
Message-ID: <20230516001718.317177-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OLmLZG9FfUKqKNRuZw1iSmxAyvS26PAK
X-Proofpoint-GUID: OLmLZG9FfUKqKNRuZw1iSmxAyvS26PAK
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
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

__fallthrough is now not supported. Instead of renaming it to
now-canonical ([0]) fallthrough pseudo-keyword, just get rid of it and
equate 'h' case to default case, as both emit usage information and
succeed.

  [0] https://www.kernel.org/doc/html/latest/process/deprecated.html?highli=
ght=3Dfallthrough#implicit-switch-case-fall-through

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 samples/bpf/hbm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index 6448b7826107..bf66277115e2 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -498,7 +498,6 @@ int main(int argc, char **argv)
 					"Option -%c requires an argument.\n\n",
 					optopt);
 		case 'h':
-			__fallthrough;
 		default:
 			Usage();
 			return 0;
--=20
2.34.1


