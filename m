Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8626F5D08
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 19:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjECRY6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjECRY5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 13:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C67A92
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 10:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D4262F03
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 17:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0661C433D2;
        Wed,  3 May 2023 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683134686;
        bh=QX7xjPHHa2LxCd2sAyvNEoM+g/5OJ1lFZfmHLXTBrNA=;
        h=From:To:Cc:Subject:Date:From;
        b=fWu+Y7lRb6K5YROupzyvEv9wRgv1wflHJXy+8Bg0pkhgRodll1W/dt5GhxTEtlNrs
         ZH2dQ3qF77ebEbikWw4awl9zrK4HnLcHPBtsckueKtbEOcfnGRismACiQUOVR+uJmv
         BWR3aS5nyewHQz1r18dOAriXdIkOqlkW5o7xOyVh7VOwsVgQjs8xV4ApEAA0QFjGhW
         CIkopPiU4Pwpy04cuUFzS0tqL8TGmx3Tj64aAj5m7oLvTytX2FHIK9gG0l8CHnn8x8
         Rw9jjGxMr6xwTFxbkLOEqxZecIic1WyKqkggYCyYlDANjv3Rl94fvu+6D5aZIhd+zA
         pGHY7pgXI1HnQ==
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
Subject: [RFC/PATCH] libbpf: Store zero fd to fd_array for loader kfunc relocation
Date:   Wed,  3 May 2023 19:24:41 +0200
Message-Id: <20230503172441.2138444-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When moving some of the test kfuncs to bpf_testmod I hit an issue
when some of the object's kfuncs are in module and some in vmlinux.

The problem is that both vmlinux and module kfuncs get btf_fd_idx
index into fd_array, but we store to it the BTF fd value only for
module's kfunc.

Then after the program is loaded we check if fd_array[btf_fd_idx] != 0
and close the fd.

When the object has kfuncs from both vmlinux and module, the fd from
fd_array[btf_fd_idx] from previous load will be there for vmlinux kfunc
and we close unrelated fd (of the program we just loaded in my case).

Not sure if there's easier way to clear the fd_array between the
loads, but the change below seems to fix the issue for me.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/gen_loader.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 83e8e3bfd8ff..e247f62aed49 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -703,17 +703,17 @@ static void emit_relo_kfunc_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo
 	/* obtain fd in BPF_REG_9 */
 	emit(gen, BPF_MOV64_REG(BPF_REG_9, BPF_REG_7));
 	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_9, 32));
-	/* jump to fd_array store if fd denotes module BTF */
-	emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0, 2));
-	/* set the default value for off */
-	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
-	/* skip BTF fd store for vmlinux BTF */
-	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 4));
 	/* load fd_array slot pointer */
 	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
 					 0, 0, 0, blob_fd_array_off(gen, btf_fd_idx)));
 	/* store BTF fd in slot */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_9, 0));
+	/* jump to insn[insn_idx].off store if fd denotes module BTF */
+	emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0, 2));
+	/* set the default value for off */
+	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
+	/* skip BTF fd store for vmlinux BTF */
+	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
 	/* store index into insn[insn_idx].off */
 	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), btf_fd_idx));
 log:
-- 
2.40.1

