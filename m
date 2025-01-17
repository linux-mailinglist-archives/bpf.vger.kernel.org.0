Return-Path: <bpf+bounces-49179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6B3A14E9C
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285237A3DF9
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11E1FE477;
	Fri, 17 Jan 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BoBOio13"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF119992C;
	Fri, 17 Jan 2025 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114114; cv=none; b=hXMDT7ScU9APVtshVsuz2HYkW1Gpha0+wNoUdZCNtzQv6SdQDEwcB67wAKNkk7xsIWXzUFN6Grh9u6ksLYgcljri3jB+NaB3Ka6RV3ymcfNAemU0y+pFXve5wPOB2g9yDPMvjuVE014Ydrvi+No9/IsQZFABkMcsXsM697Kkkes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114114; c=relaxed/simple;
	bh=KpmJK9fmGjbWScLvnlO9YfaqIutL+XcKhyQb5yNu/AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPEpb4Kl21iubKYr4z9HmxXnxYWGRqohMVWmXB7GVBjWHIlmLz/fWwruqYlM0SzVmSZfjRH8b0qjrB9Wq5FAXUVAUyTywg32DQzSsDtxxHViAAVzKdIZHrc83TOFHQZD5/7WdmzWXGo/weFeVHDkwTyuIEBump61VoiRi/J/anM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BoBOio13; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KpmJK9fmGjbWScLvnlO9YfaqIutL+XcKhyQb5yNu/AI=; b=BoBOio138WSNTSlaC6VuTK3CzG
	/6TudRXkSpPup6REUJC2gOikLDoXLW/izRfvEcitzjFrwJn5W/g+78ovvqswZj+GN/rRFOyrInbea
	cTm7WtpDw3zYBMyt4jXBAvVAvvXufFYvJ/zbJk61+zeDD+QD9T+hU7uLWZyVZVfA63wcv+6pKNjqg
	cmz5raYhvp9zd/RRlXvL6LWQ4SmT48I2v/BUrdWfCEjHnqGR8SeV5+wVF5F+ucpSbcwmfZyAJthkK
	Jj35k0ZyXThFC5M2XwIyhO03gbY1LXDYBja02Ps5yyyGfZc7E9wWUgol/fEBw5rm32l9hGs8pS4OB
	XRS0Mo/Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYkjD-0000000BPYG-2Sxl;
	Fri, 17 Jan 2025 11:41:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4C4A330057A; Fri, 17 Jan 2025 12:41:30 +0100 (CET)
Date: Fri, 17 Jan 2025 12:41:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <olsajiri@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, tglx@linutronix.de,
	bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250117114130.GB8603@noisy.programming.kicks-ass.net>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114105802.GA19816@redhat.com>
 <Z4ZyYudZSD92DPiF@krava>
 <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
 <20250114203922.GA5051@redhat.com>
 <CAEf4BzaRCzWMVvyGC_T52djF7q65yM8=AdBEMOPUU8edG-PLxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaRCzWMVvyGC_T52djF7q65yM8=AdBEMOPUU8edG-PLxg@mail.gmail.com>

On Tue, Jan 14, 2025 at 01:45:11PM -0800, Andrii Nakryiko wrote:

> someday sys_uretprobe will be old as well

And then we'll delete it because everybody that cares about performance
will have FRED on ;-)

