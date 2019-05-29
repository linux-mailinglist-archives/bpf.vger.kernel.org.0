Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2ED2D31C
	for <lists+bpf@lfdr.de>; Wed, 29 May 2019 03:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfE2BOe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 May 2019 21:14:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60322 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbfE2BOe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 May 2019 21:14:34 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T1BlI3018968
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 18:14:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=q0gZeQn06XfmdaZyNCuqGSfc6wOnjFCu+fmwFIviwBw=;
 b=rOSNG4bKKoBkxlFVmmdwHpWukwpZdKrkhvXKLOgasl3JAOceLRXfKGrIqIfda6rIUE3B
 xB5FhS06dlxPKrIHf34hklYHRUX3J+L3g1X8O3VydZjiWy1ADGYYWtwGgw1lUmzLILPg
 E9ct/epeFNhNYzk7xMMw0kAdZMhHxG14N+4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2ssckegpb4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 18:14:32 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 May 2019 18:14:32 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id E0BE38617AA; Tue, 28 May 2019 18:14:30 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/9] libbpf: fix detection of corrupted BPF instructions section
Date:   Tue, 28 May 2019 18:14:18 -0700
Message-ID: <20190529011426.1328736-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529011426.1328736-1-andriin@fb.com>
References: <20190529011426.1328736-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=887 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure that size of a section w/ BPF instruction is exactly a multiple
of BPF instruction size.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ca4432f5b067..05a73223e524 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -349,8 +349,11 @@ static int
 bpf_program__init(void *data, size_t size, char *section_name, int idx,
 		  struct bpf_program *prog)
 {
-	if (size < sizeof(struct bpf_insn)) {
-		pr_warning("corrupted section '%s'\n", section_name);
+	const size_t bpf_insn_sz = sizeof(struct bpf_insn);
+
+	if (size < bpf_insn_sz || size % bpf_insn_sz) {
+		pr_warning("corrupted section '%s', size: %zu\n",
+			   section_name, size);
 		return -EINVAL;
 	}
 
@@ -376,9 +379,8 @@ bpf_program__init(void *data, size_t size, char *section_name, int idx,
 			   section_name);
 		goto errout;
 	}
-	prog->insns_cnt = size / sizeof(struct bpf_insn);
-	memcpy(prog->insns, data,
-	       prog->insns_cnt * sizeof(struct bpf_insn));
+	prog->insns_cnt = size / bpf_insn_sz;
+	memcpy(prog->insns, data, prog->insns_cnt * bpf_insn_sz);
 	prog->idx = idx;
 	prog->instances.fds = NULL;
 	prog->instances.nr = -1;
-- 
2.17.1

