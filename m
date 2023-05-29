Return-Path: <bpf+bounces-1374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E471482A
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 12:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FA8280E3C
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644BB3D72;
	Mon, 29 May 2023 10:45:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01740A53
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 10:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C9C433D2;
	Mon, 29 May 2023 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685357155;
	bh=YyZhd7+u4rnN68BcvCm78mN9H7X5EQow465eMlMwb4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAGhpNbneXKu5Fu+MvG/WOrAYFJa/OhdGymyw5GN6sYkdBGsPBX1UbwYq+xtmcXiS
	 GSc+hMQ6MFpNsY/QCqnjbpL3JYYbKuBmhGnnK90BnWJ/iAeKv8t0h0YWHQBJxbGRix
	 D9+ULVYtggHIYgYaJVL+vNY2pQ/zg/RSfKPoc496Obts+VgzMbbu0zTBkxOg5mLiBE
	 ustXpn3uJ8ZNVVgx0FEQrvLk0lK9smLr3YNL84eyEuIYQYVUlrD5Z/0k3p4m8NZ9h8
	 vdCA4pucvoTL+6/eumOu/74mhwYt6AT9O/ZrxY/R9l16QWvX67qjTfueFzHgiQZaxq
	 eCrLxfGUvno7A==
Date: Mon, 29 May 2023 13:45:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <20230529104530.GL4967@kernel.org>
References: <20230526051529.3387103-1-song@kernel.org>
 <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>

On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> On Sat, May 27, 2023 at 12:04 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > I think this needs to back to the drawing board and we need something
> > simpler just targeted at executable memory; architecture specific
> > options should definitely _not_ be part of the exposed interface.
> 
> I don't think we are exposing architecture specific options to users.
> Some layer need to handle arch specifics. If the new allocator is
> built on top of module_alloc, module_alloc is handling that. If the new
> allocator is to replace module_alloc, it needs to handle arch specifics.
 
I'm for creating a new allocator that will replace module_alloc(). This
will give us a clean abstraction that modules and all the rest will use and
it will make easier to plug binpack or another allocator instead of
vmalloc.
Another point is with a new allocator we won't have weird dependencies on
CONFIG_MODULE in e.g. bpf and kprobes.

I'll have something ready to post as an RFC in a few days.

> Thanks,
> Song

-- 
Sincerely yours,
Mike.

