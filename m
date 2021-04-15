Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9D360BAE
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhDOOSn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhDOOSn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 10:18:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7787DC061574
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 07:18:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j32so2231289pgm.6
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xmoFfH95KqIzSfvJOukFbl18IziLSL8YgoFoiqluIZQ=;
        b=YzFCXwhnAW7rTvuCgkLqKxCkKpP21klIdaGOUUbwuHD3GdCfowL/TBPq5U2AA707Hx
         yPRaE9RkO4HC9bK3lwjvDDM5MdD6CbeUH2LqE7cQzUBXd/XUJqFtILtZ3DPwMPzFkr4G
         V23qrypGtjDdjS9ROirlyoMXi+vy+n1VEZYq8o3/DHAmI29xx8Dr99N6mLW1SZbM6T/x
         51o8n37vhQLbfcMGUUZgCNATooP2C29DvReUyxaq80GbZ52EkklZ3/hWT2hfOQBHMypI
         1087o1dBOewiIQ034OP9pTMZL8tRsy8DZPlw50aC8MFwreCnE9CSYzKn9dCFSYPoocH1
         exRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xmoFfH95KqIzSfvJOukFbl18IziLSL8YgoFoiqluIZQ=;
        b=Ju47WGr6doVqYYPR3vz8dc8fvg6qzfO3xEewVLhXAmwcQoasM2OO92JlJTDhSu+Vdi
         YSFIINGXNeYqBgM+4uqtqO9jqqR/9Nc4oK4WYJXz9hdFPDCiQ+LWMTLM+rQSp3r9YFb4
         U9rOZIw/hjJBAf58RK+MbKWnSGfYiIw9T/BNZOYmkmDybhmwvt+s2Vdim3c9TuR5sGT1
         WmTkjace7oehYV5ePvg9eAsXpLVfVTFJlBJzftUit8DoFZC99wT21XtHUT+PN6RmXRvF
         FX9sROiV7X0VDNzrebO/LSMRptvRznTtNAke4z2Jx9mRvEzkyPlk51BZhfQpuvyhorhP
         RKcQ==
X-Gm-Message-State: AOAM531vUonsTfEHti/MbZqR047ksj3uJUmEmLOJF3MbMWeRIFYaE3Aq
        r/C5s6qa+uCI6t1Nqpzdtus=
X-Google-Smtp-Source: ABdhPJzKF/0D5egI7+DWoEEVZCan3+u+Uig8/uo67SdLb9T26xzwSbI5u/fYaPV9oJFNPmnldUV94A==
X-Received: by 2002:aa7:92cb:0:b029:1f1:542f:2b2b with SMTP id k11-20020aa792cb0000b02901f1542f2b2bmr3309041pfa.31.1618496299916;
        Thu, 15 Apr 2021 07:18:19 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id mz18sm2762571pjb.13.2021.04.15.07.18.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 07:18:19 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next] libbpf: Remove unused field.
Date:   Thu, 15 Apr 2021 07:18:17 -0700
Message-Id: <20210415141817.53136-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

relo->processed is set, but not used. Remove it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ed5586cce227..9cc2d45b0080 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -195,7 +195,6 @@ struct reloc_desc {
 	int insn_idx;
 	int map_idx;
 	int sym_off;
-	bool processed;
 };
 
 struct bpf_sec_def;
@@ -3499,8 +3498,6 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 	const char *sym_sec_name;
 	struct bpf_map *map;
 
-	reloc_desc->processed = false;
-
 	if (!is_call_insn(insn) && !is_ldimm64_insn(insn)) {
 		pr_warn("prog '%s': invalid relo against '%s' for insns[%d].code 0x%x\n",
 			prog->name, sym_name, insn_idx, insn->code);
@@ -6314,13 +6311,11 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_LD64:
 			insn[0].src_reg = BPF_PSEUDO_MAP_FD;
 			insn[0].imm = obj->maps[relo->map_idx].fd;
-			relo->processed = true;
 			break;
 		case RELO_DATA:
 			insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
 			insn[1].imm = insn[0].imm + relo->sym_off;
 			insn[0].imm = obj->maps[relo->map_idx].fd;
-			relo->processed = true;
 			break;
 		case RELO_EXTERN_VAR:
 			ext = &obj->externs[relo->sym_off];
@@ -6338,13 +6333,11 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 					insn[1].imm = ext->ksym.addr >> 32;
 				}
 			}
-			relo->processed = true;
 			break;
 		case RELO_EXTERN_FUNC:
 			ext = &obj->externs[relo->sym_off];
 			insn[0].src_reg = BPF_PSEUDO_KFUNC_CALL;
 			insn[0].imm = ext->ksym.kernel_btf_id;
-			relo->processed = true;
 			break;
 		case RELO_SUBPROG_ADDR:
 			insn[0].src_reg = BPF_PSEUDO_FUNC;
@@ -6630,9 +6623,6 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 		 * different main programs */
 		insn->imm = subprog->sub_insn_off - (prog->sub_insn_off + insn_idx) - 1;
 
-		if (relo)
-			relo->processed = true;
-
 		pr_debug("prog '%s': insn #%zu relocated, imm %d points to subprog '%s' (now at %zu offset)\n",
 			 prog->name, insn_idx, insn->imm, subprog->name, subprog->sub_insn_off);
 	}
@@ -6725,7 +6715,7 @@ static int
 bpf_object__relocate_calls(struct bpf_object *obj, struct bpf_program *prog)
 {
 	struct bpf_program *subprog;
-	int i, j, err;
+	int i, err;
 
 	/* mark all subprogs as not relocated (yet) within the context of
 	 * current main program
@@ -6736,9 +6726,6 @@ bpf_object__relocate_calls(struct bpf_object *obj, struct bpf_program *prog)
 			continue;
 
 		subprog->sub_insn_off = 0;
-		for (j = 0; j < subprog->nr_reloc; j++)
-			if (subprog->reloc_desc[j].type == RELO_CALL)
-				subprog->reloc_desc[j].processed = false;
 	}
 
 	err = bpf_object__reloc_code(obj, prog, prog);
-- 
2.30.2

