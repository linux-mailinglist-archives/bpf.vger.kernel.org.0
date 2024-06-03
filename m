Return-Path: <bpf+bounces-31220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545338D881E
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB24D1F224E8
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7187137904;
	Mon,  3 Jun 2024 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t99PUu0x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911128382;
	Mon,  3 Jun 2024 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436451; cv=none; b=BRAkxfIDWvZKj8Xsz15yHPYzGBfp9OSKIHEf2HxrqsDgbGv5URRDy3xngAlkINMN9tu1tHGn76RPvA7H50BBaZ0FrCgCN8HcUt/fE9fk7Fs4m0B0YIoB2YF30hWLzWphF1ngEejkDRq+vbCE6J4rq3wyTTYNlccThxR82pRLrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436451; c=relaxed/simple;
	bh=7Jt6JTJ5Fqe/ytKcty54fXO/iBTOFNE3jTW5wrQPTQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP78ngCHgbtjxSwVmlSp99qfQG7OaU2GGMCLdP15AX4V6lRqyKc2bEC96K8SeuYSZs4iFu3dgYjSMh4sEbn+YpfzDQZ1WLBd4yOV+FhVv/vLaROb07nA6UKNWmSnXsNX0od2kV4SPOayWboc9foXRomXUXrKbwJSiSKJ+uaFf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t99PUu0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D14C2BD10;
	Mon,  3 Jun 2024 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717436450;
	bh=7Jt6JTJ5Fqe/ytKcty54fXO/iBTOFNE3jTW5wrQPTQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t99PUu0xlGEHtX88oAXT01QIJuw+f1ykbAUSojgd6lCcR4Ns/E8xRS4D/OoE9MTfP
	 KfaYsZVnkyjkDAcidufDOGGwAjOPxAD/lg2Tn0cW4cmIl5k8gPZuzzioERVQr3gCZp
	 bOj4Y7goHi61AfspEVit7FYdpRUShK900uIjRcZrC4zzJ2eOBbZ7rBZNyRdN/yS1VS
	 jPgsjKlW1Xr4ybONpq3VTOUue4AYndoDxmFyA+ERynYMDE6RWpBiNMKrlyOhgIYGxX
	 cdIvd7yXBRvdYkrwdNaeJDwEeCI14KE9deNzKMIDKRiqo6bPfPOH4tv25QHfY0u/4A
	 dGAAe4SGRrjYg==
Date: Mon, 3 Jun 2024 14:40:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Mark Wielaard <mjw@redhat.com>, Hengqi Chen <hengqi.chen@gmail.com>,
	bpf@vger.kernel.org, dwarves@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: elfutils DWARF problem was: Re: Problem with BTF generation on
 mips64el
Message-ID: <Zl4AHfG6Gg5Htdgc@x1>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
 <Zln1kZnu2Xxeyngj@x1>
 <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu>
 <Zl3Zp5r9m6X_i_J4@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl3Zp5r9m6X_i_J4@x1>

On Mon, Jun 03, 2024 at 11:56:43AM -0300, Arnaldo Carvalho de Melo wrote:
> So the vmlinux seems to have its BTF section successfully generated,
> lemme check the .ko files.

⬢[acme@toolbox repro_die__process]$ pahole -F dwarf netdevsim.ko  | wc -l
die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got member (0xd)!
11448
⬢[acme@toolbox repro_die__process]$ pahole -F btf netdevsim.ko  | wc -l
libbpf: Invalid BTF string section
pahole: file 'netdevsim.ko' has no btf type information.
0
⬢[acme@toolbox repro_die__process]$

We manage to load a lot of DWARF types but then we hit that warning, no
BTF encoded.

Humm,

⬢[acme@toolbox repro_die__process]$ eu-readelf -winfo netdevsim.ko | wc -l
0
⬢[acme@toolbox repro_die__process]$ readelf -wi netdevsim.ko | wc -l
779837
⬢[acme@toolbox repro_die__process]$

