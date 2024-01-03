Return-Path: <bpf+bounces-18844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA3182267F
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 02:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09A8B21D14
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E28BED3;
	Wed,  3 Jan 2024 01:21:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA817980
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T4X3R486vz4f3jHc
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 09:20:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D1B1E1A0178
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 09:20:54 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAHj71ytpRlNaEeFQ--.11110S2;
	Wed, 03 Jan 2024 09:20:54 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Test the inlining of
 bpf_kptr_xchg()
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20231223104042.1432300-1-houtao@huaweicloud.com>
 <20231223104042.1432300-4-houtao@huaweicloud.com>
 <f1196d941601108141bb60f382b7503a50ba600c.camel@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1b72e2dd-32f7-7893-d75f-c4dcefbbc9fe@huaweicloud.com>
Date: Wed, 3 Jan 2024 09:20:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f1196d941601108141bb60f382b7503a50ba600c.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAHj71ytpRlNaEeFQ--.11110S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyktw4xJr13XF15CF1fXrb_yoW8Cr1xpF
	W3Gry29F4kJa4vkryxGw45ZaySqrsagr45XrWUtr1UK3Z8Z34Sg3WDGr9I9a13u34vkFyq
	vF4vgryakF1qyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

On 1/3/2024 2:41 AM, Eduard Zingerman wrote:
> On Sat, 2023-12-23 at 18:40 +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The test uses bpf_prog_get_info_by_fd() to obtain the xlated
>> instructions of the program first. Since these instructions have
>> already been rewritten by the verifier, the tests then checks whether
>> the rewritten instructions are as expected.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Thank you for adding this test, one nitpick below.
>
> [...]
>
>> +#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
>> +private(kptr) struct bin_data __kptr * ptr;
>> +
>> +SEC("tc")
>> +int kptr_xchg_inline(void *ctx)
>> +{
>> +	void *old;
>> +
>> +	old = bpf_kptr_xchg(&ptr, NULL);
>> +	if (old)
>> +		bpf_obj_drop(old);
>> +
>> +	return 0;
>> +}
> This is highly unlikely, but in theory nothing guarantees that LLVM
> would generate code exactly as expected by pattern in test_kptr_xchg_inline().
> It would be more fail-proof to use inline assembly and a naked
> function instead of C code, e.g.:
>
> SEC("tc")
> __naked int kptr_xchg_inline(void)
> {
> 	asm volatile (
> 		"r1 = %[ptr] ll;"
> 		"r2 = 0;"
> 		"call %[bpf_kptr_xchg];"
> 		"if r0 == 0 goto 1f;"
> 		"r1 = r0;"
> 		"r2 = 0;"
> 		"call %[bpf_obj_drop_impl];"
> "1:"
> 		"r0 = 0;"
> 		"exit;"
> 		:
> 		: __imm_addr(ptr),
> 		  __imm(bpf_kptr_xchg),
> 		  __imm(bpf_obj_drop_impl)
> 		: __clobber_all
> 	);
> }
>
> /* BTF FUNC records are not generated for kfuncs referenced
>  * from inline assembly. These records are necessary for
>  * libbpf to link the program. The function below is a hack
>  * to ensure that BTF FUNC records are generated.
>  */
> void __btf_root(void)
> {
> 	bpf_obj_drop(NULL);
> }
>
> wdyt?

Sure, will update the C code to the inline assembly in v3. And thanks
for the review and the suggestions.


