Return-Path: <bpf+bounces-74629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE0EC5FEC7
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3C754E5115
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950E2116F6;
	Sat, 15 Nov 2025 02:42:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626B1E5B78
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174526; cv=none; b=r5i7sRsSoer4T1UVkyK0K6Y8H7Yd/v6Zm1yu/+UXK2/5A8HuUSLa+m5D/lmpB9V0Ys6+3FUfYm2zuku0qzPM/kk2cY+t4UqPFnc4xDZWpcPCvd8kvij4FEl0uB3W8cGRjtye7QWk+1yP1C2iSv9W8dtxI2BXfUbgz4e+Gh5jPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174526; c=relaxed/simple;
	bh=N+0Guy2LFLpTnhFS4NAEeov8EFzcm93lKZL2pVB4lS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyeJ0+/HKCfacQFiySgROzyv16XJTYRGN6nT7kad9Ls+ycm3n3H7O3iIvJu/DbU26Leeq0N8xtt2ey51ULj/RppIBUGnBunb5zcTB/dLz8SxxqHqCNLodilIXv8G83htmUnEsX5b2JwJd5ZaUUVYLh2sAOjnTyPln/20oGBjF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d7dYt4QGjzKHMfF
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 10:41:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1AFEC1A0E70
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 10:42:00 +0800 (CST)
Received: from [10.67.108.204] (unknown [10.67.108.204])
	by APP2 (Coremail) with SMTP id Syh0CgDXM3p26BdpfuwkAw--.20113S2;
	Sat, 15 Nov 2025 10:41:59 +0800 (CST)
Message-ID: <2612eeec-8948-41d6-9d41-4f1ec813d514@huaweicloud.com>
Date: Sat, 15 Nov 2025 10:41:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Pu Lehui <pulehui@huawei.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
References: <20251110092536.4082324-1-pulehui@huaweicloud.com>
 <92ba87bbc6b11234be1925a4dc7262e11cd07305.camel@gmail.com>
 <CAADnVQ+2jdSD=HMMq3tKvu08gF49T=290LNzvc5LDOf4AycEuw@mail.gmail.com>
 <fb7f62db-4dc6-4614-a0c4-3b2a1904aadb@huawei.com>
 <CAADnVQLPJGPwx3CfgXBCZPHi_niGYTy+VFnyd50oNrDSkvyqPw@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAADnVQLPJGPwx3CfgXBCZPHi_niGYTy+VFnyd50oNrDSkvyqPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDXM3p26BdpfuwkAw--.20113S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1rKrWfGF4UKrW5Ww45KFg_yoWxCw47pF
	WDGa4xAay8Xr4DZr4Dtryxtr45tw1rWF18urWUG34FgF9Fqrn3Kr18CrWYkr15urZFkw10
	v3WjqrZxJ3y7Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/11/15 5:08, Alexei Starovoitov wrote:
