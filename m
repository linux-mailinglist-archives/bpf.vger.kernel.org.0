Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95269BA3F
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 14:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBRNYL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Feb 2023 08:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRNYL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 08:24:11 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C1718AA3
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 05:24:09 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id z4so749710lji.0
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 05:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yU4uGnu7P7zmeS88qmw1g4vYjPV5LiU1lCPavbtOIFo=;
        b=aHpXn+IpYyhfXaKx8J4Ch3TILJScF79D1V57WVV40wQnmMNCqAbl4xTn9s93+5WGSP
         VqYwbnoR0MdqQYK0Tsz7woIrMgtZYp8FPLDoV9WNJhxYgXiPPmtB+6wGt2yRzmxkrvp9
         srdlC42bucFMnoUABeW/1XgU9Q9RAl/TfwnQYkFrsZXU+K0p0B2dtN2cv/NExi91DNm9
         mE82/zSqjrAxTCMqE9ZOt5K1hcyEVctoNvGDSRHgtysjpPxgpjYEwKs+CyAVPu+eAv7M
         0LPEuZWSeJ6f6N9Z4zzozmlwjoHE+6IpGK+GsfwZT+g37RbJpo5ynAbsZ/0IHdOKhRs7
         cKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yU4uGnu7P7zmeS88qmw1g4vYjPV5LiU1lCPavbtOIFo=;
        b=P0rVR+851qy+acoG5sON5hf9Qaf9K9RVGWj15iMUjxXvHknBGsMFyID2DMK8ZgVh1k
         NcOzcZTyfQc/AKgD4u9I9HwnrMKSLDAtnxmd6XU1JXm9VA7KQ1qa1qWVtcf20LvaXDBy
         saT3HINdQXQw2KcJB7C09dZ54UfwsSiH9q8St8MuU+c85zupKJ6geyZset3DW4tYkREV
         SJR60m7DAwWlWnX+ggHzStBOa8O/8mlJJBWFLC6mlxvEmrdSmxS4lqQXKIf90A3MlE9h
         meEs/P4n3qYinx1K0IZfVTMxow27W/rgqaI3ZEeYeaIGvZ4m1cKBZ0x8yyX3jL57NDe+
         hhsQ==
X-Gm-Message-State: AO0yUKU2e7Owwy8wz5vauBLNn/OhYg2+lYfHS85RDsg2fTSYJn4YMkts
        TzgQdLYtEHYJfuGRfFAdZNCI/LeRoIhgM9YY3pEUFBajO9LQ2YGV
X-Google-Smtp-Source: AK7set/NuEWLcg6vqSnvHpgRr6Ig+HCLfjSCcakJRpJgz5Ghlww+r6OzYBnHZp903YSzvG6yDdtVaC4ALBKcxbHajy0=
X-Received: by 2002:a05:651c:1a06:b0:293:7477:97bd with SMTP id
 by6-20020a05651c1a0600b00293747797bdmr89348ljb.3.1676726647905; Sat, 18 Feb
 2023 05:24:07 -0800 (PST)
MIME-Version: 1.0
References: <CANk7y0joRFw2F4iAuN9r-dWWMvOmbFZz_J4rhGhgVFjdnxPTYw@mail.gmail.com>
 <Y+2J+jIFIxGOW32X@google.com> <CAEf4BzaQJfB0Qh2Wn5wd9H0ZSURbzWBfKkav8xbkhozqTWXndw@mail.gmail.com>
 <CANk7y0iKQX7BdGabDgHmTa=BXc_WCh3rkh5xjqJqc56FJs-QUA@mail.gmail.com> <CAEf4BzbHZ3mJT7sMhAGjfEjENjgMT+vForcKr1d+75yUkme+Tw@mail.gmail.com>
