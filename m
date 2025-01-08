Return-Path: <bpf+bounces-48231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC4A05693
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3173218888EA
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 09:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9F41F0E5E;
	Wed,  8 Jan 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WgHj+ihJ"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C651EB9ED;
	Wed,  8 Jan 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327915; cv=none; b=XWdkR76b32MIkhShjJqfAYCrRTZJOEwXAA020Azu+McJbS5B0nEExvSlBW69TFpTfrCQoGqSO4DiicV2NgWqtAw4lTQjxnN7kAyPJYUlPM20Re6GSEZxMkBIBTwUAxnu/tWn6ROH2s+AETCHf4A4VX58yQFLgKDeYYME4w+jp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327915; c=relaxed/simple;
	bh=5xg2Gqn+MSHjFu8Rlm64KjN9d+JLhIhsJOsp65ICYX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T814X2/yytXT2yGHJIXybwVHy3TyDsCE3EhQ9MrVOf1GFzrdP/PXfk119gnBbStAeNsDaxoOqcHsS4MEvxIpKqD42VJQ2IWtq/E49o2qLu22BWZ8WzUZEoysLKk9D5gXqYqeC08G13/NPS4i83jXgMUaYP3LgGYt6RklUxfU2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WgHj+ihJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ONVopvVQNGVAsAehHnnloX8BOAjlwQgA+K8ochM/nwg=; b=WgHj+ihJOZrGEq7Ahi3onFGPEQ
	2rNpEDiKrRjvpb9J03W21xPEYuJphgq8r80xs+YLhTBMkoZHPZptTHw5eHjD8qEIe+ai8ToPmG04S
	TKeMoG9BD0r22sjiJUxGwHVJpqf6EIA+p+jPj9hq1yCi0UcCFg0oAUTo0DCn22p6pnS79KUUXo7DT
	bysjn7mf6z1+a1v2BZVZUx0is6Ske8htsCnY9wv5/1iv29xj+jxyIUqzI0GMSQ7wWGhOxEQfbL2jM
	3sENb+IB0MzeZ8bwf0mH7Vb6YRYe4Kae1lebNOuRddafU/sGRXg13h0UXZTEn7WXNU3cBfbT1Epqc
	ncbkEezg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVSCp-00000009KH9-2P0I;
	Wed, 08 Jan 2025 09:18:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2ED523005D6; Wed,  8 Jan 2025 10:18:27 +0100 (CET)
Date: Wed, 8 Jan 2025 10:18:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
Message-ID: <20250108091827.GF23315@noisy.programming.kicks-ass.net>
References: <20250107140004.2732830-1-memxor@gmail.com>
 <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>

On Tue, Jan 07, 2025 at 03:54:36PM -0800, Linus Torvalds wrote:
> On Tue, 7 Jan 2025 at 06:00, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
> > res_spin_lock() and res_spin_unlock() APIs).
> 
> So when I see people doing new locking mechanisms, I invariably go "Oh no!".
> 
> But this series seems reasonable to me. I see that PeterZ had a couple
> of minor comments (well, the arm64 one is more fundamental), which
> hopefully means that it seems reasonable to him too. Peter?

I've not had time to fully read the whole thing yet, I only did a quick
once over. I'll try and get around to doing a proper reading eventually,
but I'm chasing a regression atm, and then I need to go review a ton of
code Andrew merged over the xmas/newyears holiday :/

One potential issue is that qspinlock isn't suitable for all
architectures -- and I've yet to figure out widely BPF is planning on
using this. Notably qspinlock is ineffective (as in way over engineered)
for architectures that do not provide hardware level progress guarantees
on competing atomics and qspinlock uses mixed sized atomics, which are
typically under specified, architecturally.

Another issue is the code duplication.

Anyway, I'll get to it eventually...

