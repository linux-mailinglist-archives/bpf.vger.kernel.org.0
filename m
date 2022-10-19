Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DC46048EA
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiJSOQa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 10:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiJSOQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 10:16:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD11CE3ED
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 06:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1F0FB822CE
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 13:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B90C433C1;
        Wed, 19 Oct 2022 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666187811;
        bh=ckVkdGEwuo+uocub2igAcV430UhqmBM22t//R6dPL94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ha467mgXymTlxsPdZbcnstEgFFDYtKDJtCzoGTzw0s06C2haoHc9lDSOmE7tx0LEb
         s/9ql1WBBk+qwYv+oyQ+zWgWOJfH1Tgyb1lUivabVRxH3CrA0srUvIFceBDaI/mtMS
         WLqgbtWBpzzIJoLLZPXQ/Xjwv8OFPX2TStziMA0QYOjzP1Uwyqtav2KzHaALX66+wB
         WfjS4Hk+5hhD6qTEuhxcwKpukOHUS7ZaWrn39iPni2c7v3ckWSFuWKbS4nsuQQkYQJ
         aqoX0p5oA0t+wVegCyPZvKICkXT2fQONAn4cjMFxBkZEZ1HC5diG7ptDu+/IgLRdWu
         ZRQi4YYaPnqEQ==
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
Subject: [PATCHv2 bpf-next 2/8] ftrace: Add support to resolve module symbols in ftrace_lookup_symbols
Date:   Wed, 19 Oct 2022 15:56:15 +0200
Message-Id: <20221019135621.1480923-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019135621.1480923-1-jolsa@kernel.org>
References: <20221019135621.1480923-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

