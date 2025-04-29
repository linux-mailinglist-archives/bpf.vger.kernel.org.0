Return-Path: <bpf+bounces-56934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5024AA0A62
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A1F188BD9D
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5A2D323E;
	Tue, 29 Apr 2025 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cSPKGl9X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82D270ED5
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926938; cv=none; b=QztAmUJXDa1mCfU9ToJ1JStJhnSGUqEf2eVAJ7giZVv/jzFuK2cth0oslDT8MhGqapgaTSb1tBDIgiY1j8+IzqZXyQeqMCyt1Dc0KYSlkDFbd1TgnysxZxYFbl1aHqxwJhyKcfR3+qmbN7oHZyGh180RoRylBOA76WdW7ZVAS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926938; c=relaxed/simple;
	bh=1pXLPMhmoxjMRNxn/3jRxQkvfWaqkkEBCKjj4zAnD8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/ZeFawkLJ7Szd1JT5ot6USGvKgmEUmcs1y+KjW4kjThiPr8E4u3xJWfi2PFVy4pJveOcodeN0RqY0+H9E6DROPgirx+Zb2VSzAl+bSCRK5+NSropoT84a4XogGxrKPr9TrodCtCflbgEl79u85ZgKlqv35mb844bbNHWmd/dOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cSPKGl9X; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso1275018266b.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745926933; x=1746531733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ey+I5jL6iIXatVmqxM65zXGZtsNFeT7DcoIALExv/ys=;
        b=cSPKGl9XHpqjmUDOPZXbht/1rfTVbVLSAflZyBzOeLfZ6ZAmr6I8CbfB4ENlY+d5iT
         QD1m6tZF+RQ8OoVOqUrcZhtiwAnfz34LMF3yubFF5y05hi75luzKlCyqyXWyqj+rubuT
         ss1kKdFRhXY7VkhBuv0vMX2+RAW7JBtIqqLGJ9LZfLSs7wSYIrIGqG6r28moHUf7AOxh
         zxkbykN1vhuL4QL4iv0Ig/NEuMnlP93RvIlIG5G54ecgYSYXpvpH6a8AjMDoYeXkVpQo
         EJMsz0tEGyrOrw745uas+RtL/SOOvRrdl49BHyE4R1pXFlgw4TmfO0v0KHSYQmJTPLnh
         xWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745926933; x=1746531733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey+I5jL6iIXatVmqxM65zXGZtsNFeT7DcoIALExv/ys=;
        b=JArFA9knHRmhsrLKGjESPXzZ94PwHkn4m1q8FkGEN26/UXGyPxxYBUd2Wj546tGJh0
         PorMN564xySBlNsITirnDkUa/GKbsTVbwI1uFu+rHn1f3z9aNGe3sV6NALxzoAQS9Nzv
         t1HFiO4iNCFXXMvQulmffJ5Pw9R0PIu3oIdDUV/XFhlpkUO2ZVU9BEqphW1BxOCBoZ7d
         AxaK6k9cGjnlxqA2y5c/ya7UZh5z8J5bxLB8NlDuYSYhZQs7XcN74FxC9EiMoTYjrvmt
         KJrJ1+q407VqEZbJOPG6ouODE0LgwNyO15eQd1xjQ3ww7P92XxM/VmwyiQaRI7fm7kgq
         foHw==
X-Forwarded-Encrypted: i=1; AJvYcCXhOXkh50FpchKP0slBh5bdW3TXvBnGZVuHBWiX2vB26CSVrGtt6zhHWL9m0Sf/Q/zP1vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLOXoKBdfez4vicTGKDj4quT7bJ+F91Vmg14AXJ6shcrxATROX
	NtMYU5CL9rTHG5zxffqZ3ibMS3pRKhDPiN6EVS81IFeTD4QxN8yZQIk2ZGD26qw=
X-Gm-Gg: ASbGncuNWYGXSpLkg/EeVqLQ4x+IcGM6tQ0saHLYd24nI+MDLvHiTP79dyPCDyaiFvg
	BRuwCYCwQ1cueLKPtd35AW3Bd/rF2jqLN+ihB+qJ/kq0H9HKcJ5j83Wfgs6URyfosGRoGHvO9lv
	INoI2xmN66dn9TcT64Id62NqOBJuyThz8VJRre6UscMvtSl/DqF/n2J0W8Rr2FbHI9RpTw+xQR6
	h5sOSenk6h/adNCV34OZRVV4ejuaFI5NP9OK8/h2jyA2mkQtZd/hlRuBBUyzytgsjHdD0DoRziG
	4oYDQaTTK9RbN2PIs4yaoDGCfdPs2lzQ2WhFffoitVT5VSBo1OzR/w==
