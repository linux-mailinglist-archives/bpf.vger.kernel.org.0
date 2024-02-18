Return-Path: <bpf+bounces-22224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F3859536
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 08:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C757D1F21A72
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CEAF9F4;
	Sun, 18 Feb 2024 07:13:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9690F9CF
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708240414; cv=none; b=LxHtYj6VUmdv/8JIu3Jh5D3E9zV7k/PuMcH38yQJhZTaj59o5LnwW1ihdtxjP+uDK2qeMJUP7idNm8mU+XuEsM+qdV8Tc1fxyRtrL+uITmxw77LGn7iU19jCJsAsOPUFibSQiZxIjf9WEmx+BPcH/2nYkmydxPqRqcdHZBf5Ye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708240414; c=relaxed/simple;
	bh=p9c2cUQkMK5oHvqqwJDwipTkqK9LAM/M1b1hMRyaTAU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pkZD7x76WejNLXNLm2su5JWKIPLvVmWvXGCdqeYyzs+gq5O0+vpdN0dxprLQfmv66gbk7ffwYKJSyOHGAjzoNdgBOLhnw+hTQIXWuW+fkP3e2ptRaCvwTlo4JeW0Qd7niYS8zas7mXRMSbW2KRYawID0P6Oi5Ef+YpqJgVraWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tcxhy4NSYz4f3jZS
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 15:13:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AD6891A0E47
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 15:13:25 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDn7W8SrtFl6qO8EQ--.6245S2;
	Sun, 18 Feb 2024 15:13:25 +0800 (CST)
Subject: Re: [PATCH bpf 1/2] bpf: Fix racing between bpf_timer_cancel_and_free
 and bpf_timer_cancel
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20240215211218.990808-1-martin.lau@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3223f558-9bd4-a6bf-4182-3e682d7c7c4c@huaweicloud.com>
Date: Sun, 18 Feb 2024 15:13:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240215211218.990808-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDn7W8SrtFl6qO8EQ--.6245S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWruF13trWUAF1xurW3KFg_yoW8Ar13pF
	4xta4xCr1UZrsYywn7X3WkWa4rK39ruw17Gr1rGFWUuF9xurZ3tFyj9F43WFW3W3ZavF42
	yr4kA3s5Jr1UZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 2/16/2024 5:12 AM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> The following race is possible between bpf_timer_cancel_and_free
> and bpf_timer_cancel. It will lead a UAF on the timer->timer.
>
> bpf_timer_cancel();
> 	spin_lock();
> 	t = timer->time;
> 	spin_unlock();
>
> 					bpf_timer_cancel_and_free();
> 						spin_lock();
> 						t = timer->timer;
> 						timer->timer = NULL;
> 						spin_unlock();
> 						hrtimer_cancel(&t->timer);
> 						kfree(t);
>
> 	/* UAF on t */
> 	hrtimer_cancel(&t->timer);
>
> In bpf_timer_cancel_and_free, this patch frees the timer->timer
> after a rcu grace period. This requires a rcu_head addition
> to the "struct bpf_hrtimer". Another kfree(t) happens in bpf_timer_init,
> this does not need a kfree_rcu because it is still under the
> spin_lock and timer->timer has not been visible by others yet.
>
> In bpf_timer_cancel, rcu_read_lock() is added because this helper
> can be used in a non rcu critical section context (e.g. from
> a sleepable bpf prog). Other timer->timer usages in helpers.c
> have been audited, bpf_timer_cancel() is the only place where
> timer->timer is used outside of the spin_lock.
>
> Another solution considered is to mark a t->flag in bpf_timer_cancel
> and clear it after hrtimer_cancel() is done.  In bpf_timer_cancel_and_free,
> it busy waits for the flag to be cleared before kfree(t). This patch
> goes with a straight forward solution and frees timer->timer after
> a rcu grace period.
>
> Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Hou Tao <houtao1@huawei.com>


