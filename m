Return-Path: <bpf+bounces-63630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB9FB091A6
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08FC189761A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201B2FC3DB;
	Thu, 17 Jul 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b679k7B3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD472FC007
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769440; cv=none; b=n1UshJeV0eZ1zFATHQTnf/j6/32jROMXN5UspZmLT1Z4G42RDbp4n92qxta0IAshBW/X0w1B3/jo3qDiO0Hu574k/EJ6HNbEhRrwV6FphSlG4z5NO9ScOlBESH9mz1SKl2R07fW1rwWP501lp2bLD7hW00nMFzLz7PMkDw0lzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769440; c=relaxed/simple;
	bh=Nk8MgKi5lPnsc5ClvbjZVmm59ODJhkuhBra1IO5r/SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rv2kX68FT9Axp3oboz7AX6W9w0FSAPZ9LpefC6hX9dPfwbNTzDB/gqfGO5rh9RKoMN8TzTSmObCRLbd/a5KcrDCVbVTH+Jqk1ZSwonZkmSVIh+eKLvF6wkBRT47Y2kbX0yWRgNQ6ySNDotUx8zOQbIqvcqCbjM9o4u6K2UGKj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b679k7B3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso735084f8f.2
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752769437; x=1753374237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk8MgKi5lPnsc5ClvbjZVmm59ODJhkuhBra1IO5r/SM=;
        b=b679k7B3EEUNt8cE8xiPHSRPajlKVPqilDfIaMLaqj/tiuKYj/tPRjlMUhfRA88VPK
         NVzNOuq3X53eLgKbuEG4bAZM3TX2Z/bK3XiYKsJj7ERfdEopatlujygGqo8s9dec1A1Q
         D4e6SntefyL25cCsjZtQyg381JDmQ0shJj1rVq+QU7DHRSJE4rb1wbiAMxQt+ULbQZn9
         o9in4K6G7vLpEERmCu9dIZA+vaE2qP3yNT3Duy9ILs9Wi9FKIhXPUu2qDMBQ582lg89z
         XXlKjagRBIhtcQO5RZLYpiO76wT0e74PeQ3J8jMHrQnpGpvg/KIuJ4zQabgtJfmd2MEv
         F3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769437; x=1753374237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk8MgKi5lPnsc5ClvbjZVmm59ODJhkuhBra1IO5r/SM=;
        b=wswa5zYRxAm+mottADqlx7Fy4vRSujBT/7WIKYtYERWP8yfkq1WNGX075YM52tg+aB
         E5OOSVo9UKX+grtSsgdFaI7rrQNH9NeVL0yxQD//1oaDlaj4wRAwdGHXjmFdD3VFdBy+
         G6ak/gkTRNrPa2iO0VTdYtEURvoPgW9qf3u5NZ7k5hfEa4pgL/nKe02JWoRwKhf6gXtE
         tK4Pse7OkpWMBDQrfSgi94tp+kPfyDnirruVVtMA/+N0tAXk/FwRShgWCIsJ5IpGv35b
         Nr9c4eC1kSNpjqJtsDg1Imtq0iiT/9/vXcOOrhAxAxQ/QlWHJcNQyUZk3O5TWLTOJJia
         TyNw==
X-Gm-Message-State: AOJu0Yz3BBPLS+0UNZZBvQeUQgJvGAsrWWKIQ3vbnZl4vCTGiw25k1ev
	lGfigtjPfjWT0xE2MWlKXs8RBBCKW+edcPotdYLkPPBXZS9i7xSQzD8SJoFMS6PR3oE00XfwDNd
	ZrXGKMThlFWGPOfiYW0+ezw8ON6kdfm9tYWT9
