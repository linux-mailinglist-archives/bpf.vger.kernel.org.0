Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48413523CB
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 01:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhDAXdI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 19:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhDAXct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 19:32:49 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B7BC0613B6
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 16:32:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 11so4048260qtz.7
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0OJOU674SN3xj3Lqx/JMDarKdo+EQxjvu4sbPIpjGbQ=;
        b=jfBjjOuhFQTA8f0FqdSPYiaPzg1wyJdsu6rf+AEn6rGrWZOfwwq0Djf3chNSnS7Al1
         CYoBougyMan9Q08AOWoPl+s2ObadC2VNY7e52LxhTDGKJdF7lroHx6pH7gxtIWp3HLbo
         9D30HxzSUs8Xy14f8/0PCXhSEvko8qmbcGGWpoZRB7qS3xzFxGKW3IdbZ7PV1kmwzrwc
         72AVCWZub5vFlEh8Hr14vs7E5uDHu9GA2/ITxlceHp/an8qRZVOhGwa+W54iVp2eqvXk
         yDR4D1GPb5PqQ+eyxfXteqoCwLXnMIvkCatin6cOA5lOHl6HWuHuhE52jIwyK2l9B+Rv
         cl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0OJOU674SN3xj3Lqx/JMDarKdo+EQxjvu4sbPIpjGbQ=;
        b=W1NDePPcaEdg2jTGeDcNFnuFN4baY3dV1QYSg92t8rGVkeBuW1GdlmHdEeX4AV6NPe
         uiRzA1dIt8XX4C6Ng7tiHaDBSZ5KqD4eP4mRw58cI/wgcxW0v/ZjyOkxQT9thedKldh8
         eRaPPkzL6VtUK2rxhHBJtEA3GqYdZHg3NPmeuIA52+8Di1jStWTJKsvFwde2q+A90sv4
         8JyFx9C9O4mGpYkOTt6AF+uxMaVxSVPiJZJkiu1HRHXSAcDqMlhjU63l6u95M8H+KT80
         v58bOpeLS9Zwf6py5JNDEDAYvhUrM866iWYV1gi6FNNAqTni6ZZPfj9NwFKMtHKP2sIZ
         5dEw==
X-Gm-Message-State: AOAM5337sG4bKd04FD4uHz86OSgh3afFfKovSq84uG056wNkh5jXzjQ2
        hCiSlkw8wkjHQCJ9cwvTBb9H2ev3eizZf++KS1c=
X-Google-Smtp-Source: ABdhPJw2V6BkGIRoC1gSesYQ2ERf1COdk3WosLQHl6cpLgtczKxwCftqsIjTMxTCEer8OTHmjcXvC7GTYXG2o7/8hn0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:bec3:: with SMTP id
 f3mr10582224qvj.49.1617319952913; Thu, 01 Apr 2021 16:32:32 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:05 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 07/18] kallsyms: strip ThinLTO hashes from static functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
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
 kernel/kallsyms.c | 55 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 8043a90aa50e..c851ca0ed357 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -161,6 +161,27 @@ static unsigned long kallsyms_sym_address(int idx)
 	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }
 
+#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
+/*
+ * LLVM appends a hash to static function names when ThinLTO and CFI are
+ * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
+ * This causes confusion and potentially breaks user space tools, so we
+ * strip the suffix from expanded symbol names.
+ */
+static inline bool cleanup_symbol_name(char *s)
+{
+	char *res;
+
+	res = strrchr(s, '$');
+	if (res)
+		*res = '\0';
+
+	return res != NULL;
+}
+#else
+static inline bool cleanup_symbol_name(char *s) { return false; }
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -173,6 +194,9 @@ unsigned long kallsyms_lookup_name(const char *name)
 
 		if (strcmp(namebuf, name) == 0)
 			return kallsyms_sym_address(i);
+
+		if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
+			return kallsyms_sym_address(i);
 	}
 	return module_kallsyms_lookup_name(name);
 }
@@ -303,7 +327,9 @@ const char *kallsyms_lookup(unsigned long addr,
 				       namebuf, KSYM_NAME_LEN);
 		if (modname)
 			*modname = NULL;
-		return namebuf;
+
+		ret = namebuf;
+		goto found;
 	}
 
 	/* See if it's in a module or a BPF JITed image. */
@@ -316,11 +342,16 @@ const char *kallsyms_lookup(unsigned long addr,
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
 
@@ -331,15 +362,23 @@ int lookup_symbol_name(unsigned long addr, char *symname)
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
 
@@ -351,10 +390,16 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
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
2.31.0.208.g409f899ff0-goog

