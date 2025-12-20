Return-Path: <bpf+bounces-77227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 792FACD2756
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 233F33014AD4
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FF92DC783;
	Sat, 20 Dec 2025 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuqnLWCA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798C26B95B;
	Sat, 20 Dec 2025 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204984; cv=none; b=IqPVI0300OVrvBEmXTSUqtWp83pOpDYhooogzUKYCtdpx2pKRYfpM20QYG72iJmb1SnNe4/1CJBy+jIX1Ek4mt04bXJEZfOuER29G2onmJ+EGYP8gwA1wFMQgndsaohXi+/kcDZiT83s96epp4nydZyXGbI7QVCTQRcku78nJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204984; c=relaxed/simple;
	bh=LHAu/dZyFQqqK29xEpICrXmsoRaq6iiP4g0Utho5RUI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S41fZBh0z2nMdG9OaOmOs4LJCYQZMFGRJB+6PDeZ/UFmhKd2zzg95+UIsB4PUIHjrNJXyXnrJkRe+GwRdx8wH0FWTJs7UOlmefn7QbK9/FDqz0C8u8cfw6+bktPe9GTEL2vcsfBqqbrO+enQxxw6eqgtMd+kHQHU8lPBqvPOLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuqnLWCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39741C4CEF5;
	Sat, 20 Dec 2025 04:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766204983;
	bh=LHAu/dZyFQqqK29xEpICrXmsoRaq6iiP4g0Utho5RUI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kuqnLWCAZTNO1hFuZFoMgWDhDNkPQA3euPYG79oVTR2ZJ9D365HS8d7tZSORwJhJ/
	 2rudc3555K/aZ5zARBsFmLwnjDNe1ZNRhrygMNOp7EV43nQBvb7diJ06zvyUEAivvL
	 EV/nJuLjVrIndgEIHzagDZKITQLb7OszTygz3PYiueJx8zWJRMMrf9S2DPsPcxGljK
	 FDQpbW46oxRN9EWFbWngsVHKM8g8bFmIcyBoavAo+FdT0xg9MV53pN91Goy79/BdWj
	 unZPMBTA7pti/eLQ+vDZDTUbGzbQLVLVsBw0Y5OH4vbq0kxsouTsimqhyNW9VtExpz
	 amjowlt6QNPtA==
Content-Type: multipart/mixed; boundary="===============1907785491009621542=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b78506003b674f5e66bc7ac61f279a363f5cacc8d2fcb615d06abb0316ef00c@mail.kernel.org>
In-Reply-To: <20251220041250.372179-5-roman.gushchin@linux.dev>
References: <20251220041250.372179-5-roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next v2 4/7] mm: introduce BPF kfuncs to access memcg statistics and events
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kernel@vger.kernel.org
Cc: inwardvessel@gmail.com,ast@kernel.org,daniel@iogearbox.net,shakeel.butt@linux.dev,mhocko@kernel.org,hannes@cmpxchg.org,roman.gushchin@linux.dev,mhocko@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 20 Dec 2025 04:29:43 +0000 (UTC)

--===============1907785491009621542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 2d518ad2ad3f..d84fe6f3ed43 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -78,6 +78,57 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>  	css_put(&memcg->css);
>  }
>
> +/**
> + * bpf_mem_cgroup_vm_events - Read memory cgroup's vm event counter
> + * @memcg: memory cgroup
> + * @event: event id
> + *
> + * Allows to read memory cgroup event counters.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
> +						enum vm_event_item event)
> +{
> +	return memcg_events(memcg, event);
> +}

Should this function validate the event parameter before passing it to
memcg_events()?

The call chain bpf_mem_cgroup_vm_events()->memcg_events()->memcg_events_index()
reaches an array access in memcg_events_index():

    static inline int memcg_events_index(enum vm_event_item idx)
    {
        return mem_cgroup_events_index[idx];
    }

The array mem_cgroup_events_index is declared with size NR_VM_EVENT_ITEMS.
If a BPF program passes an event value >= NR_VM_EVENT_ITEMS, this would
cause an out-of-bounds array read.

For comparison, bpf_mem_cgroup_page_state() below validates its idx
parameter before calling memcg_page_state_output(). A similar check here
would prevent the potential out-of-bounds access:

    if (event < 0 || event >= NR_VM_EVENT_ITEMS)
        return (unsigned long)-1;

> +
> +/**
> + * bpf_mem_cgroup_usage - Read memory cgroup's usage

[ ... ]

> +__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
> +{
> +	if (idx < 0 || idx >= MEMCG_NR_STAT)
> +		return (unsigned long)-1;
> +
> +	return memcg_page_state_output(memcg, idx);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20389033088

--===============1907785491009621542==--

