Return-Path: <bpf+bounces-63673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205AB09657
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 23:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8393A964F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C233C231839;
	Thu, 17 Jul 2025 21:26:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5218F1DE4E1;
	Thu, 17 Jul 2025 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752787597; cv=none; b=cyCBr0bsq8du0r7rp5HVX1NfYL7vp51cX0pnhc9utHDgf773cWh6l8AmI/xPcvXSMbqACdU9IWB0+LDimBThzghRAjLY4uxAYsUrIqZilTKVGchgcmMDW3YFC91JTeMPqOLoyxT/F7y5yB2ePuIGXeZBGPcAQXVWswiC1yTJimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752787597; c=relaxed/simple;
	bh=91tOrToOHduYdlbBS11+MtbUYmMDSyKuWHwf50X1irw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwqSJxbSYeqRvICVCUAyt1Uhvu15GrqwQithpFzkoWgbtbehm6wmDzvBZh+3INKWvw594DDqrYsW/jMr9oVcdNa3fL8Y3/x9cyJKo74Q2YOHFGkMD2pkPivmrws1dajCKMyykb8ryYDz3jg9L4urDQd9DAVWq7SI4uFFd6t1OdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 683CD60E4D; Thu, 17 Jul 2025 23:26:32 +0200 (CEST)
Date: Thu, 17 Jul 2025 23:26:32 +0200
From: Florian Westphal <fw@strlen.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	netfilter-devel <netfilter-devel@vger.kernel.org>,
	syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 bpf] bpf: Disable migration in nf_hook_run_bpf().
Message-ID: <aHlqiEaG43iqUsOX@strlen.de>
References: <20250717185837.1073456-1-kuniyu@google.com>
 <CAADnVQJdn5ERUBfmTHAdfmn0dLozcY6FHsHodNnvfOA40GZYWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJdn5ERUBfmTHAdfmn0dLozcY6FHsHodNnvfOA40GZYWg@mail.gmail.com>

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > Let's call migrate_disable() before calling bpf_prog_run() in
> > nf_hook_run_bpf().

Or use bpf_prog_run_pin_on_cpu() which wraps bpf_prog_run().

> > Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
> 
> Fixes tag looks wrong.
> I don't think it's Daniel's defrag series.
> No idea why syzbot bisected it to this commit.

Didn't check but I'd wager the bpf prog attach is rejected due to an
unsupported flag before this commit.  Looks like correct tag is

Fixes: fd9c663b9ad6 ("bpf: minimal support for programs hooked into netfilter framework")

I don't see anything that implicitly disables preemption and even 6.4 has
the cant_migrate() call there.

> > +       unsigned int ret;
> >
> > -       return bpf_prog_run(prog, &ctx);
> > +       migrate_disable();
> > +       ret = bpf_prog_run(prog, &ctx);
> > +       migrate_enable();
> 
> The fix looks correct, but we need to root cause it better.
> Why did it start now ?

I guess most people don't have preemptible rcu enabled.

