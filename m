Return-Path: <bpf+bounces-18706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881C81F7A0
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 12:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014551F2428C
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 11:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6EC6FBF;
	Thu, 28 Dec 2023 11:20:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AFE6FB2
	for <bpf@vger.kernel.org>; Thu, 28 Dec 2023 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0VzOKzM3_1703762394;
Received: from 30.221.128.104(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VzOKzM3_1703762394)
          by smtp.aliyun-inc.com;
          Thu, 28 Dec 2023 19:19:55 +0800
Message-ID: <f5edeba8-4a17-415f-8c85-73eedc65a99f@linux.alibaba.com>
Date: Thu, 28 Dec 2023 19:19:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/3] bpf: introduce BPF_MAP_TYPE_RELAY
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Joanne Koong <joannelkoong@gmail.com>,
 Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>,
 Hou Tao <houtao@huaweicloud.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, guwen@linux.alibaba.com,
 hengqi@linux.alibaba.com
References: <20231227100130.84501-1-lulie@linux.alibaba.com>
 <CAADnVQ+8GJSqUSBH__tTy-gEz9LMY5pPex-p-ijtr+OkFoqW1A@mail.gmail.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <CAADnVQ+8GJSqUSBH__tTy-gEz9LMY5pPex-p-ijtr+OkFoqW1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/12/28 02:02, Alexei Starovoitov wrote:
> On Wed, Dec 27, 2023 at 2:01 AM Philo Lu <lulie@linux.alibaba.com> wrote:
>>
>> The patch set introduce a new type of map, BPF_MAP_TYPE_RELAY, based on
>> relay interface [0]. It provides a way for persistent and overwritable data
>> transfer.
>>
>> As stated in [0], relay is a efficient method for log and data transfer.
>> And the interface is simple enough so that we can implement and use this
>> type of map with current map interfaces. Besides we need a kfunc
>> bpf_relay_output to output data to user, similar with bpf_ringbuf_output.
>>
>> We need this map because currently neither ringbuf nor perfbuf satisfies
>> the requirements of relatively long-term consistent tracing, where the bpf
>> program keeps writing into the buffer without any bundled reader, and the
>> buffer supports overwriting. For users, they just run the bpf program to
>> collect data, and are able to read as need. The detailed discussion can be
>> found at [1].
> 
> Hold on.
> Earlier I mistakenly assumed that this relayfs is a multi producer
> buffer instead of per-cpu.
> Since it's actually per-cpu I see no need to introduce another per-cpu
> ring buffer. We already have a perf_event buffer.
> 
I think relay map and perfbuf don't conflict with each other, and relay 
map could be a better choice in some use cases (e.g., constant tracing). 
In our application, we output the tracing records as strings into relay 
files, and users just read it through `cat` without any process, which 
seems impossible to be implemented even with pinnable perfbuf.

Specifically, the advantages of relay map are summarized as follows:
(1) Read at any time without extra process: As discussed before, with 
relay map, bpf programs can keep writing into the buffer and users can 
read at any time.

(2) Custom data format: Unlike perfbuf processing data entry by entry 
(or event), the data format of relay is up to users. It could be simple 
string, or binary struct with a header, which provides users with high 
flexibility.

(3) Better performance: Due to the simple design, relay outperforms 
perfbuf in current bench_ringbufs (I added a relay map case to 
`tools/testing/selftests/bpf/benchs/bench_ringbufs.c` without other 
changes). Note that relay outputs data directly without notification, 
and the consumer can get a batch of samples using read() at a time.

Single-producer, parallel producer, sampled notification
========================================================
relaymap             51.652 ± 0.007M/s (drops 0.000 ± 0.000M/s)
rb-libbpf            22.773 ± 0.015M/s (drops 0.000 ± 0.000M/s)
rb-custom            23.782 ± 0.004M/s (drops 0.000 ± 0.000M/s)
pb-libbpf            18.506 ± 0.007M/s (drops 0.000 ± 0.000M/s)
pb-custom            19.503 ± 0.007M/s (drops 0.000 ± 0.000M/s)

Single-producer, back-to-back mode
==================================
relaymap             44.771 ± 0.014M/s (drops 0.000 ± 0.000M/s)
rb-libbpf            25.091 ± 0.013M/s (drops 0.000 ± 0.000M/s)
rb-libbpf-sampled    24.779 ± 0.018M/s (drops 0.000 ± 0.000M/s)
rb-custom            27.784 ± 0.012M/s (drops 0.000 ± 0.000M/s)
rb-custom-sampled    27.414 ± 0.017M/s (drops 0.000 ± 0.000M/s)
pb-libbpf             1.409 ± 0.000M/s (drops 0.000 ± 0.000M/s)
pb-libbpf-sampled    18.467 ± 0.005M/s (drops 0.000 ± 0.000M/s)
pb-custom             1.415 ± 0.000M/s (drops 0.000 ± 0.000M/s)
pb-custom-sampled    19.913 ± 0.007M/s (drops 0.000 ± 0.000M/s)


Thanks.

> Earlier you said:
> "I can use BPF_F_PRESERVE_ELEMS flag to keep the
> perf_events, but I do not know how to get the buffer again in a new process.
> "
> 
> Looks like the issue is lack of map_fd_sys_lookup_elem callback ?
> Solve the latter part.
> perf_event_array_map should be pinnable like any other map,
> so there is a way to get an FD to a map in a new process.
> What's missing is a way to get an FD to perf event itself.

