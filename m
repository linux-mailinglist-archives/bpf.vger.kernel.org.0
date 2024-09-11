Return-Path: <bpf+bounces-39551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD4197472C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 02:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237F7285BD2
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 00:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D410F2;
	Wed, 11 Sep 2024 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHNNcMuv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037E161;
	Wed, 11 Sep 2024 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726013629; cv=none; b=HcnhjmMNZo2lDZcMA2KFj7AFoxSBkbXcYdW5eUnPhbkRjvQuP1dQnBZcejT40cKLcou0NjlDXFTacmBXJxuxkaU1sGJNtptG8qa9v6dhN0sXRS13MpyPZfhLMAbPtUAxgqM5ZbgmvBAzY8cmTX+VtA+prXaVcBWntni9ISCjP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726013629; c=relaxed/simple;
	bh=kLX/MNy8LQx6pmAYAL9htFO1I0OjK3ouK59utdKuxMk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AdsR5yxW6FvXAQ9GGt2S6Jlz3H9OjE6zBW23o8GwP+nuteL7qkbSj7/d3VVGrCjLJ4m7UNVE7MLLSrmaCXz/Ft3quQRl30bvzlwHiFUnmPZi4/nDl3l9to4TbBF+IEI4lf9ve60GyW9OUb8uQ31uwy/uM4ItfUgR/IpAE9TbWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHNNcMuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A65C4CECC;
	Wed, 11 Sep 2024 00:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726013628;
	bh=kLX/MNy8LQx6pmAYAL9htFO1I0OjK3ouK59utdKuxMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pHNNcMuvkBf22Ht5hikTfK5DrtdlvONrgq+Q+6nKmjhExO6WVUe/kBGnuo3JGq9bS
	 S8gt5ghMPw+mci8KHjIQ1rxS5h0OcuirDrr7GalNd+3ErN2lqn8DDvJzIUFLzjITS8
	 eeZ6xLKzupTg9uAoMxUEg6edxvm4ufEse6W5d47LS+P6nMHwAxxESW+lZMcme4Z5Um
	 VGxFo81QheOp/odPOD+jEm3Tlgek/0Dau48+7mokshFPbfpxZIUuy4cdnVBmQUsM7C
	 2fBGcD+h9rguDIms/xW+FoPWXhK7iCAH09Z9cUgg/x31zP6Z86RyB7MUWGLCiE+BUF
	 MippYztjimdtw==
Date: Wed, 11 Sep 2024 09:13:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh
 <kpsingh@chromium.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Florent Revest
 <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
Message-Id: <20240911091343.77c60bc2e5d96cbfd8787c19@kernel.org>
In-Reply-To: <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
	<CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 10 Sep 2024 11:23:29 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> + arm ML and maintainers
> 
> On Wed, Sep 4, 2024 at 6:02 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Hey,
> >
> > I just recently realized that we are still missing multi-kprobe
> > support for ARM64, which depends on CONFIG_FPROBE. And CONFIG_FPROBE
> > seems to require CONFIG_HAVE_RETHOOK, which, it turns out, is not
> > implemented for ARM64.
> >
> > It took me a while to realize what's going on, as I roughly remembered
> > (and confirmed through lore search) that Masami's original rethook
> > patches had arm64-specific bits. Long story short:
> >
> > 0f8f8030038a Revert "arm64: rethook: Add arm64 rethook implementation"
> > 83acdce68949 arm64: rethook: Add arm64 rethook implementation
> >
> > The patch was landed and then reverted. I found some discussion online
> > and it seems like the plan was to land arch-specific bits shortly
> > after bpf-next PR.
> >
> > But it seems like that never happened. Why?
> >
> > I see s390x, RISC-V, loongarch (I'm not even mentioning x86-64) all
> > have CONFIG_HAVE_RETHOOK, even powerpc is getting one (see [0]), it
> > seems. How come ARM64 is the one left out?
> >
> > Can anyone please provide some context? And if that's just an
> > oversight, can we prioritize landing this for ARM64 ASAP?
> >
> >   [0] https://lore.kernel.org/bpf/20240830113131.7597-1-adubey@linux.ibm.com/
> >
> 
> Masami, Steven,
> 
> Does Linus have to be in CC to get any reply here? Come on, it's been
> almost a full week.

Sorry about bothering you, let me check that. But I think we eventually
need my fprobe-on-fgraph patch which allows all architecture uses ftrace_regs
instead of pt_regs for ftrace/fgraph users. That allows arm64 to implement
fprobe.

> 
> Maybe ARM64 folks have some context?... And hopefully desire to see
> this through so that ARM64 doesn't stick out as a lesser-supported
> platform as far as tracing goes compared to loongarch, s390x, and
> powerpc (which just landed rethook support, see [2]).

I think lesser-supported or not is not a matter, but they need to keep 
their architecutre healthy. Mark said that the current rethook
implementation is not acceptable because arm64 can not manually generate
pt_regs. So we need to use ftrace_regs for that.
So eventually, we need my fprobe series.

https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit@devnote2/

Thank you,

> 
> Note that there was already an implementation (see [1]), but for some
> reason it never made it.
> 
>   [1] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit@devnote2/
>   [2] https://lore.kernel.org/bpf/172562357215.467568.2172858907419105155.b4-ty@ellerman.id.au/
> 
> >
> > -- Andrii


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

