Return-Path: <bpf+bounces-18660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624D81E029
	for <lists+bpf@lfdr.de>; Mon, 25 Dec 2023 12:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C89282166
	for <lists+bpf@lfdr.de>; Mon, 25 Dec 2023 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD415103E;
	Mon, 25 Dec 2023 11:36:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147B53E1E;
	Mon, 25 Dec 2023 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VzCE9Bo_1703504193;
Received: from 30.221.128.104(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VzCE9Bo_1703504193)
          by smtp.aliyun-inc.com;
          Mon, 25 Dec 2023 19:36:35 +0800
Message-ID: <6a8538dc-d05c-41c9-bab5-6fbb5c6eea2f@linux.alibaba.com>
Date: Mon, 25 Dec 2023 19:36:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: implement relay map basis
From: Philo Lu <lulie@linux.alibaba.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, hengqi@linux.alibaba.com, shung-hsi.yu@suse.com
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
 <20231222122146.65519-2-lulie@linux.alibaba.com>
 <35f5a5bf-7059-a177-cd94-b60ed8dbff03@huaweicloud.com>
 <87b4f7fc-cc98-496c-bbff-6e3890278e35@linux.alibaba.com>
In-Reply-To: <87b4f7fc-cc98-496c-bbff-6e3890278e35@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/23 21:02, Philo Lu wrote:
> 
> 
> On 2023/12/23 19:22, Hou Tao wrote:
>> Hi,
>>
>> On 12/22/2023 8:21 PM, Philo Lu wrote:
>>> BPF_MAP_TYPE_RELAY is implemented based on relay interface, which
>>> creates per-cpu buffer to transfer data. Each buffer is essentially a
>>> list of fix-sized sub-buffers, and is exposed to user space as files in
>>> debugfs. attr->max_entries is used as subbuf size and attr->map_extra is
>>> used as subbuf num. Currently, the default value of subbuf num is 8.
>>>
>>> The data can be accessed by read or mmap via these files. For example,
>>> if there are 2 cpus, files could be `/sys/kernel/debug/mydir/my_rmap0`
>>> and `/sys/kernel/debug/mydir/my_rmap1`.
>>>
>>> Buffer-only mode is used to create the relay map, which just allocates
>>> the buffer without creating user-space files. Then user can setup the
>>> files with map_update_elem, thus allowing user to define the directory
>>> name in debugfs. map_update_elem is implemented in the following patch.
>>>
>>> A new map flag named BPF_F_OVERWRITE is introduced to set overwrite mode
>>> of relay map.
>>
>> Beside adding a new map type, could we consider only use kfuncs to
>> support the creation of rchan and the write of rchan ? I think
>> bpf_cpumask will be a good reference.
> 
> This is a good question. TBH, I have thought of implement it with 
> helpers (I'm not very familiar with kfuncs, but I think they could be 
> similar?), but I was stumped by how to close the channel. We can create 
> a relay channel, hold it with a map, but it could be difficult for the 
> bpf program to close the channel with relay_close(). And I think it 
> could be the difference compared with bpf_cpumask.

I've learned more about kfunc and kptr, and find that kptr can be 
automatically released with a given map. Then, it is technically 
feasible to use relay interface with kfuncs. Specificially, creating a 
relay channel and getting the pointer with kfunc, transferring it as a 
kptr into a map, and then it lives with the map.

Though I'm not sure if this is better than map-based implementation, as 
mostly it will be used with a map (I haven't thought of a case without a 
map yet). And with kfunc, it will be a little more complex to create a 
relay channel.

Thanks.

