Return-Path: <bpf+bounces-68288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4E4B55D5C
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 03:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9236B635A9
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 01:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3092C1A2;
	Sat, 13 Sep 2025 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wVar9OQb"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882B27470
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757726229; cv=none; b=MVyyKnWetuBM+MqMzIsz2L1ji/rIYGP6JlE4ppi64TDZbgdLi9FB5eJjKkFqNaOkn31jnS/sIRForqaueVA4j6UbWneJmt/5vcI+RLw1WMRPl7HHR8AOIVlK91VISypqwGzj53wtXRv0MfL6nQCjvi4mx/Us+G5OIuI+S4oxh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757726229; c=relaxed/simple;
	bh=LJfozR7u5FKR1ixyZf3faJ165R1Namz53WHAXmPYbSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6qsdpjg+RckYkBBnqzbkEgCaBpN/wKDzIq6PEw7OfNB4XMeNwaLyk3QEg0oT9MfDSmnv7MQJqV8nOFqx6F81lb0fQNKaZRqZ1HwPQdWvk+3Knbvz4cAE293Sm1+Dc7/izk+9jvQ3HmRNYFrmKkSlburr13tk7mVI8tBgDf7eSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wVar9OQb; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 18:16:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757726222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqlLAeYWdZwvoK0DYA0jAex2CBIzpCMdqLmlmnesYyY=;
	b=wVar9OQbAnp05C49WbC/5f+y2yNP8Pia2055lnzcpJTO/1VRo1pbgOgkt0+Ycshor2vWJw
	z0YRZE6ftkwSburpBcpUmh7bp5ZoFQFF4XvlJl7rbfkhiqLm6cYQtDfAP97Bj+E3ZwE2yX
	6/zMs1w9LPIjuVdLrA3ZcqZ8RF/v9JQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, 
	harry.yoo@oracle.com, mhocko@suse.com, bigeasy@linutronix.de, andrii@kernel.org, 
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org, 
	rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
Message-ID: <6xghjvydfxp3m23oddzzbkm6o6j35w343njoediubtxcfxc6ye@lj2uhqrks3wk>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909010007.1660-6-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Since the combination of valid upper bits in slab->obj_exts with
> OBJEXTS_ALLOC_FAIL bit can never happen,
> use OBJEXTS_ALLOC_FAIL == (1ull << 0) as a magic sentinel
> instead of (1ull << 2) to free up bit 2.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


