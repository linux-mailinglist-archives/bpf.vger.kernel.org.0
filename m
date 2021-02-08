Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6002B314161
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 22:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhBHVMk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 16:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBHVMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 16:12:33 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D70C061786;
        Mon,  8 Feb 2021 13:11:53 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e7so14104656ile.7;
        Mon, 08 Feb 2021 13:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qhN+v9SpSshkYffTJiPhZSShJVl7udXDkh1GuM/ARwE=;
        b=MWzyGiXyA6zof3nG47ylATqgN1ct8sFYFbb3z4LPN4VPsctw/l7GHTr5ZJ4mD8xiqA
         u4EotmkUJybl8hcH7vWyjagwajn8kkMEaTm/8oF8lyqGZYDnJWU2es0fmoXR8TsSK8MY
         MC+IvF3mKkMATGDM7N+pcQ5fCanM9PSFGoHu4LyP0EEhaWO7SeDqZG5ETmeJzDZ0HSlw
         nOSanIqTNp/dNx/JsxSFgtx6vv6ERm83aZegUqXKFJSIGXL8nJplmAw940Iz8Mj9nD7S
         g5E5UZbQ0GlNOUVE2C9SFO333ITs8Vl1pNVh807NKcYGiOAYDk5KPX532WHvvH73Y/ul
         l5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qhN+v9SpSshkYffTJiPhZSShJVl7udXDkh1GuM/ARwE=;
        b=ccnJxncoBMRPy6dPVkIZ2iV5Dbr0pYO2q10k2w3O3WZjqiSbjpJ6Ujg6NnxTgEC19t
         fV1CdnuLwmblhg2cEBbGKh7DQ6aybEt6bs+dGka6bLDOFrAbwxzG7UJmoCZKNcifrUHi
         HHSyN7qpNMUKPAhiEW1xi3ODyg+e1nIqP6OWCF+VOYNfNbyjytQYUpXKEnvui+RhzMWs
         7L9IsXS9xQUXWHkQUXqhMvjUD7Qj46QEm71R4ZiOeJf6tDOH2IGgtQXdoxMHrRH/Yc1G
         5H1gK5+SCYUSIWMZmcptiZt5p1/4x2vGHDkeatvXUSx6c7WTZMpnJ3zjSI+hy+tc2aR7
         Eg0w==
X-Gm-Message-State: AOAM530XBxGCBBG72WCqPFW4RYcT2qCr516kLCusCgiTO2rr5jFsaWtV
        FY3HBM7Fn0RPMzUAQ8t1RhzkqWlKqlRHdJC/uUM=
X-Google-Smtp-Source: ABdhPJwuZ1XWrDAWJtCTA40piBLHTj94wPXIRcmgtkmFmqVN8+kq7yUYrfSdshL+pq12ImyOen/jgK3t1rseOmgad2s=
X-Received: by 2002:a92:c5c8:: with SMTP id s8mr17114345ilt.186.1612818712670;
 Mon, 08 Feb 2021 13:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20210207071726.3969978-1-yhs@fb.com> <CA+icZUVwz+OroPfsqtOxAstWGeRxf=KYMUY5LCDPzyPLJFmZmg@mail.gmail.com>
 <20210208195501.GS920417@kernel.org> <CA+icZUWTzrNXfB1FypgrbSneraY+-9LdqJBNdhWSgGCR-2+Ddg@mail.gmail.com>
 <CAEf4Bzb=xx0TZOtOJqYVHGGpHTEbL7X_Ap0oCPVpWutEKLfq3g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb=xx0TZOtOJqYVHGGpHTEbL7X_Ap0oCPVpWutEKLfq3g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Feb 2021 22:11:41 +0100
