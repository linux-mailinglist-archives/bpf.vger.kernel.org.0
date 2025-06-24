Return-Path: <bpf+bounces-61411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C8AE6D5C
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05D23B8527
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BFB2D3237;
	Tue, 24 Jun 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBGAwOjs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5512236F8
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785245; cv=none; b=geef8ptV9skijrB8oxUOR9bGGAu6hFtW2rzMeMmlAWwDybS/SZNn1yIOuRTcc5QqZofTVxxslKpdhLCvMi9j+aojCftAaL8MXG1mpnH/WisiZy1GCH1rP9dUWWgT3jHUnLLLXkGYEuz0BPgmaZDzkIp9UJIrcHUgyk4LPxWBK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785245; c=relaxed/simple;
	bh=8YitItSoTNxc0wcb8HWpjDbqne7rnrM7w7V/YHH0lCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGnfeHH+H/L03qcH6yrxAj2iGhF34WNC1/TtPvyh2jTJm716jdL3l4h0pzBs9G7hIs7Xuni6uHH0Jx2Q7Ql402gkjMc8Jz+RoNjdDlQtbkANVW2UWulWXGHMO8PqtChqcO88FcFtqVPEvTKgeyscrmSa63JethLejQtifD/5WeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBGAwOjs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-453398e90e9so38711015e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750785241; x=1751390041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O05s4575vBbTgSIwvGmuswCqY0U3XoMpvRBXMQaPmpg=;
        b=VBGAwOjsObDlwYapfqlnNW0OpTFC7yi2wb8A9eukltZszdHCja9wpniNx7WyPoSE+1
         fLL8fGtYcc48hDlDZwe6C8n3VWdxL9NRA7csnQm2h8desSSG0xyyR3fWsXekYY6QAJPh
         PkVvtn4InH5BSSFNcjnHe8qBOLSo/P9lcqjBHQca4aIk7wpSrgoYRDOLFM4p1WkmUZMI
         oZHyxLqMGLqL1KNt679PlN9pJlVcA2CzInaXg5q+Bj+G0s0aO6fZzE2ariaQPyVlX0Ct
         79CUUhWkXxjv8F/fdtU5rXLg6u60UEWnarDj1+LDh6gY3Zxdkew966BHhLFv8Ju4V8Nr
         lMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750785241; x=1751390041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O05s4575vBbTgSIwvGmuswCqY0U3XoMpvRBXMQaPmpg=;
        b=P5wKiYCj2todwWSNR4ap2Miepf/cGRSbZKTHjvh2UGElJZkBgfXa79Uq4lqI8bzAc+
         FB5b2QyoqyWdRtQPJfBRiaGgtFfo3/cfQXvzFH6blkM7W0KtRyjWq30hQIVRDGa7Pwzk
         MtUXKAPosqekm8b8/AD3jCGOBvBeFAlpnYNpEB2jL/4AAdhCfWGe2y0Ep/ScNGjy6nae
         fbBFYLEBH7kq2mY9ZmRS4vTrHDjmzYsXu21qUWRPOeSuS/vT8p1htvo1gEq5KLfbsoMk
         FX3lJWXtc3nH8Vnac4HpaphhQmhiPA9oxW7eygv0/GfO1CPXgJ6kVm94Y3/IRrtoQ1IN
         1iTg==
X-Gm-Message-State: AOJu0YwGY+fmq+7MoiVDeUc7GeVhMVeuefmgb9Ew41y6rCYxm+8nnx8L
	auyulvUN1D2cFWaRhwbXkG5q+dUDd+za6uDY2BsEjbBMb5wqoOg08yzm5kM5z2mRlS/NxNWAwY6
	gKf9/BY+evTAhBqfvXh+Hwis3ODaTgto=
X-Gm-Gg: ASbGncuSCZ/EsHAhxym/XVYEAHUiOdkSTgsz/0iTYvg//XxjWK9Y0brwlc2XsCqV4vk
	5lclaGAOkopLXdPaS/wXtAbHJzjkpejmkwB3pyFOnKydxgijiJGQjaXXskHv5xI0ekzj2DpQnzZ
	0WACbG9Zx4FZx67Byb4bR6QY/U75ehAStSMKPqfFdVsiXQNXfF2fL6jE11TyE=
