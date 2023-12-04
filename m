Return-Path: <bpf+bounces-16566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61535802DF5
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 10:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BC11F211F8
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4414F94;
	Mon,  4 Dec 2023 09:12:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C0CD2
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 01:12:17 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SkHx52zLDz4f3mHR
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 17:12:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 148C21A076F
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 17:12:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAHabfql21l18CnCg--.17454S2;
	Mon, 04 Dec 2023 17:12:13 +0800 (CST)
Subject: Re: [PATCH bpf v4 7/7] selftests/bpf: Test outer map update
 operations in syscall program
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
References: <20231130140120.1736235-1-houtao@huaweicloud.com>
 <20231130140120.1736235-8-houtao@huaweicloud.com>
 <20231203190410.qcyu3qmdkxavim2t@macbook-pro-49.dhcp.thefacebook.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <db491a00-81ad-9c9b-7ab1-e75742730994@huaweicloud.com>
Date: Mon, 4 Dec 2023 17:12:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231203190410.qcyu3qmdkxavim2t@macbook-pro-49.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAHabfql21l18CnCg--.17454S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4UKr4UKFWrZr1UGryDJrb_yoWfAwc_uF
	ykCr1kGrs8tryDtr15AF1kJF9rGasxuasrKFW8XFsrZr1DArWrZF9Y9ayDAw1xWw47JF9x
	ZFs8twnIgr42gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

Hi,

On 12/4/2023 3:04 AM, Alexei Starovoitov wrote:
> On Thu, Nov 30, 2023 at 10:01:20PM +0800, Hou Tao wrote:
>>  
>> -	prog_load_attr.license = (long) license;
>> -	prog_load_attr.insns = (long) insns;
>> +	prog_load_attr.license = (unsigned long)license;
>> +	prog_load_attr.insns = (unsigned long)insns;
> Maybes keep it as (long) ?
> There are plenty of case where we cast a pointer to (long) because
> it's less verbose. Signedness shouldn't really matter.

It matters for 32-bits host. Because insns and license are the pointers
in kernel space, so the MSB of these pointer must be 1 under 32-bits
host. Assuming the value of license is 0xc000-0000, if using (u64)(long)
to cast the value of license, the final value will be
0xffff-ffff-c000-0000, instead of 0x0000-0000-c000-0000.

> Or use ptr_to_u64().

Will add and use ptr_to_u64() in v5. Thanks for all these suggestions.
>
> pw-bot: cr