Message-ID: <CA+icZUWr7ea0UJiTpZULoyGRLHAae+DHj4J5L2wjSjWxeiH1+g@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base type
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Mark Wielaard <mark@klomp.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 10:08 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 8, 2021 at 12:46 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Mon, Feb 8, 2021 at 8:55 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Sun, Feb 07, 2021 at 11:32:00AM +0100, Sedat Dilek escreveu:
> > > > On Sun, Feb 7, 2021 at 8:17 AM Yonghong Song <yhs@fb.com> wrote:
> > > > >
> > > > > clang with dwarf5 may generate non-regular int base type,
> > > > > i.e., not a signed/unsigned char/short/int/longlong/__int128.
> > > > > Such base types are often used to describe
> > > > > how an actual parameter or variable is generated. For example,
> > > > >
> > > > > 0x000015cf:   DW_TAG_base_type
> > > > >                 DW_AT_name      ("DW_ATE_unsigned_1")
> > > > >                 DW_AT_encoding  (DW_ATE_unsigned)
> > > > >                 DW_AT_byte_size (0x00)
> > > > >
> > > > > 0x00010ed9:         DW_TAG_formal_parameter
> > > > >                       DW_AT_location    (DW_OP_lit0,
> > > > >                                          DW_OP_not,
> > > > >                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
> > > > >                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
> > > > >                                          DW_OP_stack_value)
> > > > >                       DW_AT_abstract_origin     (0x00013984 "branch")
> > > > >
> > > > > What it does is with a literal "0", did a "not" operation, and the converted to
> > > > > one-bit unsigned int and then 8-bit unsigned int.
> > > > >
> > > > > Another example,
> > > > >
> > > > > 0x000e97e4:   DW_TAG_base_type
> > > > >                 DW_AT_name      ("DW_ATE_unsigned_24")
> > > > >                 DW_AT_encoding  (DW_ATE_unsigned)
> > > > >                 DW_AT_byte_size (0x03)
> > > > >
> > > > > 0x000f88f8:     DW_TAG_variable
> > > > >                   DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
> > > > >                      [0xffffffff82808812, 0xffffffff82808817):
> > > > >                          DW_OP_breg0 RAX+0,
> > > > >                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > > > >                          DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
> > > > >                          DW_OP_stack_value,
> > > > >                          DW_OP_piece 0x1,
> > > > >                          DW_OP_breg0 RAX+0,
> > > > >                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > > > >                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > > > >                          DW_OP_lit8,
> > > > >                          DW_OP_shr,
> > > > >                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > > > >                          DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
> > > > >                          DW_OP_stack_value,
> > > > >                          DW_OP_piece 0x3
> > > > >                      ......
> > > > >
> > > > > At one point, a right shift by 8 happens and the result is converted to
> > > > > 32-bit unsigned int and then to 24-bit unsigned int.
> > > > >
> > > > > BTF does not need any of these DW_OP_* information and such non-regular int
> > > > > types will cause libbpf to emit errors.
> > > > > Let us sanitize them to generate BTF acceptable to libbpf and kernel.
> > > > >
> > > > > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > > >
> > > > Thanks for v2.
> > > >
> > > > For both v1 and v2:
> > > >
> > > >    Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > >    Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > >
> > > Thanks, applied.
> > >
> >
> > Great.
> > I cannot see it yet in [1] or [2].
> >
> > More important to me is is this worth a pahole v1.20.1 release?
> > This patch is required to successfully build with BTF and DWARF-5 and Clang-12.
> >
> > I have Nathan's "bpf: Hoise pahole version checks into Kconfig" patch
> > in my custom patchset (together with Nick's DWARF-v5 patchset) which
> > makes it easier to do (depends on PAHOLE_VERSION >= 1201) via Kconfig
>
> I don't think the math works out with 1201 vs 121 (in the future), so
> I'd rather prefer 1.21, if necessary.
>

Aaargh, you are right.

# /opt/pahole/bin/pahole --numeric_version
120

The wish is to have a pahole v1.21.

- Sedat -

> > for example.
> >
> > - Sedat -
> >
> > [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> > [2] https://github.com/acmel/dwarves/
> >
> > > - Arnaldo
> > >
> > > > My development and testing environment:
> > > >
> > > > 1. Debian/testing AMD64
> > > > 2. Linux v5.11-rc6+ with custom mostly Clang fixes
> > > > 3. Debug-Info: BTF + DWARF-v5 enabled
> > > > 4. Compiler and tools (incl. Clang's Integrated ASsembler IAS):
> > > > LLVM/Clang v12.0.0-rc1 (make LLVM=1 LLVM_IAS=1)
> > > >
> > > > Build and boot on bare metal.
> > > >
> > > > - Sedat -
> > > >
> > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > > > ---
> > > > >  libbtf.c | 39 ++++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/libbtf.c b/libbtf.c
> > > > > index 9f76283..5843200 100644
> > > > > --- a/libbtf.c
> > > > > +++ b/libbtf.c
> > > > > @@ -373,6 +373,7 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
> > > > >         struct btf *btf = btfe->btf;
> > > > >         const struct btf_type *t;
> > > > >         uint8_t encoding = 0;
> > > > > +       uint16_t byte_sz;
> > > > >         int32_t id;
> > > > >
> > > > >         if (bt->is_signed) {
> > > > > @@ -384,7 +385,43 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
> > > > >                 return -1;
> > > > >         }
> > > > >
> > > > > -       id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), encoding);
> > > > > +       /* dwarf5 may emit DW_ATE_[un]signed_{num} base types where
> > > > > +        * {num} is not power of 2 and may exceed 128. Such attributes
> > > > > +        * are mostly used to record operation for an actual parameter
> > > > > +        * or variable.
> > > > > +        * For example,
> > > > > +        *     DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
> > > > > +        *         [0xffffffff82808812, 0xffffffff82808817):
> > > > > +        *             DW_OP_breg0 RAX+0,
> > > > > +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > > > > +        *             DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
> > > > > +        *             DW_OP_stack_value,
> > > > > +        *             DW_OP_piece 0x1,
> > > > > +        *             DW_OP_breg0 RAX+0,
> > > > > +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> > > > > +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > > > > +        *             DW_OP_lit8,
> > > > > +        *             DW_OP_shr,
> > > > > +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> > > > > +        *             DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
> > > > > +        *             DW_OP_stack_value, DW_OP_piece 0x3
> > > > > +        *     DW_AT_name    ("ebx")
> > > > > +        *     DW_AT_decl_file       ("/linux/arch/x86/events/intel/core.c")
> > > > > +        *
> > > > > +        * In the above example, at some point, one unsigned_32 value
> > > > > +        * is right shifted by 8 and the result is converted to unsigned_32
> > > > > +        * and then unsigned_24.
> > > > > +        *
> > > > > +        * BTF does not need such DW_OP_* information so let us sanitize
> > > > > +        * these non-regular int types to avoid libbpf/kernel complaints.
> > > > > +        */
> > > > > +       byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
> > > > > +       if (!byte_sz || (byte_sz & (byte_sz - 1))) {
> > > > > +               name = "__SANITIZED_FAKE_INT__";
> > > > > +               byte_sz = 4;
> > > > > +       }
> > > > > +
> > > > > +       id = btf__add_int(btf, name, byte_sz, encoding);
> > > > >         if (id < 0) {
> > > > >                 btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error emitting BTF type");
> > > > >         } else {
> > > > > --
> > > > > 2.24.1
> > > > >
> > >
> > > --
> > >
> > > - Arnaldo
