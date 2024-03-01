Return-Path: <bpf+bounces-23210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD786EBD8
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 23:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7C71C215EE
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A059B54;
	Fri,  1 Mar 2024 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyKTYPwx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71C3BB33;
	Fri,  1 Mar 2024 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332165; cv=none; b=t1ONf4TQukZ4fIZGzWadO9Zos2+UrWIbQM2P5QCCvPLwFe58tXnaG4echmR6NHu988MxyPUhDoPpmhxdhaAc0Ue9WBEP/9sqwrmIuSKVrn9QTijA6z9/c1HaYy4w1v30ws3OmBiwxSiMrNSzv30obf8lFgOWyeRqwXJhxnpO3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332165; c=relaxed/simple;
	bh=5Xj1ur1qN0aF23NjoAtLbU1HDSoN1Q1krN4IozUzHS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkTn8UjOwT3VKhOUSUPugmpmDb6iv5nGWNPc5/bhj8+IidKhIdA4JjVANuAnpjmx9rhnd3+TiwGW6YdAHZih9Xfbn7L8+c4r9upb0hj5yEJu5J+Y1BEL+tBh/qJLEU3uNjdqLy/bNrzrZ376CsCBIrc8v9NWx+FZbZvC7itrgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyKTYPwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96062C433C7;
	Fri,  1 Mar 2024 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709332164;
	bh=5Xj1ur1qN0aF23NjoAtLbU1HDSoN1Q1krN4IozUzHS8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZyKTYPwxbK8Wo4eDEQ4y1DTJrke0mAEg32I1SIdrsksERipv9lSZGApGvsRLPh/DG
	 RY4vXU1etymGhG88U97Lnl1v5N1Z+MAVrvcOGrxh8DaOxsDDDSQjRR0hbDUntXNqg9
	 cPibmPieh7K5sJW3jMHndyT0EkYCBC3t6BAyGdZUDtb6hL6rpyf7kkN9ZUVKtdUlAN
	 eCTdhMJoemcPGfDWc8PbRXfiAFTbe/S6AvIV0TYF8h78CyjtBYjAX8MZyon9sCBJUI
	 TID3yvumGoT79UVsrpmoXELbPTu2q8Pxnwjgl+m+BZm3zg7Q6SwmvEaj4WY81uIpOC
	 xhLSx1/hnZPCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B6AFCE140C; Fri,  1 Mar 2024 14:29:19 -0800 (PST)
Date: Fri, 1 Mar 2024 14:29:19 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
Message-ID: <ed57b5fa-8b44-48de-904e-fe8da1939292@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZeFPz4D121TgvCje@debian.debian>
 <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
 <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
 <CAO3-PboZwTiSmVxVFFfAm94o+LgK=rnm1vbJvMhzSGep+RYzaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-PboZwTiSmVxVFFfAm94o+LgK=rnm1vbJvMhzSGep+RYzaQ@mail.gmail.com>

On Fri, Mar 01, 2024 at 11:30:29AM -0600, Yan Zhai wrote:
> Hi Eric,
> 
> On Fri, Mar 1, 2024 at 2:30 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > I could not see the reason for 1sec (HZ) delays.
> >
> > Would calling rcu_softirq_qs() every ~10ms instead be a serious issue ?
> >
> The trouble scenarios are often when we need to detach an ad-hoc BPF
> tracing program, or restart a monitoring service. It is fine as long
> as they do not block for 10+ seconds or even completely stall under
> heavy traffic. Raising a QS every few ms or HZ both work in such
> cases.
> 
> > In anycase, if this all about rcu_tasks, I would prefer using a macro
> > defined in kernel/rcu/tasks.h
> > instead of having a hidden constant in a networking core function.
> 
> Paul E. McKenney was suggesting either current form or
> 
>          local_bh_enable();
>          if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>                  rcu_softirq_qs_enable(local_bh_enable());
>          else
>                  local_bh_enable();
> 
> With an interval it might have to be
> "rcu_softirq_qs_enable(local_bh_enable(), &next_qs);" to avoid an
> unnecessary extern/static var. Will it make more sense to you?

I was thinking in terms of something like this (untested):

	#define rcu_softirq_qs_enable(enable_stmt, oldj) \
	do { \
		if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
		    time_after(oldj + HZ / 10, jiffies) { \
			rcu_softirq_qs(); \
			(oldj) = jiffies; \
		} \
		do  { enable_stmt; } while (0) \
	} while (0)

Then the call could be "rcu_softirq_qs_enable(local_bh_enable(), last_qs)",
where last_qs is initialized by the caller to jiffies.

The reason for putting "enable_stmt;" into anothor do-while loop is
in case someone typos an "else" as the first part of the "enable_stmt"
argument.

Would that work?

							Thanx, Paul

