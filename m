Return-Path: <bpf+bounces-49165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35181A14B5D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 09:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F67188D921
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6981F940F;
	Fri, 17 Jan 2025 08:42:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21741F869A
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103366; cv=none; b=Vmk50LhByVbINjD0JbxOhJCp/5yqGJnjrsLIed/tpYizj8poBoN3B/5n/osXGWCxiUpKxBXkv1zFg7iE5vjgykeLm+/tue0qGBDdQexgmhWb4Q6meAwgL9+3YPf62MBSTeDizckw9PECzV96ujSM7Sl447njYYBfGIZvAzs7bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103366; c=relaxed/simple;
	bh=VDspej9NXc6/KOs9/zTmSXm+kCnw928MWK1jGxeucsg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JhxgXb8Dib30LEM7IKfS92Gr/w32lbvawdnj+j0J4oIQuYXd6as/tWlbFniKnOXQ8C0eSk3iA6nAGsCQS8RnoGFrbqmUl3Av4/yoeSwUmpmoI25812eAz4rHk0JK1ghaILegJf+YWta3Ny9NuD4+HPxlFpFQWWBseVctlNOiJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YZCsS3Xppz4f3jXV
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 16:42:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EC16E1A0B41
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 16:42:40 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDnSF38F4pnpp_JBA--.17507S2;
	Fri, 17 Jan 2025 16:42:40 +0800 (CST)
Subject: Re: [PATCH bpf-next] bpf: Alloc bpf_async_cb by using bpf_global_ma
 under PREEMPT_RT
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, xukuohai@huawei.com,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20250114081338.2375090-1-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <65910c67-0e63-07d9-9eab-3c61456297e1@huaweicloud.com>
Date: Fri, 17 Jan 2025 16:42:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250114081338.2375090-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDnSF38F4pnpp_JBA--.17507S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4xGF48urW5GF13Wr13CFg_yoW3KrX_ua
	9YvF4DGr1fZrnak3y3GFW3X3s7Gw40g3W5Xr40qr9ruFyfKw4kt3y8twsxuryrJw48WF9x
	Gwn3KayUXF13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/14/2025 4:13 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Under PREEMPT_RT, it is not safe to use GPF_ATOMIC kmalloc when
> preemption or irq is disabled. The following warning is reported when
> running test_progs under PREEMPT_RT:
>
>   

SNIP
> +	bpf_async_free_rcu(&w->cb);
>  }
>  
>  static void bpf_timer_delete_work(struct work_struct *work)
> @@ -1236,7 +1266,7 @@ static void bpf_timer_delete_work(struct work_struct *work)
>  	 * bpf_timer_cancel_and_free will have been cancelled.
>  	 */
>  	hrtimer_cancel(&t->timer);
> -	kfree_rcu(t, cb.rcu);
> +	bpf_async_free_rcu(&t->cb);
>  }

Er, it is buggy here. migrate_{disable|enable} pair is missed because it
is running under kworker context. Found it when apply the patch after
the patch set "Free htab element out of bucket lock v2". Will send v2
for it.


