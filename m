Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E9C30FFEE
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 23:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBDWLG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 17:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhBDWLG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 17:11:06 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0CC0613D6;
        Thu,  4 Feb 2021 14:10:24 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id m20so4052353ilj.13;
        Thu, 04 Feb 2021 14:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UoK/jNgPexifBCsM5TeU8UemDOf1tGSYf8Mxoq9PzCc=;
        b=rill+UGqgq8KXJP+c9/01HDIsyhurADO3vJsaJwKFLTkNwQt1JeyQ5j12JfSEsBbYn
         Dv3RerOOmgzj5OOytRBLIJVr4iLfMGATbcRlc88+IpD35NUZnrdx++11SZrwnMN9WcnW
         JN5v1MQBa7eq3vuC9BRbBagxO3CIEdBqx5hL7RUIa+GjHAgTGZOq1Pvsprit07sQLVzn
         LKZqtakYEQ7lVZSr4nj9L2cgCiFUG2SETBqBKxJPdcirjkXstPtDdKODRv08ydmQsKKU
         uHoDkE/BE5INEwXxzRpjzoUTaaRcLsn0LQ9HbDeCTYwvSjSrWB9u6AT7NbIVhw77tlHx
         bVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UoK/jNgPexifBCsM5TeU8UemDOf1tGSYf8Mxoq9PzCc=;
        b=eISIzN2N9824+KPR2vmkeOipPdkwUrf5/TQmjUItLLyUQUr0BmRSxMrYxOjtKtETcR
         tkddsV4zunFly8quRWYXb5ilBkrMsEYK+0J/pydbWDp3TZA4uDQ5Z68WkKXryuZbQKPm
         +U1yGcvhoWjRE2i1rAE204piodhfWr2y9HbMUqZf2M88/BxCDjG8HSEYX5DWD6HYf9Kg
         3NSMWw6EcpeQiFsVi3GlBdV4Ar8XYyV652f6sUs6sX/+Cq/vfjgoahcQyPZp0wECV7uQ
         B1ggpBI0kidgFfA6/GXbWWbXXdJhmtDfuGvnhHLatmuvlIl2UhG2y5pq+OxG0OHtxA5h
         SiFg==
X-Gm-Message-State: AOAM532aBaO6Kf4ZZLFeRC1hUQspPPMM02bFisaJQFN/mfLZwEjN5xDY
        bvOQzKY869HxvyhVyosSBonxFlhMXa2rIW8YfaLKTzyLW7EWeA==
X-Google-Smtp-Source: ABdhPJySOE47p7L2PzNh6iIn+aEoZ2w6m1Cj6R1w8KKmUUooUdb8tWcp9p49P9im6qMUC4nhOi6eHpqyH5YYFV9+4Qc=
X-Received: by 2002:a92:ce46:: with SMTP id a6mr1204547ilr.10.1612476624026;
 Thu, 04 Feb 2021 14:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org>
In-Reply-To: <20210204220741.GA920417@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 4 Feb 2021 23:10:12 +0100
Message-ID: <CA+icZUXwtrxbZib+nUD8t4mjqR_4r2nxHb4ob2a1KmaNPeTv2g@mail.gmail.com>
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

Congrats and thanks for v1.20 and to all involved folks.

- Sedat -

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
