Return-Path: <bpf+bounces-67851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942AAB4A65E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 11:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39011188BE56
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E2D2797B8;
	Tue,  9 Sep 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/rCf4wE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF442773E4
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408422; cv=none; b=HC/XGs5Hq8VwMtt8Q4gWi6i52KtKb2lf3JVysoGiXqDzsuKBj/F7XGLHT8O0O+FoVw2ytyYa7vaw84v51RphNVedeU1qDvsLyc9KWScEC63eAUU5cekS3JR3tAjp6DShNwPyEXlvr1PWfbafeGXN7Ya9NRcKCoOfw9zS3bXE8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408422; c=relaxed/simple;
	bh=led0RI/AhTQU2o9DB0fw2gvyZNmiMookDXNF0TMBETk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2W5+KtTn74q1q5pMkW8zdAvFV5icByfV13qXoJJlmNsUYqtM4gNwFNUcHO5rlEf1LCTRUMei/QzfLMSdFmpaFHlp5qhyVr4KyN/p3nPdaxOezJIOAbK6nBJLwtXXn9ZiDBdQf2qfDjbN8LWRoz9xtj3ou4+mmNVzXRE98wm6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/rCf4wE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24b2d018f92so617075ad.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757408420; x=1758013220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZD5JHGWpdZZVrStAYH9mMx353X3wI2ffFHx8fyZ9Ems=;
        b=K/rCf4wEPpnoeiqpRS99haAEgbzU2DYLYlwHRdSL6F3jTwN1GYidAISeScBIwCrA2K
         hGCZx0t3COCq6aMraoFpEA54kEsuO7mPzUn68/hVvY0n803hEEJD8PNmbsewmrqDsaRw
         Zr11/bGAFuNf+I1BLkbEMtpE61cr4Tepyv+htJqUADCMudpK3dcFjDyR+oWgfiEr87lf
         UyeIsVZKfob50xRcwFTwTU7BlTjYheQC+jCEsGF+Fb0VapuSYKS53fyCch9bitSFY+ei
         Z2MTam7mMsOhh9EzKIMyYXk9itoqvq3DOaHsBa2CmwNpULphaGH5hgqggdoXYUSDbCPm
         HQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408420; x=1758013220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD5JHGWpdZZVrStAYH9mMx353X3wI2ffFHx8fyZ9Ems=;
        b=jNLxgd+jwjBoxsT0Jo19Ai0GQCCFpIvJH/Qf3siI1UtzaOw1D5VfZAdckDDT2LKWoU
         yl9HD3TU4T7EMpCdh1d7ArSgQ1LjQolNszoXpaET4XAFv9Jv8Re+28kZ0nLB4qpHaVlO
         Dsp4BHJff4CF67RltVShoKI8FtzL9nAKwGTTdA6BjcFe1ojUp3E6SN0xtlSkDz2zBFvF
         ChQB942sQLBm4QT95VVRqQ/aOizl9eIZdgkdEImlYM7JdaluUa3xGQCtcuMrFwztZM9g
         U/g4ziAhfveLvJjxzFtDoN7yHz/bCP8LEn/k9+CsZ1ku6ubqb/lr5SsvikyIUrfla1f6
         bqHA==
X-Forwarded-Encrypted: i=1; AJvYcCV1IEjHVryxVHzgqw3y5tgf7F+X8vtHYvqbtv35HG0M7URau8uZ+vmiQf7Zup1EhoH9h8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZyUenUJQ5Yu29Jv3yhkEdbAs9IGxyoXgqsECYqVfuiqCFlTWW
	9X/uY6hXrDUW/30BrOfeh05vTTGfIq0yJkM3e9rA0DZx7MWXg8Yo/mOTuYS49O5AkA==
X-Gm-Gg: ASbGncsrW6vcHFN4wzo8uEf9AXIr/bLimTd/ilBlD4mOIoBWwG3yJrZPLojOe+zEIkO
	OA2YjwZX5ZJnS4kpBEmCTtCbcNJdWWdRXpV3QinO9Q0+feIKnpqmB/gINoOB9H1hSERjLRlByTy
	Xsl4G9ITvhzxpEufut73atw7qINaEJGakZJczKLYY1jtpK/qqMIMeQCh3szzECfXlcqfMOG/cWx
	jge8Krke1+olDf9lXd7iKvL5mqU+4zjFEbTqjVeT6wW8qvBVHg4ssFwgfIvy8m6NM30RVDCcP2T
	hkWkTE0x/u3IfKr14Sf/j9KwG87BH4YGa9TCi5m/gdDYH8PESP679qloSbdL+zpqJV5uN0NTgsP
	H74Zvbzu9md+3dy2jaHnnbLxvGnDhB1QqBegSLnKo9SsPgoZ9mMlNv92pTVftDoJFHJrw+796vY
	Qusw==
