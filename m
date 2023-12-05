Return-Path: <bpf+bounces-16686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96716804427
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5272F281418
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C06C17E4;
	Tue,  5 Dec 2023 01:37:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E95F0
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 17:36:56 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SkjnF0tSFz4f3l1r
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 09:36:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C6E451A0282
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 09:36:53 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB3hUWxfm5lOCFmCw--.2625S2;
	Tue, 05 Dec 2023 09:36:51 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Use GFP_KERNEL in bpf_event_entry_gen()
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20231113141207.1459002-1-houtao@huaweicloud.com>
Message-ID: <b02930cf-9e0f-a842-1031-bbf8b948bfdf@huaweicloud.com>
Date: Tue, 5 Dec 2023 09:36:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231113141207.1459002-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB3hUWxfm5lOCFmCw--.2625S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4UWr1rKryxJF4UZrW7XFb_yoWfZFX_Ww
	4IkFy5Grs8J3Waqa109rs5Wrs3Kry8X3WDA3yUtrW2qr15Zan3ZrsY9FyfuryDXas7uF95
	trn3XwsFvr45ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UQzVbUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

ping ?

On 11/13/2023 10:12 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The simple patchset aims to replace GFP_ATOMIC in bpf_event_entry_gen().
> These two patches in the patchset were preparatory patches in "Fix the
> release of inner map" patchset [1] and are not needed for v2, so re-post
> it to bpf-next tree.
>
> Patch #1 reduces the scope of rcu_read_lock when updating fd map and
> patch #2 replaces GFP_ATOMIC by GFP_KERNEL. Please see individual
> patches for more details.
>
> Comments are always welcome.
>
> Regards,
> Tao
>
> [1]: https://lore.kernel.org/bpf/20231107140702.1891778-1-houtao@huaweicloud.com
>
> Hou Tao (2):
>   bpf: Reduce the scope of rcu_read_lock when updating fd map
>   bpf: Use GFP_KERNEL in bpf_event_entry_gen()
>
>  kernel/bpf/arraymap.c | 2 +-
>  kernel/bpf/hashtab.c  | 2 ++
>  kernel/bpf/syscall.c  | 4 ----
>  3 files changed, 3 insertions(+), 5 deletions(-)
>


