Return-Path: <bpf+bounces-60119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22130AD2AAE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0037A7B7E
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5D22E3FF;
	Mon,  9 Jun 2025 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L42OIJw3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10D22A7E1;
	Mon,  9 Jun 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749512653; cv=none; b=jFctpZFGUHeQ6vTkI8vpueRFVE5GfY7J1aJ90RnXHurMw5IcKIRzekvTfND21vjt24tMu6cMrGNcdIVD7l2oOlXyAbpgBOlGGg3APrcANwWL1kmPlhLl9gPQb05QZAZiObJHACw6jI8CNlekXj53CqFjMUS++RVjwzXfJpptsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749512653; c=relaxed/simple;
	bh=vCsvJmopQfzNvtO7dFpJpOrAKelVv3J5F65ij4IFChE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tX/zaoa6OYRvfSvKDXZBLZ5Gd6Iit9Nr+5z4PxwuHLgnj1g13WTHXEBlhjrM6d+rvs0fZWCQwKibJN5/D6GpbABFD6uKTw5VOYB6Xzod7LWev/4STv8/qr75hYPD8RoufAcgkTKYyin7WW1gPPGNWoY1tZdxamQ2NWXs/SRb2lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L42OIJw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D47C4CEEB;
	Mon,  9 Jun 2025 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749512651;
	bh=vCsvJmopQfzNvtO7dFpJpOrAKelVv3J5F65ij4IFChE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L42OIJw3fcppNGCJh7ojQVhFL4XvQRULZwFoEqHeP02rdBj9lBWmb8RNPaN2zNKBB
	 ojz7Xjf3SXcFG+cKKsX/uZnnLfafDZTUe1aTqvde78thvl1JFj0UjviyHDkrbqsuBl
	 Vgi6plUGKA/rulEES/v0MOtUPWWZ704idsk7pExM=
Date: Mon, 9 Jun 2025 16:44:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed
 <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH 0/3] cgroup: nmi safe css_rstat_updated
Message-Id: <20250609164410.568fd70e6a1deb6556e25af7@linux-foundation.org>
In-Reply-To: <20250609225611.3967338-1-shakeel.butt@linux.dev>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 15:56:08 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> BPF programs can run in nmi context and may trigger memcg charged memory
> allocation in such context. Recently linux added support to nmi safe
> page allocation along with memcg charging of such allocations. However
> the kmalloc/slab support and corresponding memcg charging is still
> lacking,
> 
> To provide nmi safe support for memcg charging for kmalloc/slab
> allocations, we need nmi safe memcg stats and for that we need nmi safe
> css_rstat_updated() which adds the given cgroup state whose stats are
> updated into the per-cpu per-ss update tree. This series took the aim to
> make css_rstat_updated() nmi safe.
> 
> This series made css_rstat_updated by using per-cpu lockless lists whose
> node in embedded in individual struct cgroup_subsys_state and the
> per-cpu head is placed in struct cgroup_subsys. For rstat users without
> cgroup_subsys, a global per-cpu lockless list head is created. The main
> challenge to use lockless in this scenario was the potential multiple
> inserters using the same lockless node of a cgroup_subsys_state which is
> different from traditional users of lockless lists.
> 
> The multiple inserters using potentially same lockless node was resolved
> by making one of them succeed on reset the lockless node and the winner
> gets to insert the lockless node in the corresponding lockless list.

And what happens with the losers?

