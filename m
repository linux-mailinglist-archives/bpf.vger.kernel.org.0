Return-Path: <bpf+bounces-48168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A4A04A03
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6B91887FEA
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF431F3D5D;
	Tue,  7 Jan 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTkSZq82"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F62C187;
	Tue,  7 Jan 2025 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736277500; cv=none; b=YtJNz6oUXItFVOYhvKYfngOPV1TrRfGizeGjL5eI+duHKOgwUSbn1YzppOD6S4Yssdbc3pV56T+HHpKv9iUD4YI0EnxWZNcUDRorJqEUjEtw+dMq2tD4hc8nUsCoRmUz69FmyqVLKG5h145w0VFlKjJNsS9ArxmARoj8OFmn0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736277500; c=relaxed/simple;
	bh=gdnk5FCyLS+bB5ZjXzdUZL7qYYtoJ5kQbEUstU+pYMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZYnWtqBTuRkKtLpt/bWejiUN7mD0Ehf4+kasv8PnAVu7APnMA4LegHtEOw8El9QeFNi/WOsDkv7n3aXQQ/IJeEgtIMvzhiOXFji+kdSNhGHikFWm0QjHbmgekOW+xE6e+Er0I+uNrhzaYQpSUE3fGX8n/jc0KcDF4XRc9uEpKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LTkSZq82; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9fxUZqncY/qyCEH1hTPmyzijZWhew+qCllemJRhAejM=; b=LTkSZq823TDo8tlfwB5uVa1E7b
	M3GEtTsEkUOGGPnUmhj0O8UvwEhikXTio4VGqVImJgQSEhGasdDM7W7otbocU01EEQSeSt2W965d9
	av0fNmHSRxJ06/UdydCvIfpBbdK5qoiKBrMyWfNMG6iWmt3PYBw+1ddhtuDik8pL1bvhhI6hz48fC
	OzkbuhuzRfuJB9WWzy5Msk8xYEma8/r5TSvQH+c5rhONS0Tyw9xJDv/EO4GBB5gnOP5S7Cpa947cJ
	vgNylYbA6FCX/MSeqTqAaq3G4vewK6djJe4DS6f7fFgPu2dlMm4ZpsNik3r7fw6S72KP+NAkl/qlE
	ZrRllHlw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVF5R-00000009Bym-1XGI;
	Tue, 07 Jan 2025 19:18:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D21730057A; Tue,  7 Jan 2025 20:17:56 +0100 (CET)
Date: Tue, 7 Jan 2025 20:17:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 08/22] rqspinlock: Protect pending bit owners
 from stalls
Message-ID: <20250107191756.GA28303@noisy.programming.kicks-ass.net>
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-9-memxor@gmail.com>
 <20250107145159.GB23315@noisy.programming.kicks-ass.net>
 <CAP01T74SHdhtshm3iO_=+W4AHNQSZekJVKwaQn-Sr5up2apKhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T74SHdhtshm3iO_=+W4AHNQSZekJVKwaQn-Sr5up2apKhA@mail.gmail.com>

On Tue, Jan 07, 2025 at 10:44:16PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Tue, 7 Jan 2025 at 20:22, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jan 07, 2025 at 05:59:50AM -0800, Kumar Kartikeya Dwivedi wrote:
> > > +     if (val & _Q_LOCKED_MASK) {
> > > +             RES_RESET_TIMEOUT(ts);
> > > +             smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret));
> > > +     }
> >
> > Please check how smp_cond_load_acquire() works on ARM64 and then add
> > some words on how RES_CHECK_TIMEOUT() is still okay.
> 
> Thanks Peter,
> 
> The __cmpwait_relaxed bit does indeed look problematic, my
> understanding is that the ldxr + wfe sequence can get stuck because we
> may not have any updates on the &lock->locked address, and we’ll not
> call into RES_CHECK_TIMEOUT since that cond_expr check precedes the
> __cmpwait macro.

IIRC the WFE will wake at least on every interrupt but might have an
inherent timeout itself, so it will make some progress, but not at a
speed comparable to a pure spin.

> Do you have suggestions on resolving this? We want to invoke this
> macro as part of the waiting loop. We can have a
> rqspinlock_smp_cond_load_acquire that maps to no-WFE smp_load_acquire
> loop on arm64 and uses the asm-generic version elsewhere.

That will make arm64 sad -- that wfe thing is how they get away with not
having paravirt spinlocks iirc. Also power consumption.

I've not read well enough to remember what order of timeout you're
looking for, but you could have the tick sample the lock like a watchdog
like, and write a magic 'lock' value when it is deemed stuck.

