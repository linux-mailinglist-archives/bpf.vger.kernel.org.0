Return-Path: <bpf+bounces-67501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96BB4475E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2E07B7041
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2832836A3;
	Thu,  4 Sep 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KR/8ynTQ"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838BA1F872D;
	Thu,  4 Sep 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018126; cv=none; b=IrVmHy0HunZvmYtnHAUSXDEb+q3bhZMqStYT+KuKIlub0XvsjGUFkF4lAvAikFStjiKYwmWK4PzBSD4Q2/0In7URPP0Ye2Z8dzj/LWn8v1EBtfTdF5YyaiSrolFa9PFeV6NabcYjTUU57v4W93NUvY37ZRfmWuCERvN4H7Gg3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018126; c=relaxed/simple;
	bh=M8EbvMxMXMibzkZOtXRkWchoAXACqomoMACH3LplP9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lalQLwbHYmaFoVOFYJHIIJCjLRQHVriIz+MUzxnUIFfHTBlHWn0ckDNxQOLq1Qvm5TZBv1p2km6UbDmfF0ifnnuGjuL7yfU5RX8WzS3wrnRjFiLaN0WLag7bromvvKRM//4rDcrpKfYY/16SFjaSTrb16+qQg0+wWCbCKBCkGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KR/8ynTQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M8EbvMxMXMibzkZOtXRkWchoAXACqomoMACH3LplP9M=; b=KR/8ynTQ9yCd1BeztNH28HNN/M
	JxZcdlx9flo2Fs4chIsiRXPKrY1ihmbqSS3QrAIdpsutvFWbtnrhMlnkCsS5DfkaulC5e51RQN/3L
	8KuiDE2515Hns9YnMLlO1n1kAws5nn8ZXAq0+3cowoixxXxauP2MLfTCGFfvDhVFjmh3BHo8uEWpU
	8uSYTDgJNTYoku2BcmC0LbOcuAjK1UAczACwfZJBW8OFdubdFWS7vCUrDbaAG7HJF1UbOZfidYRvy
	RLMqMj+6+HLrGYTc/Am7ldWFy4gAFGGVI1Pg82ZRWzFVoZ2ZX/v6lIyuqRf4fl65a2H0HHpYfzr9c
	meNODCYw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuGfo-00000004Pop-2gaA;
	Thu, 04 Sep 2025 20:35:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7966A300220; Thu, 04 Sep 2025 22:35:11 +0200 (CEST)
Date: Thu, 4 Sep 2025 22:35:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: nop5-optimized USDTs WAS: Re: [PATCHv6 perf/core 09/22]
 uprobes/x86: Add uprobe syscall to speed up uprobe
Message-ID: <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLlKJWRs5etuvFuK@krava>
 <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>

On Thu, Sep 04, 2025 at 11:27:45AM -0700, Andrii Nakryiko wrote:

> > > So I've been thinking what's the simplest and most reliable way to
> > > feature-detect support for this sys_uprobe (e.g., for libbpf to know
> > > whether we should attach at nop5 vs nop1), and clearly that would be
> >
> > wrt nop5/nop1.. so the idea is to have USDT macro emit both nop1,nop5
> > and store some info about that in the usdt's elf note, right?

Wait, what? You're doing to emit 6 bytes and two nops? Why? Surely the
old kernel can INT3 on top of a NOP5?





