Return-Path: <bpf+bounces-8305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62277784BFA
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932011C20ABB
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1C934CD7;
	Tue, 22 Aug 2023 21:26:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F262018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:26:22 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E6E40
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:26:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so12295438a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692739578; x=1693344378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32tFknpYUltGX7BrfzpOF/XJEJkxSlIebbE3WJkd8PM=;
        b=7AkQbKGj7c2iyU1W1VleqR2BeJQxs9NQg4Dm4uTnHgD0my3qkctcx7KwwqdM17qsAG
         tL3hMHIxigb2XVJGm1XzIcPBfVamX7KeRvrLHAtKdleDm6KUtL+rxHo0R+f2WRBPsiHS
         yOR0jmYmcdpVcxe8AXGWkldfDIIjuFItsUpHs9dF8x6PG2sd9tDFnEYswintcvIb2REK
         WjI/9McRGQDEze9QncuOg2aWiECZ9Gq8lKKBLrlxA5jb2hup3Nfr5pGBbrOZVNlIfacr
         UXbl3v5rxMaYDIiB0pdyoWvxdN25vilG09QK6kdBb3wLSI+BVNTZJS/XUPSWdLSJRXdY
         N/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739578; x=1693344378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32tFknpYUltGX7BrfzpOF/XJEJkxSlIebbE3WJkd8PM=;
        b=G/PwZRTCb2/jMbQ+uE2eJDxzMymYUniBhyEwWWBSbGa4JG8IymrrYXHHTbHispQbMG
         BhSGfZ68I4mUrrWIbbxRMeljZeuh1WZEBN5FDM/xXDaE3w27+iRV77RbjV8YnwXCbeA8
         98Wq1meolH9wQaU/AQGyHYRkgr0GbYNycEafdQlWGoeRctixOs4Mj/EXtDNGPOymdPav
         76Cxo4apeJRu+/sfEQUVEht7zW1/hoLkoTEUnBfz9zLoADI2OEA5WJDqniA+fiRw6fEU
         7pVzHgxk4uggRDxaHpns1s9TtQQXe8U4ezEgiG7qZnqUAzGHjQbzyVr9OTvZCgoNTRCC
         CoRg==
X-Gm-Message-State: AOJu0Yxu8BjkIER7ZyVaDktIeO+UcJqHJWdXZunkRMaKyJ13xUk1JQvs
	0Z+8ieYrmJBQsk3ocUc3yF2AxoqsBzQs1Px7UXUZhQ==
X-Google-Smtp-Source: AGHT+IEWAA9h4kEyYMlZHbSoVul6EaKjAtvHTpIGULLsioKqmRhgMN2F6THcR1biYGczo4vK53pCZCjRO/rt5x2G900=
X-Received: by 2002:aa7:c414:0:b0:523:b133:5c7a with SMTP id
 j20-20020aa7c414000000b00523b1335c7amr10629299edq.21.1692739577864; Tue, 22
 Aug 2023 14:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
 <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
 <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com> <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
In-Reply-To: <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 22 Aug 2023 14:26:06 -0700
Message-ID: <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 2:15=E2=80=AFPM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Aug 22, 2023 at 11:06=E2=80=AFPM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 10:57=E2=80=AFPM Justin Stitt <justinstitt@goog=
le.com> wrote:
> > >
> > [...]
> > > > > > Here's the invocation I am running to build kselftest:
> > > > > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D=
1 ARCH=3Dx86_64
> > > > > > -j128 V=3D1 -C tools/testing/selftests`
> > > >
> > > > I think I fixed the same issue in the script I am running to launch
> > > > those tests in a VM. This was in commit
> > > > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).
> > > >
> > > > And in the commit log, I wrote:
> > > > ```
> > > > According to commit 01d6c48a828b ("Documentation: kselftest:
> > > > "make headers" is a prerequisite"), running the kselftests requires
> > > > to run "make headers" first.
> > > > ```
> > > >
> > > > So my assumption is that you also need to run "make headers" with t=
he
> > > > proper flags before compiling the selftests themselves (I might be
> > > > wrong but that's how I read the commit).
> > >
> > > In my original email I pasted the invocation I used which includes th=
e
> > > headers target. What are the "proper flags" in this case?
> > >
> >
> > "make LLVM=3D1 ARCH=3Dx86_64 headers" no?
> >
> > But now I'm starting to wonder if that was not the intent of your
> > combined "make mrproper headers". I honestly never tried to combine
> > the 2. It's worth a try to split them I would say.
>
> Apologies, I just tested it, and it works (combining the 2).
>
> Which kernel are you trying to test?
> I tested your 2 commands on v6.5-rc7 and it just works.

I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378ef)

I ran these exact commands:
|    $ make mrproper
|    $ make LLVM=3D1 ARCH=3Dx86_64 headers
|    $ make LLVM=3D1 ARCH=3Dx86_64 -j128 -C tools/testing/selftests
TARGETS=3Dhid &> out

and here's the contents of `out` (still warnings/errors):
https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce5f59c6d

I have a feeling I'm doing something fundamentally incorrectly. Any ideas?

To be clear, I can build the Kernel itself just fine across many
configs and architectures. I have, at the very least, the dependencies
required to accomplish that.

>
> FTR:
> $> git checkout v6.5-rc7
> $> make LLVM=3D1 ARCH=3Dx86_64 mrproper headers
> $> make LLVM=3D1 ARCH=3Dx86_64 -j8 -C tools/testing/selftests TARGETS=3Dh=
id
>
> ->   BINARY   hid_bpf
>
> Cheers,
> Benjamin
>

