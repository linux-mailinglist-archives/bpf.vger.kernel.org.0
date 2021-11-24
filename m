Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97AD45B0A9
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhKXA0w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:26:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59314 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233081AbhKXA0v (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:26:51 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMf4nu010318
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:42 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch0wxcgv3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:41 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:40 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BB51CA666ABB; Tue, 23 Nov 2021 16:23:39 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 06/13] libbpf: fix using invalidated memory in bpf_linker
Date:   Tue, 23 Nov 2021 16:23:18 -0800
Message-ID: <20211124002325.1737739-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 7jiE82Hf3wvPa_0rZw9VGVOF3LErYUIy
X-Proofpoint-ORIG-GUID: 7jiE82Hf3wvPa_0rZw9VGVOF3LErYUIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=798
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

add_dst_sec() can invalidate bpf_linker's section index making
dst_symtab pointer pointing into unallocated memory. Reinitialize
dst_symtab pointer on each iteration to make sure it's always valid.

Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/linker.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 3e1b2a15fdc7..9aa016fb55aa 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2000,7 +2000,7 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *obj)
 {
 	struct src_sec *src_symtab = &obj->secs[obj->symtab_sec_idx];
-	struct dst_sec *dst_symtab = &linker->secs[linker->symtab_sec_idx];
+	struct dst_sec *dst_symtab;
 	int i, err;
 
 	for (i = 1; i < obj->sec_cnt; i++) {
@@ -2033,6 +2033,9 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 			return -1;
 		}
 
+		/* add_dst_sec() above could have invalidated linker->secs */
+		dst_symtab = &linker->secs[linker->symtab_sec_idx];
+
 		/* shdr->sh_link points to SYMTAB */
 		dst_sec->shdr->sh_link = linker->symtab_sec_idx;
 
-- 
2.30.2

