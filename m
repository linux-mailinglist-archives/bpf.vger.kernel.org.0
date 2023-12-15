Return-Path: <bpf+bounces-17989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A6E814532
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 11:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF71F22A69
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D8718C3D;
	Fri, 15 Dec 2023 10:10:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD518C1D
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyXOVE6_1702635051;
Received: from 30.221.128.158(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VyXOVE6_1702635051)
          by smtp.aliyun-inc.com;
          Fri, 15 Dec 2023 18:10:52 +0800
Message-ID: <23bcab0e-bec1-4edd-b45a-0142ebcda41a@linux.alibaba.com>
Date: Fri, 15 Dec 2023 18:10:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with
 overwriting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, song@kernel.org, andrii@kernel.org, ast@kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, guwen@linux.alibaba.com,
 alibuda@linux.alibaba.com, hengqi@linux.alibaba.com,
 Nathan Slingerland <slinger@meta.com>, "rihams@meta.com" <rihams@meta.com>,
 Alan Maguire <alan.maguire@oracle.com>
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
 <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
 <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
 <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
 <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/12/14 07:35, Andrii Nakryiko wrote:
> On Mon, Dec 11, 2023 at 4:39 AM Philo Lu <lulie@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2023/12/9 06:32, Andrii Nakryiko wrote:
>>> On Thu, Dec 7, 2023 at 6:49 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 07/12/2023 13:15, Philo Lu wrote:
>>>>> Hi all. I have a question when using perfbuf/ringbuf in bpf. I will
>>>>> appreciate it if you give me any advice.
>>>>>
>>>>> Imagine a simple case: the bpf program output a log (some tcp
>>>>> statistics) to user every time a packet is received, and the user
>>>>> actively read the logs if he wants. I do not want to keep a user process
>>>>> alive, waiting for outputs of the buffer. User can read the buffer as
>>>>> need. BTW, the order does not matter.
>>>>>
>>>>> To conclude, I hope the buffer performs like relayfs: (1) no need for
>>>>> user process to receive logs, and the user may read at any time (and no
>>>>> wakeup would be better); (2) old data can be overwritten by new ones.
>>>>>
>>>>> Currently, it seems that perfbuf and ringbuf cannot satisfy both: (i)
>>>>> ringbuf: only satisfies (1). However, if data arrive when the buffer is
>>>>> full, the new data will be lost, until the buffer is consumed. (ii)
>>>>> perfbuf: only satisfies (2). But user cannot access the buffer after the
>>>>> process who creates it (including perf_event.rb via mmap) exits.
>>>>> Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the
>>>>> perf_events, but I do not know how to get the buffer again in a new
>>>>> process.
>>>>>
>>>>> In my opinion, this can be solved by either of the following: (a) add
>>>>> overwrite support in ringbuf (maybe a new flag for reserve), but we have
>>>>> to address synchronization between kernel and user, especially under
>>>>> variable data size, because when overwriting occurs, kernel has to
>>>>> update the consumer posi too; (b) implement map_fd_sys_lookup_elem for
>>>>> perfbuf to expose fds to user via map_lookup_elem syscall, and a
>>>>> mechanism is need to preserve perf_event->rb when process exits
>>>>> (otherwise the buffer will be freed by perf_mmap_close). I am not sure
>>>>> if they are feasible, and which is better. If not, perhaps we can
>>>>> develop another mechanism to achieve this?
>>>>>
>>>>
>>>> There was an RFC a while back focused on supporting BPF ringbuf
>>>> over-writing [1]; at the time, Andrii noted some potential issues that
>>>> might be exposed by doing multiple ringbuf reserves to overfill the
>>>> buffer within the same program.
>>>>
>>>
>>> Correct. I don't think it's possible to correctly and safely support
>>> overwriting with BPF ringbuf that has variable-sized elements.
>>>
>>> We'll need to implement MPMC ringbuf (probably with fixed sized
>>> element size) to be able to support this.
>>>
>>
>> Thank you very much!
>>
>> If it is indeed difficult with ringbuf, maybe I can implement a new type
>> of bpf map based on relay interface [1]? e.g., init relay during map
>> creating, write into it with bpf helper, and then user can access to it
>> in filesystem. I think it will be a simple but useful map for
>> overwritable data transfer.
> 
> I don't know much about relay, tbh. Give it a try, I guess.
> Alternatively, we need better and faster implementation of
> BPF_MAP_TYPE_QUEUE, which seems like the data structure that can
> support overwriting and generally be a fixed elementa size
> alternative/complement to BPF ringbuf.
> 

Thank you for your reply. I am afraid BPF_MAP_TYPE_QUEUE cannot get rid 
of locking overheads with concurrent reading and writing by design, and 
a lockless buffer like relay fits better to our case. So I will try it :)

>>
>> [1]
>> https://github.com/torvalds/linux/blob/master/Documentation/filesystems/relay.rst
>>
>>>> Alan
>>>>
>>>> [1]
>>>> https://lore.kernel.org/lkml/20220906195656.33021-2-flaniel@linux.microsoft.com/