> On Mon, Nov 10, 2025 at 7:20 PM Pu Lehui <pulehui@huawei.com> wrote:
>>
>>
>> On 2025/11/11 9:13, Alexei Starovoitov wrote:
>>> On Mon, Nov 10, 2025 at 12:36 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>
>>>> On Mon, 2025-11-10 at 09:25 +0000, Pu Lehui wrote:
>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>
>>>>> Syzkaller triggers an invalid memory access issue following fault
>>>>> injection in update_effective_progs. The issue can be described as
>>>>> follows:
>>>>>
>>>>> __cgroup_bpf_detach
>>>>>     update_effective_progs
>>>>>       compute_effective_progs
>>>>>         bpf_prog_array_alloc <-- fault inject
>>>>>     purge_effective_progs
>>>>>       /* change to dummy_bpf_prog */
>>>>>       array->items[index] = &dummy_bpf_prog.prog
>>>>>
>>>>> ---softirq start---
>>>>> __do_softirq
>>>>>     ...
>>>>>       __cgroup_bpf_run_filter_skb
>>>>>         __bpf_prog_run_save_cb
>>>>>           bpf_prog_run
>>>>>             stats = this_cpu_ptr(prog->stats)
>>>>>             /* invalid memory access */
>>>>>             flags = u64_stats_update_begin_irqsave(&stats->syncp)
>>>>> ---softirq end---
>>>>>
>>>>>     static_branch_dec(&cgroup_bpf_enabled_key[atype])
>>>>>
>>>>> The reason is that fault injection caused update_effective_progs to fail
>>>>> and then changed the original prog into dummy_bpf_prog.prog in
>>>>> purge_effective_progs. Then a softirq came, and accessing the stats of
>>>>> dummy_bpf_prog.prog in the softirq triggers invalid mem access.
>>>>>
>>>>> To fix it, we can use static per-cpu variable to initialize the stats
>>>>> of dummy_bpf_prog.prog.
>>>>>
>>>>> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
>>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>>> ---
>>>>
>>>> Hi Pu,
>>>>
>>>> Sorry for the delayed response. This patch looks good to me, but I
>>>> think that your argument about memory consumption makes total sense.
>>>> It might be the case that v1 is a better fix. Let's hear from Alexei.
>>>
>>
>> Hi Alexei,
>>
>>> I don't particularly like either v1 or v2.
>>> Runtime penalty to bpf_prog_run_array_cg() is not nice.
>>> Memory waste with __dummy_stats is not good as well.
>>
>> Indeed a trade-off between time and space before better solution.
>>
>>>
>>> Also v1 doesn't really fix it, since prog_array is
>>> used not only by cgroup.
>>> perf_event_detach_bpf_prog() does bpf_prog_array_delete_safe() too.
>>
>> I noticed that too, but before syncing to other parts of the
>> bpf_prog_array, I found there were some shotgun-style modifications, so
>> I switched to initializing per-cpu variables to minimize changes.
>>
>>>
>>> Another option is to add a runtime check to __bpf_prog_run()
>>> but it isn't great either.
>>
>> Yep, same runtime penalty, but simpler than v1 – will we use this to patch?
>>
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -712,11 +712,13 @@ static __always_inline u32 __bpf_prog_run(const
>> struct bpf_prog *prog,
>>                   ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
>>
>>                   duration = sched_clock() - start;
>> -               stats = this_cpu_ptr(prog->stats);
>> -               flags = u64_stats_update_begin_irqsave(&stats->syncp);
>> -               u64_stats_inc(&stats->cnt);
>> -               u64_stats_add(&stats->nsecs, duration);
>> -               u64_stats_update_end_irqrestore(&stats->syncp, flags);
>> +               if (likely(prog->stats)) {
>> +                       stats = this_cpu_ptr(prog->stats);
>> +                       flags =
>> u64_stats_update_begin_irqsave(&stats->syncp);
>> +                       u64_stats_inc(&stats->cnt);
>> +                       u64_stats_add(&stats->nsecs, duration);
>> +                       u64_stats_update_end_irqrestore(&stats->syncp,
>> flags);
>> +               }
> 
> Yeah. Let's do this. Pls submit it as a proper patch.

Hi Alexei,

How about making the stats update a callback function? That is, the 
dummy flow does nothing, while the others follow the normal process.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d808253f2e94..7bd784c58309 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1738,6 +1738,7 @@ struct bpf_prog {
  		u8 tag[BPF_TAG_SIZE];
  	};
  	struct bpf_prog_stats __percpu *stats;
+	void (*update_stats)(struct bpf_prog_stats __percpu *stats, u64 duration);
  	int __percpu		*active;
  	unsigned int		(*bpf_func)(const void *ctx,
  					    const struct bpf_insn *insn);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..eb2c464880fd 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -705,18 +705,12 @@ static __always_inline u32 __bpf_prog_run(const 
struct bpf_prog *prog,

  	cant_migrate();
  	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
-		struct bpf_prog_stats *stats;
  		u64 duration, start = sched_clock();
-		unsigned long flags;

  		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);

  		duration = sched_clock() - start;
-		stats = this_cpu_ptr(prog->stats);
-		flags = u64_stats_update_begin_irqsave(&stats->syncp);
-		u64_stats_inc(&stats->cnt);
-		u64_stats_add(&stats->nsecs, duration);
-		u64_stats_update_end_irqrestore(&stats->syncp, flags);
+		prog->update_stats(prog->stats, duration);
  	} else {
  		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
  	}
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..8d5312eb221f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -144,6 +144,18 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned 
int size, gfp_t gfp_extra_flag
  	return fp;
  }

+static void bpf_update_stats(struct bpf_prog_stats __percpu *stats, u64 
duration)
+{
+	struct bpf_prog_stats *pstats;
+	unsigned long flags;
+
+	pstats = this_cpu_ptr(stats);
+	flags = u64_stats_update_begin_irqsave(&pstats->syncp);
+	u64_stats_inc(&pstats->cnt);
+	u64_stats_add(&pstats->nsecs, duration);
+	u64_stats_update_end_irqrestore(&pstats->syncp, flags);
+}
+
  struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
  {
  	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | 
gfp_extra_flags);
@@ -168,6 +180,8 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, 
gfp_t gfp_extra_flags)
  		pstats = per_cpu_ptr(prog->stats, cpu);
  		u64_stats_init(&pstats->syncp);
  	}
+
+	prog->update_stats = bpf_update_stats;
  	return prog;
  }
  EXPORT_SYMBOL_GPL(bpf_prog_alloc);
@@ -2536,11 +2550,17 @@ static unsigned int __bpf_prog_ret1(const void *ctx,
  	return 1;
  }

+static void
+__dummy_update_stats(struct bpf_prog_stats __percpu *stats, u64 duration)
+{
+}
+
  static struct bpf_prog_dummy {
  	struct bpf_prog prog;
  } dummy_bpf_prog = {
  	.prog = {
  		.bpf_func = __bpf_prog_ret1,
+		.update_stats = __dummy_update_stats,
  	},
  };


