Return-Path: <bpf+bounces-8308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D25F784C2A
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFAE28114B
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62EE34CDF;
	Tue, 22 Aug 2023 21:38:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C72018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:38:45 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B89D3
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:38:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so8984293a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692740322; x=1693345122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yto2kk6DBSJ1V5ZImzvYQx7OM25yQ1eu7dHzXWPe8ao=;
        b=vmKH5XaOyyiRgLUGfWw3BHuFln5Yd03mzRPVgPjr+nY/eAZ+J4Fg0KV7ycSV2XTYVZ
         m0EYdreTRwSwva2WtoEjz3iadvJZQdb20kzUhLVc4vt/J2IjKrptWOYEx0kPl9CE4fPe
         P73C7+YqSzqDTWVSFIW64es0ra2GYNm3HN7hV6nuu1vTNlKFQkwDSovL34JgrbdK12A1
         pBLPBQV//uXBUqhrGwtXm2wA/9TlkdAfNSzGf0m2+9UbQYidCE/184s+j5PNrgUEqGhv
         lURkL6pi4yWpzb5OO6ZgTy8MYWUIT5qLyuuMUR1Rnh5T4siYsVkwhqBiB4JQJuwYa7EH
         Pw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740322; x=1693345122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yto2kk6DBSJ1V5ZImzvYQx7OM25yQ1eu7dHzXWPe8ao=;
        b=EIojiUFIsUBNgK8DK+rkvpAzr6GGzfpB8rV5lDnoJBNoq/R3e8T8rq1Ht2lkoL55nD
         D5gFcg2A5tBfZ57/3HUX95uTTnzKASj0G9w3ch77EgxrszLjf4MCbsMmVoHiK72F34Oq
         9yhGoBO1Q3muR0siV1sPfJWhPDzorHVJ3XDamnp8kxsneFTv/7ExXMANwI1RVA5kbkdo
         dttAP9/5WnWre0DbGD4VLNIrGCZdD/UihIYcJ1aZVO9tZbX0s0mCOVYztaxK3HcB9h4t
         8mKbhuw/AifFOxwadTjlFQdOBRPKzND7OHk8burat+/CvX0iwO6iWac/aYb6TUkbUeHG
         zS7g==
X-Gm-Message-State: AOJu0Yz77IzKVZKk5MpPKRMH47wyXUW7bp8a+Q6rng+YH8+qh720CgBl
	/7l4/2w1KwT4CANVhvxNIcxbnfBozD/mpmUtJfH2BQ==
X-Google-Smtp-Source: AGHT+IG9y9F4GEeS+t1s2A1hj/NgdZZSvZh6IBK6jRU2acBGiGcHy35VP9tKp6KwcvC4f9C3t3Y2KbT5MO4fhwkvnuM=
X-Received: by 2002:a05:6402:792:b0:521:ad49:8493 with SMTP id
 d18-20020a056402079200b00521ad498493mr12142075edy.6.1692740322016; Tue, 22
 Aug 2023 14:38:42 -0700 (PDT)
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
 <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
 <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
 <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com> <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
In-Reply-To: <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 22 Aug 2023 14:38:29 -0700
Message-ID: <CAFhGd8rgdszt5vgWuGKkcpTZbKvihGCJXRKKq7RP17+71dTYww@mail.gmail.com>
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
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 2:36=E2=80=AFPM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Aug 22, 2023 at 11:26=E2=80=AFPM Justin Stitt <justinstitt@google=
.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 2:15=E2=80=AFPM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 11:06=E2=80=AFPM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 10:57=E2=80=AFPM Justin Stitt <justinstitt@=
google.com> wrote:
> > > > >
> > > > [...]
> > > > > > > > Here's the invocation I am running to build kselftest:
> > > > > > > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLV=
M=3D1 ARCH=3Dx86_64
> > > > > > > > -j128 V=3D1 -C tools/testing/selftests`
> > > > > >
> > > > > > I think I fixed the same issue in the script I am running to la=
unch
> > > > > > those tests in a VM. This was in commit
> > > > > > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ serie=
s).
> > > > > >
> > > > > > And in the commit log, I wrote:
> > > > > > ```
> > > > > > According to commit 01d6c48a828b ("Documentation: kselftest:
> > > > > > "make headers" is a prerequisite"), running the kselftests requ=
ires
> > > > > > to run "make headers" first.
> > > > > > ```
> > > > > >
> > > > > > So my assumption is that you also need to run "make headers" wi=
th the
> > > > > > proper flags before compiling the selftests themselves (I might=
 be
> > > > > > wrong but that's how I read the commit).
> > > > >
> > > > > In my original email I pasted the invocation I used which include=
s the
> > > > > headers target. What are the "proper flags" in this case?
> > > > >
> > > >
> > > > "make LLVM=3D1 ARCH=3Dx86_64 headers" no?
> > > >
> > > > But now I'm starting to wonder if that was not the intent of your
> > > > combined "make mrproper headers". I honestly never tried to combine
> > > > the 2. It's worth a try to split them I would say.
> > >
> > > Apologies, I just tested it, and it works (combining the 2).
> > >
> > > Which kernel are you trying to test?
> > > I tested your 2 commands on v6.5-rc7 and it just works.
> >
> > I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378ef)
> >
> > I ran these exact commands:
> > |    $ make mrproper
> > |    $ make LLVM=3D1 ARCH=3Dx86_64 headers
> > |    $ make LLVM=3D1 ARCH=3Dx86_64 -j128 -C tools/testing/selftests
> > TARGETS=3Dhid &> out
> >
> > and here's the contents of `out` (still warnings/errors):
> > https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce5f59c6d
> >
> > I have a feeling I'm doing something fundamentally incorrectly. Any ide=
as?
>
> Sigh... there is a high chance my Makefile is not correct and uses the
> installed headers (I was running the exact same commands, but on a
> v6.4-rc7+ kernel).
>
> But sorry, it will have to wait for tomorrow if you want me to have a
> look at it. It's 11:35 PM here, and I need to go to bed
Take it easy. Thanks for the prompt responses here! I'd like to get
the entire kselftest make target building with Clang so that we can
close [1].

>
> Cheers,
> Benjamin
>
> >
> > To be clear, I can build the Kernel itself just fine across many
> > configs and architectures. I have, at the very least, the dependencies
> > required to accomplish that.
> >
> > >
> > > FTR:
> > > $> git checkout v6.5-rc7
> > > $> make LLVM=3D1 ARCH=3Dx86_64 mrproper headers
> > > $> make LLVM=3D1 ARCH=3Dx86_64 -j8 -C tools/testing/selftests TARGETS=
=3Dhid
> > >
> > > ->   BINARY   hid_bpf
> > >
> > > Cheers,
> > > Benjamin
> > >
> >
>

[1]: https://github.com/ClangBuiltLinux/linux/issues/1910

