Return-Path: <bpf+bounces-74014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF17C442EE
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB344346E21
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFBB3043BA;
	Sun,  9 Nov 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqbObaft"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BF2E92DA;
	Sun,  9 Nov 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707496; cv=none; b=INkrUhso5+jMT+x9Ghf3N3cKRZLd3fDi38nUKQf8hkEU8kt914kIpYrJ7oP0DzlSuX+cCBX5IxA5SYXGMj8W0Yr8quXpgpfa5Nx7jhbOpaAmUwpSUUhgVX8dGAd/skM4ScO5iJ4JcTZ2YBvUn2FUC13mR+MZ7DOEq+/czTqq0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707496; c=relaxed/simple;
	bh=b6sosotwC/oHOg9LGRqzgR279GDoawxDZ0ekAKfx+70=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fRRvLvSJYfOuOy5zOj0dtWHFqaSQXZ2Q0nmrest63V/Bg9QTkPNiXyYcrtZa1KJOqlqC4o3EYAsJaYqDJghfXV94P813Zsc9GnZhPG+XHu5N/HTDGsabIsVRaKtjoUEkch/rroW1PtXyk8Q9sZ4YWTK/1ZK5Mz43CywtWXDGFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqbObaft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E941C16AAE;
	Sun,  9 Nov 2025 16:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762707496;
	bh=b6sosotwC/oHOg9LGRqzgR279GDoawxDZ0ekAKfx+70=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WqbObaftT+4n7+zzfmiM089HqwM54MVsjMUJ9epZseSqw6gZ/3qZt6ZwNS7AnFeuY
	 qyGsV/LWhoXphn7GYJLya36fi6jk9hMZHdnqC+sbgKDUrAZ0vB2Lh/R3PCfJPGjdWY
	 ypWt31DJK2jZ7TbPx0TDFRZJG+1IzsCxF2qN+05fszTFOzmWgyEUCwwO1aoKYhDsfv
	 mAweHAp8Xh5KBuSGJchTwXLkfmkcRlgxEOeKpXu8LAS+CuIUadMcX6b5ykA/uk0MfC
	 DCil7ySHUq+IydX+H8zwQb6Ht8GCnB0+aAGNrrboznizVTPugym50ntrYUrHW6prJy
	 AiBkqIJ1tb03A==
Content-Type: multipart/mixed; boundary="===============0591375349055705727=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <886b17f3dd9f9836dd87b9249a01e737088fe52174b8d513ad6350c6bb19ff87@mail.kernel.org>
In-Reply-To: <20251109163559.4102849-2-chen.dylane@linux.dev>
References: <20251109163559.4102849-2-chen.dylane@linux.dev>
Subject: Re: [PATCH bpf-next v5 1/3] perf: Refactor get_perf_callchain
From: bot+bpf-ci@kernel.org
To: chen.dylane@linux.dev,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mark.rutland@arm.com,alexander.shishkin@linux.intel.com,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,chen.dylane@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  9 Nov 2025 16:58:15 +0000 (UTC)

--===============0591375349055705727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index fd1d91017..edd3058e4 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
>  	u32				nr;
>  	short				contexts;
>  	bool				contexts_maxed;
> +	bool				add_mark;
>  };

[ ... ]

> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 808c0d7a3..fb1f26be2 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c

[ ... ]

> +void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
> +{
> +	int start_entry_idx;
> +
> +	if (!user_mode(regs)) {
> +		if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
> +			return;
> +		regs = task_pt_regs(current);
> +	}
> +
> +	if (ctx->add_mark)
> +		perf_callchain_store_context(ctx, PERF_CONTEXT_USER);
> +
> +	start_entry_idx = ctx->nr;
                          ^^^^^^^^
> +	perf_callchain_user(ctx, regs);
> +	fixup_uretprobe_trampoline_entries(ctx->entry, start_entry_idx);
> +}

Can this break uprobe trampoline fixups? The original code used
entry->nr for start_entry_idx, but the refactored version uses ctx->nr.

These two counters track different things:
- entry->nr counts ALL entries (incremented by both
  perf_callchain_store_context() and perf_callchain_store())
- ctx->nr only counts regular callchain entries (incremented only by
  perf_callchain_store(), not by perf_callchain_store_context())

When add_mark is true, perf_callchain_store_context() increments
entry->nr but not ctx->nr, causing them to become out of sync.

For example, if kernel callchain collection runs first with add_mark
set:

  Initial: ctx->nr = entry->nr = 0

  In __get_perf_callchain_kernel():
    perf_callchain_store_context() stores PERF_CONTEXT_KERNEL marker
      -> entry->nr becomes 1, ctx->nr still 0
    perf_callchain_kernel() stores N kernel frames
      -> entry->nr becomes 1+N, ctx->nr becomes N

  In __get_perf_callchain_user():
    perf_callchain_store_context() stores PERF_CONTEXT_USER marker
      -> entry->nr becomes 2+N, ctx->nr still N
    start_entry_idx = ctx->nr assigns N (should be 2+N)
    fixup_uretprobe_trampoline_entries() scans from wrong index

This causes fixup_uretprobe_trampoline_entries() to scan kernel
callchain entries instead of user callchain entries, missing the
uretprobe trampolines that need to be fixed up.

Should this use ctx->entry->nr instead of ctx->nr?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19211481431

--===============0591375349055705727==--

