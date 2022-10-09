Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28355F8F06
	for <lists+bpf@lfdr.de>; Sun,  9 Oct 2022 23:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJIV7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 17:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJIV7s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 17:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C447645C
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 14:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD4AA60C92
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 21:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B4AC433C1;
        Sun,  9 Oct 2022 21:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665352785;
        bh=O+QRCtwux+rfk7Dd0kNs5Cm18D0ny2Hnwweu1eiuMEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahE7A5AWFOGuq9eHE2MDW+8oG3t8odam4y4UXJIocGc7yl+j4ETlBwfmz+kAqEsxF
         8FxQMFbJAi0c53oA4S/E1AqoZToLccJhzbmObLyMwkIk2VXw+V6u8WUSs2L3DTND/C
         6A5Hi/ne0Zu1LEKGlv3NZuvE8NmJU1YvLlsUTagdg5yztM81B7mf/9wbItEBbM7HMb
         ymG0FAnQvN5xqIvQQy6+yzbMIhjYtXfjMe7Umvge17p29YoUSZ3yr/kHGGxtHVXSh5
         CzT59inM9agetHAl0OUxqNwNooxFA81m7PViGX0U3MjijhwLAynsIV+8xeN88oB6GG
         ZYFl0+6Z4pVHw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf-next 1/8] kallsyms: Make module_kallsyms_on_each_symbol generally available
Date:   Sun,  9 Oct 2022 23:59:19 +0200
Message-Id: <20221009215926.970164-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009215926.970164-1-jolsa@kernel.org>
References: <20221009215926.970164-1-jolsa@kernel.org>
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

Making module_kallsyms_on_each_symbol generally available, so it
can be used outside CONFIG_LIVEPATCH option in following changes.

Rather than adding another ifdef option let's make the function
generally available (when CONFIG_KALLSYMS and CONFIG_MODULES
options are defined).

Cc: Christoph Hellwig <hch@lst.de>
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

