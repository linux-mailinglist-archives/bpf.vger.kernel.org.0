Return-Path: <bpf+bounces-45129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0719D1CEA
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 02:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739B31F2255E
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0103022067;
	Tue, 19 Nov 2024 01:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7F38FA3
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978375; cv=none; b=Q/fK8nEBL2bddQh5nASan2v+x5xXKzxE2BhhsTGSJfQJeWpA9ebFPukSSkB2lbZC0Fg/EHeqNP0gu/MrumAOhZrrT/7C4WY028+U/KRZxgQY6Q3yC1Jerl/hTJkNgXXdyK5VoARuwDGJlfHr51ivrKkjxnSIkczcMhHyQ+6AO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978375; c=relaxed/simple;
	bh=LRmXz3mDaUpyddG295knED4lRm0vjVAziZ00jQ05seU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S4KozH6X9DI8f9S9lgoA07akNLQbvF02MVcyKofVXYNnCNmG0XgZ3T0ucN8kxSquOMhKennKFFL5DU05cTYaWDI8v73eHCuTEJvcgRJuSphmRXwHF5R+J18PZD9tDlfBUKyfNGxc4+qdtE9uDgZFuaqBOXW5Zzg75x1enZ5ECOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XsmWr3t6bz4f3jXv
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:05:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 040131A0568
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:06:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAHtOB25DtnlmSyCA--.64157S2;
	Tue, 19 Nov 2024 09:06:02 +0800 (CST)
Subject: Re: [PATCH bpf-next 04/10] bpf: Handle in-place update for full LPM
 trie correctly
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-5-houtao@huaweicloud.com>
 <20241118131327.7s83iQCp@linutronix.de>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5bd07cd9-d3dc-d990-a998-de43df1a9d72@huaweicloud.com>
Date: Tue, 19 Nov 2024 09:05:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241118131327.7s83iQCp@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAHtOB25DtnlmSyCA--.64157S2
X-Coremail-Antispam: 1UD129KBjvdXoWrCw43WryDGFW5ZFWkZw1UJrb_yoWxWFc_ua
	1vv3sYkrZYqFnxGwnrAw4qgF9Igw48ZFyUGFs5Gr9rZFnYva9a9F40krn5ZrW7XFs7twnr
	CFZYqasIg34a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 11/18/2024 9:13 PM, Sebastian Andrzej Siewior wrote:
> On 2024-11-18 09:08:02 [+0800], Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When a LPM trie is full, in-place updates of existing elements
>> incorrectly return -ENOSPC.
>>
>> Fix this by deferring the check of trie->n_entries. For new insertions,
>> n_entries must not exceed max_entries. However, in-place updates are
>> allowed even when the trie is full.
> This and the previous patch look like a fix to an existing problem.
> Shouldn't both have a fixes tag?

Will add in v2. Thanks for the suggestion.
>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Sebastian


