Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182FD40A2D1
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 03:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhINBuG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 13 Sep 2021 21:50:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18836 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235890AbhINBtJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 21:49:09 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DM9YXq024714
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1xp36yds-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:52 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 18:47:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 58B183F9D7CE; Mon, 13 Sep 2021 18:47:43 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/4] libbpf: minimize explicit iterator of section definition array
Date:   Mon, 13 Sep 2021 18:47:33 -0700
Message-ID: <20210914014733.2768-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914014733.2768-1-andrii@kernel.org>
References: <20210914014733.2768-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 0eH783Kj2UXzppjN6-vVOnSM3CSvNW8n
X-Proofpoint-ORIG-GUID: 0eH783Kj2UXzppjN6-vVOnSM3CSvNW8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=896 malwarescore=0 spamscore=0 clxscore=1034
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove almost all the code that explicitly iterated BPF program section
definitions in favor of using find_sec_def(). The only remaining user of
section_defs is libbpf_get_type_names that has to iterate all of them to
construct its result.

Having one internal API entry point for section definitions will
simplify further refactorings around libbpf's program section
definitions parsing.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 46 +++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cdf5249e6353..8834d6f8fed2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8438,22 +8438,13 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd,
 	__u32 attach_prog_fd = prog->attach_prog_fd;
 	const char *name = prog->sec_name, *attach_name;
 	const struct bpf_sec_def *sec = NULL;
-	int i, err = 0;
+	int err = 0;
 
 	if (!name)
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(section_defs); i++) {
-		if (!section_defs[i].is_attach_btf)
-			continue;
-		if (strncmp(name, section_defs[i].sec, section_defs[i].len))
-			continue;
-
-		sec = &section_defs[i];
-		break;
-	}
-
-	if (!sec) {
+	sec = find_sec_def(name);
+	if (!sec || !sec->is_attach_btf) {
 		pr_warn("failed to identify BTF ID based on ELF section name '%s'\n", name);
 		return -ESRCH;
 	}
@@ -8491,27 +8482,28 @@ int libbpf_attach_type_by_name(const char *name,
 			       enum bpf_attach_type *attach_type)
 {
 	char *type_names;
-	int i;
+	const struct bpf_sec_def *sec_def;
 
 	if (!name)
 		return libbpf_err(-EINVAL);
 
-	for (i = 0; i < ARRAY_SIZE(section_defs); i++) {
-		if (strncmp(name, section_defs[i].sec, section_defs[i].len))
-			continue;
-		if (!section_defs[i].is_attachable)
-			return libbpf_err(-EINVAL);
-		*attach_type = section_defs[i].expected_attach_type;
-		return 0;
-	}
-	pr_debug("failed to guess attach type based on ELF section name '%s'\n", name);
-	type_names = libbpf_get_type_names(true);
-	if (type_names != NULL) {
-		pr_debug("attachable section(type) names are:%s\n", type_names);
-		free(type_names);
+	sec_def = find_sec_def(name);
+	if (!sec_def) {
+		pr_debug("failed to guess attach type based on ELF section name '%s'\n", name);
+		type_names = libbpf_get_type_names(true);
+		if (type_names != NULL) {
+			pr_debug("attachable section(type) names are:%s\n", type_names);
+			free(type_names);
+		}
+
+		return libbpf_err(-EINVAL);
 	}
 
-	return libbpf_err(-EINVAL);
+	if (!sec_def->is_attachable)
+		return libbpf_err(-EINVAL);
+
+	*attach_type = sec_def->expected_attach_type;
+	return 0;
 }
 
 int bpf_map__fd(const struct bpf_map *map)
-- 
2.30.2

