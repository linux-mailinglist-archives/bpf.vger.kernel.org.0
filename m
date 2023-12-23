Return-Path: <bpf+bounces-18637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E781D14F
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 03:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C961F23C79
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 02:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F46B1375;
	Sat, 23 Dec 2023 02:57:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E281E1111;
	Sat, 23 Dec 2023 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vz09a0o_1703300202;
Received: from 30.236.12.129(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vz09a0o_1703300202)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 10:57:42 +0800
Message-ID: <4fa72ba9-5f42-454e-80d8-52f5db2df345@linux.alibaba.com>
Date: Sat, 23 Dec 2023 10:57:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/3] bpf: introduce BPF_MAP_TYPE_RELAY
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 hengqi@linux.alibaba.com, shung-hsi.yu@suse.com
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
 <ZYWhBWP_J_esr6TW@krava>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <ZYWhBWP_J_esr6TW@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/22 22:45, Jiri Olsa wrote:
> On Fri, Dec 22, 2023 at 08:21:43PM +0800, Philo Lu wrote:
>> The patch set introduce a new type of map, BPF_MAP_TYPE_RELAY, based on
>> relay interface [0]. It provides a way for persistent and overwritable data
>> transfer.
>>
>> As stated in [0], relay is a efficient method for log and data transfer.
>> And the interface is simple enough so that we can implement and use this
>> type of map with current map interfaces. Besides we need a new helper
>> bpf_relay_output to output data to user, similar with bpf_ringbuf_output.
>>
>> We need this map because currently neither ringbuf nor perfbuf satisfies
>> the requirements of relatively long-term consistent tracing, where the bpf
>> program keeps writing into the buffer without any bundled reader, and the
>> buffer supports overwriting. For users, they just run the bpf program to
>> collect data, and are able to read as need. The detailed discussion can be
>> found at [1].
>>
>> The buffer is exposed to users as per-cpu files in debugfs, supporting read
>> and mmap, and it is up to users how to formulate and read it, either
>> through a program with mmap or just `cat`. Specifically, the files are
>> created as "/sys/kerenl/debug/<dirname>/<mapname>#cpu", where the <dirname>
>> is defined with map_update_elem (Note that we do not need to implement
>> actual elem operators for relay_map).
>>
>> If this map is acceptable, other parts including docs, libbpf support,
>> selftests, and benchmarks (if need) will be added in the following version.
> 
> looks useful, selftests might be already helpful to see the usage
> 

Ok, I will add selftests in the next version.

Thanks.

> jirka
> 
>>
>> [0]
>> https://github.com/torvalds/linux/blob/master/Documentation/filesystems/relay.rst
>> [1]
>> https://lore.kernel.org/bpf/20231219122850.433be151@gandalf.local.home/T/
>>
>> Philo Lu (3):
>>    bpf: implement relay map basis
>>    bpf: implement map_update_elem to init relay file
>>    bpf: introduce bpf_relay_output helper
>>
>>   include/linux/bpf.h       |   1 +
>>   include/linux/bpf_types.h |   3 +
>>   include/uapi/linux/bpf.h  |  17 +++
>>   kernel/bpf/Makefile       |   3 +
>>   kernel/bpf/helpers.c      |   4 +
>>   kernel/bpf/relaymap.c     | 213 ++++++++++++++++++++++++++++++++++++++
>>   kernel/bpf/syscall.c      |   1 +
>>   kernel/bpf/verifier.c     |   8 ++
>>   kernel/trace/bpf_trace.c  |   4 +
>>   9 files changed, 254 insertions(+)
>>   create mode 100644 kernel/bpf/relaymap.c
>>
>> --
>> 2.32.0.3.g01195cf9f
>>

