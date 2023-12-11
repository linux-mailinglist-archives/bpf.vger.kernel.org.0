Return-Path: <bpf+bounces-17357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3338480BEE6
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 03:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C6F280CA0
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 02:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDD511C81;
	Mon, 11 Dec 2023 02:07:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA09F1
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 18:07:18 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SpQ9X45qZz4f3kFp
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:07:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EF2241A01A5
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:07:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAnibfPbnZlKMQNDQ--.29334S2;
	Mon, 11 Dec 2023 10:07:14 +0800 (CST)
Subject: Re: [PATCH bpf-next 7/7] bpf: Wait for sleepable BPF program in
 maybe_wait_bpf_programs()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
 <20231208102355.2628918-8-houtao@huaweicloud.com>
 <CAADnVQKZfvDQUuzJ98n5Q6a1xU5XBxFGi0PeEnmRxj_TFKoW1A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <bcaeae84-766c-5e3c-d444-70015ada7765@huaweicloud.com>
Date: Mon, 11 Dec 2023 10:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKZfvDQUuzJ98n5Q6a1xU5XBxFGi0PeEnmRxj_TFKoW1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAnibfPbnZlKMQNDQ--.29334S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyrCr4fKF1xGr4fKFyfWFg_yoW3Krb_J3
	92vw1kGwn3G393AanxGF45tr4fGFZY9F1DKrWUWrZIkryfZ3s5WF4kuryfC343KFWUXFn8
	Gry3Ja4xCrnIqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Alexei,

On 12/10/2023 10:11 AM, Alexei Starovoitov wrote:
> On Fri, Dec 8, 2023 at 2:22 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> +       /* Wait for any running non-sleepable and sleepable BPF programs to
>> +        * complete, so that userspace, when we return to it, knows that all
>> +        * programs that could be running use the new map value.
> which could be forever... and the user space task doing simple map update
> will never know why it got stuck in syscall waiting... forever...
> synchronous waiting for tasks_trace is never an option.

Could you please elaborate the reason why there is dead-lock problem ? 
In my naive understanding, synchronize_rcu_tasks_trace() only waits for
the end of rcu_read_lock_trace()/rcu_read_unlock_trace(), if there is no
rcu_read_lock_trace being held, there will be no dead-lock.


