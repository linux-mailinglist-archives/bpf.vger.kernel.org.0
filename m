Return-Path: <bpf+bounces-35731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4057193D433
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F7F1C23286
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8130D17BB1D;
	Fri, 26 Jul 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTvhlzUx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7E176AAE;
	Fri, 26 Jul 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000824; cv=none; b=Z4WiQ54Za7627aD4p3g3Acrc1J5w958GETBcHIkcGQkqS4VoCB/jATnHqyC41lVb+6I3p/hddVA6QtzHYkL8ZuyXygiFYKzPfxbcMIOIO09K2yfeDMpYYBlAR4S0AwvxUl+b/+bWoW6gNYuolM73NGHQcvrMnsaM7A0stUJm8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000824; c=relaxed/simple;
	bh=1PYTiId4BuPOHiUxSn1neJSHlnqAUMLX8ggbJ7DCGb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmRIkvQvNPAA85ci68WDWvdp8pkwb8iFIPUgWKrAkC9gdbofkBpweiPsU7wl+oT+nchkEqGO+xid+wRAXIJy05Eylo+6Jbo1UwJggxIAA+l9fo26qTLVfV99oWSyYn1NoMTGcsghUGIKrJf5waOkBF8TKLVXZad47k0t0pJXTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTvhlzUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEC9C32782;
	Fri, 26 Jul 2024 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722000823;
	bh=1PYTiId4BuPOHiUxSn1neJSHlnqAUMLX8ggbJ7DCGb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTvhlzUxzfOziu+NWn6gJWcl8rt1a2JqwLIwKXLzMSBDWKB9U+BKxFFSVxvrihqNn
	 8ELIXeQe2L9TMu+ymz62gN/yLewI2oFvQtMdg/Vmnckv0M3VBoJybUeWBxnyj0jDJR
	 djORyFROf2lsVVN1dFdEATbcHDHLlnkA5kVDjxI1WSBCMaALED9Z2WN6Q+sCTjzaXa
	 TM/bJA8VBNfGXg7+Zv8JrZE7CdVWIJTaEHumVB/t2CJvrxz83k+3c4UabUZ3F5d5ki
	 ee14a19Vf4YZnjmuO1z2f5W98+yhp1Exz0ggDw3OgTkDF8bhvRRNV0Jun5umNARbTn
	 JfULlMmfoKv+w==
Date: Fri, 26 Jul 2024 10:33:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org
Cc: Guilherme Amadio <amadio@gentoo.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: perf tools build clash with capstone
Message-ID: <ZqOltPk9VQGgJZAA@x1>
References: <ZqFz1eKplFvhOx16@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqFz1eKplFvhOx16@x1>

On Wed, Jul 24, 2024 at 06:36:25PM -0300, Arnaldo Carvalho de Melo wrote:
> Still investigating, but seems just a namespace clash, haven't yet
> pinpointed the cset where this problem was introduced.

So this happens with fedora:40 as well, the current "fix" is to avoid
including util/sort.h from util/disasm.c to avoid the clash, I added
this to the "perf annotate: Add support to capture and parse raw
instruction in powerpc using dso__data_read_offset utility" patch since
all we need is the sort_order extern for that hack with "sym" +
"powerpc", that we need to get rid off at some point anyway.

- Arnaldo

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 0aac35c5f1bcfda9..bab15cce612f8ff0 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -25,7 +25,6 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "util.h"
-#include "sort.h"
 
 static regex_t	 file_lineno;
 
