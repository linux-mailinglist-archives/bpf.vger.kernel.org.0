Return-Path: <bpf+bounces-65832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1191DB2911D
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 04:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695581B25D3A
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5ED17BB21;
	Sun, 17 Aug 2025 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exPF/Tvn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA95BE46;
	Sun, 17 Aug 2025 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755396097; cv=none; b=o0XXjTZhrtYvEuUFgdGYm9jLdK90rW3eDTXB83poiHLEt5CMal0AzxJGQeaa95zKFTl8MqUwktIvBvIxqU88u84Y5O2Vv63+YEObmp4+MD5hdxpy3zGRZR+/RaLcsZ7Jz6dmyB1T3IfLXq29V+yslDhHX4L+MEhcWQG1+KsqSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755396097; c=relaxed/simple;
	bh=JMpPxPCRNT+b9gMbh5gE3h70V27UlE9kSrwGspa14ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1u9zdOYnz7SEUBmNFxgCc1mjOKZHqHdP4XYJQ57osTY287pEwnqilzSGxF653oh5mD2NCk4a231VnpEPjmuoXFWq5VbL1yJ7KGkyeHyQ/T7l4me1I+HfG1n7bSuatyymg0OtSjkMSQnuVZyJiB8Pqm2F4rTKFYZR1dZQKAMMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exPF/Tvn; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71d603f13abso27262897b3.0;
        Sat, 16 Aug 2025 19:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755396094; x=1756000894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP/DK/OPxVUi4HYLH3WSj/00BA/5dW4VdYTDNqBq37Q=;
        b=exPF/Tvn3UkpoaUHCKtj4TyRMDrBXYSlOo4Iad4MfX+Go7htqPBfH5qUKAq1ZtTmQB
         oDhCVCOUZHcZQ4CNxa3r/2JP4lR2Va/Sq/gJTsYHT+xVwzXxCmBPK+9bLpPZ1QyTa72O
         r4R47oT4Uwr2jbSVQzUrtQrgVHxxl4rokAei/Ay510yL8M1jfYSl6yBy+QDUZl2twu2J
         4XGWQ+/6pNi9WhkpDVKnVnwJ2CyM5b+11gRAQ4h939lEwQfLsVWniwudkP4uf9NTASLg
         EOCSEgB7OiYeZHUFUBnfRoeKqdByBmiKoSwmxwFv59fAQNlTx+CR+1B5iijJ2pjhwL/p
         apOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755396094; x=1756000894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP/DK/OPxVUi4HYLH3WSj/00BA/5dW4VdYTDNqBq37Q=;
        b=Xq6a81pK6xVLPzsc430E9eZ3lQsDNWurdbs7HHlxwFufNkCfapItYQZZKoaUt71WWq
         CLJEyetCzHiqV/cp6+8rK+PKClIXseGkPZDzq09IolwhgmxT2UygpURDrhTm3oe2NBZk
         jL5qIdZb8p6lmf8Gvkxq42bdyUr89SN9oFqUaJFVMNwRP3zodSemtpdNx3JgeXY+rIMv
         kwLlD9HH0i7x6GIhPu+aA8N2nT7xfPSqrGDScca43n38zoFluI6SO2mZ9H3j8r3QRRpS
         pD4neptp79MubPhkBo1ithEFvHMm9G65U/J8D3wQeyMXbpODCQeip4KY87g9ln86zXqJ
         Bqiw==
X-Forwarded-Encrypted: i=1; AJvYcCUCSmDM45FzWTmNKlW9ZwHLOBBWGkhWm+JHDFAl0b1b3u/XjVkukgohK21Suq+sGtTinicTr4tIweptLc9M@vger.kernel.org, AJvYcCX+sT9mTCDNBcxV7lA8auUDsPiS6U2+2osLZROlLuQFR3Kbr4qUBzE1NNOMqUT9q39+pY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwqY5/b8Nc01LgPZx3VLF3DN67Jtnamnz1WqY/qa2TQZfiNFm
	ATTdoq1t8UaTN0ICLTIKQObSUroKQ0RyO4C4W/k2tlSz06SYDgQgUi83q2OuymTQTlsWVe/c/0g
	UEfckJcjp8pZtSmFkVnpi79G/JjJ2agk=
