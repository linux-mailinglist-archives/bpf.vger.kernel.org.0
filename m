Return-Path: <bpf+bounces-26839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C68D8A5793
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFBB1F21F30
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141082492;
	Mon, 15 Apr 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA/AWKYQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1080C14
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198054; cv=none; b=pRo10OyIjvC1dZPdUGsx2ww2uMztZ2BYU3L/nvOpkKyOoTnwtgKvWbhbVQJeC34hEMrLWJsTlgtW4LsR6KWGjrcdbZSc7yXjHFa5f01uFrFNdCDXSFbuYS/j0KuczeGxuoM8u1Yyp8L3oHmnS/rbocHfS0Vgj0jsM1nHZD9B1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198054; c=relaxed/simple;
	bh=J2hRLplVLxqxMA6E8xzPuTVt84azbEdp5qYIhiP3Ytk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aqud+y1g98AefQCQ9uCLaYRgYFTBodVl6gWIEcG5C6355F1Cmfof7ULd0DE8j7amOX3xEMbMIeK9iXHxbtO+huADTKWolY3bNwmLGmDK2y8tqUafebmA9YjZN48NqxfMb/zw3gS8LfBkF/ci7JUYRkNFDIqvxYX3HZyTZCMOuMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vA/AWKYQ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343e46df264so1850278f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713198050; x=1713802850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=olXUbwFvWhAHV+rAKgvFMgGXe2ohRAJCIFGXNNajNx8=;
        b=vA/AWKYQXEkfbEVTu+k74IYsRmp/E8LEwP9CHw1cqQqbiHALGR+vepem1WF1CF2GMv
         VGCChGMezqFG+63IvqMvEe55EmQX6KBp86C8Gw52QfhteJRiL5k+FaRje0CnfveWybRy
         vPz44NhV9DWT1tIaCqGaQiiKdsYJemGsaDRPBK2ox/Q0tgghKmOgKWpZD4K3LWYPDcSN
         admV1yjIU4kf43QBw+AFxqk3Fqst9qo1s962UwqfhqPYXQ+CP2B8P2znPBCDJbW+A0GB
         tOzBZTRR03yCqYROQ6sz6H3nlKiPH2QLfP160PpaPOXSJaPX4/kr2oMw0wL5h00LDeJB
         oG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198050; x=1713802850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olXUbwFvWhAHV+rAKgvFMgGXe2ohRAJCIFGXNNajNx8=;
        b=Ov9Sb26JvsCzqHnT4vKoJSwanwUNkpb/E0nVUTofwUGa3cWiyS1xkBA7SMynthEWQD
         hluor/HWvRsUYfc3e3wZ8vMIO5c+d4N7hg2gtkgydY7fuy4eJdGUUoOEPizxcuTfx1IX
         CbJfdRZu87j1IwZDMabxLZPPldaSb391SWGkykMzcX6bY2KzveiRBhdKI3/Jn3hRGSL/
         /IkZnEptAo5VLfmwuBUAxIBBoLphlk4rld937ZkMhcozZgJhWVK61Iw9/JIr8Hs+Fgo8
         lQW2++hQFowUW0CDjsqg5U2eKcJLSD2zUzYQgwVK+preUYH8pjzq77xt8mF3qqLTRVep
         1Dvw==
X-Forwarded-Encrypted: i=1; AJvYcCUgWhqYiMuzmVHEeLmxxrCWt87x3Jgc+GSjI41JdvVlK/0WUFUsowgMZAhXlLL01CO3yEgfZVagT5HDfjNcdqGDT4lH
X-Gm-Message-State: AOJu0Yw+UrAyaJA6+m2UWdBbXbanzm78VtMmQF8hmmCyX0Hb1utvYLiq
	wRYvW89PBQMtulPKjyU7fvaLtdMa5zggbn8Fsa6fDUeMNZHNusMn/M68ZwUNcyo8TNBn+g==
X-Google-Smtp-Source: AGHT+IEMgew5ssfIbv9fifRncojzkGtMiA8CSK6jhzA2J79/AgUKJ2Zlkb123g0xWbDErEkxut602gdK
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:e38a:0:b0:346:35ad:3d0f with SMTP id
 e10-20020adfe38a000000b0034635ad3d0fmr20173wrm.4.1713198050558; Mon, 15 Apr
 2024 09:20:50 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:20:43 +0200
