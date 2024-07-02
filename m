Return-Path: <bpf+bounces-33646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B9924232
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A751F21B23
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E0D1BC068;
	Tue,  2 Jul 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuuhBMOE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9561BBBC3;
	Tue,  2 Jul 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933550; cv=none; b=poa6m1Jz6mU98xn+DIHiMbqtwiR9k1Ed7XDQivwf20hoJKdF66xUXKUrM608P6Zr65znwQ8ZA9C8WWzgV92uHF/VqsRVqpsvmxMzwTpSyyP6xpKbvaYzT7y1lR09dVF6/CsvMA0Kqs4J4TsxgbpQpx4Ia8Ca1J3l8RGmK0K9ygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933550; c=relaxed/simple;
	bh=4RHihOnQnHHmyTKq/PgNxngD5ax7ld6Ek2D24DjxfLc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X1blrcU5XD/Bs7duKa/Wt0q4tmhOn3gfitAvv8qzTTTS2I8k5w0rk0a7Uqcz41HcVlNqAlyIfKC1MjHD2IZJ4oj2FhfAViK1TUWQ9znSk3TueUbLcEYK+e/CmRrNprbb5AoxVlPcrZ7Z9qeDgW7Me7utR8DvxXlMm6Qs04iOjHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuuhBMOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C35FC2BD10;
	Tue,  2 Jul 2024 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933549;
	bh=4RHihOnQnHHmyTKq/PgNxngD5ax7ld6Ek2D24DjxfLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MuuhBMOE26ZKMq7Sqhygd0LyO6xXyFDyu7ZqM7qSK6PBQGu63eZmdq5T1c4QvE6iF
	 kJZzjTCj6MSfVh3h+HpFEtFQSQOueRR8jeRDjKgMPLy29apsPoXEKJbqqyP1rPFbvG
	 76vedL8FcInodAqdDYP7RjMbXL7KoMIxWIIsnNqoR8D4eZ7TerSEgls08i3X0dFnqU
	 BbMg0nD7WihPN77NJyXXNkfG2SmdpsWqb7cJAlKz/PAUnQNII1seeSdiO2AlvDPLwv
	 v3dxrxYdNCERE6t2WPGsrlUZmWwWFBfGpTk8kAme8i85KxuswBAAbQkPtN2Fb9NYw9
	 2r087p/toO4IA==
Date: Wed, 3 Jul 2024 00:19:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org,
 mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
 paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister
 APIs
Message-Id: <20240703001905.4bc2699cf91b8101649a458a@kernel.org>
In-Reply-To: <CAEf4BzYShpT2fZKv3yZYxZA0Ha9JQXC3YQyJsjGB+T-yLOKs+Q@mail.gmail.com>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jul 2024 18:34:55 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > > How about this? I'll keep the existing get_uprobe_consumer(idx, ctx)
> > > contract, which works for the only user right now, BPF multi-uprobes.
> > > When it's time to add another consumer that works with a linked list,
> > > we can add another more complicated contract that would do
> > > iterator-style callbacks. This would be used by linked list users, and
> > > we can transparently implement existing uprobe_register_batch()
> > > contract on top of if by implementing a trivial iterator wrapper on
> > > top of get_uprobe_consumer(idx, ctx) approach.
> >
> > Agreed, anyway as far as it uses an array of uprobe_consumer, it works.
> > When we need to register list of the structure, we may be possible to
> > allocate an array or introduce new function.
> >
> 
> Cool, glad we agree. What you propose above with start + next + ctx
> seems like a way forward if we need this.
> 
> BTW, is this (batched register/unregister APIs) something you'd like
> to use from the tracefs-based (or whatever it's called, I mean non-BPF
> ones) uprobes as well? Or there is just no way to even specify a batch
> of uprobes? Just curious if you had any plans for this.

No, because current tracefs dynamic event interface is not designed for
batched registration. I think we can expand it to pass wildcard symbols
(for kprobe and fprobe) or list of addresses (for uprobes) for uprobe.
Um, that maybe another good idea.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

