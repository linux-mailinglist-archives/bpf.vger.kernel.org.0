Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04F69D1AD
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 17:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjBTQsU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 11:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjBTQsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 11:48:18 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737DDA5C0
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 08:47:58 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f16so1728271ljq.10
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vXQ1MAtDz0lQmOFdI1R2feMe7eGL16MyKvtkqm0kD8=;
        b=V7vubP+GQNFBfCZx/T1JtLQAbzuyrfvhBZnTwyavk7CxI1uKj20THX1W1zEwCeouE4
         TfwFL2o1uESpjD6b7/qmuZijOJMVQQYVJfJ2SJNR6VjeC0IsRYgWdqs8X/XVcp63ayIX
         Um7g2QJyUQ4W/qtztoTnz96riZrjraiuelHCX6eGAJOvHqzPn+Lxdmy5TGxjmwEK1MO1
         PX8s1o38DPbtw94HH4Trl7rxVWSxw02qo2sHbePlUimhioeycwpzFtyiaVymOjLJLFGN
         UYrFDBflSU6aEL9MDE9XGY4J68AixA3Jmla2m+NbYjHjwYcgIOda9ZvoyY/EcyenhhOr
         yyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vXQ1MAtDz0lQmOFdI1R2feMe7eGL16MyKvtkqm0kD8=;
        b=55wzADxnOhL9RzKDkh7bL/tc1QUr814WdgBthpfGVt03PAVmtK6eWhtyW5gU1Zx1KX
         /THfQIgV94YGhlL2MoRe2DaUmbdpoJpy1JUcWGqp+4tu/s72ZwlrANB5CD/CX4YX3zzb
         xx5C6ojBu5NzUJW3uHOF8hGGKS9qS5g/Q7WMhmS1SmnbvHYXR/CXRgdq7G07iV3q2CYW
         lrWLPi+RLKgzyoeqe5xK0JblmQ6dalSElUP30+Li9RgMms5W6Xuu0tifu6LFZ4dk0VcP
         lPZ2hdbsUPVVHpNXl6rjlTszrqNUT9qnI8ljqaJxAHyc4L/9peUSHdny27xQyY46DDV6
         lStg==
X-Gm-Message-State: AO0yUKXOile+Qc9Z9g83jOIUzOlyzyTgPs/O1jimTDST9ohw+o9m0o1B
        zxdufr4xIajGh6ESFjLm37OwnTiIGpMVKnwK7vBN+t39EsKAjhEG
X-Google-Smtp-Source: AK7set/OBr18hqtl4LozHvJ72Uuj75Gr00vsxs/scDaT4ayNuLjzQilvS2XsWLze3Q48PaHrLwUahpYAYQ9mnZcOYlo=
X-Received: by 2002:a05:651c:3de:b0:290:6c1b:d4ff with SMTP id
 f30-20020a05651c03de00b002906c1bd4ffmr842241ljp.10.1676911670612; Mon, 20 Feb
 2023 08:47:50 -0800 (PST)
MIME-Version: 1.0
References: <CANk7y0joRFw2F4iAuN9r-dWWMvOmbFZz_J4rhGhgVFjdnxPTYw@mail.gmail.com>
 <Y+2J+jIFIxGOW32X@google.com> <CAEf4BzaQJfB0Qh2Wn5wd9H0ZSURbzWBfKkav8xbkhozqTWXndw@mail.gmail.com>
 <CANk7y0iKQX7BdGabDgHmTa=BXc_WCh3rkh5xjqJqc56FJs-QUA@mail.gmail.com>
 <CAEf4BzbHZ3mJT7sMhAGjfEjENjgMT+vForcKr1d+75yUkme+Tw@mail.gmail.com>
 <CANk7y0hJc=--b8eV4d6nmjAThuv1njvTtbzpvpp_UmPB6R=6ag@mail.gmail.com> <20230220163029.3c5hv4rzaybt7jlr@heavy>
In-Reply-To: <20230220163029.3c5hv4rzaybt7jlr@heavy>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 20 Feb 2023 17:47:39 +0100
Message-ID: <CANk7y0inf7DHYuXgXXdAX+QLoMqGBx5=2juig8YQprwinRsGxA@mail.gmail.com>
Subject: Re: [RFC] libbbpf/bpftool: Support 32-bit Architectures.
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
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

On Mon, Feb 20, 2023 at 5:30 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Sat, Feb 18, 2023 at 02:23:56PM +0100, Puranjay Mohan wrote:
> > On Fri, Feb 17, 2023 at 10:46 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Feb 17, 2023 at 2:25 AM Puranjay Mohan <puranjay12@gmail.com>=
 wrote:
