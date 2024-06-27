Return-Path: <bpf+bounces-33216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A3B919D3D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 04:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159D4282444
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 02:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3023BE;
	Thu, 27 Jun 2024 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDTAIHEi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4CD51E;
	Thu, 27 Jun 2024 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455403; cv=none; b=o6SxNJ0JKvlHu6XOT/6owX6L/23l0aQuW/mNbD6BWOkq/ac0lEHvf6G7t8poWuO3e66rVZQgjpsBH229O3V6FTWN6nrGRXnMItLttaa2lxHAL8JU8GNAXeZ4QRT1L6ghRSikiYveGf/+vgH/KJ0yxtWKeXuWrVfkCqLHBNQaa2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455403; c=relaxed/simple;
	bh=yLoEUkzIdR2ynQVS/sAJoHQIrQ/7oTOkXayKVHubxEw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gDd1WM0cVv9ZBae1AVscN21dTW8MdkIQaXkaDZ2HS7y24RnUdUeoJIhCr/551dV6a+mTH+WxbOaIfbC3WeqFlMsjJYfFeZz8WmBGM7JHA17lJobiMZ65pOp+ndqTg1/5Ho1+Ub+xTyHJnteJxDHwQvdRGGNt4jkKnwj+o/SmlIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDTAIHEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BCAC116B1;
	Thu, 27 Jun 2024 02:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719455403;
	bh=yLoEUkzIdR2ynQVS/sAJoHQIrQ/7oTOkXayKVHubxEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UDTAIHEitL1yCCx4EoOND2jkD2AWNFAwJqHtcjRlXwB6AflLUXQrb3e1aSFD06Uit
	 X+BPLiW3Mw9VavuY9ZCn+jNt7cGBO4pg+T8EVs4XL4fDX5Doyk/NqOd1Zw7HwjbTvR
	 pNMO5TKbObbG6pNl4fVwQ2BykNN8qOXTDu/T7yXeoveLpDd15XfCF0T1zreReYBXHQ
	 B/uczRtHy6DbD7ilXJN+1WOFEtt9KbUTTHXGQwWe89TK2k+qYSCB0si2GMlMe9ZsG2
	 3fydiy5flX+rRVl1LoT8vbzppV5uVFhJ+MNtvi6bUd1z77OHleVdjH0JBiIy9kHCkN
	 vtxoZrqsnfihQ==
Date: Thu, 27 Jun 2024 11:29:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 oleg@redhat.com, peterz@infradead.org, mingo@redhat.com,
 bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-Id: <20240627112958.0e4aa22fe5a694a2feb11e06@kernel.org>
In-Reply-To: <20240625002144.3485799-5-andrii@kernel.org>
References: <20240625002144.3485799-1-andrii@kernel.org>
	<20240625002144.3485799-5-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 17:21:36 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Anyways, under exclusive writer lock, we double-check that refcount
> didn't change and is still zero. If it is, we proceed with destruction,
> because at that point we have a guarantee that find_active_uprobe()
> can't successfully look up this uprobe instance, as it's going to be
> removed in destructor under writer lock. If, on the other hand,
> find_active_uprobe() managed to bump refcount from zero to one in
> between put_uprobe()'s atomic_dec_and_test(&uprobe->ref) and
> write_lock(&uprobes_treelock), we'll deterministically detect this with
> extra atomic_read(&uprobe->ref) check, and if it doesn't hold, we
> pretend like atomic_dec_and_test() never returned true. There is no
> resource freeing or any other irreversible action taken up till this
> point, so we just exit early.
> 
> One tricky part in the above is actually two CPUs racing and dropping
> refcnt to zero, and then attempting to free resources. This can happen
> as follows:
>   - CPU #0 drops refcnt from 1 to 0, and proceeds to grab uprobes_treelock;
>   - before CPU #0 grabs a lock, CPU #1 updates refcnt as 0 -> 1 -> 0, at
>     which point it decides that it needs to free uprobe as well.
> 
> At this point both CPU #0 and CPU #1 will believe they need to destroy
> uprobe, which is obviously wrong. To prevent this situations, we augment
> refcount with epoch counter, which is always incremented by 1 on either
> get or put operation. This allows those two CPUs above to disambiguate
> who should actually free uprobe (it's the CPU #1, because it has
> up-to-date epoch). See comments in the code and note the specific values
> of UPROBE_REFCNT_GET and UPROBE_REFCNT_PUT constants. Keep in mind that
> a single atomi64_t is actually a two sort-of-independent 32-bit counters
> that are incremented/decremented with a single atomic_add_and_return()
> operation. Note also a small and extremely rare (and thus having no
> effect on performance) need to clear the highest bit every 2 billion
> get/put operations to prevent high 32-bit counter from "bleeding over"
> into lower 32-bit counter.

I have a question here.
Is there any chance to the CPU#1 to put the uprobe before CPU#0 gets
the uprobes_treelock, and free uprobe before CPU#0 validate uprobe->ref
again? e.g.

CPU#0							CPU#1

put_uprobe() {
	atomic64_add_return()
							__get_uprobe();
							put_uprobe() {
								kfree(uprobe)
							}
	write_lock(&uprobes_treelock);
	atomic64_read(&uprobe->ref);
}

I think it is very rare case, but I could not find any code to prevent
this scenario.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

