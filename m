Return-Path: <bpf+bounces-45580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9499D89BC
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 16:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC2C169220
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802CC1AF0C5;
	Mon, 25 Nov 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LM6b2E6c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE8194AC7
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549969; cv=none; b=bv1+OQcCa7jwWFyNPNTymiWrXoqCz8tjISaYzEG3APb9XdwEUoVUaaigHMy4ibOxF0f2Pz7ED1dBMdmhFudOXwlyLxJXgF+G2dugig+thXy+q85TIik+VHtJfjBCNSmDPLGa0lfrXRbkXjCDW5TBia/4GP3jg22tctUSjnQb3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549969; c=relaxed/simple;
	bh=rXXcf+8fgI9k1fKciwcHZr8GztycczWdb5sTCeT+Nsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUhMc1Cv6rZwcv3xf2Tj5xo3su5FSB5TAa8NQimGKQaEnulXGs0wsYB8V+D4mPJsImY2ttnRsVeXffNvMkbBmHbQ7XSKfMVOSJ6K5zY7Ur27jslhDXCREXP7XN2DkhHLPvAmIVDUsgjXQ7O3o06lPF8td+2+n+7E51VrFF1OO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LM6b2E6c; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so462210066b.3
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 07:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732549965; x=1733154765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IkcuVcBZKo0fSv25XbOh4wEr88fYLEogcpBHxRTGTRc=;
        b=LM6b2E6cbfqM+UHIsdcdAEfDYxrAgY9ooKOAZ3tlSlcKMNSr5k5NKpLxXThUXSLmQ/
         rOkXx9ZgNqkx79MbInxbhMmye5AoJOPHZjhnWtci4eW3qBr5kCEWHLZKyx6c1VV0gxX8
         KgL73WoQEFJuKYRiRQ32C1dbTlEfVj6tRRbzvYuc0XcQaLN1cpZPD5w6LDT7W1s1q1it
         2OQTMWLyDcXCtvBW1J1Y4E8wXAEb0jeMjiVNpq2bAsVkyr3163AeOI2wQSQXrS/Mr62Z
         L8UdT6JRq3GSDLad7HTX2tWiIHX9JT6UPGxoLtXkUlbXkfdOsRP7pB0GM2nrvE7K+Kpb
         mzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732549965; x=1733154765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkcuVcBZKo0fSv25XbOh4wEr88fYLEogcpBHxRTGTRc=;
        b=fqL7PesQyUannb7GQ7dAHOB7a9FmZ//d9Zo5WPEqy/XxiGtPxa+9vTgSJ7b8VbnRfr
         xear4lMgrCSxH0mGhkSeLWmMy2nYgs7Pruc4FhUvq1QnC+ERSxKBY6kq6Tzg68PX3Q/S
         2jsvmb8Kyz96XRakPZl6JUMJO2MUqxEt1hkQJkCZrtEdubmo8a61j8rKAKNR6ZRFqPA4
         a4S1gyfBl+yLmtR3inQwbz8gbJnl7bIvefNL9FuhpBzusyjH9nJSVnr9sCj2L/HDJUya
         AjyszTLrJCaJg4AJkafNSuRA6iIXwu+ZpRtJZXNFOiMBlZ5Xtn3SYBt6hpUu9kQdv/ux
         CjKg==
X-Gm-Message-State: AOJu0YyfS92WHQo4OqFV8muO6POP16hTHIl/+NizdR+uUSAKCGvCrOKG
	btS1VSilGBbKrCoZMlOqSeEjz52OeBqnUo90Z0Rkq4S3KvwuhZnzVWtQnkl8DQ==
X-Gm-Gg: ASbGncukYnHUtWlsLfGitUZeWbsXAunt7qHF1Gt7JU2E709f1l/vlrSmxXEVPE3chhF
	i9Pa+c+iyrcXSa/C+fdeBVxewCi1zjjIOF3dWaqn4TVi6MeNBIhkV53vRDmsinn+eSAV1sTRhey
	/TjaKjHx2WGrWrdJyYoZtuhRjboIY0rgcaP1UYnxBke6MUG4urAsN2g6v2cHyaRYOdNZ2sjnmPV
	vp8PyFErnmOk/VFOA1k+oFkczzZIZGkLyKNcotbTcUsOcFhWotc5zRTZsl9AzQtHWvNAT302Ukg
	3MtZk7uOfZ532GbR8Dg=
X-Google-Smtp-Source: AGHT+IHJd/nKCqZ4nuFDCMEJQDC4CEojlpj/3TR1UhIKGocxlmcfORXTxnCenJF4k0XFUgY1gACo4Q==
X-Received: by 2002:a17:906:9d2:b0:aa5:b32:6966 with SMTP id a640c23a62f3a-aa50b327982mr1056427766b.50.1732549965353;
        Mon, 25 Nov 2024 07:52:45 -0800 (PST)
