Return-Path: <bpf+bounces-46612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1439EC9F7
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 11:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07501884ACF
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822CB1DF755;
	Wed, 11 Dec 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QxY8Q2DL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15391A8406
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911743; cv=none; b=I69Tl+gVJUFKi1xHldDNtyAyFL+QQBuWJtLOtKbdeUxbG/TCsC/TgEmgIKvQ5v4qbqvbFdrr+/bIDC57qJK9DPT6f7qmpAyKBSkhXJKv3ND6NOH5L9qIRD0suEaa2ZM+F/GnomstwMeuHn7W8t+KKJcjzDRSh+5UonixtxBoLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911743; c=relaxed/simple;
	bh=+WUnBoLFbfPmJzQE4xZ0Y4YXwfOIR+bF9MDtJTTRhK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6fXyjtUl6tX90BUZoFQQJFR1e1RYS+OorT9Glgl5Gb2hc0rzL2RRDWxlhbn3icRmbCP2eR+El7oLJKYBJ00koR2tQLyHTA/Bo+CB7G+M8tjyXIzTygfxZXvpOnoyqkf4qwkczrKm80XZZ8SoITg5PKKBYCkRTDdDmTxffrj/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QxY8Q2DL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so286227f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 02:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733911739; x=1734516539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQTIkbXiSjL4ZTjxx7KFR/cd8ulUeA/BaZmO4ST/YMs=;
        b=QxY8Q2DLq7WBOsaD19wkrtSZ5CKt1kCfZ+6CQsrNS6N9yz/fqc7swJUxVBEwklaTMN
         cguLH035zseODvynG4NytGbbmrb4sZ7bOe4xIVXa32KAvFcbtjiBO4nnoO6f5AME5Ev/
         fskjIKTz2OeZnPEfGmjwR4DMNGfu61Bp9/S/ZIIJiu3CpzqVmHd2dVAbetyn7ZCTThbc
         4UkS5O5SEoE9aUl5Y1xz17n3D8h6aIhAL7FbO7ldRlAGz3q8Vfp//BCAJSeZcVoLCupJ
         Ef9XX+5yj0GNKHiHg+1IxLA+5kiyH9nAKxirg3/FIkYKFhAmrE4MjSsUEA6CTwDGkqaB
         J+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911739; x=1734516539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQTIkbXiSjL4ZTjxx7KFR/cd8ulUeA/BaZmO4ST/YMs=;
        b=j4xkM9smg3p+6ma7JYDpZmUKDTst17y2/zUNwXM2k8Keg7CQS50GY15eGUTwP51BIR
         fhfmcz2PUXXsOldrcwKG6cJyPiiz6ye+5ucQRfPvgxy1WMuQKQ01zq1jIKaktifHinxY
         m91w8TkdAAuhe4is2xfpFSPTMLiTdZPkw+Y+HHK3ep9QOI4VqiFLovq7C576PBdLbwTg
         Nko1/hHcdDg2Y8NY16DpqNkSEJCeKr6k/dBOEai3SSp1wHAIJP/G7sNIVI682FlNUB4x
         ppNWe5gC7mZobXqHLCTAz5SAhR0RjUMYsOHxbAeUHQbIIQxTD5JTKEvbd0vUBamVxXEe
         rCXA==
X-Forwarded-Encrypted: i=1; AJvYcCUYhgU6b4/m4U0nEMlY8hF9fXkDMik7wtpDhb6VTZQsvh5l3M/sXJa/W8RVh9HjAaDbH5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoMT2gKtGXcN8NjGEJNTmEBDPr3aAM4QpLkCZThdCLH1ikwZ8V
	TzmUT0KkSatvCUHT+ZeE+iupGA9mSSlOWO6V3ZUwjF5Mn4vRZ3JnULRNOlZASbo=
X-Gm-Gg: ASbGncuCbIK5DWTPYua6kg4ou/kd6e3dbxYliyuEmtUuHoRzncjaYRMO5KVRLYyDEUl
	bwbWoV+jyoLbPhHd7zFDUD1kM7NIE5vDtaV/sCSRcpz+KEJxiM6kHqQ0uLvkeALT4/Nu9Jy0X8z
	OFYdjKkUM9/mSFR5vhKq+8RtInB7pCjAmPNQiGM9bcBmxlwY3DH0KMTqVhryscVpTW7JX+EnopU
	iAbASzBmqgkwC3/SSOv/LzekR7g1UPVSqrJoxmTBkuNF6/tWgSdRx/oxYkRBH0K3FI=
