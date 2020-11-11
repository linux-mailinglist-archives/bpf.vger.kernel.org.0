Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99B62AFD21
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgKLBcH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 11 Nov 2020 20:32:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36754 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727846AbgKKXMX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Nov 2020 18:12:23 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ABN15oV026219
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 15:12:23 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34qwve9c7k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 15:12:23 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 11 Nov 2020 15:12:22 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DA99E2EC9432; Wed, 11 Nov 2020 15:12:20 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf] selftests/bpf: fix unused attribute usage in subprogs_unused test
Date:   Wed, 11 Nov 2020 15:12:15 -0800
Message-ID: <20201111231215.1779147-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_11:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=637 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=8 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Correct attribute name is "unused". maybe_unused is a C++17 addition.
This patch fixes compilation warning during selftests compilation.

Fixes: 197afc631413 ("libbpf: Don't attempt to load unused subprog as an entry-point BPF program")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_subprogs_unused.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_subprogs_unused.c b/tools/testing/selftests/bpf/progs/test_subprogs_unused.c
index 75d975f8cf90..bc49e050d342 100644
--- a/tools/testing/selftests/bpf/progs/test_subprogs_unused.c
+++ b/tools/testing/selftests/bpf/progs/test_subprogs_unused.c
@@ -4,12 +4,12 @@
 
 const char LICENSE[] SEC("license") = "GPL";
 
-__attribute__((maybe_unused)) __noinline int unused1(int x)
+__attribute__((unused)) __noinline int unused1(int x)
 {
 	return x + 1;
 }
 
-static __attribute__((maybe_unused)) __noinline int unused2(int x)
+static __attribute__((unused)) __noinline int unused2(int x)
 {
 	return x + 2;
 }
-- 
2.24.1

