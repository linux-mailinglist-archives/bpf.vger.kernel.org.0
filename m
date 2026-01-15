Return-Path: <bpf+bounces-79162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714E0D29583
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 00:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9A3F3040282
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 23:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244533120D;
	Thu, 15 Jan 2026 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4Cescfp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3642326954
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521136; cv=pass; b=tq3K4tGlHlxIn3szH7u9K9XkHIhNSidFGRNXgwhLCPJ5TsOgBfeFV1QlbEoMI9fur6WWMZ3pZlxMsLUmVBh3ZTTRVasuaVe+lw0NW3zg81rA3UVchdHX7yHOqWSD3gjM9nqFNpYiN77irYTZT3uiTtbIYDDbV/YR1G+trEcH0+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521136; c=relaxed/simple;
	bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcJnh5mgkAwdJ9EVnN5mGVkjd+KHrln1YLbrk5kQ6Xd4u9wfWv1yCSEHpiy77zxMiHWUGEPvBaAkmyeC1hIKFd3HJ2RqI4clqcsZBGe91mCRGFX4Q4F4tVc3FXGGnl4wUOsjqLhvbyUJA85Wp/LKjKXrYgDLRxXWfoYJ+3qVgCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4Cescfp; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50299648ae9so91801cf.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 15:52:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768521134; cv=none;
        d=google.com; s=arc-20240605;
        b=Wwc2ukYwFwpotHaXbBHI6UTWUAD8Map7EPevmzIh18BYO8kflRdEc5wmz7ciMu9yOG
         xccX/1riUv0oM6Mbm8ZDpJ3OZCEuvnXpbNQgnZym514dCBnjFZeYaO8fhOvSEH6/XFro
         qTtlRRnIOaQE4RP9tJoLLc3eanVU5kZbRS8gElQrG8v6+GbofI31U8JQIYG7lFvvX9oh
         VFTgjtHnAKuyaddC7Br2wgXTayq4qLfDdBAQk4sbWRtE607xyW0PrLJwbHntTYDZQk61
         EviGoQWziNuvl5+1JhN+ZxKSF7C26OxlLxT1MyyDZ+nVDYB03vZUWQMDUJdi14FHdysG
         iGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
        fh=STtWtyUQawlzKFyAUf4WAUNmuEa8bY3AArrqDPB06qw=;
        b=GhMzcAy1gSxP147+hNZ5MsHJ8zAsxRkjyZGFv82hYonhkZtNluthiepXihKLJjiU8X
         y7Vt9VfjZpheacko+eQLjFRDfk+Bn2PxFyEbGajZr8McbVMWuRL4urEJ8sH4FdxPQMn4
         GqHNfGD6vo3F7/jHcAQY8pwpp3asqYWfEFOY+Pf9xsnJRAq3XseHs8IL18bP6NW+xaTj
         NPj2UO+kAViH7IAJwUb6CMI5JC1oc9GkFMwtQfHNI7xzdYvCnH9C8/asw8PnRgDrwBEc
         8EBf3qdeFuL0zdlc4zl23i0PNS6gY7Ub/I6pJAaXWvZYFX57OOfaBmSdD5ON94FbAhbJ
         gfgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768521134; x=1769125934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
        b=u4Cescfpn1OnVSiSBqa5nZKR9h1lcNfHd9brRMoX6LykbU79t/u6ZHYijnL8EdacAW
         KggfRA71jITgSZThXZKMuNJae4buD+CWmq5Jczne8rk/UxUJkTNpU7BBwNANHgY4nVva
         HVU0ur4wF02mbOC3Kyyi3JccpD1DcOZYa8usHmlIjVZzMXbVX1/JKbXNcf+1v4J0Gb0k
         28+ONiyejWnwjpxjqs1I5iL/+kcIHezH/2B6rIpTBdY+wnzSSRyn8dE6v084a2vdB5Pv
         jPZsoKY3Zd5Zmz/teZG3f20K/XQGeUsD6VlDjiqGEQ5VfWVfbqyKfljTkAX/9X/mNxxv
         X/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521134; x=1769125934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
        b=R8ajrezcnzajJLPI2gsGhbg7DPYm9g7KVvd+OPruSdNWUXz60pkBla2UUbZP5I37xt
         NVqQLwEoCJBbNVh5MN7CQEjXgMPqr2nnIMLEoS8+gp0NNCIW/BqvenOdQy/ilYSQuv/3
         PRhPlk77Z6mHmsUmX2y5FkIm7ElVYsKL+E+E3DRT3TyUUfV0h08S3PSTlKToqlPI2OTl
         XFgx0pSXNK6FQElzK7p7UeuY6fpZmldOBdEPVP54yyV1ZH1uJO6c1pB6pdGfuKYM6OMf
         lVJk48cVusl3pEtW76lpbOWyYN1CWQl+/KqD8YD/vIMvztCzTGEwGu+MxQWH01KH/HF0
         1zMA==
