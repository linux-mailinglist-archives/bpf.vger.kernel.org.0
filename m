Return-Path: <bpf+bounces-49883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF25A1DCE4
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 20:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84541886D34
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F908194A67;
	Mon, 27 Jan 2025 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMRcENEd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960E18FDBD;
	Mon, 27 Jan 2025 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006990; cv=none; b=Z83p7qECkPyZOarzzpONpnhNdp2rTpsHAmuPs/s/GR5xgHiKc1Yr9gc7W410quwnmRsRhIRgI56CA72J83GtDdwDLJA8orvGcyinu/nTye3ccIY8AnJPtwBsmINSGBJuz9gJIgoGTyOWzEcywbRTmW+C1aYh8IHvrV+A09o4aJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006990; c=relaxed/simple;
	bh=iTdO+69RM1LBQsJWCHGCvzAUTh7tuT2jXHCzvASr/3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P95P8P0lcvUBAS3sEUr+mvOHUarG/UP07M3aYMU/TQMc5ka4DCyG/MY5Ht+8obxd7CN/9Wb64bViRp7jrFqsIYgIyvSOPdVLYkAwmDI9RAl5k0QziCAo+19n01OZyV/qi5Lqrj3R39HjUlFCDrAGrwTzZN5idh56TwUUyHUuv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMRcENEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197D1C4CED2;
	Mon, 27 Jan 2025 19:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738006990;
	bh=iTdO+69RM1LBQsJWCHGCvzAUTh7tuT2jXHCzvASr/3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMRcENEdar7TwZvs8QKJy/D5y8srtw/e6uMqZ24FbRjn3LfmDk59Q8wDDZ7PdwzMA
	 wGlnjWJHNUqVkBz399bCcg/XddGxi4b7utnVq6fdVdOINb4PKIxaFrJ4Cv+TPZuOrM
	 2ERSvDF4+Oa0DJElI9n4ylubYhfTlFVK4e7qmLw0X8ULU3CFDj3nl8zokLVpYMkyBc
	 Tst5I6I7NY5Swgo3YUM3djfRzV9d8X/9zBABayOQAwUbq/g94cTC/Z90AT+/sS04Ga
	 o4XVvuGY0IJFKfBFuZC5j3rjLBNbMsb5IAT4NQdxAvP5J8Q9/PWEzXPFWEbmGijaF2
	 fVoGTKJf72i9g==
Date: Mon, 27 Jan 2025 11:43:07 -0800
From: Kees Cook <kees@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, ldv@strace.io,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <202501271142.71C1B5EE6@keescook>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
 <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
 <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
 <202501201334.604217B7@keescook>
 <CAHsH6Gt4EqSz6TrQa+JKG98y8CUTtOM8=dfCVy0fZ8pwXJr1pw@mail.gmail.com>
 <202501271131.7B5C22D@keescook>
 <CAHsH6GtPBt329FeN7K4X4Hqc_uZ=a8uofDN15mqqC4obQ-RK5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GtPBt329FeN7K4X4Hqc_uZ=a8uofDN15mqqC4obQ-RK5g@mail.gmail.com>

On Mon, Jan 27, 2025 at 11:39:44AM -0800, Eyal Birger wrote:
> On Mon, Jan 27, 2025 at 11:33 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Mon, Jan 27, 2025 at 11:24:02AM -0800, Eyal Birger wrote:
> > > Hi Kees,
> > >
> > > On Mon, Jan 20, 2025 at 1:34 PM Kees Cook <kees@kernel.org> wrote:
> > > >
> > > > On Sat, Jan 18, 2025 at 07:39:25PM -0800, Eyal Birger wrote:
> > > > > Alternatively, maybe this syscall implementation should be reverted?
> > > >
> > > > Honestly, that seems the best choice. I don't think any thought was
> > > > given to how it would interact with syscall interposers (including
> > > > ptrace, strict mode seccomp, etc).
> > >
> > > I don't know if you noticed Andrii's and others' comments on this [1].
> > >
> > > Given that:
> > > - this issue requires immediate remediation
> > > - there seems to be pushback for reverting the syscall implementation
> > > - filtering uretprobe is not within the capabilities of seccomp without this
> > >   syscall (so reverting the syscall is equivalent to just passing it through
> > >   seccomp)
> > >
> > > is it possible to consider applying this current fix, with the possibility of
> > > extending seccomp in the future to support filtering uretprobe if deemed
> > > necessary (for example by allowing userspace to define a stricter policy)?
> >
> > I still think this is a Docker problem, but I agree that uretprobe
> > without syscall is just as unfilterable as seccomp ignoring the syscall.
> >
> > Can you please update the patch to use the existing action_cache bitmaps
> > instead of adding an open-coded check? We can consider adding
> > syscall_restart to this as well in the future...
> 
> I can. The main difference as far as I can tell is that it would not
> apply to strict mode. Is that OK? it means that existing binaries using
> strict mode would still crash if uretprobe is attached to them.

Ah, good point. Please also add it to mode1_syscalls for strict. :)

-- 
Kees Cook

