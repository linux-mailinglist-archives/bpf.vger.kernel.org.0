Return-Path: <bpf+bounces-48307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D6A06731
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 22:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC95C1889011
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A020408A;
	Wed,  8 Jan 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqYKN/+T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B521A23B5;
	Wed,  8 Jan 2025 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736371849; cv=none; b=U/3D0vuHEjRgQXGoPuz/q4xaQrwMnLUVj0k3HfIHSkLho6I+lEE4KauMq/D3uMjk1HmunEyBHbDgCatstshyH1WPUf3rBLXge8eIgoT/nJDhoqmoVOUfAugbTEftnbMtO4puNnMkUJpy8yIQdq4g5BhhB4WmfseOumIwGVO+Bl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736371849; c=relaxed/simple;
	bh=rb5YmYqctd7RUTKSEJOTa3UjngpkBPPZxOkW+lJ7ggk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czNkuXbMMWw/HtjC26D//+2fBMexAYoT58DNkgLhO4z/yHBTwyNwt+U4ThBuFOC1o5XBIS/egaICCB0Cbsh21kjsD6NdEGk2wz0f2hH+m5nhoNM6ulq58XebZy4BoBrfc2SfryB8OTKYHm3dLxn6wHt7z0FsRvonCmHe+qxCyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqYKN/+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F14FC4CED3;
	Wed,  8 Jan 2025 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736371849;
	bh=rb5YmYqctd7RUTKSEJOTa3UjngpkBPPZxOkW+lJ7ggk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iqYKN/+TjNkTtlgWO8D4n2pkqEjPF9ilGi1W9a7AYyMwdopv4ao60ixi+Jy7YwTy4
	 XAPJ+XgPTmGiAMxqYk8iLuDn4vB/YqXn7WCpX0anaC0dZTbBPdZZ4SIN3J4G6w693m
	 yp70TInwEYuu6SE9WrUiOI1aZmI1vQgGHRv/fJX3TfDzQlmk83p++PyNEo0DT/TC1T
	 vW26CBMebIGtfuj1OVObd9akTPuktxNVR8PY0XHuWKkHPKKC683dAXF0Xx4QLYy53u
	 tV9SY9T1sVi5gdPKTDkXFTHB150XL47ycRNmOu49u/QQw4h74RLL7mZTWtSRQH5qkQ
	 p447wWsgL+9Qw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B5985CE134A; Wed,  8 Jan 2025 13:30:48 -0800 (PST)
Date: Wed, 8 Jan 2025 13:30:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
Message-ID: <4d037057-8d05-47ed-8f90-8417b0002722@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250107140004.2732830-1-memxor@gmail.com>
 <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>
 <20250108091827.GF23315@noisy.programming.kicks-ass.net>
 <CAP01T75XoSv91C6oT8WSFrSsqNxnGHn0ZE=RbPSYgwX79pRQVA@mail.gmail.com>
 <CAHk-=wiWxnjFkqG9VLm0N3Nj4U7Y3JNvyshmjdwdD_=7_zZriw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWxnjFkqG9VLm0N3Nj4U7Y3JNvyshmjdwdD_=7_zZriw@mail.gmail.com>

On Wed, Jan 08, 2025 at 12:30:27PM -0800, Linus Torvalds wrote:
> On Wed, 8 Jan 2025 at 12:13, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Yes, we also noticed during development that try_cmpxchg_tail (in
> > patch 9) couldn't rely on 16-bit cmpxchg being available everywhere
> 
> I think that's purely a "we have had no use for it" issue.
> 
> A 16-bit cmpxchg can always be written using a larger size, and we did
> that for 8-bit ones for RCU.
> 
> See commit d4e287d7caff ("rcu-tasks: Remove open-coded one-byte
> cmpxchg() emulation") which switched RCU over to use a "native" 8-bit
> cmpxchg, because Paul had added the capability to all architectures,
> sometimes using a bigger size and "emulating" it: a88d970c8bb5 ("lib:
> Add one-byte emulation function").

Glad you liked it.  ;-)

> In fact, I think that series added a couple of 16-bit cases too, but I
> actually went "if we have no users, don't bother".

Not only that, there were still architectures supported by the Linux
kernel that lacked 16-bit store instructions.  Although this does not
make 16-bit emulation useless, it does give it some nasty sharp edges
in the form of compilers turning those 16-bit stores into non-atomic
RMW instructions.  Or tearing them into 8-bit stores.

So yes, I dropped 16-bit emulated cmpxchg() from later versions of that
patch series.

When support for those architectures are dropped, I would be happy to do
the honors for 16-bit cmpxchg() emulation.  Or to review someone else's
doing the honors, for that matter.  ;-)

							Thanx, Paul