It seems this is some problem with elfutils...

After I added:

⬢[acme@toolbox pahole]$ git diff
diff --git a/dwarf_loader.c b/dwarf_loader.c
index f59477b44dfea026..b832c93cc2194eaf 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2847,8 +2847,8 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
        }
 
        if (tag != DW_TAG_compile_unit && tag != DW_TAG_type_unit) {
-               fprintf(stderr, "%s: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got %s (0x%x)!\n",
-                       __FUNCTION__, dwarf_tag_name(tag), tag);
+               fprintf(stderr, "%s: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got %s (0x%x) @ %llx!\n",
+                       __FUNCTION__, dwarf_tag_name(tag), tag, (unsigned long long)dwarf_dieoffset(die));
                return -EINVAL;
        }
 
⬢[acme@toolbox pahole]$

We get:

⬢[acme@toolbox repro_die__process]$ pahole -F dwarf netdevsim.ko > /dev/null
die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got member (0xd) @ 529de!
⬢[acme@toolbox repro_die__process]$

And if we look at binutils' readeld DWARF dump we get:

⬢[acme@toolbox repro_die__process]$ readelf -wi netdevsim.ko | grep '<529de>' -B5 -A8
  Compilation Unit @ offset 0x529d3:
   Length:        0x2132e (32-bit)
   Version:       4
   Abbrev Offset: 0x1d0e
   Pointer Size:  8
 <0><529de>: Abbrev Number: 108 (DW_TAG_compile_unit)
    <529df>   DW_AT_producer    : (indirect string, offset: 0x41389): GNU C11 13.3.0 -G 0 -mel -mno-check-zero-division -mabi=64 -mno-abicalls -msoft-float -march=mips64r2 -msym32 -mlong-calls -mllsc -mips64r2 -mno-shared -g -gdwarf-4 -O2 -std=gnu11 -p -fshort-wchar -funsigned-char -fno-common -fno-strict-aliasing -fno-pic -ffreestanding -fstack-check=no -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector -fno-stack-clash-protection -fstrict-flex-arrays=3 -fno-strict-overflow -fstack-check=no -fconserve-stack
    <529e3>   DW_AT_language    : 12	(ANSI C99)
    <529e4>   DW_AT_name        : (indirect string, offset: 0x44ce0): drivers/net/netdevsim/ethtool.c
    <529e8>   DW_AT_comp_dir    : (indirect string, offset: 0x3f407): /home/kodidev/linux
    <529ec>   DW_AT_low_pc      : 0x5270
    <529f4>   DW_AT_high_pc     : 0x65c
    <529fc>   DW_AT_stmt_list   : 0x709d
 <1><52a00>: Abbrev Number: 57 (DW_TAG_base_type)
⬢[acme@toolbox repro_die__process]$ readelf -wi netdevsim.ko | grep '<529de>' -B5 -A8

And at that <529de> die it _is_ a DW_TAG_compile_unit, and we managed to
process two other DW_TAG_compile_units up to that point:

⬢[acme@toolbox repro_die__process]$ readelf -wi netdevsim.ko | grep -w DW_TAG_compile_unit
 <0><b>: Abbrev Number: 188 (DW_TAG_compile_unit)
 <0><26c16>: Abbrev Number: 188 (DW_TAG_compile_unit)
 <0><529de>: Abbrev Number: 108 (DW_TAG_compile_unit)
 <0><73d10>: Abbrev Number: 204 (DW_TAG_compile_unit)
 <0><a43a8>: Abbrev Number: 160 (DW_TAG_compile_unit)
 <0><c7e66>: Abbrev Number: 110 (DW_TAG_compile_unit)
 <0><e8f21>: Abbrev Number: 158 (DW_TAG_compile_unit)
 <0><10c525>: Abbrev Number: 115 (DW_TAG_compile_unit)
 <0><12da49>: Abbrev Number: 167 (DW_TAG_compile_unit)
 <0><1546b9>: Abbrev Number: 140 (DW_TAG_compile_unit)
 <0><17656a>: Abbrev Number: 1 (DW_TAG_compile_unit)
