Return-Path: <bpf+bounces-45018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C13C9CFFD0
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8015D1F21042
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F9918787F;
	Sat, 16 Nov 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="t1B0plXG"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E183C8C7;
	Sat, 16 Nov 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773739; cv=none; b=jPHklaCca0UNYJhKVyrkFrWocI4M+RXvneRYg5tIs0+5Pi/TdL+L247floN7geg7eEOp/PVcAhMoMI1wm+poeujfgPZbgZyu8W49c4u8FX1lR6vAX8P2+ufjeH+f0zWT818g+DqlKnSPJMYvKdc5SxALu8zpuLOnjvhnwbZVjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773739; c=relaxed/simple;
	bh=BIM1Jk1WfWD8u+/mNfra30CaiC1sEYqJ/6LciJmtljk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9zjsVXuYORhonXDgzUuZQLkcpRddYI/GPszLwzZWGZmFvV7Hv8yTCp3v6WyHwx+b4Y9HnSgmz6G2RGrrbkRaB+T6CrjcIl2njbxNZujAGMFSqLJa7qe1T9CWSwOtOOEkZIh9JBFvS2tz3qL9/Kho2rnbHbgIJM/tGZspJ+6zz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=t1B0plXG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731773734;
	bh=BIM1Jk1WfWD8u+/mNfra30CaiC1sEYqJ/6LciJmtljk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1B0plXGSm38raN82fLD9vJnfnurcFtNEbeXCxfNtVhIhamAMXzKsQ6IPQlMGNepB
	 zbYJF6rXxD6gdid87FVztpBkkUq1PwVvYCNVE1AkxEej90/0mHUVlvWojvQNQea3ik
	 qYUm1yCOk4zG0k2KFnFU2QW+VWZMNrapArUPS2DQ=
Date: Sat, 16 Nov 2024 17:15:33 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, clrkwllms@kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-devel@lists.linux.dev, syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
Message-ID: <1ed46394-f065-4e8b-8f37-c450b0c1b3a9@t-8ch.de>
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
 <87v7wsmqv4.ffs@tglx>
 <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev>
 <87sersyvuc.ffs@tglx>
 <20241116092102.O_30pj9W@linutronix.de>
 <CAADnVQ+ToRZ6ZQL44Z9TAn6c=ecqrDgrnJenH7-miHJSWe7Nsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+ToRZ6ZQL44Z9TAn6c=ecqrDgrnJenH7-miHJSWe7Nsw@mail.gmail.com>

On 2024-11-16 08:01:49-0800, Alexei Starovoitov wrote:
> On Sat, Nov 16, 2024 at 1:21 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2024-11-15 23:29:31 [+0100], Thomas Gleixner wrote:
> > > IIRC, BPF has it's own allocator which can be used everywhere.
> >
> > Thomas Weißschuh made something. It appears to work. Need to take a
> > closer look.
> 
> Any more details?
> bpf_mem_alloc is a stop gap.

It is indeed using bpf_mem_alloc.
It is a fairly straightforward conversion, using one cache for
intermediate and one for non-intermediate nodes.

I'll try to send it early next week.

> As Vlastimil Babka suggested long ago:
> https://lwn.net/Articles/974138/
> "...next on the target list is the special allocator used by the BPF
> subsystem. This allocator is intended to succeed in any calling
> context, including in non-maskable interrupts (NMIs). BPF maintainer
> Alexei Starovoitov is evidently in favor of this removal if SLUB is
> able to handle the same use cases..."
> 
> Here is the first step:
> https://lore.kernel.org/bpf/20241116014854.55141-1-alexei.starovoitov@gmail.com/

