Return-Path: <bpf+bounces-10310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F236F7A4E57
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFB72823AD
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C8241F8;
	Mon, 18 Sep 2023 16:08:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408C210FA;
	Mon, 18 Sep 2023 16:08:24 +0000 (UTC)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F24C03;
	Mon, 18 Sep 2023 09:08:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 38308e7fff4ca-2bffa8578feso28310211fa.2;
        Mon, 18 Sep 2023 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695053290; x=1695658090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mw9PGns58MpgDbC90EC6PCBD0i/AuxCD1+N04xG6c7I=;
        b=Ro6SKHhLbi//LraJ7eNoJRjfZwkRNldCVUccCpFG8C3+R6nDguXDpUEcJmY7KbXlfV
         HS26JH+LIhrlIDq3Xy17ujhxUGV/0zRMCYimMGNXgkFE+dYRdF/u1hLKASckGUc8lPrp
         PIAEKPdtj987r5BmL54nmNAyKg32bx0EVx+aZu/NMJFttOTL9w0T0RWE1GvvxK0Wnm/T
         esWNl8rEVTEse3s0rqWlxsmErSImsBf0U3kbJXsnsq3rSLUafHZZNqRFMs34jQDxul8a
         LIN4XtiwpDycF2xabU4rZB0vweEa58VX+i5T+x9vhKH3E1d04DyKDpnwi60sBtzeUBaY
         sTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053290; x=1695658090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mw9PGns58MpgDbC90EC6PCBD0i/AuxCD1+N04xG6c7I=;
        b=hiFwVeQuPu1aEd6i/vEWsgOqUCVQgH/J2LMCJ+RjC7vS0iBPWySlsqYVu+w3X5SxBq
         9qRFde6vEeIth0VSKLMjPgnrcTHJxoXzJzTBSfg/6Rb3KWzbZgVAe8QnxdnobwQT8MqI
         qdGa+Jf9V3WVAmKjEDnwx38lLdXzBuhBV42S4zADmO6xTj7Hy+DUGeGYQ2PwUitbOONH
         UMDVzECVrbqTAg5xNKkxDs5Lizv+3p43r5fZv8Iwq+oP8M6OR1x3NaaUVbT3zG26VjX7
         C0NJ/J8UJ2ch0EWP4l3od8PwB7rGi1vo1OeRK6HXo9lsKj6g8YS+kDbA5WOMYMEwtY5z
         TKxA==
X-Gm-Message-State: AOJu0YwCLEv/gapby7ywRyi9oPZ3WWusmGxnkNaoE1JTSchTZjWItPTo
	OW9fxLHOcy9hP9CpDliE0QbFaPrSYlPRVzZB3LNyqNwugEQ=
X-Google-Smtp-Source: AGHT+IEkCcydntQavCkIUABpmahINsBagQaEup2IybnBeuFdtNhWBnfMeN4B40L4hpYTqpyLMSdUK5ibhUjDVBfYAlw=
X-Received: by 2002:a17:906:9e:b0:9a1:be50:ae61 with SMTP id
 30-20020a170906009e00b009a1be50ae61mr7613626ejc.69.1695046540120; Mon, 18 Sep
 2023 07:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
 <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com>
 <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com>
 <CANn89iKkEcsaEQRNmxdEHAkTbPVgVekUcjJvDsd-_fs0M9Qszw@mail.gmail.com> <CAADnVQLn1dtBNyywZO38WyWtUyomKJDdMefpkj3mkR=+fOh+tg@mail.gmail.com>
In-Reply-To: <CAADnVQLn1dtBNyywZO38WyWtUyomKJDdMefpkj3mkR=+fOh+tg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 18 Sep 2023 16:15:03 +0200
Message-ID: <CAP01T75C3qHe3OuXcbFqDjLtb+M8UixVYxHA-Gf=c6xrNQvVAA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-09-16
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sept 2023 at 15:56, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 18, 2023 at 6:54=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Sep 18, 2023 at 3:41=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Sep 18, 2023 at 6:25=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Sat, Sep 16, 2023 at 6:59=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > Hi David, hi Jakub, hi Paolo, hi Eric,
> > > > >
> > > > > The following pull-request contains BPF updates for your *net-nex=
t* tree.
> > > > >
> > > > > We've added 73 non-merge commits during the last 9 day(s) which c=
ontain
> > > > > a total of 79 files changed, 5275 insertions(+), 600 deletions(-)=
.
> > > > >
> > > > > The main changes are:
> > > > >
> > > > > 1) Basic BTF validation in libbpf, from Andrii Nakryiko.
> > > > >
> > > > > 2) bpf_assert(), bpf_throw(), exceptions in bpf progs, from Kumar=
 Kartikeya Dwivedi.
> > > > >
> > > > > 3) next_thread cleanups, from Oleg Nesterov.
> > > > >
> > > > > 4) Add mcpu=3Dv4 support to arm32, from Puranjay Mohan.
> > > > >
> > > > > 5) Add support for __percpu pointers in bpf progs, from Yonghong =
Song.
> > > > >
> > > > > 6) Fix bpf tailcall interaction with bpf trampoline, from Leon Hw=
ang.
> > > > >
> > > > > 7) Raise irq_work in bpf_mem_alloc while irqs are disabled to imp=
rove refill probabablity, from Hou Tao.
> > > > >
> > > > > Please consider pulling these changes from:
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> > > > >
> > > >
> > > > This might have been raised already, but bpf on x86 now depends on
> > > > CONFIG_UNWINDER_ORC ?
> > > >
> > > > $ grep CONFIG_UNWINDER_ORC .config
> > > > # CONFIG_UNWINDER_ORC is not set
> > > >
> > > > $ make ...
> > > > arch/x86/net/bpf_jit_comp.c:3022:58: error: no member named 'sp' in
> > > > 'struct unwind_state'
> > > >                 if (!addr || !consume_fn(cookie, (u64)addr,
> > > > (u64)state.sp, (u64)state.bp))
> > > >                                                                  ~~=
~~~ ^
> > > > 1 error generated.
> > >
> > > Kumar,
> > > can probably explain better,
> > > but no the bpf as whole doesn't depend.
> > > One feature needs either ORC or frame unwinder.
> > > It won't work with unwinder_guess.
> > > The build error is a separate issue.
> > > It hasn't been reported before.
> >
> > In my builds, I do have CONFIG_UNWINDER_FRAME_POINTER=3Dy
> >
> > $ grep UNWIND .config
> > # CONFIG_UNWINDER_ORC is not set
> > CONFIG_UNWINDER_FRAME_POINTER=3Dy
> >
> >
> > I note state.sp is only available to CONFIG_UNWINDER_ORC
> >
> > arch/x86/include/asm/unwind.h
> >
> > #if defined(CONFIG_UNWINDER_ORC)
> >     bool signal, full_regs;
> >     unsigned long sp, bp, ip;
> >     struct pt_regs *regs, *prev_regs;
> > #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
> >    bool got_irq;
> >    unsigned long *bp, *orig_sp, ip;   // this is orig_sp , not sp.
>
> Right. Our replies crossed.
> Please ignore this PR. We need to fix this first.

Hello,
This is my bad. I totally missed it since I initially wrote this patch
and never looked at it again.
I suggest that I send a fix to disable this feature with
CONFIG_UNWINDER_FRAME_POINTER=3Dy, while I work on reenabling it again
for it with a follow up.

