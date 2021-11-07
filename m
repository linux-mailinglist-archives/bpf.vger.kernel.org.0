Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6080344715B
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 04:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhKGECG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 00:02:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49916 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhKGECF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 00:02:05 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A73qJ9v021727
        for <bpf@vger.kernel.org>; Sat, 6 Nov 2021 20:59:23 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c5qf1v4qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 20:59:23 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sat, 6 Nov 2021 20:59:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8804C8288B57; Sat,  6 Nov 2021 20:59:19 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/9] selftests/bpf: free per-cpu values array in bpf_iter selftest
Date:   Sat, 6 Nov 2021 20:59:01 -0700
Message-ID: <20211107035906.548087-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107035906.548087-2-andrii@kernel.org>
References: <20211107035906.548087-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: MPs4hM1l_GA0oIlFspSxte5bdPwSwQT4
X-Proofpoint-ORIG-GUID: MPs4hM1l_GA0oIlFspSxte5bdPwSwQT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=868 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Array holding per-cpu values wasn't freed. Fix that.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 9454331aaf85..71c724a3f988 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -770,6 +770,7 @@ static void test_bpf_percpu_hash_map(void)
 	bpf_link__destroy(link);
 out:
 	bpf_iter_bpf_percpu_hash_map__destroy(skel);
+	free(val);
 }
 
 static void test_bpf_array_map(void)
-- 
2.30.2

