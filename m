Return-Path: <bpf+bounces-5611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544C575C736
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F66B1C216A1
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5D1BE68;
	Fri, 21 Jul 2023 12:57:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5991D2E8
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 12:57:24 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0B10CB
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 05:57:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6qMb5GBpz4f3jMF
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 20:57:15 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDXyxmqgLpkT_XNNQ--.29737S2;
	Fri, 21 Jul 2023 20:57:18 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] selftests/bpf: improve ringbuf benchmark
 output
To: Andrew Werner <awerner32@gmail.com>, bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev, alexei.starovoitov@gmail.com
References: <20230719201533.176702-1-awerner32@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1499e329-8132-3233-e3ed-79ef0bcb591c@huaweicloud.com>
Date: Fri, 21 Jul 2023 20:57:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230719201533.176702-1-awerner32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDXyxmqgLpkT_XNNQ--.29737S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1kCrWfKFW8Cr1kury8Zrb_yoWDAFg_J3
	Z2vF48ua1jqw1SvrZrKF4DZFy2kF1UAryjy3y7Cw47tFyFywsYva1jqr4I9w1Fqan2kF9I
	gwnxXrn7Jw17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/20/2023 4:15 AM, Andrew Werner wrote:
> The ringbuf benchmarks print headers for each section of benchmarks.
> The naming conventions lead a user of the benchmarks to some confusion.
> This change is a cosmetic update to the output of that benchmark; no
> changes were made to what the script actually executes.
>
> The back-to-back exploration of sample rates for Perfbuf and Ringbuf
> have been combined into a single section.
>
> Some of the variables in the script were renamed for clarity; b is
> always a benchmark name, s is a sampling rate, n is a number of
> producers. Before the change, b was the only variable.
>
> After:
> ```
> Parallel producer
> =================
> rb-libbpf            43.072 ± 0.165M/s (drops 0.940 ± 0.016M/s)
> rb-custom            20.274 ± 0.442M/s (drops 0.000 ± 0.000M/s)
> pb-libbpf            1.480 ± 0.015M/s (drops 0.000 ± 0.000M/s)
> pb-custom            1.492 ± 0.023M/s (drops 0.000 ± 0.000M/s)
>
......
>
> ```
>
> Signed-off-by: Andrew Werner <awerner32@gmail.com>

Acked-by: Hou Tao <houtao1@huawei.com>


