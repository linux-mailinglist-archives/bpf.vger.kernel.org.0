Return-Path: <bpf+bounces-32564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7F490FFA8
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1405E1C209F9
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5456217557C;
	Thu, 20 Jun 2024 08:55:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5A4D8B7
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873702; cv=none; b=AwWzrpoRV27SHQO3Bfiemp81uW2bODRzl/OUILKgJi4unXmvuJl3XrVKxPKusln63+6yZpT/r2L5B2j1OLa6spS4VF5W163vnpVZMU02QMGEaBEOUxhycwudb4WHbTRNeqL643jvR5he0EbsUzJBamMC6g4ed2nBgkRwINZY43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873702; c=relaxed/simple;
	bh=Bqz/RPh4xEeYm84WA4dZh8XXA3R9Y3oKV+JpPRmOgio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWjE9hAMJiwdBX+LOBHCcNQ9JNnxZOw3Oh1zbaXKTAZO4vB9ks+T4UUbXazslO5r8Cn2XnFdNGIdmOfp8kZqCUqye02NkH+KaJ+JHiuHTUL4+rVMCok4qdrFfIfcbMHEGfCPThqCI+wPWXHxc/S3p+lnRGDR3nEPNHYmdLmhE40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W4Z7F0Bctz4f3jLX
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 16:54:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DE9681A0572
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 16:54:55 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgCnO61c7nNmDLLCAQ--.21955S2;
	Thu, 20 Jun 2024 16:54:53 +0800 (CST)
Message-ID: <2c5d2fdb-19ee-4b3c-9004-5e4d0a8719b8@huaweicloud.com>
Date: Thu, 20 Jun 2024 16:54:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix null pointer dereference in
 resolve_prog_type() for BPF_PROG_TYPE_EXT
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20240620060701.1465291-1-wutengda@huaweicloud.com>
 <cfab6597-2c2c-4b76-853d-1b0dc13b8e9a@gmail.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <cfab6597-2c2c-4b76-853d-1b0dc13b8e9a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCnO61c7nNmDLLCAQ--.21955S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF45XrWfZFWkWFyfXr1rtFb_yoW7Gr15pr
	4UGw17Kr4kA347AwnrAr1Utr1UZF1UCFy5tr4fK34rZF15ur1Iy3y5Ga1UCFn8Ar4kJrW2
	yFyjgw4qq3WUCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2024/6/20 14:46, Leon Hwang wrote:
> 
> 
> On 20/6/24 14:07, Tengda Wu wrote:
>> When loading a EXT program without specifying `attr->attach_prog_fd`,
>> the `prog->aux->dst_prog` will be null. At this time, calling
>> resolve_prog_type() anywhere will result in a null pointer dereference.
> 
> Interesting, same NULL pointer dereference causes another issue[0].
> 
> As for my case, when resolve_prog_type(), it has to use
> prog->aux->saved_dst_prog_type instead of prog->aux->dst_prog->type for
> EXT program, in order to avoid NULL pointer dereference.
> 
> [0] https://lore.kernel.org/bpf/20240602122421.50892-2-hffilwlqm@gmail.com/
> 
> Thanks,
> Leon
>This looks good, but unfortunately, there is still a problem with using 
`prog->aux->saved_dst_prog_type` to resolve prog type, because its value still 
comes from `prog->aux->dst_prog`in check_attach_btf_id(). 

Additionally, resolve_prog_type() not always be used after check_attach_btf_id().
The following example stack trace proves the existence of this situation. It 
shows that NULL pointer dereference occurs in add_subprog_and_kfunc(), which
check_attach_btf_id() has not yet reached. 

So it may be more effective to check and avoid dst_prog empty when EXT program loads.

>>
>> Example stack trace:
>>
>> [    8.107863] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
>> [    8.108262] Mem abort info:
>> [    8.108384]   ESR = 0x0000000096000004
>> [    8.108547]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    8.108722]   SET = 0, FnV = 0
>> [    8.108827]   EA = 0, S1PTW = 0
>> [    8.108939]   FSC = 0x04: level 0 translation fault
>> [    8.109102] Data abort info:
>> [    8.109203]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>> [    8.109399]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [    8.109614]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [    8.109836] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101354000
>> [    8.110011] [0000000000000004] pgd=0000000000000000, p4d=0000000000000000
>> [    8.112624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>> [    8.112783] Modules linked in:
>> [    8.113120] CPU: 0 PID: 99 Comm: may_access_dire Not tainted 6.10.0-rc3-next-20240613-dirty #1
>> [    8.113230] Hardware name: linux,dummy-virt (DT)
>> [    8.113390] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    8.113429] pc : may_access_direct_pkt_data+0x24/0xa0
>> [    8.113746] lr : add_subprog_and_kfunc+0x634/0x8e8
>> [    8.113798] sp : ffff80008283b9f0
>> [    8.113813] x29: ffff80008283b9f0 x28: ffff800082795048 x27: 0000000000000001
>> [    8.113881] x26: ffff0000c0bb2600 x25: 0000000000000000 x24: 0000000000000000
>> [    8.113897] x23: ffff0000c1134000 x22: 000000000001864f x21: ffff0000c1138000
>> [    8.113912] x20: 0000000000000001 x19: ffff0000c12b8000 x18: ffffffffffffffff
>> [    8.113929] x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
>> [    8.113944] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
>> [    8.113958] x11: 0720072007200720 x10: 0000000000f9fca4 x9 : ffff80008021f4e4
>> [    8.113991] x8 : 0101010101010101 x7 : 746f72705f6d656d x6 : 000000001e0e0f5f
>> [    8.114006] x5 : 000000000001864f x4 : ffff0000c12b8000 x3 : 000000000000001c
>> [    8.114020] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
>> [    8.114126] Call trace:
>> [    8.114159]  may_access_direct_pkt_data+0x24/0xa0
>> [    8.114202]  bpf_check+0x3bc/0x28c0
>> [    8.114214]  bpf_prog_load+0x658/0xa58
>> [    8.114227]  __sys_bpf+0xc50/0x2250
>> [    8.114240]  __arm64_sys_bpf+0x28/0x40
>> [    8.114254]  invoke_syscall.constprop.0+0x54/0xf0
>> [    8.114273]  do_el0_svc+0x4c/0xd8
>> [    8.114289]  el0_svc+0x3c/0x140
>> [    8.114305]  el0t_64_sync_handler+0x134/0x150
>> [    8.114331]  el0t_64_sync+0x168/0x170
>> [    8.114477] Code: 7100707f 54000081 f9401c00 f9403800 (b9400403)
>> [    8.118672] ---[ end trace 0000000000000000 ]---
>>
>> Fix this by adding dst_prog non-empty check in BPF_PROG_TYPE_EXT case
>> when calling bpf_prog_load().
>>
>> Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> Cc: stable@vger.kernel.org # v5.18+
>> ---
>>  kernel/bpf/syscall.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index f45ed6adc092..4490f8ccf006 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2632,9 +2632,12 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
>>  			return 0;
>>  		return -EINVAL;
>>  	case BPF_PROG_TYPE_SYSCALL:
>> -	case BPF_PROG_TYPE_EXT:
>>  		if (expected_attach_type)
>>  			return -EINVAL;
>> +		return 0;
>> +	case BPF_PROG_TYPE_EXT:
>> +		if (expected_attach_type || !dst_prog)
>> +			return -EINVAL;
>>  		fallthrough;
>>  	default:
>>  		return 0;


