Return-Path: <bpf+bounces-15884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E137F980A
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 04:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E59280DF4
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 03:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186646AC;
	Mon, 27 Nov 2023 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE0127
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 19:54:14 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SdsCM1pMHz4f3l2B
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:54:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A719F1A0476
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:54:11 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA3hgzfEmRlCQwzCA--.46550S2;
	Mon, 27 Nov 2023 11:54:11 +0800 (CST)
Subject: Re: [PATCH bpf v3 4/6] bpf: Optimize the free of inner map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231124113033.503338-1-houtao@huaweicloud.com>
 <20231124113033.503338-5-houtao@huaweicloud.com>
 <CAADnVQJ8_QcisYsRVD1cz8PDHvDHzrtdHwmG21jCWogvaBQ9Lw@mail.gmail.com>
 <8609c9fc-5ca6-7884-2444-52a2d2650d74@huaweicloud.com>
 <CAADnVQJ--ABTNboOPLUVH+Ae2Q5d-ii_4YEPxRGrB9mcP7FopQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <814e719f-5009-c885-5f29-3172765857a3@huaweicloud.com>
Date: Mon, 27 Nov 2023 11:54:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ--ABTNboOPLUVH+Ae2Q5d-ii_4YEPxRGrB9mcP7FopQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA3hgzfEmRlCQwzCA--.46550S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW3Ar17JF1fury3WryUZFb_yoW8uw1kpF
	WrtFW0kr4ktF4Iyr1qvw1xA34FyrZaq3yDXw10g34Yk3s8u34a9FWxKFW5uF98ur4kJ34I
	vryjv34rua1rAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/27/2023 11:20 AM, Alexei Starovoitov wrote:
> On Sun, Nov 26, 2023 at 6:47 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>
>> Before posting v4,  do the following code-snippets match your suggestions ?
>>
>> resolve_pseudo_ldimm64()
>>                         if (env->prog->aux->sleepable)
>>                                /* The max number of program is INT_MAX -
>> 1, so atomic_t will be enough */
>>                                 atomic_inc(&map->sleepable_refcnt);
>>
>> bpf_map_fd_put_ptr()
>>         if (deferred) {
>>                 if (atomic_read(&map->sleepable_refcnt))
>>                         WRITE_ONCE(map->free_after_tt_rcu_gp, true);
>>                 else
>>                         WRITE_ONCE(map->free_after_rcu_gp, true);
>>         }
> Yes. That was an idea and I hope you see that in this form it's
> much easier to understand, right?

Yes.
>
> and regarding your other question:
>
>> Could we replace sleepable_refcnt by
>> a bool (e.g, access_in_sleepable), so the check can be simplified further ?
> I think you're trying to optimize too soon.
> How would that bool access_in_sleepable work?
> Something needs to set it and the last sleepable to unset it.
> You might need a refcnt to do that.

Yes, a premature optimization. I only consider the case that one bpf map
will be only accessed by one bpf program and bpf program will always
exit after the inner map is deleted from outer map (so sleepable_refcnt
is still greater than zero when calling bpf_map_fd_put_ptr()). Will drop
the idea.
>
>> bpf_map_put()
>>                 if (READ_ONCE(map->free_after_tt_rcu_gp))
>>                         call_rcu_tasks_trace(&map->rcu,
>> bpf_map_free_mult_rcu_gp);
>>                 else if (READ_ONCE(map->free_after_rcu_gp))
>>                         call_rcu(&map->rcu, bpf_map_free_rcu_gp);
>>                 else
>>                         bpf_map_free_in_work(map);
>>
>> And are you OK with using call_rcu()/call_rcu_tasks_trace() instead of
>> synchronize_rcu()/synchronize_rcu_mult() ?
> Of course. Not sure what you meant by that.
> bpf_map_put() cannot call sync_rcu.
> Are you asking about doing queue_work first and then sync_rcu* inside?
> I think it will not scale compared to call_rcu approach.
> .

Yes, I mean the deferment implementation in v2 which calls sync_rcu()*
in kworker. Will still use call_rcu()* in v4. Thanks for all these
suggestions.


