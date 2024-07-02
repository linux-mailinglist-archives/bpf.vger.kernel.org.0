Return-Path: <bpf+bounces-33702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB3924C0B
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 01:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A1AB21343
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6526149DF0;
	Tue,  2 Jul 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgYDy9Nz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9B1DA310;
	Tue,  2 Jul 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962195; cv=none; b=uttknOHTjfPgenf5fOQ069bpbQvbocjAAGFHuYuxFDxcpVNMqhcT1QqbtkenLYf3s2bwh2hqcUImSDSrSYyxhxQlvO9qG2wlMp5FDVT2J7/3mtm0zxB67VUQ99s8taZvWc2VO8QZOoAo4s3H0WiHIq8TTBXE1uY6XoCbpq2WOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962195; c=relaxed/simple;
	bh=uGqt+NmSAxykzOZPEEPI8Op9DF7EbIbtDsiQasAIoms=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aTjdivzZghcnxXyC/ZWAtIrZ97xsz3XU3a6L5W38OSSQzBMwXmtJvi6w+dz/zXOEQPUfPz4Z3eIPObPeAscnCigMSAa6I8+GQrfzA04vvgjUhYRNf4VCtcSFflTZNMFMNrVIq/J6XlvrXpmu2d6q6se7ZEBT2tDhOVE+FbjhUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgYDy9Nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2263BC116B1;
	Tue,  2 Jul 2024 23:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719962194;
	bh=uGqt+NmSAxykzOZPEEPI8Op9DF7EbIbtDsiQasAIoms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XgYDy9NzWcWzb3elfREPi1nf3kDzqxS5FGgj8XdoorQgUNELWmcNWMGbPYiPju61M
	 QSVBhs8SyMlSMvAz3Kci5JCct+F/Jl5Ffd5HE4JEWnI/B8g1/6C+a1XTa8QcQOtECR
	 HtHbNiWIOfn8xtkg8d2Mi8EQbUcI9wjvRyyPUC67FwmwMhnJulLJ4bkk05t8jjrgJy
	 lqHCcpZjucTfhNqP7NtQDFJ86kbPHWYTj2L9sPFOcYN7xUo0molEuxEsKbQBhqwiJ2
	 eNtSBOEwoFGiNh+00ev0vE4Q/neezhCGmhmEkxRmLjwKyBHfBNrjTGemeI1Lj61sNf
	 hYug/wcO7d6Jw==
Date: Wed, 3 Jul 2024 08:16:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, oleg@redhat.com,
 peterz@infradead.org, mingo@redhat.com, bpf@vger.kernel.org,
 jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister
 APIs
Message-Id: <20240703081629.e26cb6dc55a8dd7d4ae36a11@kernel.org>
In-Reply-To: <20240702125320.64ec588e@rorschach.local.home>
References: <20240625002144.3485799-1-andrii@kernel.org>
	<20240625002144.3485799-7-andrii@kernel.org>
	<20240627220449.0d2a12e24731e4764540f8aa@kernel.org>
	<CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
	<20240628152846.ddf192c426fc6ce155044da0@kernel.org>
	<CAEf4Bzbr-yFv6wPJ8P=GBth7jLLj58Y7D5NwcDbX4V8nAs1QmA@mail.gmail.com>
	<20240630083010.99ff77488ec62b38bcfeaa29@kernel.org>
	<CAEf4BzZh4ShURvqk-QxC5h1NpN0tjWMr1db+__gsCmr-suUNOQ@mail.gmail.com>
	<CAEf4BzbRQjK7nnR2nnw_hgYztPPxaSC6_qFTrdADy3yCki_wEA@mail.gmail.com>
	<20240702100151.509a9e45c04a9cfed0653e6f@kernel.org>
	<CAEf4BzYShpT2fZKv3yZYxZA0Ha9JQXC3YQyJsjGB+T-yLOKs+Q@mail.gmail.com>
	<20240703001905.4bc2699cf91b8101649a458a@kernel.org>
	<20240702125320.64ec588e@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 12:53:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 3 Jul 2024 00:19:05 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > BTW, is this (batched register/unregister APIs) something you'd like
> > > to use from the tracefs-based (or whatever it's called, I mean non-BPF
> > > ones) uprobes as well? Or there is just no way to even specify a batch
> > > of uprobes? Just curious if you had any plans for this.  
> > 
> > No, because current tracefs dynamic event interface is not designed for
> > batched registration. I think we can expand it to pass wildcard symbols
> > (for kprobe and fprobe) or list of addresses (for uprobes) for uprobe.
> > Um, that maybe another good idea.
> 
> I don't see why not. The wild cards were added to the kernel
> specifically for the tracefs interface (set_ftrace_filter).

Sorry for mislead you, I meant current "dynamic_events" interface does not
support the wildcard places.
And I agree that we can update it to support something like

 p:multi_uprobe 0x1234,0x2234,0x3234@/bin/foo $arg1 $arg2 $arg3

(note: kernel does not read the symbols in user binary)

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