> > > >
> > > > Hi,
> > > > Thanks for the response.
> > > >
> > > > On Thu, Feb 16, 2023 at 11:13 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 15, 2023 at 5:48 PM Stanislav Fomichev <sdf@google.co=
m> wrote:
> > > > > >
> > > > > > On 02/15, Puranjay Mohan wrote:
> > > > > > > The BPF selftests fail to compile on 32-bit architectures as =
the skeleton
> > > > > > > generated by bpftool doesn=E2=80=99t take into consideration =
the size difference
> > > > > > > of
> > > > > > > variables on 32-bit/64-bit architectures.
> > > > > >
> > > > > > > As an example,
> > > > > > > If a bpf program has a global variable of type: long, its ske=
leton will
> > > > > > > include
> > > > > > > a bss map that will have a field for this variable. The long =
variable in
> > > > > > > BPF is
> > > > > > > 64-bit. if we are working on a 32-bit machine, the generated =
skeleton has
> > > > > > > to
> > > > > > > compile for that machine where long is 32-bit.
> > > > > >
> > > > > > > A reproducer for this issue:
> > > > > > >          root@56ec59aa632f:~# cat test.bpf.c
> > > > > > >          long var;
> > > > > >
> > > > > > >          root@56ec59aa632f:~# clang -target bpf -g -c test.bp=
f.c
> > > > > >
> > > > > > >          root@56ec59aa632f:~# bpftool btf dump file test.bpf.=
o format raw
> > > > > > >          [1] INT 'long int' size=3D8 bits_offset=3D0 nr_bits=
=3D64 encoding=3DSIGNED
> > > > > > >          [2] VAR 'var' type_id=3D1, linkage=3Dglobal
> > > > > > >          [3] DATASEC '.bss' size=3D0 vlen=3D1
> > > > > > >                 type_id=3D2 offset=3D0 size=3D8 (VAR 'var')
> > > > > >
> > > > > > >         root@56ec59aa632f:~# bpftool gen skeleton test.bpf.o =
> skeleton.h
> > > > > >
> > > > > > >         root@56ec59aa632f:~# echo "#include \"skeleton.h\"" >=
 test.c
> > > > > >
> > > > > > >         root@56ec59aa632f:~# gcc test.c
> > > > > > >         In file included from test.c:1:
> > > > > > >         skeleton.h: In function 'test_bpf__assert':
> > > > > > >         skeleton.h:231:2: error: static assertion failed: "un=
expected
> > > > > > > size of \'var\'"
> > > > > > >           231 |  _Static_assert(sizeof(s->bss->var) =3D=3D 8,=
 "unexpected
> > > > > > > size of 'var'");
> > > > > > >                  |  ^~~~~~~~~~~~~~
> > > > > >
> > > > > > > One naive solution for this would be to map =E2=80=98long=E2=
=80=99 to =E2=80=98long long=E2=80=99 and
> > > > > > > =E2=80=98unsigned long=E2=80=99 to =E2=80=98unsigned long lon=
g=E2=80=99. But this doesn=E2=80=99t solve everything
> > > > > > > because this problem is also seen with pointers that are 64-b=
it in BPF and
> > > > > > > 32-bit in 32-bit machines.
> > > > > >
> > > > > > > I want to work on solving this and am looking for ideas to so=
lve it
> > > > > > > efficiently.
> > > > > > > The main goal is to make libbbpf/bpftool host architecture ag=
nostic.
> > > > > >
> > > > > > Looks like bpftool needs to be aware of the target architecture=
. The
> > > > > > same way gcc is doing with build-host-target triplet. I don't
> > > > > > think this can be solved with a bunch of typedefs? But I've lon=
g
> > > > > > forgotten how a pure 32-bit machine looks, so I can't give any
> > > > > > useful input :-(
> > > > >
> > > > > Yeah, I'd rather avoid making bpftool aware of target architectur=
e.
> > > > > Three is 32 vs 64 bitness, there is also little/big endianness, e=
tc.
> > > > >
> > > > > So I'd recommend never using "long" (and similar types that depen=
d on
> > > > > bitness of the platform, like size_t, etc) for global variables. =
Also
> > > > > don't use pointer types as types of the variable. Stick to __u64,
> > > > > __u32, etc.
> > > >
> > > > I feel if we follow. this convention then it will work out but
> > > > currently a lot of selftests use these
> > > > architecture dependent variable types and therefore don't even comp=
ile
> > > > for 32-bit architectures
> > > > because of the _Static_asserts in the skeleton.
> > > >
> > > > Do you suggest replacing all these with __u64, __u32, etc. in the
> > > > selftests so that they compile on every architecture?
> > >
> > > how many changes are we talking about? my initial reaction is that
> > > yeah, if this matters for correctness, we should be strict with __u64
> > > and __u32 use over long
> >
> > I can try to compile the selftests on arm32 and count the number of fai=
lures.
> > It is important for correctness but also for testing the support of
> > BPF on non-64 bit
> > architectures. If the selftests don't even compile we can't test BPF pr=
operly.
>
> Hi,
>
> Does anyone plan looking into fixing selftests on 32-bit arches in the
> near future (i.e. getting rid of longs and pointers)? I have an x86 JIT
> change that I would like to test, and I'm also running into this issue.
> I can try doing this, but I'd like to avoid doing duplicate work.
>

Hi,
I am interested in doing this. I want to make sure that BPF is fully
supported on 32-bit architectures.
This is just a hobby for me but I want to work on this. I also wish to
implement the trampoline for ARM some day.

I will be sending patches soon for this. Currently I am working on a
patch to support usdt for arm in libbpf.

> Best regards,
> Ilya
>
> [...]


--=20
Thanks and Regards

Yours Truly,

Puranjay Mohan
