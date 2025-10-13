Return-Path: <bpf+bounces-70836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 988D0BD6063
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 22:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E1BA4EB64E
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162802DC772;
	Mon, 13 Oct 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="mI54anQi"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4561E32CF;
	Mon, 13 Oct 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385703; cv=none; b=nLslYE1gnQZuMdVJF8K+UegtSGjlNmeuH+AHya3UU2uhMCYcrKfc+PZTZQxTXB8RhTUN6wuoyTKpwOLOQAcJorDgsNKcKiJBzpAe/Mwb9tbSTWbcBQIRdgtJ82pbtnbcaPZgynLqxVwDlGVu21xjO2iT2SyBZwCDcL27oisDbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385703; c=relaxed/simple;
	bh=m+BkOeQ+wHK1cV+hLMbkMAa63wPhO6d/zPQoLBqGtWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRqXNP4rnQyDc7aSe4bBoIlkDDdJ2JFNNbv/1XhpVqhyU/q+6NbenjN2ZGDajUJqJdLkikeWp3Hk/bohA1lmQQRO/dcjq9+nvnxVXUOviVv9p7iL6ZXR5dmCMCmH2wM+hbe3OSJaij+t7ioDLiucpP5h7zqGByQWZOilX+igxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=mI54anQi; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4clpC5213Lz9tNm;
	Mon, 13 Oct 2025 22:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760385697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bI+xaoZurbn7ioJ+XeyHP8AcOBKxrNZnWgnc6mYFR8o=;
	b=mI54anQi8S3aS8CxjovLgGYQ0SZF2P/b3Q++dQC7YSxsP1vLro7A8TVGIREIQSs3Osmjz6
	2Mks+sXK+XK4wXHcdREIAKx/nf7jUrHbOCSHEoBJzMdNAC7QtPANZ9DG7P4sTBSEN9pfiH
	4M7/6TBgG5jq4uFu4MXydwtxbH63874YXb905zJ0A5zt/oVlgpzCgjU6+b/mmyPdC10MYY
	Smiw5qGNEV8b9Gqr3A5PP2eFwPkpk9KZO5IFcPr8BP25rgOp5mQWLqK6WwTV6I7vzOZbHd
	FssYO/zU1HY30TaIMZtDTfQO1O74Lrd6g4GNOFMogOXhx4HUURGgAVqIjAgqVg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
Date: Tue, 14 Oct 2025 01:31:28 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Sahil Chandna <chandna.linuxkernel@gmail.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, david.hunter.linux@gmail.com, skhan@linuxfoundation.org, 
	khalid@kernel.org
Subject: Re: [PATCH v3] bpf: test_run: fix atomic context in timer path
 causing sleep-in-atomic BUG
Message-ID: <u63lefbfseajkacl5uixafvvtlcwnpypxwqnrbgc5ec5c3tciy@prxb2yriebfy>
References: <20251013171104.493153-1-chandna.linuxkernel@gmail.com>
 <b7fa9c76-f343-42d0-9c47-6a1af0deea2c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7fa9c76-f343-42d0-9c47-6a1af0deea2c@linux.dev>
X-Rspamd-Queue-Id: 4clpC5213Lz9tNm

On 13.10.2025 11:35, Yonghong Song wrote:
> 
> 
> On 10/13/25 10:11 AM, Sahil Chandna wrote:
> > The timer mode is initialized to NO_PREEMPT mode by default,
> > this disable preemption and force execution in atomic context
> > causing issue on PREEMPT_RT configurations when invoking
> > spin_lock_bh(), leading to the following warning:
> > 
> > BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
> > preempt_count: 1, expected: 0
> > RCU nest depth: 1, expected: 1
> > Preemption disabled at:
> > [<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42
> > 
> > Fix this, by removing NO_PREEMPT/NO_MIGRATE mode check.
> > Also, the test timer context no longer needs explicit calls to
> > migrate_disable()/migrate_enable() with rcu_read_lock()/rcu_read_unlock().
> > Use helpers rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate()
> > instead.
> > 
> > Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
> > Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> > Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
> 
> You have multiple versions in CI:
>   [PATCH v2] bpf: avoid sleeping in invalid context during sock_map_delete_elem path
>   [PATCH v3] bpf: test_run: fix atomic context in timer path causing sleep-in-atomic BUG
Yeah, my bad. The v2 is mine, which I send few mins before Sahil

https://lore.kernel.org/all/20251013171122.1403859-1-listout@listout.xyz/T/
> 
> In the future, please submit new patch set only after some reviews on the old patch.
> 
> I also recommend to replace e.g. [PATCH v3] to [PATCH bpf v3] (or [PATCH bpf-next v3])
> so CI can do proper testing for either bpf or bpf-next.
> 
> For the title:
>   bpf: test_run: fix atomic context in timer path causing sleep-in-atomic BUG
> Change to:
>   bpf: Fix sleep-in-atomic BUG in timer path with RT kernel
> 
> The code change LGTM.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
> > 
> > ---
> > Changes since v2:
> > - Fix uninitialized struct bpf_test_timer
> > 
> > Changes since v1:
> > - Dropped `enum { NO_PREEMPT, NO_MIGRATE } mode` from `struct bpf_test_timer`.
> > - Removed all conditional preempt/migrate disable logic.
> > - Unified timer handling to use `migrate_disable()` / `migrate_enable()` universally.
> > 
> > Link to v2: https://lore.kernel.org/all/20251010075923.408195-1-chandna.linuxkernel@gmail.com/
> > Link to v1: https://lore.kernel.org/all/20251006054320.159321-1-chandna.linuxkernel@gmail.com/
> > 
> > Testing:
> > - Reproduced syzbot bug locally using the provided reproducer.
> > - Observed `BUG: sleeping function called from invalid context` on v1.
> > - Confirmed bug disappears after applying this patch.
> > - Validated normal functionality of `bpf_prog_test_run_*` helpers with C
> >    reproducer.
> > ---
> >   net/bpf/test_run.c | 23 ++++++-----------------
> >   1 file changed, 6 insertions(+), 17 deletions(-)
> 
> [...]
> 

-- 
Regards,
listout

