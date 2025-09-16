Return-Path: <bpf+bounces-68548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CAFB5A32D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2443252020C
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544632E2E2;
	Tue, 16 Sep 2025 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX+fsfIF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6232F9DB4
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054430; cv=none; b=VkmfJdeInSluU1DqgB/G/K7bsEhtTpsRI58pmNhJWPe/wJqaKwqqiRDRpX8t5nssaNA09YhKUSfD5yrvOHh2eG+xwhhNjToo59yqs3iF6sgVAJV+TeoZPkBRlZOgOC7zkbeleiItP/y7xFEvA9TYFw18t3hb4/D12NboXf4VNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054430; c=relaxed/simple;
	bh=1Ix97aob12h2GgYL8EbRr5XWxpV8URBbytsJHtryCfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXEUP/32uQYcpt3ORavd/w2OVMFmPMHkBHT2vENOhPeAKbNMbNuT0jiDhhPPFBiNTVDDCxGxhlCqllcGCrSuKFoosqS5nU8DN8nq3OArBSL4SkkRPnsV/FM0J5ZzB9+bIdMnLuDAyhPwV7JCwwbk3/GWT7KjA9E0VS+UFzqKl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX+fsfIF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3dae49b1293so3298265f8f.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758054427; x=1758659227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ix97aob12h2GgYL8EbRr5XWxpV8URBbytsJHtryCfw=;
        b=aX+fsfIFPvtloa8XCpMHXv7Ob/JlSbVpMKEFVgzEiKx70+wkHF8lSn/B1cnraTMbNC
         x5Zht6fMRBKLNFOwpRgMDd/c8028jp5moHyQyVdlMM+Rkqu0L40jxHbjVh4QztK9S/yG
         pplR0FxYQdJ7/vJoBbNDPuhXEKLx+YUwOs2HATwc2qmwoJtPT5qnmMgPNlDW9MX8IY3+
         WqqcRp1n3h+EPQoztpPH/9SYKpgrYw33K19Xs6B07zYzDEjDei4YDEChZ29LY4ottmt8
         6fz5lNAAX34VORZVCRA5CiJMHPPZwOpwYZxU4BzyOE19q7+9I8/xalZqeNjJjx7Evydo
         fXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758054427; x=1758659227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ix97aob12h2GgYL8EbRr5XWxpV8URBbytsJHtryCfw=;
        b=VpNhoFRg2fmTVAUEwHwj9Hdb5nJ1fVEo4O/AVvQi0u93Bemq+FnakgGx3AUT5+g1nR
         7HikWIwo8Naoy4N0U1vB7eiDHQ+iPFTWXzt/Y1MwD4RZ+DFjHbdmpk/+nx2Ih8jRWAab
         7hxl64+Un4vCG26mhTcyxZAwYdXPLttlmju8ho7PSKmDGaNuo6aabPCZfPCkpJAz1m3j
         w1gFuQDcc5aKMOc+j2laH9b7ks6fryEP07lBXqhRyxkt1E0C2GLPzDFSEPMxxlmJKYGH
         F0msSj86JayUj/GxSRfVwWyBk7e344nICiodQwalJEongwgPLSa6C5rvduTQuilSgjEk
         8MBg==
X-Forwarded-Encrypted: i=1; AJvYcCVlHNulC+bGwviXYibkZ40SqeUkucZCKLhzWgOsI0amdIikY8xwPKJmkmoKOJN+PdnBtSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0UKbRg3mw+vQa+kJXJAzHO7zEDBJ+9pZ+SzMNZ/iDtnB55vhn
	LfIGaAEU0GNGSUCp8Ehx8y1Unk8PjxvGFJhkyPhi2E1h42MD+hDtLxygnXrhLs2q36lXNhZHROh
	YrliStAGTeJF7O8LxJ8IxqlnUJiwIOMRO5/dx
X-Gm-Gg: ASbGncsgMdL2LJsYsv+W3tSinS8bhkjMfsV09Fx3DnbeNpK9wa/HqZT57rLqKtbdfgF
	Wg+tEsyGccTOnlXlp6wrGkxTMMkm0VaKcFbQv7lCPqPDdF/MeRZz9LUqNjwpkIH7sA9j/N5rqTW
	jojdY+pEvAXvzfv2chHkXuKWowQuA85qKrm0na/ZnBzIyEbNjoXm/cIkC7lleISYfFyUQBLZk+W
	otPOKjZwvbGJgzn+xdC/w==
