Return-Path: <bpf+bounces-42218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F304A9A11A4
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45B3286979
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458C52141A1;
	Wed, 16 Oct 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T46ZaHFZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA118C33E;
	Wed, 16 Oct 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103720; cv=none; b=Gct+xvq91Xz9EoG/XC2gYO2J27cuQvHhJ0vey3A+uUS4+cC1mejagGzBGhcvoJhy+p925SuGiCpfdgqMS1/1c8ecoBWAe+rye9auch/4nC90Weckn3mi0QzJtMxj4iVvmHxiUWSZegVpg2eOgH3YCoy/Umg/hrSLL8LSz9O6Pzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103720; c=relaxed/simple;
	bh=Wbzx8WQNkx2LfwF5/9Fel6fTjsfrcYca5cm8SsQhTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkNGYjEPESvVsmW4jy+E2MGcm65uow+B5ExA1kA7qs6xazKq9mXoAp4EqD10LCEvaElfQaohEeLPi6U0kbmtGuB124nC5QipEkGLqJyOEZ5M1M4OFrLI17/m55e/gfx57v2yEL5YD3gHoE0gqhHLDkc7tRQQN6RksQYB8oTnG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T46ZaHFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC86EC4CEC5;
	Wed, 16 Oct 2024 18:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729103720;
	bh=Wbzx8WQNkx2LfwF5/9Fel6fTjsfrcYca5cm8SsQhTXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T46ZaHFZPG8Y8J2eE5/mNSEyJWM+ipCnlZ1Fy/sZzxRhW1z/ybed5qvDEB14LbAfH
	 iAMepQqhxQ9RePBIs11NLkMzD0oai4SAa25TAfvk63W5hnk5Se3rkDq6XOm5LAqgxY
	 9KEAyPi8VjW0zvkRA132pYG7ngtotf/7r0IggB0vtd+gs+ZPyXuAMYqvC00X/XtbuF
	 Riw0cALxO2a8aL9qBTMvmbTpU4+BP70ZOf+dJZOKmNf6jG7AfzZTCS5q3tFdjv+zOh
	 8/Z+1QR3rGVKK9Hvz6menRdqzGue9K+wCjdOqem3m92jY1a9vqoXB4XssgPRKq1Aul
	 34IOb030opWnw==
Date: Wed, 16 Oct 2024 11:35:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <ZxAHZt8pFjxeOx-U@google.com>
References: <20241016170542.7e22b03c@canb.auug.org.au>
 <CAADnVQJ=Woq=82EDvMT1YRLLTvNgFVSbnZDiR5HUgEhcyBLW4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ=Woq=82EDvMT1YRLLTvNgFVSbnZDiR5HUgEhcyBLW4Q@mail.gmail.com>

On Wed, Oct 16, 2024 at 09:25:41AM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 15, 2024 at 11:05 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the bpf-next tree, today's linux-next build (arm64
> > defconfig) failed like this:
> >
> > Building: arm64 defconfig
> > In file included from arch/arm64/include/asm/thread_info.h:17,
> >                  from include/linux/thread_info.h:60,
> >                  from arch/arm64/include/asm/preempt.h:6,
> >                  from include/linux/preempt.h:79,
> >                  from include/linux/spinlock.h:56,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:7,
> >                  from include/linux/slab.h:16,
> >                  from mm/slab_common.c:7:
> > mm/slab_common.c: In function 'bpf_get_kmem_cache':
> > arch/arm64/include/asm/memory.h:427:66: error: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
> >   427 |         __is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));      \
> >       |                                                                  ^~~~~~
> >       |                                                                  |
> >       |                                                                  u64 {aka long long unsigned int}
> > mm/slab_common.c:1260:14: note: in expansion of macro 'virt_addr_valid'
> >  1260 |         if (!virt_addr_valid(addr))
> >       |              ^~~~~~~~~~~~~~~
> > arch/arm64/include/asm/memory.h:382:53: note: expected 'const void *' but argument is of type 'u64' {aka 'long long unsigned int'}
> >   382 | static inline unsigned long virt_to_pfn(const void *kaddr)
> >       |                                         ~~~~~~~~~~~~^~~~~
> >
> > Caused by commit
> >
> >   04b069ff0181 ("mm/bpf: Add bpf_get_kmem_cache() kfunc")
> >
> > I have reverted commit
> >
> >   08c837461891 ("Merge branch 'bpf-add-kmem_cache-iterator-and-kfunc'")
> >
> > for today.
> 
> Thanks for flagging.
> Fixed and force pushed.

Oops, thanks for fixing this.  The virt_addr_valid() was confusing
whether it takes unsigned long or a pointer.  It seems each arch has
different expectation.

Thanks,
Namhyung


