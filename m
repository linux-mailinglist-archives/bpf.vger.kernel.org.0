Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB55B34E4
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIIKNF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIIKNE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:13:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD97174BA8
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 03:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D6C61F73
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 10:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FDFC433D6;
        Fri,  9 Sep 2022 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662718382;
        bh=oomoVeYl/NS7dXqwjk2EddpsaQRK5EqdKhgqMxNE9lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2nPYDyWrcIYONUdnuK8yNqZWPFTAUxfBHrNO9ynJyX2U8qKwK/5nIANpB17CF194
         Mo80d6yOuYEcyuxfeCZ6ywhdY+T8bcUGHpNYGIk50pauYDAizqc/wynaX1ryySeQi/
         ocwXWM7OiASe7R1WaE0yGna02sE48GNoRMN3Swzua5ZGTYENO5Z4OAO/XuNDUIjd8A
         MelZI4Did8EzwGhVxAex7z50MlK5VabeT+4svt/GN234/s/7DIKcZ+7NJVqyQUgwSd
         YMv2JB/YVPqY1nvu3xBI/GPDtLfXOeRRS7VYqeFiFZFHLDL8+ug6EXJy7OvwIfgnAW
         ATniyzAVCPlEQ==
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
Subject: [PATCHv3 bpf-next 1/6] kprobes: Add new KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
Date:   Fri,  9 Sep 2022 12:12:40 +0200
Message-Id: <20220909101245.347173-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909101245.347173-1-jolsa@kernel.org>
References: <20220909101245.347173-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

