Return-Path: <bpf+bounces-54586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D2A6D140
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 22:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8712A7A3301
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 21:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0B1A5B93;
	Sun, 23 Mar 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbjbcgR+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839943ABC;
	Sun, 23 Mar 2025 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742765902; cv=none; b=ZZp5aZJbWIxoTbqmbbWFX/p7XmIJt/UhqR+SSW6nztR04ISfPRCfU9ZNj1XvCluVeyVTABZ1h48oUsTqedovVDC/eWtqw6sTy5BSmkT+AgwNmAjUGlfBHj4RIWaxq99B7cH04WZ9tcCcrAFSuCRjPGtKZeJ9KXUM6ZkfDnd94ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742765902; c=relaxed/simple;
	bh=/LdUmRuYDzZ+pcAfIi5jUxXTqjVbMP2bRgHPhCCF4D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCQ8Dfm0McJYOTp7z2v3b78diTb33xe5s+vg9oLDkohSzQF5LVyqWL8Tj9q/GdfsK6Xboju/UUqx+LZ5wqZZ5/6stEN2WiwYQ6RZYyS9zEbcMlyQ2dy8h9meHxiJAdhtg5dCH+HBxoLWbepLqOMhq7lu8Kjn5cejfGhZHnHu4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbjbcgR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5BEC4CEE2;
	Sun, 23 Mar 2025 21:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742765902;
	bh=/LdUmRuYDzZ+pcAfIi5jUxXTqjVbMP2bRgHPhCCF4D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbjbcgR+0uUDC4g6AP44WMqSQsAIlhpwUhszEjDRqqCAQU4i99GTtqM7Et6HLyg3A
	 OsDVD5FdDr4tr5DDikKDkmLGniV/wRYZxeyuA+oyJGhx8XPLX4RKuwxJkCGk8qjYws
	 exUvKr7wxGUjLXoA0m1qdjI7Llkq9ssplGQ8W06Wu9ZhcUA8wtMsyfUKaictCUrWdX
	 0rcmB4KCYg+xBVX5pDoZAxN69qG7H6sTyND7VOEdSb00+fpG53zrb+PpELV83MgNiz
	 u1QptBokjnKlE2okiS5pdFHdNMIK7pN7D8ID+Mj9QqPsNkEvhA0/egG+c78aT3jYmV
	 v7UCZThwQVX5g==
Date: Sun, 23 Mar 2025 22:38:15 +0100
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
Message-ID: <Z-B_R737uM31m6_K@gmail.com>
References: <20250323072511.2353342-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323072511.2353342-1-edumazet@google.com>


* Eric Dumazet <edumazet@google.com> wrote:

> eBPF programs can be run 20,000,000+ times per second on busy servers.
> 
> Whenever /proc/sys/kernel/bpf_stats_enabled is turned off,
> hundreds of calls sites are patched from text_poke_bp_batch()
> and we see a critical loss of performance due to false sharing
> on bp_desc.refs lasting up to three seconds.

> @@ -2413,8 +2415,12 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	/*
>  	 * Remove and wait for refs to be zero.
>  	 */
> -	if (!atomic_dec_and_test(&bp_desc.refs))
> -		atomic_cond_read_acquire(&bp_desc.refs, !VAL);
> +	for_each_possible_cpu(i) {
> +		atomic_t *refs = per_cpu_ptr(&bp_refs, i);
> +
> +		if (!atomic_dec_and_test(refs))
> +			atomic_cond_read_acquire(refs, !VAL);
> +	}

So your patch changes text_poke_bp_batch() to busy-spin-wait for 
bp_refs to go to zero on all 480 CPUs.

Your measurement is using /proc/sys/kernel/bpf_stats_enabled on a 
single CPU, right?

What's the adversarial workload here? Spamming bpf_stats_enabled on all 
CPUs in parallel? Or mixing it with some other text_poke_bp_batch() 
user if bpf_stats_enabled serializes access?

Does anything undesirable happen in that case?

Thanks,

	Ingo

