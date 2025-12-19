Return-Path: <bpf+bounces-77113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F7CCE403
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6413030FDD
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A528D83F;
	Fri, 19 Dec 2025 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohOY26Jz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568F2877D6;
	Fri, 19 Dec 2025 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766110512; cv=none; b=FKb99VWBbsbhMk0po+7OLFxhZg1J9AEqBbPtQqlZju0rBFxWW4qBaW8X08eAPDoK51mmRgOqR64LQ5x/QxQlyxs12d8ZjCfyyGlXGAgNB4ph11rKdGiDbz4UUbckQc3H+MXcGpGRHgXI8rdopVMkgGZ7oUpSw9SaBr5jjnbDi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766110512; c=relaxed/simple;
	bh=jbSSl/iAC0Y6PJMSUrlMAn/BWY9Mt013nMXshs1xgDs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ik9aSRZsjOZN25hfKsmKoF3XHRy5ePD25ancRzymvSLp/UMDAub9H6qd8r+23HbrGDDA4URuqveByar0xP5+bO+4XPE0yDQm2SXmTrESUnR8qsVBkQckmp6TMzrNoDKGiyErDswolwQmENhYq2YN0TlJTH5VVjyYki2zOTzsNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohOY26Jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C1DC4CEFB;
	Fri, 19 Dec 2025 02:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766110512;
	bh=jbSSl/iAC0Y6PJMSUrlMAn/BWY9Mt013nMXshs1xgDs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ohOY26JzrJ84xK6XyL8AqFmyDkTo9LE/qIAUO8G0H5ib8aLYkqsqgg4iN4HhwC9A8
	 dSCzzo+xsEtHkc7jQ89GIDOau3gUAOxUVGwQECL+G4gWuQ39gpN4wNlvTaJw6S4eCK
	 6cauPx1p8PM4trko8Ybe0AOqRbLrch7ro1uFZaESGAkC4yrEtka4JS/mJQb+cz9OBs
	 VyLO4ZxrNZu41kCGli0yUgqOe5BHni16a6XnX7cGom+wTldN+siH/m/WQ7cBSSnvFu
	 p+6l9II2GAjI69e6mCttfNJniZ2cFHw8I1y5eFA3aZdR5kW4p5ErP9PalcG5xHtwHP
	 +JMxQvcfiW7bg==
Content-Type: multipart/mixed; boundary="===============1148049922040317406=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e80e8faecbfd7099950485f4de08a1226ae10282ec44fe9e6b3610fcb00c8400@mail.kernel.org>
In-Reply-To: <20251219015750.23732-5-roman.gushchin@linux.dev>
References: <20251219015750.23732-5-roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next v1 4/6] mm: introduce BPF kfuncs to access memcg statistics and events
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kernel@vger.kernel.org
Cc: inwardvessel@gmail.com,ast@kernel.org,daniel@iogearbox.net,shakeel.butt@linux.dev,mhocko@kernel.org,hannes@cmpxchg.org,roman.gushchin@linux.dev,mhocko@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Dec 2025 02:15:11 +0000 (UTC)

--===============1148049922040317406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 6d0d73bf0dd1..4d9d7d909f6c 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

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

Should bpf_mem_cgroup_vm_events() validate the event parameter before
passing it to memcg_events()? The call chain is:

  bpf_mem_cgroup_vm_events() -> memcg_events() -> memcg_events_index()

And memcg_events_index() does:

  return mem_cgroup_events_index[idx];

where mem_cgroup_events_index is an array of size NR_VM_EVENT_ITEMS. If a
BPF program passes event >= NR_VM_EVENT_ITEMS, this would be an
out-of-bounds array read.

The sister function bpf_mem_cgroup_page_state() below validates its idx
parameter before calling its callee:

> +/**
> + * bpf_mem_cgroup_page_state - Read memory cgroup's page state counter
> + * @memcg: memory cgroup
> + * @idx: counter idx
> + *
> + * Allows to read memory cgroup statistics. The output is in bytes.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
> +{
> +	if (idx < 0 || idx >= MEMCG_NR_STAT)
> +		return (unsigned long)-1;
> +
> +	return memcg_page_state_output(memcg, idx);
> +}

Should bpf_mem_cgroup_vm_events() have a similar bounds check, perhaps:

  if (event >= NR_VM_EVENT_ITEMS)
      return (unsigned long)-1;

before calling memcg_events()?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20357445962

--===============1148049922040317406==--

