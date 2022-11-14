Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A96627CBC
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 12:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiKNLq3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 06:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbiKNLpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 06:45:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793FF22B3A;
        Mon, 14 Nov 2022 03:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5ACC6106E;
        Mon, 14 Nov 2022 11:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9126C433D7;
        Mon, 14 Nov 2022 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426295;
        bh=OSbGEYnUhjKa2m71ScF7KvfTEC1ATHNDn1CpUx6Hw/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJ8z/7CedpLvc+/MF3CZmnF65KarkQtOfm1yX5IFr/LmkkXS8OyiGK5D6LzuK4Mwa
         XoMpS5SsUhiHN8EntCQVS0aMN3JXNLtGIGn9JmXD9vi5XxwcfKeGIiS4xH7MxNI8t6
         vH7kjHjE20tVD8aibkNSy3K52KyjWCH1iFbLzFn+bajePCfLOF8m0ZCazRzy7geM3l
         IVhKr+7koeeO6NdvAEFD6DO/3P47xTvTqcxey6Tldepdy+3IUwRzfAoFgp+p+ZpuSn
         FXWWZL6zaWeuMoxWy0bf01evM34QctoIH3I0saRBNn4hX3uT+AVmaq7no+BRMbr/1H
         tJh/RQSG7pzBA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 24/46] bpf, lto: mark interpreter jump table as __noreorder
Date:   Mon, 14 Nov 2022 12:43:22 +0100
Message-Id: <20221114114344.18650-25-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

gcc LTO has a problem that can cause static variables containing &&
labels to be put into a different LTO partition and then fail the build.
This can happen with the jump table in the BPF interprer.

Mark the interpreter function and the jump table as __noreorder, this
guarantees they both end up in the first partition.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 25a54e04560e..d40ce00622f6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1640,7 +1640,7 @@ u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
  *
  * Return: whatever value is in %BPF_R0 at program exit
  */
-static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
+static u64 __noreorder ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 {
 #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
 #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
-- 
2.38.1

