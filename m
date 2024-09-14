Return-Path: <bpf+bounces-39891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B37978F61
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 11:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3321C212FE
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 09:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC641CDA13;
	Sat, 14 Sep 2024 09:14:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D413B780
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305283; cv=none; b=p1I+JH1xvuRAZ49Lh2OfZPnwML8uaXn2Rzgo/lHNgukhtDkKSuP00dJ7XZJHci4TQxirXfyzHMHauZP3qZE42DqQrDPhviRcYeBvaswSRmzs220FtZ5GXJjkT4W9ahujFciTEQPoCL07+J7BJsBR+orhRel0o4RQtihPzW9TTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305283; c=relaxed/simple;
	bh=x7i/eyEpfgZAniVXQAWvNQJad+gFTiFJ+QnXP+cf1g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRzllrh7E0xkXaccmV7zRjIdUy675yhiCM5CYyNBprShl5jwFIuJw2S0UgY2op2EE9arT1I8oLMmZK6lyMYAHLxgX0GB6pIbdkLbBm+A5oZU6lVcaJTg2Z/F8fBTQ9MiBaWHk7jGPqHFyQrZfqZkrA36nuSrb0B2YadSzYO7AEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X5QV759jxz4f3jkX
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 17:14:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 795AD1A08DC
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 17:14:34 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCHu8f4U+VmRycnBQ--.2469S2;
	Sat, 14 Sep 2024 17:14:34 +0800 (CST)
Message-ID: <fd7192e0-bba3-49d5-aede-ce3d85e886c2@huaweicloud.com>
Date: Sat, 14 Sep 2024 17:14:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Eddy Z <eddyz87@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
References: <20240901133856.64367-1-leon.hwang@linux.dev>
 <20240901133856.64367-3-leon.hwang@linux.dev>
 <fb6ed3e4-7ef2-4b7d-af7e-bf928d835fe9@linux.dev>
 <64c3f174-1dfb-409b-bc11-d7379c09e0ae@huaweicloud.com>
 <cac838d2-9590-4bef-bb58-b56f97881fde@linux.dev>
 <0fc08a50-8812-4932-bb85-9d81cedf142a@huaweicloud.com>
 <2e955de3-396a-4def-925c-0e8463f29b23@linux.dev>
 <CAADnVQJB+y0NFTk4zOp8vLtYPuSy+eOOy6qYridK6WWeFFPWxA@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQJB+y0NFTk4zOp8vLtYPuSy+eOOy6qYridK6WWeFFPWxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHu8f4U+VmRycnBQ--.2469S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8GFW3KF4UGFy7XF1fJFb_yoW5KFWkpF
	y8Ja9rtF4Dtr4qvF47tw1fuFyakw4DJr90qrn5X34rAr9IqrnakFW3Gry8CFy5Xr4UGw1j
	qF1jqas7A3W8JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 9/14/2024 1:47 AM, Alexei Starovoitov wrote:
> On Mon, Sep 9, 2024 at 7:42 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 9/9/24 20:08, Xu Kuohai wrote:
>>> On 9/9/2024 6:38 PM, Leon Hwang wrote:
>>>>
>>>>
>>>> On 9/9/24 17:02, Xu Kuohai wrote:
>>>>> On 9/8/2024 9:01 PM, Leon Hwang wrote:
>>>>>>
>>>>>>
>>>>>> On 1/9/24 21:38, Leon Hwang wrote:
>>>>>>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the
>>>>>>> same
>>>>>>> issue happens on arm64, too.
>>>>>>>
>>
>> [...]
>>
>>>>>>>
>>>>>> Hi Puranjay and Kuohai,
>>>>>>
>>>>>> As it's not recommended to introduce arch_bpf_run(), this is my
>>>>>> approach
>>>>>> to fix the niche case on arm64.
>>>>>>
>>>>>> Do you have any better idea to fix it?
>>>>>>
>>>>>
>>>>> IIUC, the recommended appraoch is to teach verifier to reject the
>>>>> freplace + tailcall combination. If this combiation is allowed, we
>>>>> will face more than just this issue. For example, what happens if
>>>>> a freplace prog is attached to tail callee? The freplace prog is not
>>>>> reachable through the tail call, right?
>>>>>
>>>>
>>>> It's to reject the freplace + tailcall combination partially, see "bpf,
>>>> x64: Fix tailcall infinite loop caused by freplace". (Oh, I should
>>>> separate the rejection to a standalone patch.)
>>>> It rejects the case that freplace prog has tailcall and its attach
>>>> target has no tailcall.
>>>>
>>>> As for your example, it depends on:
>>>>
>>>>                   freplace       target    reject?
>>>> Has tailcall?     YES            NO        YES
>>>> Has tailcall?     YES            YES       NO
>>>> Has tailcall?     NO             YES       NO
>>>> Has tailcall?     NO             YES       NO
>>>>
>>>> Then, freplace prog can be tail callee always. I haven't seen any bad
>>>> case when freplace prog is tail callee.
>>>>
>>>
>>> Here is a concrete case. prog1 tail calls prog2, and prog2_new is
>>> attached to prog2 via freplace.
>>>
>>> SEC("tc")
>>> int prog1(struct __sk_buff *skb)
>>> {
>>>          bpf_tail_call_static(skb, &progs, 0); // tail call prog2
>>>          return 0;
>>> }
>>>
>>> SEC("tc")
>>> int prog2(struct __sk_buff *skb)
>>> {
>>>          return 0;
>>> }
>>>
>>> SEC("freplace")
>>> int prog2_new(struct __sk_buff *skb) // target is prog2
>>> {
>>>          return 0;
>>> }
>>>
>>> In this case, prog2_new is not reachable, since the tail call
>>> target in prog2 is start address of prog2  + TAIL_CALL_OFFSET,
>>> which locates behind freplace/fentry callsite of prog2.
>>>
>>
>> This is an abnormal use case. We can do nothing with it, e.g. we're
>> unable to notify user that prog2_new is not reachable for this case.
> 
> Since it doesn't behave as the user would expect, I think, it's better
> to disallow such combinations in the verifier.
> Either freplace is trying to patch a prog that is already in prog_array
> then the load of freplace prog can report a meaningful error into the
> verifier log or
> already freplaced prog is being added to prog array.
> I think in this case main prog tail calling into this freplace prog
> will actually succeed, but it's better to reject sys_bpf update
> command in bpf_fd_array_map_update_elem(),
> since being-freplaced prog is not in prog_array and won't be called,
> but freplace prog in prog array can be called which is inconsistent.
> freplace prog should act and be called just like target being-freplaced prog.
> 
> I don't think this will break any actual use cases where freplace and
> tail call are used together.

+1, we should not ignore it silently. If the freplace + tailcall
combination can not be disallowed completely, we should disallow
this case separately (or maybe we could find an acceptable way to
make it work as expected?) . Let me give it a try.


