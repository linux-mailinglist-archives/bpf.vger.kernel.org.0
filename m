Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59E60CDBF
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 15:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJYNmS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 09:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJYNmR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 09:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4847183D83
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 06:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66F1761962
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 13:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F75C433D6;
        Tue, 25 Oct 2022 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666705335;
        bh=ckVkdGEwuo+uocub2igAcV430UhqmBM22t//R6dPL94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCc6EseWxOGDdi0etZ6ze+69pFNcvUXp8x2gKbXRof4kcUEdifmYg6DLZJnM4SQJ1
         rN/4W4huJlOYSM5XmUDgH9Z0aCRxQSS13a3r0UlvG8ti9WTErs36a4wcJzTa5JwnYN
         EG33kr/u3jySjEUawN+JanO2wLbS1vybn4gcyqeSKJRL/2bY6k6rbRV+4xgyJmwnKn
         jNo9XLWHTzp2MysiwVPOHIaSLuXpKv4rHdQbb2wNY0twjHnnjBXspcgR0zkhvrKtHt
         +6CNJ+4KyheEDFeNZOP0UbgqoAexMR1chFptCWWG0ME0lteh+a49SpOGl90wMGBSdk
         CJLzcIMxWZ2yw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martynas Pumputis <m@lambda.lt>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv3 bpf-next 2/8] ftrace: Add support to resolve module symbols in ftrace_lookup_symbols
Date:   Tue, 25 Oct 2022 15:41:42 +0200
Message-Id: <20221025134148.3300700-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025134148.3300700-1-jolsa@kernel.org>
References: <20221025134148.3300700-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently ftrace_lookup_symbols iterates only over core symbols,
adding module_kallsyms_on_each_symbol call to check on modules
symbols as well.

Also removing 'args.found == args.cnt' condition, because it's
already checked in kallsyms_callback function.

Also removing 'err < 0' check, because both *kallsyms_on_each_symbol
functions do not return error.

Reported-by: Martynas Pumputis <m@lambda.lt>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fbf2543111c0..72de9009a6a0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8267,6 +8267,10 @@ struct kallsyms_data {
 	size_t found;
 };
 
+/* This function gets called for all kernel and module symbols
+ * and returns 1 in case we resolved all the requested symbols,
+ * 0 otherwise.
+ */
 static int kallsyms_callback(void *data, const char *name,
 			     struct module *mod, unsigned long addr)
 {
@@ -8309,17 +8313,19 @@ static int kallsyms_callback(void *data, const char *name,
 int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
 {
 	struct kallsyms_data args;
-	int err;
+	int found_all;
 
 	memset(addrs, 0, sizeof(*addrs) * cnt);
 	args.addrs = addrs;
 	args.syms = sorted_syms;
 	args.cnt = cnt;
 	args.found = 0;
-	err = kallsyms_on_each_symbol(kallsyms_callback, &args);
-	if (err < 0)
-		return err;
-	return args.found == args.cnt ? 0 : -ESRCH;
+
+	found_all = kallsyms_on_each_symbol(kallsyms_callback, &args);
+	if (found_all)
+		return 0;
+	found_all = module_kallsyms_on_each_symbol(kallsyms_callback, &args);
+	return found_all ? 0 : -ESRCH;
 }
 
 #ifdef CONFIG_SYSCTL
-- 
2.37.3