X-Google-Smtp-Source: AGHT+IHpwXqn25MjRJJ+HK6d3j76DB4ejMnh7zmsER9R493vaK71nT56UgyeM9k+XIrMu5FMCHiF0fOAVLJXYRLD0Eg=
X-Received: by 2002:a05:600c:3b15:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-453659c3b8cmr151708275e9.5.1750785240860; Tue, 24 Jun 2025
 10:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com> <aB1UVkKSeJWEGECq@hyeyoo>
In-Reply-To: <aB1UVkKSeJWEGECq@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 10:13:49 -0700
X-Gm-Features: Ac12FXxK3oDOHzZ3IPosIrFcZDleZ2SVgraCT-lhd77AXqMkzOnJ6FS5gXXSYsk
Message-ID: <CAADnVQKQ-kqpO_vkyDcaUdvrvntWjwUfDy00SOawuRMrx0rfzw@mail.gmail.com>
Subject: SLAB_NO_CMPXCHG was:: [PATCH 6/6] slab: Introduce kmalloc_nolock()
 and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 6:03=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wro=
te:
> > +     s =3D kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> > +
> > +     if (!(s->flags & __CMPXCHG_DOUBLE))
> > +             /*
> > +              * kmalloc_nolock() is not supported on architectures tha=
t
> > +              * don't implement cmpxchg16b.
> > +              */
> > +             return NULL;
>
> Hmm when someone uses slab debugging flags (e.g., passing boot
> parameter slab_debug=3DFPZ as a hardening option on production [1], or
> just for debugging), __CMPXCHG_DOUBLE is not set even when the arch
> supports it.
>
> Is it okay to fail all kmalloc_nolock() calls in such cases?

I studied the code and the git history.
Looks like slub doesn't have to disable cmpxchg mode when slab_debug is on.
The commit 41bec7c33f37 ("mm/slub: remove slab_lock() usage for debug
operations")
removed slab_lock from debug validation checks.
So right now slab_lock() only serializes slab->freelist/counter update.
It's still necessary on arch-s that don't have cmpxchg, but that's it.
Only __update_freelist_slow() is using it.
folio_lock() is the same lock, but PG_locked is there for different
reasons. 10+ years ago PG_locked bit was reused for slab serialization.
Today it's unnecessary to do so. Abusing the same bit for
freelist/counter updates doesn't provide any better slab debugging.
The comment next to SLAB_NO_CMPXCHG is obsolete as well.
It's been there since days that slab_lock() was taken during
consistency checks. Removing misuse of PG_locked is a good thing on
its own.

I think the following diff is appropriate:

diff --git a/mm/slub.c b/mm/slub.c
index 044e43ee3373..9d615cfd1b6f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -286,14 +286,6 @@ static inline bool
kmem_cache_has_cpu_partial(struct kmem_cache *s)
 #define DEBUG_DEFAULT_FLAGS (SLAB_CONSISTENCY_CHECKS | SLAB_RED_ZONE | \
                                SLAB_POISON | SLAB_STORE_USER)

-/*
- * These debug flags cannot use CMPXCHG because there might be consistency
- * issues when checking or reading debug information
- */
-#define SLAB_NO_CMPXCHG (SLAB_CONSISTENCY_CHECKS | SLAB_STORE_USER | \
-                               SLAB_TRACE)
-
-
 /*
  * Debugging flags that require metadata to be stored in the slab.  These =
get
  * disabled when slab_debug=3DO is used and a cache's min order increases =
with
@@ -6654,7 +6646,7 @@ int do_kmem_cache_create(struct kmem_cache *s,
const char *name,
        }

 #ifdef system_has_freelist_aba
-       if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG)) {
+       if (system_has_freelist_aba()) {
                /* Enable fast mode */
                s->flags |=3D __CMPXCHG_DOUBLE;
        }

It survived my stress tests.
Thoughts?

