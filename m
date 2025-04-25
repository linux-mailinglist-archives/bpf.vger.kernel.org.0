Return-Path: <bpf+bounces-56718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7157A9D0EE
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60C59A8400
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23909218EBD;
	Fri, 25 Apr 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j+Jiiqlo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F31AA1C4;
	Fri, 25 Apr 2025 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607516; cv=none; b=Prt26F6xRHZ9aF/X7lc/nVtIgAEU9T6brPki0yUYWVH/htgnNxsJfPhduBcfeEgzg729YEWJ/0w2QAbLd72i4LVIIy9r3TMQInVrFJ7FovVHhcxkXnafPVaw9Ks3xH4tucQE5XOoxWdGzB5mqbI06c5q/XftRxs5nVL4STls9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607516; c=relaxed/simple;
	bh=Lsmrp9NKV92pd90erCa0bNkQyc6Oy+Y9ltxfyRGkeD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMWgd/WcHSQZ5Sjl3fx4JYushLNa+HeQTMbPe5e//1s7YnvjgHHVKk2NanHdu0ED6KG1PCcwJXNqixou4ct/FRrdK+I5InNoNJ4osa5M2Vp08iSFqButG0xxa1dpgWDYj/aGfWghFfvZpDiobZucbpA1Xs2TzA7iMYhl4eAxi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j+Jiiqlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C308AC4CEE4;
	Fri, 25 Apr 2025 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745607515;
	bh=Lsmrp9NKV92pd90erCa0bNkQyc6Oy+Y9ltxfyRGkeD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+JiiqlocYgHar31q8KKX1xVyWVDUWmQtYm4Ae6wbdqb3DdQP0Lt3PZ9LTQ9ZLyaI
	 moGQb8qDR/0nQxC44DRBesbPAI3UtgIJsU51mX2SAEp3AXQYD9GGTrtAjCJ+NMAWw2
	 iAjPMZyUDoo8Rbx5zHLz4IzinUO5WHc0T47/KcjU=
Date: Fri, 25 Apr 2025 14:58:32 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
Message-ID: <20250425-artichoke-dove-of-reward-6e3ca2@lemur>
References: <20250424165525.154403-1-iii@linux.ibm.com>
 <174551961000.3446286.10420854203925676664.git-patchwork-notify@kernel.org>
 <CAADnVQL2YzG1TX4UkTOwhfeExCPV5Sj3dd-2c8Wn98PMsUQWCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQL2YzG1TX4UkTOwhfeExCPV5Sj3dd-2c8Wn98PMsUQWCA@mail.gmail.com>

On Thu, Apr 24, 2025 at 11:41:16AM -0700, Alexei Starovoitov wrote:
> > On Thu, 24 Apr 2025 18:41:24 +0200 you wrote:
> > > Hi,
> > >
> > > I tried running the arena_spin_lock test on s390x and ran into the
> > > following issues:
> > >
> > > * Changing the header file does not lead to rebuilding the test.
> > > * The checked for number of CPUs and the actually required number of
> > >   CPUs are different.
> > > * Endianness issue in spinlock definition.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [1/3] selftests/bpf: Fix arena_spin_lock.c build dependency
> >     https://git.kernel.org/netdev/net-next/c/4fe09ff1a54a
> >   - [2/3] selftests/bpf: Fix arena_spin_lock on systems with less than 16 CPUs
> >     (no matching commit)
> >   - [3/3] selftests/bpf: Fix endianness issue in __qspinlock declaration
> >     (no matching commit)
> 
> Hmm. Looks like pw-bot had too much influence from AI bots
> and started hallucinating itself :)

Looks like it's a mix of bad assumptions and the usual difficulty of
recognizing fast-forward merges that came in through a different tree.

If you look at the commit mentioned above, it has:

| Note that the first patch in this series is a leftover from an
| earlier patchset that was abandoned:
| Link: https://lore.kernel.org/netdev/20250129004337.36898-2-shannon.nelson@amd.com/

This confuses the bot into thinking that the linked message is the source of
the patch (which is why we started using patch.msgid.link to disambiguate
links aimed at cross-referencing and links aimed at indicating commit
provenance -- but we aren't relying on this disambiguation in the bot itself
yet).

The other replies are the usual mess when fast-forward tree updates confuse
things. It's a long-standing hard bug to fix.

I am going to re-enable the bot for now -- in general it's not any more wrong
than usual. I'm scheduling some time next week to try to tackle the
fast-forwards problem.

-K

