Return-Path: <bpf+bounces-43988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79379BC348
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231E9B2135F
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B91242AA3;
	Tue,  5 Nov 2024 02:39:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B933987;
	Tue,  5 Nov 2024 02:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730774355; cv=none; b=KHO91ArWbCs49oJ6RLOdp/jd5gok8N9IJ1whe7A6IlqSRKQRgwr9QyxnedL3sGIgIV+r8gGjpDnjb+lQrsuLHEGtBO7bKzeitaMN9IsH/PTMNVNUj+nXGg4yKfDaltp+6Vs3mvWFwP7Zmkya//45UWqMZzZUg1cCNVzv7MkkNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730774355; c=relaxed/simple;
	bh=3dlYcn7aZzqdueWTNf/V65Mx0ZwJAYLnxDp1PVl80KE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rRYKRp1QnscWmXFOPGv6OqHqSibhWCTtVrxfBZ6h7k2FeA3/DAAc4rTY8t9Y8u5YMQVjDjH7bDqwRqH9XT/qkJi4gxf+AMjXGktlxWNihrB+7B0kob45EbpGNXqFaB2uMsZEZQrQe91TXnpjZtqVcT5XVph5oo7ahwbxpkNc0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XjCFk6wZ1z4f3jXP;
	Tue,  5 Nov 2024 10:38:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E07891A07B6;
	Tue,  5 Nov 2024 10:39:08 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgA35uJMhSlnbsyDAw--.48440S2;
	Tue, 05 Nov 2024 10:39:08 +0800 (CST)
Subject: Re: [PATCH bpf] selftests/bpf: Add a copyright notice to
 lpm_trie_map_get_next_key
To: Byeonguk Jeong <jungbu2855@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZycSXwjH4UTvx-Cn@ub22>
 <925cb852-df24-81b6-318a-ee6a628d43c7@huaweicloud.com>
 <ZygrNkfNVUmc74ZG@byeonguk.jeong>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <13c99b61-782c-ff4c-b8ee-5e3497cf0e8a@huaweicloud.com>
Date: Tue, 5 Nov 2024 10:39:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZygrNkfNVUmc74ZG@byeonguk.jeong>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgA35uJMhSlnbsyDAw--.48440S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/4/2024 10:02 AM, Byeonguk Jeong wrote:
> Okay, then do I need to resend this patch or it would be accepted anyway?
>
> .
It is decided by the maintainer. In my opinion, the patch is not urgent,
so I think you can repost the patch later after v6.12 is released and
change the target tree as bpf-next instead of bpf.


