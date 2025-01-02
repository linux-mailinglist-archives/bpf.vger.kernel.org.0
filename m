Return-Path: <bpf+bounces-47756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4389FFF00
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B622D3A336E
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 18:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EE41B4228;
	Thu,  2 Jan 2025 18:59:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C33F191F6D;
	Thu,  2 Jan 2025 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844387; cv=none; b=rs06KiZrExXHuRn1KvmqbfJMN60ZFvg+Yoi2dEzwfmp6tR496u9qNW+U7DOsTZFL6xmJzb6ATODFBrtlseauHp1mJrJngDPh2X38KMZXW/Wf+G5b/7mGNH15UcO8dqAmbQaBOn8LRxnxGE8fHk3fzUtWgS5wJDT+Y05zuISdRNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844387; c=relaxed/simple;
	bh=0PiWUTn4HS2+6Hqtdbt7AAKDTj3gjdoEBm3Jr4CL3Cs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TW6n6Vd1yRSQnFJMC9b0O/D/2Tyw2N13Wxmy4a6uEcHX7R4yH+Aph/YBfPeHaIaxPZzFKIcmsxUvGHG0tUXOZ2g4URnl3lY8v+anAnXXi6QVQ/qc/GksXsj+KhZoAoFx6n3uP5kvF6JvSoQriuzIFbpRVAjtVAlcPdryG+x+RmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEEEC4CED0;
	Thu,  2 Jan 2025 18:59:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTQRL-00000005MjM-1mpD;
	Thu, 02 Jan 2025 14:01:03 -0500
Message-ID: <20250102190103.276046882@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 13:58:46 -0500
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
Subject: [PATCH 01/14] scripts/sorttable: Remove unused macro defines
References: <20250102185845.928488650@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The code of sorttable.h was copied from the recordmcount.h  which defined
a bunch of Elf MACROs so that they could be used between 32bit and 64bit
functions. But there's several MACROs that sorttable.h does not use but
was copied over. Remove them to clean up the code.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 7bd0184380d3..2a9ec5046e9a 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -27,19 +27,10 @@
 #undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Rel
-#undef Elf_Rela
 #undef Elf_Sym
-#undef ELF_R_SYM
-#undef Elf_r_sym
-#undef ELF_R_INFO
-#undef Elf_r_info
-#undef ELF_ST_BIND
 #undef ELF_ST_TYPE
-#undef fn_ELF_R_SYM
-#undef fn_ELF_R_INFO
 #undef uint_t
 #undef _r
-#undef _w
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -52,19 +43,10 @@
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
 # define Elf_Rel		Elf64_Rel
-# define Elf_Rela		Elf64_Rela
 # define Elf_Sym		Elf64_Sym
-# define ELF_R_SYM		ELF64_R_SYM
-# define Elf_r_sym		Elf64_r_sym
-# define ELF_R_INFO		ELF64_R_INFO
-# define Elf_r_info		Elf64_r_info
-# define ELF_ST_BIND		ELF64_ST_BIND
 # define ELF_ST_TYPE		ELF64_ST_TYPE
-# define fn_ELF_R_SYM		fn_ELF64_R_SYM
-# define fn_ELF_R_INFO		fn_ELF64_R_INFO
 # define uint_t			uint64_t
 # define _r			r8
-# define _w			w8
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -76,19 +58,10 @@
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
 # define Elf_Rel		Elf32_Rel
-# define Elf_Rela		Elf32_Rela
 # define Elf_Sym		Elf32_Sym
-# define ELF_R_SYM		ELF32_R_SYM
-# define Elf_r_sym		Elf32_r_sym
-# define ELF_R_INFO		ELF32_R_INFO
-# define Elf_r_info		Elf32_r_info
-# define ELF_ST_BIND		ELF32_ST_BIND
 # define ELF_ST_TYPE		ELF32_ST_TYPE
-# define fn_ELF_R_SYM		fn_ELF32_R_SYM
-# define fn_ELF_R_INFO		fn_ELF32_R_INFO
 # define uint_t			uint32_t
 # define _r			r
-# define _w			w
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
-- 
2.45.2



