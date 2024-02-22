Return-Path: <bpf+bounces-22492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D444785F454
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 10:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0CC1F22A1D
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5506C39860;
	Thu, 22 Feb 2024 09:27:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4D381B6
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594042; cv=none; b=XJcovc2l3WWZnaGr+GdV58SXP9jco161bs37I5D2JbD+wgQ882qhpnngjqAiytk3YcuKDcXkbpXQW1ued3OcXURY5MbDZGR18H+gYqMcFGWoJWm4iKK/wCrKkl/55kDsQvqSkZuZzVm1WEWw1LJQlrClQ4AasddRiKwEzsvd58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594042; c=relaxed/simple;
	bh=+/Nt5I3GUawhmrJjtQP3AG3FUzcS5X7GWMvk2IHDLUs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DZ5ABi4pIdZIHdyDmWfSgBSEPkcDYInYM0niQo4ofcaiL8TIDfGzQ9katyn/qpb3VHHyNfqV8XANvKKygJrOKBNRRwZscoMSnrJ3tc06tUJ78FvETcgQDpQsO7Yr09OA/1nx/fNQVjrTjGWX3WkRZGABMGb3gwIlemP4dm3c/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgSTK51Tkz4f3jsN
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:27:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B55C91A0176
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:27:06 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAnSw5lE9dlSBiAEw--.60932S2;
	Thu, 22 Feb 2024 17:27:05 +0800 (CST)
Subject: Re: Page faults in tracepoint caused by aliased pointer
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yan Zhai <yan@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Ignat Korchagin <ignat@cloudflare.com>, bpf <bpf@vger.kernel.org>,
 kernel-team <kernel-team@cloudflare.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <ZcqYNrktYhHFTtzH@debian.debian>
 <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
 <CALrw=nGU-gBihe-08rJaxdwpRPQLBPLEQn5q+aBwzLKZ4Go+JQ@mail.gmail.com>
 <CAADnVQ+EL71GN6z3RnSBX5jfCmD9f5T9WN=sr_k+JmZzOOLqPg@mail.gmail.com>
 <CAP01T74t_w0sDaDV5zf3RsZNQg0Hz1XEYw2myOML0L=6afCjsg@mail.gmail.com>
 <CAADnVQLgC8wc5v8sSt=ZxAqLhwoPWXcwwLpSQwKAgaWvuuhF_g@mail.gmail.com>
 <CAO3-Pbp2idpgEcf7ynvx_ucoDXKPVupWctMk1nZ0i_3zPoOTEw@mail.gmail.com>
 <CAP01T77KHwS8bmcXfYXn1OmdAXdrSz_sXooUZ5jAa7vSk=HmnQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <acfd5d49-7727-e07e-4cc1-76decda3b0e5@huaweicloud.com>
Date: Thu, 22 Feb 2024 17:27:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAP01T77KHwS8bmcXfYXn1OmdAXdrSz_sXooUZ5jAa7vSk=HmnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAnSw5lE9dlSBiAEw--.60932S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw17trWxZry8JF18Cw47twb_yoWrJw17pF
	W8ta4UtFs2yr4jyanFq3Wvv3WSy3W7JF1rWr95JryYvwnIgryUKrWxKay5ur1Yvrn7Cry2
	v3y7J3sFvw15t37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/13/2024 8:33 AM, Kumar Kartikeya Dwivedi wrote:
> On Tue, 13 Feb 2024 at 01:21, Yan Zhai <yan@cloudflare.com> wrote:
>> On Mon, Feb 12, 2024 at 5:52 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> On Mon, Feb 12, 2024 at 3:42 PM Kumar Kartikeya Dwivedi
>>> <memxor@gmail.com> wrote:
>>>> On Tue, 13 Feb 2024 at 00:34, Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>> On Mon, Feb 12, 2024 at 3:16 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
>>>>>> [288931.217143][T109754] CPU: 4 PID: 109754 Comm: bpftrace Not tainted
>>>>>> 6.6.16+ #10
>>>>> ...
>>>>>> [288931.217143][T109754]  ? copy_from_kernel_nofault+0x1d/0xe0
>>>>>> [288931.217143][T109754]  bpf_probe_read_compat+0x6a/0x90
>>>>>>
>>>>>> And Jakub CCed here did it for 6.8.0-rc2+
>>>>> I suspect something is broken in your kernels.
>>>>> Above is doing generic copy_from_kernel_nofault(),
>>>>> so one should be able to crash the kernel without any bpf.
>>>>>
>>>>> We have this in selftests/bpf:
>>>>> __weak noinline struct file *bpf_testmod_return_ptr(int arg)
>>>>> {
>>>>>         static struct file f = {};
>>>>>
>>>>>         switch (arg) {
>>>>>         case 1: return (void *)EINVAL;          /* user addr */
>>>>>         case 2: return (void *)0xcafe4a11;      /* user addr */
>>>>>         case 3: return (void *)-EINVAL;         /* canonical, but invalid */
>>>>>         case 4: return (void *)(1ull << 60);    /* non-canonical and invalid */
>>>>>         case 5: return (void *)~(1ull << 30);   /* trigger extable */
>>>>>         case 6: return &f;                      /* valid addr */
>>>>>         case 7: return (void *)((long)&f | 1);  /* kernel tricks */
>>>>>         default: return NULL;
>>>>>         }
>>>>> }
>>>>> where we check that extables setup by JIT for bpf progs are working correctly.
>>>>> You should see the kernel crashing when you just run bpf selftests.
>>>> I agree, this appears unrelated to BPF since it is happening when
>>>> using copy_from_kernel_nofault (which should be jumping to the Efault
>>>> label instead of the oops), but I think it's not specific to some
>>>> custom kernel. I can reproduce it on my dev machine on top of bpf-next
>>>> as well, and another machine with Ubuntu's generic 6.5 kernel for
>>>> 24.04. And I think Ignat tried it on the mainline 6.8-rc2 as well.
>> copy_from_kernel_nofault is called in Jakub's reproducer, but the
>> panic case in our production seems to be direct memory accessing
>> according to bpftool dumped jited code. Will faults from such
>> instructions also be caught correctly?
>>
> Yep, since faults in both cases end up in the page fault handler.
> Once the fix pointed out by Alexei is applied, it should address both scenarios.

I didn't get the idea on how the vsyscall patch [1] will fix the
unhandled page fault caused by BTF pointer dereference. In my
understanding, for BTF pointer dereference, x86 JIT checks whether the
address is a kernel space address or not. If it is the kernel space
address, it will setup an exception fix-up entry for its dereference and
will try to do dereference directly. If the address is vsyscall address,
x86 JIT will consider it as kernel space address and will try to
dereference it directly. The dereference of vsyscall page in kernel will
trigger the page fault, handle_page_fault() will be invoked and it will
invoke do_user_addr_fault() and page_fault_oops() accordingly.

[1]:
https://patchwork.kernel.org/project/netdevbpf/patch/20240202103935.3154011-3-houtao@huaweicloud.com/

>
>> Yan
>>
>>> Then it must be vsyscall address that this series are fixing:
>>> https://patchwork.kernel.org/project/netdevbpf/patch/20240202103935.3154011-3-houtao@huaweicloud.com/
>>>
>>> We're still waiting on x86 maintainers to ack them.
> .


