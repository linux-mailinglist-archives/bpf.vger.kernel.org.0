Return-Path: <bpf+bounces-46682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DDE9EDD7C
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 03:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864EA16545F
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7883F9D2;
	Thu, 12 Dec 2024 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLSBq7vM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B47FBA2
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969710; cv=none; b=h3g7zJeKHpMypE5eQwADR2i45dqtrQfHegog8Sh7T1p065li7MZwfEAKldSE46zpRacbI+JIrBNXokiFbmyDUh1tbhlisCdh0lmrMoLfQCegqH81HsCfcxApd/Ygy1lMN10uBDz5RFX0XXvD1jQ0zQBNfGdOlQDISNWHYOu7Efo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969710; c=relaxed/simple;
	bh=73Wvnxdsn5pQr8crOlrIk09pP4brXsnvzdO5qYCU+Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1PBp0taVzS+L5aTy85cszFa8bvdtq1uQcfY1XHUucZR9LmL1uI8W8EbeClZ6CStGseHhAv+cC6tONEMypTqE9XLf4sQTUaUJ2XO0hbF+4pTHLFMHe+y4TnfohCyfP00HTrSLRrfWwBR6NHQ0+iz2tRdJjwzuemGr2nhD/WCvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLSBq7vM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385de59c1a0so23619f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 18:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733969707; x=1734574507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73Wvnxdsn5pQr8crOlrIk09pP4brXsnvzdO5qYCU+Zg=;
        b=DLSBq7vMHI/jn7hqQFeop6f/8/5scY4uUD77VBitYLekY36IaXJSAPTDI9Sv4DwQNY
         78dRZbPLYH9M5fXbzEEEot6V9jP3Rnlo1QbJQGDeXbHQMTH+Lv9vztSD8l0SSv2QUPJx
         V2yb7cKO93CSk6g2XzO7LUTDyT+4FqtOQZnPsxFC/IdRCQJzdlteqQwVSVQqYDCmVGqE
         x0U3vIVBtzywfSPewFRevIIkxtb98IEjzCi+MsM/Yk461wcsykNYxdwO0ja9Age+yb3m
         O0W1Or/2+Za39oMIcQlYpUNM8awCnAIpxdtnKYbyvCXPfKZ5f3lJq8CqCi4q4m18ugRY
         uW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733969707; x=1734574507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73Wvnxdsn5pQr8crOlrIk09pP4brXsnvzdO5qYCU+Zg=;
        b=WS+dBNcIm/FvWTV8VyfusvMeYRG6RNEPpizQ5GcaFrz5c4WVFxjzNmdJdET5rK3bJC
         K5rag/I0n4J18vZdFFSoRTepbqiwbxVh96wQ4Fqqua3yphgMazU9qT2qJzQQXRwHGBb5
         YSKOK31fDqQo01rMnZfdDKfdJPoNT8hzsD5gHhF15HTFaphtkFzVFMkeP5B1DKNCigvv
         BG2vnzPTOm/5bXW1ok46PY9+R686QTcqTNOWPsJzb8CPyokNmrKEbNbQ73DiYpIhkc+g
         giujmCGBWy5zoGcJgVgwO7YXBl8Gnc3rBHjStGes2TQ8rR60t+atRVWrRQReFk2EKLth
         li7g==
X-Forwarded-Encrypted: i=1; AJvYcCXXtNuaZNi5unHLLk+quTw9zqwNu77XqQx2jTgYLX9Aul65ShvwoMQj0XVPnvALmGGdvLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9RbwABfVUwgq5Yi/KJC8qtQmTvTBdJdSFXHNQViBEECb7kjb
	sMjd78KBMb3fpnNmwexJvhIT7Cttc5WntQZUxVbrrvjaFEC6s2w2cMSg5Ec9keu+iTo06Vv4w8u
	LwkzrFXlCp3ks218wysMjVKcyjg0=
X-Gm-Gg: ASbGncu1TPkqhKxksO/k14GUQLCHErJpgMBhHmjioqTlxIHjJ0OyjOokPibWoEirl+v
	2eUCOtnSdmSiyk9LCySCpVVrCQVzPzuP3TQAd4VB/oTEhhtjv4ugOuA==
