Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0538158F9D4
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 11:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiHKJPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 05:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiHKJPr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 05:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B1F2F675
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 02:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51F31615C3
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 09:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79149C433C1;
        Thu, 11 Aug 2022 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660209345;
        bh=be1aKwDzQbVN1bGlLIykUjeGOVF3AW7KX5vh7AD6858=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxqObgFvVMMC/ibhxQYGZl/8HnLe3+iQAQW5CIX5AEBaLYaX7SGc+4Vklwqdn2nox
         omF1yvI6pPWMfd5YnEkEGlMeiTAE35GPxeRecAj+4DC6ASRbVmYPFMzUvrTSBxnfWz
         67LGGZ8Ic+07PLlFBPjm10yBZe/zON2+yNztYNJA0SZ4214RvMPhLR2Fij0n4ruHQG
         MDCZeeTEryN1crC87ilzAIEdVzuoMgc+NWd6lWnjO5FB/0g6rBzp/s9Wipkr+6KABl
         Xf3A/i8OgyolcOIhDbGZ8FDFscGsyQTS8bpvKK7xPaz78hGh7qjUyzb9d5BY0Xiq1M
         3tCPoxwYWsp6A==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 1/6] kprobes: Add new KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
Date:   Thu, 11 Aug 2022 11:15:21 +0200
Message-Id: <20220811091526.172610-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811091526.172610-1-jolsa@kernel.org>
References: <20220811091526.172610-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag to indicate that
attach address is on function entry. This is used in following
changes in get_func_ip helper to return correct function address.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/kprobes.h | 1 +
 kernel/kprobes.c        | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 55041d2f884d..a0b92be98984 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -103,6 +103,7 @@ struct kprobe {
 				   * this flag is only for optimized_kprobe.
 				   */
 #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
+#define KPROBE_FLAG_ON_FUNC_ENTRY	16 /* probe is on the function entry */
 
 /* Has this kprobe gone ? */
 static inline bool kprobe_gone(struct kprobe *p)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c088ed..a6b1b5c49d92 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1605,9 +1605,10 @@ int register_kprobe(struct kprobe *p)
 	struct kprobe *old_p;
 	struct module *probed_mod;
 	kprobe_opcode_t *addr;
+	bool on_func_entry;
 
 	/* Adjust probe address from symbol */
-	addr = kprobe_addr(p);
+	addr = _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 	p->addr = addr;
@@ -1627,6 +1628,9 @@ int register_kprobe(struct kprobe *p)
 
 	mutex_lock(&kprobe_mutex);
 
+	if (on_func_entry)
+		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
+
 	old_p = get_kprobe(p->addr);
 	if (old_p) {
 		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
-- 
2.37.1

