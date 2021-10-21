Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFEE43586B
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJUBqx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Oct 2021 21:46:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23260 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230368AbhJUBqw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 21:46:52 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KN9pmc024692
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3btqsf33mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:37 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 18:44:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5CD356E3E199; Wed, 20 Oct 2021 18:44:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 06/10] bpftool: improve skeleton generation for data maps without DATASEC type
Date:   Wed, 20 Oct 2021 18:44:00 -0700
Message-ID: <20211021014404.2635234-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021014404.2635234-1-andrii@kernel.org>
References: <20211021014404.2635234-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: A06t4ZhGzjwG8aQei2vJRvsd0cuhQPHq
X-Proofpoint-ORIG-GUID: A06t4ZhGzjwG8aQei2vJRvsd0cuhQPHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It can happen that some data sections (e.g., .rodata.cst16, containing
compiler populated string constants) won't have a corresponding BTF
DATASEC type. Now that libbpf supports .rodata.* and .data.* sections,
situation like that will cause invalid BPF skeleton to be generated that
won't compile successfully, as some parts of skeleton would assume
memory-mapped struct definitions for each special data section.

Fix this by generating empty struct definitions for such data sections.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 51 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 59afe9a2ca3c..c446405ab73f 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -213,22 +213,61 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 	struct btf *btf = bpf_object__btf(obj);
 	int n = btf__get_nr_types(btf);
 	struct btf_dump *d;
+	struct bpf_map *map;
+	const struct btf_type *sec;
+	char sec_ident[256], map_ident[256];
 	int i, err = 0;
 
 	d = btf_dump__new(btf, NULL, NULL, codegen_btf_dump_printf);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
-	for (i = 1; i <= n; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
+	bpf_object__for_each_map(map, obj) {
+		/* only generate definitions for memory-mapped internal maps */
+		if (!bpf_map__is_internal(map))
+			continue;
+		if (!(bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
+			continue;
 
-		if (!btf_is_datasec(t))
+		if (!get_map_ident(map, map_ident, sizeof(map_ident)))
 			continue;
 
-		err = codegen_datasec_def(obj, btf, d, t, obj_name);
-		if (err)
-			goto out;
+		sec = NULL;
+		for (i = 1; i <= n; i++) {
+			const struct btf_type *t = btf__type_by_id(btf, i);
+			const char *name;
+
+			if (!btf_is_datasec(t))
+				continue;
+
+			name = btf__str_by_offset(btf, t->name_off);
+			if (!get_datasec_ident(name, sec_ident, sizeof(sec_ident)))
+				continue;
+
+			if (strcmp(sec_ident, map_ident) == 0) {
+				sec = t;
+				break;
+			}
+		}
+
+		/* In some cases (e.g., sections like .rodata.cst16 containing
+		 * compiler allocated string constants only) there will be
+		 * special internal maps with no corresponding DATASEC BTF
+		 * type. In such case, generate empty structs for each such
+		 * map. It will still be memory-mapped and its contents
+		 * accessible from user-space through BPF skeleton.
+		 */
+		if (!sec) {
+			printf("	struct %s__%s {\n", obj_name, map_ident);
+			printf("	} *%s;\n", map_ident);
+		} else {
+			err = codegen_datasec_def(obj, btf, d, sec, obj_name);
+			if (err)
+				goto out;
+		}
 	}
+
+
 out:
 	btf_dump__free(d);
 	return err;
-- 
2.30.2

