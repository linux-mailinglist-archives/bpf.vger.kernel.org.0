Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC94A2AA0
	for <lists+bpf@lfdr.de>; Sat, 29 Jan 2022 01:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiA2Agg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 19:36:36 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58332 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiA2Agg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 19:36:36 -0500
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id E707620B8010;
        Fri, 28 Jan 2022 16:36:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E707620B8010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1643416595;
        bh=J5hHj/dx23so3IxDHwT/MEE38qNMldGDsBDJbZWzMuI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DIzmeTE//T4QPJlvda5dJgcz5067BjdRLHBzq7nBxOi7CJxO8WL8sd49RAEt4W77y
         3b7szVzDoCkpWB+ZWHJYrh9T/AdU4DLX3duNVHqGJmkN95KyhlZ62mWNcjXP3pvNOf
         wTR6yffucvl8oFCM8fDprbtW5i94b0PPkspWHQkE=
Received: by mail-pg1-f182.google.com with SMTP id t32so6670074pgm.7;
        Fri, 28 Jan 2022 16:36:35 -0800 (PST)
X-Gm-Message-State: AOAM533zMndws+4tkMmmZkQB4j4sFE6F3k+gkq3G84LURFLQgcqxYhUk
        rgU6339e1RCtbHz41NFt7bDuM+NgwNCj2KcOI9M=
X-Google-Smtp-Source: ABdhPJz+yMH8XVHa0HI6zjz0tpcPbMSW6aHedHYPtjoaizEr1bRo1kq1BmO9chZiqEPiwj94mb7g+Pdix4X1XIQ1sBg=
X-Received: by 2002:a63:5146:: with SMTP id r6mr8357669pgl.455.1643416595340;
 Fri, 28 Jan 2022 16:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
 <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
 <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
 <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
 <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com>
 <177da568-8410-36d6-5f95-c5792ba47d62@fb.com> <CAADnVQJZvgpo-VjUCBL8YZy8J+s7O0mv5FW+5sx8NK84Lm6FUQ@mail.gmail.com>
 <CAFnufp3ybOFMY=ObZFvbmr+c70CPUrL2uYp1oZQmffQBTyVy_A@mail.gmail.com> <CAADnVQ+cvD2rwa-hRQP8agj8=SXuun3dv-PZpK5=kJ2Ea_0KCg@mail.gmail.com>
In-Reply-To: <CAADnVQ+cvD2rwa-hRQP8agj8=SXuun3dv-PZpK5=kJ2Ea_0KCg@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sat, 29 Jan 2022 01:35:59 +0100
X-Gmail-Original-Message-ID: <CAFnufp3MHW9su8pouUqg__DToSHEx=HZccrpR49hSdsuEnpW0g@mail.gmail.com>
Message-ID: <CAFnufp3MHW9su8pouUqg__DToSHEx=HZccrpR49hSdsuEnpW0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 9:09 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 28, 2022 at 10:51 AM Matteo Croce
> <mcroce@linux.microsoft.com> wrote:
> >
> > On Fri, Jan 28, 2022 at 6:31 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Dec 20, 2021 at 10:34 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > >
> > > > https://reviews.llvm.org/D116063 improved the error message as below
> > > > to make it a little bit more evident what is the problem:
> > > >
> > > > $ clang -target bpf -O2 -g -c bug.c
> > > >
> > > > fatal error: error in backend: SubroutineType not supported for
> > > > BTF_TYPE_ID_REMOTE reloc
> > >
> > > Hi Matteo,
> > >
> > > Are you still working on a test?
> > > What's a timeline to repost the patch set?
> > >
> > > Thanks!
> >
> > Hi Alexei,
> >
> > The change itself is ready, I'm just stuck at writing a test which
> > will effectively calls __bpf_core_types_are_compat() with some
> > recursion.
> > I guess that I have to generate a BTF_KIND_FUNC_PROTO type somehow, so
> > __bpf_core_types_are_compat() is called again to check the prototipe
> > arguments type.
> > I tried with these two, with no luck:
> >
> > // 1
> > typedef int (*func_proto_typedef)(struct sk_buff *);
> > bpf_core_type_exists(func_proto_typedef);
> >
> > // 2
> > void func_proto(int, unsigned int);
> > bpf_core_type_id_kernel(func_proto);
> >
> > Which is a simple way to generate a BTF_KIND_FUNC_PROTO BTF field?
>
> What do you mean 'no luck'?
> Have you tried what progs/test_core_reloc_type_id.c is doing?
> typedef int (*func_proto_typedef)(long);
> bpf_core_type_id_kernel(func_proto_typedef);
>
> Without macros:
> typedef int (*func_proto_typedef)(long);
>
> int test() {
>    return __builtin_btf_type_id(*(typeof(func_proto_typedef) *)0, 1);
> }
> int test2() {
>    return __builtin_preserve_type_info(*(typeof(func_proto_typedef) *)0, 0);
> }
>
>
> compiles fine and generates relos.

Yes, I tried that one.
We reach bpf_core_apply_relo_insn() but not bpf_core_spec_match(),
since cands->len is 0.

[   16.424821] bpf_core_apply_relo_insn:1202 cands->len: 0

That's a very simple raw_tracepoint/sys_enter program:

-- 
per aspera ad upstream
