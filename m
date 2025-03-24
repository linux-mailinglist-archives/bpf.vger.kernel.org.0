Return-Path: <bpf+bounces-54599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C51A6D5C5
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 09:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80CC18929A5
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C825C719;
	Mon, 24 Mar 2025 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGynYWlj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACD18B470;
	Mon, 24 Mar 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803498; cv=none; b=UwsiaRbUHEu/0fwmQDSunjEPu7/C5npCWB7PtwRo9tC+0CApuKy9mhfgPjZ+qM3TxgjlOGJ6zrLpns4pq9V9mruJ5m0FAMwAGYVFyw8XwyHxfg8kuyzC/GyWXKDNwE0+l1RoRaOjpMX4TsZTOygyCqiR11ya89wxTteW6qOEv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803498; c=relaxed/simple;
	bh=2gSLluaFzVDaLqnWsNk8sVoYQ+2ifhmEkiUog9vfzOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG3S9crPCTFVKvZ2Mm7IwuL2fTylTkaB5/iYpZHfzRkJjweMmHEa8Dx+f4/PRL/7nHNvR9+S0+dshnthnnporcsN6KxbBhnaz9mbdrZ0monf1mEhRl4kvoAO52ywuP1WGY+5A45PR4yGBDA1vzFB4KRFYU9Fydun34tE5gZgrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGynYWlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1451BC4CEDD;
	Mon, 24 Mar 2025 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742803497;
	bh=2gSLluaFzVDaLqnWsNk8sVoYQ+2ifhmEkiUog9vfzOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGynYWljYVwsjBkFfRfR2JqFmEpoDbpRvYy/VqSO977TnZaXU4Bqk5Oi73yGNsmzT
	 7pO8mPc/CiqmEsMhvsQzsbZXEOombY5TdnaCSfSfgApcR2oCoiIdWRKlh9mJtg5ndZ
	 ZhzacUowUFkM878v9z5W7PQoaum7xVkkGN5wDtaipvu3OiXv/NaFWGjJs3UKPxQG/a
	 6FNJvUVt3Q+wKg15fZGoNsDTxCz9fewYvF3ESQyZ9R/w7TwDx4eZXjY5a53p4eeG71
	 gbuR5LjomfD8yWv/AN9/7d+wEf5Zwa6jOnexDlxYy9GM0qKEVF602UKdYGgL5RTJ5X
	 Zpooy1FVRPvcg==
Date: Mon, 24 Mar 2025 09:04:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <Z-ESIogCNDiHz4NG@gmail.com>
References: <20250323072511.2353342-1-edumazet@google.com>
 <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com>
 <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
 <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>


* Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Mar 24, 2025 at 8:47 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Mar 24, 2025 at 8:16 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > > > What's the adversarial workload here? Spamming bpf_stats_enabled on all
> > > > > CPUs in parallel? Or mixing it with some other text_poke_bp_batch()
> > > > > user if bpf_stats_enabled serializes access?
> > >             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >
> > > > > Does anything undesirable happen in that case?
> > > >
> > > > The case of multiple threads trying to flip bpf_stats_enabled is
> > > > handled by bpf_stats_enabled_mutex.
> > >
> > > So my suggested workload wasn't adversarial enough due to
> > > bpf_stats_enabled_mutex: how about some other workload that doesn't
> > > serialize access to text_poke_bp_batch()?
> >
> > Do you have a specific case in mind that I can test on these big platforms ?
> >
> > text_poke_bp_batch() calls themselves are serialized by text_mutex, it
> > is not clear what you are looking for.
> 
> 
> BTW the atomic_cond_read_acquire() part is never called even during my
> stress test.

Yeah, that code threw me off - can it really happen with text_mutex 
serializing all of it?

> @@ -2418,7 +2418,7 @@ static void text_poke_bp_batch(struct
> text_poke_loc *tp, unsigned int nr_entries
>         for_each_possible_cpu(i) {
>                 atomic_t *refs = per_cpu_ptr(&bp_refs, i);
> 
> -               if (!atomic_dec_and_test(refs))
> +               if (unlikely(!atomic_dec_and_test(refs)))
>                         atomic_cond_read_acquire(refs, !VAL);

If it could never happen then this should that condition be a 
WARN_ON_ONCE() perhaps?

Thanks,

	Ingo

