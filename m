Return-Path: <bpf+bounces-77228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50692CD2759
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E6C3025F9B
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4062F12CF;
	Sat, 20 Dec 2025 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B46/qmCG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B15B2ECEBB;
	Sat, 20 Dec 2025 04:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204985; cv=none; b=RhFrBegpz8Or7SXkqoEE5FQqtlwV5fQceGS7N+hw9UIvq8bRyTgBrJD7wUN3AxWkqaWdYJtzSjsxm5FjTRcCGcSchPaMPkr2ujlg4baKio7kCcksx+BEHhhY6UpOgd1mGvYTbkJQbHrIA9vJ8JbX0IOzznUv7zHUMbNTDWujqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204985; c=relaxed/simple;
	bh=Z9JOLErhQJXlltHr9P9A8oYRxRDSKmJ1+qQX8KwZG7Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=twd+afGtGHrHpeJvWERso6p42+sTYZe80TYgCBILF7FJEVFubJHVfI6NU4q5TVw4KbgJgfYxHMqnQwscBsKL17jwKDvKZ8YKIlGrc+JsPRJ89jsSXHxaGvdVSpDgtpuDxSI31G/DDV/d37XmhnBvRqO7F7oL2ICu4QVTW9WvmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B46/qmCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7B5C116C6;
	Sat, 20 Dec 2025 04:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766204984;
	bh=Z9JOLErhQJXlltHr9P9A8oYRxRDSKmJ1+qQX8KwZG7Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=B46/qmCGfQTJUTcuLEOwXHSbfxWtorMZkB6aFjFPVkPs++W+Iya8ZoagzJPWtLTf+
	 prRuo7ju/Y0Z7ikQYxRUWPOgig2YWrhuYvWyFSqJbJ9BtLcju/eXCEe5h02ptMa9MY
	 cuP1MRFUZho0vUSt0Jc0HgQZ9T6bklJUjutOPpxqQ32bZ8mliCtSDWmKQSCtjag/aO
	 7N0GY6kfq55xqf19DJHXByTe9ePh1KamaXNZdcdFQFhzJsLg3NA0DhDjbSb7nba0FR
	 0ENAkZZoz3RQuhEJKu/37q7hspwR8rHcNqkt91uo8miODiJULioX/OiRzzPZrskT/2
	 7t7zDGZMh23lA==
Content-Type: multipart/mixed; boundary="===============8958172171642077659=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f23848b8ac657b4b4a2da04da242039c59e9ad9826a8d5fa0f5aee55acfecc9@mail.kernel.org>
In-Reply-To: <20251220041250.372179-6-roman.gushchin@linux.dev>
References: <20251220041250.372179-6-roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next v2 5/7] mm: introduce BPF kfunc to access memory events
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kernel@vger.kernel.org
Cc: inwardvessel@gmail.com,ast@kernel.org,daniel@iogearbox.net,shakeel.butt@linux.dev,mhocko@kernel.org,hannes@cmpxchg.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 20 Dec 2025 04:29:44 +0000 (UTC)

--===============8958172171642077659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index d84fe6f3ed43..858eb43766ce 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -103,6 +103,22 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
>  	return mem_cgroup_usage(memcg, false) * PAGE_SIZE;
>  }
>
> +/**
> + * bpf_mem_cgroup_memory_events - Read memory cgroup's memory event value
> + * @memcg: memory cgroup
> + * @event: memory event id
> + *
> + * Returns current memory event count.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
> +						enum memcg_memory_event event)
> +{
> +	if (event >= MEMCG_NR_MEMORY_EVENTS)
> +		return (unsigned long)-1;

Should this also check for negative values?  The enum type is typically
signed, so a BPF program passing a negative event value would pass this
check but cause an out-of-bounds read from memcg->memory_events[].

The similar bpf_mem_cgroup_page_state() in this same file uses:

    if (idx < 0 || idx >= MEMCG_NR_STAT)

which checks both bounds.  Could the check here be changed to:

    if (event < 0 || event >= MEMCG_NR_MEMORY_EVENTS)

to match that pattern?

> +
> +	return atomic_long_read(&memcg->memory_events[event]);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20389033088

--===============8958172171642077659==--

