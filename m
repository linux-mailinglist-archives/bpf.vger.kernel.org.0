Return-Path: <bpf+bounces-44023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE19BC924
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 10:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C721F23985
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA431D041D;
	Tue,  5 Nov 2024 09:30:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCB1D0DC4;
	Tue,  5 Nov 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799006; cv=none; b=egxoAjBo/9PjTTFtOwMyfRmXpZ7CfGhAryzdqnKs3NIMlb0nn/6rBy7rZqBJiOHaTTF5f2Zg2nrbLRhL7CjvOgsv5PudRlLfvtFEVu7SNrHeU1hCPHVklKu1qsXaK3iAHHuH5RTQlDNxsHu3A/S4DPMDhHujaSTpv9zFAGaT6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799006; c=relaxed/simple;
	bh=IXIW+HJZMlx+onFVtov5lZBp2suvREm9OpppOYyrBTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVmTkc5B5mmTAosm7Ls9+vAaV2K5xQz4V8qqNui+OcMnXOX4bZGdkfjodVCNPmQ96did24DDlPxF7DLqOb+7ND1SPCeRolZVn+Dd/4ilCNX6utr+Vb9wHYQ9IPok1MK2EP/FGN/T+4YIroNErPHwOdNyAdYBQXH0DfKYXwtHTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XjNMw1kT6z4f3kk3;
	Tue,  5 Nov 2024 17:29:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 143491A058E;
	Tue,  5 Nov 2024 17:30:01 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDnj7GH5Slnk02NAw--.34665S3;
	Tue, 05 Nov 2024 17:30:00 +0800 (CST)
Message-ID: <d8f7ca59-9bcb-4934-bf0d-91f75ab1c1d9@huaweicloud.com>
Date: Tue, 5 Nov 2024 17:30:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel symbol for struct_ops
 trampoline
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
 <CAADnVQKnJkJpWkuxC32UPc4cvTnT2+YEnm8TktrEnDNO7ZbCdA@mail.gmail.com>
 <5c16fb2f-efa2-4639-862d-99acbd231660@huaweicloud.com>
 <CAADnVQLvpwLp=t1oz3ic-EKnaio2DhOCanmuBQ+8nSf-jzBePw@mail.gmail.com>
 <85160853-cc20-40df-b090-62b4359bec37@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <85160853-cc20-40df-b090-62b4359bec37@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDnj7GH5Slnk02NAw--.34665S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1xuFWUGF45AryUKrWUCFg_yoWfXrX_uw
	sYvrnrJw13G392gr9YkF1fG39ruryrZ340vryFq3s5t3s8tFn8Aw4DCF1YvF98Ga18Arsr
	Zw4qqrWYvFW7XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbD8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtV
	W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jehFxUUUUU
	=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/5/2024 6:13 AM, Martin KaFai Lau wrote:
> On 11/4/24 9:53 AM, Alexei Starovoitov wrote:
> 
>> As a separate clean up I would switch the freeing to call_rcu_tasks.
>> Synchronous waiting is expensive.
>>
>> Martin,
>>
>> any suggestions?
> 
> There is a map->rcu now. May be add a "bool free_after_rcu_tasks_gp" to "struct bpf_map" and do the call_rcu_tasks() in bpf_map_put(). The bpf_struct_ops_map_alloc() can set the map->free_after_rcu_tasks_gp.
> 
> Take this chance to remove the "st_map->rcu" from "struct bpf_struct_ops_map" also. It is a left over after cleaning up the kvalue->refcnt in the
> commit b671c2067a04 ("bpf: Retire the struct_ops map kvalue->refcnt.").
> 
> Xu, it will be great if you can follow up with this cleanup. Otherwise, I will put it under the top of my todo list. Let me know what you prefer.

Sure, I'll take this cleanup, thanks.


