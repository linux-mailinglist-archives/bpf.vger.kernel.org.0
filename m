Return-Path: <bpf+bounces-45453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F55F9D5BA9
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 10:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE41B23CF7
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D5183CAE;
	Fri, 22 Nov 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWlZcSSD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD66917BB1E
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266731; cv=none; b=fXROdpaE/RJHp4SClTOjgPMohPH7UGdsZtX8qvR7bgyXU/QAcNm2aeREXuECfmHUKvEboc4aPOIhLXytK5l470YJT6KS0MQqMa/FPJQ4gmA3+iz8XNHlWnYcvYvuTEGpuN6x1MopSbMXqlclMZcOwfAMRoOPjNGGSArznccQbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266731; c=relaxed/simple;
	bh=XwO23q36DMvctywuCZtvEILk+SKGnnhv9yOjb3nyqPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwuc/XJPAxRZqMzPzT9YGFhWmGy37cRC/I1FNvbk+iydgKHfiKNHgV128iBrTOFZkkj4QYhbHj8Znu3kj8WMoEAFjKYZVMX4Uwzw4lSZi/Pj0DME0xrZpEAWQcKLcvXDOA8/8GJ7aQFvnNJHJXK4dd9BdmE/n3S3PwAUL2x1MEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWlZcSSD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53dd9246d21so111392e87.1
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732266728; x=1732871528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SIgoelk7O6ghnjqLS/arvJd8GesZqWVwrGWBpYoIq9Y=;
        b=TWlZcSSDphISKNosFkfUMpyrR5AYe+5ioCRVgMzH0bBDx7wtX3cFoSbpRCsrfFExcM
         Az1lQrL7L9zQ+nr8ZwhJNdNXqieSZeTzbS8coD6GyXLTkkApvq8F3snpe04KaOza0qvS
         PrfOrgWbfpsKTugSU6zA9eJS0VxRGEGdPxZ2qea5C3d5DVa/JDUK64JfkUHaNxWq2IQf
         1iQLYFSZglOn8W/+bsorSieq6z6gZGQaWGfsVNX3aPvioeGn+XGl7E+lPaLr0zWmyaHn
         wqLGKxjQ1qNqFLqYKPM2wTqo2uKOVFySaxSyMV1rm7PiifyZYyJ+d+Rh9HL65kemhoTD
         87vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266728; x=1732871528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIgoelk7O6ghnjqLS/arvJd8GesZqWVwrGWBpYoIq9Y=;
        b=V3Ao27Xq2af+YgOuGw+LGv72hcM2zDKV/Vxu+H6nJ/an41CHprncwXbdKz21IKY1Z8
         ANrokrcztij2yrEEU1W/zr+lpHjhMW/XGoCQ9vTewpBfuwVAP107f88aBSwFc7cW5snY
         OI1exsS7DTpmfC4CjG5QsOGjb8LDpcGgezfIdmaCKqvCQVvFMB+/dG8OcUMk/cxgAS/U
         g3C3s1QLpIKTjjNxQ+SIuWtr+QoT2QqJ44t99C0AsISEuy0Z8czR7tgPuh2RjVYGX4EQ
         St/0eAkO3dbtcuYAngiYSiDOrorrqueWNYIvTUOEdp7eL2epzrsq255/Xs57+GMkUxQz
         UA1A==
X-Gm-Message-State: AOJu0YzexV92MrV6kfdGMH5Ob4kC54rzU545KfilBYPCdEv+oI2rX3T2
	Pp39gNQf8t86kCTBNe16bJA5DO/nvn/lwSbmWg+YKL0N/sY0XqnpJn0ucmSoOw==
X-Gm-Gg: ASbGnctWpaB0euUjCrI+fGWcmz3ZtgUG9dsJi0gCg3xYtH7UQGZO9Nhr9kNHyTf44Yy
	RSPG3TvTk5trokLsnL/CjFyfCIy0bv4ZIL2ucAoO8UMA9cVHzkxYPI9RT8mhgd2AqEr0pb6Yxoz
	7jzcArWtQJh3DzEqnB52z16P0A8AQ8zWaoHXU8GwcLrDZHlIpnWmVx8xyztWItYur775VNKFXaW
	rqo0LqFRm5IIorvgUbEEFhIO7bWJQaIXUZx3+eFl0pugsZ61jwr8cUi5De6LjmYdjQrDZ5V9rCy
	YZveaGacRAlo4oy1bn8=
X-Google-Smtp-Source: AGHT+IGo3ms5s9/ZRdMUszGQJh2s6rx6TeIosF/PQD+iPFTOgXrKamafMz4f5jBHJQjMUIvni4Bbow==
X-Received: by 2002:a05:6512:32c9:b0:539:f035:e158 with SMTP id 2adb3069b0e04-53dd35a8cd4mr896653e87.18.1732266727579;
        Fri, 22 Nov 2024 01:12:07 -0800 (PST)
