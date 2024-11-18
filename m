Return-Path: <bpf+bounces-45082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA499D0DBE
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 11:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691F21F22C7E
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415BC19342A;
	Mon, 18 Nov 2024 10:06:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB0192B94;
	Mon, 18 Nov 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924383; cv=none; b=dysi4IbjYFfRE8lhVx1nNUs5o6bhqqNelyBx1En3epj0H5aShlRWoVlNuTzyLAAR8HubvKpfmBzRHNn6MOlWTjHR7gddD7KXdkc8fUXNH8FvQdZqnLNhe6O+UKArtUkz6qNiuUzwvjK6Le2/EbDWUaWFfNHN1zFCoZEulKNghSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924383; c=relaxed/simple;
	bh=tqLkGb4q1vFDsNwPuYatSrqaYTSenyoy+n5SUDkfDmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGMnwx1llgu0FFZVZ5Tv5bWQ2kq4xwJcxS5BJf7rdc7ue+NrmfX4T9hAqkJihYJmyCCddX7V82f0WEZNQfRqcLEFXjoEeSabxU0DKBIBqtmKTf1vpfbglOHdF4z7udDXpzdHDLZ5SdeviLpP0nnobo4hYBjIdbGQm1bq74Skrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99C36113E;
	Mon, 18 Nov 2024 02:06:45 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 707933F5A1;
	Mon, 18 Nov 2024 02:06:13 -0800 (PST)
Date: Mon, 18 Nov 2024 10:06:01 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
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
Message-ID: <ZzsRfhGSYXVK0mst@J2N7QTR9R3>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241117114946.GD27667@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117114946.GD27667@noisy.programming.kicks-ass.net>

On Sun, Nov 17, 2024 at 12:49:46PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 05, 2024 at 02:33:54PM +0100, Jiri Olsa wrote:
> > hi,
> > this patchset adds support to optimize usdt probes on top of 5-byte
> > nop instruction.
> > 
> > The generic approach (optimize all uprobes) is hard due to emulating
> > possible multiple original instructions and its related issues. The
> > usdt case, which stores 5-byte nop seems much easier, so starting
> > with that.
> > 
> > The basic idea is to replace breakpoint exception with syscall which
> > is faster on x86_64. For more details please see changelog of patch 7.
> 
> So this is really about the fact that syscalls are faster than traps on
> x86_64? Is there something similar on ARM64, or are they roughly the
> same speed there?

From the hardware side I would expect those to be the same speed.

From the software side, there might be a difference, but in theory we
should be able to make the non-syscall case faster because we don't have
syscall tracing there.

> That is, I don't think this scheme will work for the various RISC
> architectures, given their very limited immediate range turns a typical
> call into a multi-instruction trainwreck real quick.
> 
> Now, that isn't a problem if their exceptions and syscalls are of equal
> speed.

Yep, on arm64 we definitely can't patch in branches reliably; using BRK
(as we do today) is the only reliable option, and it *shouldn't* be
slower than a syscall.

Looking around, we have a different latent issue with uprobes on arm64
in that only certain instructions can be modified while being
concurrently executed (in addition to the atomictiy of updating the
bytes in memory), and for everything else we need to stop-the-world. We
handle that for kprobes but it looks like we don't have any
infrastructure to handle that for uprobes.

Mark.

