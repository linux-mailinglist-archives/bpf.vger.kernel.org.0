Return-Path: <bpf+bounces-18638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716E781D20F
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 05:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEFAB2261D
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 04:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BD91113;
	Sat, 23 Dec 2023 04:01:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2715BD
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sxr7M0Bckz4f3l0y
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 12:01:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4F3D81A0A8E
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 12:01:08 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDXe0qAW4ZlCckMEg--.50411S2;
	Sat, 23 Dec 2023 12:01:08 +0800 (CST)
Subject: Re: [PATCH bpf-next 2/3] bpf, x86: Don't generate lock prefix for
 BPF_XCHG
To: Hou Tao <houtao@huaweicloud.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
 <20231219135615.2656572-3-houtao@huaweicloud.com>
 <7f682450-e165-26a9-1247-ef1440d9b7a2@iogearbox.net>
 <CAADnVQKZAsLhZEd8E4_jODJq=V+DexcVCrmifvYNaFwpcbXLgw@mail.gmail.com>
 <1b1c23b6-467e-d645-cbcb-0c51db2203a1@iogearbox.net>
 <0afcb79f-d7b7-5c2a-f2d0-ae0e67f3441c@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <fd94efb9-4a56-c982-dc2e-c66be5202cb7@huaweicloud.com>
Date: Sat, 23 Dec 2023 12:01:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0afcb79f-d7b7-5c2a-f2d0-ae0e67f3441c@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDXe0qAW4ZlCckMEg--.50411S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWxtr1UuFWxKr1kAFWxtFb_yoWrXF43pF
	Z3GF43trW8Jwn7Zwn7t3s3XF12q3yrXFWrGrZ0yr4kC3ZIgr1vgF9F934293s8ArZ7Cr1f
	JF1Ut343X3Z8ZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/21/2023 7:37 PM, Hou Tao wrote:
> Hi,
>
> On 12/21/2023 2:46 AM, Daniel Borkmann wrote:
>> On 12/20/23 7:25 PM, Alexei Starovoitov wrote:
>>> On Wed, Dec 20, 2023 at 6:58 AM Daniel Borkmann
>>> <daniel@iogearbox.net> wrote:
>>>> On 12/19/23 2:56 PM, Hou Tao wrote:
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>
>>>>> According to the implementation of atomic_xchg() under x86-64, the
>>>>> lock
>>>>> prefix is not necessary for BPF_XCHG atomic operation, so just remove
>>>>> it.
>>>> It's probably a good idea for the commit message to explicitly quote
>>>> the
>>>> Intel docs in here, so it's easier to find on why the lock prefix would
>>>> not be needed for the xchg op.
>>> It's a surprise to me as well.
>>> Definitely more info would be good.
>>>
>>> Also if xchg insn without lock somehow implies lock in the HW
>>> what is the harm of adding it explicitly?
>>> If it's a lock in HW than performance with and without lock prefix
>>> should be the same, right?
>> e.g. 7.3.1.2 Exchange Instructions says:
>>
>>   The XCHG (exchange) instruction swaps the contents of two operands.
>> This
>>   instruction takes the place of three MOV instructions and does not
>> require
>>   a temporary location to save the contents of one operand location while
>>   the other is being loaded. When a memory operand is used with the XCHG
>>   instruction, the processor’s LOCK signal is automatically asserted.
>>
>> Also curious if there is any harm adding it explicitly.
>>
>> .
> I could use the bpf ma benchmark to test it, but I doubt it will make
> any visible difference.
>
> .

The following is the performance comparison between inlined-kptr-xchg()
without and with lock prefix. It seems for helper without-lock-prefix
the peak free performance is indeed larger than the helper with lock
prefix, but it is so tiny that it may be just fluctuations. So I will
keep the JIT of BPF_XCHG() as-is.


(1) inlined bpf_kptr_xchg() without lock prefix:

$ for i in 1 2 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a; done | grep
Summary
Summary: per-prod alloc   11.50 ± 0.25M/s free   37.52 ± 0.59M/s, total
memory usage    0.00 ± 0.00MiB
Summary: per-prod alloc    8.52 ± 0.14M/s free   34.73 ± 0.46M/s, total
memory usage    0.01 ± 0.00MiB
Summary: per-prod alloc    7.40 ± 0.09M/s free   36.09 ± 0.65M/s, total
memory usage    0.02 ± 0.00MiB
Summary: per-prod alloc    6.62 ± 0.16M/s free   36.48 ± 2.06M/s, total
memory usage    0.07 ± 0.00MiB

$ for j in $(seq 3); do ./bench -w3 -d10 bpf_ma -p1 -a; done | grep Summary
Summary: per-prod alloc   10.81 ± 0.12M/s free   36.78 ± 0.35M/s, total
memory usage    0.00 ± 0.00MiB
Summary: per-prod alloc   10.77 ± 0.07M/s free   35.76 ± 0.37M/s, total
memory usage    0.01 ± 0.00MiB
Summary: per-prod alloc   10.61 ± 0.09M/s free   33.92 ± 0.41M/s, total
memory usage    0.00 ± 0.00MiB

(2) inlined bpf_kptr_xchg() with lock prefix:

$ for i in 1 2 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a; done | grep
Summary
Summary: per-prod alloc   11.10 ± 0.19M/s free   36.07 ± 0.40M/s, total
memory usage    0.00 ± 0.00MiB
Summary: per-prod alloc    8.56 ± 0.13M/s free   35.74 ± 0.55M/s, total
memory usage    0.01 ± 0.00MiB
Summary: per-prod alloc    7.37 ± 0.05M/s free   35.78 ± 0.64M/s, total
memory usage    0.02 ± 0.00MiB
Summary: per-prod alloc    6.57 ± 0.10M/s free   33.72 ± 0.57M/s, total
memory usage    0.07 ± 0.00MiB

$ for j in $(seq 3); do ./bench -w3 -d10 bpf_ma -p1 -a; done | grep Summary
Summary: per-prod alloc   11.51 ± 0.20M/s free   35.42 ± 0.34M/s, total
memory usage    0.00 ± 0.00MiB
Summary: per-prod alloc   11.30 ± 0.08M/s free   34.81 ± 0.35M/s, total
memory usage    0.00 ± 0.00MiB
Summary: per-prod alloc   11.43 ± 0.11M/s free   35.43 ± 0.33M/s, total
memory usage    0.00 ± 0.00MiB



