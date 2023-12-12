Return-Path: <bpf+bounces-17484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D0980E2E5
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 04:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86CBB216FB
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 03:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103298F77;
	Tue, 12 Dec 2023 03:44:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910FB4
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 19:44:44 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sq4HS3LZgz4f3jJH
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:44:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6312F1A0380
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:44:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBXrUsi13dlEGMSDg--.32317S2;
	Tue, 12 Dec 2023 11:44:38 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Use __GFP_NOWARN for kvcalloc when
 attaching multiple uprobes
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 xingwei lee <xrivendell7@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
 <20231211112843.4147157-2-houtao@huaweicloud.com>
 <CAADnVQKYE7ijTtcWrdsGpTNvS0r-TTXgkw8-R5U7rWTj+-kqAA@mail.gmail.com>
Message-ID: <8d17436c-66ea-dea0-38e5-6edcea6c1eea@huaweicloud.com>
Date: Tue, 12 Dec 2023 11:44:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKYE7ijTtcWrdsGpTNvS0r-TTXgkw8-R5U7rWTj+-kqAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBXrUsi13dlEGMSDg--.32317S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWrGw45Kr17ArW8CF1kAFb_yoW8KF13pa
	97GF1UtFn5JFyYv3Wvva1SgFy2yw4kW3y7GanFvry3Zrs8ZrWkKrs7KFW8uFnY9rWvkFWS
	qr1DKFyjv3yDZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi,

On 12/12/2023 12:50 AM, Alexei Starovoitov wrote:
> On Mon, Dec 11, 2023 at 3:27 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> An abnormally big cnt may be passed to link_create.uprobe_multi.cnt,
>> and it will trigger the following warning in kvmalloc_node():
>>
>>         if (unlikely(size > INT_MAX)) {
>>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>>                 return NULL;
>>         }
>>
>> Fix the warning by using __GFP_NOWARN when invoking kvzalloc() in
>> bpf_uprobe_multi_link_attach().
>>
>> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
>> Reported-by: xingwei lee <xrivendell7@gmail.com>
>> Closes: https://lore.kernel.org/bpf/CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/trace/bpf_trace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 774cf476a892..07b9b5896d6c 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -3378,7 +3378,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>>         err = -ENOMEM;
>>
>>         link = kzalloc(sizeof(*link), GFP_KERNEL);
>> -       uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
>> +       uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL | __GFP_NOWARN);
> __GFP_NOWARN will hide actual malloc failures.
> Let's limit cnt instead. Both for k and u multi probes.

Do you mean there will be no warning messages when the malloc request
can not be fulfilled, right ?  Because kvcalloc() will still return
-ENOMEM when __GFP_NOWARN is used, so the userspace knows the malloc
failed. And I also found out that __GFP_NOWARN only effect the
invocation of vmalloc(), because kvmalloc_node() enable __GFP_NOWARN for
kmalloc() by default when the passed size is greater than PAGE_SIZE.

I also though about fixing the problem by limitation, but I could not
get good reference values for these limitations. For multiple kprobe,
maybe the number of kallsyms can be used as an anchor (e.g, the number
is 207617 on my local dev machine), how about using 
__roundup_pow_of_two(207617 * 4) = 1 << 20 for multiple kprobes ? For
multiple uprobes, maybe (1<<20) is also suitable.





