Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F630FFEA
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 23:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhBDWI3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 17:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhBDWIY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 17:08:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD6CC64E4A;
        Thu,  4 Feb 2021 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612476464;
        bh=JA5i5CJqYX81a3kjCG1mjmZB3f3ENVDSQ9kAT86kifY=;
        h=Date:From:To:Cc:Subject:From;
        b=aPHM6K9RJwsd4Xt8K0gLDMkCF2WhWg5vRgVcnP9Plm2uEKMrW73/LK7erWyBRdS6d
         5mo4oXt2gAI5yfA2sucrOo/MfQuM49Q+RNUNcfVlKDp6mXY7Pzt8FiDPa6HCDCcvko
         vEN2UbhPOQO7d10R6rlla77DkRTIGFQRoWmeO+exUfqAoNIN57I34/bgNmjVgL2D6x
         Rl/JursclME7xtm2PIL8o4cIN1ljQAB1aOjKHN5xA8UUjobeZuS87Z2ZqPo8RNLdsS
         srRFTHbTAxd6mD/1hWbZD6rQrNzpvEjkwhPpU7JYwOa9KZ9rhOWwYv/ZJxG/PB3SH2
         hynBsnCqAPVIg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32AD640513; Thu,  4 Feb 2021 19:07:41 -0300 (-03)
Date:   Thu, 4 Feb 2021 19:07:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     dwarves@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
Message-ID: <20210204220741.GA920417@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
 
	The v1.20 release of pahole and its friends is out, mostly
addressing problems related to gcc 11 defaulting to DWARF5 for -g,
available at the usual places:

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.sign

Best Regards,
 
 - Arnaldo

v1.20:

BTF encoder:

  - Improve ELF error reporting using elf_errmsg(elf_errno()).

  - Improve objcopy error handling.

  - Fix handling of 'restrict' qualifier, that was being treated as a 'const'.

  - Support SHN_XINDEX in st_shndx symbol indexes, to handle ELF objects with
    more than 65534 sections, for instance, which happens with kernels built
    with 'KCFLAGS="-ffunction-sections -fdata-sections", Other cases may
    include when using FG-ASLR, LTO.

  - Cope with functions without a name, as seen sometimes when building kernel
    images with some versions of clang, when a SEGFAULT was taking place.

  - Fix BTF variable generation for kernel modules, not skipping variables at
    offset zero.

  - Fix address size to match what is in the ELF file being processed, to fix using
    a 64-bit pahole binary to generate BTF for a 32-bit vmlinux image.

  - Use kernel module ftrace addresses when finding which functions to encode,
    which increases the number of functions encoded.

libbpf:

  - Allow use of packaged version, for distros wanting to dynamically link with
    the system's libbpf package instead of using the libbpf git submodule shipped
    in pahole's source code.

DWARF loader:

  - Support DW_AT_data_bit_offset

    This appeared in DWARF4 but is supported only in gcc's -gdwarf-5,
    support it in a way that makes the output be the same for both cases.

      $ gcc -gdwarf-5 -c examples/dwarf5/bf.c
      $ pahole bf.o
      struct pea {
            long int                   a:1;                  /*     0: 0  8 */
            long int                   b:1;                  /*     0: 1  8 */
            long int                   c:1;                  /*     0: 2  8 */

            /* XXX 29 bits hole, try to pack */
            /* Bitfield combined with next fields */

            int                        after_bitfield;       /*     4     4 */

            /* size: 8, cachelines: 1, members: 4 */
            /* sum members: 4 */
            /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
            /* last cacheline: 8 bytes */
      };

  - DW_FORM_implicit_const in attr_numeric() and attr_offset()

  - Support DW_TAG_GNU_call_site, its the standardized rename of the previously supported
    DW_TAG_GNU_call_site.

build:

    - Fix compilation on 32-bit architectures.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