X-Google-Smtp-Source: AGHT+IGCFRax43r4+6U0AJyqG0me1YwkPNuoWeIBuUHrDGoeTl10iCWD7/ZxIHdhBvkM8deem3EiJqgW173CYYc3/jE=
X-Received: by 2002:a05:6000:26c5:b0:3e7:6197:9947 with SMTP id
 ffacd0b85a97d-3e765a2675fmr15823778f8f.53.1758054426758; Tue, 16 Sep 2025
 13:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
 <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz> <aMlZ8Au2MBikJgta@hyeyoo>
 <e7d1c20c-7164-4319-ac7e-9df0072a12ad@suse.cz> <CAADnVQLNm+0ZwX2MN_JK3ookGxpOGxEdwaaroQk+rGB401E8Jg@mail.gmail.com>
 <0beac436-1905-4542-aebe-92074aaea54f@suse.cz> <CAADnVQJbj3OqS9x6MOmnmHa=69ACVEKa=QX-KVAncyocjCn1AQ@mail.gmail.com>
 <c370486e-cb8f-4201-b70e-2bdddab9e642@suse.cz>
In-Reply-To: <c370486e-cb8f-4201-b70e-2bdddab9e642@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 13:26:53 -0700
X-Gm-Features: AS18NWB_6pHA1ySVG2GJLMXhfR1N9Z5Ppefr9YB0skR0SQES1Z1apMlYGB5i-gA
Message-ID: <CAADnVQL6xGz8=NTDs=3wPfaEqxUjfQE98h5Q2ex-iyRs4yemiw@mail.gmail.com>
Subject: Re: [PATCH slab] slab: Disallow kprobes in ___slab_alloc()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:06=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> >>
> >> Hm I see. I wrongly reasoned as if NOKPROBE_SYMBOL(___slab_alloc) cove=
rs the
> >> whole scope of ___slab_alloc() but that's not the case. Thanks for cle=
arin
> >> that up.
> >
> > hmm. NOKPROBE_SYMBOL(___slab_alloc) covers the whole function.
> > It disallows kprobes anywhere within the body,
> > but it doesn't make it 'notrace', so tracing the first nop5
> > is still ok.
>
> Yeah by "scope" I meant also whatever that function calls, i.e. the spinl=
ock
> operations you mentioned (local_lock_irqsave()). That's not part of the
> ___slab_alloc() body so you're right we have not eliminated it.

Ahh. Yes. All functions that ___slab_alloc() calls
are not affected and it's ok.
There are no calls in the middle freelist update.

> >>
> >> But with nmi that's variant of #1 of that comment.
> >>
> >> Like for ___slab_alloc() we need to prevent #2 with no nmi?
> >> example on !RT:
> >>
> >> kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf ->
> >> kfree_nolock() -> do_slab_free()
> >>
> >> in_nmi() || !USE_LOCKLESS_FAST_PATH()
> >> false || false, we proceed, no checking of local_lock_is_locked()
> >>
> >> if (USE_LOCKLESS_FAST_PATH()) { - true (!RT)
> >> -> __update_cpu_freelist_fast()
> >>
> >> Am I missing something?
> >
> > It's ok to call __update_cpu_freelist_fast(). It won't break anything.
> > Because only nmi can make this cpu to be in the middle of freelist upda=
te.
>
> You're right, freeing uses the "slowpath" (local_lock protected instead o=
f
> cmpxchg16b) c->freelist manipulation only on RT. So we can't preempt it w=
ith
> a kprobe on !RT because it doesn't exist there at all. The only one is in
> ___slab_alloc() and that's covered.

yep.

> I do really hope we'll get to the point where sheaves will be able to
> replace the other percpu slab caching completely... it should be much sim=
pler.

+1.
Since we're talking about long term plans...
would be really cool to have per-numa allocators.
Like per-cpu alloc, but per-numa. And corresponding this_numa_add()
that will use atomic_add underneath.
Regular atomic across all nodes are becoming quite slow
in modern cpus, while per-cpu counters are too expensive from memory pov.
per-numa could be such middle ground with fast enough operations
and good memory usage.

