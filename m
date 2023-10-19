Return-Path: <bpf+bounces-12634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A3E7CED2C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 03:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4981C20C5A
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067A3394;
	Thu, 19 Oct 2023 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98D38C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 01:07:17 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822C8128;
	Wed, 18 Oct 2023 18:07:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S9qLj5y8wz4f3l27;
	Thu, 19 Oct 2023 09:07:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3RdU7gTBlOLFZDQ--.58008S2;
	Thu, 19 Oct 2023 09:07:11 +0800 (CST)
Subject: Re: [PATCH bpf] Fold smp_mb__before_atomic() into
 atomic_set_release()
To: paulmck@kernel.org, bpf@vger.kernel.org
Cc: David Vernet <void@manifault.com>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
References: <ec86d38e-cfb4-44aa-8fdb-6c925922d93c@paulmck-laptop>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <722b64d7-281b-b4ab-4d4d-403abc41a36b@huaweicloud.com>
Date: Thu, 19 Oct 2023 09:07:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ec86d38e-cfb4-44aa-8fdb-6c925922d93c@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3RdU7gTBlOLFZDQ--.58008S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1rGFWUJFykuFyxWry7trb_yoWrGF4Upr
	48Kr4UtrWDXr48JwnrJw4UZ34fJr4DA345Gr45JFy8Zr1UKr4jvF18Xr4jgr15Jr4kGr1j
	yr1UWryqv34UJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

Hi Paul,

On 10/19/2023 6:28 AM, Paul E. McKenney wrote:
> bpf: Fold smp_mb__before_atomic() into atomic_set_release()
>
> The bpf_user_ringbuf_drain() BPF_CALL function uses an atomic_set()
> immediately preceded by smp_mb__before_atomic() so as to order storing
> of ring-buffer consumer and producer positions prior to the atomic_set()
> call's clearing of the ->busy flag, as follows:
>
>         smp_mb__before_atomic();
>         atomic_set(&rb->busy, 0);
>
> Although this works given current architectures and implementations, and
> given that this only needs to order prior writes against a later write.
> However, it does so by accident because the smp_mb__before_atomic()
> is only guaranteed to work with read-modify-write atomic operations,
> and not at all with things like atomic_set() and atomic_read().
>
> Note especially that smp_mb__before_atomic() will not, repeat *not*,
> order the prior write to "a" before the subsequent non-read-modify-write
> atomic read from "b", even on strongly ordered systems such as x86:
>
>         WRITE_ONCE(a, 1);
>         smp_mb__before_atomic();
>         r1 = atomic_read(&b);

The reason is smp_mb__before_atomic() is defined as noop and
atomic_read() in x86-64 is just READ_ONCE(), right ?

And it seems that I also used smp_mb__before_atomic() in a wrong way for
patch [1]. The memory order in the posted patch is

process X                                    process Y
    atomic64_dec_and_test(&map->usercnt)
    READ_ONCE(timer->timer)
                                            timer->time = t
                                            // it won't work
                                            smp_mb__before_atomic()
                                            atomic64_read(&map->usercnt)

For the problem, it seems I need to replace smp_mb__before_atomic() by
smp_mb() to fix the memory order, right ?

Regards,
Hou

[1]:
https://lore.kernel.org/bpf/20231017125717.241101-2-houtao@huaweicloud.com/
                                                                

>
> Therefore, replace the smp_mb__before_atomic() and atomic_set() with
> atomic_set_release() as follows:
>
>         atomic_set_release(&rb->busy, 0);
>
> This is no slower (and sometimes is faster) than the original, and also
> provides a formal guarantee of ordering that the original lacks.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: David Vernet <void@manifault.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: <bpf@vger.kernel.org>
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index f045fde632e5..0ee653a936ea 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -770,8 +770,7 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
>  	/* Prevent the clearing of the busy-bit from being reordered before the
>  	 * storing of any rb consumer or producer positions.
>  	 */
> -	smp_mb__before_atomic();
> -	atomic_set(&rb->busy, 0);
> +	atomic_set_release(&rb->busy, 0);
>  
>  	if (flags & BPF_RB_FORCE_WAKEUP)
>  		irq_work_queue(&rb->work);
>
> .


