Return-Path: <bpf+bounces-45403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 841A59D526A
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B43CB22F02
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE731C07D3;
	Thu, 21 Nov 2024 18:18:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B751A08A3;
	Thu, 21 Nov 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213135; cv=none; b=lZo/tq5KrXCvDZ/It4dLCIQqXUCxidIYGNqDfQHyLU63AfLqJlRRN0RrP+8+AHEDn0MRq/TvBqHZ1ofJCJHAaXPu9qTS5hPTyhPF35PSLfYhkbmM7VJI6U7KNpF18j/xTr7PBNR0RdIIQCSAmemlpWi4jpJ/SJgUcwl8mJkFvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213135; c=relaxed/simple;
	bh=boJtVvo70ZEiAShf8Jnaat3ZvuPdjt2n4zPdgQ22XIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+2MHXVIe9AyK5yXfJXtXSa4rBruNDbzUMHqpZU//wfpKR3EdjqwTQ2Yzle4/UWsztCBOP1sb4qHdy9onc7XsIwT/IRqwPA03l0SlswHImDIaEOIq1/HW5gJ2mlpdo0zjj5aUbvbsdi5aeX2EYx8khFHRt+jFu3V8Ym40FLaOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD45712FC;
	Thu, 21 Nov 2024 10:19:21 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F359A3F5A1;
	Thu, 21 Nov 2024 10:18:48 -0800 (PST)
Date: Thu, 21 Nov 2024 18:18:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>
Subject: Re: [RFC 00/11] uprobes: Add support to optimize usdt probes on
 x86_64
Message-ID: <Zz95aiWM5cN6MDED@J2N7QTR9R3.cambridge.arm.com>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241117114946.GD27667@noisy.programming.kicks-ass.net>
 <ZzsRfhGSYXVK0mst@J2N7QTR9R3>
 <CAEf4BzbXYrZLF+WGBvkSmKDCvVLuos-Ywx1xKqksdaYKySB-OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbXYrZLF+WGBvkSmKDCvVLuos-Ywx1xKqksdaYKySB-OQ@mail.gmail.com>

On Mon, Nov 18, 2024 at 10:13:04PM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 18, 2024 at 2:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > Yep, on arm64 we definitely can't patch in branches reliably; using BRK
> > (as we do today) is the only reliable option, and it *shouldn't* be
> > slower than a syscall.
> >
> > Looking around, we have a different latent issue with uprobes on arm64
> > in that only certain instructions can be modified while being
> > concurrently executed (in addition to the atomictiy of updating the
> 
> What does this mean for the application in practical terms? Will it
> crash? Or will there be some corruption? Just curious how this can
> manifest.

It can result in a variety of effects including crashes, corruption of
memory, registers, issuing random syscalls, etc.

The ARM ARM (ARM DDI 0487K.a [1]) says in section B2.2.5:

  Concurrent modification and execution of instructions can lead to the
  resulting instruction performing any behavior that can be achieved by
  executing any sequence of instructions that can be executed from the
  same Exception level [...]

Which is to say basically anything might happen, except that this can't
corrupt any state userspace cannot access, and cannot provide a
mechanism to escalate privilege to a higher exception level.

So that's potentially *very bad*, and we're just getting lucky that most
implementations don't happen to do that for most instructions, though
I'm fairly certain there are implementations out there which do exhibit
this behaviour (and it gets more likely as implementations get more
aggressive).

Mark.

[1] https://developer.arm.com/documentation/ddi0487/ka/?lang=en

