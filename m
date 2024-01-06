Return-Path: <bpf+bounces-19156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165A825DEC
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 03:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0964628493F
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 02:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C7F15C4;
	Sat,  6 Jan 2024 02:32:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E615AB
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T6PVf5Yqkz4f3jHl
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 10:32:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 28F991A0BCD
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 10:32:30 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBnyri6u5hlinM7Fg--.4854S2;
	Sat, 06 Jan 2024 10:32:29 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Test the inlining of
 bpf_kptr_xchg()
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20240105104819.3916743-1-houtao@huaweicloud.com>
 <20240105104819.3916743-4-houtao@huaweicloud.com>
 <2d2ed98e8d4c5386b03f5c04bab7c439c9bbaffa.camel@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1ce6d697-49f0-7b13-50d7-de3dcd8bcf13@huaweicloud.com>
Date: Sat, 6 Jan 2024 10:32:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2d2ed98e8d4c5386b03f5c04bab7c439c9bbaffa.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBnyri6u5hlinM7Fg--.4854S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF43tr13CrWfXryftFWxtFb_yoW3uFbE9a
	y0vF9xCw45WF4xZF1UZrZIqF97Can7WF15Gr1Dtr9F9F9xAFZ5Cas8ZrnYyw4fur4xJFZx
	twn0qr43A347WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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



On 1/5/2024 9:26 PM, Eduard Zingerman wrote:
> On Fri, 2024-01-05 at 18:48 +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The test uses bpf_prog_get_info_by_fd() to obtain the xlated
>> instructions of the program first. Since these instructions have
>> already been rewritten by the verifier, the tests then checks whether
>> the rewritten instructions are as expected. And to ensure LLVM generates
>> code exactly as expected, use inline assembly and a naked function.
>>
>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Thank you for this adjustment.

And thanks for the suggestions. Due to these great suggestions, I have
learned how to write BPF assembly code.