Received: from google.com (97.176.141.34.bc.googleusercontent.com. [34.141.176.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f045asm73106866b.53.2024.11.22.01.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:12:05 -0800 (PST)
Date: Fri, 22 Nov 2024 09:12:00 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: bpf: adding BPF linked list iteration support
Message-ID: <Z0BK4Pob-oPjnS1z@google.com>
References: <ZzyDCKrmgAGa4NDD@google.com>
 <CAADnVQ+4qCnVBPbJdwYOakc+Sg-_55pekSsuavFxYS7eyMycOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+4qCnVBPbJdwYOakc+Sg-_55pekSsuavFxYS7eyMycOg@mail.gmail.com>

On Wed, Nov 20, 2024 at 04:51:36PM -0800, Alexei Starovoitov wrote:
> On Tue, Nov 19, 2024 at 4:22 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > Hi,
> >
> > Currently, we have BPF kfuncs which allow BPF programs to add and
> > remove elements from a BPF linked list. However, we're currently
> > missing other simple capabilities, like being able to iterate over the
> > elements within the BPF linked lists. What is our current appetite
> > with regards to adding new BPF kfuncs that support this kind of
> > capability to BPF linked lists?
> 
> What kind of kfuncs do you have in mind for link lists ?

At this point, it'd have to be some kind of iterator based BPF kfunc
that allows a BPF program to traverse over the supplied BPF linked
list, coupled with a delete based BPF kfunc such that elements from
the list can be removed whilst performing the iteration
i.e. list_for_each_safe/list_del. Now that I know you're not
completely opposed to adding such BPF kfuncs, I can concretely start
thinking about what this will actually end up looking like. But
essentially, it'd need to be BPF kfuncs that support those 2
previously mentioned capabilities, being traversal and arbitrary
removal of an element whilst performing the traversal.

> So far the only user of bpf_rbtree is sched-ext.
> It was used in one scheduler and the experience was painful.
> There is a chance that we will remove rbtree and link list
> support from the verifier to reduce complexity.
> So new link list kfuncs may be ok, but potentially not for too long.

Noted.

> > I know that we're now somewhat advocating for using BPF arenas
> > whenever and wherever possible, especially when it comes to building
> > out and supporting more complicated data structures in BPF. However,
> > IMO BPF linked lists still have their place. Specifically, and as of
> > now, I'd argue that the BPF linked list implementation could be
> > considered more memory efficient when compared to a BPF arena backed
> > linked list implementation. This is purely due to the fact that the
> > BPF linked list implementation can perform more constrained memory
> > allocations for elements via bpf_obj_new_impl() based on the demand,
> > whereas for a BPF arena based implementation a BPF program needs to
> > allocate memory upfront in terms of the number of pages (modulo the
> > fact that not all pages for the BPF arena will necessarily be reserved
> > upfront). The fact that allocations are performed in terms of
> > multiples of PAGE_SIZE can lead to unnecessary memory wastage.
> 
> I don't follow this logic.
> bpf_mem_alloc is relying on slab that relies on page alloc.
> So either arena or bpf_ma allocates a page at a time.
> So from that pov the cost is the same.

Oh, what? So, both are actually performing full page sized allocations
whenever there's a need to fetch more memory? My shallow understanding
at this point was that the BPF specific memory allocator simply acts
as a front-end cache to kmalloc(), and depending on the size of your
allocation request i.e. via bpf_obj_new_impl for example, depends on
what freelist that allocation is fulfilled from. Any needs for
refilling a freelist due to exhaustion pressure are performed at
freelist size granularity i.e. 16, 32, 64, 128, 256..., 4096.

So, based on my current understanding and assuming that your BPF
program at most requests 128 byte sized allocations via
bpf_obj_new_impl, the BPF specific memory allocator will via kmalloc()
only allocate that much more memory at a time when needing to refill
the freelist caches (maybe it'd be a multiple of that because of
batching or something, but I don't fully understand the details of
that just yet). In comparison to using something like a BPF arena, if
I had to build out my own in-BPF program memory allocator that was
backed by a BPF arena, in the need of a refill like situation, the
allocation would be performed at page size granularity as that is the
amount of memory that the BPF arena pulls in at a time.

This is what I was basically trying to get at, but my trail of thought
may be flawed by my lack of understanding on how something actually
works in practice.

> But in practice bpf_ma needs extra 8 bytes for every allocation
> whereas arena allocs don't have this overhead.

Makes sense, freelist objects need to be tracked somehow by the BPF
specific memory allocator...

> Right now arena allocs need to be sleepable and that is
> a severe limitation for tracing use cases.
> We're working on lifting that. Once that happens
> allocs in arena will be more usable than bpf_ma.

Cool, sonuds good. I'm following this closely too BTW, because at some
point I think we'll end up using BPF arenas for a bunch of our stuff.

> kptr-s in arena is another required feature.
> There were few proposals. So it will be done as well. Eventually.
> So new link list kfuncs are ok, but might get removed in the future.

Let me think about this a little more and send out an RFC patch series
when time permits.