⬢[acme@toolbox repro_die__process]$


And eu-readelf also doesn't work for that mips vmlinux:

⬢[acme@toolbox repro_die__process]$ file vmlinux 
vmlinux: ELF 64-bit LSB executable, MIPS, MIPS64 rel2 version 1 (SYSV), statically linked, BuildID[sha1]=19c8dafc6aa33a2e63b87487dfb10bf215bdf3a3, with debug_info, not stripped
⬢[acme@toolbox repro_die__process]$ eu-readelf -winfo vmlinux 
⬢[acme@toolbox repro_die__process]$ eu-readelf -winfo+ vmlinux 
⬢[acme@toolbox repro_die__process]$ readelf -wi vmlinux | head -30
Contents of the .debug_info section:

  Compilation Unit @ offset 0:
   Length:        0x3f (32-bit)
   Version:       4
   Abbrev Offset: 0
   Pointer Size:  8
 <0><b>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <c>   DW_AT_stmt_list   : 0
    <10>   DW_AT_ranges      : 0
    <14>   DW_AT_name        : (indirect string, offset: 0): arch/mips/kernel/head.S
    <18>   DW_AT_comp_dir    : (indirect string, offset: 0x18): /home/kodidev/linux
    <1c>   DW_AT_producer    : (indirect string, offset: 0x2c): GNU AS 2.42
    <20>   DW_AT_language    : 32769	(MIPS assembler)
 <1><22>: Abbrev Number: 2 (DW_TAG_subprogram)
    <23>   DW_AT_name        : (indirect string, offset: 0x38): kernel_entry
    <27>   DW_AT_external    : 1
    <27>   DW_AT_type        : <0x41>
    <28>   DW_AT_low_pc      : 0xffffffff80b0ce68
    <30>   DW_AT_high_pc     : 172
 <1><32>: Abbrev Number: 2 (DW_TAG_subprogram)
    <33>   DW_AT_name        : (indirect string, offset: 0x45): smp_bootstrap
    <37>   DW_AT_external    : 1
    <37>   DW_AT_type        : <0x41>
    <38>   DW_AT_low_pc      : 0xffffffff80b0cf14
    <40>   DW_AT_high_pc     : 44
 <1><41>: Abbrev Number: 3 (DW_TAG_unspecified_type)
 <1><42>: Abbrev Number: 0
  Compilation Unit @ offset 0x43:
   Length:        0x22ed9 (32-bit)
⬢[acme@toolbox repro_die__process]$

Couldn't find a way to ask eu-readelf for more verbose output, where we
could perhaps get some clue as to why it produces nothing while binutils
readelf manages to grok it, Mark, do you know some other way to ask
eu-readelf to produce more debug output?

I'm unsure if the netdevsim.ko file was left in a semi encoded BTF state
that then made eu-readelf to not be able to process it while pahole,
that uses eltuils' libraries, was able to process the first two CUs for
a kernel module and all the CUs for the vmlinux file :-\

Mark, the whole thread is available at:

https://lore.kernel.org/all/Zl3Zp5r9m6X_i_J4@x1/T/#u

Now tryint to look at elfutils source to see if I can figure out
something there..

- Arnaldo