Received: from google.com (97.176.141.34.bc.googleusercontent.com. [34.141.176.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2a4f03sm475928766b.40.2024.11.25.07.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:52:44 -0800 (PST)
Date: Mon, 25 Nov 2024 15:52:40 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: bpf: adding BPF linked list iteration support
Message-ID: <Z0SdSFdRNeexH6NK@google.com>
References: <ZzyDCKrmgAGa4NDD@google.com>
 <CAADnVQ+4qCnVBPbJdwYOakc+Sg-_55pekSsuavFxYS7eyMycOg@mail.gmail.com>
 <Z0BK4Pob-oPjnS1z@google.com>
 <CAADnVQJA_pZLKWmeC7bwE7thVAjmKpxvWue-EpcOvj3wfcO5TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJA_pZLKWmeC7bwE7thVAjmKpxvWue-EpcOvj3wfcO5TA@mail.gmail.com>

On Fri, Nov 22, 2024 at 01:54:58PM -0800, Alexei Starovoitov wrote:
> On Fri, Nov 22, 2024 at 1:12 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > On Wed, Nov 20, 2024 at 04:51:36PM -0800, Alexei Starovoitov wrote:
> > > On Tue, Nov 19, 2024 at 4:22 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Currently, we have BPF kfuncs which allow BPF programs to add and
> > > > remove elements from a BPF linked list. However, we're currently
> > > > missing other simple capabilities, like being able to iterate over the
> > > > elements within the BPF linked lists. What is our current appetite
> > > > with regards to adding new BPF kfuncs that support this kind of
> > > > capability to BPF linked lists?
> > >
> > > What kind of kfuncs do you have in mind for link lists ?
> >
> > At this point, it'd have to be some kind of iterator based BPF kfunc
> > that allows a BPF program to traverse over the supplied BPF linked
> > list, coupled with a delete based BPF kfunc such that elements from
> > the list can be removed whilst performing the iteration
> > i.e. list_for_each_safe/list_del. Now that I know you're not
> > completely opposed to adding such BPF kfuncs, I can concretely start
> > thinking about what this will actually end up looking like. But
> > essentially, it'd need to be BPF kfuncs that support those 2
> > previously mentioned capabilities, being traversal and arbitrary
> > removal of an element whilst performing the traversal.
> 
> iterator and removal would need to be done while the lock is held.
> There is no support for such things in the verifier.
> I don't think it will be easy.

Hm, I was under the impression that this would rather be trivial to
add, but you'd obviously have more of an idea than I. Let me think
about how I want to go about adding these BPF kfuncs and come back to
you with a proposal.

> > > So far the only user of bpf_rbtree is sched-ext.
> > > It was used in one scheduler and the experience was painful.
> > > There is a chance that we will remove rbtree and link list
> > > support from the verifier to reduce complexity.
> > > So new link list kfuncs may be ok, but potentially not for too long.
> >
> > Noted.
> >
> > > > I know that we're now somewhat advocating for using BPF arenas
> > > > whenever and wherever possible, especially when it comes to building
> > > > out and supporting more complicated data structures in BPF. However,
> > > > IMO BPF linked lists still have their place. Specifically, and as of
> > > > now, I'd argue that the BPF linked list implementation could be
> > > > considered more memory efficient when compared to a BPF arena backed
> > > > linked list implementation. This is purely due to the fact that the
> > > > BPF linked list implementation can perform more constrained memory
> > > > allocations for elements via bpf_obj_new_impl() based on the demand,
> > > > whereas for a BPF arena based implementation a BPF program needs to
> > > > allocate memory upfront in terms of the number of pages (modulo the
> > > > fact that not all pages for the BPF arena will necessarily be reserved
> > > > upfront). The fact that allocations are performed in terms of
> > > > multiples of PAGE_SIZE can lead to unnecessary memory wastage.
> > >
> > > I don't follow this logic.
> > > bpf_mem_alloc is relying on slab that relies on page alloc.
> > > So either arena or bpf_ma allocates a page at a time.
> > > So from that pov the cost is the same.
> >
> > Oh, what? So, both are actually performing full page sized allocations
> > whenever there's a need to fetch more memory? My shallow understanding
> > at this point was that the BPF specific memory allocator simply acts
> > as a front-end cache to kmalloc(), and depending on the size of your
> > allocation request i.e. via bpf_obj_new_impl for example, depends on
> > what freelist that allocation is fulfilled from. Any needs for
> > refilling a freelist due to exhaustion pressure are performed at
> > freelist size granularity i.e. 16, 32, 64, 128, 256..., 4096.
> 
> Correct, but how do you think kmalloc works?
> It's a slab on top of the buddy page allocator.
> Same thing at the end.

Right, I can see what you mean by this. So, whether you're memory
allocation request is being fulfilled by the BPF specific memory
allocator or BPF arena, in the end if you're in need of more memory
you're technically interfacing with the same backend i.e. Buddy
Allocator, and that in itself still ends up managing memory in
page-sized chunk granularity.

I just thought that given that kmalloc() interfaces with the
middle-end, being the SLUB/SLAB/SLOB allocator in this case, it too
has its allocation requests served from pre-allocated caches. So, in
theory, it'd mean that when the BPF specific memory allocator needs
more memory those memory requests would be fulfilled from this layer
of cache first prior to actually going all the way down to the Buddy
Allocator and getting more pages of memory directly from
it. Admittedly though, I have not looked at how BPF arena memory
allocation requests are fulfilled, so it could actually just end up
taking the exact same route. Maybe I'll have a look at that tonight as
I'm curious now.