X-Gm-Gg: ASbGncu6wHUsjSZUXCi9fsNGfI+mTpyFtE7PTIIwjUjUytQnJwPdZJHkfIOWuRPFV7N
	aBrnZabXAVTecjgDINVhFMzla9BDkCl34zopvo7+cwI2a/xMObo57kqwVzcvH1aEc892K1WbaoN
	sYWJpaQOUIz2bpWHM06LhMbOklQj6AyDKw6JMjRwsqplFE9PUoXOEGEvqR9mN4NuYt6H9S1ANCM
	KGn3G4K4nT6vYYGgKIpghA=
X-Google-Smtp-Source: AGHT+IGObr3+mK/nBSSAqr/4D47SeJcDylS1eU4gWKtCeotozAgGPtjm/iwky2NIR12Cx4hqxuLn+zfiCVR+CKHVt0o=
X-Received: by 2002:a05:6000:25c3:b0:3a5:8a68:b815 with SMTP id
 ffacd0b85a97d-3b60dd996d8mr6556382f8f.46.1752769436470; Thu, 17 Jul 2025
 09:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-6-alexei.starovoitov@gmail.com> <a28390e4-23cf-4615-93e3-611b046e1973@suse.cz>
 <CAADnVQJBGWdWkGOGSMSN2quSXfaKYdnFpAqfAYYEbpJgchyNbg@mail.gmail.com> <e1095887-7a20-411c-9efe-5687e6a5ef74@suse.cz>
In-Reply-To: <e1095887-7a20-411c-9efe-5687e6a5ef74@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 09:23:43 -0700
X-Gm-Features: Ac12FXwzl8imCEsBuPqkG9NPDgHmLDQTXaLnFMmXbSPj6skZY9zJYfF0awK8QKc
Message-ID: <CAADnVQLUk7oa5kLkdO3B-YTG+nwBTnkRv7PO9XQk5sWbXPHvGA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 2:18=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> >
> > When "bool allow_spin" was there in Sebastian's version it definitely
> > looked cleaner as a proper function,
> > but now, if (!IS_ENABLED(CONFIG_PREEMPT_RT)) can be
> > #ifdef CONFIG_PREEMPT_RT
> > and the comment will look normal (without ugly backslashes)
> > So yeah. I'll convert it to macro.
>
> To clarify, the ideal I think would be e.g.
>
> #if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
>
> local_lock_irqsave();
>
> #else
>
> lockdep_assert(local_trylock_irqsave());
>
> #endif
>
> This should mean that without lockdep we just trust the code to be correc=
t
> (kmalloc_nolock() using local_lock_held() properly before calling here, a=
nd
> kmalloc() callers not being in an unsupported context, as before this
> series) with no checking on both RT and !RT.
>
> With lockdep, on RT lockdep does its checking in local_lock_irqsave()
> normally. On !RT we need to use trylock to avoid false positives in nmi, =
but
> lockdep_assert() will catch a bug still in case of a true positive.
>
> At least I hope I got it right...

Yes. Exactly what I had in mind.

> > My preference is to add a comment saying that only objects
> > allocated by kmalloc_nolock() should be freed by kfree_nolock().
>
> We could go with that until someone has a case for changing this, and the=
n
> handle kmemleak and kfence with defer_free()...

Good. Will go with warning/comment for now.

At least from bpf infra pov the context where free-ing is done
is better controlled than allocation.
Free is often in call_rcu() or call_rcu_tasks_trace() callback.
Whereas the context of kmalloc_nolock() is impossible to predict
when it comes to tracing bpf progs.
So the issues from kmalloc_nolock() -> kfree() transition are more
likely to occur, but bpf progs won't be using these primitives
directly, of course. The existing layers of protection
like bpf_obj_new()/bpf_obj_drop() will continue to be the interface.

Fun fact... initially I was planning to implement kmalloc_nolock()
only :) since bpf use case of freeing is after rcu and rcu_tasks_trace GP,
but once I realized that slab is already recursive and kmalloc_nolock()
has to be able to free deep inside, I figured I had to implement
kfree_nolock() in the same patch.
I'm talking about
alloc_slab_obj_exts() -> vec =3D kmalloc_nolock() -> kfree_nolock(vec) path=
.

