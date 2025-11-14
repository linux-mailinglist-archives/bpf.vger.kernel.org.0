Return-Path: <bpf+bounces-74561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC6DC5F496
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3AB3A3E0A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACBD2FB0B4;
	Fri, 14 Nov 2025 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QihUmuow"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250F286891;
	Fri, 14 Nov 2025 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153561; cv=none; b=rMYZiuPwQlVJ1Vg0IAGwUVxqjGgWaiYIs50tIboA3DLxJLGpAmqIhHe7UfbMauNH3db3RgeTIIS5vvMbUUiSOzgsEevC+u+8nO8tF2FM4h0krOz29iw+1deADmjkc8arjqhhCwYpQ7kLBKI9J+miqHi4yHgHV8Ee47MGAgVCoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153561; c=relaxed/simple;
	bh=dnukIf+Itv7To5FosMRzEicpsoJhQHkfdpQJ7VgOFSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh8rYe+bsB5FB5/vWiWiFaMwI0VReZwSbaXvW0H8i8LAymWLloGpGBaASvUXCbiJGV7+iqS9S2Eq9C16Xw9PJFIcZB+4vEbuCS/IAeNRUIIoZgaBJeYj6VWJJ3VhpWyAxTugWDGpj/4O6wR2s20wF4P32f8MWdYMUjs/YRSJwfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QihUmuow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E48C19421;
	Fri, 14 Nov 2025 20:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763153561;
	bh=dnukIf+Itv7To5FosMRzEicpsoJhQHkfdpQJ7VgOFSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QihUmuowvkp+ZQpLbfPEugLiINU6M3LlJqrXkkCxWS1wlddteYGoZBrwRKQnVvgX/
	 FgEO6FqbpD+vAarbOuK9BFcBOfbrjnkIlwLKAvqz7jV+JRoFciM4jTRursaZm227pB
	 /imBPybiBYFmpLVjC8/8CeYi5z5u+JY+3KOrJx20/9t41GPXkobBUNIhjicYOONYhs
	 KeZwNWhe3NLZElIIBi5Hx/DCF5zx4Mm1gK3YgkdLlGY14ZChHn4s3dYtqUKETLoZUV
	 QSwDZDR++B2fAGElwbR877t0RgcEAFNP7h5RXphoQ/13MjT94Ygr7DNSPjaccrBdal
	 D8SK2dbWFepiw==
Date: Fri, 14 Nov 2025 17:52:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	dwarves <dwarves@vger.kernel.org>, Eduard <eddyz87@gmail.com>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF
 funcs
Message-ID: <aReWlPqSGWnj8sPf@x1>
References: <20251106012835.260373-1-ihor.solodrai@linux.dev>
 <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com>
 <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com>
 <aRaPnq2QJN1iFF_3@x1>
 <cf503462-6616-4cdc-ae63-b126b28ae66a@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf503462-6616-4cdc-ae63-b126b28ae66a@oracle.com>

On Fri, Nov 14, 2025 at 03:40:36PM +0000, Alan Maguire wrote:
> On 14/11/2025 02:10, Arnaldo Carvalho de Melo wrote:
> > On Thu, Nov 13, 2025 at 09:20:44AM -0800, Alexei Starovoitov wrote:
> >> On Thu, Nov 13, 2025 at 8:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>>
> >>> On 06/11/2025 01:28, Ihor Solodrai wrote:
> >>>> This series refactors a few functions that handle how BTF functions
> >>>> are emitted.
> >>>>
> >>>> v3->v4: Error handling nit from Eduard
> >>>> v2->v3: Add patch removing encoder from btf_encoder_func_state

> >>>> v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.solodrai@linux.dev/
> >>>> v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai@linux.dev/
> >>>> v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/

> >>> series applied to the next branch of
> >>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

> >> Same rant as before...
> >> Can we please keep it normal with all changes going to master ?
> >> This 'next' branch confused people in the past.
> > 
> > I think the problem before was that it sat there for far too long.
> > 
> > I see value in it staying there for a short period for some eventual
> > rebase and for some CI thing, to avoid polluting, think of it as some
> > topic branch on the way to master.

Somehow my reply via the smartphone didn't seem to have made to the
list...
 
> Yeah, I think if we can augment CI to cover more we can narrow this
> window, aiming for zero as the test coverage improves.

So the 'next' is an artifact for CI usage, i.e. if we just don't
announce that it was merged, do it for the CI sake and then when it runs
and don't detect any problem we go ahead and merge into master and
announce that it was merged, nothing of this drama would take place.

The best thing going forward I think is to have AI reviewing just like
with the BPF patches, having the patches, once posted to the list by the
contributors, trigger the CI, that amongst other things do the AI
reviewing, if all is ok, maintainers get some nudge that AI bot is ok,
etc and merge it in master, annouce publicly, yadda, yadda.

> The other thing we should think about maybe is syncing
> github.com/acmel/dwarves with pahole.git as many people are pulling
> from github.
> Should we discourage using the github repo, or just find a way to
> mirror pahole.git automatically? Thanks!

I think we should have a https://github.com/pahole/ area that is
administered by the pahole maintainer(s), just like there are:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/

For the project (current merge window, next merge window) and my
personal, previously canonical, perf and other kernel work repo:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/

:-)

- Arnaldo

