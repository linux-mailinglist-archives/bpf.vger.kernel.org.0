Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC5287F32
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 01:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgJHXkZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 8 Oct 2020 19:40:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33476 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731022AbgJHXkY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Oct 2020 19:40:24 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098NZ4UR017547
        for <bpf@vger.kernel.org>; Thu, 8 Oct 2020 16:40:23 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3429gp8w7h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 16:40:23 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 8 Oct 2020 16:40:22 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id A31E12EC7C76; Thu,  8 Oct 2020 16:40:16 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH v2 dwarves 6/8] dwarf_loader: increase the size of lookup hash map
Date:   Thu, 8 Oct 2020 16:39:58 -0700
Message-ID: <20201008234000.740660-7-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201008234000.740660-1-andrii@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_15:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=625 suspectscore=13 impostorscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010080166
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

One of the primary use cases for using pahole is BTF deduplication during
Linux kernel build. That means that DWARF contains more than 5 million types
is loaded. So using a hash map with a small number of buckets is quite
expensive due to hash collisions. This patch bumps the size of the hash map
and reduces overhead of this part of the DWARF loading process.

This shaves off about 1 second out of about 20 seconds total for Linux BTF
dedup.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index d3586aa5b0dd..0e6e4f741922 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -93,7 +93,7 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dtag, dwarf_off_ref spec)
 	*(dwarf_off_ref *)(dtag + 1) = spec;
 }
 
-#define HASHTAGS__BITS 8
+#define HASHTAGS__BITS 15
 #define HASHTAGS__SIZE (1UL << HASHTAGS__BITS)
 
 #define obstack_chunk_alloc malloc
-- 
2.24.1

