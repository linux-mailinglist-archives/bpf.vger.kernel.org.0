Return-Path: <bpf+bounces-72826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD54C1BF5A
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 17:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A188D628120
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38907314A8F;
	Wed, 29 Oct 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fe1qANSy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AFC32C941
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751841; cv=none; b=e9A4kPeSCPuoIZYy67aI9vhcMBGFXOCHRlK/OWlai9FpSOfOBw+j57OJ1fgf+Ns4kMn5S3Cl622aB5VWV7z2S0SG8pVxSFxwtZkwAz+QAGPY1xPbtnsbpMKiE2VB3PXMOFiEmU+0XdiFMyJEG0GBEGfxg5Twnlg4XbBJfCL4G7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751841; c=relaxed/simple;
	bh=guB4QovAHT8kMie0PLZYLo2KFTfB2kqXlrVCoekHzzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjvQWQ4/oJOTbEf4zk53EmEBjDKSE1t6xfIcIxdGLugkphqjUizcICdnPUntFGj1S1lsOip4t4HsG/zyCC8Hl7DO6/d7Dvt8ef7i11OYaxSybU2KiReYU+QmMC/fM3/oKvtHf8sP79xwKm0xIjWFRQ4T7b2iMnZbTiYDj4mH1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fe1qANSy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2947d345949so65098045ad.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761751839; x=1762356639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/Chhgm7KMivLaP7UfXKsNLQx2xR5ZnzWFQSYqKYSi8=;
        b=Fe1qANSyoYZ+o5Xo5l0p0wAQl/dQ2l6wihovFdmQz0LNNb+yp5MG6qh1ZS/66QKA0v
         cqZTpf8lsEM15lxmPtcE0abzG3++W/TN0uTkbgf+SktGWC52Mx03E+euik+ozrA7A2PC
         YlLNE+uwkA34AijjBjEkspFrBC6kjm2OmHg9laesKo3oy3dcW7WF82scAaQ3MIJPK0S8
         zAkAKkKxCGtuE0l2DBfOzGNLHKuXYgMomGvO5lTzJZkt4AbIBfSRMOvS2Dfh0rFeJl4+
         cJMRBsrADjOm/+7Mf4ykj4Obpp0nXOz7eR6h6ILaZxaEw3Rsuy839Qx1UHhvZNWfP2Fd
         sRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751839; x=1762356639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/Chhgm7KMivLaP7UfXKsNLQx2xR5ZnzWFQSYqKYSi8=;
        b=CwwaIL818adMGe9mBQK/PfEJdWtAHKyvC/LuFRhNCw8OEz8ByWovi5jaRG8SMSk1ez
         pmb6bhXUB6ci0G+8JLJAIQXKI06KeIqQM9FGPVOQrb2xX/ED7a9tPS4eRXGQqmq3lNTF
         ggZzrjZVoYexpahHOhuT2k8uoaJ4vB3I5TmHaDnDccs9jHNKiVLu2TzcJuMc6ZijagYw
         Rtz+JbiorFklHfBZ1O/e1rvnOzD1fxHOeRHScEdlgsw6T29F9Jz88365kar5D6Mw7cEw
         hFl9FlhZdept8jNFJWHfszbpmRoIDM/ZDdYNstHQJdRrcVpoiM3oO+OJHD6y+PQmTz1T
         qeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWR2zTcvaLJ/VfYZpq3j3upa43BOO96U/Z67M5LGRC6H5E0svvpYfpZFNvtnpJnsdiAbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2QrI1IWbAR4KfysEoZU6a2I9jZswKU3CT1OeU6BoNp3H+UWR
	n1tdZNl3zWtVEuxQVoKpLpqcuv0wvsgBQdYYoygTQyw4LuJ3OfPozzLO6S3LzlLinc4chHR4bCZ
	n5vbwq4iauz5uPw72zBwDPuHlMQvpCMe1RoYdf6Bc
X-Gm-Gg: ASbGncvMWwBUjpHL/AcqszUTUyX5MZ0jUEJOsKKbcTXwWN7qnG9fxzAol2U1hOeLUGF
	xdfIJMTeBGuKk11AR41OGlL1gAXK6O0WJiErzBKZQhyesOe7X+DecglpuWuFESBgsEO+//IRto3
	6GI7JBK0YDfLXcmojnCFUYG0Njs0ozb1MzzMiYZCA8EYTcIIDCy1jLF0AZyyIVpk4yTIrapmXJV
	MP1zkJFz8ZOqTmjaHymy7Eeuv8pFOeTDZnLi5rcC76hILcUo4B74i5F26JxRBNIhrT7HO/yPcuB
	++kMKETIDziKktKWCnt63TqomA==
