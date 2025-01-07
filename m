Return-Path: <bpf+bounces-48050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B11FA037C2
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 07:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C701163E3C
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 06:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10B1DE3AA;
	Tue,  7 Jan 2025 06:16:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E301DD543;
	Tue,  7 Jan 2025 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230568; cv=none; b=qrIlyKXaqMLdkm3nC/aGm+fmTg9cxsB+RsT75RJ7sAMYVSUdw+61sdijHTC8iPvsaY2XfySgro5OuyTnhbikOtO5TYqA+UFnx05WYnyQ3T/Z2zVoh0N2pkE3CdWvpSFhnfzjnHGjKA1pwlkGsj5b93d0EKeSzOcos77HPW3myGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230568; c=relaxed/simple;
	bh=6qigaCJI7jPGiRLXGrw413iothpRqqC7zQtgW+r1qzU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CL3pONXyEI/9r3io2tWRw42qszcgrqC7iOLkErpAqbjj+ZuPPnlFtDo+53Xvo6X2XqaWJl6RE8WMwckCl0qkDM50Z6dBFJ+r+KkgQYbagQOpDRaqRux4jbXjx0Ys9OR1wfNYlE7LQsJCW2fR6XleAG/ikvfsJqC23ikCArUOFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YS14l6l86z4f3jXP;
	Tue,  7 Jan 2025 14:15:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 161501A15F9;
	Tue,  7 Jan 2025 14:15:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgA3mFyYxnxnOsEUAQ--.60863S2;
	Tue, 07 Jan 2025 14:15:55 +0800 (CST)
Subject: Re: [PATCH] bpf: fix range_tree_set error handling
To: Soma Nakata <soma.nakata@somane.sakura.ne.jp>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20250106231536.52856-1-soma.nakata@somane.sakura.ne.jp>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ab96c4f1-fdf3-a657-fb5c-14c57d3859bc@huaweicloud.com>
Date: Tue, 7 Jan 2025 14:15:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250106231536.52856-1-soma.nakata@somane.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgA3mFyYxnxnOsEUAQ--.60863S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy5Xw17uFW3Jr15Kr1UAwb_yoWDCrg_Cr
	W09r93urZ8G3W2gFy7Wr4Fgr93t393Kr109w1IyFsrXwn8Ga1kGwsakr13ZrykCr43KFZ7
	Arsavr92yr17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/7/2025 7:15 AM, Soma Nakata wrote:
> `range_tree_set` might fail and return -ENOMEM,
> causing subsequent `bpf_arena_alloc_pages` to fail.
> Added the error handling.
>
> Signed-off-by: Soma Nakata <soma.nakata@somane.sakura.ne.jp>
> ---
>  kernel/bpf/arena.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 41a76ca56040..4b22a651b5d5 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -138,7 +138,11 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>  	INIT_LIST_HEAD(&arena->vma_list);
>  	bpf_map_init_from_attr(&arena->map, attr);
>  	range_tree_init(&arena->rt);
> -	range_tree_set(&arena->rt, 0, attr->max_entries);
> +	err = range_tree_set(&arena->rt, 0, attr->max_entries);
> +	if (err) {
> +		bpf_map_area_free(arena);
> +		goto err;
> +	}
>  	mutex_init(&arena->lock);
>  
>  	return &arena->map;

The fix is straightforward, so

Acked-by: Hou Tao <houtao1@huawei.com>


