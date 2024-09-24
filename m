Return-Path: <bpf+bounces-40263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8539849F4
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F711C22B2D
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364161ABED1;
	Tue, 24 Sep 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="e/a1jRUb"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4E1AAE39;
	Tue, 24 Sep 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196378; cv=none; b=dULt036LLg3egK1LC6wAI8fIbJH27SAoq62tzY0Sj9hgaGTxzp+6dxs7sDaSmA+eh+DH8dTGGAZxl+pWXKE+JIHVcPx4TjkKk8n7J49FRxD2UPBEK8XMxfKbkylNYCJHCNKbr4J7njxbQdL4xthAgBkAieSZdTArSXczVoWtce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196378; c=relaxed/simple;
	bh=ojARksjer35/xv8IIdbyLRrk0/CVkX7KcYV+wb/kQE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5Hq0nqtRFTkYOkZYLdv84fk6oo47QyxnjUKgZHGJ6jiNIkKcCG5uhLODenqcCVKbVbFoBfISfQTMZPKQQLdREl6fFuUsq6pPDNwNcWHBMd2h+Tl8HchlmkgcYPWTm/JJlsErHHyqMUdWErr2jiASz5CNJV2UHoJ4nvienV6heI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=e/a1jRUb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yRil3Ks0WNUcjIepcvt5HXYk3DsTBQppYF7FZg8gEIA=; b=e/a1jRUbqM5E+ASZ3zKhYnmv/0
	HYU9q7/fuHZ2gN5NpzPolyXSO5dDjo223das/lir4BW3Q1ISuYqnrk2KEWZROzlQuT4MQ/NaXyp1O
	Le6V/ooXVGOu6mLBbAESaWKdHMLF1xpOBF647Ns5D9gRbMFPQoQaZ3YUyqCiqT4msF4l7K1O1nFge
	DuZbfRsyCx2oLkGseQoEcSBJWrV6XPXlkc0CN7neWhXNCHq/wIj0aoeGzJlcgnJHLoe8hXOPnl9cM
	dGUc15MfF7wSmBXbf4O8amYStc6uppxNf7z3LL6vQLKCTkKEpO+ZDZB92W8EbFr6bUHJWZwnDli8c
	3aJ4l+Rg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1st8g0-00031P-Qr; Tue, 24 Sep 2024 18:46:12 +0200
Received: from [178.197.249.54] (helo=[192.168.1.114])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1st8g0-0006vS-0x;
	Tue, 24 Sep 2024 18:46:11 +0200
Message-ID: <a22858d6-1676-4429-b617-86191e44cb65@iogearbox.net>
Date: Tue, 24 Sep 2024 18:46:10 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: use raw_spinlock_t in ringbuf
To: Wander Lairson Costa <wander@redhat.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "open list:BPF [RINGBUF]"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Wander Lairson Costa <wander.lairson@gmail.com>,
 Brian Grech <bgrech@redhat.com>
References: <20240920190700.617253-1-wander@redhat.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20240920190700.617253-1-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27408/Tue Sep 24 10:34:28 2024)

On 9/20/24 9:06 PM, Wander Lairson Costa wrote:
> From: Wander Lairson Costa <wander.lairson@gmail.com>
>
> The function __bpf_ringbuf_reserve is invoked from a tracepoint, which
> disables preemption. Using spinlock_t in this context can lead to a
> "sleep in atomic" warning in the RT variant. This issue is illustrated
> in the example below:
>
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 556208, name: test_progs
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 1
> INFO: lockdep is turned off.
> Preemption disabled at:
> [<ffffd33a5c88ea44>] migrate_enable+0xc0/0x39c
> CPU: 7 PID: 556208 Comm: test_progs Tainted: G
> Hardware name: Qualcomm SA8775P Ride (DT)
> Call trace:
>   dump_backtrace+0xac/0x130
>   show_stack+0x1c/0x30
>   dump_stack_lvl+0xac/0xe8
>   dump_stack+0x18/0x30
>   __might_resched+0x3bc/0x4fc
>   rt_spin_lock+0x8c/0x1a4
>   __bpf_ringbuf_reserve+0xc4/0x254
>   bpf_ringbuf_reserve_dynptr+0x5c/0xdc
>   bpf_prog_ac3d15160d62622a_test_read_write+0x104/0x238
>   trace_call_bpf+0x238/0x774
>   perf_call_bpf_enter.isra.0+0x104/0x194
>   perf_syscall_enter+0x2f8/0x510
>   trace_sys_enter+0x39c/0x564
>   syscall_trace_enter+0x220/0x3c0
>   do_el0_svc+0x138/0x1dc
>   el0_svc+0x54/0x130
>   el0t_64_sync_handler+0x134/0x150
>   el0t_64_sync+0x17c/0x180
>
> Switch the spinlock to raw_spinlock_t to avoid this error.
>
> Signed-off-by: Wander Lairson Costa <wander.lairson@gmail.com>
> Reported-by: Brian Grech <bgrech@redhat.com>
> Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Fix is for bpf tree, lgtm:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