X-Google-Smtp-Source: AGHT+IH8xvowD+kYXQ7z5quxP2h2xDBqXwlebiin7tKEs9t726w7tT592s456fkeCdpk2YUZnOu4Up+XSy1ZFsm9bRU=
X-Received: by 2002:a17:902:d4ce:b0:28c:2db3:b9ab with SMTP id
 d9443c01a7336-294dee25ef7mr46936785ad.26.1761751838802; Wed, 29 Oct 2025
 08:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz> <CANpmjNM06dVYKrraAb-XfF02u8+Jnh-rA5rhCEws4XLqVxdfWg@mail.gmail.com>
 <0f630d2a-3057-49f7-a505-f16866e1ed08@suse.cz>
In-Reply-To: <0f630d2a-3057-49f7-a505-f16866e1ed08@suse.cz>
From: Marco Elver <elver@google.com>
Date: Wed, 29 Oct 2025 16:30:01 +0100
X-Gm-Features: AWmQ_bkcozjdjluUvttU4Roh8Mm8XDdSh0qCy1zW1YFReOaqG1YdYoXpHqK6R8Y
Message-ID: <CANpmjNOtocYUyX4HEB9GELeDVb1LbgESea98+UH5LCuYVoZbCw@mail.gmail.com>
Subject: Re: [PATCH RFC 01/19] slab: move kfence_alloc() out of internal bulk alloc
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 15:38, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/23/25 17:20, Marco Elver wrote:
> > On Thu, 23 Oct 2025 at 15:53, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> SLUB's internal bulk allocation __kmem_cache_alloc_bulk() can currently
> >> allocate some objects from KFENCE, i.e. when refilling a sheaf. It works
> >> but it's conceptually the wrong layer, as KFENCE allocations should only
> >> happen when objects are actually handed out from slab to its users.
> >>
> >> Currently for sheaf-enabled caches, slab_alloc_node() can return KFENCE
> >> object via kfence_alloc(), but also via alloc_from_pcs() when a sheaf
> >> was refilled with KFENCE objects. Continuing like this would also
> >> complicate the upcoming sheaf refill changes.
> >>
> >> Thus remove KFENCE allocation from __kmem_cache_alloc_bulk() and move it
> >> to the places that return slab objects to users. slab_alloc_node() is
> >> already covered (see above). Add kfence_alloc() to
> >> kmem_cache_alloc_from_sheaf() to handle KFENCE allocations from
> >> prefilled sheafs, with a comment that the caller should not expect the
> >> sheaf size to decrease after every allocation because of this
> >> possibility.
> >>
> >> For kmem_cache_alloc_bulk() implement a different strategy to handle
> >> KFENCE upfront and rely on internal batched operations afterwards.
> >> Assume there will be at most once KFENCE allocation per bulk allocation
> >> and then assign its index in the array of objects randomly.
> >>
> >> Cc: Alexander Potapenko <glider@google.com>
> >> Cc: Marco Elver <elver@google.com>
> >> Cc: Dmitry Vyukov <dvyukov@google.com>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >> @@ -7457,6 +7458,20 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
> >>         if (unlikely(!s))
> >>                 return 0;
> >>
> >> +       /*
> >> +        * to make things simpler, only assume at most once kfence allocated
> >> +        * object per bulk allocation and choose its index randomly
> >> +        */
>
> Here's a comment...
>
> >> +       kfence_obj = kfence_alloc(s, s->object_size, flags);
> >> +
> >> +       if (unlikely(kfence_obj)) {
> >> +               if (unlikely(size == 1)) {
> >> +                       p[0] = kfence_obj;
> >> +                       goto out;
> >> +               }
> >> +               size--;
> >> +       }
> >> +
> >>         if (s->cpu_sheaves)
> >>                 i = alloc_from_pcs_bulk(s, size, p);
> >>
> >> @@ -7468,10 +7483,23 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
> >>                 if (unlikely(__kmem_cache_alloc_bulk(s, flags, size - i, p + i) == 0)) {
> >>                         if (i > 0)
> >>                                 __kmem_cache_free_bulk(s, i, p);
> >> +                       if (kfence_obj)
> >> +                               __kfence_free(kfence_obj);
> >>                         return 0;
> >>                 }
> >>         }
> >>
> >> +       if (unlikely(kfence_obj)) {
> >
> > Might be nice to briefly write a comment here in code as well instead
> > of having to dig through the commit logs.
>
> ... is the one above enough? The commit log doesn't have much more on this
> aspect. Or what would you add?

Good enough - thanks.

> > The tests still pass? (CONFIG_KFENCE_KUNIT_TEST=y)
>
> They do.

Great.

Thanks,
-- Marco

