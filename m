Return-Path: <bpf+bounces-1647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B25571F889
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 04:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2AB1C21179
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD8F15BF;
	Fri,  2 Jun 2023 02:39:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE515B2
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 02:39:58 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D217C192;
	Thu,  1 Jun 2023 19:39:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QXRzr0mfrz4f3tDr;
	Fri,  2 Jun 2023 10:39:52 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDnUCt2VnlkSnKEKA--.16099S2;
	Fri, 02 Jun 2023 10:39:53 +0800 (CST)
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 Hou Tao <houtao1@huawei.com>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
 <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
 <986216a3-437a-5219-fd9a-341786e9264b@huaweicloud.com>
 <20230504020051.xga5y5dj3rxobmea@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <d3169329-1453-e87a-fbb0-e1435f0741dc@huaweicloud.com>
 <CAADnVQ+yK700YFHBQx5-UpxkqhgK-SyL=b=vCXJb448WvSHkEQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1b64fc4e-d92e-de2f-4895-2e0c36427425@huaweicloud.com>
Date: Fri, 2 Jun 2023 10:39:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+yK700YFHBQx5-UpxkqhgK-SyL=b=vCXJb448WvSHkEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDnUCt2VnlkSnKEKA--.16099S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrW5tF4fury8Kr1DGF47twb_yoW7Ww1rpr
	18Jr1UJryUJr18Jr18Jr1UJryUJF1UJw1DJr1UJF18Jr1UJr1jqr1UXr1jgr15Jr48Jr1U
	JryUJr1UZr1UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/2/2023 1:36 AM, Alexei Starovoitov wrote:
> On Wed, May 3, 2023 at 7:30 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Construct the patch series as:
>>> - prep patches
>>> - benchmark
>>> - unconditional convert of bpf_ma to REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace
>>>   with numbers from bench(s) before and after this patch.
>> Thanks again for the suggestion. Will do in v4.
>
> It's been a month. Any update?
>
> Should we take over this work if you're busy?
Sorry for the delay. I should post some progress information about the
patch set early. The patch set is simpler compared with v3, I had
implemented v4 about two weeks ago. The problem is v4 don't work as
expected: its memory usage is huge compared with v3. The following is
the output from htab-mem benchmark:

overwrite:
Summary: loop   11.07 ±    1.25k/s, memory usage  995.08 ±  680.87MiB,
peak memory usage 2183.38MiB
batch_add_batch_del:
Summary: loop   11.48 ±    1.24k/s, memory usage 1393.36 ±  780.41MiB,
peak memory usage 2836.68MiB
add_del_on_diff_cpu:
Summary: loop    6.07 ±    0.69k/s, memory usage   14.44 ±    2.34MiB,
peak memory usage   20.30MiB

The direct reason for the huge memory usage is slower RCU grace period.
The RCU grace period used for reuse is much longer compared with v3 and
it is about 100ms or more (e.g, 2.6s). I am still trying to find out the
root cause of the slow RCU grace period. The first guest is the running
time of bpf program attached to getpgid() is longer, so the context
switch in bench is slowed down. The hist-diagram of getpgid() latency in
v4 indeed manifests a lot of abnormal tail latencies compared with v3 as
shown below.

v3 getpid() latency during overwrite benchmark:
@hist_ms:
[0]               193451
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                  767
|                                                    |
[2, 4)                75
|                                                    |
[4, 8)                 1
|                                                    |

v4 getpid() latency during overwrite benchmark:
@hist_ms:
[0]                86270
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                31252
|@@@@@@@@@@@@@@@@@@                                  |
[2, 4)                 1
|                                                    |
[4, 8)                 0
|                                                    |
[8, 16)                0
|                                                    |
[16, 32)               0
|                                                    |
[32, 64)               0
|                                                    |
[64, 128)              0
|                                                    |
[128, 256)             3
|                                                    |
[256, 512)             2
|                                                    |
[512, 1K)              1
|                                                    |
[1K, 2K)               2
|                                                    |
[2K, 4K)               1
|                                                    |

I think the newly-added global spin-lock in memory allocator and
irq-work running under the context of free procedure may lead to
abnormal tail latency and I am trying to demonstrate that by using
fine-grain locks and kworker (just temporarily). But on the other side,
considering the number of abnormal tail latency is much smaller compared
with the total number of getpgid() syscall, so I think maybe there is
still other causes for the slow RCU GP.

Because the progress of v4 is delayed, so how about I post v4 as soon as
possible for discussion (maybe I did it wrong) and at the same time I
continue to investigate the slow RCU grace period problem (I will try to
get some help from RCU community) ?

Regards,
Tao