X-Forwarded-Encrypted: i=1; AJvYcCWRtbzTtm8F4lyqMkkKT2ZRyG9Qsl4K1EhmoNI2WBgS06+Tpr5W5DJuejlHAun+kZTx3iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLC7IX3mPKJhSexl1Sru5cfgEt58Kz9QeTqVGNv1abCX+X5arS
	8e9xgHhUNUtrGtlQR2aGFnuwBFUxVuCrJRl8CF3W80lIB0OHwyv1BcRY6lNyFNnYyyQ3IKefCoo
	W5qg2SyZFACR7HBysw7MCtmunmRvW+0ObW39dOrAR
X-Gm-Gg: AY/fxX67AWy0GZ113Yz296dwfKFXF14/Ah6L8h0lSbqcN3ql5l6dwc73h/CCeIZj7QX
	s1qJUnG6csT3OCZidDBX8kcYfzmU1E6bby23viEdOFvJsGEMVPJ7sYKqIFMf6K48G4K9uT1IS+C
	4qyrwiDUl9JgHDr3SCa43K++MLuhjfjIXJK2uOlLQMKQ++Bq89SiDE5fjuGcmHuczVhmXu8w8dm
	HGd4jbezFoN9y6+0ALpstjSUx/N3AfcTHf1/VV0C92m0KxMj1k95aMusocnPXE1LBsWGYt1Aa8c
	HU6YtlHz3VapTE/hpTV2p2ZiXckYcwiWDw==
X-Received: by 2002:a05:622a:58b:b0:4ff:a98b:7fd3 with SMTP id
 d75a77b69052e-502a22cfe86mr4096151cf.2.1768521133130; Thu, 15 Jan 2026
 15:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-1-98225cfb50cf@suse.cz> <aWWpE-7R1eBF458i@hyeyoo>
 <6e1f4acd-23f3-4a92-9212-65e11c9a7d1a@suse.cz> <aWY7K0SmNsW1O3mv@hyeyoo>
 <342a2a8f-43ee-4eff-a062-6d325faa8899@suse.cz> <aWd6f3jERlrB5yeF@hyeyoo> <3d05c227-5a3b-44c7-8b1b-e7ac4a003b55@suse.cz>
In-Reply-To: <3d05c227-5a3b-44c7-8b1b-e7ac4a003b55@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Jan 2026 23:52:01 +0000
X-Gm-Features: AZwV_QjyQPPUtH5tGDbHEFhedU3kKqiqu-2QyYB5WPZJAwFL9F8l2hS-k58cSQU
Message-ID: <CAJuCfpHCgyKTiPOZ_p76hTLRrZfQrkNh7XHJkEM0omWWCK2WQA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 01/20] mm/slab: add rcu_barrier() to kvfree_rcu_barrier_on_cache()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com, kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 1:02=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/14/26 12:14, Harry Yoo wrote:
> > For the record, an accurate analysis of the problem (as discussed
> > off-list):
> >
> > It turns out the object freed by sheaf_flush_unused() was in KASAN
> > percpu quarantine list (confirmed by dumping the list) by the time
> > __kmem_cache_shutdown() returns an error.
> >
> > Quarantined objects are supposed to be flushed by kasan_cache_shutdown(=
),
> > but things go wrong if the rcu callback (rcu_free_sheaf_nobarn()) is
> > processed after kasan_cache_shutdown() finishes.
> >
> > That's why rcu_barrier() in __kmem_cache_shutdown() didn't help,
> > because it's called after kasan_cache_shutdown().
> >
> > Calling rcu_barrier() in kvfree_rcu_barrier_on_cache() guarantees
> > that it'll be added to the quarantine list before kasan_cache_shutdown(=
)
> > is called. So it's a valid fix!
>
> Thanks a lot! Will incorporate to commit log.
> This being KASAN-only means further reducing the urgency.

Thanks for the detailed explanation!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

