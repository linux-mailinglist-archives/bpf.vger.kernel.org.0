Return-Path: <bpf+bounces-17535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3229B80EE5C
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 15:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3E42814DF
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BA67316B;
	Tue, 12 Dec 2023 14:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67C3138
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 06:06:09 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SqL4V5910z4f3l2b
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 22:06:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 348C71A02FD
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 22:06:05 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXJw7FaHhlnVrODQ--.4007S2;
	Tue, 12 Dec 2023 22:06:01 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/4] bpf: Use __GFP_NOWARN for kvcalloc when
 attaching multiple uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 xingwei lee <xrivendell7@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
 <20231211112843.4147157-2-houtao@huaweicloud.com>
 <CAADnVQKYE7ijTtcWrdsGpTNvS0r-TTXgkw8-R5U7rWTj+-kqAA@mail.gmail.com>
 <8d17436c-66ea-dea0-38e5-6edcea6c1eea@huaweicloud.com>
 <ZXgt5kLyk9BsFRBq@krava>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5f63e895-8320-2200-7452-83959db8be27@huaweicloud.com>
Date: Tue, 12 Dec 2023 22:05:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZXgt5kLyk9BsFRBq@krava>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXJw7FaHhlnVrODQ--.4007S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWDWw1fZw45XrWDJrWkJFb_yoW5Cr1fpF
	srJF1Ut3Z5JF1Yvwn2vw4FqFy2yw4kWr47WanrXry5ZrsIqrZ7KF17Kr4j9FnY934vkFWI
	qr1qga42q3yDZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/12/2023 5:54 PM, Jiri Olsa wrote:
> On Tue, Dec 12, 2023 at 11:44:34AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 12/12/2023 12:50 AM, Alexei Starovoitov wrote:
>>> On Mon, Dec 11, 2023 at 3:27 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> An abnormally big cnt may be passed to link_create.uprobe_multi.cnt,
>>>> and it will trigger the following warning in kvmalloc_node():
>>>>
>>>>         if (unlikely(size > INT_MAX)) {
>>>>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>>>>                 return NULL;
>>>>         }
>>>>
>>>> Fix the warning by using __GFP_NOWARN when invoking kvzalloc() in
>>>> bpf_uprobe_multi_link_attach().
>>>>
>>>> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
>>>> Reported-by: xingwei lee <xrivendell7@gmail.com>
>>>> Closes: https://lore.kernel.org/bpf/CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>> ---
>>>>  kernel/trace/bpf_trace.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>> index 774cf476a892..07b9b5896d6c 100644
>>>> --- a/kernel/trace/bpf_trace.c
>>>> +++ b/kernel/trace/bpf_trace.c
>>>> @@ -3378,7 +3378,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>>>>         err = -ENOMEM;
>>>>
>>>>         link = kzalloc(sizeof(*link), GFP_KERNEL);
>>>> -       uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
>>>> +       uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL | __GFP_NOWARN);
>>> __GFP_NOWARN will hide actual malloc failures.
>>> Let's limit cnt instead. Both for k and u multi probes.
>> Do you mean there will be no warning messages when the malloc request
>> can not be fulfilled, right ?  Because kvcalloc() will still return
>> -ENOMEM when __GFP_NOWARN is used, so the userspace knows the malloc
>> failed. And I also found out that __GFP_NOWARN only effect the
>> invocation of vmalloc(), because kvmalloc_node() enable __GFP_NOWARN for
>> kmalloc() by default when the passed size is greater than PAGE_SIZE.
>>
>> I also though about fixing the problem by limitation, but I could not
>> get good reference values for these limitations. For multiple kprobe,
>> maybe the number of kallsyms can be used as an anchor (e.g, the number
>> is 207617 on my local dev machine), how about using 
>> __roundup_pow_of_two(207617 * 4) = 1 << 20 for multiple kprobes ? For
>> multiple uprobes, maybe (1<<20) is also suitable.
> I think available_filter_functions is more relevant, because kallsyms
> has everything
>
> on fedora kernel:
>   # cat available_filter_functions | wc -l
>   80177

Agreed. Only functions in available_filter_functions could use kprobe.
>
> anyway to be on the safe side with some other configs and possible
> huge kernel modules the '1 << 20' looks good to me, also for uprobe
> multi

Thanks. Will post v2 if Alexei is also fine with such limitations.
>
> jirka


