Return-Path: <bpf+bounces-15509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C037F25E4
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 07:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781201C2173D
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D3171AB;
	Tue, 21 Nov 2023 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59175BB
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 22:45:36 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZFHs0llwz4f3lgP
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 14:45:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 520651A05AC
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 14:45:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCH1w0JUlxlenQPBg--.37035S2;
	Tue, 21 Nov 2023 14:45:33 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf v2 4/5] bpf: Optimize the free of inner map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20231113123324.3914612-1-houtao@huaweicloud.com>
 <20231113123324.3914612-5-houtao@huaweicloud.com>
 <20231121051917.lbp6luone7pxqkvw@macbook-pro-49.dhcp.thefacebook.com>
Message-ID: <96e07186-d497-8e41-edcd-a106bf87a548@huaweicloud.com>
Date: Tue, 21 Nov 2023 14:45:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231121051917.lbp6luone7pxqkvw@macbook-pro-49.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCH1w0JUlxlenQPBg--.37035S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWftw4kury5XFW7CF17ZFb_yoW5CF1DpF
	Z5Ja4UGr4qqrWj9395Xw4I9ryFvwsxW343Wwn5J345Ar9xury09r4IgFW3AFy5ZrZ7t3yI
	qryjy343JF4UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi Alexei,

On 11/21/2023 1:19 PM, Alexei Starovoitov wrote:
> On Mon, Nov 13, 2023 at 08:33:23PM +0800, Hou Tao wrote:
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index e2d2701ce2c45..5a7906f2b027e 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -694,12 +694,20 @@ static void bpf_map_free_deferred(struct work_struct *work)
>>  {
>>  	struct bpf_map *map = container_of(work, struct bpf_map, work);
>>  	struct btf_record *rec = map->record;
>> +	int acc_ctx;
>>  
>>  	security_bpf_map_free(map);
>>  	bpf_map_release_memcg(map);
>>  
>> -	if (READ_ONCE(map->free_after_mult_rcu_gp))
>> -		synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
> The previous patch 3 is doing too much.
> There is maybe_wait_bpf_programs() that will do synchronize_rcu()
> when necessary.
> The patch 3 could do synchronize_rcu_tasks_trace() only and it will solve the issue.

I didn't follow how synchronize_rcu() in maybe_wait_bpf_programs() will
help bpf_map_free_deferred() to defer the free of inner map. Could you
please elaborate on that ? In my understanding, bpf_map_update_value()
invokes maybe_wait_bpf_programs() after the deletion of old inner map
from outer map completes. If the ref-count of inner map in the outer map
is the last one, bpf_map_free_deferred() will be called when the
deletion completes, so maybe_wait_bpf_programs() will run concurrently
with bpf_map_free_deferred().
>
>> +	acc_ctx = atomic_read(&map->may_be_accessed_prog_ctx) & BPF_MAP_ACC_PROG_CTX_MASK;
>> +	if (acc_ctx) {
>> +		if (acc_ctx == BPF_MAP_ACC_NORMAL_PROG_CTX)
>> +			synchronize_rcu();
>> +		else if (acc_ctx == BPF_MAP_ACC_SLEEPABLE_PROG_CTX)
>> +			synchronize_rcu_tasks_trace();
>> +		else
>> +			synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
> and this patch 4 goes to far.
> Could you add sleepable_refcnt in addition to existing refcnt that is incremented
> in outer map when it's used by sleepable prog and when sleepable_refcnt > 0
> the caller of bpf_map_free_deferred sets free_after_mult_rcu_gp.
> (which should be renamed to free_after_tasks_rcu_gp).
> Patch 3 is simpler and patch 4 is simple too.
> No need for atomic_or games.
>
> In addition I'd like to see an extra patch that demonstrates this UAF
> when update/delete is done by syscall bpf prog type.
> The test case in patch 5 is doing update/delete from user space.

Do you mean update/delete operations on outer map, right ? Because in
patch 5, inner map is updated from bpf program instead of user space.
> If that was the only issue we could have easily extended maybe_wait_bpf_programs()
> to do synchronize_rcu_tasks_trace() and that would close the issue exposed by patch 5.
> But inner maps can indeed be updated by syscall bpf prog and since they run
> under rcu_read_lock_trace() we cannot add synchronize_rcu_tasks_trace() to
> maybe_wait_bpf_programs() because it will deadlock.
> So let's make sure we have test cases for all combinations where inner maps
> can be updated/deleted.


