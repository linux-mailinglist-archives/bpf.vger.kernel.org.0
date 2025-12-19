Return-Path: <bpf+bounces-77209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6544CD2253
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 23:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E071C3017F01
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C332E62D9;
	Fri, 19 Dec 2025 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v+ESlIex"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C490157480
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184425; cv=none; b=XV0WtzZgYTxFH7F8ot+ItWFyT0pOWGopykA9BkU7la5ujUCeAlIiEAl7MATtYXPor+4kuGVaaGtdn0nH1J04exYrp/olyvq+yIc9mbG7lCGWoprB4f/Y7SCPPmsy946x+HWgnGUsuyxvu5b1LwKtzAfjJ0MJnkYqkxHpzW33YoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184425; c=relaxed/simple;
	bh=uqFat4EKJW5NPbQHvyObBwqH+C8PafQHAZz2h+DemJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By09fqt+BHL0VBK/Nu1rTtR0pr7VGPnRayQAuvZA7/q0ZnfSm65YgXXqVD7ljfjKTVjSvushU4hHtHNaz5ssOv+bnZyh9N3yakimkw1t/px12SAzHgPU8AwBbOIqjF2f/0wC8F/nEUGiXhxON/jIyHiOvNt8gGhZe36uecR5kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v+ESlIex; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 14:46:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766184416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oy4hadatsvYWxENzwt+xKjFz8JiU6Rcr59bQ6PfeQ9A=;
	b=v+ESlIexGbzGvTFY8u0qTO52uw/9pfdgJuAtppdMwJLAHyU7B8/qs61vGeEO8CKpxLFcaO
	JBKfTE5P660Zcj0Aujch/paPfdHjiY57DaIUGyyxjvWCm1n/2mnOd4ZVloERWcE08MV+3Y
	Kr07LDdfWyntv4h7FO+KjQUNQNTuJNo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v1 5/6] mm: introduce BPF kfunc to access memory
 events
Message-ID: <imjniqyf6rbyla4hhgpxetw27wxsqpvt7zskdytov2by7bkt6k@yza2vuhvczmi>
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
 <20251219015750.23732-6-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219015750.23732-6-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 18, 2025 at 05:57:49PM -0800, Roman Gushchin wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> Introduce BPF kfunc to access memory events, e.g.:
> MEMCG_LOW, MEMCG_MAX, MEMCG_OOM, MEMCG_OOM_KILL etc.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Roman, you need to add your signoff as well.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