X-Google-Smtp-Source: AGHT+IHj9KuyCI3jM8C2B2pywNKTz2+PID1sNOAsuKjh17FO/LgGrHovdODyf4DWcBc8jd7QHwU0kg==
X-Received: by 2002:a5d:64c3:0:b0:386:42b1:d7e4 with SMTP id ffacd0b85a97d-3864dedffa5mr1404642f8f.19.1733911738817;
        Wed, 11 Dec 2024 02:08:58 -0800 (PST)
Received: from localhost (109-81-86-131.rct.o2.cz. [109.81.86.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4f4dsm914438f8f.31.2024.12.11.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:08:58 -0800 (PST)
Date: Wed, 11 Dec 2024 11:08:57 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de,
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
	tglx@linutronix.de, tj@kernel.org, linux-mm@kvack.org,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <Z1lkuflVkeEoKYXe@tiehlicka>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka>
 <d7hy4vsnssi3melcb2jabdpyiuqsub5rq7fkn7u2ty5l3p27p3@r5xiszmmzquq>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7hy4vsnssi3melcb2jabdpyiuqsub5rq7fkn7u2ty5l3p27p3@r5xiszmmzquq>

On Tue 10-12-24 12:25:04, Shakeel Butt wrote:
> On Tue, Dec 10, 2024 at 10:05:22AM +0100, Michal Hocko wrote:
> > On Tue 10-12-24 05:31:30, Matthew Wilcox wrote:
> > > On Mon, Dec 09, 2024 at 06:39:31PM -0800, Alexei Starovoitov wrote:
> > > > +	if (preemptible() && !rcu_preempt_depth())
> > > > +		return alloc_pages_node_noprof(nid,
> > > > +					       GFP_NOWAIT | __GFP_ZERO,
> > > > +					       order);
> > > > +	return alloc_pages_node_noprof(nid,
> > > > +				       __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO,
> > > > +				       order);
> > > 
> > > [...]
> > > 
> > > > @@ -4009,7 +4018,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
> > > >  	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
> > > >  	 */
> > > >  	alloc_flags |= (__force int)
> > > > -		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> > > > +		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TRYLOCK));
> > > 
> > > It's not quite clear to me that we need __GFP_TRYLOCK to implement this.
> > > I was originally wondering if this wasn't a memalloc_nolock_save() /
> > > memalloc_nolock_restore() situation (akin to memalloc_nofs_save/restore),
> > > but I wonder if we can simply do:
> > > 
> > > 	if (!preemptible() || rcu_preempt_depth())
> > > 		alloc_flags |= ALLOC_TRYLOCK;
> > 
> > preemptible is unusable without CONFIG_PREEMPT_COUNT but I do agree that
> > __GFP_TRYLOCK is not really a preferred way to go forward. For 3
> > reasons. 
> > 
> > First I do not really like the name as it tells what it does rather than
> > how it should be used. This is a general pattern of many gfp flags
> > unfotrunatelly and historically it has turned out error prone. If a gfp
> > flag is really needed then something like __GFP_ANY_CONTEXT should be
> > used.  If the current implementation requires to use try_lock for
> > zone->lock or other changes is not an implementation detail but the user
> > should have a clear understanding that allocation is allowed from any
> > context (NMI, IRQ or otherwise atomic contexts).
> > 
> > Is there any reason why GFP_ATOMIC cannot be extended to support new
> 
> GFP_ATOMIC has access to memory reserves. I see GFP_NOWAIT a better fit
> and if someone wants access to the reserve they can use __GFP_HIGH with
> GFP_NOWAIT.

Right. The problem with GFP_NOWAIT is that it is very often used as an
opportunistic allocation attempt before a more costly fallback. Failing
those just because of the zone lock (or other internal locks) contention
seems too aggressive.

> > Third, do we even want such a strong guarantee in the generic page
> > allocator path and make it even more complex and harder to maintain?
> 
> I think the alternative would be higher maintenance cost i.e. everyone
> creating their own layer/solution/caching over page allocator which I
> think we agree we want to avoid (Vlastimil's LSFMM talk).

Yes, I do agree that we do not want to grow special case allocators. I
was merely interested in an option to reuse existing bulk allocator for
this new purpose.
-- 
Michal Hocko
SUSE Labs

