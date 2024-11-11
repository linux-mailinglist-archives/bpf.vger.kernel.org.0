Return-Path: <bpf+bounces-44535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007439C442F
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8621F265AD
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24881AA793;
	Mon, 11 Nov 2024 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGW9RJsJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06E1A725E;
	Mon, 11 Nov 2024 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347506; cv=none; b=ra7Osb96zCvRG/lYFFAaRObN7nPjlnVh3HeXs+06379RjG3E7JVkhjYH8OuJACzlfTS7HuWnhWwhB4Gog1COaaoYG9zBx3L6aLhYmsBtT1sOt1SvmanY/PI4QNT+YLgvpd2QVmLJWOkxynax+WWVMIAtfT4UAc2obZjc8CYDJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347506; c=relaxed/simple;
	bh=BbKFMf/zgfJJywRXAq3rAWpxUsMiJjrwpn3KzCpxqWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjtVpf3s1ZRUAHTg3UD6ocgqGLsD/6j7jwqmnpOzTS9Tgefg/YyHgQufh2xzNjI77+fSiNrLjmJiutNCB0Sl0IWENrA7l83CYYr0YQJBptcP1fW3IcpGgleu5NtJLaukGAkmPPpHMA1RouPECbOTeUb0rva80hR6wMLIYMtoaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGW9RJsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6D9C4CECF;
	Mon, 11 Nov 2024 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347505;
	bh=BbKFMf/zgfJJywRXAq3rAWpxUsMiJjrwpn3KzCpxqWI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OGW9RJsJ60Q2RLevpJZg2Jdcya1/+oWaZNpRYiO4TyzYJMbI9sG2wDHyKyGODfW36
	 YrdQ1liIOWwOjaQh2EP7TtnyZ6s7PKd5MAqOOIZdnSQUlT1XwFZrY3svz2FjIPickN
	 xkHEG4D09iBm3Zvp8tFlXqtYoXPKo7PHXc3zqjsUI5jUfR+EiuigZr+iWYmjj1XKTK
	 z2jqh7ilN00HpFZD7HCLyusO8F4kFi3i+0Gr2EkGxihHP2aPYzEVIhjseOOW4JxPGK
	 X8cNqnNf0WH0y9pg1Kr4jlB5/JN5xI20GZ6T9UHDnw/mcNjf2k76HMrsyzOnxA+d+3
	 pGZEX4TQDG+2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 19F4CCE09DE; Mon, 11 Nov 2024 09:51:45 -0800 (PST)
Date: Mon, 11 Nov 2024 09:51:45 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 08/15] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
Message-ID: <722827bc-fc48-4ae0-aa6a-b28d8ab8dfbb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-8-paulmck@kernel.org>
 <d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com>
 <0726384d-fe56-4f2d-822b-5e94458aa28a@paulmck-laptop>
 <CAEf4BzbMOSfQ3gdhujUyz_NuiDG7w74n7n52ZO5VCyc-XKOeQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbMOSfQ3gdhujUyz_NuiDG7w74n7n52ZO5VCyc-XKOeQg@mail.gmail.com>

On Mon, Nov 11, 2024 at 09:46:22AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 11, 2024 at 7:17 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Nov 11, 2024 at 04:47:49PM +0530, Neeraj Upadhyay wrote:
> > >
> > > > +/**
> > > > + * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
> > > > + * @ssp: srcu_struct in which to unregister the old reader.
> > > > + * @idx: return value from corresponding srcu_read_lock().
> > > > + *
> > > > + * Exit a light-weight SRCU read-side critical section.
> > > > + */
> > > > +static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
> > > > +   __releases(ssp)
> > > > +{
> > > > +   WARN_ON_ONCE(idx & ~0x1);
> > > > +   srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
> > > > +   srcu_lock_release(&ssp->dep_map);
> > > > +   __srcu_read_unlock(ssp, idx);
> > >
> > > s/__srcu_read_unlock/__srcu_read_unlock_lite/ ?
> >
> > Right you are!  I am testing the patch.
> >
> > The effect of this bug is that srcu_read_unlock_lite() has a needless
> > memory barrier and fails to check for RCU watching, so not a blazing
> > emergency.  But it does mean that Andrii was only seeing half of the
> > performance benefit of using _lite().
> 
> That's exciting, happy to re-test once we have fixed patches.

Neeraj also found a functional error, so a bit more work to do.
Better him finding it that me doing so the hard way!  ;-)

							Thanx, Paul

