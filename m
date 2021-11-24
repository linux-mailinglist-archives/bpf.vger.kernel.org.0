Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96A45B0A7
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhKXA0w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:26:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11832 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232131AbhKXA0t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:26:49 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMf81W031448
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:41 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cgrqjf09k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:41 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:39 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A296BA666AB1; Tue, 23 Nov 2021 16:23:35 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 04/13] libbpf: don't call libc APIs with NULL pointers
Date:   Tue, 23 Nov 2021 16:23:16 -0800
Message-ID: <20211124002325.1737739-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: tiIq6aFSu8FscbdZoig61yo1P_5f7B3r
X-Proofpoint-ORIG-GUID: tiIq6aFSu8FscbdZoig61yo1P_5f7B3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=963
 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sanitizer complains about qsort(), bsearch(), and memcpy() being called
with NULL pointer. This can only happen when the associated number of
elements is zero, so no harm should be done. But still prevent this from
happening to keep sanitizer runs clean from extra noise.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index af405c38aadc..23f84757c806 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3369,7 +3369,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 
 	/* sort BPF programs by section name and in-section instruction offset
 	 * for faster search */
-	qsort(obj->programs, obj->nr_programs, sizeof(*obj->programs), cmp_progs);
+	if (obj->nr_programs)
+		qsort(obj->programs, obj->nr_programs, sizeof(*obj->programs), cmp_progs);
 
 	return bpf_object__init_btf(obj, btf_data, btf_ext_data);
 }
@@ -5816,6 +5817,8 @@ static int cmp_relo_by_insn_idx(const void *key, const void *elem)
 
 static struct reloc_desc *find_prog_insn_relo(const struct bpf_program *prog, size_t insn_idx)
 {
+	if (!prog->nr_reloc)
+		return NULL;
 	return bsearch(&insn_idx, prog->reloc_desc, prog->nr_reloc,
 		       sizeof(*prog->reloc_desc), cmp_relo_by_insn_idx);
 }
@@ -5831,8 +5834,9 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	relos = libbpf_reallocarray(main_prog->reloc_desc, new_cnt, sizeof(*relos));
 	if (!relos)
 		return -ENOMEM;
-	memcpy(relos + main_prog->nr_reloc, subprog->reloc_desc,
-	       sizeof(*relos) * subprog->nr_reloc);
+	if (subprog->nr_reloc)
+		memcpy(relos + main_prog->nr_reloc, subprog->reloc_desc,
+		       sizeof(*relos) * subprog->nr_reloc);
 
 	for (i = main_prog->nr_reloc; i < new_cnt; i++)
 		relos[i].insn_idx += subprog->sub_insn_off;
-- 
2.30.2

