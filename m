Return-Path: <bpf+bounces-70718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB15BCB936
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 05:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CC51A62AA8
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 03:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF126B74D;
	Fri, 10 Oct 2025 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rJFLhW2+"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303193D76
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067814; cv=none; b=N2wXLEru8ZHw/GMhcVtRJtGSM6fmW3iTvzU5zwXfw/r7HqQLTQKvqRqfR4lwHVL2uCBRl2XuDnycrof+RYHXf9Akwfks/VIfpF2PKr3AcPeAQ/cenHtB2jzmChkxU7MfAAYIVVcrQlIq1e/8jE59IKQUtRiwhUDnYsFac2IvYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067814; c=relaxed/simple;
	bh=S33GuI5ePjbs9XU1BF1JFvUbgLWnZfxV9bbkj3QH0AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trGCvxHfMkhJMrjDoIYWKjrogDfh2wJe2G58zpzIuZwpmws9LFPK3DtedLAfbeb6k7gzuMqUmua+nGkU9PnxLMGwZAlGuf7WcObfuGNTlyB225Aj2RzNzLzqDzRVMchbNkeiv6HSLwtCB73ZlNO98CC5MBwZ36mMw+99Id+yh2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rJFLhW2+; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba3c0f8c-98b3-4529-9752-a5db2067e235@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760067800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IgaGdxVuR2BvnUbv+TzYCHJSzVW2EPTyhuT4ru1yDs4=;
	b=rJFLhW2+thT189APrcydXk2X62lhfwIutaL8nDuN/uZZcjJEazZ9v52MbUJJSIivT4OJYm
	ntLAAbv1n7PArmq+aPZwviq4fdldNG+8+geozapd0q9F9MhOykoYbJ7C5H1Mzrx4sG04wm
	6JnVpJczOgpvyrlLNKYYz20lS7IdmAo=
Date: Thu, 9 Oct 2025 20:43:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: test_run: Fix timer mode initialization to
 NO_MIGRATE mode
Content-Language: en-GB
To: Brahmajit Das <listout@listout.xyz>,
 d0fdced7-a9a5-473e-991f-4f5e4c13f616@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 chandna.linuxkernel@gmail.com, daniel@iogearbox.net,
 david.hunter.linux@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, khalid@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, skhan@linuxfoundation.org, song@kernel.org,
 syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
References: <lm4q7sgtfqabpuzkr73fz7xx7jinhwpwtdnhafoknngqvpduyn@srhrp6cnmnza>
 <z5vpeaow6kyr4uamfqlev7yxbfpr333ngws6tgjnuyjqaznfcr@vn4ihodpiwhz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <z5vpeaow6kyr4uamfqlev7yxbfpr333ngws6tgjnuyjqaznfcr@vn4ihodpiwhz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/9/25 4:10 PM, Brahmajit Das wrote:
> On 10.10.2025 04:20, Brahmajit Das wrote:
>> Yonghong Song,
>>
>>> So I suspect that we can remove NO_PREEMPT/NO_MIGRATE in test_run.c
>>> and use migrate_disable()/migrate_enable() universally.
>> Would something like this work?
>>
> Or we can do something like this to completely remove
> NO_PREEMPT/NO_MIGRATE.
>
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -29,7 +29,6 @@
>   #include <trace/events/bpf_test_run.h>
>
>   struct bpf_test_timer {
> -       enum { NO_PREEMPT, NO_MIGRATE } mode;
>          u32 i;
>          u64 time_start, time_spent;
>   };
> @@ -38,10 +37,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer *t)
>          __acquires(rcu)
>   {
>          rcu_read_lock();
> -       if (t->mode == NO_PREEMPT)
> -               preempt_disable();
> -       else
> -               migrate_disable();
> +       migrate_disable();
>
>          t->time_start = ktime_get_ns();
>   }
> @@ -51,10 +47,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
>   {
>          t->time_start = 0;
>
> -       if (t->mode == NO_PREEMPT)
> -               preempt_enable();
> -       else
> -               migrate_enable();
> +       migrate_enable();
>          rcu_read_unlock();
>   }
>
> @@ -374,7 +367,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
>
>   {
>          struct xdp_test_data xdp = { .batch_size = batch_size };
> -       struct bpf_test_timer t = { .mode = NO_MIGRATE };
> +       struct bpf_test_timer t = {};
>          int ret;
>
>          if (!repeat)
> @@ -404,7 +397,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
>          struct bpf_prog_array_item item = {.prog = prog};
>          struct bpf_run_ctx *old_ctx;
>          struct bpf_cg_run_ctx run_ctx;
> -       struct bpf_test_timer t = { NO_MIGRATE };
> +       struct bpf_test_timer t = {};
>          enum bpf_cgroup_storage_type stype;
>          int ret;
>
> @@ -1377,7 +1370,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>                                       const union bpf_attr *kattr,
>                                       union bpf_attr __user *uattr)
>   {
> -       struct bpf_test_timer t = { NO_PREEMPT };
> +       struct bpf_test_timer t = {};
>          u32 size = kattr->test.data_size_in;
>          struct bpf_flow_dissector ctx = {};
>          u32 repeat = kattr->test.repeat;
> @@ -1445,7 +1438,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>   int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
>                                  union bpf_attr __user *uattr)
>   {
> -       struct bpf_test_timer t = { NO_PREEMPT };
> +       struct bpf_test_timer t = {};
>          struct bpf_prog_array *progs = NULL;
>          struct bpf_sk_lookup_kern ctx = {};
>          u32 repeat = kattr->test.repeat;
>
> Basically RFC. I posted a patch, wasn't aware that work was already
> going on.

The above sounds good to me.We should remove enum { NO_PREEMPT, NO_MIGRATE } mode;
in struct bpf_test_timer.



