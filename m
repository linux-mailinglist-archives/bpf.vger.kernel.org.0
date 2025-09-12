Return-Path: <bpf+bounces-68269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B2BB5585E
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181935C3A75
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E726158B;
	Fri, 12 Sep 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="InhDAFfv"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1638322256B
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712595; cv=none; b=ZLw1CLyeW+kAYsTdi/hacfD6bkyvbQ8/Xb3cjgy+F1ByBp+VteUn5CuYb7rTHzEG/Aiuxc9pYTL9YHpLKuWGObpCjDMTC3FMCSZoZ6gZU6PbDnFcn1j4Lrkhdygmy44D+5cQek/2q8QhHeY261I1WFcipU60YHtTwgLOb0LWutY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712595; c=relaxed/simple;
	bh=vycwI4Yl+XxF2bgz00N1Tdjk14dAEGZFq8C8HNdDr50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auxk9CdZmJ2/N5jVuPdj3Gp5QboXZarPeZb47NxTSpxaGDYUslD+HETd4LZyaoVUs5//Jjiv/7CY661M4m/WX+QL0BrpThCQodZB8NtID1E0ndRohV0og6MZYbXeoX8Ha7FwMahr2qVVrlhGmjA7cn8yu59FWSAASRW1UGuBmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=InhDAFfv; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 14:29:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757712591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRRg+naQxqNIqyjfph05OIHuyRCyHgm4Y++j4EuMPmw=;
	b=InhDAFfvQTGp/RNmVgG9Z50+TpVRMZ6febZsdz8N0RnpFLrzrqHinEtD6XVXmsxwrk1xNV
	01KA3ojSOmggoXkI3NCbsLOMVR9EP19lKTGmY5BQGFqbg/NMplL7vxJs3e5Intu7jON4Td
	dPGgQjbSZ3R/RGwHt1hCjs4GM1W2HjI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
Message-ID: <shfysi62hb5g7lo44mw4htwxdsdljcp3usu2wvsjpd2a57vvid@tuhj63dixxpn>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com>
 <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
 <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 12, 2025 at 02:24:26PM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 12, 2025 at 2:03 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Sep 12, 2025 at 12:27 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > >
> > > +Suren, Roman
> > >
> > > On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wrote:
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Since the combination of valid upper bits in slab->obj_exts with
> > > > OBJEXTS_ALLOC_FAIL bit can never happen,
> > > > use OBJEXTS_ALLOC_FAIL == (1ull << 0) as a magic sentinel
> > > > instead of (1ull << 2) to free up bit 2.
> > > >
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Are we low on bits that we need to do this or is this good to have
> > > optimization but not required?
> >
> > That's a good question. After this change MEMCG_DATA_OBJEXTS and
> > OBJEXTS_ALLOC_FAIL will have the same value and they are used with the
> > same field (page->memcg_data and slab->obj_exts are aliases). Even if
> > page_memcg_data_flags can never be used for slab pages I think
> > overlapping these bits is not a good idea and creates additional
> > risks. Unless there is a good reason to do this I would advise against
> > it.
> 
> Completely disagree. You both missed the long discussion
> during v4. The other alternative was to increase alignment
> and waste memory. Saving the bit is obviously cleaner.
> The next patch is using the saved bit.

I will check out that discussion and it would be good to summarize that
in the commit message.