In-Reply-To: <CAEf4BzbHZ3mJT7sMhAGjfEjENjgMT+vForcKr1d+75yUkme+Tw@mail.gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Sat, 18 Feb 2023 14:23:56 +0100
Message-ID: <CANk7y0hJc=--b8eV4d6nmjAThuv1njvTtbzpvpp_UmPB6R=6ag@mail.gmail.com>
Subject: Re: [RFC] libbbpf/bpftool: Support 32-bit Architectures.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 17, 2023 at 10:46 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Feb 17, 2023 at 2:25 AM Puranjay Mohan <puranjay12@gmail.com> wro=
te:
> >
> > Hi,
> > Thanks for the response.
> >
> > On Thu, Feb 16, 2023 at 11:13 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Feb 15, 2023 at 5:48 PM Stanislav Fomichev <sdf@google.com> w=
rote:
> > > >
> > > > On 02/15, Puranjay Mohan wrote:
> > > > > The BPF selftests fail to compile on 32-bit architectures as the =
skeleton
> > > > > generated by bpftool doesn=E2=80=99t take into consideration the =
size difference
> > > > > of
> > > > > variables on 32-bit/64-bit architectures.
> > > >
> > > > > As an example,
> > > > > If a bpf program has a global variable of type: long, its skeleto=
n will
> > > > > include
> > > > > a bss map that will have a field for this variable. The long vari=
able in
> > > > > BPF is
> > > > > 64-bit. if we are working on a 32-bit machine, the generated skel=
eton has
> > > > > to
> > > > > compile for that machine where long is 32-bit.
> > > >
> > > > > A reproducer for this issue:
> > > > >          root@56ec59aa632f:~# cat test.bpf.c
> > > > >          long var;
> > > >
> > > > >          root@56ec59aa632f:~# clang -target bpf -g -c test.bpf.c
> > > >
> > > > >          root@56ec59aa632f:~# bpftool btf dump file test.bpf.o fo=
rmat raw
> > > > >          [1] INT 'long int' size=3D8 bits_offset=3D0 nr_bits=3D64=
 encoding=3DSIGNED
> > > > >          [2] VAR 'var' type_id=3D1, linkage=3Dglobal
> > > > >          [3] DATASEC '.bss' size=3D0 vlen=3D1
> > > > >                 type_id=3D2 offset=3D0 size=3D8 (VAR 'var')
> > > >
> > > > >         root@56ec59aa632f:~# bpftool gen skeleton test.bpf.o > sk=
eleton.h
> > > >
> > > > >         root@56ec59aa632f:~# echo "#include \"skeleton.h\"" > tes=
t.c
> > > >
> > > > >         root@56ec59aa632f:~# gcc test.c
> > > > >         In file included from test.c:1:
> > > > >         skeleton.h: In function 'test_bpf__assert':
> > > > >         skeleton.h:231:2: error: static assertion failed: "unexpe=
cted
> > > > > size of \'var\'"
> > > > >           231 |  _Static_assert(sizeof(s->bss->var) =3D=3D 8, "un=
expected
> > > > > size of 'var'");
> > > > >                  |  ^~~~~~~~~~~~~~
> > > >
> > > > > One naive solution for this would be to map =E2=80=98long=E2=80=
=99 to =E2=80=98long long=E2=80=99 and
> > > > > =E2=80=98unsigned long=E2=80=99 to =E2=80=98unsigned long long=E2=
=80=99. But this doesn=E2=80=99t solve everything
> > > > > because this problem is also seen with pointers that are 64-bit i=
n BPF and
> > > > > 32-bit in 32-bit machines.
> > > >
> > > > > I want to work on solving this and am looking for ideas to solve =
it
> > > > > efficiently.
> > > > > The main goal is to make libbbpf/bpftool host architecture agnost=
ic.
> > > >
> > > > Looks like bpftool needs to be aware of the target architecture. Th=
e
> > > > same way gcc is doing with build-host-target triplet. I don't
> > > > think this can be solved with a bunch of typedefs? But I've long
> > > > forgotten how a pure 32-bit machine looks, so I can't give any
> > > > useful input :-(
> > >
> > > Yeah, I'd rather avoid making bpftool aware of target architecture.
> > > Three is 32 vs 64 bitness, there is also little/big endianness, etc.
> > >
> > > So I'd recommend never using "long" (and similar types that depend on
> > > bitness of the platform, like size_t, etc) for global variables. Also
> > > don't use pointer types as types of the variable. Stick to __u64,
> > > __u32, etc.
> >
> > I feel if we follow. this convention then it will work out but
> > currently a lot of selftests use these
> > architecture dependent variable types and therefore don't even compile
> > for 32-bit architectures
> > because of the _Static_asserts in the skeleton.
> >
> > Do you suggest replacing all these with __u64, __u32, etc. in the
> > selftests so that they compile on every architecture?
>
> how many changes are we talking about? my initial reaction is that
> yeah, if this matters for correctness, we should be strict with __u64
> and __u32 use over long

I can try to compile the selftests on arm32 and count the number of failure=
s.
It is important for correctness but also for testing the support of
BPF on non-64 bit
architectures. If the selftests don't even compile we can't test BPF proper=
ly.

>
> >
> > >
> > > Note that all this is irrelevant for static global variables, as they
> > > are not exposed in the BPF skeleton.
> > >
> > > In general, mixing 32-bit host architecture with (always) 64-bit BPF
> > > architecture always requires more care. And BPF skeleton is just one
> > > aspect of this.
> > >
> > > >
> > > >
> > > > > Thanks,
> > > > > Puranjay Mohan.
> >
> >
> >
> > --
> > Thanks and Regards
> >
> > Yours Truly,
> >
> > Puranjay Mohan



--=20
Thanks and Regards

Yours Truly,

Puranjay Mohan
