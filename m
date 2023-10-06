Return-Path: <bpf+bounces-11553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2457BBE2E
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 19:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A936282262
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4534198;
	Fri,  6 Oct 2023 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8D341AA
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 17:58:03 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBCDBF
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 10:57:58 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 396DkBZ5005582
	for <bpf@vger.kernel.org>; Fri, 6 Oct 2023 10:57:57 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3tj6da0007-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 10:57:57 -0700
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 6 Oct 2023 10:57:56 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 43162394AC91F; Fri,  6 Oct 2023 10:57:49 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: don't truncate #test/subtest field
Date: Fri, 6 Oct 2023 10:57:44 -0700
Message-ID: <20231006175744.3136675-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006175744.3136675-1-andrii@kernel.org>
References: <20231006175744.3136675-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6s6mb0CJXYJcf96pYNTVxK8_Tx_3M5eM
X-Proofpoint-GUID: 6s6mb0CJXYJcf96pYNTVxK8_Tx_3M5eM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_14,2023-10-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We currently expect up to a three-digit number of tests and subtests, so:

  #999/999: some_test/some_subtest: ...

Is the largest test/subtest we can see. If we happen to cross into
1000s, current logic will just truncate everything after 7th character.
This patch fixes this truncate and allows to go way higher (up to 31
characters in total). We still nicely align test numbers:

  #60/66   core_reloc_btfgen/type_based___incompat:OK
  #60/67   core_reloc_btfgen/type_based___fn_wrong_args:OK
  #60/68   core_reloc_btfgen/type_id:OK
  #60/69   core_reloc_btfgen/type_id___missing_targets:OK
  #60/70   core_reloc_btfgen/enumval:OK

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 4d582cac2c09..1b9387890148 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -255,7 +255,7 @@ static void print_subtest_name(int test_num, int subt=
est_num,
 			       const char *test_name, char *subtest_name,
 			       char *result)
 {
-	char test_num_str[TEST_NUM_WIDTH + 1];
+	char test_num_str[32];
=20
 	snprintf(test_num_str, sizeof(test_num_str), "%d/%d", test_num, subtest=
_num);
=20
--=20
2.34.1