X-Google-Smtp-Source: AGHT+IE4aLJpIwRr6IGFK1SO8me5JgCXb9equHXSSf1lbwrM5rhP3/h2pQTGziNVpb8TIkioPPAOChRZ6VR4GQTEn/U=
X-Received: by 2002:a05:6000:178e:b0:382:3754:38fa with SMTP id
 ffacd0b85a97d-387877dc519mr1123597f8f.51.1733969706604; Wed, 11 Dec 2024
 18:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com> <20241210090136.DGfYLmeo@linutronix.de>
 <CAADnVQK_oFD9+HbcEgqy0+JMygje8fB9qdhkJ5uoofQntZoywg@mail.gmail.com> <a06c6e51-d242-477b-9f77-d7bad24c299b@suse.cz>
In-Reply-To: <a06c6e51-d242-477b-9f77-d7bad24c299b@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Dec 2024 18:14:55 -0800
Message-ID: <CAADnVQKUJcv-YKBnwa_bW-GxoBWGZaZVVy5m1mVHehWN83E6kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 12/10/24 22:53, Alexei Starovoitov wrote:
> > On Tue, Dec 10, 2024 at 1:01=E2=80=AFAM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> >>
> >> On 2024-12-09 18:39:31 [-0800], Alexei Starovoitov wrote:
> >> > From: Alexei Starovoitov <ast@kernel.org>
> >> >
> >> > Tracing BPF programs execute from tracepoints and kprobes where runn=
ing
> >> > context is unknown, but they need to request additional memory.
> >> > The prior workarounds were using pre-allocated memory and BPF specif=
ic
> >> > freelists to satisfy such allocation requests. Instead, introduce
> >> > __GFP_TRYLOCK flag that makes page allocator accessible from any con=
text.
> >> > It relies on percpu free list of pages that rmqueue_pcplist() should=
 be
> >> > able to pop the page from. If it fails (due to IRQ re-entrancy or li=
st
> >> > being empty) then try_alloc_pages() attempts to spin_trylock zone->l=
ock
> >> > and refill percpu freelist as normal.
> >> > BPF program may execute with IRQs disabled and zone->lock is sleepin=
g in RT,
> >> > so trylock is the only option.
> >>
> >> The __GFP_TRYLOCK flag looks reasonable given the challenges for BPF
> >> where it is not known how much memory will be needed and what the
> >> calling context is.
> >
> > Exactly.
> >
> >> I hope it does not spread across the kernel where
> >> people do ATOMIC in preempt/ IRQ-off on PREEMPT_RT and then once they
> >> learn that this does not work, add this flag to the mix to make it wor=
k
> >> without spending some time on reworking it.
> >
> > We can call it __GFP_BPF to discourage any other usage,
> > but that seems like an odd "solution" to code review problem.
>
> Could we perhaps not expose the flag to public headers at all, and keep i=
t
> only as an internal detail of try_alloc_pages_noprof()?

public headers?
To pass additional bit via gfp flags into alloc_pages
gfp_types.h has to be touched.

If you mean moving try_alloc_pages() into mm/page_alloc.c and
adding another argument to __alloc_pages_noprof then it's not pretty.
It has 'gfp_t gfp' argument. It should to be used to pass the intent.

We don't have to add GFP_TRYLOCK at all if we go with
memalloc_nolock_save() approach.
So I started looking at it,
but immediately hit trouble with bits.
There are 5 bits left in PF_ and 3 already used for mm needs.
That doesn't look sustainable long term.
How about we alias nolock concept with PF_MEMALLOC_PIN ?

As far as I could trace PF_MEMALLOC_PIN clears GFP_MOVABLE and nothing else=
.

The same bit plus lack of __GFP_KSWAPD_RECLAIM in gfp flags
would mean nolock mode in alloc_pages,
while PF_MEMALLOC_PIN alone would mean nolock in free_pages
and deeper inside memcg paths and such.

thoughts? too hacky?

