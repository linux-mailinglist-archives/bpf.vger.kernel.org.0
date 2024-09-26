Return-Path: <bpf+bounces-40327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ADC986A38
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 02:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78A51C215C2
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 00:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F62D16B75B;
	Thu, 26 Sep 2024 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j5aBZG1M"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097614B07E
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727309788; cv=none; b=McWpcwGtqX8yV28RhSd7lxPSAR+y/STbn//+U/V35HE1gMbs0QbC+xrNJhCrbXzfIk6FfjXJACjlvg3PrwV1lAspA3X95VnIlb42EQdh8qtsHYQ9JWYwDGllRtBhrPKVlIgt0MYavCj1Q/XHCh0cRh7XxpVkfpGEWzKIl7hcfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727309788; c=relaxed/simple;
	bh=enwoDO9zWkwqHs5u+zYVt8zDdSb9cC+OKz6EZZC2mx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV8QEWv1FzFMC6/9Hdal3WFG64pb1K+1I76BSKCQubZdvXu+lItj8TgBvjw72WwjwxOHgBSLMutYZWNKLMyuSyIoYLLVsRYpUz94UYFo5TtNgE7ghbJN7MsvHHSBS6y1CZjFWlgPami70E6UtoHp0MRWgoONOpJRTQxaGGJlMq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j5aBZG1M; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Sep 2024 00:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727309783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/w0GqQUJf9ZvapO+fo8ZvEt44vfHed8rtLvCcTVOD4=;
	b=j5aBZG1MpDF6m5aOfSPds6ZxgTTmmX4spq3jfTDID4WNOeAsiEiRDh3Y9m/u/KddbFH3n5
	O5FeBC8GPEe7CrtMkz/u/ncYExQA1qi4UtlJfyot1gEbvCFhkXW1ejEM8F+ju5GLglyygD
	qhAjD1ybu4OKUAG8lkb1XadxaVZRVWY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Subject: Re: [RFC/PATCH bpf-next 0/3] bpf: Add slab iterator and kfunc (v1)
Message-ID: <ZvSnz4F7gDFa9_ue@google.com>
References: <20240925223023.735947-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925223023.735947-1-namhyung@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 25, 2024 at 03:30:20PM -0700, Namhyung Kim wrote:
> Hello,
> 
> I'm proposing a new iterator and a kfunc for the slab memory allocator
> to get information of each kmem_cache like in /proc/slabinfo or
> /sys/kernel/slab.

Hello, Namhyung!

I personally like the idea very much. With a growing number of kmem_caches
/proc/slabinfo getting close to it's limit, so having a more flexible
interface makes a lot of sense.

> Maybe I need to call it kmem_cache iter but slab
> was short and easier to call. :)

I'd personally prefer kmem_cache or slab_cache, just in case somebody later
would propose an iterator over individual slab objects within a kmem_cache.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)

Thanks!

