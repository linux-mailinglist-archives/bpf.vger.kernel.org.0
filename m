Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6031290A
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 03:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBHCpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Feb 2021 21:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHCpr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Feb 2021 21:45:47 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1979AC06174A;
        Sun,  7 Feb 2021 18:45:07 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id u20so13444184iot.9;
        Sun, 07 Feb 2021 18:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=mtjqJol7vTXvy12x0z4hkAgj+mfxoJ3qfBWD1xOomkQ=;
        b=ThbthEM8x/MN0Ii2BGBE7KfrUhIQnLkQjy+HpJ0fAFDuiNjc0fF7PbR88eBhBuMQSP
         uzpYnvxDW8NJ+ZnCzSUR/TSvGCx1kT0M5Jg7ge90GANv31RFpfLQPUWfaXjP9kKcFj75
         RxuGGmCBbV7sNe2JXF3Gzyzqiiv+6BXXGbMJoDKr7wHaVFVRQtPes1EBweHQe+OBoMUl
         1Zk9FlgD5pOOx0R9YwsO4MD7Pt4QHm4j288loRcx79kBjfoSk75dzKrJ0wj3GdNIl9IS
         fxztWLSqM+6FcvcqAboJRkeGMexcUGEUtDiwG7H3LMwnss5p+pVCLCGLFA/38CThnrhX
         qHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=mtjqJol7vTXvy12x0z4hkAgj+mfxoJ3qfBWD1xOomkQ=;
        b=fs906nqtV4VnWigzh6gwpodXGLhFmYB6CnKh2jrv2ADUw+RUa6NNwVG/FjhZW5fVlr
         2z4WYEsDUhXHvjqsON/PBKW3ZGXqfv2p6l93b7Rz1uKSMi259zbytb/TG0m7E5Dl7Y9N
         9t3YT8ieP+94s0KjxS04SCNmfeZsCkdY5OcTV1i1RVXzxoo/SNXwy+VGoHmH8CNJRWr/
         TTQWOViFTohHUawgRGtwFd+7yQwpDZoxEqX9bSfUMMNsxd9+LnyCSsL1hSznks0IMTQN
         /GskTvrYxumKOMCExgzUBirtm9jqEZJROVw5SbmiY8kXhmGm9dK7yu5/tcxVEKo1qCXb
         88Sw==
X-Gm-Message-State: AOAM532qKvOJ3psgoLQFcLEFiEPImcbj5eolANC+rYbKl+qDnmQ3i36z
        3xgsbDSzwjI3708r3Alkjs0vpmC56VvkQbBOu4s=
X-Google-Smtp-Source: ABdhPJwmnoIadfnQ/N1tpZUnigHgJWhIf/n1td9ullFgkxkut+NlLxeHhXQ+tBu9xyEw7AzaESfBwdEacxOQDOOAfxA=
X-Received: by 2002:a05:6602:150a:: with SMTP id g10mr13772834iow.75.1612752306223;
 Sun, 07 Feb 2021 18:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org>
In-Reply-To: <20210204220741.GA920417@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Feb 2021 03:44:54 +0100
Message-ID: <CA+icZUXngJL2WXRyeWDjTyBYbXc0uC0_C69nBH9bq4sr_TAx5g@mail.gmail.com>
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 11:07 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Hi,
>
>         The v1.20 release of pahole and its friends is out, mostly
> addressing problems related to gcc 11 defaulting to DWARF5 for -g,
> available at the usual places:
>
> Main git repo:
>
>    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
>
> Mirror git repo:
>
>    https://github.com/acmel/dwarves.git
>
> tarball + gpg signature:
>
>    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.xz
>    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.bz2
>    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.sign
>

FYI:
Debian now ships dwarves package version 1.20-1 in unstable.

Just a small nit to this release and its tagging:

You did:
commit 0d415f68c468b77c5bf8e71965cd08c6efd25fc4 ("pahole: Prep 1.20")

Is this new?

The release before:
commit dd15aa4b0a6421295cbb7c3913429142fef8abe0 ("dwarves: Prep v1.19")

- Sedat -

> Best Regards,
>
>  - Arnaldo
>
> v1.20:
>
> BTF encoder:
>
>   - Improve ELF error reporting using elf_errmsg(elf_errno()).
>
>   - Improve objcopy error handling.
>
>   - Fix handling of 'restrict' qualifier, that was being treated as a 'const'.
>
>   - Support SHN_XINDEX in st_shndx symbol indexes, to handle ELF objects with
>     more than 65534 sections, for instance, which happens with kernels built
>     with 'KCFLAGS="-ffunction-sections -fdata-sections", Other cases may
>     include when using FG-ASLR, LTO.
>
>   - Cope with functions without a name, as seen sometimes when building kernel
>     images with some versions of clang, when a SEGFAULT was taking place.
>
>   - Fix BTF variable generation for kernel modules, not skipping variables at
>     offset zero.
>
>   - Fix address size to match what is in the ELF file being processed, to fix using
>     a 64-bit pahole binary to generate BTF for a 32-bit vmlinux image.
>
>   - Use kernel module ftrace addresses when finding which functions to encode,
>     which increases the number of functions encoded.
>
> libbpf:
>
>   - Allow use of packaged version, for distros wanting to dynamically link with
>     the system's libbpf package instead of using the libbpf git submodule shipped
>     in pahole's source code.
>
> DWARF loader:
>
>   - Support DW_AT_data_bit_offset
>
>     This appeared in DWARF4 but is supported only in gcc's -gdwarf-5,
>     support it in a way that makes the output be the same for both cases.
>
>       $ gcc -gdwarf-5 -c examples/dwarf5/bf.c
>       $ pahole bf.o
>       struct pea {
>             long int                   a:1;                  /*     0: 0  8 */
>             long int                   b:1;                  /*     0: 1  8 */
>             long int                   c:1;                  /*     0: 2  8 */
>
>             /* XXX 29 bits hole, try to pack */
>             /* Bitfield combined with next fields */
>
>             int                        after_bitfield;       /*     4     4 */
>
>             /* size: 8, cachelines: 1, members: 4 */
>             /* sum members: 4 */
>             /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
>             /* last cacheline: 8 bytes */
>       };
>
>   - DW_FORM_implicit_const in attr_numeric() and attr_offset()
>
>   - Support DW_TAG_GNU_call_site, its the standardized rename of the previously supported
>     DW_TAG_GNU_call_site.
>
> build:
>
>     - Fix compilation on 32-bit architectures.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
