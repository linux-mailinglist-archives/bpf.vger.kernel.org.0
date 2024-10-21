Return-Path: <bpf+bounces-42642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559CA9A6BB6
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A83E1C22D3A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DCF1F472D;
	Mon, 21 Oct 2024 14:09:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C521EF939
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519788; cv=none; b=FsNcsaNbBfsZP/WpxkDdZ7xi/87Ug3nsFXtHd6gfVxts1dyKwnIUxzuo2tPjiFfIcH0aJla4lHpB9jJEICj77VVbx7A74wPgL8jz+rnJoWi44tx+IkIwMnErgSmT0HtsmsrOg+rWlIdDZ2h1gyC54bmTA3/9KgFwrzhYMh7MNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519788; c=relaxed/simple;
	bh=tB6O8Ue2Iic+7J21Gr8GDx1pE4J1Ys7HCmldmEv799k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ilIX3feY1PkVheo8/MYckiHCKO9lxyBqXC9dLoyoztwXNoufVt2oCU420a/bUpByGm8Xg2jOLRNJZnfTKO/NZjfXvqbRzw7adkGrUWfVelp7CZbopWxVSFi7kKbBMeqWFPwb1loK8mycKRbY/wVrpfPmPopUq40UVHcxGPN/n4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXHHb2Ht9z4f3l8x
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 22:09:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8E3F81A0568
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 22:09:43 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC36sakYBZnQpviEg--.61861S2;
	Mon, 21 Oct 2024 22:09:43 +0800 (CST)
Subject: Re: [PATCH bpf-next 00/16] Support dynptr key for hash map
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 xukuohai@huawei.com
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <2fcb579b5f35c600c542f677da94e0e9b30b6199.camel@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <851f31d7-e749-b554-9268-53795e57ae8f@huaweicloud.com>
Date: Mon, 21 Oct 2024 22:09:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2fcb579b5f35c600c542f677da94e0e9b30b6199.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC36sakYBZnQpviEg--.61861S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWFyfZr1xZFyxJFWfAw1DZFb_yoWxXFXEgF
	W0vryDAw4jvr42qr43CasrJF43tayjq345Zryvk3srKFyUXF98XanrWrZ7Z3WrJFZ3Jr9I
	grZ3A3s8G3y2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUzo7KUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/12/2024 6:11 AM, Eduard Zingerman wrote:
> On Tue, 2024-10-08 at 17:14 +0800, Hou Tao wrote:
>
> [...]
>
>> As usual, comments and suggestions are always welcome.
> fwiw, I've read through the patches in the series and code changes
> seem all to make sense. Executing selftests with KASAN enabled also
> does not show any issues.

Thanks for the review and test.
>
> Maybe add benchmarks in v2?

I have written a benchmark to compare the performance between the normal
hash table and the dynptr-key hash map (this is the source of the
benchmark data in cover letter). However, it was not polished when I
posted v1. Will include it in v2.


