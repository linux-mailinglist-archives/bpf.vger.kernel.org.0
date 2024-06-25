Return-Path: <bpf+bounces-33054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641779169EE
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904161C2227A
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BF516A37C;
	Tue, 25 Jun 2024 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtOeROvE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AD1B7F7;
	Tue, 25 Jun 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324796; cv=none; b=DNcdbElDgajpKRP6anEgyS2aZ218BKadHh//za6pk+hqyla4vVSyvx+IM3jNJM3ZYDB8IU/gaVx8Tr+raniwYxhFFLRw+2DHsgp1JdW88nTZLjnY2K6+5zMWlxsCcrZ/g9RqCfFvE/6r3uQRnA3guHjOyR4WiIGSGpazoXgz6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324796; c=relaxed/simple;
	bh=d3nPgJuWovkDgvkMf7UKdic0kOOrapO8a1bmL3gnIWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWm3i3e7517OcPARJoNiPCF5Bwcms2sfIDh1aQ2sJ0jZQr1x5kCa+XOezmjICOiRsc3zSk/O0ficPjRscN9aQ5liNC1aKDRgXmqJl+YPYrvvx/Dw2sbCWGVFIP3L1+oD3S2iS9ozSA/MiDDOCgLgfudu8u1BS1KzINiQ1mkbf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtOeROvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E0AC32781;
	Tue, 25 Jun 2024 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324796;
	bh=d3nPgJuWovkDgvkMf7UKdic0kOOrapO8a1bmL3gnIWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JtOeROvE7+yShh8jOiozpHigkf0TwK8mao/PPNQQDxyjfhdh0v5ba2ydwBPbsAl8t
	 hEIUQWfJHpE4fM05tsUgb6LgDOZlE2XOucB9+9JmcOxb9ylwsiiJnsghEMOfKy7PSf
	 9/LKe5vVh3dmj/rC4uDnCzpgAdIwp/VOzAnj6ypGlk7p9xKEnz0dcnGA5yBFgF1qQX
	 9OqCvZ3Tlg1hF2oVH9TVe3KSSBJTIcctytwkw4NhGM2YPVbMZ2JqBGijEZ/SnbrfrF
	 EyWeGe/kGoAA+3wq/HUx9x+WEDHXlLv337c85J8gzdLWUbYnU5x3q9g6SS7MKJ0Brv
	 jbNJ66v9xKDtg==
Date: Tue, 25 Jun 2024 07:13:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2024-06-24
Message-ID: <20240625071314.00fdb459@kernel.org>
In-Reply-To: <c2119e37-4ce4-bf9b-61c2-1728c7c2b0ce@iogearbox.net>
References: <20240624124330.8401-1-daniel@iogearbox.net>
	<20240624184126.33322abe@kernel.org>
	<c2119e37-4ce4-bf9b-61c2-1728c7c2b0ce@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 09:46:39 +0200 Daniel Borkmann wrote:
> On 6/25/24 3:41 AM, Jakub Kicinski wrote:
> > On Mon, 24 Jun 2024 14:43:30 +0200 Daniel Borkmann wrote:  
> >> The following changes since commit 143492fce36161402fa2f45a0756de7ff69c366a:
> >>
> >>    Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue (2024-06-14 19:05:38 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>    ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev  
> > 
> > Bot seems to not be responding, so: pulled, thanks!
> > 
> > BTW was the ssh link intentional?   
> 
> Yes at least from what I read at users@k.o the recommendation / preference is
> to use the gitolite link so that you as kernel.org user do not get artificially
> throttled when pulling.

Hm. Wasn't there some suggestion for people to locally have a rule to
replace links if they want that? The SSH link is impossible for bots to
pull. I guess I could sprinkle regexps in all the bots but that sounds
like a pain. And TBH I've personally never experienced the throttling
issues K mentioned, so I see no upside :(

