Return-Path: <bpf+bounces-77306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD54CD6F6E
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 20:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6318E307D412
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183E327C09;
	Mon, 22 Dec 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJsPyZi2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D613254B6
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431634; cv=none; b=Pbq7EIXp09DaZbnVtHbpawmi5+XqZfWothGwp8y9/ZrFz9AvsQjDTr54bklbUukxQdyhNpG0vJa0U7V4dfc80iH5AhKlFXZaa4L1KKospYTMhgulncp2iyWQaccl3epOtjXt/pThtzRLSuxnjD3lgF/CIDtnMhjuKsA/z+Xkchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431634; c=relaxed/simple;
	bh=5DsStJscODRn8CJfsEvTQknWQmTrnCn5xTBfZnA7fAg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bc6Z7zULblycmKvped56G0JOncBH3TwZUOuKiSEj89HcFPV2uAlf7idvKYDOrAd/68hHtgRGtYFhH6sr1U3H+uDPlAJuJvS8lxqO34GmDzVpEuxIaOvt2rMump9e+v1RIO75oXzkrAHwZYstJ4i+H9nexCOq8JAANC37ugYJ80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJsPyZi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB2DC116D0;
	Mon, 22 Dec 2025 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431633;
	bh=5DsStJscODRn8CJfsEvTQknWQmTrnCn5xTBfZnA7fAg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dJsPyZi2FyQ+D6hqG99R+mRYErH9/WwHi5gLm7cKP7LPc5jHQ1eKiFCaN93ORKjlO
	 oufncQeqKx9vejHW/5yiluAc3Pi4PgJM3FoME0CTc6KCOA9VrycprpXgk7pH64A3W9
	 SYoifcuJpc4VUXXJNFH5wPJm8gScG99biNgaCYG4kfkxFU2wjZ1TxaX6hOMWYD9AyF
	 qWPObaHbof3gE+kdGkecsaq/E7bLXShE1ribmM0dXh7X72Xd6E1KnsKtvi2zb5n2KG
	 qTOfrDaJ5TKQzSNRMBkWSsw/FvazcBz39EMo8yaFRUjdLGcURN58tos0zaAnL0aNc0
	 ot6ttHNcx9Q4Q==
Content-Type: multipart/mixed; boundary="===============0892836612000819908=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc0a81fe1debcd43ec9bdb440695bdf6d443a02080229dc1a2b60fa0eed00d18@mail.kernel.org>
In-Reply-To: <20251222190815.4112944-4-puranjay@kernel.org>
References: <20251222190815.4112944-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v7 3/4] bpf: arena: make arena kfuncs any context safe
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Dec 2025 19:27:13 +0000 (UTC)

--===============0892836612000819908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 128efb68d47b..55d1e15725c7 100644

[ ... ]

> +static void arena_free_worker(struct work_struct *work)
> +{
> +	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
> +	struct llist_node *list, *pos, *t;
> +	struct arena_free_span *s;
> +	u64 arena_vm_start, user_vm_start;
> +	struct llist_head free_pages;
> +	struct page *page;
> +	unsigned long full_uaddr;
> +	long kaddr, page_cnt, pgoff;
> +	unsigned long flags;
> +
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
> +		schedule_work(work);
> +		return;
> +	}
> +
> +	init_llist_head(&free_pages);
> +	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
> +	user_vm_start = bpf_arena_get_user_vm_start(arena);
> +
> +	list = llist_del_all(&arena->free_spans);
> +	llist_for_each(pos, list) {
> +		s = llist_entry(pos, struct arena_free_span, node);
> +		page_cnt = s->page_cnt;
> +		kaddr = arena_vm_start + s->uaddr;
> +		pgoff = compute_pgoff(arena, s->uaddr);
> +
> +		/* clear ptes and collect pages in free_pages llist */
> +		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
> +					     apply_range_clear_cb, &free_pages);
> +
> +		range_tree_set(&arena->rt, pgoff, page_cnt);
> +	}
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +
> +	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
> +	llist_for_each_safe(pos, t, list) {
> +		s = llist_entry(pos, struct arena_free_span, node);
> +		page_cnt = s->page_cnt;
> +		full_uaddr = user_vm_start + s->uaddr;
                          ^^^^^^^^^^^^^^^^^^^^^^^

Is there a missing clear_lo32() call here? In arena_free_pages() the
sleepable path computes full_uaddr as:

    full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;

But arena_free_worker() computes it as:

    full_uaddr = user_vm_start + s->uaddr;

Since s->uaddr is already the lower 32 bits (set from masked uaddr in
arena_free_pages()), and user_vm_start includes its own lower 32 bits,
this appears to produce the wrong address. For example, if user_vm_start
is 0x7f7d26200000 and s->uaddr is 0x26200000, this would give
0x7f7d4c400000 instead of the correct 0x7f7d26200000.

Should this be:

    full_uaddr = clear_lo32(user_vm_start) + s->uaddr;

to match the sleepable path?

> +		kaddr = arena_vm_start + s->uaddr;
> +
> +		/* ensure no stale TLB entries */
> +		flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
> +
> +		/* remove pages from user vmas */
> +		zap_pages(arena, full_uaddr, page_cnt);
> +
> +		kfree_nolock(s);
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20441598118

--===============0892836612000819908==--

