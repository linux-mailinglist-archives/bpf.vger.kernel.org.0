Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B602E38F66E
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhEXXos convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 24 May 2021 19:44:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19512 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhEXXoC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 May 2021 19:44:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ONdnTW029243
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 16:42:33 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38qhq4ha6a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 16:42:33 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:42:32 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 303B82EDBCCE; Mon, 24 May 2021 16:42:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>,
        <bpf@vger.kernel.org>, <jolsa@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH dwarves] btf_encoder: fix and complete filtering out zero-sized per-CPU variables
Date:   Mon, 24 May 2021 16:42:22 -0700
Message-ID: <20210524234222.278676-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fofcf9qWqtyOY2MqYP8zNcY-UKvMSGdz
X-Proofpoint-GUID: fofcf9qWqtyOY2MqYP8zNcY-UKvMSGdz
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_11:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_encoder is ignoring zero-sized per-CPU ELF symbols, but the same has to be
done for DWARF variables when matching them with ELF symbols. This is due to
zero-sized DWARF variables matching unrelated (non-zero-sized) variable that
happens to be allocated at the exact same address, leading to a lot of
confusion in BTF.

See [0] for when this causes big problems.

  [0] https://lore.kernel.org/bpf/CAEf4BzZ0-sihSL-UAm21JcaCCY92CqfNxycHRZYXcoj8OYb=wA@mail.gmail.com/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 btf_encoder.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c711f124b31e..672b9943a4e2 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -538,6 +538,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 	cu__for_each_variable(cu, core_id, pos) {
 		uint32_t size, type, linkage;
 		const char *name, *dwarf_name;
+		const struct tag *tag;
 		uint64_t addr;
 		int id;
 
@@ -550,6 +551,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 		/* addr has to be recorded before we follow spec */
 		addr = var->ip.addr;
+		dwarf_name = variable__name(var, cu);
 
 		/* DWARF takes into account .data..percpu section offset
 		 * within its segment, which for vmlinux is 0, but for kernel
@@ -582,11 +584,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		 *  modules per-CPU data section has non-zero offset so all
 		 *  per-CPU symbols have non-zero values.
 		 */
-		if (var->ip.addr == 0) {
-			dwarf_name = variable__name(var, cu);
+		if (var->ip.addr == 0)
 			if (!dwarf_name || strcmp(dwarf_name, name))
 				continue;
-		}
 
 		if (var->spec)
 			var = var->spec;
@@ -600,6 +600,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 			break;
 		}
 
+		tag = cu__type(cu, var->ip.tag.type);
+		if (tag__size(tag, cu) == 0) {
+			if (btf_elf__verbose)
+				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
+			continue;
+		}
+
 		type = var->ip.tag.type + type_id_off;
 		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
 
-- 
2.30.2

