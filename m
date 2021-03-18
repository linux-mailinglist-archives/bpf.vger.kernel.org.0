Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD49340B36
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 18:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhCRRLo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhCRRLc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:32 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8B9C061760
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:31 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id g6so19302360pfo.2
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QoegLXCzdycUycxpIzR40RqHRPa9NLqqSFx528i53Ro=;
        b=SwdpuVXHhmr5I7uUVGY1EjCm8+fTTbfiNABDrVeBEVmIvbeeIDlt/UhyWnlCaKQm07
         OIVzSOKtR3TWxAAi/LnAZiHfEIOEJFpBom+cqUC5mlcbXjV+TWyDtvH30rGq0Gs390D1
         gKgHu/2HCL710YS0gubnGCYv6wl8+cDW5YmBKVr3wnbCPMiEX3L6SMXkiSg65Jb4yGk5
         6t/YyfLngnf9r/RqZQWnFpYTr8wfMnnp2xedEMcFyg73Q8MHPxOyZplkRYUZtrweMSEb
         t5YGPopzwnrFjPlk4cXa7Qj0ab6klJPgsRdMebUCuUpOilfqFPZMRnljqiv9zyy4kWwZ
         kRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QoegLXCzdycUycxpIzR40RqHRPa9NLqqSFx528i53Ro=;
        b=FKa73Kui5cwfRb7i4smMoDxAz+nIbDERM3a07mKm5PYwFuhNZ8opZFjmlY+SEySu6V
         t+KPPF+j3zXvIOf9kg7PwOuyq8LzmnWZ+X9ZV86Xbh9X6ijbS57sfRsH/cIpIHwf4Psv
         rno9otukiIkpxh9bg299oIoyrUMtnGTgY8acuaAHZin85rbf6eTmhhuN9ocqXoOZs4qr
         ylE9OxOXgilgovzJejYqpMOfhX38ngIZhenrrbL2Nm4cLRKD4X1RPJRTdyyHQV5HDo2h
         RBuQ1bISwIhoEAnRNomeyP+ExUGmU2Zl4dsxNpsOiwubOPb/HzoVHA18NgCg/8kSXhgr
         Qk4A==
X-Gm-Message-State: AOAM5323tuZjcEF4sxVhF95hrePzFREhhimDCDQtFhT6A08ctjNx85dT
        PNiVLI18Q4hlR+GRuZ8ygfJgfFY+tbogUSLwWCE=
X-Google-Smtp-Source: ABdhPJx7blCXf2gjM2TRqlPaz7K7KuIqvTaBoVDCfyrUDL1O5jt8iCqoUsRNSsWoTAT2ZRwEgLc0VblPK6SpskXxR50=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:aa7:9619:0:b029:1fa:ed79:b724 with
 SMTP id q25-20020aa796190000b02901faed79b724mr4972560pfg.38.1616087491320;
 Thu, 18 Mar 2021 10:11:31 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:01 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 07/17] kallsyms: strip ThinLTO hashes from static functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With CONFIG_CFI_CLANG and ThinLTO, Clang appends a hash to the names
of all static functions not marked __used. This can break userspace
tools that don't expect the function name to change, so strip out the
hash from the output.

Suggested-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/kallsyms.c | 54 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 8043a90aa50e..17d3a704bafa 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -161,6 +161,26 @@ static unsigned long kallsyms_sym_address(int idx)
 	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }
 
+#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
+/*
+ * LLVM appends a hash to static function names when ThinLTO and CFI are
+ * both enabled, which causes confusion and potentially breaks user space
+ * tools, so we will strip the postfix from expanded symbol names.
+ */
+static inline char *cleanup_symbol_name(char *s)
+{
+	char *res = NULL;
+
+	res = strrchr(s, '$');
+	if (res)
+		*res = '\0';
+
+	return res;
+}
+#else
+static inline char *cleanup_symbol_name(char *s) { return NULL; }
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -173,6 +193,9 @@ unsigned long kallsyms_lookup_name(const char *name)
 
 		if (strcmp(namebuf, name) == 0)
 			return kallsyms_sym_address(i);
+
+		if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
+			return kallsyms_sym_address(i);
 	}
 	return module_kallsyms_lookup_name(name);
 }
@@ -303,7 +326,9 @@ const char *kallsyms_lookup(unsigned long addr,
 				       namebuf, KSYM_NAME_LEN);
 		if (modname)
 			*modname = NULL;
-		return namebuf;
+
+		ret = namebuf;
+		goto found;
 	}
 
 	/* See if it's in a module or a BPF JITed image. */
@@ -316,11 +341,16 @@ const char *kallsyms_lookup(unsigned long addr,
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
 						offset, modname, namebuf);
+
+found:
+	cleanup_symbol_name(namebuf);
 	return ret;
 }
 
 int lookup_symbol_name(unsigned long addr, char *symname)
 {
+	int res;
+
 	symname[0] = '\0';
 	symname[KSYM_NAME_LEN - 1] = '\0';
 
@@ -331,15 +361,23 @@ int lookup_symbol_name(unsigned long addr, char *symname)
 		/* Grab name */
 		kallsyms_expand_symbol(get_symbol_offset(pos),
 				       symname, KSYM_NAME_LEN);
-		return 0;
+		goto found;
 	}
 	/* See if it's in a module. */
-	return lookup_module_symbol_name(addr, symname);
+	res = lookup_module_symbol_name(addr, symname);
+	if (res)
+		return res;
+
+found:
+	cleanup_symbol_name(symname);
+	return 0;
 }
 
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 			unsigned long *offset, char *modname, char *name)
 {
+	int res;
+
 	name[0] = '\0';
 	name[KSYM_NAME_LEN - 1] = '\0';
 
@@ -351,10 +389,16 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 		kallsyms_expand_symbol(get_symbol_offset(pos),
 				       name, KSYM_NAME_LEN);
 		modname[0] = '\0';
-		return 0;
+		goto found;
 	}
 	/* See if it's in a module. */
-	return lookup_module_symbol_attrs(addr, size, offset, modname, name);
+	res = lookup_module_symbol_attrs(addr, size, offset, modname, name);
+	if (res)
+		return res;
+
+found:
+	cleanup_symbol_name(name);
+	return 0;
 }
 
 /* Look up a kernel symbol and return it in a text buffer. */
-- 
2.31.0.291.g576ba9dcdaf-goog

