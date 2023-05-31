Return-Path: <bpf+bounces-1536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B71718A98
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335B92815E4
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449FB3C0A0;
	Wed, 31 May 2023 19:55:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4DE19E61
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45A3C433EF;
	Wed, 31 May 2023 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685562926;
	bh=K6BiB4d4pwh5l5fEvqg5HdsW+2/SZ5ha4oA58FNbVQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuSCt7/41WoHCLlFavs2RXRxmldBL7Ykn9PLKEI5mTlSq8J8r3pTx9GA6RlHeXPHs
	 Bs7j3d47LzA6lzpLmKw49dzEsf0GHytMnrsv6BBfUSM0ou+i6s3zAz7/bUEIKf+edU
	 9ETJeJF8nBvARAe8pp4O9agqKhDGNPCh3pBNUzDIkPWSWgKa8CdBsMHBH3BNV/fMWG
	 v8iuohJNe6KusvYI9dmcvVVyTq7z+fjUFHwk+26RGP41wNFB2J7hcZRPiokWcBTYS2
	 JHgziIzlZDrcsqgATpaEjbzvteIxpIDZ7bWbH8O+yYHtPFGuqU1Td4rWl8EfQHGRHy
	 vxeSinydRSACg==
Date: Wed, 31 May 2023 22:54:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <20230531195454.GB395338@kernel.org>
References: <20230526051529.3387103-1-song@kernel.org>
 <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
 <20230529104530.GL4967@kernel.org>
 <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
 <20230531135120.GA395338@kernel.org>
 <CAPhsuW6r=0r0dKfKxwPp9KXqLSKWw4x6RrbNBnS=1M1Y1sh5Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6r=0r0dKfKxwPp9KXqLSKWw4x6RrbNBnS=1M1Y1sh5Ag@mail.gmail.com>

On Wed, May 31, 2023 at 10:03:58AM -0700, Song Liu wrote:
> On Wed, May 31, 2023 at 6:51 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, May 30, 2023 at 03:37:24PM -0700, Song Liu wrote:
> > > On Mon, May 29, 2023 at 3:45 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > > > > On Sat, May 27, 2023 at 12:04 AM Kent Overstreet
> > > > > <kent.overstreet@linux.dev> wrote:
> > > > > >
> > > > > > I think this needs to back to the drawing board and we need something
> > > > > > simpler just targeted at executable memory; architecture specific
> > > > > > options should definitely _not_ be part of the exposed interface.
> > > > >
> > > > > I don't think we are exposing architecture specific options to users.
> > > > > Some layer need to handle arch specifics. If the new allocator is
> > > > > built on top of module_alloc, module_alloc is handling that. If the new
> > > > > allocator is to replace module_alloc, it needs to handle arch specifics.
> > > >
> > > > I'm for creating a new allocator that will replace module_alloc(). This
> > > > will give us a clean abstraction that modules and all the rest will use and
> > > > it will make easier to plug binpack or another allocator instead of
> > > > vmalloc.
> > > >
> > > > Another point is with a new allocator we won't have weird dependencies on
> > > > CONFIG_MODULE in e.g. bpf and kprobes.
> > > >
> > > > I'll have something ready to post as an RFC in a few days.
> > >
> > > I guess this RFC is similar to unmapped_alloc()? If it replaces
> > > vmalloc, we can probably trim this set down a bit (remove
> > > mod_alloc_params and vmalloc_params, etc.).
> >
> > No, it's not a new allocator. I'm trying to create an API for code
> > allocations that can accommodate all the architectures and it won't be a
> > part of modules code. The modules will use the new API just like every
> > other subsystem that needs to allocate code.
> >
> > I've got a core part of it here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=jitalloc/v1
> 
> This branch looks like the same scope as this set (but with different
> implementation). So it will still use vmalloc, right?

Yes, it still uses vmalloc. The idea is to decouple code allocations from
modules from one side and make it handle all the variants expected by the
architectures based on a set of parameters each architecture provides.

The first few commits essentially shuffle the code around and replace
arch::module_alloc() with arch::jit_alloc_params.

The commits on top enable some bits that are not available today, like ROX
executable memory and DYNAMIC_FTRACE without modules for x86.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.

