Return-Path: <bpf+bounces-19014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B625823CE3
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 08:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB51C21176
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6741320323;
	Thu,  4 Jan 2024 07:43:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD07208A6;
	Thu,  4 Jan 2024 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxDOs+YZZlq+ABAA--.7171S3;
	Thu, 04 Jan 2024 15:41:51 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxPN48YZZlfyoBAA--.2989S3;
	Thu, 04 Jan 2024 15:41:48 +0800 (CST)
Subject: Re: [PATCH bpf-next v1] bpf: Return -ENOTSUPP if callbacks are not
 allowed in non-JITed programs
To: John Fastabend <john.fastabend@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20231225091830.6094-1-yangtiezhu@loongson.cn>
 <1179fcf4e4feaf5d9161eb0ec8fb41e4f08511a4.camel@gmail.com>
 <6594a4c15a677_11e86208cd@john.notmuch>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0ea51d9f-7007-b893-0903-d9f76d6f34c9@loongson.cn>
Date: Thu, 4 Jan 2024 15:41:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6594a4c15a677_11e86208cd@john.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8BxPN48YZZlfyoBAA--.2989S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJry5KrW7Ar15ZF1Uur4xXwc_yoW8Aw45pF
	40kFWqyFWvqa47WasFqFsrua42qw15J3y7WFW8AryxJFn8tr9xJr48Kw43uasavrn3W3W0
	va1S9FyvvFyUXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1tC7UUU
	UU=



On 01/03/2024 08:05 AM, John Fastabend wrote:
> Eduard Zingerman wrote:
>> On Mon, 2023-12-25 at 17:18 +0800, Tiezhu Yang wrote:
>>> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
>>> exist 6 failed tests.

...

>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> ---
>>>  kernel/bpf/verifier.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index a376eb609c41..1c780a893284 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -19069,7 +19069,7 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>>>  			 * have to be rejected, since interpreter doesn't support them yet.
>>>  			 */
>>>  			verbose(env, "callbacks are not allowed in non-JITed programs\n");
>>> -			return -EINVAL;
>>> +			return -ENOTSUPP;
>>>  		}
>>>
>>>  		if (!bpf_pseudo_call(insn))
>>
>> I agree with this change, however I think that it should be consistent.
>> Quick and non-exhaustive grepping shows that there are 4 places where
>> "non-JITed" is used in error messages: in check_map_func_compatibility()
>> and in fixup_call_args().
>> All these places currently use -EINVAL and should be updated to -ENOTSUPP,
>> if this change gets a green light.
>
> My preference is to just leave them as is unless its a serious
> problem. In this case any userspace has likely already figured
> out how to handle these errors so I don't think there is much
> value in changing things.

I am not quite sure whether to ignore this patch, but the state of
this patch is "Changes Requested" [1], I guess I should send v2 as
Eduard suggested.

[1] 
https://patchwork.kernel.org/project/netdevbpf/patch/20231225091830.6094-1-yangtiezhu@loongson.cn/

Thanks,
Tiezhu


