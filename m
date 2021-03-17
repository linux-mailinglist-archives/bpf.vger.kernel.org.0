Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A640D33E762
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 04:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCQDDw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 16 Mar 2021 23:03:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14304 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhCQDDd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 16 Mar 2021 23:03:33 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12H2wAVr008535
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 20:03:32 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37a6bs3jmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 20:03:32 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 20:03:32 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0EEB32ED23D6; Tue, 16 Mar 2021 20:03:21 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: drop custom NULL #define in skb_pkt_end selftest
Date:   Tue, 16 Mar 2021 20:03:10 -0700
Message-ID: <20210317030312.802233-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317030312.802233-1-andrii@kernel.org>
References: <20210317030312.802233-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_09:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=857
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103170023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that bpftool generates NULL definition as part of vmlinux.h, drop custom
NULL definition in skb_pkt_end.c.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/skb_pkt_end.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/skb_pkt_end.c b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
index cf6823f42e80..7f2eaa2f89f8 100644
--- a/tools/testing/selftests/bpf/progs/skb_pkt_end.c
+++ b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
@@ -4,7 +4,6 @@
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 
-#define NULL 0
 #define INLINE __always_inline
 
 #define skb_shorter(skb, len) ((void *)(long)(skb)->data + (len) > (void *)(long)skb->data_end)
-- 
2.30.2

