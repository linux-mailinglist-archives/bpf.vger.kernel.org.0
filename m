Return-Path: <bpf+bounces-8301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FD784BB0
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21BA1C209D4
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9A2B56E;
	Tue, 22 Aug 2023 20:57:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE822018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 20:57:20 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44697CFC
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:57:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso7542007e87.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692737836; x=1693342636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzHAvJvU/nApA2yMoHvJ1G6cDPyhvuZ9u+E3dxZTTl0=;
        b=CZwvKWGK3DckCO7Fi8mS3W7MwGDdoUCTakynZcFLiDP12Qs5dJmvuSPK56+EGHsd//
         s8vDrDu7Bg6unT9uqT3ibMk3RpFhOr3LKZ0pDmc02GvoA9AtyrZNlwVyORhAu8GHZWFy
         95WyLiJons3xvMHdyD965uHJc59jKIxt0tp1+SzhUNHHORN7RBgyeWb9V8l7d/8eYiKp
         MKp8kGZKcktKz4f22biVRmiDQbjAEoymZimW+GqcfyLfX8+TphZHpq9uT9KQe/l6IzK2
         qZbke/ZRXqDWSc9NxgxDBPyXxkOKKfKfAFrJb4dIJ395fdM2xfUr+0oAC8JRAmuiCNhD
         n+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692737836; x=1693342636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzHAvJvU/nApA2yMoHvJ1G6cDPyhvuZ9u+E3dxZTTl0=;
        b=FGUAz0gITRoGyBio+gwq20M2A7RJd70THOP1URq1bwooQdx6fj/Q9YKkPzH9sTNaWF
         GFQJpyj9Ch7kvdnH4BzoCl8LfzCOlofiduyNk6RpYGoewHr+j2/btiMhOpUIFZJFOgK5
         zsY5ri/UbZlAiBtpdC2pFKR3XBPJ7Z6eIC/VMI4pkVsk91xTXlaVGOQKwQac3Ze5hXtu
         sOMtra5mpD5/FKYS9j/NhXcfkIIiPBnecVFYOOwXZzow43ZSls08XqWp4CM28AF4PU7n
         fWB7vFIoaAr1I1JQ8+j+QkTekva49B9bOcHeB+JDfjQpBpezRWkrrWGycKLWOdY2ucXw
         R/yQ==
X-Gm-Message-State: AOJu0YzaG6o0bcBZr5oOOwrFMO5c8Ibi6g2614b8fKRttDu+sfjdW4kp
	HourPl6Vh9Jxk+0JZxs6JgN7bOGwL1R6sqty3zuXPA==
X-Google-Smtp-Source: AGHT+IENL3fGaa5c8yeC0Cvpb3NAyDAe2M8ES19Hvh6sDem/HbedUBIz+q/XLprGZ7xJXvyjWuu+0QOfvgRmwAHcxOU=
X-Received: by 2002:a05:6512:2522:b0:4f1:3d7d:409e with SMTP id
 be34-20020a056512252200b004f13d7d409emr9198896lfb.0.1692737836393; Tue, 22
 Aug 2023 13:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com> <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
In-Reply-To: <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 22 Aug 2023 13:57:04 -0700
Message-ID: <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
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

On Tue, Aug 22, 2023 at 1:52=E2=80=AFPM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Justin,
>
> On Tue, Aug 22, 2023 at 10:44=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > + Ben, author of commit dbb60c8a26da ("selftests: add tests for the
> > HID-bpf initial implementation")
> >
> > On Tue, Aug 22, 2023 at 1:34=E2=80=AFPM Justin Stitt <justinstitt@googl=
e.com> wrote:
> > >
> > > Hi, I'd like to get some help with building the kselftest target.
> > >
> > > I am running into some warnings within the hid tree:
> > > | progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct
> > > hid_bpf_ctx' will \
> > > |       not be visible outside of this function [-Werror,-Wvisibility=
]
> > > |     9 | extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> > > |       |                                      ^
> > > | progs/hid.c:23:35: error: incompatible pointer types passing 'struc=
t
> > > hid_bpf_ctx *' \
> > > |       to parameter of type 'struct hid_bpf_ctx *'
> > > [-Werror,-Wincompatible-pointer-types]
> > > |    23 |         __u8 *rw_data =3D hid_bpf_get_data(hid_ctx, 0 /*
> > > offset */, 3 /* size */);
> > >
> > > This warning, amongst others, is due to some symbol not being include=
d.
> > > In this case, `struct hid_bpf_ctx` is not being defined anywhere that=
 I
> > > can see inside of the testing tree itself.
> > >
> > > Instead, `struct hid_bpf_ctx` is defined and implemented at
> > > `include/linux/hid_bpf.h`. AFAIK, I cannot just include this header a=
s
> > > the tools directory is a separate entity from kbuild and these tests =
are
> > > meant to be built/ran without relying on kernel headers. Am I correct=
 in
> > > this assumption? At any rate, the include itself doesn't work. How ca=
n I
> > > properly include this struct definition and fix the warning(s)?
> > >
> > > Please note that we cannot just forward declare the struct as it is
> > > being dereferenced and would then yield a completely different
> > > error/warning for an incomplete type. We need the entire implementati=
on
> > > for the struct included.
> > >
> > > Other symbols also defined in `include/linux/hid_bpf.h` that we need =
are
> > > `struct hid_report_type` and `HID_BPF_FLAG...`
> > >
> > > Here's the invocation I am running to build kselftest:
> > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 ARCH=
=3Dx86_64
> > > -j128 V=3D1 -C tools/testing/selftests`
>
> I think I fixed the same issue in the script I am running to launch
> those tests in a VM. This was in commit
> f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).
>
> And in the commit log, I wrote:
> ```
> According to commit 01d6c48a828b ("Documentation: kselftest:
> "make headers" is a prerequisite"), running the kselftests requires
> to run "make headers" first.
> ```
>
> So my assumption is that you also need to run "make headers" with the
> proper flags before compiling the selftests themselves (I might be
> wrong but that's how I read the commit).

In my original email I pasted the invocation I used which includes the
headers target. What are the "proper flags" in this case?

>
> Cheers,
> Benjamin
>
> > >
> > > If anyone is currently getting clean builds of kselftest with clang,
> > > what invocation works for you?
> > >
> > >
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> > > Full-build-log:
> > > https://gist.github.com/JustinStitt/b217f6e47c1d762e5e1cc6c3532f1bbb
> > > (V=3D1)
> > >
> > > Thanks.
> > > Justin
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
> >
>

