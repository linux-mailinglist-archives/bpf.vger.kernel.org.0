Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C4E4468C6
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 20:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhKETNk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 5 Nov 2021 15:13:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32500 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233159AbhKETNj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 15:13:39 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5I74Nc030300
        for <bpf@vger.kernel.org>; Fri, 5 Nov 2021 12:10:59 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c59kwrec8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 12:10:59 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 12:10:58 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 424337FF890A; Fri,  5 Nov 2021 12:10:57 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: fix non-C89 loop variable declaration in gen_loader.c
Date:   Fri, 5 Nov 2021 12:10:55 -0700
Message-ID: <20211105191055.3324874-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 1A9UGm7x-cJ_DsC50WFkk8cpQHapqSEq
X-Proofpoint-ORIG-GUID: 1A9UGm7x-cJ_DsC50WFkk8cpQHapqSEq
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_02,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=918 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111050104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the `int i` declaration inside the for statement. This is non-C89
compliant. See [0] for user report breaking BCC build.

  [0] https://github.com/libbpf/libbpf/issues/403

Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/gen_loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 502dea53a742..2e10776b6d85 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -584,8 +584,9 @@ void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
 static struct ksym_desc *get_ksym_desc(struct bpf_gen *gen, struct ksym_relo_desc *relo)
 {
 	struct ksym_desc *kdesc;
+	int i;
 
-	for (int i = 0; i < gen->nr_ksyms; i++) {
+	for (i = 0; i < gen->nr_ksyms; i++) {
 		if (!strcmp(gen->ksyms[i].name, relo->name)) {
 			gen->ksyms[i].ref++;
 			return &gen->ksyms[i];
-- 
2.30.2

