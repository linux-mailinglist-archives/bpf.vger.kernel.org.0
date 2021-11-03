Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4358D443A48
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 01:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhKCAM7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 Nov 2021 20:12:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7734 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbhKCAMz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 20:12:55 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LZtXB003797
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 17:10:19 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3dcs0y5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 17:10:19 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 17:10:18 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2BD0C7C14DC5; Tue,  2 Nov 2021 17:10:13 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/5] libbpf: fix section counting logic
Date:   Tue, 2 Nov 2021 17:10:02 -0700
Message-ID: <20211103001003.398812-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103001003.398812-1-andrii@kernel.org>
References: <20211103001003.398812-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 4JJq3OJL2-wk6Rg1t8w3NIDJYTtKLXLu
X-Proofpoint-ORIG-GUID: 4JJq3OJL2-wk6Rg1t8w3NIDJYTtKLXLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

e_shnum does include section #0 and as such is exactly the number of ELF
sections that we need to allocate memory for to use section indices as
array indices. Fix the off-by-one error.

This is purely accounting fix, previously we were overallocating one
too many array items. But no correctness errors otherwise.

Fixes: 25bbbd7a444b ("libbpf: Remove assumptions about uniqueness of .rodata/.data/.bss maps")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 757604b9f869..ecea4dfaca82 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3191,11 +3191,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 	Elf_Scn *scn;
 	Elf64_Shdr *sh;
 
-	/* ELF section indices are 1-based, so allocate +1 element to keep
-	 * indexing simple. Also include 0th invalid section into sec_cnt for
-	 * simpler and more traditional iteration logic.
+	/* ELF section indices are 0-based, but sec #0 is special "invalid"
+	 * section. e_shnum does include sec #0, so e_shnum is the necessary
+	 * size of an array to keep all the sections.
 	 */
-	obj->efile.sec_cnt = 1 + obj->efile.ehdr->e_shnum;
+	obj->efile.sec_cnt = obj->efile.ehdr->e_shnum;
 	obj->efile.secs = calloc(obj->efile.sec_cnt, sizeof(*obj->efile.secs));
 	if (!obj->efile.secs)
 		return -ENOMEM;
-- 
2.30.2

