Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7D42B8A7
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 09:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhJMHQK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 13 Oct 2021 03:16:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17248 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhJMHQJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 03:16:09 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D3BHAU026192
        for <bpf@vger.kernel.org>; Wed, 13 Oct 2021 00:14:06 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bnqav18g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Oct 2021 00:14:06 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 13 Oct 2021 00:14:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5DF58641D3A3; Fri,  1 Oct 2021 11:07:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf] libbpf: fix memory leak in strset
Date:   Fri, 1 Oct 2021 11:07:13 -0700
Message-ID: <20211001180713.1599361-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: RzJbyQQmTNmN6AHdbloUEaElbDwfzFT9
X-Proofpoint-ORIG-GUID: RzJbyQQmTNmN6AHdbloUEaElbDwfzFT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_02,2021-10-13_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 mlxlogscore=687 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Free struct strset itself, not just its internal parts.

Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastructure APIs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/strset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
index 1fb8b49de1d6..ea655318153f 100644
--- a/tools/lib/bpf/strset.c
+++ b/tools/lib/bpf/strset.c
@@ -88,6 +88,7 @@ void strset__free(struct strset *set)
 
 	hashmap__free(set->strs_hash);
 	free(set->strs_data);
+	free(set);
 }
 
 size_t strset__data_size(const struct strset *set)
-- 
2.30.2

