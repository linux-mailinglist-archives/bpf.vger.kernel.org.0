Return-Path: <bpf+bounces-58726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B64BAC0EAB
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020E516BD03
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDBD28CF68;
	Thu, 22 May 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3vviLUA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20528C025;
	Thu, 22 May 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925306; cv=none; b=I+2idnITqNkLxBf5GHECWkWxVNBs3ma/WbmpUAatdtpRgBTGKWecb8oKfm9JANlUCQ2PuaUnBP5hO3wRwEIwrZlIfgFbCikDil8vomFHLkC0wl6CQOQ/ju2/aRrbD7Mg9aMuUfpoYVxf9Me0t6yZf4A/QQnKUlDm8lzxvTO4LpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925306; c=relaxed/simple;
	bh=q562ioAQjNzU7zWjd6PzrCCNFWSDVCXaC01c3hhCs00=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IHAAcltKxJ1aHtpA4zsBmsXF00TmdmyiMgtEGl3Mj736H9J7w4KFKNWsqeS4CUik2PWmTPATP2HluLKQZe//S4n2n3Elw633Wro9Y8uk/dLVwjS5MKO7gYZVsITfQhrXEZd/iK4Yoqdcgu0zo6g6nOaarFKbz3xOLuGSEXK15ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3vviLUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC2BC4CEE4;
	Thu, 22 May 2025 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747925306;
	bh=q562ioAQjNzU7zWjd6PzrCCNFWSDVCXaC01c3hhCs00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d3vviLUAHJIuaNZc9yUbQOspBl1InXIQP0G2z+DGnonuhIbgqKWN60bpBvWTIrXqU
	 /Tj3nhmo5mHbyasZ9aY+je1xy/0mN3kNFbS2rGE7FfGNmwmMzl2/kCa0TQuLyxWM0F
	 QHZJTydvRSSH3nJkaDj1G7kOhNiBegKyno7L1GaWVJTAcVxzCko30XmZ6NoDaroO7P
	 aCLnkl4ZwUNR3THLddzzh3IT0vKMc1qwpnhwcRzta6Howm6thLq38Hs1tCVQEzY6sF
	 D9ehtQMdXOO0UY3+3T3ItDX89H/63qvCPzVr/MUPSVwf0sZigsejyJuuX2S0QhoryT
	 oGOF4k8RJF4kw==
Date: Thu, 22 May 2025 23:48:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Alan Maguire
 <alan.maguire@oracle.com>, David Laight <David.Laight@ACULAB.COM>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 01/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
Message-Id: <20250522234822.0410cabbbbfb58ef327805a9@kernel.org>
In-Reply-To: <20250520141925.GA14203@redhat.com>
References: <20250515121121.2332905-1-jolsa@kernel.org>
	<20250515121121.2332905-2-jolsa@kernel.org>
	<20250520084845.6388479dd18658d2c2598953@kernel.org>
	<20250520141925.GA14203@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 16:19:26 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 05/20, Masami Hiramatsu wrote:
> >
> > On Thu, 15 May 2025 14:10:58 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > > Currently unapply_uprobe takes mmap_read_lock, but it might call
> > > remove_breakpoint which eventually changes user pages.
> > >
> > > Current code writes either breakpoint or original instruction, so
> > > it can probably go away with that, but with the upcoming change that
> > > writes multiple instructions on the probed address we need to ensure
> > > that any update to mm's pages is exclusive.
> > >
> >
> > So, this is a bugfix, right?
> 
> No, mmap_read_lock() is fine.
> 
> To remind, this was already discussed with you, see
> [PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
> https://lore.kernel.org/all/20240625002144.3485799-3-andrii@kernel.org/
> 
> And you even reviewed this patch
> [PATCH 1/2] uprobes: document the usage of mm->mmap_lock
> https://lore.kernel.org/all/20240710140045.GA1084@redhat.com/
> 
> But, as the changelog explains, this patch is needed for the upcoming changes.

Oops, OK. So current code is good with either mmap_read_lock() or mmap_write_lock().
But the patch description is a bit confusing. If the point is an atomic (byte?)
update or not, it should describe it.

Thank you,

> 
> --------------------------------------------------------------------------
> Just in case... I'll try to read this series tomorrow, but at first glance
> this version addresses all my concerns.
> 
> Oleg.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

