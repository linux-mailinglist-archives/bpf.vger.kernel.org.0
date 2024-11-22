Return-Path: <bpf+bounces-45481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7187D9D6578
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 22:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2A2B21D59
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 21:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0637189F5F;
	Fri, 22 Nov 2024 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdtpVftb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0B1CA9C
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732312513; cv=none; b=rH2CD4U3qNcHkCIWf2HcldkIOAQSkwznPM1DbPtChtRATXcdKE+Sgh4G4IFyWJTYXKtZmt5T40RbRDnLMSp1dlb2m1RiUwtpzTUFRtXaJtRrQ04SjesINlMHn+07UeNz1/MDmNySB6DQT7/zdI5gj4OhvOI/B/iRGaU/JoCwdwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732312513; c=relaxed/simple;
	bh=FKxX3vr5jtczmRhibWMXxcGBCSoOyD6tDDVxJAAhlGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=em0bnHpgNmlAwQveOHUvGq4QGCZpiM94qaZ51akInvLHvSs2OZw6yFbicXz0SBeG5acYp/rhCysc0CJshvR6ShW3y9S/pEUStZjluQxw4oc+aj6ZqsSt6xbZ0Mk8/uwmq8LYF6VOtFOAz+az+REqQFwZRujzjTcBpK17/j9JI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdtpVftb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382411ea5eeso1514442f8f.0
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 13:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732312510; x=1732917310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKxX3vr5jtczmRhibWMXxcGBCSoOyD6tDDVxJAAhlGU=;
        b=fdtpVftbHq3h+2j1quIqzXg5EeSIACXxYRm9jh4i4ssnSGqyBoILlGGYLiTJ6BH4DH
         NHwSlm1QMo4HgsFTYw2NlE4VRz7QCW32LG6ahK4nDJ86GQ2AKkwSkmXs3aW0lUJx9qo6
         zmyVIv8gywDxI8ax7H8uxOfEivFoC66N07HIieHwsrYVDPPfek1qIN7pjIIFJIdiTlO2
         UV0tlfoIQjURRmageass1h/E2NEPk24exdJ/5zwzWHury2wvc0dWGECxL23SrHGpUOq9
         4noRcC0EmHaaftSac66e1vw1ATn8dB3UXBYK3TKuXTlwJD8GSC4mCOkfkXVdKUoHASFe
         tGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732312510; x=1732917310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKxX3vr5jtczmRhibWMXxcGBCSoOyD6tDDVxJAAhlGU=;
        b=JgIl2IVCNZJSikdLQ+sWpA4owiBb4sfRPt/kAaRVFOxV1oPKzXIagACLwrav6RDLvQ
         H9HkjJSgA9H8NaxRsrmEajNGRF/n7nQzXx3OHXmvnjaV2pbyjF1ePcP1dNXM3Dl4ybSG
         gj5f9mK3ORR/gVbETp6NXppuWKPHzTWM1A72sx6ri5XMqHwffU2aFjCvlwEIQT8swS8z
         aIzJmVH5ajgaxl3EgdqEkhQPDbMCGirRL5M14RLql3cEYO0O9V49Z8E/9NIcgp/wD+FK
         4ri3g5bmJR+VnW1gFCXcYh9hzTac416ADppbt9ZhbGkOc7MFzlJ82Zlb2ifiaeFZgF6t
         G9lA==
X-Gm-Message-State: AOJu0Yw4Bn2Pw1ZXnM5gCBzMLHhfU7g19pXjylG552N9ykOFAJS1m4yO
	Y+A5akwJeCKLbr09nRbAdi4kMetHXpE2N74ZPvS0E5Oo8VbX7Z1OMx260R4dmCkqxD0Feq7wesK
	21SY24lSoS9jR4a+4kt16A086M+4=
X-Gm-Gg: ASbGncuZsXvcp2ny7rV03ZZ1qwR6s/GDb8Hb2KI7C4XmhCo+ILMvZHeZ07kY3grxLEU
	QyZUXr5+lPga6I7iYRWhZAs8HsjP1Kg==
X-Google-Smtp-Source: AGHT+IHQSo4wql/i1pzaDHBkaR3OdByXCchuwil2QWqT8og0y5F9A737tBEdqx/PkilsuSVx1HcXTvIJdawllG83BxA=
X-Received: by 2002:a05:6000:1acc:b0:382:42d7:eec4 with SMTP id
 ffacd0b85a97d-382601132ccmr3628041f8f.4.1732312509620; Fri, 22 Nov 2024
 13:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZzyDCKrmgAGa4NDD@google.com> <CAADnVQ+4qCnVBPbJdwYOakc+Sg-_55pekSsuavFxYS7eyMycOg@mail.gmail.com>
 <Z0BK4Pob-oPjnS1z@google.com>
