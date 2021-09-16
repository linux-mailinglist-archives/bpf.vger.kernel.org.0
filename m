Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632FE40D17B
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 03:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhIPCAM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Sep 2021 22:00:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233367AbhIPCAL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:00:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18FM3sCY012484
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:51 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b3jkac8vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:51 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 18:58:50 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0BB49422A273; Wed, 15 Sep 2021 18:58:40 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/7] libbpf: use pre-setup sec_def in libbpf_find_attach_btf_id()
Date:   Wed, 15 Sep 2021 18:58:30 -0700
Message-ID: <20210916015836.1248906-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916015836.1248906-1-andrii@kernel.org>
References: <20210916015836.1248906-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: imL9lUvbEeP4tJ1QOoavPZImiCGthFD6
X-Proofpoint-ORIG-GUID: imL9lUvbEeP4tJ1QOoavPZImiCGthFD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=700 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't perform another search for sec_def inside
libbpf_find_attach_btf_id(), as each recognized bpf_program already has
prog->sec_def set.

Also remove unnecessary NULL check for prog->sec_name, as it can never
be NULL.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 62a43c408d73..5ba11b249e9b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8461,19 +8461,15 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd,
 {
 	enum bpf_attach_type attach_type = prog->expected_attach_type;
 	__u32 attach_prog_fd = prog->attach_prog_fd;
-	const char *name = prog->sec_name, *attach_name;
-	const struct bpf_sec_def *sec = NULL;
+	const char *attach_name;
 	int err = 0;
 
-	if (!name)
-		return -EINVAL;
-
-	sec = find_sec_def(name);
-	if (!sec || !sec->is_attach_btf) {
-		pr_warn("failed to identify BTF ID based on ELF section name '%s'\n", name);
+	if (!prog->sec_def || !prog->sec_def->is_attach_btf) {
+		pr_warn("failed to identify BTF ID based on ELF section name '%s'\n",
+			prog->sec_name);
 		return -ESRCH;
 	}
-	attach_name = name + sec->len;
+	attach_name = prog->sec_name + prog->sec_def->len;
 
 	/* BPF program's BTF ID */
 	if (attach_prog_fd) {
-- 
2.30.2

