Return-Path: <bpf+bounces-70748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2AFBCDCBE
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 977B54E4AC7
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7D92F90DB;
	Fri, 10 Oct 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MJ8CHehq"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FA235044
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110107; cv=none; b=lyUO4fT9NwVKeanaS3PD3aiSL6NmEYmR3m4MMkxtgQlXOZ35iXBMwQbDpkLk+R0XEJk/fRb82G/gADAUOKWsNJZV07gBEvYGopQt04Oepx5L9ejVPADSe+ng4ji2xJbihZd3ulLgOrHIECJ4JAQvSGo6/grGs++wMEVKip1U2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110107; c=relaxed/simple;
	bh=YiIOv1FrYRHAOigDer5NhDZfgGWnuEe3aZ1JEt1bh68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKdamC5z6Y2LaABsy7sqI/bYryC+4ca8A8uKb2DueAGgahNeAI5dIF3BeBgsmSFfjJlpGJzYOaXBAtJs0bPd4/iuD1Oeh+ZldoJgMr08QRvwQ33kvEImt9ZubMER8BC2OI3d68GcgrZd4D9DgG47QR9YeymYCDeW961vRWEgTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MJ8CHehq; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb3b5d30-d232-4eb8-af31-2a1518ed8966@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760110093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8gKcoOaYYdHXMbG9Fq/8pPdJ3EoFkEGz2jidWyUbww=;
	b=MJ8CHehqhqPZ/TlpiHIHzCAq5xmszw+OLW1wu7/qt2FN4p/jZZfC3vJcQFqVridBTRFT9G
	LkmgnIoLYoJDby9NyK4FQNGPVG7SleY6sojFdC1QosRG1ZfPYnh9iqcHQagzjdIqbtvmNr
	zY1m1N7w5oI2SBSCyWK5XYj/07UDnl0=
Date: Fri, 10 Oct 2025 08:28:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf: test_run: Use migrate_enable()/disable()
 universally
Content-Language: en-GB
To: Sahil Chandna <chandna.linuxkernel@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, john.fastabend@gmail.com, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 khalid@kernel.org, syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
References: <20251010075923.408195-1-chandna.linuxkernel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251010075923.408195-1-chandna.linuxkernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/10/25 12:59 AM, Sahil Chandna wrote:
> The timer context can safely use migrate_disable()/migrate_enable()
> universally instead of conditional preemption or migration disabling.
> Previously, the timer was initialized in NO_PREEMPT mode by default,
> which disabled preemption and forced execution in atomic context.
> This caused issues on PREEMPT_RT configurations when invoking
> spin_lock_bh() — a sleeping lock — leading to the following warning:
>
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 1
> Preemption disabled at:
> [<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42
>
> Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
> Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
>
> ---
> Link to v1: https://lore.kernel.org/all/20251006054320.159321-1-chandna.linuxkernel@gmail.com/
>
> Changes since v1:
> - Dropped `enum { NO_PREEMPT, NO_MIGRATE } mode` from `struct bpf_test_timer`.
> - Removed all conditional preempt/migrate disable logic.
> - Unified timer handling to use `migrate_disable()` / `migrate_enable()` universally.
>
> Testing:
> - Reproduced syzbot bug locally using the provided reproducer.
> - Observed `BUG: sleeping function called from invalid context` on v1.
> - Confirmed bug disappears after applying this patch.
> - Validated normal functionality of `bpf_prog_test_run_*` helpers with C
>    reproducer.
> ---
>   net/bpf/test_run.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index dfb03ee0bb62..b23bc93e738e 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -29,7 +29,6 @@
>   #include <trace/events/bpf_test_run.h>
>   
>   struct bpf_test_timer {
> -	enum { NO_PREEMPT, NO_MIGRATE } mode;
>   	u32 i;
>   	u64 time_start, time_spent;
>   };
> @@ -38,10 +37,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer *t)
>   	__acquires(rcu)
>   {
>   	rcu_read_lock();
> -	if (t->mode == NO_PREEMPT)
> -		preempt_disable();
> -	else
> -		migrate_disable();
> +	migrate_disable();
>   
>   	t->time_start = ktime_get_ns();
>   }
> @@ -50,11 +46,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
>   	__releases(rcu)
>   {
>   	t->time_start = 0;
> -
> -	if (t->mode == NO_PREEMPT)
> -		preempt_enable();
> -	else
> -		migrate_enable();
> +	migrate_enable();
>   	rcu_read_unlock();
>   }
>   
> @@ -374,7 +366,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
>   
>   {
>   	struct xdp_test_data xdp = { .batch_size = batch_size };
> -	struct bpf_test_timer t = { .mode = NO_MIGRATE };
> +	struct bpf_test_timer t;

We still need to initialize 'struct bpf_test_timer t' with t.time_spent = 0 like
	struct bpf_test_timer t = {};
since time_spent is used like
         t->time_spent += ktime_get_ns() - t->time_start;


>   	int ret;
>   
>   	if (!repeat)
> @@ -404,7 +396,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
>   	struct bpf_prog_array_item item = {.prog = prog};
>   	struct bpf_run_ctx *old_ctx;
>   	struct bpf_cg_run_ctx run_ctx;
> -	struct bpf_test_timer t = { NO_MIGRATE };
> +	struct bpf_test_timer t;
>   	enum bpf_cgroup_storage_type stype;
>   	int ret;
>   
> @@ -1377,7 +1369,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>   				     const union bpf_attr *kattr,
>   				     union bpf_attr __user *uattr)
>   {
> -	struct bpf_test_timer t = { NO_PREEMPT };
> +	struct bpf_test_timer t;
>   	u32 size = kattr->test.data_size_in;
>   	struct bpf_flow_dissector ctx = {};
>   	u32 repeat = kattr->test.repeat;
> @@ -1445,7 +1437,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>   int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
>   				union bpf_attr __user *uattr)
>   {
> -	struct bpf_test_timer t = { NO_PREEMPT };
> +	struct bpf_test_timer t;
>   	struct bpf_prog_array *progs = NULL;
>   	struct bpf_sk_lookup_kern ctx = {};
>   	u32 repeat = kattr->test.repeat;


