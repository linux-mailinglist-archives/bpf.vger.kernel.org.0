Return-Path: <bpf+bounces-41384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DF996758
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 12:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409422844FD
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025AF168C3F;
	Wed,  9 Oct 2024 10:32:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA171C6BE;
	Wed,  9 Oct 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469925; cv=none; b=QvDtEyV4VZy11NeIfh0w9cIu3rKsyD9WLli0l1PC5lFgvd6E5oc8cszg/aWrJ3LSq+9jLplN88rVqiHzWRG05xysCQR3MhnEi7rKg6PTlrziCGde1rgxL9vrI2/T5whTeR0pr3olO+dTeAj8O3BCZcbT2t1JOP0ldjBqi4brNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469925; c=relaxed/simple;
	bh=QvtfR7BhG8sulKALwtMeEvVd+Q2wyrwjlIV3/0y5/HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfjSxhGs9CPeuUdRRIHXV5ahPD2RHB4Y4XaBgL7nxZ7P4VJtiah2G56STB0kJL1RO/f6EiTrowrqaL/lbC+tjgsUT1HXhnF6ipBKx6iUlwj6oZpEVbHqLxYL2RPgRSCy70qmFC1Fg3dflarO3Uy1rYNcYilaPhBtq1QgkIOI6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNq1n28ZTz4f3mHR;
	Wed,  9 Oct 2024 18:31:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DB26C1A018D;
	Wed,  9 Oct 2024 18:31:58 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP2 (Coremail) with SMTP id Syh0CgB3q2CdWwZnmZ9lDg--.1143S2;
	Wed, 09 Oct 2024 18:31:58 +0800 (CST)
Message-ID: <bc137f2e-4375-4174-8985-c5fe31fbbf98@huaweicloud.com>
Date: Wed, 9 Oct 2024 18:31:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] riscv, bpf: Fix possible infinite tailcall when
 CONFIG_CFI_CLANG is enabled
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20241008124544.171161-1-pulehui@huaweicloud.com>
 <87jzeh4qvv.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87jzeh4qvv.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3q2CdWwZnmZ9lDg--.1143S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1UWFyUKF45JrW3tF4ruFg_yoWDWFc_uF
	WSyr9ag3y5Ja1Ik3W8ur4UW3srCrWj9ryUX3W5t3sxGa93Jws5uw4vqrs2yrWxZ393XFyq
	yF45tFWIgw429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jIks
	gUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/10/9 16:33, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> When CONFIG_CFI_CLANG is enabled, the number of prologue instructions
>> skipped by tailcall needs to include the kcfi instruction, otherwise the
>> TCC will be initialized every tailcall is called, which may result in
>> infinite tailcalls.
>>
>> Fixes: e63985ecd226 ("bpf, riscv64/cfi: Support kCFI + BPF on riscv64")
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> Thanks! Did you test this with the selftest suite? Did the tailcall
> tests catch it?

Oh, I discovered it through code review.

I just tried llvm compilation but it seems that my environment cannot 
compile bpf selftests. I need to find why.

But after reading the tailcalls testcase, I found that the tailcall_3 
subtest can cover this scenario as it will verify the TCC value.

> 
> Note to self is that I should run kCFI enabled tests for RISC-V.
> 
> 
> Acked-by: Björn Töpel <bjorn@kernel.org>