X-Google-Smtp-Source: AGHT+IE46itzTexSI8Ctt31Rs3xNXXaQNiRX/4w+ST8ZDHOI9xNPl+N801SHqUJaPMpgqyoD4ORqcQ==
X-Received: by 2002:a17:902:ce83:b0:24c:7be9:85b9 with SMTP id d9443c01a7336-2511a6a5705mr11099925ad.14.1757408419746;
        Tue, 09 Sep 2025 02:00:19 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327ba547f05sm35037156a91.20.2025.09.09.02.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:00:19 -0700 (PDT)
Date: Tue, 9 Sep 2025 09:00:14 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Leon Hwang <leon.hwang@linux.dev>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
Message-ID: <aL_snlcI4zC4HtZw@google.com>
References: <20250908044025.77519-1-leon.hwang@linux.dev>
 <20250908044025.77519-2-leon.hwang@linux.dev>
 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
 <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com>
 <aL9bvqeEfDLBiv5U@google.com>
 <CAADnVQ+56_gvS328irDEuGoDGFH6iywKriACtsre7h5a7eiJbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+56_gvS328irDEuGoDGFH6iywKriACtsre7h5a7eiJbw@mail.gmail.com>

On Mon, Sep 08, 2025 at 03:51:00PM -0700, Alexei Starovoitov wrote:
> On Mon, Sep 8, 2025 at 3:42 PM Peilin Ye <yepeilin@google.com> wrote:
> > Just in case - actually there was a patch that does this:
> >
> > [2] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/
> >
> > It was then superseded by the patches you linked [1] above however,
> > since per discussion in [2], "use bpf_mem_alloc() to skip memcg
> > accounting because it can trigger hardlockups" is a workaround instead
> > of a proper fix.
> >
> > I wonder if this new issue on PREEMPT_RT would justify [2] over [1]?
> > IIUC, until kmalloc_nolock() becomes available:
> >
> > [1] (plus Leon's patch here) means no bpf_timer on PREEMPT_RT, but we
> > still have memcg accounting for non-PREEMPT_RT; [2] means no memcg
> > accounting.
> 
> I didn't comment on the above statement earlier, because
> I thought you meant "no memcg accounting _inline_",
> but reading above it sounds that you think that bpf_mem_alloc()
> doesn't do memcg accounting at all ?
> That's incorrect. bpf_mem_alloc() always uses memcg accounting

Ah, I see - kernel/bpf/memalloc.c:alloc_bulk() via irq_work.  Thanks for
the correction!

> , but the usage is nuanced. bpf_global_ma is counted towards root memcg,
> since it's created during boot. While hash map powered by bpf_mem_alloc
> is using memcg of the user that created that map.

- - -
IIUC, this "sleeping function called from invalid context" message on
PREEMPT_RT is because ___slab_alloc() does local_lock_irqsave(), with
IRQ disabled by __bpf_async_init():

        __bpf_spin_lock_irqsave(&async->lock);
        t = async->timer;
        if (t) {
                ret = -EBUSY;
                goto out;
        }

        /* allocate hrtimer via map_kmalloc to use memcg accounting */
        cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);

For my understanding, is/how is kmalloc_nolock() going to resolve this?
Patch [3] changes ___slab_alloc() to:

          /* must check again c->slab in case we got preempted and it changed */
 -        local_lock_irqsave(&s->cpu_slab->lock, flags);
 +        local_lock_cpu_slab(s, &flags);

But for PREEMPT_RT, local_lock_cpu_slab() still does
local_lock_irqsave(), and the comment says that we can't call it with
IRQ disabled:

 +         * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
 +         * disabled context. The lock will always be acquired and if needed it
 +         * block and sleep until the lock is available.

So it seems that we'll still have this "sleeping function called from
invalid context" issue for PREEMPT_RT even if we make __bpf_async_init()
use bpf_mem_alloc() (when the latter uses kmalloc_nolock())?

[3]
[PATCH v3 5/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
https://lore.kernel.org/all/20250716022950.69330-6-alexei.starovoitov@gmail.com/

Thanks,
Peilin Ye


