Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD364437E97
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 21:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhJVT11 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 22 Oct 2021 15:27:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48508 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233564AbhJVT10 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 15:27:26 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MGmvRi031477
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 12:25:08 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3busjqd2pa-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 12:25:07 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 12:25:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EDF3A70A3A32; Fri, 22 Oct 2021 12:25:04 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: fix the use of aligned attribute
Date:   Fri, 22 Oct 2021 12:25:02 -0700
Message-ID: <20211022192502.2975553-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: LNcr0OAzeC2NRz7fhyJR2H8ZLQxLzgFm
X-Proofpoint-GUID: LNcr0OAzeC2NRz7fhyJR2H8ZLQxLzgFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=660 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Building libbpf sources out of kernel tree (in Github repo) we run into
compilation error due to unknown __aligned attribute. It must be coming
from some kernel header, which is not available to Github sources. Use
explicit __attribute__((aligned(16))) instead.

Fixes: 961632d54163 ("libbpf: Fix dumping non-aligned __int128")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index e9e5801ece4c..3c19644b5fad 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1676,7 +1676,7 @@ static int btf_dump_int_data(struct btf_dump *d,
 {
 	__u8 encoding = btf_int_encoding(t);
 	bool sign = encoding & BTF_INT_SIGNED;
-	char buf[16] __aligned(16);
+	char buf[16] __attribute__((aligned(16)));
 	int sz = t->size;
 
 	if (sz == 0 || sz > sizeof(buf)) {
-- 
2.30.2

