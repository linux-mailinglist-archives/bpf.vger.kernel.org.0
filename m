Return-Path: <bpf+bounces-796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC31E706E10
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E8E1C20FD5
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF552098E;
	Wed, 17 May 2023 16:26:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B2111A1
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:26:35 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC391987
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:26:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so1798687a12.3
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684340792; x=1686932792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPwFirfaRkIyZZAuXKTQpmf9D1tkmkY1cfDYWxRyr8k=;
        b=n68ErBrNB2rvJLw6hEBjoJoY62J9dsHL/AbWe5nVZNYrrXx7YOJhxEWKrBhusZmK67
         futOj3x0nX+o9xjjISeEJGOJvuwTnyBW/+zvKyQhtzHqfAxFnKPtXiJOmaC1wH2XxgvX
         iD1sOOjWEQ6opu5DQrq1ic/kh5YomYYMMxT6w7d/yjkuhIEePBQDBP/M1hv3tz/tJ0l+
         vMxRAporVy89ylw2iHyPPfb0/ApwHZj8AhZQ4J9dj3yVuoR8X4i5HtsKwUDrkPeUCOGg
         1vJ8CGgDkR6OhWzaJw7pZQYGmDqbuEND1Kw8TdarQnV2kXBPc86NMB041jG6zjfmxbte
         8Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340792; x=1686932792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPwFirfaRkIyZZAuXKTQpmf9D1tkmkY1cfDYWxRyr8k=;
        b=giOx052m17+16McXG9ReRMMS2GoFC1Zg4JiKghokRhqsFXp2ek+IGXC2rwYjF5C/LB
         PIoh9MNtRq6o2oQQFDGtvMM8eQ2kmUruNv3tRMeJYgg/Uf3eXPk8il3Go4YbDCIgvWCB
         CGeJsDp4SaC+fNsr8L1thm7o9mu0QdNKKK0naXfSkenInldiGsET586MaZH2u4L2gVfi
         v2HxkeGys3G5M8fSHox685AGvA7bDYANkwCX/XuhrqBYQIjPAQFDyjo/9oMOoZ+3iWdm
         wb/0HR3rc4zENYBzOC7SDfIFVDnHsw9NpkczHVVip/IpQAb7yg5Fr7ZHIAPnnLlN671N
         y9Zw==
X-Gm-Message-State: AC+VfDz6mGgmDDNtwSHWMEOAmuznJ95OMRd3za+YgOeTB/e8x4i+U9AR
	gsIaAXgV35UI9uxipQ3mA1oafnlWHik1Acsvk2w=
X-Google-Smtp-Source: ACHHUZ58/EhP3HuDh0vfPYUd5nxlvVS0KWOr79IlewWSzaLcErQbuhi3BO73qHHmfp0ewihAucNodP8ImJknsOtvtJQ=
X-Received: by 2002:a17:907:7f19:b0:947:335f:5a0d with SMTP id
 qf25-20020a1709077f1900b00947335f5a0dmr46558124ejc.62.1684340791624; Wed, 17
 May 2023 09:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509132433.2FSY_6t7@linutronix.de> <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
In-Reply-To: <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 May 2023 09:26:19 -0700
Message-ID: <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: Remove in_atomic() from bpf_link_put().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 10:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 10, 2023 at 12:19=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, May 9, 2023 at 6:24=E2=80=AFAM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks =
are
> > > invoked within softirq context. By setting rcutree.use_softirq=3D0 bo=
ot
> > > option the RCU callbacks will be invoked in a per-CPU kthread with
> > > bottom halves disabled which implies a RCU read section.
> > >
> > > On PREEMPT_RT the context remains fully preemptible. The RCU read
> > > section however does not allow schedule() invocation. The latter happ=
ens
> > > in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
> > > from bpf_link_put().
> > >
> > > Remove the context checks and use the workqueue unconditionally.
> > >
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> >
> > Please see [0] and corresponding revert commit. We do want
> > bpf_link_free() to happen synchronously if it's caused by close()
> > syscall.
> >
> > f00f2f7fe860 ("Revert "bpf: Fix potential call bpf_link_free() in
> > atomic context"")
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4BzZ9zwA=3DSrLTx9JT50OeM6fVPg0Py0=
Gx+K9ah2we8YtCRA@mail.gmail.com/
>
> Sebastian,
>
> Andrii is correct. We cannot do this unconditionally,
> but we can do it for IS_ENABLED(CONFIG_PREEMPT_RT)
> if it's causing issues on RT, but BPF users won't be happy
> with non deterministic prog detach.
> Do you see a different way of solving it?

Is struct file_operations.release() callback guaranteed to be called
from user context? If yes, then perhaps the most straightforward way
to guarantee synchronous bpf_link cleanup on close(link_fd) is to have
a bpf_link_put() variant that will be only called from user-context
and will just do bpf_link_free(link) directly, without checking
in_atomic().

