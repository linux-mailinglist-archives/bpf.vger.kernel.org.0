Return-Path: <bpf+bounces-15882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DAD7F97D7
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 04:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DC41C208D1
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A82A20F7;
	Mon, 27 Nov 2023 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C285C186
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 19:07:50 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sdr9p6MKVz4f3lVk
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:07:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4D3441A0DA5
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:07:47 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAHHbv_B2Rl_VwPCA--.40506S2;
	Mon, 27 Nov 2023 11:07:47 +0800 (CST)
Subject: Re: [PATCH bpf v3 4/6] bpf: Optimize the free of inner map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20231124113033.503338-1-houtao@huaweicloud.com>
 <20231124113033.503338-5-houtao@huaweicloud.com>
 <CAADnVQJ8_QcisYsRVD1cz8PDHvDHzrtdHwmG21jCWogvaBQ9Lw@mail.gmail.com>
 <8609c9fc-5ca6-7884-2444-52a2d2650d74@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <56735468-916c-b755-2e48-fab5b0ffe79e@huaweicloud.com>
Date: Mon, 27 Nov 2023 11:07:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8609c9fc-5ca6-7884-2444-52a2d2650d74@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAHHbv_B2Rl_VwPCA--.40506S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4rWFWrXry7CF43XrykGrg_yoW5Cr48pF
	W8Kr4UGrWDJr18tr1DJw1UJryUJr4UJw1UJr18JFyUAr1UAryjqr1UXFWj9r15Jr4kJr1U
	tr1UJr1UZr1UAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi

On 11/27/2023 10:47 AM, Hou Tao wrote:
> Hi Alexei,
>
> On 11/27/2023 9:49 AM, Alexei Starovoitov wrote:
>> On Fri, Nov 24, 2023 at 3:29 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> When removing the inner map from the outer map, the inner map will be
>>> freed after one RCU grace period and one RCU tasks trace grace
>>> period, so it is certain that the bpf program, which may access the
>>> inner map, has exited before the inner map is freed.
>>>
>>> However there is unnecessary to wait for any RCU grace period, one RCU
>>> grace period or one RCU tasks trace grace period if the outer map is
>>> only accessed by userspace, sleepable program or non-sleepable program.
>>> So recording the sleepable attributes of the owned bpf programs when
>>> adding the outer map into env->used_maps, copying the recorded
>>> attributes to inner map atomically when removing inner map from the
>>> outer map and using the recorded attributes in the inner map to decide
>>> which, and how many, RCU grace periods are needed when freeing the
>>> inner map.
>>>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>

SNIP
>> I still think sleepable_refcnt and refcnt is more than enough to
>> optimize patch 3.
> Before posting v4,  do the following code-snippets match your suggestions ?
>
> resolve_pseudo_ldimm64()
>                         if (env->prog->aux->sleepable)
>                                /* The max number of program is INT_MAX -
> 1, so atomic_t will be enough */
>                                 atomic_inc(&map->sleepable_refcnt);
>
> bpf_map_fd_put_ptr()
>         if (deferred) {
>                 if (atomic_read(&map->sleepable_refcnt))
>                         WRITE_ONCE(map->free_after_tt_rcu_gp, true);
>                 else
>                         WRITE_ONCE(map->free_after_rcu_gp, true);
>         }
>
> bpf_map_put()
>                 if (READ_ONCE(map->free_after_tt_rcu_gp))
>                         call_rcu_tasks_trace(&map->rcu,
> bpf_map_free_mult_rcu_gp);
>                 else if (READ_ONCE(map->free_after_rcu_gp))
>                         call_rcu(&map->rcu, bpf_map_free_rcu_gp);
>                 else
>                         bpf_map_free_in_work(map);
>

Just find out the above code-snippet misses the corresponding
atomic_dec() for sleepable_refcnt. Could we replace sleepable_refcnt by
a bool (e.g, access_in_sleepable), so the check can be simplified further ?
> And are you OK with using call_rcu()/call_rcu_tasks_trace() instead of
> synchronize_rcu()/synchronize_rcu_mult() ?
>
> .


