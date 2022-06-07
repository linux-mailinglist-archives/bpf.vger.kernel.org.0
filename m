Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AFB53F60D
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 08:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiFGG0U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 02:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiFGG0T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 02:26:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89036D0281
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 23:26:18 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25751Vq5021154
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 23:26:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dtUFLurAVpC2sjwYufq4sMNqVj3+whNProPCHEfGRkw=;
 b=ArFKeWNv48FHHD89jY7o96kSa4StIyC48JcrJsAh2SROI9v+4aFiu4DlYujTNGe9jk8z
 izkhnFQzTx8zVKPP5Y3x6ZRaUVv5XGYCKha4fvCzhzOhhzMhceKnmckVJj60uvkz/0Cg
 UyH3zx0om2NnfaE5Mnw6waH4fk+cY7uN+QY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ghy450h1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 23:26:17 -0700
Received: from twshared18317.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 23:26:17 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B569EB520F66; Mon,  6 Jun 2022 23:26:10 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next v5 03/17] libbpf: Fix an error in 64bit relocation value computation
Date:   Mon, 6 Jun 2022 23:26:10 -0700
Message-ID: <20220607062610.3717378-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607062554.3716237-1-yhs@fb.com>
References: <20220607062554.3716237-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JEa3332PycyEkp05Fe8vMacWGYu-7uwA
X-Proofpoint-GUID: JEa3332PycyEkp05Fe8vMacWGYu-7uwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_02,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the 64bit relocation value in the instruction
is computed as follows:
  __u64 imm =3D insn[0].imm + ((__u64)insn[1].imm << 32)

Suppose insn[0].imm =3D -1 (0xffffffff) and insn[1].imm =3D 1.
With the above computation, insn[0].imm will first sign-extend
to 64bit -1 (0xffffffffFFFFFFFF) and then add 0x1FFFFFFFF,
producing incorrect value 0xFFFFFFFF. The correct value
should be 0x1FFFFFFFF.

Changing insn[0].imm to __u32 first will prevent 64bit sign
extension and fix the issue. Merging high and low 32bit values
also changed from '+' to '|' to be consistent with other
similar occurences in kernel and libbpf.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/relo_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 0dce5644877b..073a54ed7432 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1027,7 +1027,7 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
 			return -EINVAL;
 		}
=20
-		imm =3D insn[0].imm + ((__u64)insn[1].imm << 32);
+		imm =3D (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
 		if (res->validate && imm !=3D orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: go=
t %llu, exp %llu -> %llu\n",
 				prog_name, relo_idx,
--=20
2.30.2

