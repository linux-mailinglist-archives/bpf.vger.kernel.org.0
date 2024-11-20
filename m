Return-Path: <bpf+bounces-45262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1129D3A84
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 13:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3159128148F
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB81A3BC8;
	Wed, 20 Nov 2024 12:16:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4E19F13B
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104962; cv=none; b=Ea7ZDRpe7hJv1D8hSBaqFNS+Vl0V5ZnUPm518wyjSLZeCTcC0usGNelpioSJmJNR+xlSIGxwYC5+9KooDnEUU5vjfLyaHKQsYO4D6mVZZ5hAS6EdVQuIuUMkXe9v8BCLe7iR6wMWXdEcez7P54iVqUV+JHRyRmf18P68UG+l1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104962; c=relaxed/simple;
	bh=QbIzaMl4lG6UwK87PaYRpMK3NRKioZLxg+UF5I7kVEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/MtcQVROM8D54F8lDapLb/fTP8YdTCrIiXKO3ehw7D/WkBsfL+ZLWCIK7O8u8b1fc9oSKxF3dMbuyI9Cu6GWH6QH+V5O4BR4C40ayfpovaHMAoE8+gafKDVk/U9GhkocyCIQ4fsdoqLW+F1Edt+UeLGuUEAoZnDPvjfvy6pegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XtgLP2HXyz4f3l85
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 20:15:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BFCD21A018D
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 20:15:54 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgAHtuL50j1nJoU_CQ--.30761S2;
	Wed, 20 Nov 2024 20:15:54 +0800 (CST)
Message-ID: <9eb3de07-6802-426a-b59c-bb412d70ccfc@huaweicloud.com>
Date: Wed, 20 Nov 2024 20:15:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v2 3/3] selftests/bpf: add more verifier tests for
 signed range deduction of BPF_AND
Content-Language: en-US
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>, Edward Cree
 <ecree.xilinx@gmail.com>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20241119114023.397450-1-shung-hsi.yu@suse.com>
 <20241119114023.397450-4-shung-hsi.yu@suse.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20241119114023.397450-4-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHtuL50j1nJoU_CQ--.30761S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWxGF4fAw4DJw4DGw4rKrg_yoW8WFWDpr
	yDGrW29FWvyFyDC3WIqF15try5tF9xZanrX34jkryUJ345KFZFqrWUGr45C3s5Wrnavw4S
	vFn8XayDKF4DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/19/2024 7:40 PM, Shung-Hsi Yu wrote:
> Add more specific test cases into verifier_and.c to test against signed
> range deduction.
> 
> WIP, Test failing.
> ---
> The GitHub action is at https://github.com/kernel-patches/bpf/actions/runs/11909088689/
> 
> For and_mixed_range_vs_neg_const()
> 
>    Error: #432/8 verifier_and/[-1,0] range vs negative constant @unpriv
>    ...
>    VERIFIER LOG:
>    =============
>    0: R1=ctx() R10=fp0
>    0: (85) call bpf_get_prandom_u32#7    ; R0_w=Pscalar()
>    1: (67) r0 <<= 63                     ; R0_w=Pscalar(smax=smax32=umax32=0,umax=0x8000000000000000,smin32=0,var_off=(0x0; 0x8000000000000000))
>    2: (c7) r0 s>>= 63                    ; R0_w=Pscalar(smin=smin32=-1,smax=smax32=0)
>    3: (b7) r1 = -13                      ; R1_w=P-13
>    4: (5f) r0 &= r1                      ; R0_w=Pscalar(smin=smin32=-16,smax=smax32=0,umax=0xfffffffffffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3)) R1_w=P-13
>    5: (b7) r2 = 0                        ; R2_w=P0
>    6: (6d) if r0 s> r2 goto pc+4         ; R0_w=Pscalar(smin=smin32=-16,smax=smax32=0,umax=0xfffffffffffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3)) R2_w=P0
>    7: (b7) r2 = -16                      ; R2=P-16
>    8: (cd) if r0 s< r2 goto pc+2 11: R0=Pscalar() R1=P-13 R2=Pscalar() R10=fp0
> 
> 	Somehow despite the verifier knows that r0's smin=-16 and smax=0,
> 	and r2's smin=-16 and smax=-16, it does determine that
> 	[-16, 0] s< -16 is always false.
> 
>    11: (61) r1 = *(u32 *)(r1 +0)
>    R1 invalid mem access 'scalar'
>

Interesting, CI reported failure in unpriv test, while the priv
test ran well. It seems to be related to some security policy.
I think it is bypass_spec_v1, which makes the verifier to check
the unreachable target instruction.


