Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08994F9C4E
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiDHSQr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Apr 2022 14:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiDHSQq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 14:16:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02DF13F2E
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 11:14:42 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 238GqqC3022002
        for <bpf@vger.kernel.org>; Fri, 8 Apr 2022 11:14:42 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fad7yvyt1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 11:14:36 -0700
Received: from twshared27284.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 11:14:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DDA9216F8734C; Fri,  8 Apr 2022 11:14:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/3] libbpf: don't error out on CO-RE relos for overriden weak subprogs
Date:   Fri, 8 Apr 2022 11:14:23 -0700
Message-ID: <20220408181425.2287230-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408181425.2287230-1-andrii@kernel.org>
References: <20220408181425.2287230-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ABlcz39Y9Q077BqA-vvqwJhZVkrmSnMd
X-Proofpoint-GUID: ABlcz39Y9Q077BqA-vvqwJhZVkrmSnMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During BPF static linking, all the ELF relocations and .BTF.ext
information (including CO-RE relocations) are preserved for __weak
subprograms that were logically overriden by either previous weak
subprogram instance or by corresponding "strong" (non-weak) subprogram.
This is just how native user-space linkers work, nothing new.

But libbpf is over-zealous when processing CO-RE relocation to error out
when CO-RE relocation belonging to such eliminated weak subprogram is
encountered. Instead of erroring out on this expected situation, log
debug-level message and skip the relocation.

Fixes: db2b8b06423c ("libbpf: Support CO-RE relocations for multi-prog sections")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9deb1fc67f19..465b7c0996f1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5687,10 +5687,17 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			insn_idx = rec->insn_off / BPF_INSN_SZ;
 			prog = find_prog_by_sec_insn(obj, sec_idx, insn_idx);
 			if (!prog) {
-				pr_warn("sec '%s': failed to find program at insn #%d for CO-RE offset relocation #%d\n",
-					sec_name, insn_idx, i);
-				err = -EINVAL;
-				goto out;
+				/* When __weak subprog is "overridden" by another instance
+				 * of the subprog from a different object file, linker still
+				 * appends all the .BTF.ext info that used to belong to that
+				 * eliminated subprogram.
+				 * This is similar to what x86-64 linker does for relocations.
+				 * So just ignore such relocations just like we ignore
+				 * subprog instructions when discovering subprograms.
+				 */
+				pr_debug("sec '%s': skipping CO-RE relocation #%d for insn #%d belonging to eliminated weak subprogram\n",
+					 sec_name, i, insn_idx);
+				continue;
 			}
 			/* no need to apply CO-RE relocation if the program is
 			 * not going to be loaded
-- 
2.30.2