@ -1855,6 +1854,8 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	 * not required in case of powerpc.
 	 */
 	if (arch__is(args->arch, "powerpc")) {
+		extern const char *sort_order;
+
 		if (sort_order && !strstr(sort_order, "sym")) {
 			err = symbol__disassemble_raw(symfs_filename, sym, args);
 			if (err == 0)
 

 
> Probably alpine:3.19/archlinux:base are the first where capstone devel
> files are available.
> 
> perfbuilder@number:~$ export BUILD_TARBALL=http://192.168.86.42/perf/perf-6.10.0.tar.xz
> perfbuilder@number:~$ time dm
>    1   101.28 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-22) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8.10.0+3757+fc27b834) flex 2.6.1
>    2   100.50 almalinux:9                   : Ok   gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9) flex 2.6.4
>    3   119.65 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1 flex 2.6.4
>    4   117.18 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
>    5    99.97 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
>    6    92.95 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_git20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
>    7    13.59 alpine:3.19                   : FAIL gcc version 13.2.1 20231014 (Alpine 13.2.1_git20231014) 
>                      from util/disasm.c:29:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
>                      from builtin-script.c:38:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>     make[3]: *** [/git/perf-6.10.0/tools/build/Makefile.build:158: util] Error 2
>       CC      /tmp/build/perf/util/event.o
>       CC      /tmp/build/perf/builtin-script.o
>       CC      /tmp/build/perf/util/evlist.o
>       CC      /tmp/build/perf/arch/x86/util/env.o
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from util/print_insn.h:23,
>                      from util/disasm.c:29:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>       CC      /tmp/build/perf/arch/x86/util/dwarf-regs.o
>       CC      /tmp/build/perf/util/sideband_evlist.o
>       CC      /tmp/build/perf/arch/x86/util/unwind-libunwind.o
>       CC      /tmp/build/perf/builtin-kvm.o
>       CC      /tmp/build/perf/builtin-inject.o
>     make[4]: *** [/git/perf-6.10.0/tools/build/Makefile.build:106: /tmp/build/perf/util/disasm.o] Error 1
>     make[4]: *** Waiting for unfinished jobs....
>       CC      /tmp/build/perf/builtin-mem.o
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
>                      from builtin-script.c:38:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>       CC      /tmp/build/perf/builtin-data.o
>       CC      /tmp/build/perf/bench/breakpoint.o
>       CC      /tmp/build/perf/tests/evsel-roundtrip-name.o
>       CC      /tmp/build/perf/arch/x86/util/auxtrace.o
>       CC      /tmp/build/perf/tests/evsel-tp-sched.o
>    8    13.68 alpine:3.20                   : FAIL gcc version 13.2.1 20240309 (Alpine 13.2.1_git20240309) 
>                      from util/disasm.c:29:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
>                      from builtin-script.c:38:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>     make[3]: *** [/git/perf-6.10.0/tools/build/Makefile.build:158: util] Error 2
>       CC      /tmp/build/perf/bench/breakpoint.o
>       CC      /tmp/build/perf/tests/hists_link.o
>       CC      /tmp/build/perf/builtin-kvm.o
>       CC      /tmp/build/perf/util/env.o
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from util/print_insn.h:23,
>                      from util/disasm.c:29:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
>                      from builtin-script.c:38:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>       CC      /tmp/build/perf/builtin-inject.o
>       CC      /tmp/build/perf/arch/x86/util/intel-pt.o
>       CC      /tmp/build/perf/util/event.o
>     make[4]: *** [/git/perf-6.10.0/tools/build/Makefile.build:106: /tmp/build/perf/util/disasm.o] Error 1
>     make[4]: *** Waiting for unfinished jobs....
>    9    13.56 alpine:edge                   : FAIL gcc version 13.2.1 20240309 (Alpine 13.2.1_git20240309) 
>                      from util/disasm.c:29:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
>                      from builtin-script.c:38:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>       CC      /tmp/build/perf/builtin-script.o
>       CC      /tmp/build/perf/tests/hists_output.o
>       CC      /tmp/build/perf/tests/hists_cumulate.o
>       CC      /tmp/build/perf/bench/epoll-ctl.o
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from util/print_insn.h:23,
>                      from util/disasm.c:29:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>       CC      /tmp/build/perf/util/sideband_evlist.o
>       CC      /tmp/build/perf/builtin-kvm.o
>       CC      /tmp/build/perf/arch/x86/util/auxtrace.o
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
>                      from builtin-script.c:38:
>     /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>       CC      /tmp/build/perf/tests/python-use.o
>       CC      /tmp/build/perf/util/evsel.o
>     make[4]: *** [/git/perf-6.10.0/tools/build/Makefile.build:106: /tmp/build/perf/util/disasm.o] Error 1
>     make[4]: *** Waiting for unfinished jobs....
>       CC      /tmp/build/perf/builtin-inject.o
>   10    12.00 amazonlinux:2                 : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-17) (GCC) 
>   11    87.71 amazonlinux:2023              : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn2023.0.1) flex 2.6.4
>   12    86.71 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
>   13    18.34 archlinux:base                : FAIL gcc version 13.2.1 20230801 (GCC) 
>                      from builtin-script.c:38:
>     /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from util/print_insn.h:23,
>                      from util/disasm.c:29:
>     /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>       CC      /tmp/build/perf/util/copyfile.o
>       CC      /tmp/build/perf/ui/browsers/scripts.o
>       CC      /tmp/build/perf/bench/epoll-wait.o
>       CC      /tmp/build/perf/arch/x86/util/mem-events.o
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
>                      from builtin-script.c:38:
>     /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>       CC      /tmp/build/perf/builtin-data.o
>       CC      /tmp/build/perf/ui/browsers/header.o
>       CC      /tmp/build/perf/builtin-version.o
>       CC      /tmp/build/perf/builtin-c2c.o
>       CC      /tmp/build/perf/arch/x86/util/evsel.o
>     --
>       CC      /tmp/build/perf/arch/x86/util/intel-pt.o
>       CC      /tmp/build/perf/util/sideband_evlist.o
>       CC      /tmp/build/perf/util/evsel.o
>       CC      /tmp/build/perf/arch/x86/util/intel-bts.o
>     In file included from /usr/include/capstone/capstone.h:325,
>                      from util/print_insn.h:23,
>                      from util/disasm.c:29:
>     /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
>        94 | typedef enum bpf_insn {
>           |              ^~~~~~~~
>       CC      /tmp/build/perf/tests/pmu-events.o
>       CC      /tmp/build/perf/util/evsel_fprintf.o
>       CC      /tmp/build/perf/bench/kallsyms-parse.o
>       CC      /tmp/build/perf/bench/find-bit-bench.o
>       CC      /tmp/build/perf/tests/hists_common.o
>   14   103.85 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-21) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8+767+9fa966b8) flex 2.6.1
>   15    98.52 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 14.1.1 20240717 releases/gcc-14.1.0-275-g3a963d441a , clang version 17.0.6 flex 2.6.4

