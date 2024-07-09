Return-Path: <bpf+bounces-34223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7844392B4D8
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 12:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90B31C223A1
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 10:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BD15623B;
	Tue,  9 Jul 2024 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Heburb7a"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4812CDB6;
	Tue,  9 Jul 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519904; cv=none; b=SoE9vfNoMMU8ND7Qs85myndHelEdwtoZgz4lpZRC33zIdxLxJ7weuI4P66llJLKEgjF6TmIcrtNeSYm90sPXqLiK4WasYd+8DPPQBg6P9P7NabNDoD2b1MmGiXsrOyPkfzt8C6XqakEelJDttU7rWm2CLB7ywLamMBgsX6MNPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519904; c=relaxed/simple;
	bh=e5M3p0E1OnXLX+OksumOytxTx8GR6YV6i9LlmZ9r+Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQWC7pgd/XU2iS6iQgib41PUk0AeWQKMFBclRmhGaGEnVHoTy7X0MU+1kJLJWBBcapHL9Lvm81eGKuJEFqgVKdpKuoe2zybJX3Krj0DpW2bIfLWh9n0Cw/Xlpbco7pwDdZ2LqnU/HkweSqozpictNGXwcs7dbc+Wk6moDQ33vnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Heburb7a; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OP++PZjIdf0qPn4jB/USA0uLfYgm46JE6m2j6PR23Ks=; b=Heburb7aDknCv9CpbNOxE/4hhj
	YmnWdkiGQInGRs51gTHtcNzz/2Rutv3iHu9X0p3awhekwpcKjxsEGqRqELnP/idw+KTczZXj3fzUA
	XvJoWx3EptwErqlXLR3ggjw9bTClodrTb7bPdc+y3m110e0DjdBtsm/lg4Mv8S1qs4MTQkMJjWn4C
	eVTnoyTKR+0JpWM69xcj9kgemavnfv/N11agPJSYq0Z9MpSbXeWWgBZw6SLJ63Q2VSpn7OAPpmuPl
	HJzsykVGTT7ZlKy4FwH4FGH+UkuQBVGQ+ws2d/6v2QIluqrfG+nKq4Hk+FwajhGPhqTT2+BvQ4OgU
	cAtUsR/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR7os-00000000iwt-3agU;
	Tue, 09 Jul 2024 10:11:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C438F3006B7; Tue,  9 Jul 2024 12:11:33 +0200 (CEST)
Date: Tue, 9 Jul 2024 12:11:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com,
	tglx@linutronix.de, jpoimboe@redhat.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240709101133.GI27299@noisy.programming.kicks-ass.net>
References: <20240708231127.1055083-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708231127.1055083-1-andrii@kernel.org>

On Mon, Jul 08, 2024 at 04:11:27PM -0700, Andrii Nakryiko wrote:
> +#ifdef CONFIG_UPROBES
> +/*
> + * Heuristic-based check if uprobe is installed at the function entry.
> + *
> + * Under assumption of user code being compiled with frame pointers,
> + * `push %rbp/%ebp` is a good indicator that we indeed are.
> + *
> + * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
> + * If we get this wrong, captured stack trace might have one extra bogus
> + * entry, but the rest of stack trace will still be meaningful.
> + */
> +static bool is_uprobe_at_func_entry(struct pt_regs *regs)
> +{
> +	struct arch_uprobe *auprobe;
> +
> +	if (!current->utask)
> +		return false;
> +
> +	auprobe = current->utask->auprobe;
> +	if (!auprobe)
> +		return false;
> +
> +	/* push %rbp/%ebp */
> +	if (auprobe->insn[0] == 0x55)
> +		return true;
> +
> +	/* endbr64 (64-bit only) */
> +	if (user_64bit_mode(regs) && *(u32 *)auprobe->insn == 0xfa1e0ff3)
> +		return true;

I meant to reply to Josh suggesting this, but... how can this be? If you
scribble the ENDBR with an INT3 things will #CP and we'll never get to
the #BP.

Also, we tried very hard to not have a literal encode ENDBR (I really
should teach objtool about this one :/). If it somehow makes sense to
keep this clause, please use: gen_endbr()

