Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004686048E7
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiJSOQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 10:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiJSOPr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 10:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE9B193441
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 06:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C07C0618DE
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 13:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B0C433D6;
        Wed, 19 Oct 2022 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666187800;
        bh=U46pkV1bbPWWYFOdwlin4B8T0zosTNgp+rtNpOzHJHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUallH50DBgSmhiU9zU/UrZ7kAt03fCtLJwq3qT2MNm6WRd6yYMKsczrUdYXTDX35
         h+bgKf1TvuDTNIyD6VKovkKb8z/LCU5L3Su+pjyAI/5/tXfOBqbakh+B+wbBhePRW/
         mXrkXFEx+z7u7bdqUJpz2xj35yODFJC8ZYUHNiE6emi0RnGje0ALfLPjMtVKvLjtVA
         An6SASAslX+3JxoU3CoTDK2s+I13B0MNTy9dPefUStyEHuq0OpzXcHkJ6wY90tNLKR
         pNbM0V7P3GEaAFzhczsWTSQjIunU9y4r5hj3m/kIjal2NmgYpB/eJCBkV6KqqxJK4S
         vIT8pFpSQ9C6g==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCHv2 bpf-next 1/8] kallsyms: Make module_kallsyms_on_each_symbol generally available
Date:   Wed, 19 Oct 2022 15:56:14 +0200
Message-Id: <20221019135621.1480923-2-jolsa@kernel.org>
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

Making module_kallsyms_on_each_symbol generally available, so it
can be used outside CONFIG_LIVEPATCH option in following changes.

Rather than adding another ifdef option let's make the function
generally available (when CONFIG_KALLSYMS and CONFIG_MODULES
options are defined).

Cc: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/module.h   | 9 +++++++++
 kernel/module/kallsyms.c | 2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ec61fb53979a..35876e89eb93 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -879,8 +879,17 @@ static inline bool module_sig_ok(struct module *module)
 }
 #endif	/* CONFIG_MODULE_SIG */
 
+#if defined(CONFIG_MODULES) && defined(CONFIG_KALLSYMS)
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data);
+#else
+static inline int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
+						 struct module *, unsigned long),
+						 void *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index f5c5c9175333..4523f99b0358 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -494,7 +494,6 @@ unsigned long module_kallsyms_lookup_name(const char *name)
 	return ret;
 }
 
-#ifdef CONFIG_LIVEPATCH
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data)
@@ -531,4 +530,3 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 	mutex_unlock(&module_mutex);
 	return ret;
 }
-#endif /* CONFIG_LIVEPATCH */
-- 
2.37.3

