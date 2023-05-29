Return-Path: <bpf+bounces-1410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3645E714F5D
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 20:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18EC280F38
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 18:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31493C8F8;
	Mon, 29 May 2023 18:25:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A479F0
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 18:25:18 +0000 (UTC)
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22379C4
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 11:25:17 -0700 (PDT)
Date: Mon, 29 May 2023 14:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685384715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dcw0wi1IKmWoL1+2Aech130Jerxslz1zIA7wJ3PVaaE=;
	b=hvyv6MMtqup1fC317UHrZ0xYxTWI1yPtQXSD9f4elllGt7Xgm7MqPJilWH25onE5HEZvqk
	4yMVcoSREt2QbHkEhCzPwLZsVf8WF36+fMAbB6bHkk92EfO+O72ca32VR3jDQwkUOA4Znj
	ADEM3xGH2low/mLNfirkjQEnNn5kTzA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mcgrof@kernel.org,
	peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
	rppt@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <ZHTuBdlhSI0mmQGE@moria.home.lan>
References: <20230526051529.3387103-1-song@kernel.org>
 <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> I don't think we are exposing architecture specific options to users.
> Some layer need to handle arch specifics. If the new allocator is
> built on top of module_alloc, module_alloc is handling that. If the new
> allocator is to replace module_alloc, it needs to handle arch specifics.

Ok, I went back and read more thoroughly, I got this part wrong. The
actual interface is the mod_mem_type enum, not mod_alloc_params or
vmalloc_params.

So this was my main complaint, but this actually looks ok now.

It would be better to have those structs in a .c file, not the header
file - it looks like those are the public interface the way you have it.

> > The memory protection interface also needs to go, we've got a better
> > interface to model after (text_poke(), although that code needs work
> > too!). And the instruction fill features need a thorough justification
> > if they're to be included.
> 
> I guess the first step to use text_poke() is to make it available on all
> archs? That doesn't seem easy to me.

We just need a helper that either calls text_poke() or does the page
permission dance in a single place.

If we do the same thing for other mod_mem_types, we could potentially
allow them to be shared on hugepages too.

