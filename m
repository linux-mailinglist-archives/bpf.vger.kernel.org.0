Return-Path: <bpf+bounces-33653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB5C9243FB
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F868282886
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0361BD50E;
	Tue,  2 Jul 2024 16:53:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633293D978;
	Tue,  2 Jul 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939203; cv=none; b=JLh4tx+OCTGErXEUi6TD9q8FmHZyz7+ATK4eaKkclTFIimQPR/DT4XxFFoPrVYRckO+63FTL6m4KPitIKCG4Oo4AV68mH1iyBvdrCIksMJS4tIAZ7KzhFWjdXvaQH3VfDss6EVIzKe5qis/Ebtyu90GKy0m0BxP8N1yYtqnMKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939203; c=relaxed/simple;
	bh=A/BbmC5Sr8eBD0w0d3VBdyYc6rEnjfuIoBHhfK+i9bo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5KgdLEyiB9jCaQ9MiJi5kfQc7koXEiLcgWuqkXS1t0BGHrd9dbSyKNQWO4Q0mH1fPjJ2X5/LgWhaRNtIk5PLVbIvpovh8y9y3WUNxusSW/gpiSWdbExPBE5kZIiREOM5iocCWB+BawgcswcYkPmlTVtWdly4oK3R0iXu6bCfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D371C116B1;
	Tue,  2 Jul 2024 16:53:21 +0000 (UTC)
Date: Tue, 2 Jul 2024 12:53:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, oleg@redhat.com,
 peterz@infradead.org, mingo@redhat.com, bpf@vger.kernel.org,
 jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister
 APIs
Message-ID: <20240702125320.64ec588e@rorschach.local.home>
In-Reply-To: <20240703001905.4bc2699cf91b8101649a458a@kernel.org>
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
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 00:19:05 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > BTW, is this (batched register/unregister APIs) something you'd like
> > to use from the tracefs-based (or whatever it's called, I mean non-BPF
> > ones) uprobes as well? Or there is just no way to even specify a batch
> > of uprobes? Just curious if you had any plans for this.  
> 
> No, because current tracefs dynamic event interface is not designed for
> batched registration. I think we can expand it to pass wildcard symbols
> (for kprobe and fprobe) or list of addresses (for uprobes) for uprobe.
> Um, that maybe another good idea.

I don't see why not. The wild cards were added to the kernel
specifically for the tracefs interface (set_ftrace_filter).

-- Steve