X-Gm-Gg: ASbGncuwf9gdHlL79Pm0HDm4cu88OIZB/LBwxa4e41aDq+oc062laHRyPbGvdAB6Tcb
	i7PGFsKad3c2vqAQFzfZgu3odrnmD7jYawBNH7Hc9e5aXCXvF27fCHnyJRWinJBNWDofBTYUKNr
	Oshp0WuMKQnnq6TidCao/GRDaTaumjUNqZZXpOMWBDFf+5xNQ5NRyBPIaYuaWAGnQDujRRSR1ev
	KA4AXc=
X-Google-Smtp-Source: AGHT+IFHTZaiGQs8bl6nbKOPwVJj+lh7p3pcZI1xxVzC42mL/taKxMOu+nW2R/48k6/5n5yHiMe997272zN8Csd2qe4=
X-Received: by 2002:a05:690c:61c9:b0:71b:6635:df33 with SMTP id
 00721157ae682-71e6de26886mr92439187b3.30.1755396094401; Sat, 16 Aug 2025
 19:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815061824.765906-1-dongml2@chinatelecom.cn>
 <20250815061824.765906-2-dongml2@chinatelecom.cn> <CAADnVQKA98hBSsb02djL-zMsaXQDCjn4Ytck+WP3SWfvgXqDYg@mail.gmail.com>
 <eb93f12d-2232-4b7e-a7c6-71082a69f1f6@paulmck-laptop>
In-Reply-To: <eb93f12d-2232-4b7e-a7c6-71082a69f1f6@paulmck-laptop>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 17 Aug 2025 10:01:23 +0800
X-Gm-Features: Ac12FXz7Bfo17I5FqziJGxQUGU1PJQ9Orh5nKfgXKMfq7R81v9FavhwLOpsux1Q
Message-ID: <CADxym3bkqdXScTBvQMOb-JTDZTmAqdm_m_we4Rds6W=rgByauQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] rcu: add rcu_migrate_enable and rcu_migrate_disable
To: paulmck@kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 11:31=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Fri, Aug 15, 2025 at 04:02:14PM +0300, Alexei Starovoitov wrote:
> > On Fri, Aug 15, 2025 at 9:18=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > migrate_disable() is called to disable migration in the kernel, and i=
t is
> > > used togather with rcu_read_lock() oftenly.
> > >
> > > However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_loc=
k()
> > > will disable preemption, which will also disable migration.
> > >
> > > Introduce rcu_migrate_enable() and rcu_migrate_disable(), which will =
do
> > > the migration enable and disable only when the rcu_read_lock() can't =
do
> > > it.
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > >  include/linux/rcupdate.h | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 120536f4c6eb..0d9dbd90d025 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -72,6 +72,16 @@ static inline bool same_state_synchronize_rcu(unsi=
gned long oldstate1, unsigned
> > >  void __rcu_read_lock(void);
> > >  void __rcu_read_unlock(void);
> > >
> > > +static inline void rcu_migrate_enable(void)
> > > +{
> > > +       migrate_enable();
> > > +}
> >
> > Interesting idea.
> > I think it has to be combined with rcu_read_lock(), since this api
> > makes sense only when used together.
> >
> > rcu_read_lock_dont_migrate() ?
> >
> > It will do rcu_read_lock() + migrate_disalbe() in PREEMPT_RCU
> > and rcu_read_lock() + preempt_disable() otherwise?
>
> That could easily be provided.  Or just make one, and if it starts
> having enough use cases, it could be pulled into RCU proper.

Hi, do you mean that we should start with a single
use case? In this series, I started it with the BPF
subsystem. Most of the situations are similar, which will
call rcu_read_lock+migrate_disable and run bpf prog.

>
> > Also I'm not sure we can rely on rcu_read_lock()
> > disabling preemption in all !PREEMPT_RCU cases.
> > iirc it's more nuanced than that.
>
> For once, something about RCU is non-nuanced.  But don't worry, it won't
> happen again.  ;-)
>
> In all !PREEMPT_RCU, preemption must be disabled across all RCU read-side
> critical sections in order for RCU to work correctly.

Great! I worried about this part too.

Thanks!
Menglong Dong

>
>                                                         Thanx, Paul

