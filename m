Return-Path: <bpf+bounces-18467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2E81AC0A
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 02:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6F21C233E2
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 01:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7A117E9;
	Thu, 21 Dec 2023 01:15:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF015B7;
	Thu, 21 Dec 2023 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwXYL0mjyz4f3k5n;
	Thu, 21 Dec 2023 09:15:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7A1F91A0180;
	Thu, 21 Dec 2023 09:15:35 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgD3fr2zkYNl5e2LEA--.23425S2;
	Thu, 21 Dec 2023 09:15:32 +0800 (CST)
Subject: Re: BUG: unable to handle kernel paging request in
 bpf_probe_read_compat_str
To: Yonghong Song <yonghong.song@linux.dev>,
 xingwei lee <xrivendell7@gmail.com>
Cc: ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 song@kernel.org
References: <CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com>
 <cde2ebc4-7e7d-56be-5f08-6d261142189e@huaweicloud.com>
 <2327d4aa-68f5-48d4-9296-7d5df15502b1@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6568a839-be3c-6898-4e56-95436ea18069@huaweicloud.com>
Date: Thu, 21 Dec 2023 09:15:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2327d4aa-68f5-48d4-9296-7d5df15502b1@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgD3fr2zkYNl5e2LEA--.23425S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyfJF1Dur18XrW7XFyUAwb_yoW8Ar1rp3
	y5Ga9YyrZ8Xr1xAws7t348Xa4Ivw4fGa15WrW8try7u3s09rnaya1vvay3CrZIqr10gF4x
	trs0qa9Igr1UXrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/21/2023 1:50 AM, Yonghong Song wrote:
>
> On 12/20/23 1:19 AM, Hou Tao wrote:
>> Hi,
>>
>> On 12/14/2023 11:40 AM, xingwei lee wrote:
>>> Hello I found a bug in net/bpf in the lastest upstream linux and
>>> comfired in the lastest net tree and lastest net bpf titled BUG:
>>> unable to handle kernel paging request in bpf_probe_read_compat_str
>>>
>>> If you fix this issue, please add the following tag to the commit:
>>> Reported-by: xingwei Lee <xrivendell7@gmail.com>
>>>
>>> kernel: net 9702817384aa4a3700643d0b26e71deac0172cfd / bpf
>>> 2f2fee2bf74a7e31d06fc6cb7ba2bd4dd7753c99
>>> Kernel config:
>>> https://syzkaller.appspot.com/text?tag=KernelConfig&x=b50bd31249191be8
>>>
>>> in the lastest bpf tree, the crash like:
>>>
>>> TITLE: BUG: unable to handle kernel paging request in
>>> bpf_probe_read_compat_str
>>> CORRUPTED: false ()
>>> MAINTAINERS (TO): [akpm@linux-foundation.org linux-mm@kvack.org]
>>> MAINTAINERS (CC): [linux-kernel@vger.kernel.org]
>>>
>>> BUG: unable to handle page fault for address: ff0
>> Thanks for the report and reproducer. The output is incomplete. It
>> should be: "BUG: unable to handle page fault for address:
>> ffffffffff600000". The address is a vsyscall address, so
>> handle_page_fault() considers that the fault address is in userspace
>> instead of kernel space, and there will be no fix-up for the exception
>> and oops happened. Will post a fix and a selftest for it.
>
> There is a proposed fix here:
>
> https://lore.kernel.org/bpf/87r0jwquhv.ffs@tglx/
>
> Not sure the fix in the above link is merged to some upstream branch
> or not.

It seems it has not been merged. will ping Thomas later.


