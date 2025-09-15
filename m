Return-Path: <bpf+bounces-68370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D89B56F3F
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 06:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E574178B46
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 04:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55F1DF75B;
	Mon, 15 Sep 2025 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKOeGzoX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090A17BEBF
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757909980; cv=none; b=FDnBb0wUQmpGPgDGXiSgSE+RZEmnJsDHe6HGOhAslj0G3z4Rq80mIxBVBa7lNFlOfYT6xf6rW4EpO1RTRyo5b3bnVRT6dIutzpw6CFkkitAHs4op6PEOeRWt0R94b7s57VdPrbT7Ng/1jmpPEJGuEHJiJsS35DEHi6GboUzBrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757909980; c=relaxed/simple;
	bh=p79D1GNMGHNdxUWIHh7fDPFNSIfeDnRTC1S9P8RKWUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McmrdJNRN9Ad35mKuz8C3/GXGeRtK/sM/Xdbehb+Wuv8o9rJ3ZIV8WQcuRY1Aa0b3htbGn5+Iy4UcVktf33Tf4EKVF6QjoJoJuNKn18KHpexBX0tub0Q680nW8xqRbEMoPEEQEKr3twpeXyTbao2tyoFI42c5Ewlol9O9PvUrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKOeGzoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40200C4CEF1;
	Mon, 15 Sep 2025 04:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757909979;
	bh=p79D1GNMGHNdxUWIHh7fDPFNSIfeDnRTC1S9P8RKWUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKOeGzoX3944PWPU0v3CY/dyruwi0GwI0L0YMvwR8rchrijDbV7nKHVIk4o26ffWP
	 Qu2nKSjUqKi5kGptz+V78NLJGSjM5Ie+FKOC3ckPFuUqYfOoc7Z9zkj4C/5LBukBXj
	 IC7VTWc25GghDf2oopEgq8wv5ky91YRffNU+Y7fQxSz3810PWS/Xtd/TKuHwOVXqC2
	 cBSvi3/KDk2/PQpktEjCeDjHShEIEojv/d/P0rEkHbHGZDN1PwgzMglH/aec/g9Ucr
	 PoHH2WAMliwvrq5R4AOo/EBJRg7qMV96lECqyHgN/oToyNC7mZVuofu/rTXgD0fcRl
	 lR3v27BBaiHiw==
Date: Sun, 14 Sep 2025 18:19:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not limit bpf_cgroup_from_id to
 current's namespace
Message-ID: <aMeT2t0HXCNcJBuS@slm.duckdns.org>
References: <20250915032618.1551762-1-memxor@gmail.com>
 <20250915032618.1551762-2-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915032618.1551762-2-memxor@gmail.com>

On Mon, Sep 15, 2025 at 03:26:17AM +0000, Kumar Kartikeya Dwivedi wrote:
> The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
> cgroup corresponding to a given cgroup ID. This helper can be called in
> a lot of contexts where the current thread can be random. A recent
> example was its use in sched_ext's ops.tick(), to obtain the root cgroup
> pointer. Since the current task can be whatever random user space task
> preempted by the timer tick, this makes the behavior of the helper
> unreliable.
> 
> Refactor out __cgroup_get_from_id as the non-namespace aware version of
> cgroup_get_from_id, and change bpf_cgroup_from_id to make use of it.
> 
> There is no compatibility breakage here, since changing the namespace
> against which the lookup is being done to the root cgroup namespace only
> permits a wider set of lookups to succeed now. The cgroup IDs across
> namespaces are globally unique, and thus don't need to be retranslated.
> 
> Reported-by: Dan Schatzberg <dschatzberg@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route this through the BPF tree.

Thanks.

-- 
tejun