X-Google-Smtp-Source: AGHT+IH7dcicAcnmj5NaE95QUGR24eCcfOm63TRGYwTmK3j5rlAl8p+nDrnlZU2xFwsK27po9Y9CvQ==
X-Received: by 2002:a17:907:60d0:b0:acb:63a4:e8e5 with SMTP id a640c23a62f3a-acec4ccfc22mr315665666b.6.1745926932884;
        Tue, 29 Apr 2025 04:42:12 -0700 (PDT)
Received: from localhost (109-81-85-148.rct.o2.cz. [109.81.85.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ace6ed6affesm765813266b.130.2025.04.29.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 04:42:12 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:42:11 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
Message-ID: <aBC7E487qDSDTdBH@tiehlicka>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>

On Mon 28-04-25 03:36:05, Roman Gushchin wrote:
> This patchset adds an ability to customize the out of memory
> handling using bpf.
> 
> It focuses on two parts:
> 1) OOM handling policy,
> 2) PSI-based OOM invocation.
> 
> The idea to use bpf for customizing the OOM handling is not new, but
> unlike the previous proposal [1], which augmented the existing task
> ranking-based policy, this one tries to be as generic as possible and
> leverage the full power of the modern bpf.
> 
> It provides a generic hook which is called before the existing OOM
> killer code and allows implementing any policy, e.g.  picking a victim
> task or memory cgroup or potentially even releasing memory in other
> ways, e.g. deleting tmpfs files (the last one might require some
> additional but relatively simple changes).

Makes sense to me. I still have a slight concern though. We have 3
different oom handlers smashed into a single one with special casing
involved. This is manageable (although not great) for the in kernel
code but I am wondering whether we should do better for BPF based OOM
implementations. Would it make sense to have different callbacks for
cpuset, memcg and global oom killer handlers?

I can see you have already added some helper functions to deal with
memcgs but I do not see anything to iterate processes or find a process to
kill etc. Is that functionality generally available (sorry I am not
really familiar with BPF all that much so please bear with me)?

I like the way how you naturalely hooked into existing OOM primitives
like oom_kill_process but I do not see tsk_is_oom_victim exposed. Are
you waiting for a first user that needs to implement oom victim
synchronization or do you plan to integrate that into tasks iterators?
I am mostly asking because it is exactly these kind of details that
make the current in kernel oom handler quite complex and it would be
great if custom ones do not have to reproduce that complexity and only
focus on the high level policy.

> The second part is related to the fundamental question on when to
> declare the OOM event. It's a trade-off between the risk of
> unnecessary OOM kills and associated work losses and the risk of
> infinite trashing and effective soft lockups.  In the last few years
> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> systemd-OOMd [4]). The common idea was to use userspace daemons to
> implement custom OOM logic as well as rely on PSI monitoring to avoid
> stalls.

This makes sense to me as well. I have to admit I am not fully familiar
with PSI integration into sched code but from what I can see the
evaluation is done on regular bases from the worker context kicked off
from the scheduler code. There shouldn't be any locking constrains which
is good. Is there any risk if the oom handler took too long though?

Also an important question. I can see selftests which are using the
infrastructure. But have you tried to implement a real OOM handler with
this proposed infrastructure?

> [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
> [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
> [3]: https://github.com/facebookincubator/oomd
> [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
> 
> ----
> 
> This is an RFC version, which is not intended to be merged in the current form.
> Open questions/TODOs:
> 1) Program type/attachment type for the bpf_handle_out_of_memory() hook.
>    It has to be able to return a value, to be sleepable (to use cgroup iterators)
>    and to have trusted arguments to pass oom_control down to bpf_oom_kill_process().
>    Current patchset has a workaround (patch "bpf: treat fmodret tracing program's
>    arguments as trusted"), which is not safe. One option is to fake acquire/release
>    semantics for the oom_control pointer. Other option is to introduce a completely
>    new attachment or program type, similar to lsm hooks.
> 2) Currently lockdep complaints about a potential circular dependency because
>    sleepable bpf_handle_out_of_memory() hook calls might_fault() under oom_lock.
>    One way to fix it is to make it non-sleepable, but then it will require some
>    additional work to allow it using cgroup iterators. It's intervened with 1).

I cannot see this in the code. Could you be more specific please? Where
is this might_fault coming from? Is this BPF constrain?

> 3) What kind of hierarchical features are required? Do we want to nest oom policies?
>    Do we want to attach oom policies to cgroups? I think it's too complicated,
>    but if we want a full hierarchical support, it might be required.
>    Patch "mm: introduce bpf_get_root_mem_cgroup() bpf kfunc" exposes the true root
>    memcg, which is potentially outside of the ns of the loading process. Does
>    it require some additional capabilities checks? Should it be removed?

Yes, let's start simple and see where we get from there.

> 4) Documentation is lacking and will be added in the next version.

+1

Thanks!
-- 
Michal Hocko
SUSE Labs

