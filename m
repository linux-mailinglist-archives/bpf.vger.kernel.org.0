Return-Path: <bpf+bounces-47901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F6A01A81
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 777137A18BD
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B61D5CF9;
	Sun,  5 Jan 2025 16:22:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52361D5177;
	Sun,  5 Jan 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094143; cv=none; b=Y/Fy8XyeOwoMGqjlZhc2tdJCltX3p1sLquMIAqshQLh6y3HvXInCGKUczugaHATa8FoJwjL9N8BMoAtHNMAwA1Scv/qKiyNkDsF6CjstOAkso4JCcP+409Qs8HBqTnH84SkJWKoP430ubbIRupQV+2EwYiIo3q2XmyQMLTtHL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094143; c=relaxed/simple;
	bh=/4azsqDLsrbB/1qJH9CZHFoMzOGofhz0TORgNxsoWJE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=T1KHQGHPKNQSVoBl8aYfE52gdlfIBIBAsJ0dqddLE3N7/L9ci20K+LYY1lPwsVJtkpY4MC8foR9HgLkjIQWN4d10wQr/tGsFYB30IywxBdu8quOTyvR25gQA6u/YI62KYW8RQOe7uAi/cZUayvVK5n4+wg1J66nHu3mXaCTaNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E63C4CEDD;
	Sun,  5 Jan 2025 16:22:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tUTPm-00000008EwZ-2JXY;
	Sun, 05 Jan 2025 11:23:46 -0500
Message-ID: <20250105162346.373528925@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 05 Jan 2025 11:22:23 -0500
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
Subject: [PATCH 12/14] scripts/sorttable: Use uint64_t for mcount sorting
References: <20250105162211.971039541@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The mcount sorting defines uint_t to uint64_t on 64bit architectures and
uint32_t on 32bit architectures. It can work with just using uint64_t as
that will hold the values of both, and they are not used to point into the
ELF file.

sizeof(uint_t) is used for defining the size of the mcount_loc section.
Instead of using a type, define long_size and use that instead. This will
allow the header code to be moved into the C file as generic functions and
not need to include sorttable.h twice, once for 64bit and once for 32bit.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a1c9bdd6b5dd..b9c0716ee72c 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,7 +23,6 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef uint_t
 #undef ehdr_shoff
 #undef ehdr_shentsize
 #undef ehdr_shstrndx
@@ -39,6 +38,7 @@
 #undef sym_name
 #undef sym_value
 #undef sym_shndx
+#undef long_size
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -47,7 +47,6 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define uint_t			uint64_t
 # define ehdr_shoff		ehdr64_shoff
 # define ehdr_shentsize		ehdr64_shentsize
 # define ehdr_shstrndx		ehdr64_shstrndx
@@ -63,6 +62,7 @@
 # define sym_name		sym64_name
 # define sym_value		sym64_value
 # define sym_shndx		sym64_shndx
+# define long_size		8
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -70,7 +70,6 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define uint_t			uint32_t
 # define ehdr_shoff		ehdr32_shoff
 # define ehdr_shentsize		ehdr32_shentsize
 # define ehdr_shstrndx		ehdr32_shstrndx
@@ -86,6 +85,7 @@
 # define sym_name		sym32_name
 # define sym_value		sym32_value
 # define sym_shndx		sym32_shndx
+# define long_size		4
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -190,25 +190,25 @@ pthread_t mcount_sort_thread;
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
 	Elf_Shdr *init_data_sec;
-	uint_t start_mcount_loc;
-	uint_t stop_mcount_loc;
+	uint64_t start_mcount_loc;
+	uint64_t stop_mcount_loc;
 };
 
 /* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
 static void *sort_mcount_loc(void *arg)
 {
 	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
-	uint_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
+	uint64_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
 					+ shdr_offset(emloc->init_data_sec);
-	uint_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
+	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
-	qsort(start_loc, count/sizeof(uint_t), sizeof(uint_t), compare_extable);
+	qsort(start_loc, count/long_size, long_size, compare_extable);
 	return NULL;
 }
 
 /* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
-static void get_mcount_loc(uint_t *_start, uint_t *_stop)
+static void get_mcount_loc(uint64_t *_start, uint64_t *_stop)
 {
 	FILE *file_start, *file_stop;
 	char start_buff[20];
@@ -274,8 +274,8 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int shstrndx;
 #ifdef MCOUNT_SORT_ENABLED
 	struct elf_mcount_loc mstruct = {0};
-	uint_t _start_mcount_loc = 0;
-	uint_t _stop_mcount_loc = 0;
+	uint64_t _start_mcount_loc = 0;
+	uint64_t _stop_mcount_loc = 0;
 #endif
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 	unsigned int orc_ip_size = 0;
-- 
2.45.2



