Return-Path: <bpf+bounces-67244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2787EB41152
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 02:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9303560FF7
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F45E19E7F8;
	Wed,  3 Sep 2025 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHxl1z2M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FA188580;
	Wed,  3 Sep 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756859343; cv=none; b=IE3q+YYWm1SAZyyyi8kEo649r83aQP9Ytpjw6M1S4XhhZ5BUZfNrcQmMY5DN25YsrjjITtOloKsMxN34Uu4sPKwPjrPqPAPUj3/7Ic1yXxawHoeyXRKGlkew2yS/TsKOqXmY+N8XcCjO39IbcGQlcI/QKARE/Vs76qFwsA370YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756859343; c=relaxed/simple;
	bh=U6crchSx22A1Dkt0nN8K+hqbGunsTXrVtw8pYSSnspQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGTQOBLCPG8HW7J+Qrcyvs3wWSmsBkZhpncOEoy8ZKpfcB9RR5TSbcaLGqvKlbfzmF6NGhRcpr8EXbka1Y9RiUD1dG4z1dR52xDtql8pWgAAC/upClcZKpABZznEtZuEM/y/PYMp0XsQkERCaZyjH+VAxGpLbyBNMT/dwQlncg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHxl1z2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E84BC4CEED;
	Wed,  3 Sep 2025 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756859342;
	bh=U6crchSx22A1Dkt0nN8K+hqbGunsTXrVtw8pYSSnspQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHxl1z2MauCod22FbWqCkY6B5xkLKi5v1sCfCih9PmgDeWl6ShYcQ4PqJQC2fCBDD
	 ejCgibNuovMVGUJl/ISP88p2mUL1tipGRboeaDkwOSPjYKxdz+i9BLka2e5meyuAl/
	 iLaiOyimIXhQ7f29wZx7a8laO0//URfaUDDKqgjSF/wm+mmFDuyqD8TbWlmqO/3Tpu
	 PGvi2PYP7h9YI6Vqlf64fLXbkhHKbL/HxBZk5aAmFE3BCpMZR7geaUzPGagj7gSUQT
	 vAYVUEOO8JtZV4uLblMB3kmx6TDPHaYTR4hYT4Tq00dk1eVrdYNIU113DI9qGSfx8j
	 yLyDyRnl1PwIw==
Date: Tue, 2 Sep 2025 14:29:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
Message-ID: <aLeLzWygjrTsgBo8@slm.duckdns.org>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev>
 <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev>
 <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev>
 <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iki0n4lm.fsf@linux.dev>

Hello, Roman. How are you?

On Tue, Sep 02, 2025 at 10:31:33AM -0700, Roman Gushchin wrote:
...
> Btw, what's the right way to attach struct ops to a cgroup, if there is
> one? Add a cgroup_id field to the struct and use it in the .reg()
> callback? Or there is something better?

So, I'm trying to do something similar with sched_ext. Right now, I only
have a very rough prototype (I can attach multiple schedulers with warnings
and they even can schedule for several seconds before melting down).
However, the basic pieces should may still be useful. The branch is:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-hier-prototype

There are several pieces:

- cgroup recently grew lifetime notifiers that you can hook in there to
  receive on/offline events. This is useful for initializing per-cgroup
  fields and cleaning up when cgroup dies:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/tree/kernel/sched/ext.c?h=scx-hier-prototype#n5469

- I'm passing in cgroup_id as an optional field in struct_ops and then in
  enable path, look up the matching cgroup, verify it can attach there and
  insert and update data structures accordingly:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/tree/kernel/sched/ext.c?h=scx-hier-prototype#n5280

- I wanted to be able to group BPF programs together so that the related BPF
  timers, tracing progs and so on can call sched_ext kfuncs to operate on
  the associated scheduler instance. This currently isn't possible, so I'm
  using a really silly hack. I'm hoping we'd be able to get something better
  in the future:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/commit/?h=scx-hier-prototype&id=b459b1f967fe1767783360761042cd36a1a5f2d6

Thanks.

-- 
tejun

