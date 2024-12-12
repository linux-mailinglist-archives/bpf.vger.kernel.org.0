Return-Path: <bpf+bounces-46683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C09EDDBF
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 03:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D471167FB2
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 02:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2DC7CF16;
	Thu, 12 Dec 2024 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvRPX/Wu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC972EB00
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733971782; cv=none; b=sOoOoe3IyZnCW9O6hI85flhx0xVvBKuQIZoxzs/6svEpBvGvHSmQj5p+sWfw8oo3lfIjtrLs3KwQP0RCi9RHjs6tak2XASIjDp/1JGVMWkq7ITTWWyJOxebdAmMLoFkSemh1FDZ0jUiheP44ve22iyRF0WOZib/9fPWRCY/OWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733971782; c=relaxed/simple;
	bh=2kElPuwqIjUpGNUhIL1GCGkmu/OVCg6nIr0OPDszj+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2TG9Dm9FYlmwW1wvScVnKouDtgCfFBNG6n7SROS88bks0VLcRpzcmcAp8q0E+apuu6B8W8R7FbcPzIMu5GpzDtgvsPhsgZ/TdfuT8kKKNdG+nIvPZRG4bGeVm/wVizH18PFQ8OEbtmVH19xP7+ugW32jDg3lARAydhsiqaRv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvRPX/Wu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e87b25f0so816282f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 18:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733971779; x=1734576579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca8OIYO0+FSLXAgUGro2sDxj5RgcMXkMj04Ise63hr4=;
        b=GvRPX/WuuHPqdDqht5Um3F+e23f2M9bmWmfFF8hCEX1KwVCF3jIi3VaUGjtGYJA/zo
         pPQd6LW7UJ3xC9uohnU72yN3gEBKvKh9AdKzHI+fb/09sg6J2lYVkr/t31MHJfFvmP7K
         DYMHAh6YnDuZyipIjjaZAVyZe9RrBtv3owd8KxlYGGnGP1rzTIjhkY9MaFTg4e/zeWqf
         1h4jbMjdjZcS4ufB5Zj4nDJPpXr69CdpXiOSFhRnNI6oXomCsEBg9Gq/UgYqKd3xyg+t
         epPRPWtk7UKTROvtc1ekI1qGgk3197Ylp1p8NwHw/aB/mjFyoqjF2qMJJiwi2eaO+DzA
         L5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733971779; x=1734576579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca8OIYO0+FSLXAgUGro2sDxj5RgcMXkMj04Ise63hr4=;
        b=JwNfBQYVKQixbUxQrK4bFBwib/EG02H2t6q0MMpX5VGPZp351deG/PtgjE2uCiAnP7
         coQq13uNQM2KVZpOAregwz+n4jmkN4fnJPtixtkrmuOBm6o52gjnIDOj3+AReoMe2UN8
         nJh4oXTPbXYSVawLGnDoO6wI+Z2x121mzi0edgd7IYdqjscwsyCowLui6aL26Ek58qzU
         JnddcXmJI4d4WdJr3KalRWcMNdoJ/lCIcQLff2TkLMRJrBZczDO0dZSU4OII67Ky8DWc
         mlTzU3wZwgF1f5iAMm+jajlFRZYw6IYOQkJRAAPVaZbpGLoKOQRFo6aGLgISnFtDa2QH
         PRAQ==
X-Gm-Message-State: AOJu0Yyu7Q7vtfgu324wlzEfjnOB6wW/7m5cnIaU4U3++qCuPQDrufGd
	TJO2iIkdFZ+f7hLIbxeP5llofR6WTUaaRVIGmHM2zMYZE7mGU+eBqA7fEvkV9umMLyMXIB54pAH
	Y+12XPmsjIzkIzuvIbd6y08JcmlE=
X-Gm-Gg: ASbGncveZ8dCZN7oQK4EG3lst29WMzI05M9Q10S+008Vpsx4iVbDlHDQGiI2XCGRkX4
	9gBr1gz+b8xiJ1/ywM7rqACcahwHKbxSktCtBX8zj1MvcxkE+8G113w==
