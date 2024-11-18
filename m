Return-Path: <bpf+bounces-45109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D210B9D1865
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 19:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFFC1F249AD
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A681E2833;
	Mon, 18 Nov 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRUiChqv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FFD1E102E;
	Mon, 18 Nov 2024 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955533; cv=none; b=ddgf9K/JdYjFqFTByPdPijA90v6ah758DARZUt1biVmH53OBhBaY6Wux9HUqwmMGy6H/ldjJBzh0v0TYRaHcyS7rnDde4iMBAiyG46W1BjsH65DBGGGVu8Zm/Vl/KsM8LmbFB49KG9H9JA8T0eUblYpO1qUBJdM9D6z8h6P8WTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955533; c=relaxed/simple;
	bh=pTpgbEQ2v4xOlxmRjIKhSkuxO6OUIO3GQ62UFcCIbLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwyP9NiRd7AJADvQdMkppRdhnBBEnfbYsb1LYrkDhg1DoiWVjjj/A8l08s1lsMPmBVHAdmVszL4wgXh6unRldVlxz5G/xSjlt7k4uolAj0kNbfj9firMpkgGHdyba5vjF9LgqElOeYU+bPsh4o9O97SFVZ8pp3M/jDV7QZZthDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRUiChqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CA0C4CECC;
	Mon, 18 Nov 2024 18:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731955532;
	bh=pTpgbEQ2v4xOlxmRjIKhSkuxO6OUIO3GQ62UFcCIbLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRUiChqvD9wUkB+adJ+j8Xum+Z5bFMu7qqMilBlF5myMtJpFm+ezFJJycgSZgRlk4
	 nrIeUmu9p+u6KR7wQEZR5mDtx1a8iiN6wTIZfl9kujk/gidgH2lP1mjNrnoxr45PLX
	 WjyL1x/RYudJqea+GmyXXBKiW4zVDF/G1p0lMHiAe8dzi+eSQVI/wcmfTYlrZBkOal
	 3FaitVSX+TMZHTvEEHoTHrvlKucmCcZxE7No5iutEhyoi3U5ifmMxt/HKGzBpxZy6n
	 s3GWwbfYFeIbfCmmGPoYxbezl6CrHAeswrA3Eyfqfw7w3U/stkp4P29+oul4GbqOXP
	 6V3ZY2RPwRaOw==
Date: Mon, 18 Nov 2024 10:45:30 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 3/4] perf lock contention: Resolve slab object name
 using BPF
Message-ID: <ZzuLSkThfgkA_8hT@google.com>
References: <20241108061500.2698340-1-namhyung@kernel.org>
 <20241108061500.2698340-4-namhyung@kernel.org>
 <5f95c0d7-01a4-485d-a9d7-1a39acf9c680@suse.cz>
 <ZzNrIdiHCxTy1QId@x1>
 <00aa92be-85db-4163-9576-dfc71eafb415@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00aa92be-85db-4163-9576-dfc71eafb415@suse.cz>

Hello,

On Wed, Nov 13, 2024 at 03:20:43PM +0100, Vlastimil Babka wrote:
> On 11/12/24 15:50, Arnaldo Carvalho de Melo wrote:
> > On Tue, Nov 12, 2024 at 12:09:24PM +0100, Vlastimil Babka wrote:
> > +               /* look slab_hash for dynamic locks in a slab object */
> > +               if (hashmap__find(&slab_hash, flags & LCB_F_SLAB_ID_MASK, &slab_data)) {
> > +                       snprintf(name_buf, sizeof(name_buf), "&%s", slab_data->name);
> > +                       return name_buf;
> > +        	}
> > 
> > He wants to avoid storing 64 bytes (the slab cache pointer, 's'), instead
> > he wants to store a shorter 'id' and encode it in the upper bits of the
> > 'struct contention_data' 'flags' field.
> > 
> > The iterator, at the beggining of the session attributes this id,
> > starting from zero, to each of the slab caches, so it needs to map it
> > back from the address at contention_end tracepoint.
> > 
> > At post processing time it converts the id back to the name of the slab
> > cache.
> > 
> > I hope this helps,

Thanks Analdo for the explanation!

> 
> Thanks a lot, if it's a tradeoff to do a bit more work in order to store
> less data, then it makes sense to me.

Right, I don't want to increase the data size for this as we have some
unused bits in the flags.  It'd call one more bpf hashmap lookup during
record but I don't think it's gonna be a problem.

Thanks,
Namhyung

> > 
> >> - if it's postprocessing, it would be too late for bpf_get_kmem_cache() as
> >> the object might be gone already?
> >> 
> >> The second alternative would be worse as it could miss the cache or
> >> misattribute (in case page is reallocated by another cache), the first is
> >> just less efficient than possible.
> >> 
> >> > +			}
> >> > +		}
> >> >  
> >> >  		err = bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
> >> >  		if (err < 0) {
> 

