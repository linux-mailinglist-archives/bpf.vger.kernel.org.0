Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A163A97D
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 14:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiK1N3s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 08:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiK1N3m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 08:29:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48221E71B
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 05:29:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 721086118B
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 13:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85897C433D6;
        Mon, 28 Nov 2022 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669642175;
        bh=lZxgGIMKMvWS4LyMmZK4AU57Wo5AFEvJB1CFziAjeBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnBf3hM7rqnWbME0aTP3R5EjG0BbHrIeG22JZFxiBZzGiqVqQwJut0q/yPlAq3e1/
         01MJoHe4ka9rZFfzawLMHdq3WUJh3nPBBdEGXd/+4QSnfqgquIsRPBoL5qgyrw3vVF
         xFVarH131x6vMTH5XYdMo6as7DmGOBXqCLQobnCAtZ5HEEgtJsBJ78Aa/g4CP243H9
         QXA/7kZcBTsZFgETfYLiUvHwTTbqVa1mWMoO1i6Wwg/txqzFw/Nw/9nZXlja9FGXJM
         bwLCB9kV4z6sPUS84WbvMYIi9k2GmEOhMrJi/EyWtm5WSkcxv45gs5ODe2dRd3s2ot
         xOlVa8vMiReMg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 1/4] bpf: Mark vma objects as trusted for task_vma iter and find_vma callback
Date:   Mon, 28 Nov 2022 14:29:12 +0100
Message-Id: <20221128132915.141211-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128132915.141211-1-jolsa@kernel.org>
References: <20221128132915.141211-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Marking following vma objects as trusted so they can be used
as arguments for kfunc function added in following changes:

  - vma object argument in find_vma callback function
  - vma object in context of task_vma iterator program

Both places lock vma object so it can't go away while running
the bpf program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/task_iter.c | 2 +-
 kernel/bpf/verifier.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c2a2182ce570..cd67b3cadd91 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -755,7 +755,7 @@ static struct bpf_iter_reg task_vma_reg_info = {
 		{ offsetof(struct bpf_iter__task_vma, task),
 		  PTR_TO_BTF_ID_OR_NULL },
 		{ offsetof(struct bpf_iter__task_vma, vma),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
 	},
 	.seq_info		= &task_vma_seq_info,
 	.fill_link_info		= bpf_iter_fill_link_info,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6599d25dae38..2f04cab023be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7206,7 +7206,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 	 */
 	callee->regs[BPF_REG_1] = caller->regs[BPF_REG_1];
 
-	callee->regs[BPF_REG_2].type = PTR_TO_BTF_ID;
+	callee->regs[BPF_REG_2].type = PTR_TO_BTF_ID | PTR_TRUSTED;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
 	callee->regs[BPF_REG_2].btf =  btf_vmlinux;
 	callee->regs[BPF_REG_2].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_VMA],
-- 
2.38.1

