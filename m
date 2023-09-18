Return-Path: <bpf+bounces-10298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D03BD7A4DA3
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A59A28147C
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E409210FA;
	Mon, 18 Sep 2023 15:51:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2EC208A7
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 15:51:10 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA4CF6
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:47:45 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-41761e9181eso495021cf.1
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695051772; x=1695656572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxWP1zZlASCPMiHt8EGLIhqP2S6nXb6fXBCJS7lQbmg=;
        b=UT/ZqBtzOsveP9T67RFk0geO8O3+3efgPMWG/c+L07x9hpeqm2+WzzUYQSxDzW0V91
         SuaAt/hnIuFpxfj8laeNMsvb2UGhjhjSivh06herw3lMt5nDTZ/lFmP6B74wyF2E9Z+Q
         RORZ1dKxvCj7HlWFJBEpdBx62agXyHinEDDYpHfNyC7aJu8aAyb7jCR5reCjG22JXw76
         S/4cJeIMh2uuLOTvDSijsAlkphaYkljHMj6gUW2f283IQQb5xq4HElyUZ7hVCsH7KJyU
         zdHg1BtdtUHtSR8nMoXicq2oaSzAYZhx3ZmZ6VMrasxx2weZwsUexW/V2eV33rvHtFjX
         8ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051772; x=1695656572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxWP1zZlASCPMiHt8EGLIhqP2S6nXb6fXBCJS7lQbmg=;
        b=W/XJ6iAsGYHKIOSnN35GXEDsd5jAdRSgOLx+CYwpEViSbtM0Ea4f6I9CYSHGANP4kT
         ea/T3QcBF3t6x7A6A6RUfwW1dZhFJMRH1MGSzFxDEsCLzVMdj5d1GRul4WqUT3ogL4eU
         eXRzgGVSm4SPj+y+joUGjBzcMdUCEWn+SDn2dzVl1BPFAYQ7osXsS0Y/z0u4xl6oFnCN
         iop4QF5KW/V9wj7Gf4/0DLSnob/Lw9m+qb8iVEOOg1qOINrPLmiRgMBisqqFKIZQpQBj
         E1pKcCV8aGXYXCSxlDvIaSUuVsrv8xddZKFAFAEpgYtm+e9J4NzcpmiI6/a5HDylGq5v
         xjpA==
X-Gm-Message-State: AOJu0Yzksbzib54AdkCVP0TddkSZETz9axZhZQetvpTiPDUcq4SShrw4
	gWAxFIN3nCshbQk2/K9KzUp7UxwpNeQi++Hr8dPW0kuOzsoBLJSMq5AJyQ==
X-Google-Smtp-Source: AGHT+IHotFHipkqcsNpPcH0IpmOZFKl3zrKs+pi3/sZLgTR5nnvA/eeVWlEViG90JSNCcBM24FNAdBaJhkyv5SSjH2Q=
X-Received: by 2002:ac8:7f05:0:b0:410:9af1:f9b4 with SMTP id
 f5-20020ac87f05000000b004109af1f9b4mr461085qtk.10.1695045272440; Mon, 18 Sep
 2023 06:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
 <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com> <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com>
In-Reply-To: <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Sep 2023 15:54:21 +0200
Message-ID: <CANn89iKkEcsaEQRNmxdEHAkTbPVgVekUcjJvDsd-_fs0M9Qszw@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-09-16
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 3:41=E2=80=AFPM Alexei Starovoitov
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

In my builds, I do have CONFIG_UNWINDER_FRAME_POINTER=3Dy

$ grep UNWIND .config
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=3Dy


I note state.sp is only available to CONFIG_UNWINDER_ORC

arch/x86/include/asm/unwind.h

#if defined(CONFIG_UNWINDER_ORC)
    bool signal, full_regs;
    unsigned long sp, bp, ip;
    struct pt_regs *regs, *prev_regs;
#elif defined(CONFIG_UNWINDER_FRAME_POINTER)
   bool got_irq;
   unsigned long *bp, *orig_sp, ip;   // this is orig_sp , not sp.
   ...

