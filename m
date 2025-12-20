Return-Path: <bpf+bounces-77231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FB8CD27E6
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 06:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76A1E3014AC0
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AE32EE608;
	Sat, 20 Dec 2025 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mf1nMu5P"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB429C325
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766208060; cv=none; b=mC++3REcxnSkZtoAhEvkYjlZ/OOcSI5Ad4JCi/9q3pWVuzBPsrllOjZ8AbBGuSx9q8sZm4XK/6AhNg9/tUkn6k2JOH9XMGl/jJNbBK+BfWOYNZ4IhnkVEbJw1Qe+LapHd3cKJtkSiErfwbVcKNgZ7y7BsPrwjfAM2gvbrcL+OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766208060; c=relaxed/simple;
	bh=PxcEc+tUr2YOQ+xQFOHlFcSM10ijrPEnbhaqR3xLgL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQR8gn4LTtIi7eoOFggITUe7ut93hEEe6eRMPgoczfhSy1kjFYqWvB9f3HfsJMUYS4EEMa5qQRd5jHpQ8p/A9axdmw09YBNucmCXgY30rm8NaxyCn/FW3MVGMdEm5Jf5Ry4B12ufzMjtgSGF4u3spCdxAxahpe7ETzCOqtUQfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mf1nMu5P; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 21:20:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766208056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqDEhQp8CVG8lDjtgTLrpQdaQ9VpTAXZ80x9h0TOpys=;
	b=Mf1nMu5PoKfV5M8Nonvx8tWbqyFtiONbhEehUZVpHiXAzwhxFi/3Xo984jkG50veGmiMZk
	3XKJpCq3YxenCKjix+Xqe3nRvFokuNjBLfA6DWqTikI/YnBCIYt8VEuBboDmeBeyde7+PP
	DCw4h1BYUstCScl2vhAC2At8Woj0N7Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v2 2/7] mm: introduce BPF kfuncs to deal with
 memcg pointers
Message-ID: <z77od372jts3d73n77v3o7dk4ro7hizuj2zn235vmbltwjnwfy@zkamyu7gf5jj>
References: <20251220041250.372179-1-roman.gushchin@linux.dev>
 <20251220041250.372179-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220041250.372179-3-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 19, 2025 at 08:12:45PM -0800, Roman Gushchin wrote:
> To effectively operate with memory cgroups in BPF there is a need
> to convert css pointers to memcg pointers. A simple container_of
> cast which is used in the kernel code can't be used in BPF because
> from the verifier's point of view that's a out-of-bounds memory access.
> 
> Introduce helper get/put kfuncs which can be used to get
> a refcounted memcg pointer from the css pointer:
>   - bpf_get_mem_cgroup,
>   - bpf_put_mem_cgroup.
> 
> bpf_get_mem_cgroup() can take both memcg's css and the corresponding
> cgroup's "self" css. It allows it to be used with the existing cgroup
> iterator which iterates over cgroup tree, not memcg tree.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

