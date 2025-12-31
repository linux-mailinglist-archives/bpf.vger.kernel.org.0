Return-Path: <bpf+bounces-77575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5DBCEB761
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 08:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76A3E3028F42
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B486310768;
	Wed, 31 Dec 2025 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jB+qgm7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5F23ABBF
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767166927; cv=none; b=VuMIM52oX/5xYG1C/LvvYyjlhykFNN8qFuHbl77ZPXP3+pSc1SPIivNleGR2ydk8fJ1sE6/CBCQcD00L9XS+JF2Ug03qroTGSn0mD9kpcBFWFGJEo9/F98M+BY8depMgjXxASjx1ib9IiDtJ9IKRuY1xTUHyfBPssOSzw31xK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767166927; c=relaxed/simple;
	bh=GvswzSQgWtrqhQcg4WlQY7/TDalX55vAXZ5y0FYd8hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY+9yLk3+nin2nZgMYZWgFahRLCKoudE7prI+7vf31fJYpDd2tyBmo3vvLJN6/zVG9T+V4wBvv/AfbfdJ+LAHlzI7nCJHH+L6MKcaYso4hWY3jxLHNKvoOu2hv8UBqR/bCfyswTkexFm/PIMil43lPBhSClX7cQq3yCzZZIw6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0jB+qgm7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so13138643a12.1
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 23:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767166923; x=1767771723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBxwhR+DOUWySSn1nkmmHXTpgGimoEMqTlfeKUVI3Ic=;
        b=0jB+qgm7yJzpI0aa0dNQMBTVMPxzm3STBr0+ut3jJAG5VDIKBH8JpiRlOPCNUOJUio
         4k1h8AlL9qeBVl6JcJ6fV3DESe+ZuX8kGtREbkONlYQbgJukEs0Qs6LqYBJrTUXcL1qO
         35CZy1n72WbFLN2GVF+UGhYx/TOqGZw7QIez+G02/a/UAmbt9BOHwv7jyjM72Y4aBoVs
         CSpd7vRggjS0E9oIlbC45MC/QpGcu3CbEVXGo192bZkvwxsRfXkFkWbuLG60Ff9cSEOT
         KHIt5G1PQyNqLQQrb93Y9HGilqpN9oQE42AgVDlvHRqsSb48ji5/ReNp7ZK6bqOayW7Q
         LMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767166923; x=1767771723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBxwhR+DOUWySSn1nkmmHXTpgGimoEMqTlfeKUVI3Ic=;
        b=CHcoRxDhbaJqrbaOCmj46UWGJ/JWa/DMRTTtptwkxlRB6JcGBFUSnVQ9NjzKLiMnf5
         bjvJqb6sq7WD6crQSgmwgY0m1iLm8zPsOd5ECggEfaWy1mo33BCsr1EkHsGuoZed6pWd
         3kiuecqbDI6ybzL3xL1CpNGTRHNRF9fmlh6h5l9Yttn7MxY8ev9N5qOHPtWRxzf+oqDt
         LsqXbeAenecRYcmxiz0xNEgpHXQ+C8vqNkqTH/6JR1pb3SseRRbyQ/77RmtRlJj8pClW
         sT3fHCb8U7Jef9NklBbNjzhE3sE39LLYW1FaHZ5dofsAr0gO7yAZ6fOJzfYZuEtBCQQt
         7T4g==
X-Gm-Message-State: AOJu0YxAx0BYyUumsKM1vMbsUWhi/dw7ozRv7trmWyT+TVSDs4vLPeHF
	IkFbr2M0Dt9UaGBTuhwWDaSk1fWqOckB46COCUE7rlSB9yeMbZBjcBsd0G70lq6sWE7uDLnXITi
	E+NILJQ==
X-Gm-Gg: AY/fxX68jEtIQ11fxcx+NPPsVkGQO6L1LvffIjAmbjEFxNFq51LhpxMhiC7OHf+Mjsj
	6jPeam7ibd6rHb/INFsDUKw4nM67Udv8EKsIya+axsPlFJcF+yb+RaNFvq3ZrOKo7v7ES6EHxkf
	tcL2fLXvYNSXt/3yM+rV3YRZtxaMmE7iDUguZHeQVqQxCJDlx/1JqgmrEi4mdofjU3TnuGmtKcP
	5JnSd74n5Z/CtvV+bCzWxCtOwRjuy8bFSBJ3ogA2bwErATlDr/9vl3QUfjvGL0254Yc9s5/g9HZ
	UehlnWsfHLmp0UsIzJD7uNESiYTm5+5PUh31bXrPKFiCZb1ZsUXIKKcyh1tvgJHfq9pyTPJODCb
	yKmoA0pK2o8YwpKJDU3V1ljXSnQAZqMSHKhh2xz7Fo+Fwn2re4fYZo1iUdM+5F25n4736rO71cS
	tcBQjEaj+bNdxC8TVqfjmfAEl7yK8lIU4LGEuacino0UnX15oIYSWF6A==
