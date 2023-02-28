Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100486A52FC
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 07:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjB1GcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 01:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1GcK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 01:32:10 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B45A2057D
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 22:32:09 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o15so33041503edr.13
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 22:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgFrBwwqgUdV1wCq36h80DryTRCL54ndV9Tm0lapons=;
        b=GvwKC8uy8mXGHJiK1xOBBm4H16olGtIif7UQ/xzs2gGT7hCnj+VmlwiI6FvgfzsmKX
         GKs/cUM/k9EJysCiKzc4iFPiq4GsMZbE5vtD4h1RF+ZXScp0Ol3dtlyWYCnQY7S4wIp4
         UUdTmqUu2vfzhJ4ZyVgXao+ZbP/PSuYxnQIal/GvfipT+UARAp4wWpUzOG8qXiYQF4gK
         UENNOampy3bthn5shiQlYCJ/0TYjpgHJCirLvHXx2zR0Dtfvj3RWwO+6TEMnpYXCnyI6
         Apdtyh/20M20BMAk7fgHbJ+2eEpndmEkvT50W76rv09MW8rOfJCgCEet53ldeyVqo/EV
         kvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgFrBwwqgUdV1wCq36h80DryTRCL54ndV9Tm0lapons=;
        b=6zGOfX0tP6wvoUJIowqtwGpAXaIufSyULdfmH5b5BGn5GAjGt2KdJvE3UbgPc0asVe
         M8RSqBd9td3Y1klQcWC4ZTMq5RdfKbmFZykOyp5GY9WSP+oSKM4eYL58m9JZnSehmMB5
         DswhdhoB2woSLuOPjPqd88VE1lZZN7vhiMctBgLCVPIrsZ18mPdMOZXRN2KuINUEtiIw
         TFVrAfMY3H+6JLnq5bn/0iNzqUAQbZebi0SPvSzEECzZI6/YtNPDoXeWI946U1KMGJ/Z
         uS/1VjZVNW2Qb0wAlpNJOaxr0303pJERFXdV6sNfp5QbDAvgxx/582vA1KpYgkarMjRA
         rAFQ==
X-Gm-Message-State: AO0yUKUk+yHjl40Ko8ttMI1g8qWx+icJinB6Gmsc5f/PfRVYpbHa62/n
        T/xTBUmamw2HEDVy9eAZytxTvu/OxDxWlMucFuc=
X-Google-Smtp-Source: AK7set9Bd0z6VQEWEl5qj7hy6N5aqxhdVKd7FSE4sXP3S9FnyJzDlqPIE67sdtPZhIoM8rgkOUvLFUKsbrOuOw1ykCM=
X-Received: by 2002:a17:906:c2d5:b0:8b1:79ef:6923 with SMTP id
 ch21-20020a170906c2d500b008b179ef6923mr620153ejb.15.1677565927365; Mon, 27
 Feb 2023 22:32:07 -0800 (PST)
MIME-Version: 1.0
References: <CANk7y0joRFw2F4iAuN9r-dWWMvOmbFZz_J4rhGhgVFjdnxPTYw@mail.gmail.com>
 <Y+2J+jIFIxGOW32X@google.com> <CAEf4BzaQJfB0Qh2Wn5wd9H0ZSURbzWBfKkav8xbkhozqTWXndw@mail.gmail.com>
 <CANk7y0iKQX7BdGabDgHmTa=BXc_WCh3rkh5xjqJqc56FJs-QUA@mail.gmail.com>
 <33f48f89-15d0-58a7-b5ce-a934f4379166@isovalent.com> <CAEf4BzYutCfUPgPk-DDDGFd9Uue6Dm5ymZ=GTpHokN6JM+_mxA@mail.gmail.com>
 <f0c40278-6355-1e35-cfca-fc28cc791a91@isovalent.com>
In-Reply-To: <f0c40278-6355-1e35-cfca-fc28cc791a91@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 22:31:55 -0800
Message-ID: <CAEf4BzbjkD-+JqDJ68Qp+GBOx0xxzeNt0GG33b_wTu5u+zNyBA@mail.gmail.com>
Subject: Re: [RFC] libbbpf/bpftool: Support 32-bit Architectures.
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 3:28=E2=80=AFAM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-02-17 13:56 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Fri, Feb 17, 2023 at 3:59 AM Quentin Monnet <quentin@isovalent.com> =
wrote:
> >>
> >> 2023-02-17 11:25 UTC+0100 ~ Puranjay Mohan <puranjay12@gmail.com>
> >>> Hi,
> >>> Thanks for the response.
> >>>
> >>> On Thu, Feb 16, 2023 at 11:13 PM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>>
> >>>> On Wed, Feb 15, 2023 at 5:48 PM Stanislav Fomichev <sdf@google.com> =
wrote:
> >>>>>
> >>>>> On 02/15, Puranjay Mohan wrote:
> >>>>>> The BPF selftests fail to compile on 32-bit architectures as the s=
keleton
> >>>>>> generated by bpftool doesn=E2=80=99t take into consideration the s=
ize difference
> >>>>>> of
> >>>>>> variables on 32-bit/64-bit architectures.
> >>>>>
> >>>>>> As an example,
> >>>>>> If a bpf program has a global variable of type: long, its skeleton=
 will
