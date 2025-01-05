Return-Path: <bpf+bounces-47895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB4FA01A75
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 17:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D3118838DD
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C931C5F0E;
	Sun,  5 Jan 2025 16:22:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36919DF5B;
	Sun,  5 Jan 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094141; cv=none; b=smjhNYjPSromKknse432pPWvoLu0M5j9ETdwIjSmWWRHTY9JF6oXxkzyhKkjLXelvrcFKGI5/dS7zkPglBwAE6NSZ0Na+ERXXIMDAbPODEc7sZgf18DmkkbYKW5vAWS2UysHAbjrwiPIE7Fm510M3LrxhI5VTEStO7Gyqe1fFCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094141; c=relaxed/simple;
	bh=+QyYpeRbkgo4EmCdCfQnmv4zRztB3F8BzX4bjwL9FGk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eGoQMYhlAfKksnW9ixUAswB26LYBii6DCo/8VW/OUbYtvUULTY4lDyGuUmMlBKYaoPQyRn1f4B+gkQbazctzjzvLp7kfErAkLUwnJ41VkiRrEWBPaE4NN9ev1pbE8nd9if6Bmz4YjObkCyWzoj8XO0JJWh6HrR1bZDvT2Ke/Cic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17159C4CEE2;
	Sun,  5 Jan 2025 16:22:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tUTPl-00000008Et4-0SyU;
	Sun, 05 Jan 2025 11:23:45 -0500
Message-ID: <20250105162344.945299671@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 05 Jan 2025 11:22:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 05/14] scripts/sorttable: Make compare_extable() into two functions
References: <20250105162211.971039541@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of having the compare_extable() part of the sorttable.h header
where it get's defined twice, since it is a very simple function, just
define it twice in sorttable.c, and then it can use the proper read
functions for the word size and endianess and the Elf_Addr macro can be
removed from sorttable.h.

Also add a micro optimization. Instead of:

    if (a < b)
        return -1;
    if (a > b)
        return 1;
    return 0;

That can be shorten to:

   if (a < b)
      return -1;
   return a > b;

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 20 ++++++++++++++++++++
 scripts/sorttable.h | 14 --------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 4dcdbf7a5e26..3e2c17e91485 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -173,6 +173,26 @@ static inline unsigned int get_secindex(unsigned int shndx,
 	return r(&symtab_shndx_start[sym_offs]);
 }
 
+static int compare_extable_32(const void *a, const void *b)
+{
+	Elf32_Addr av = r(a);
+	Elf32_Addr bv = r(b);
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
+static int compare_extable_64(const void *a, const void *b)
+{
+	Elf64_Addr av = r8(a);
+	Elf64_Addr bv = r8(b);
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "sorttable.h"
 #define SORTTABLE_64
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 7c06a754e31a..58e9cebe8362 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,7 +23,6 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef Elf_Addr
 #undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Sym
@@ -38,7 +37,6 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
 # define Elf_Sym		Elf64_Sym
@@ -52,7 +50,6 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
 # define Elf_Sym		Elf32_Sym
@@ -157,17 +154,6 @@ static void *sort_orctable(void *arg)
 }
 #endif
 
-static int compare_extable(const void *a, const void *b)
-{
-	Elf_Addr av = _r(a);
-	Elf_Addr bv = _r(b);
-
-	if (av < bv)
-		return -1;
-	if (av > bv)
-		return 1;
-	return 0;
-}
 #ifdef MCOUNT_SORT_ENABLED
 pthread_t mcount_sort_thread;
 
-- 
2.45.2