X-Google-Smtp-Source: AGHT+IG1aRB+d3WsL8zwpg57El7FgfpDZaQb4jebLM9i908vaeSLRjskbvtS5lkEflNe6+T45D2gZg==
X-Received: by 2002:a05:6402:5188:b0:64b:83cb:d93e with SMTP id 4fb4d7f45d1cf-64b8eb6194bmr32320732a12.20.1767166922985;
        Tue, 30 Dec 2025 23:42:02 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9ef904bcsm36693514a12.22.2025.12.30.23.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 23:42:01 -0800 (PST)
Date: Wed, 31 Dec 2025 07:41:58 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	JP Kobryn <inwardvessel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v4 3/6] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
Message-ID: <aVTTxjwgNgWMF-9Q@google.com>
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
 <20251223044156.208250-4-roman.gushchin@linux.dev>
 <aVQ1zvBE9csQYffT@google.com>
 <7ia4ms2zwuqb.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ia4ms2zwuqb.fsf@castle.c.googlers.com>

On Tue, Dec 30, 2025 at 09:00:28PM +0000, Roman Gushchin wrote:
> Matt Bobrowski <mattbobrowski@google.com> writes:
> 
> > On Mon, Dec 22, 2025 at 08:41:53PM -0800, Roman Gushchin wrote:
> >> Introduce a BPF kfunc to get a trusted pointer to the root memory
> >> cgroup. It's very handy to traverse the full memcg tree, e.g.
> >> for handling a system-wide OOM.
> >> 
> >> It's possible to obtain this pointer by traversing the memcg tree
> >> up from any known memcg, but it's sub-optimal and makes BPF programs
> >> more complex and less efficient.
> >> 
> >> bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
> >> however in reality it's not necessary to bump the corresponding
> >> reference counter - root memory cgroup is immortal, reference counting
> >> is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
> >> memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
> >> obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.
> >> 
> >> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> >> ---
> >>  mm/bpf_memcontrol.c | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >> 
> >> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> >> index 82eb95de77b7..187919eb2fe2 100644
> >> --- a/mm/bpf_memcontrol.c
> >> +++ b/mm/bpf_memcontrol.c
> >> @@ -10,6 +10,25 @@
> >>  
> >>  __bpf_kfunc_start_defs();
> >>  
> >> +/**
> >> + * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
> >> + *
> >> + * The function has KF_ACQUIRE semantics, even though the root memory
> >> + * cgroup is never destroyed after being created and doesn't require
> >> + * reference counting. And it's perfectly safe to pass it to
> >> + * bpf_put_mem_cgroup()
> >> + *
> >> + * Return: A pointer to the root memory cgroup.
> >> + */
> >> +__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
> >> +{
> >> +	if (mem_cgroup_disabled())
> >> +		return NULL;
> >> +
> >> +	/* css_get() is not needed */
> >> +	return root_mem_cgroup;
> >> +}
> >> +
> >>  /**
> >>   * bpf_get_mem_cgroup - Get a reference to a memory cgroup
> >>   * @css: pointer to the css structure
> >> @@ -64,6 +83,7 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> >>  __bpf_kfunc_end_defs();
> >>  
> >>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> >> +BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
> >
> > I feel as though relying on KF_ACQUIRE semantics here is somewhat
> > odd. Users of this BPF kfunc will now be forced to call
> > bpf_put_mem_cgroup() on the returned root_mem_cgroup, despite it being
> > completely unnecessary.
> 
> A agree that it's annoying, but I doubt this extra call makes any
> difference in the real world.

Sure, that certainly holds true.

> Also, the corresponding kernel code designed to hide the special
> handling of the root cgroup. css_get()/css_put() are simple no-ops for
> the root cgroup, but are totally valid.

Yes, I do see that.

> So in most places the root cgroup is handled as any other, which
> simplifies the code. I guess the same will be true for many bpf
> programs.

I see, however the same might not necessarily hold for all other
global pointers which end up being handed out by a BPF kfunc (not
necessarily bpf_get_root_mem_cgroup()). This is why I was wondering
whether there's some sense to introducing another KF flag (or
something similar) which allows returned values from BPF kfuncs to be
implicitly treated as trusted.