> >>>>>> include
> >>>>>> a bss map that will have a field for this variable. The long varia=
ble in
> >>>>>> BPF is
> >>>>>> 64-bit. if we are working on a 32-bit machine, the generated skele=
ton has
> >>>>>> to
> >>>>>> compile for that machine where long is 32-bit.
> >>>>>
> >>>>>> A reproducer for this issue:
> >>>>>>          root@56ec59aa632f:~# cat test.bpf.c
> >>>>>>          long var;
> >>>>>
> >>>>>>          root@56ec59aa632f:~# clang -target bpf -g -c test.bpf.c
> >>>>>
> >>>>>>          root@56ec59aa632f:~# bpftool btf dump file test.bpf.o for=
mat raw
> >>>>>>          [1] INT 'long int' size=3D8 bits_offset=3D0 nr_bits=3D64 =
encoding=3DSIGNED
> >>>>>>          [2] VAR 'var' type_id=3D1, linkage=3Dglobal
> >>>>>>          [3] DATASEC '.bss' size=3D0 vlen=3D1
> >>>>>>                 type_id=3D2 offset=3D0 size=3D8 (VAR 'var')
> >>>>>
> >>>>>>         root@56ec59aa632f:~# bpftool gen skeleton test.bpf.o > ske=
leton.h
> >>>>>
> >>>>>>         root@56ec59aa632f:~# echo "#include \"skeleton.h\"" > test=
.c
> >>>>>
> >>>>>>         root@56ec59aa632f:~# gcc test.c
> >>>>>>         In file included from test.c:1:
> >>>>>>         skeleton.h: In function 'test_bpf__assert':
> >>>>>>         skeleton.h:231:2: error: static assertion failed: "unexpec=
ted
> >>>>>> size of \'var\'"
> >>>>>>           231 |  _Static_assert(sizeof(s->bss->var) =3D=3D 8, "une=
xpected
> >>>>>> size of 'var'");
> >>>>>>                  |  ^~~~~~~~~~~~~~
> >>>>>
> >>>>>> One naive solution for this would be to map =E2=80=98long=E2=80=99=
 to =E2=80=98long long=E2=80=99 and
> >>>>>> =E2=80=98unsigned long=E2=80=99 to =E2=80=98unsigned long long=E2=
=80=99. But this doesn=E2=80=99t solve everything
> >>>>>> because this problem is also seen with pointers that are 64-bit in=
 BPF and
> >>>>>> 32-bit in 32-bit machines.
> >>>>>
> >>>>>> I want to work on solving this and am looking for ideas to solve i=
t
> >>>>>> efficiently.
> >>>>>> The main goal is to make libbbpf/bpftool host architecture agnosti=
c.
> >>>>>
> >>>>> Looks like bpftool needs to be aware of the target architecture. Th=
e
> >>>>> same way gcc is doing with build-host-target triplet. I don't
> >>>>> think this can be solved with a bunch of typedefs? But I've long
> >>>>> forgotten how a pure 32-bit machine looks, so I can't give any
> >>>>> useful input :-(
> >>>>
> >>>> Yeah, I'd rather avoid making bpftool aware of target architecture.
> >>>> Three is 32 vs 64 bitness, there is also little/big endianness, etc.
> >>
> >> I'd rather avoid that too, but for addressing the endianness issue wit=
h
> >> cross-compiling, reported by Christophe and where the bytecode is not
> >> stored with the right endianness in the skeleton file, do you see an
> >> alternative?
> >
> > So bytecode is just a byte array, by itself endianness shouldn't
> > matter. The contents of it (ELF itself) is supposed to be of correct
> > target endianness, though, right? Or what problem we are talking about
> > here? Can you please summarize?
>
> TL;DR: When cross-compiling, host little-endian bootstrap bpftool cannot
> open a big-endian ELF to generate a skeleton from it and build target
> big-endian bpftool.
>
> Long version: Currently, bpftool's Makefile compiles the
> skeleton-related programs (skeletons/*.bpf.c) without paying attention
> to the target architecture. When cross-compiling, say on a host with LE
> for a target with BE, this leads to runtime failure on "bpftool prog
> show", because bpftool cannot load the LE bytecode on the BE target
> machine. This is Christophe's output in [0].
>
> So the first fix is to make the Makefile aware of the target endianness
> somehow, and to build this ELF with target endianness. But this is not
> enough, because when (host) boostrap bpftool opens the ELF to generate
> the skeleton from it before building the final (target) bpftool binary,
> then bpf_object__check_endianness() in libbpf refuses to open the ELF if
> endianness is not the same as on the host [1].
>
> The way I see it, we'd need to make sure libbpf can work with ELFs of a
> different endianness -- assuming that's doable -- and to pass it an
> option to tell whether LE or BE is expected for a given ELF. Which in
> turn would require bootstrap bpftool to be aware of the target
> endianness. Or do you see a simpler way?

I don't. We might not need to instruct libbpf what endianness should
be expected, we can just say that BPF object file with wrong
endianness can't be loaded, but could be introspected. So
bpf_object__open() should succeed, all the getters and stuff as well.
But bpf_object__load() will fail. We already support opening BTF of
non-native endianness, that wasn't too bad to support. I'm not sure
how much work and extra logic would be necessary for similar
cross-endianness support in ELF processing code, though.

>
>
> [0]
> https://lore.kernel.org/bpf/0792068b-9aff-d658-5c7d-086e6d394c6c@csgroup.=
eu/
> [1]
> https://lore.kernel.org/bpf/21b09e52-142d-92f5-4f8b-e4190f89383b@csgroup.=
eu/