In-Reply-To: <Z0BK4Pob-oPjnS1z@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 22 Nov 2024 13:54:58 -0800
Message-ID: <CAADnVQJA_pZLKWmeC7bwE7thVAjmKpxvWue-EpcOvj3wfcO5TA@mail.gmail.com>
Subject: Re: bpf: adding BPF linked list iteration support
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 1:12=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> On Wed, Nov 20, 2024 at 04:51:36PM -0800, Alexei Starovoitov wrote:
> > On Tue, Nov 19, 2024 at 4:22=E2=80=AFAM Matt Bobrowski <mattbobrowski@g=
oogle.com> wrote:
> > >
> > > Hi,
> > >
> > > Currently, we have BPF kfuncs which allow BPF programs to add and
> > > remove elements from a BPF linked list. However, we're currently
> > > missing other simple capabilities, like being able to iterate over th=
e
> > > elements within the BPF linked lists. What is our current appetite
> > > with regards to adding new BPF kfuncs that support this kind of
> > > capability to BPF linked lists?
> >
> > What kind of kfuncs do you have in mind for link lists ?
>
> At this point, it'd have to be some kind of iterator based BPF kfunc
> that allows a BPF program to traverse over the supplied BPF linked
> list, coupled with a delete based BPF kfunc such that elements from
> the list can be removed whilst performing the iteration
> i.e. list_for_each_safe/list_del. Now that I know you're not
> completely opposed to adding such BPF kfuncs, I can concretely start
> thinking about what this will actually end up looking like. But
> essentially, it'd need to be BPF kfuncs that support those 2
> previously mentioned capabilities, being traversal and arbitrary
> removal of an element whilst performing the traversal.

iterator and removal would need to be done while the lock is held.
There is no support for such things in the verifier.
I don't think it will be easy.

> > So far the only user of bpf_rbtree is sched-ext.
> > It was used in one scheduler and the experience was painful.
> > There is a chance that we will remove rbtree and link list
> > support from the verifier to reduce complexity.
> > So new link list kfuncs may be ok, but potentially not for too long.
>
> Noted.
>
> > > I know that we're now somewhat advocating for using BPF arenas
> > > whenever and wherever possible, especially when it comes to building
> > > out and supporting more complicated data structures in BPF. However,
> > > IMO BPF linked lists still have their place. Specifically, and as of
> > > now, I'd argue that the BPF linked list implementation could be
> > > considered more memory efficient when compared to a BPF arena backed
> > > linked list implementation. This is purely due to the fact that the
> > > BPF linked list implementation can perform more constrained memory
> > > allocations for elements via bpf_obj_new_impl() based on the demand,
> > > whereas for a BPF arena based implementation a BPF program needs to
> > > allocate memory upfront in terms of the number of pages (modulo the
> > > fact that not all pages for the BPF arena will necessarily be reserve=
d
> > > upfront). The fact that allocations are performed in terms of
> > > multiples of PAGE_SIZE can lead to unnecessary memory wastage.
> >
> > I don't follow this logic.
> > bpf_mem_alloc is relying on slab that relies on page alloc.
> > So either arena or bpf_ma allocates a page at a time.
> > So from that pov the cost is the same.
>
> Oh, what? So, both are actually performing full page sized allocations
> whenever there's a need to fetch more memory? My shallow understanding
> at this point was that the BPF specific memory allocator simply acts
> as a front-end cache to kmalloc(), and depending on the size of your
> allocation request i.e. via bpf_obj_new_impl for example, depends on
> what freelist that allocation is fulfilled from. Any needs for
> refilling a freelist due to exhaustion pressure are performed at
> freelist size granularity i.e. 16, 32, 64, 128, 256..., 4096.

Correct, but how do you think kmalloc works?
It's a slab on top of the buddy page allocator.
Same thing at the end.

> So, based on my current understanding and assuming that your BPF
> program at most requests 128 byte sized allocations via
> bpf_obj_new_impl, the BPF specific memory allocator will via kmalloc()
> only allocate that much more memory at a time when needing to refill

128 byte sized bpf_ma would need 128+8 which will be in 196 bucket.
While page frag on top of arena will allocate exactly 128.

> the freelist caches (maybe it'd be a multiple of that because of
> batching or something, but I don't fully understand the details of
> that just yet). In comparison to using something like a BPF arena, if
> I had to build out my own in-BPF program memory allocator that was
> backed by a BPF arena, in the need of a refill like situation, the
> allocation would be performed at page size granularity as that is the
> amount of memory that the BPF arena pulls in at a time.

kmalloc/slab->page_alloc vs page_frag->arena_alloc have
their pros and cons. But in most cases the difference can be ignored.