In-Reply-To: <20240415162041.2491523-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5390; i=ardb@kernel.org;
 h=from:subject; bh=V4aOk/fz1+fDF2STMCLU+VVQ7hXwmmgXF9wA63lernQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU02+HbVugcM9mKl8d6vVHKWyArYhkd23LGffr56kkK50
 KrJ01Z0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInU2DAy9PNsWrBtzrbqf115
 on+fPH3+LXWlpem1sgfxW09/+ntpqT0jw+wZE16KfngW3NcZJpls23ek6l5NQKri/IiImAsLNI8 oMgAA
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415162041.2491523-6-ardb+git@google.com>
Subject: [PATCH v4 1/3] kallsyms: Avoid weak references for kallsyms symbols
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

kallsyms is a directory of all the symbols in the vmlinux binary, and so
creating it is somewhat of a chicken-and-egg problem, as its non-zero
size affects the layout of the binary, and therefore the values of the
symbols.

For this reason, the kernel is linked more than once, and the first pass
does not include any kallsyms data at all. For the linker to accept
this, the symbol declarations describing the kallsyms metadata are
emitted as having weak linkage, so they can remain unsatisfied. During
the subsequent passes, the weak references are satisfied by the kallsyms
metadata that was constructed based on information gathered from the
preceding passes.

Weak references lead to somewhat worse codegen, because taking their
address may need to produce NULL (if the reference was unsatisfied), and
this is not usually supported by RIP or PC relative symbol references.

Given that these references are ultimately always satisfied in the final
link, let's drop the weak annotation, and instead, provide fallback
definitions in the linker script that are only emitted if an unsatisfied
reference exists.

While at it, drop the FRV specific annotation that these symbols reside
in .rodata - FRV is long gone.

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Boot
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20230504174320.3930345-1-ardb%40kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 19 +++++++++++++
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f7749d0f2562..e8449be62058 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -448,11 +448,30 @@
 #endif
 #endif
 
+/*
+ * Some symbol definitions will not exist yet during the first pass of the
+ * link, but are guaranteed to exist in the final link. Provide preliminary
+ * definitions that will be superseded in the final link to avoid having to
+ * rely on weak external linkage, which requires a GOT when used in position
+ * independent code.
+ */
+#define PRELIMINARY_SYMBOL_DEFINITIONS					\
+	PROVIDE(kallsyms_addresses = .);				\
+	PROVIDE(kallsyms_offsets = .);					\
+	PROVIDE(kallsyms_names = .);					\
+	PROVIDE(kallsyms_num_syms = .);					\
+	PROVIDE(kallsyms_relative_base = .);				\
+	PROVIDE(kallsyms_token_table = .);				\
+	PROVIDE(kallsyms_token_index = .);				\
+	PROVIDE(kallsyms_markers = .);					\
+	PROVIDE(kallsyms_seqs_of_names = .);
+
 /*
  * Read only Data
  */
 #define RO_DATA(align)							\
 	. = ALIGN((align));						\
+	PRELIMINARY_SYMBOL_DEFINITIONS					\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 18edd57b5fe8..22ea19a36e6e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -325,12 +325,6 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	unsigned long symbol_start = 0, symbol_end = 0;
 	unsigned long i, low, high, mid;
 
-	/* This kernel should never had been booted. */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
-		BUG_ON(!kallsyms_addresses);
-	else
-		BUG_ON(!kallsyms_offsets);
-
 	/* Do a binary search on the sorted kallsyms_addresses array. */
 	low = 0;
 	high = kallsyms_num_syms;
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 27fabdcc40f5..85480274fc8f 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -5,27 +5,21 @@
 #include <linux/types.h>
 
 /*
- * These will be re-linked against their real values
- * during the second link stage.
+ * These will be re-linked against their real values during the second link
+ * stage. Preliminary values must be provided in the linker script using the
+ * PROVIDE() directive so that the first link stage can complete successfully.
  */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
+extern const unsigned long kallsyms_addresses[];
+extern const int kallsyms_offsets[];
+extern const u8 kallsyms_names[];
 
-/*
- * Tell the compiler that the count isn't in the small data section if the arch
- * has one (eg: FRV).
- */
-extern const unsigned int kallsyms_num_syms
-__section(".rodata") __attribute__((weak));
-
-extern const unsigned long kallsyms_relative_base
-__section(".rodata") __attribute__((weak));
+extern const unsigned int kallsyms_num_syms;
+extern const unsigned long kallsyms_relative_base;
 
-extern const char kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
+extern const char kallsyms_token_table[];
+extern const u16 kallsyms_token_index[];
 
-extern const unsigned int kallsyms_markers[] __weak;
-extern const u8 kallsyms_seqs_of_names[] __weak;
+extern const unsigned int kallsyms_markers[];
+extern const u8 kallsyms_seqs_of_names[];
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
-- 
2.44.0.683.g7961c838ac-goog


