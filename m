Return-Path: <bpf+bounces-1513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9357183B5
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 15:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA57B2814C8
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E3E14ABC;
	Wed, 31 May 2023 13:51:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8114A95
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE6FC433D2;
	Wed, 31 May 2023 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685541105;
	bh=B3N6YHdsFd5bPXI4OFTcPK/kl2cL7GTlWbHn5XcxccU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSrNQlbXLkP7OPfaP4f9CJjlzTtVupzjE3UkcNVidX1ShjoM37KTUOY0L1MO8u1tw
	 zUL9t+OvlyBZj8/SysBwAeub43D2MhJgPH6vgY4XXIWeg44cAlK6GmCsbTWcteJkv8
	 blRcIhsH4eDJCDKmLaGtEPZbfyNJp/qqZO5aXfBtDXB19eSQD5MukWCj3cVSNlKTR0
	 ClebjkweU55d+7QdLvPKg1/jWuk7P1a+Zsr/axepmsJgqDUTJZBvDTz4mYTZFadZks
	 reYootRezpaeWoHGqklnmo7eVJYPkhkWgbUStnfM0QeVcucNAI/iif0kZGFCkezXSw
	 tfilJlbRFXrLg==
Date: Wed, 31 May 2023 16:51:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <20230531135120.GA395338@kernel.org>
References: <20230526051529.3387103-1-song@kernel.org>
 <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
 <20230529104530.GL4967@kernel.org>
 <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>

On Tue, May 30, 2023 at 03:37:24PM -0700, Song Liu wrote:
> On Mon, May 29, 2023 at 3:45 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > > On Sat, May 27, 2023 at 12:04 AM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > I think this needs to back to the drawing board and we need something
> > > > simpler just targeted at executable memory; architecture specific
> > > > options should definitely _not_ be part of the exposed interface.
> > >
> > > I don't think we are exposing architecture specific options to users.
> > > Some layer need to handle arch specifics. If the new allocator is
> > > built on top of module_alloc, module_alloc is handling that. If the new
> > > allocator is to replace module_alloc, it needs to handle arch specifics.
> >
> > I'm for creating a new allocator that will replace module_alloc(). This
> > will give us a clean abstraction that modules and all the rest will use and
> > it will make easier to plug binpack or another allocator instead of
> > vmalloc.
> >
> > Another point is with a new allocator we won't have weird dependencies on
> > CONFIG_MODULE in e.g. bpf and kprobes.
> >
> > I'll have something ready to post as an RFC in a few days.
> 
> I guess this RFC is similar to unmapped_alloc()? If it replaces
> vmalloc, we can probably trim this set down a bit (remove
> mod_alloc_params and vmalloc_params, etc.).

No, it's not a new allocator. I'm trying to create an API for code
allocations that can accommodate all the architectures and it won't be a
part of modules code. The modules will use the new API just like every
other subsystem that needs to allocate code.

I've got a core part of it here:

https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=jitalloc/v1

and I hope I'll get it ready to post this week.

> Thanks,
> Song

-- 
Sincerely yours,
Mike.