X-Google-Smtp-Source: AGHT+IFP/H5kWKEKUgpAjEJiXLREvhvKzOTx05dqLUwJKirYPA9qWNJlHiu/CRMGLNAneMlTFVnYuD3O/x8WFJOQ2ow=
X-Received: by 2002:a05:6000:1543:b0:386:2e8c:e26d with SMTP id
 ffacd0b85a97d-3878840808emr1065650f8f.0.1733971779204; Wed, 11 Dec 2024
 18:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-4-alexei.starovoitov@gmail.com> <1c760bf1-14a4-42e4-a55b-438a29987aef@suse.cz>
 <9e5bdef1-a692-47d5-82b9-96a4f2c68463@suse.cz>
In-Reply-To: <9e5bdef1-a692-47d5-82b9-96a4f2c68463@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Dec 2024 18:49:28 -0800
Message-ID: <CAADnVQJtkb3YVM9La_Zo=t_s+DNNrrVhX1gt5KsQUPZTdw_7Eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] locking/local_lock: Introduce local_trylock_irqsave()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 3:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 12/11/24 11:53, Vlastimil Babka wrote:
> > On 12/10/24 03:39, Alexei Starovoitov wrote:
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> Similar to local_lock_irqsave() introduce local_trylock_irqsave().
> >> It uses spin_trylock in PREEMPT_RT and always succeeds when !RT.
> >
> > Hmm but is that correct to always succeed? If we're in an nmi, we might=
 be
> > preempting an existing local_(try)lock_irqsave() critical section becau=
se
> > disabling irqs doesn't stop NMI's, right?
>
> So unless I'm missing something, it would need to be a new kind of local
> lock to support this trylock operation on !RT?

Ohh. Correct. Forgot about nmi interrupting local_lock_irqsave region in !R=
T.

> Perhaps based on the same
> principle of a simple active/locked flag that I tried in my sheaves RFC? =
[1]
> There could be also the advantage that if all (potentially) irq contexts
> (not just nmi) used trylock, it would be sufficient to disable preeemptio=
n
> and not interrupts, which is cheaper.

I don't think it's the case.
pushf was slow on old x86.
According to https://www.agner.org/optimize/instruction_tables.pdf
it's 3 uops on skylake.
That could be faster than preempt_disable (incl %gs:addr)
which is 3-4 uops assuming cache hit.

> The RT variant could work as you proposed here, that was wrong in my RFC =
as
> you already pointed out when we discussed v1 of this series.
>
> [1]
> https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-5-ddc0bdc27e05=
@suse.cz/

I like your
+struct local_tryirq_lock
approach, but let's put it in local_lock.h ?
and it probably needs local_inc_return() instead of READ/WRITE_ONCE.
With irq and nmis it's racy.

In the meantime I think I will fix below:

> >> +#define __local_trylock_irqsave(lock, flags)                        \
> >> +    ({                                                      \
> >> +            local_irq_save(flags);                          \
> >> +            local_trylock_acquire(this_cpu_ptr(lock));      \
> >> +            1;                                              \
> >> +    })

as
#define __local_trylock_irqsave(lock, flags)                    \
        ({                                                      \
                local_irq_save(flags);                          \
                local_trylock_acquire(this_cpu_ptr(lock));      \
                !in_nmi();                                      \
        })

I think that's good enough for memcg patch 4 and
doesn't grow local_lock_t on !RT.

We can introduce

typedef struct {
        int count;
#ifdef CONFIG_DEBUG_LOCK_ALLOC
        struct lockdep_map      dep_map;
        struct task_struct      *owner;
#endif
} local_trylock_t;

and the whole set of local_trylock_lock, local_trylock_unlock,...
But that's quite a bit of code. Feels a bit overkill for memcg patch 4.
At this point it feels that adding 'int count' to existing local_lock_t
is cleaner.

