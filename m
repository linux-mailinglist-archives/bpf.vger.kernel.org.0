Return-Path: <bpf+bounces-49009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DF7A12F9E
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 01:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6913A5974
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93F8F77;
	Thu, 16 Jan 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="obwVu66Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B779EA
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987088; cv=none; b=uMNhrtmTqcIwGq56hMP4BkEgivFdGDmPaF7lkH5NDKhoarlmFSZRNno3aDBmumG1z7medQNqRbLC6FmrJ5/6TvcOld95AKt/+WbwjbW7sNz+zhwJ5kMUVNqBDXLa1MRopBXeBfJ/PhdOUogWAv+fPDdQYTHJQmxlkR26L3qpOTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987088; c=relaxed/simple;
	bh=QF4jJAAHpJQ6+KjYwsmi/X2LghEvE8OxcT9wr8CrDmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciKWtwZP7XPoWsCghni8EnLerJk+wyGJ8e3tQ3v9h0Z7SIQaxPd3VPu5PM8TjUvyQYlBTSJWohvLhHAvt8LveAW6lbv2EQvQ2jYvOcEMuar2yf0mV1+uGP6YEZcQpshLR7n0FwL4dyRbp+5atQr8okNwort5mt8xLliAi0DYkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=obwVu66Y; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Jan 2025 16:24:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736987079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJVfuewxY+7bS+73AQA/Ts0uF9zxMXIMdSwPhzOFej4=;
	b=obwVu66YpLrg/Ygdk3KrS4VApPSAqJrhXtqn6cWoRr3wZUkeeEhEBw3RSWpafj0uluUa2T
	5XEML7YnjhcYOwAoRHFxJLOPx0bd6JlMwcPpVmxHgfRkMiFhZkQtPimnEs/8Ey+D6U7o/o
	p14PCTVOLFfNjlEWlLpBzZTf/sRCwOg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org, mhocko@suse.com, 
	willy@infradead.org, tglx@linutronix.de, jannh@google.com, tj@kernel.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v5 5/7] mm, bpf: Use memcg in try_alloc_pages().
Message-ID: <y5hduwjw6ezlyuuqhozkwzrd2qs5e3wlelmvurykl4wotwyq3t@4idcfqqlbfhu>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-6-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115021746.34691-6-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 06:17:44PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Unconditionally use __GFP_ACCOUNT in try_alloc_pages().
> The caller is responsible to setup memcg correctly.
> All BPF memory accounting is memcg based.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

