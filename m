Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F835C96A
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhDLPIe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 11:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237526AbhDLPId (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 11:08:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F108611F0;
        Mon, 12 Apr 2021 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618240095;
        bh=yEYZUKPaHR793ZDhmZ+P1vlAN1MGuDfGKGZ/vHIAn3Q=;
        h=Date:From:To:Cc:Subject:From;
        b=K3Zdpb3zv2ms3Q7FD6i2Sv3atrOd3gtXVtLnczlukv1pjpMlW+rGc0C/jBoHa0Cdb
         KiZdEu9/2ES3dZSuydULJoVbPW0DqxdBUaQn0D6g7GubujH/gHpzUoTMrZseVKfiTJ
         sQHgbKEtK/n+L7vDqz76Is5G0B/LzClBD+C9bnLZp1rPxq3qPLyDhPpQ8Bg0dbaFOp
         e6w/g2vtSzTZ1AL7yg1v2YEefQTRHhVvV8CCKaO593zpFAja2i/EyxxAQDJTeHZlof
         ubYtmxZsy+/7rPmQ4YIw9zyFN7MybZuMeW1TzuopXEKNgkDaBEtUvH9RtaTkSmDMRK
         MstQHuloq83+g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0B4D040647; Mon, 12 Apr 2021 12:08:13 -0300 (-03)
Date:   Mon, 12 Apr 2021 12:08:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     dwarves@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Bill Wendling <morbo@google.com>,
        David Blaikie <dblaikie@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: ANNOUNCE: pahole v1.21 (clang's LTO edition, BTF floats)
Message-ID: <YHRiXNX1JUF2Az0A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
 
	The v1.21 release of pahole and its friends is out, this time it's
about using clang to build the kernel with LTO, some DWARF5 fixes, supporting
floating types in the BTF encoder for s/390 sake and some misc fixes and
improvements. Ah, it should also be faster due to switching to using libbpf's
hashing routines.

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.21.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.21.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.21.tar.sign

	Thanks a lot to all the contributors and distro packagers, you're on the
CC list, I appreciate a lot the work you put into these tools,

Best Regards,
 
 - Arnaldo

DWARF loader:

- Handle DWARF5 DW_OP_addrx properly

  Part of the effort to support the subset of DWARF5 that is generated when building the kernel.

- Handle subprogram ret type with abstract_origin properly

  Adds a second pass to resolve abstract origin DWARF description of functions to aid
  the BTF encoder in getting the right return type.

- Check .notes section for LTO build info

  When LTO is used, currently only with clang, we need to do extra steps to handle references
  from one object (compile unit, aka CU) to another, a way for DWARF to avoid duplicating
  information.

- Check .debug_abbrev for cross-CU references

  When the kernel build process doesn't add an ELF note in vmlinux indicating that LTO was
  used and thus intra-CU references are present and thus we need to use a more expensive
  way to resolve types and (again) thus to encode BTF, we need to look at DWARF's .debug_abbrev
  ELF section to figure out if such intra-CU references are present.

- Permit merging all DWARF CU's for clang LTO built binary

  Allow not trowing away previously supposedly self contained compile units
  (objects, aka CU, aka Compile Units) as they have type descriptions that will
  be used in later CUs.

- Permit a flexible HASHTAGS__BITS

  So that we can use a more expensive algorithm when we need to keep previously processed
  compile units that will then be referenced by later ones to resolve types.

- Use a better hashing function, from libbpf

  Enabling patch to combine compile units when using LTO.

BTF encoder:

- Add --btf_gen_all flag

  A new command line to allow asking for the generation of all BTF encodings, so that we
  can stop adding new command line options to enable new encodings in the kernel Makefile.

- Match ftrace addresses within ELF functions

  To cope with differences in how DWARF and ftrace describes function boundaries.

- Funnel ELF error reporting through a macro

  To use libelf's elf_error() function, improving error messages.

- Sanitize non-regular int base type

  Cope with clang with dwarf5 non-regular int base types, tricky stuff, see yhs
  full explanation in the relevant cset.

- Add support for the floating-point types

  S/390 has floats'n'doubles in its arch specific linux headers, cope with that.

Pretty printer:

- Honour conf_fprintf.hex when printing enumerations

  If the user specifies --hex in the command line, honour it when printing enumerations.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
