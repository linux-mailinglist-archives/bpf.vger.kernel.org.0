Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE444F8B62
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 02:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiDGXG6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 7 Apr 2022 19:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiDGXG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 19:06:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2E0527EE
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 16:04:56 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 237M0MLu016606
        for <bpf@vger.kernel.org>; Thu, 7 Apr 2022 16:04:56 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3f9gc3adh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 16:04:55 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 16:04:54 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8A68B16D7B0DE; Thu,  7 Apr 2022 16:04:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 2/2] libbpf: allow WEAK and GLOBAL bindings during BTF fixup
Date:   Thu, 7 Apr 2022 16:04:46 -0700
Message-ID: <20220407230446.3980075-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407230446.3980075-1-andrii@kernel.org>
References: <20220407230446.3980075-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2pdX-m83wQql3nlgUePkCVfNs22b1qlA
X-Proofpoint-ORIG-GUID: 2pdX-m83wQql3nlgUePkCVfNs22b1qlA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_05,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During BTF fix up for global variables, global variable can be global
weak and will have STB_WEAK binding in ELF. Support such global
variables in addition to non-weak ones.

This is not the problem when using BPF static linking, as BPF static
linker "fixes up" BTF during generation so that libbpf doesn't have to
do it anymore during bpf_object__open(), which led to this not being
noticed for a while, along with a pretty rare (currently) use of __weak
variables and maps.

Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 016ecdd1c3e1..9deb1fc67f19 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1401,8 +1401,11 @@ static int find_elf_var_offset(const struct bpf_object *obj, const char *name, _
 	for (si = 0; si < symbols->d_size / sizeof(Elf64_Sym); si++) {
 		Elf64_Sym *sym = elf_sym_by_idx(obj, si);
 
-		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL ||
-		    ELF64_ST_TYPE(sym->st_info) != STT_OBJECT)
+		if (ELF64_ST_TYPE(sym->st_info) != STT_OBJECT)
+			continue;
+
+		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
+		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
 			continue;
 
 		sname = elf_sym_str(obj, sym->st_name);
-- 
2.30.2

