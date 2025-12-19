Return-Path: <bpf+bounces-77114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1489CCE416
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24F1D301AB38
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22195273D8D;
	Fri, 19 Dec 2025 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4GYPpK7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9694419995E;
	Fri, 19 Dec 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766110901; cv=none; b=JlB4A2NPUB/QIEnje0bE4c9/r+kUVCovzbj7dY1DYD2VeVQZXj3CCmozM9wgPkgGSXhzpVBDEUphR2Ag5t+9NRTmb7xrxm+sgA5iqyg14ImIvQLdLy1+J/xtbWnjAe36tybQPCSINUTPPruWmgKc6dnvrw2NZVmlByv3SXChov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766110901; c=relaxed/simple;
	bh=Wn06/ZF3XHZjIpC5IMs0aTkDV4ts+z6RiFMrHphIV+M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jMa2WzrVF7612aEEHbqY1b9fNQjI3F4ythu9dYcaMr4/8MgGDFhpNkGtC3xdVVSZW8XkUP0K42vtvLWfnuNYIUKiZbxY3+mRGIW0l1dmI5zHa0xQ6aIUwydvPxCIENDyLMz9YyILvGtQq1513ek/TzHKZuE6Rbd4JByI5Uu0e88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4GYPpK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD96DC4CEFB;
	Fri, 19 Dec 2025 02:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766110901;
	bh=Wn06/ZF3XHZjIpC5IMs0aTkDV4ts+z6RiFMrHphIV+M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=j4GYPpK7VGAKXEExKB9LndVfK5vDEnlPsSU/BRzP1Xsn1r4HoXfGuLnuB2ypyDz6Q
	 KZ2byv9yD8H9B0QuwaLDJJHQGjweeI0HQxZeBTCVb10j0wZEqs1cRuzgCuGvaF8b9n
	 /sKSDgzvRXjPleKrN7waHbwN4lThs8w9caxkr+bge95bDQuARiPWEGnRMHrdTn/IQZ
	 E4+kaiOi76WbamsmoFRspnK2WLZoamNWT1JhRwwxUrTLthvAAZNmimBNW1Cs4LTogI
	 nqrXWgzQF3yhZL47FL45I3m9c6fjgzTSuPpLwcFp63dcHrBgt+UuDr95k2ivgt4HNh
	 4V4YvTI5BickQ==
Content-Type: multipart/mixed; boundary="===============6244217947612912370=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cf8d48e8bcdba2515366bc8b6c85f581ca3d18ead24db9cb3ba9b98db252e0b9@mail.kernel.org>
In-Reply-To: <20251219015750.23732-6-roman.gushchin@linux.dev>
References: <20251219015750.23732-6-roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next v1 5/6] mm: introduce BPF kfunc to access memory events
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kernel@vger.kernel.org
Cc: inwardvessel@gmail.com,ast@kernel.org,daniel@iogearbox.net,shakeel.butt@linux.dev,mhocko@kernel.org,hannes@cmpxchg.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Dec 2025 02:21:40 +0000 (UTC)

--===============6244217947612912370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 4d9d7d909f6c..75076d682f75 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> +__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
> +						enum memcg_memory_event event)
> +{
> +	if (event >= MEMCG_NR_MEMORY_EVENTS)
> +		return (unsigned long)-1;
> +
> +	return atomic_long_read(&memcg->memory_events[event]);
> +}

Could this cause an out-of-bounds access if a BPF program passes a negative
value for event? The enum type is signed, so if event is -1, the check
"event >= MEMCG_NR_MEMORY_EVENTS" would evaluate to false (-1 >= 10 is
false), allowing access to memcg->memory_events[-1].

The existing bpf_mem_cgroup_page_state() in the same file uses both lower
and upper bound checks:

    if (idx < 0 || idx >= MEMCG_NR_STAT)
        return (unsigned long)-1;

Should bpf_mem_cgroup_memory_events() follow the same pattern with:

    if (event < 0 || event >= MEMCG_NR_MEMORY_EVENTS)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20357445962

--===============6244217947612912370==--

