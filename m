Return-Path: <bpf+bounces-65776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C91B282FC
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 17:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA071CE4139
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C0A291C03;
	Fri, 15 Aug 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNTWQ230"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB9302745;
	Fri, 15 Aug 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271879; cv=none; b=kEL3ZFMru1cgzNUH3+WxYF63odwyE3cuDCePHTPsvgJmi5N1WL3LWFzJQXYHryL4POTeC/RtNsnhL5c2SdQ6nfObXjjEbmKFhycerZtNfNhFZaVFpekf1+roUyPSLinIGCwILSGhLVtYYNflgLERNavzD099QqivfaQykI9gehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271879; c=relaxed/simple;
	bh=/jvMp/guKLSHe+yxsr6XthvTtUUPzj4tZ+6lXJrq+Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/Mr/6HyFk+QheCxL8/DgYJvWHjrefku7AbpRc0GyMKXA8XrGkAs+7AGL9HUKtTo6TZFAeygiezfPglQbeGhcRUXA65HknWvW/m7vHScHlVJZ9Gc9eYY02Nia778U3jyeqSRPkw+1sR4WCIIfh/n2AiqFGJP/zJnhM5zUHwiCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNTWQ230; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2F5C4CEEB;
	Fri, 15 Aug 2025 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755271879;
	bh=/jvMp/guKLSHe+yxsr6XthvTtUUPzj4tZ+6lXJrq+Ws=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eNTWQ230HNQDLCZPyyrGOXSNjpesnhlV280U2+vvvc7Meqb4LSG8o74PRS8igrwK5
	 CiLgOxbyWw4rBmbaHnK1a5ZtGVRP9AIEFBem9N0EYngiOS21gIKb242jDvIlxeN5Q3
	 0xxch+lZghGVAQKZQFkWyvr190/Ci9nBhaUeURUX0ky06TL7H42Wa/w2nTlRo/+Tgk
	 xRZR4Rikpr0uwswxyDjeo6mUFLs3dXYqCcjlEqGBSIh51h9T57VMVcz0YUDHtB9xs+
	 XNv4Jam0CO+c8bkf0GrkbdDIlaWsVnC7D83/G+BgbSMXD7kT80qGLYt+yrakd3JzCA
	 1i/En66p5pJsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8BB3BCE0ADB; Fri, 15 Aug 2025 08:31:17 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:31:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
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
Message-ID: <eb93f12d-2232-4b7e-a7c6-71082a69f1f6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250815061824.765906-1-dongml2@chinatelecom.cn>
 <20250815061824.765906-2-dongml2@chinatelecom.cn>
 <CAADnVQKA98hBSsb02djL-zMsaXQDCjn4Ytck+WP3SWfvgXqDYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKA98hBSsb02djL-zMsaXQDCjn4Ytck+WP3SWfvgXqDYg@mail.gmail.com>

On Fri, Aug 15, 2025 at 04:02:14PM +0300, Alexei Starovoitov wrote:
> On Fri, Aug 15, 2025 at 9:18 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
> >
> > migrate_disable() is called to disable migration in the kernel, and it is
> > used togather with rcu_read_lock() oftenly.
> >
> > However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock()
> > will disable preemption, which will also disable migration.
> >
> > Introduce rcu_migrate_enable() and rcu_migrate_disable(), which will do
> > the migration enable and disable only when the rcu_read_lock() can't do
> > it.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/rcupdate.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 120536f4c6eb..0d9dbd90d025 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -72,6 +72,16 @@ static inline bool same_state_synchronize_rcu(unsigned long oldstate1, unsigned
> >  void __rcu_read_lock(void);
> >  void __rcu_read_unlock(void);
> >
> > +static inline void rcu_migrate_enable(void)
> > +{
> > +       migrate_enable();
> > +}
> 
> Interesting idea.
> I think it has to be combined with rcu_read_lock(), since this api
> makes sense only when used together.
> 
> rcu_read_lock_dont_migrate() ?
> 
> It will do rcu_read_lock() + migrate_disalbe() in PREEMPT_RCU
> and rcu_read_lock() + preempt_disable() otherwise?

That could easily be provided.  Or just make one, and if it starts
having enough use cases, it could be pulled into RCU proper.

> Also I'm not sure we can rely on rcu_read_lock()
> disabling preemption in all !PREEMPT_RCU cases.
> iirc it's more nuanced than that.

For once, something about RCU is non-nuanced.  But don't worry, it won't
happen again.  ;-)

In all !PREEMPT_RCU, preemption must be disabled across all RCU read-side
critical sections in order for RCU to work correctly.

							Thanx, Paul

