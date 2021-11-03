Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B986443A44
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 01:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhKCAMr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 Nov 2021 20:12:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231881AbhKCAMq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 20:12:46 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LbKoi004516
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 17:10:10 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddfgyfj-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 17:10:10 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 17:10:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 02ADC7C14DA9; Tue,  2 Nov 2021 17:10:06 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/5] libbpf: detect corrupted ELF symbols section
Date:   Tue, 2 Nov 2021 17:09:59 -0700
Message-ID: <20211103001003.398812-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103001003.398812-1-andrii@kernel.org>
References: <20211103001003.398812-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: MXfEjWAn15bMdJSgKB4xTjAxVA8vO_TX
X-Proofpoint-GUID: MXfEjWAn15bMdJSgKB4xTjAxVA8vO_TX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=870 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prevent divide-by-zero if ELF is corrupted and has zero sh_entsize.
Reported by oss-fuzz project.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a1bea1953df6..71f5a009010a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3555,7 +3555,7 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 
 	scn = elf_sec_by_idx(obj, obj->efile.symbols_shndx);
 	sh = elf_sec_hdr(obj, scn);
-	if (!sh)
+	if (!sh || sh->sh_entsize != sizeof(Elf64_Sym))
 		return -LIBBPF_ERRNO__FORMAT;
 
 	dummy_var_btf_id = add_dummy_ksym_var(obj->btf);
-- 
2.30.2

