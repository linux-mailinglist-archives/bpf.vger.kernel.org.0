Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1095EACE0
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIZQpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIZQpJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 12:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C0065D2
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 08:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 181A260F76
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 15:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82815C433C1;
        Mon, 26 Sep 2022 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664206435;
        bh=oomoVeYl/NS7dXqwjk2EddpsaQRK5EqdKhgqMxNE9lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B81BACYqq/NGJYFNVkQSE88m7aauRMe9SOv7PnmsU0+BEdK8ahd3b2WZ5mgOzo3VK
         VaZBydR3sbcJFqQKgEaqLYMyheQRKH69M5cNJj4agYq3Wsbr6tjOla9yJKZHdDNgGm
         li9pDZd0gdXbCsC2+7R8QSeMcK7oVxFaufCXIRk0w7lbYL06vD1tZjbukTHmWUf1DS
         fMjS/aTP42MKYvp2AmsmTn8DBupMW7iICNLL6L3INBLAEHxQiva44KxoP7s38M6Hc2
         PLDL2czpJBJqFhczIMzPk4xsO9OGWP0ci/XMBglk4xR/PsUoHyMEEEVowhyq5sxHyQ
         KXZPYwV49InTQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCHv5 bpf-next 1/6] kprobes: Add new KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
Date:   Mon, 26 Sep 2022 17:33:35 +0200
Message-Id: <20220926153340.1621984-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926153340.1621984-1-jolsa@kernel.org>
References: <20220926153340.1621984-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag to indicate that
attach address is on function entry. This is used in following
changes in get_func_ip helper to return correct function address.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
index 08350e35aba2..51adc3c94503 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1606,9 +1606,10 @@ int register_kprobe(struct kprobe *p)
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
@@ -1628,6 +1629,9 @@ int register_kprobe(struct kprobe *p)
 
 	mutex_lock(&kprobe_mutex);
 
+	if (on_func_entry)
+		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
+
 	old_p = get_kprobe(p->addr);
 	if (old_p) {
 		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
-- 
2.37.3

