Return-Path: <bpf+bounces-10288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8F7A4CBF
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155E91C21196
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43F1F5F3;
	Mon, 18 Sep 2023 15:39:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9071CAAC;
	Mon, 18 Sep 2023 15:39:44 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B183C171D;
	Mon, 18 Sep 2023 08:38:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a64619d8fbso614591766b.0;
        Mon, 18 Sep 2023 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695051309; x=1695656109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIg5kmcPyIGWrNt6ZWUNIONMl/n/uAOZSBLcW4/Hcy4=;
        b=Hv+NRusGbiQa6MAbmfZp8SCfvT0C3RFHyjg7sAQ5qYO4Qsrbkp1/F0Z48DB/EfcQWm
         FyGymStnVGZ5Gvq54+TdB3mSYGjZqXF1Jzj7W0mufZEN94xMR4orDKOBvvnfcQV3Ke7m
         ATA3rPEpH3ja0O+VP6XvC+6315jAFNJyAcpfSMrKGxTU84k0KviKlZN5e03eng3l44mk
         m3taGDnPmjYE9Xa5UyIP6/GLbmpTHYTf90TlV7G0My+/m35nEf9lqFPrGc8C8G0JweGs
         FefI4d7t8NeYOJXL7V7ko7N1udqL7niE/kz8rn5aqZa+l2hM6JyEax5Me4BwLeUdBr1V
         dV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051309; x=1695656109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIg5kmcPyIGWrNt6ZWUNIONMl/n/uAOZSBLcW4/Hcy4=;
        b=uqM4xcpMlxHmEKpvTokCfrDu6VOMruEXPdhoxk012PALCPLac2k2YmTs3GR8VwTA9k
         ieLKniNxOTlM5uJWFFEmfajq7XTEVNRqWfLULinVAp2Mpk3A2aSSyFBAD8Bh9XW4mlqY
         Fyxkv9a77ybga2ObkDh5aAj1MzQ0auTqw153R99X3fsOhQHHsCDp/BIJXFYJQTbTpW3W
         3mKLjExIkCYuSqiyNENSzb/Z8d5SFcSsgvaO8yCbooN8W67L0/COxaJKiY6vdwXlExOW
         +L08bl3ywrtREuklBdH3ps+sJcY7NbgXBuAdwfYe/Zl4S8EWt7iw7yrE10rgeViEBR1I
         cyzg==
X-Gm-Message-State: AOJu0Yz5OxVRse9/speJKeFpQ8G/0u6SITUzo9Jj/5TbvhKi2xnBK1CQ
	d+eK4RqDiw0eiJ+ZBq4dogX3bQ9jVss1xMaWP1nM4BTPsSE=
X-Google-Smtp-Source: AGHT+IGbRU1gGq5co9AF9V4Vu4I8crFNkb5bMq6AdvHqEfRp8Fy7YH+gFbsjE4OgZ/2TiBFl6puhScGV2pbPEWH/hSY=
X-Received: by 2002:adf:e0ca:0:b0:319:6997:942e with SMTP id
 m10-20020adfe0ca000000b003196997942emr7333572wri.8.1695045362032; Mon, 18 Sep
 2023 06:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
 <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com>
 <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com> <CANn89iKkEcsaEQRNmxdEHAkTbPVgVekUcjJvDsd-_fs0M9Qszw@mail.gmail.com>
In-Reply-To: <CANn89iKkEcsaEQRNmxdEHAkTbPVgVekUcjJvDsd-_fs0M9Qszw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Sep 2023 06:55:51 -0700
Message-ID: <CAADnVQLn1dtBNyywZO38WyWtUyomKJDdMefpkj3mkR=+fOh+tg@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-09-16
To: Eric Dumazet <edumazet@google.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 6:54=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 18, 2023 at 3:41=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 6:25=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Sat, Sep 16, 2023 at 6:59=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > Hi David, hi Jakub, hi Paolo, hi Eric,
> > > >
> > > > The following pull-request contains BPF updates for your *net-next*=
 tree.
> > > >
> > > > We've added 73 non-merge commits during the last 9 day(s) which con=
tain
> > > > a total of 79 files changed, 5275 insertions(+), 600 deletions(-).
> > > >
> > > > The main changes are:
> > > >
> > > > 1) Basic BTF validation in libbpf, from Andrii Nakryiko.
> > > >
> > > > 2) bpf_assert(), bpf_throw(), exceptions in bpf progs, from Kumar K=
artikeya Dwivedi.
> > > >
> > > > 3) next_thread cleanups, from Oleg Nesterov.
> > > >
> > > > 4) Add mcpu=3Dv4 support to arm32, from Puranjay Mohan.
> > > >
> > > > 5) Add support for __percpu pointers in bpf progs, from Yonghong So=
ng.
> > > >
> > > > 6) Fix bpf tailcall interaction with bpf trampoline, from Leon Hwan=
g.
> > > >
> > > > 7) Raise irq_work in bpf_mem_alloc while irqs are disabled to impro=
ve refill probabablity, from Hou Tao.
> > > >
> > > > Please consider pulling these changes from:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> > > >
> > >
> > > This might have been raised already, but bpf on x86 now depends on
> > > CONFIG_UNWINDER_ORC ?
> > >
> > > $ grep CONFIG_UNWINDER_ORC .config
> > > # CONFIG_UNWINDER_ORC is not set
> > >
> > > $ make ...
> > > arch/x86/net/bpf_jit_comp.c:3022:58: error: no member named 'sp' in
> > > 'struct unwind_state'
> > >                 if (!addr || !consume_fn(cookie, (u64)addr,
> > > (u64)state.sp, (u64)state.bp))
> > >                                                                  ~~~~=
~ ^
> > > 1 error generated.
> >
> > Kumar,
> > can probably explain better,
> > but no the bpf as whole doesn't depend.
> > One feature needs either ORC or frame unwinder.
> > It won't work with unwinder_guess.
> > The build error is a separate issue.
> > It hasn't been reported before.
>
> In my builds, I do have CONFIG_UNWINDER_FRAME_POINTER=3Dy
>
> $ grep UNWIND .config
> # CONFIG_UNWINDER_ORC is not set
> CONFIG_UNWINDER_FRAME_POINTER=3Dy
>
>
> I note state.sp is only available to CONFIG_UNWINDER_ORC
>
> arch/x86/include/asm/unwind.h
>
> #if defined(CONFIG_UNWINDER_ORC)
>     bool signal, full_regs;
>     unsigned long sp, bp, ip;
>     struct pt_regs *regs, *prev_regs;
> #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
>    bool got_irq;
>    unsigned long *bp, *orig_sp, ip;   // this is orig_sp , not sp.

Right. Our replies crossed.
Please ignore this PR. We need to fix this first.

