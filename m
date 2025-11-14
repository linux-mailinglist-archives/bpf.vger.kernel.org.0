Return-Path: <bpf+bounces-74446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B80C5AFA0
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 03:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80BDB4E3A20
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 02:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE4221F13;
	Fri, 14 Nov 2025 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4aQt06e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C726B777;
	Fri, 14 Nov 2025 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086242; cv=none; b=HonyL77DqR7G/sbU/uGopCa9w9FOtgw78BtkF5OBN5KyEjgxVYSJhFx+pkekX3Qn1sywnnyifS6GcJGQmjS1hQZwsFt0NSMVZO+GP+It3OTx9FYSZB0o7pHxJ9tiOcnjvrXJEWZNejQp73EkzIJwgG6AlYEB3H0pjYd6EsmZa5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086242; c=relaxed/simple;
	bh=FfbPqAon6pN6iJ5lflLTEH3YJugpETQ+/neHJen4Sxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHRamri/YfuYaRkBTNpAkxWVJ5Y6vKZecNXhmp4D68xKwZlYLHduuSHDJDdVxn7fXzldrpd/y0PTPcOnLBiRXgH9D7viWjgVgWQi+nts8O/oaBsBHjUbjGP0PC6sA5Ze24x987RUsyxvcPRrKw5wTZPQD9XJ+eBMj9j5UnOdM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4aQt06e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD46C4CEF5;
	Fri, 14 Nov 2025 02:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763086241;
	bh=FfbPqAon6pN6iJ5lflLTEH3YJugpETQ+/neHJen4Sxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4aQt06e0wes6QtYZcEoYtdrt9w7QbA4TSVbEn8YDO2Neb5anlmpRWYJzwpoaxZNr
	 WyNEfZBrxiNk1zNGEqlusLkfZ1oSzr4Xzf30fHupxCYQ+OykAj5IpIVc/fXgLNNRGr
	 4sN4gjMzQs2JmmUOj43kwicKUZKobGXkXV5xUXLReLNd7ThwmRdFGpxgoauJtfALsT
	 LT+y4JehkeiQhOGw1Y/0O/UmlNy385vl2cJagax9kngM7rMdzF6i8i2ALrPaR/xLQ0
	 WmBGMDsvwjcO7cfWOmklvahXo4ieRCJiDmlxHukXllAJYDwCDjkBBelmhvZtPSdcDv
	 lDGzUdVf6Iojw==
Date: Thu, 13 Nov 2025 23:10:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	dwarves <dwarves@vger.kernel.org>, Eduard <eddyz87@gmail.com>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF
 funcs
Message-ID: <aRaPnq2QJN1iFF_3@x1>
References: <20251106012835.260373-1-ihor.solodrai@linux.dev>
 <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com>
 <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com>

On Thu, Nov 13, 2025 at 09:20:44AM -0800, Alexei Starovoitov wrote:
> On Thu, Nov 13, 2025 at 8:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 06/11/2025 01:28, Ihor Solodrai wrote:
> > > This series refactors a few functions that handle how BTF functions
> > > are emitted.
> > >
> > > v3->v4: Error handling nit from Eduard
> > > v2->v3: Add patch removing encoder from btf_encoder_func_state
> > >
> > > v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.solodrai@linux.dev/
> > > v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai@linux.dev/
> > > v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/
> > >
> >
> > series applied to the next branch of
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> 
> Same rant as before...
> Can we please keep it normal with all changes going to master ?
> This 'next' branch confused people in the past.

I think the problem before was that it sat there for far too long.

I see value in it staying there for a short period for some eventual
rebase and for some CI thing, to avoid polluting, think of it as some
topic branch on the way to master.

- Arnaldo

> I see no value in this 'next' thing.
> All development should happen in master and every developer
> should base their changes on top of it.
> Eventually the release happens out of master too when it's deemed stable.


