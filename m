Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A20B3676F5
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 03:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhDVBqt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 21 Apr 2021 21:46:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9572 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233909AbhDVBqr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Apr 2021 21:46:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13M1igq4002556
        for <bpf@vger.kernel.org>; Wed, 21 Apr 2021 18:46:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 382dq9xh7w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 21 Apr 2021 18:46:13 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 18:46:11 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id BE80E2ED59F8; Wed, 21 Apr 2021 18:46:04 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/6] libbpf: support static map definitions
Date:   Wed, 21 Apr 2021 18:45:53 -0700
Message-ID: <20210422014556.3451936-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422014556.3451936-1-andrii@kernel.org>
References: <20210422014556.3451936-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pnsUOlxK1AgUe2dsAshSoNfrx3eDakFq
X-Proofpoint-ORIG-GUID: pnsUOlxK1AgUe2dsAshSoNfrx3eDakFq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_08:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=994 impostorscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1034 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220014
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change libbpf relocation logic to support references to static map
definitions. This allows to use static maps and, combined with static linking,
hide internal maps from other files, just like static variables. User-space
will still be able to look up and modify static maps.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 82b1946a0802..a7c3bcb8e5ea 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3632,6 +3632,8 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 
 	/* generic map reference relocation */
 	if (type == LIBBPF_MAP_UNSPEC) {
+		size_t map_offset = sym->st_value + insn->imm;
+
 		if (!bpf_object__shndx_is_maps(obj, shdr_idx)) {
 			pr_warn("prog '%s': bad map relo against '%s' in section '%s'\n",
 				prog->name, sym_name, sym_sec_name);
@@ -3641,7 +3643,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 			map = &obj->maps[map_idx];
 			if (map->libbpf_type != type ||
 			    map->sec_idx != sym->st_shndx ||
-			    map->sec_offset != sym->st_value)
+			    map->sec_offset != map_offset)
 				continue;
 			pr_debug("prog '%s': found map %zd (%s, sec %d, off %zu) for insn #%u\n",
 				 prog->name, map_idx, map->name, map->sec_idx,
@@ -3656,7 +3658,8 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		reloc_desc->type = RELO_LD64;
 		reloc_desc->insn_idx = insn_idx;
 		reloc_desc->map_idx = map_idx;
-		reloc_desc->sym_off = 0; /* sym->st_value determines map_idx */
+		/* sym->st_value + insn->imm determines map_idx */
+		reloc_desc->sym_off = 0;
 		return 0;
 	}
 
-- 
2.30.2

