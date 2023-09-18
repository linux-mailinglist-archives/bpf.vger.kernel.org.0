Return-Path: <bpf+bounces-10295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADA47A4D7B
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA458280CE6
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0F21356;
	Mon, 18 Sep 2023 15:47:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A5F1F610;
	Mon, 18 Sep 2023 15:47:28 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7151BF8;
	Mon, 18 Sep 2023 08:46:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31f71b25a99so4620223f8f.2;
        Mon, 18 Sep 2023 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695051749; x=1695656549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DHGrKDsbcoE4V55qLA/7ca3hnClB/CuN0n14Ggoe2w=;
        b=RRAwDqRpjgl8J0Bb2QBGmW9a3itAhe2u4VBqOUs2OyAfZawXwlGaIlWdLW/0TM301Q
         ul6kNQnwrrRQmttPpiqJE+1/Std9SMyoxlRc17FffFUd88ojBQfDGVn75dyG0jTwSz7o
         11muiydGXwnABj0PNweS0IQhinfvebTTli7Ya7a4b3LYbAxiHD29xTnXPzuMt7P0K2VE
         bHIdTZWK1gYKl+jA/1+Uh1UBKIR5BcaVUz/u+e/zAYqpW6z51dg9rBcNN6CP5yOuamnE
         jAlnJ0o5tqRSq9T6wE2NnFMl48Vpu23LYL4Xtv0f3qNSrr0wdSqu3HNj27QO2RVyitCR
         Mh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051749; x=1695656549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DHGrKDsbcoE4V55qLA/7ca3hnClB/CuN0n14Ggoe2w=;
        b=Lp42WDM6p4nbokZvBC4OxdD/1RaHk+3vXurXVNEJ7wMOzLPiVPWgNZqdbJvIqmBr+2
         CgX4OyNByAo7S0ZlfEBHoS3j1kY/LuDHU0Gz+TBnFwTPHlhP17PZuYxMCVde4vj1+hPG
         ddTQjf3dvUkEgvakS8XBaKN7sWTNDW72tBhwKMusoV1kB3Uu7gR9UwEpkcq7jojVQNum
         dyA0JJ8uWeH2XezSAqigO+lrPcxyWnck646BVTIkFRQaGptyf5LPTS5ZfeTCmq3td7AG
         VJjMC0PQQE/Gm16JZIFjxShb/HZV0GIMEdOqWZjFlMF7+ziFj3cVcibv4fGsbdfI48tt
         D4Sw==
X-Gm-Message-State: AOJu0YzELLDLLw2fnU1eOKkwlRtx1Vsfk8hiLqeB+80Qk8d0HJi/qcpN
	MTg2SshL5XqgSJzDYTglGrZTjgxa85QHbbmyIC6cxpX6NrrzWQ==
X-Google-Smtp-Source: AGHT+IGHwXD6VvgXtKYITeYDiquJf+BYrMNpHKI2IdA0qBZth1fJoFVHJ8+ZatIcdu8z9KMF3QGoC8UpM0jASgeOeh0=
X-Received: by 2002:adf:f1c3:0:b0:31f:b402:5aaa with SMTP id
 z3-20020adff1c3000000b0031fb4025aaamr6804047wro.8.1695045296245; Mon, 18 Sep
 2023 06:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
 <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com> <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com>
In-Reply-To: <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Sep 2023 06:54:45 -0700
Message-ID: <CAADnVQLMYMLyBDFkoVemFOEsFW+_=-RXm9vYzpYTO2G612HtnQ@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-09-16
To: Eric Dumazet <edumazet@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 6:40=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 18, 2023 at 6:25=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Sat, Sep 16, 2023 at 6:59=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Hi David, hi Jakub, hi Paolo, hi Eric,
> > >
> > > The following pull-request contains BPF updates for your *net-next* t=
ree.
> > >
> > > We've added 73 non-merge commits during the last 9 day(s) which conta=
in
> > > a total of 79 files changed, 5275 insertions(+), 600 deletions(-).
> > >
> > > The main changes are:
> > >
> > > 1) Basic BTF validation in libbpf, from Andrii Nakryiko.
> > >
> > > 2) bpf_assert(), bpf_throw(), exceptions in bpf progs, from Kumar Kar=
tikeya Dwivedi.
> > >
> > > 3) next_thread cleanups, from Oleg Nesterov.
> > >
> > > 4) Add mcpu=3Dv4 support to arm32, from Puranjay Mohan.
> > >
> > > 5) Add support for __percpu pointers in bpf progs, from Yonghong Song=
.
> > >
> > > 6) Fix bpf tailcall interaction with bpf trampoline, from Leon Hwang.
> > >
> > > 7) Raise irq_work in bpf_mem_alloc while irqs are disabled to improve=
 refill probabablity, from Hou Tao.
> > >
> > > Please consider pulling these changes from:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> > >
> >
> > This might have been raised already, but bpf on x86 now depends on
> > CONFIG_UNWINDER_ORC ?
> >
> > $ grep CONFIG_UNWINDER_ORC .config
> > # CONFIG_UNWINDER_ORC is not set
> >
> > $ make ...
> > arch/x86/net/bpf_jit_comp.c:3022:58: error: no member named 'sp' in
> > 'struct unwind_state'
> >                 if (!addr || !consume_fn(cookie, (u64)addr,
> > (u64)state.sp, (u64)state.bp))
> >                                                                  ~~~~~ =
^
> > 1 error generated.
>
> Kumar,
> can probably explain better,
> but no the bpf as whole doesn't depend.
> One feature needs either ORC or frame unwinder.
> It won't work with unwinder_guess.
> The build error is a separate issue.
> It hasn't been reported before.

I see the error with CONFIG_UNWINDER_FRAME_POINTER.
That's unexpected.
Kumar,
looks like this config path wasn't tested.

Eric, Paolo, Dave, Kuba,
please ignore this PR.
We need to fix this first.

