Return-Path: <bpf+bounces-17397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF880C9FB
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8CB281F23
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1C93B7B9;
	Mon, 11 Dec 2023 12:39:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E500DA1
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:39:41 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyI4rE3_1702298378;
Received: from 30.221.128.158(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VyI4rE3_1702298378)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 20:39:39 +0800
Message-ID: <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
Date: Mon, 11 Dec 2023 20:39:34 +0800
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
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/12/9 06:32, Andrii Nakryiko wrote:
> On Thu, Dec 7, 2023 at 6:49 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 07/12/2023 13:15, Philo Lu wrote:
>>> Hi all. I have a question when using perfbuf/ringbuf in bpf. I will
>>> appreciate it if you give me any advice.
>>>
>>> Imagine a simple case: the bpf program output a log (some tcp
>>> statistics) to user every time a packet is received, and the user
>>> actively read the logs if he wants. I do not want to keep a user process
>>> alive, waiting for outputs of the buffer. User can read the buffer as
>>> need. BTW, the order does not matter.
>>>
>>> To conclude, I hope the buffer performs like relayfs: (1) no need for
>>> user process to receive logs, and the user may read at any time (and no
>>> wakeup would be better); (2) old data can be overwritten by new ones.
>>>
>>> Currently, it seems that perfbuf and ringbuf cannot satisfy both: (i)
>>> ringbuf: only satisfies (1). However, if data arrive when the buffer is
>>> full, the new data will be lost, until the buffer is consumed. (ii)
>>> perfbuf: only satisfies (2). But user cannot access the buffer after the
>>> process who creates it (including perf_event.rb via mmap) exits.
>>> Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the
>>> perf_events, but I do not know how to get the buffer again in a new
>>> process.
>>>
>>> In my opinion, this can be solved by either of the following: (a) add
>>> overwrite support in ringbuf (maybe a new flag for reserve), but we have
>>> to address synchronization between kernel and user, especially under
>>> variable data size, because when overwriting occurs, kernel has to
>>> update the consumer posi too; (b) implement map_fd_sys_lookup_elem for
>>> perfbuf to expose fds to user via map_lookup_elem syscall, and a
>>> mechanism is need to preserve perf_event->rb when process exits
>>> (otherwise the buffer will be freed by perf_mmap_close). I am not sure
>>> if they are feasible, and which is better. If not, perhaps we can
>>> develop another mechanism to achieve this?
>>>
>>
>> There was an RFC a while back focused on supporting BPF ringbuf
>> over-writing [1]; at the time, Andrii noted some potential issues that
>> might be exposed by doing multiple ringbuf reserves to overfill the
>> buffer within the same program.
>>
> 
> Correct. I don't think it's possible to correctly and safely support
> overwriting with BPF ringbuf that has variable-sized elements.
> 
> We'll need to implement MPMC ringbuf (probably with fixed sized
> element size) to be able to support this.
> 

Thank you very much!

If it is indeed difficult with ringbuf, maybe I can implement a new type 
of bpf map based on relay interface [1]? e.g., init relay during map 
creating, write into it with bpf helper, and then user can access to it 
in filesystem. I think it will be a simple but useful map for 
overwritable data transfer.

[1]
https://github.com/torvalds/linux/blob/master/Documentation/filesystems/relay.rst

>> Alan
>>
>> [1]
>> https://lore.kernel.org/lkml/20220906195656.33021-2-flaniel@linux.microsoft.com/

