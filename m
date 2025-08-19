Return-Path: <bpf+bounces-66044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E518B2CE97
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 23:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91DF1BA8701
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58815322DD7;
	Tue, 19 Aug 2025 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIGyaKcK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC9284884;
	Tue, 19 Aug 2025 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639252; cv=none; b=umkvotfoo77p5e+TZqru1ipdIJ8m+LsbsiV9inZBdG4BJNaa5OQCI6DL1mnS186o/mObIyehh1xuTuzvNUcdlgDtp2lWeOVnmgzsUHYOoBIHrlOIpYVfXWMz4jbrNxPqrE9WtWG45UuhY1utGnU2DxK3qJpz1FKYE3JRR5Sg1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639252; c=relaxed/simple;
	bh=+53NlAraJtyCL2JPoFwrL3tKiDe+tcXrwxWmFSyzC0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpuHcL4Dz4H4m4wy1AZLQQ5tJYQDOxe4yBYfNAzuuwv2PZAyAhRlMg3y2jA4TwOAH7Yvt6Yc5deWGe0iDCndXDOUKsA9Ewll0EpI03+ab9rXmJT35qyuU6rE3QBajWwbzc0+G13uqWyEh4bPA68BH0ubGBwgaKZq03yZPs1JIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIGyaKcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622E9C4CEF1;
	Tue, 19 Aug 2025 21:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755639252;
	bh=+53NlAraJtyCL2JPoFwrL3tKiDe+tcXrwxWmFSyzC0I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uIGyaKcKFSbNin7d3UJavzxL+Dd4r9YEgfYw9z1CVEqOAiase1Tw4oI8RtjMLDGyP
	 muJm+FaieCPMdhXXD4OIJbxIsjSwanBzA7yWsb8hoVivNptQYKJvQyOWtoccNINGA4
	 PmWiY4z0SpE7BxLgpXGy2EJj26oNmBYyL9p4yK25MJI6gzhX5xkDEBdoe9s0kdSmvX
	 i7UcpOvnC9nA0ws5E/RzsUzw4I4bB1qtzdI1XY/plvVWGNM+uuSEHg9IODxB3QSzDW
	 EMOn0kelK5te368Zp7qBEQVh5tqrBVw2e1t+9bKaEYOqAaxsZju6woDXrTaGSx3/l+
	 vsizuYNJ7RD6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1D9B5CE086D; Tue, 19 Aug 2025 14:34:12 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:34:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/7] rcu: add rcu_migrate_enable and
 rcu_migrate_disable
Message-ID: <0b46c80c-280b-4db8-957e-9dd5695e1f25@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250815061824.765906-1-dongml2@chinatelecom.cn>
 <20250815061824.765906-2-dongml2@chinatelecom.cn>
 <CAADnVQKA98hBSsb02djL-zMsaXQDCjn4Ytck+WP3SWfvgXqDYg@mail.gmail.com>
 <eb93f12d-2232-4b7e-a7c6-71082a69f1f6@paulmck-laptop>
 <CADxym3bkqdXScTBvQMOb-JTDZTmAqdm_m_we4Rds6W=rgByauQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADxym3bkqdXScTBvQMOb-JTDZTmAqdm_m_we4Rds6W=rgByauQ@mail.gmail.com>

On Sun, Aug 17, 2025 at 10:01:23AM +0800, Menglong Dong wrote:
> On Fri, Aug 15, 2025 at 11:31 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Aug 15, 2025 at 04:02:14PM +0300, Alexei Starovoitov wrote:
> > > On Fri, Aug 15, 2025 at 9:18 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
> > > >
> > > > migrate_disable() is called to disable migration in the kernel, and it is
> > > > used togather with rcu_read_lock() oftenly.
> > > >
> > > > However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock()
> > > > will disable preemption, which will also disable migration.
> > > >
> > > > Introduce rcu_migrate_enable() and rcu_migrate_disable(), which will do
> > > > the migration enable and disable only when the rcu_read_lock() can't do
> > > > it.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > ---
> > > >  include/linux/rcupdate.h | 18 ++++++++++++++++++
> > > >  1 file changed, 18 insertions(+)
> > > >
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 120536f4c6eb..0d9dbd90d025 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -72,6 +72,16 @@ static inline bool same_state_synchronize_rcu(unsigned long oldstate1, unsigned
> > > >  void __rcu_read_lock(void);
> > > >  void __rcu_read_unlock(void);
> > > >
> > > > +static inline void rcu_migrate_enable(void)
> > > > +{
> > > > +       migrate_enable();
> > > > +}
> > >
> > > Interesting idea.
> > > I think it has to be combined with rcu_read_lock(), since this api
> > > makes sense only when used together.
> > >
> > > rcu_read_lock_dont_migrate() ?
> > >
> > > It will do rcu_read_lock() + migrate_disalbe() in PREEMPT_RCU
> > > and rcu_read_lock() + preempt_disable() otherwise?
> >
> > That could easily be provided.  Or just make one, and if it starts
> > having enough use cases, it could be pulled into RCU proper.
> 
> Hi, do you mean that we should start with a single
> use case? In this series, I started it with the BPF
> subsystem. Most of the situations are similar, which will
> call rcu_read_lock+migrate_disable and run bpf prog.

Other than my wanting more compact code, what you did in your patch
series is fine.

							Thanx, Paul

> > > Also I'm not sure we can rely on rcu_read_lock()
> > > disabling preemption in all !PREEMPT_RCU cases.
> > > iirc it's more nuanced than that.
> >
> > For once, something about RCU is non-nuanced.  But don't worry, it won't
> > happen again.  ;-)
> >
> > In all !PREEMPT_RCU, preemption must be disabled across all RCU read-side
> > critical sections in order for RCU to work correctly.
> 
> Great! I worried about this part too.
> 
> Thanks!
> Menglong Dong
> 
> >
> >                                                         Thanx, Paul

