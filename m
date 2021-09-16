Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5663940D179
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 03:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhIPCAI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Sep 2021 22:00:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29990 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhIPCAH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:00:07 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM4CMq030928
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:46 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3pnh250j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:46 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 18:58:45 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 18104422A27D; Wed, 15 Sep 2021 18:58:43 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/7] selftests/bpf: stop using relaxed_core_relocs which has no effect
Date:   Wed, 15 Sep 2021 18:58:31 -0700
Message-ID: <20210916015836.1248906-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916015836.1248906-1-andrii@kernel.org>
References: <20210916015836.1248906-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 55-U03HaPzevJhbflSZ8O30IOAXgBP7J
X-Proofpoint-ORIG-GUID: 55-U03HaPzevJhbflSZ8O30IOAXgBP7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=951 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

relaxed_core_relocs option hasn't had any effect for a while now, stop
specifying it. Next patch marks it as deprecated.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 15d355af8d1d..763302e63a29 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -249,8 +249,7 @@ static int duration = 0;
 #define SIZE_CASE_COMMON(name)						\
 	.case_name = #name,						\
 	.bpf_obj_file = "test_core_reloc_size.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
-	.relaxed_core_relocs = true
+	.btf_src_file = "btf__core_reloc_" #name ".o"
 
 #define SIZE_OUTPUT_DATA(type)						\
 	STRUCT_TO_CHAR_PTR(core_reloc_size_output) {			\
-- 
2.30.2

