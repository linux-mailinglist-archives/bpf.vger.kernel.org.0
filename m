Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B86D5461
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjDCWDE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 18:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjDCWDD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 18:03:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2551BF3;
        Mon,  3 Apr 2023 15:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA4C162D1C;
        Mon,  3 Apr 2023 22:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DBBC433D2;
        Mon,  3 Apr 2023 22:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680559381;
        bh=E+J++Ja453WekURa/wOhcsyf4PVCNOpn1MEHhpca8zk=;
        h=From:To:Cc:Subject:Date:From;
        b=RewR5IfvGqVZuwU9TjmhMmOMXhm4RivCQkRakbBeB6/eYdRd11AV9bVGBRguvh+TK
         oZRH6AmThzgzK86LkXaV9E4RldjPxBagsNOYXmurDHJkOCx0myGE9H+wNdm08VQLrP
         R/L+ko9KttNkmR5RB6a1j5flY0BhtZrY75x8X3Eq1eb1HyySe4ENu9exxBKdupIhDo
         qQ2fupFjrjCZilZ539sSQeVheDdOWFak0+qFHnZborD15tw7+krhtPbK1q17detcOm
         XCqcE5MpeYrnTBYXWbmn7pAUKfnOeCQpnz2eUJZPZjezm0Lv6HvSvW1oFOX5lEJkSc
         N//V/7Dl0YtZQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Artem Savkov <asavkov@redhat.com>, bpf@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Petr Mladek <pmladek@suse.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next] kallsyms: Disable preemption for find_kallsyms_symbol_value
Date:   Tue,  4 Apr 2023 00:02:54 +0200
Message-Id: <20230403220254.2191240-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Artem reported suspicious RCU usage [1]. The reason is that verifier
calls find_kallsyms_symbol_value with preemption enabled which will
trigger suspicious RCU usage warning in rcu_dereference_sched call.

Disabling preemption in find_kallsyms_symbol_value and adding
__find_kallsyms_symbol_value function.

Fixes: 31bf1dbccfb0 ("bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules")
[1] https://lore.kernel.org/bpf/ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com/
Reported-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/module/kallsyms.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index ab2376a1be88..bdc911dbcde5 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -442,7 +442,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 }
 
 /* Given a module and name of symbol, find and return the symbol's value */
-unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
+static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
 {
 	unsigned int i;
 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
@@ -466,7 +466,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
 	if (colon) {
 		mod = find_module_all(name, colon - name, false);
 		if (mod)
-			return find_kallsyms_symbol_value(mod, colon + 1);
+			return __find_kallsyms_symbol_value(mod, colon + 1);
 		return 0;
 	}
 
@@ -475,7 +475,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
 
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
-		ret = find_kallsyms_symbol_value(mod, name);
+		ret = __find_kallsyms_symbol_value(mod, name);
 		if (ret)
 			return ret;
 	}
@@ -494,6 +494,16 @@ unsigned long module_kallsyms_lookup_name(const char *name)
 	return ret;
 }
 
+unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
+{
+	unsigned long ret;
+
+	preempt_disable();
+	ret = __find_kallsyms_symbol_value(mod, name);
+	preempt_enable();
+	return ret;
+}
+
 int module_kallsyms_on_each_symbol(const char *modname,
 				   int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
-- 
2.39.2