⬢[acme@toolbox repro_die__process]$ ltrace eu-readelf -winfo netdevsim.ko
<SNIP>
strlen(".gdb_index")                                                                 = 10
strncmp(".mdebug.abi64", ".gdb_index", 10)                                           = 6
elf_nextscn(0x55fddd480470, 0x55fddd4820e8, 10, 103)                                 = 0x55fddd4821b8
gelf_getshdr(0x55fddd4821b8, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_strptr(0x55fddd480470, 54, 349, 0x55fddd4831f8)                                  = 0x7f0970925879
strlen(".note.GNU-stack")                                                            = 15
strncmp(".note.GNU-stack", ".debug_abbrev", 13)                                      = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_addr")                                                                = 11
strncmp(".note.GNU-stack", ".debug_addr", 11)                                        = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_aranges")                                                             = 14
strncmp(".note.GNU-stack", ".debug_aranges", 14)                                     = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_frame")                                                               = 12
strncmp(".note.GNU-stack", ".debug_frame", 12)                                       = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_info")                                                                = 11
strncmp(".note.GNU-stack", ".debug_info", 11)                                        = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_types")                                                               = 12
strncmp(".note.GNU-stack", ".debug_types", 12)                                       = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_line")                                                                = 11
strncmp(".note.GNU-stack", ".debug_line", 11)                                        = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_loc")                                                                 = 10
strncmp(".note.GNU-stack", ".debug_loc", 10)                                         = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_loclists")                                                            = 15
strncmp(".note.GNU-stack", ".debug_loclists", 15)                                    = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_pubnames")                                                            = 15
strncmp(".note.GNU-stack", ".debug_pubnames", 15)                                    = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_str")                                                                 = 10
strncmp(".note.GNU-stack", ".debug_str", 10)                                         = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_line_str")                                                            = 15
strncmp(".note.GNU-stack", ".debug_line_str", 15)                                    = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_str_offsets")                                                         = 18
strncmp(".note.GNU-stack", ".debug_str_offsets", 18)                                 = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_macinfo")                                                             = 14
strncmp(".note.GNU-stack", ".debug_macinfo", 14)                                     = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_macro")                                                               = 12
strncmp(".note.GNU-stack", ".debug_macro", 12)                                       = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_ranges")                                                              = 13
strncmp(".note.GNU-stack", ".debug_ranges", 13)                                      = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".debug_rnglists")                                                            = 15
strncmp(".note.GNU-stack", ".debug_rnglists", 15)                                    = 10
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".eh_frame")                                                                  = 9
strncmp(".note.GNU-stack", ".eh_frame", 9)                                           = 9
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".eh_frame_hdr")                                                              = 13
strncmp(".note.GNU-stack", ".eh_frame_hdr", 13)                                      = 9
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".gcc_except_table")                                                          = 17
strncmp(".note.GNU-stack", ".gcc_except_table", 17)                                  = 7
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
strlen(".gdb_index")                                                                 = 10
strncmp(".note.GNU-stack", ".gdb_index", 10)                                         = 7
strncmp(".note.GNU-stack", ".gnu.debuglto_", 14)                                     = 7
elf_nextscn(0x55fddd480470, 0x55fddd4821b8, 14, 103)                                 = 0x55fddd482288
gelf_getshdr(0x55fddd482288, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482288, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482358
gelf_getshdr(0x55fddd482358, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482358, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482428
gelf_getshdr(0x55fddd482428, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482428, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd4824f8
gelf_getshdr(0x55fddd4824f8, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd4824f8, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd4825c8
gelf_getshdr(0x55fddd4825c8, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd4825c8, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482698
gelf_getshdr(0x55fddd482698, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482698, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482768
gelf_getshdr(0x55fddd482768, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482768, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482838
gelf_getshdr(0x55fddd482838, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482838, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482908
gelf_getshdr(0x55fddd482908, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482908, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd4829d8
gelf_getshdr(0x55fddd4829d8, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd4829d8, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482aa8
gelf_getshdr(0x55fddd482aa8, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482aa8, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482b78
gelf_getshdr(0x55fddd482b78, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482b78, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482c48
gelf_getshdr(0x55fddd482c48, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482c48, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482d18
gelf_getshdr(0x55fddd482d18, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482d18, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482de8
gelf_getshdr(0x55fddd482de8, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482de8, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd482eb8
gelf_getshdr(0x55fddd482eb8, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_strptr(0x55fddd480470, 54, 513, 0x55fddd4831f8)                                  = 0x7f097092591d
strlen(".BTF")                                                                       = 4
strncmp(".BTF", ".debug_abbrev", 13)                                                 = -34
strlen(".debug_addr")                                                                = 11
strncmp(".BTF", ".debug_addr", 11)                                                   = -34
strlen(".debug_aranges")                                                             = 14
strncmp(".BTF", ".debug_aranges", 14)                                                = -34
strlen(".debug_frame")                                                               = 12
strncmp(".BTF", ".debug_frame", 12)                                                  = -34
strlen(".debug_info")                                                                = 11
strncmp(".BTF", ".debug_info", 11)                                                   = -34
strlen(".debug_types")                                                               = 12
strncmp(".BTF", ".debug_types", 12)                                                  = -34
strlen(".debug_line")                                                                = 11
strncmp(".BTF", ".debug_line", 11)                                                   = -34
strlen(".debug_loc")                                                                 = 10
strncmp(".BTF", ".debug_loc", 10)                                                    = -34
strlen(".debug_loclists")                                                            = 15
strncmp(".BTF", ".debug_loclists", 15)                                               = -34
strlen(".debug_pubnames")                                                            = 15
strncmp(".BTF", ".debug_pubnames", 15)                                               = -34
strlen(".debug_str")                                                                 = 10
strncmp(".BTF", ".debug_str", 10)                                                    = -34
strlen(".debug_line_str")                                                            = 15
strncmp(".BTF", ".debug_line_str", 15)                                               = -34
strlen(".debug_str_offsets")                                                         = 18
strncmp(".BTF", ".debug_str_offsets", 18)                                            = -34
strlen(".debug_macinfo")                                                             = 14
strncmp(".BTF", ".debug_macinfo", 14)                                                = -34
strlen(".debug_macro")                                                               = 12
strncmp(".BTF", ".debug_macro", 12)                                                  = -34
strlen(".debug_ranges")                                                              = 13
strncmp(".BTF", ".debug_ranges", 13)                                                 = -34
strlen(".debug_rnglists")                                                            = 15
strncmp(".BTF", ".debug_rnglists", 15)                                               = -34
strlen(".eh_frame")                                                                  = 9
strncmp(".BTF", ".eh_frame", 9)                                                      = -35
strlen(".eh_frame_hdr")                                                              = 13
strncmp(".BTF", ".eh_frame_hdr", 13)                                                 = -35
strlen(".gcc_except_table")                                                          = 17
strncmp(".BTF", ".gcc_except_table", 17)                                             = -37
strlen(".gdb_index")                                                                 = 10
strncmp(".BTF", ".gdb_index", 10)                                                    = -37
elf_nextscn(0x55fddd480470, 0x55fddd482eb8, 10, 103)                                 = 0x55fddd482f88
gelf_getshdr(0x55fddd482f88, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd482f88, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd483058
gelf_getshdr(0x55fddd483058, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd483058, 0x55fddd480470, 0x55fddd4831f8)          = 0x55fddd483128
gelf_getshdr(0x55fddd483128, 0x7fff00974910, 0x55fddd480538, 0x55fddd4831f8)         = 0x7fff00974910
elf_nextscn(0x55fddd480470, 0x55fddd483128, 0x55fddd480470, 0x55fddd4831f8)          = 0
dwfl_end(0, 165, 0x55fddd480538, 0x55fddd4831f8)                                     = 0
free(nil)                                                                            = <void>
free(nil)                                                                            = <void>
free(nil)                                                                            = <void>
free(nil)                                                                            = <void>
free(nil)                                                                            = <void>
free(nil)                                                                            = <void>
free(nil)                                                                            = <void>
free(0x55fddd47eef0)                                                                 = <void>
<... dwfl_getmodules resumed> )                                                      = 0
dwfl_end(0x55fddd47ea90, 0x55fddd47eee0, 0x55fddd47e, 1)                             = 6
close(3)                                                                             = 0
__cxa_finalize(0x55fddbe44780, 10, 0, 0x7fff00974ee0)                                = 1
+++ exited (status 0) +++
⬢[acme@toolbox repro_die__process]$ 

