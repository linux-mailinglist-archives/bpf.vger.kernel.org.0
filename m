Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF9350949
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 23:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhCaV2Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 17:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhCaV1i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 17:27:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3B6C061765
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a19so3691908ybg.10
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i1PxfqvHNAZaUSY0Wt2J9hLbKLkB/NragVXsh/CJXkk=;
        b=CgrLOqIhy6I4HPpgcvaJ2Kf5auntmv+ua+he8hCf1xZOx39XpJXZZQKDjnLwMtvYdc
         Coi9ppbfXIt+chJQ+QAqS+uMcGf3PwWgeivSHwdv4kpzv+rr2THIbfrCVVg6whJabjHV
         2SJxgs1puZMWys7KvUR5E+GbWAG2gwUT/GVAk45+lS65j4BBiznnMwegCCuQHsgryS2u
         QzL22ZL9lFhVWUNp8q+UhG8SLH8hbhdY0GCTNzBAfacJ68xebK4pOQ0ZV2n5FHyUqPaj
         SKhOoLjlOqVTxE7XxST/QkBjkfCEkkv080ZLYXfJXOwteQgLmCab9Xy/VvS1MHxuU5DN
         Wx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i1PxfqvHNAZaUSY0Wt2J9hLbKLkB/NragVXsh/CJXkk=;
        b=A2SzXLo9sc4LN/HGdfD/v+Wwgr/tDQm/Lp4hHgHT65M1jg9fC4ysSNwiZjP54Tt5k/
         kOmB47QAsUqWEs3W/QZ8VDS9lzGXUHh0iImTdjJbyWOCa0L+UXZukMVNbp1iaDCv6xH5
         1/fd7QBpilqW1Tx78ipq8nAZRhtybQhSFKkDYOIx/JdVDSAkwUmQTdgNpG8/XmszZ6OO
         hK/eiWIRcmq/U3Y1Qr9LhpddUcjwGIucW5CLyBlozwoEWpXHA3MsuWEIRYKxkgcgl+CF
         XzzXN2fI0rTCUUifpA0WIAX7Em1VC5T7MxoBx1tCZN1QWYhpdihX2qU5QoS2QvR/lAZV
         L2Iw==
X-Gm-Message-State: AOAM533fzR/7yXKsdsv+C6/xuAIfygOQANoGCIuNJw7Mwy28nQQa8Y42
        wv+tia1hb9Xcki+O3jBhNBUEa/uF7AB9/uOqiyo=
X-Google-Smtp-Source: ABdhPJwLdAoVrfnuDHDuevSolHBmZu5plw9zwt9KPh0wtZT3FBVDe5eapKH2T6ID9dt0hQP3DBYLyas9XQhdZJ5fFFM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a5b:5c7:: with SMTP id
 w7mr7418520ybp.164.1617226057459; Wed, 31 Mar 2021 14:27:37 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:11 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 07/17] kallsyms: strip ThinLTO hashes from static functions
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
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
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
2.31.0.291.g576ba9dcdaf-goog

