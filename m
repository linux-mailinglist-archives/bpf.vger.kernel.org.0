Return-Path: <bpf+bounces-43003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1209B9ADA64
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 05:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9DB22977
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84D15B96E;
	Thu, 24 Oct 2024 03:19:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E0156997;
	Thu, 24 Oct 2024 03:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739972; cv=none; b=PtsJHPfDaJlUNde/h4068btzL7s5BiAVHAyInzpp//alm9J6ZCj1MrLMwbduxhMXndTQCTkdWf0J1huFu9irLQJDydti+5iD/nhTWQenfcvH5MSBMDisYBuXNt98s8Ew6kW4DFmeiWp6MEz3rluJO9uBykFt47TqbxAgYS2/QwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739972; c=relaxed/simple;
	bh=eiXoPBhcLW656chQS4im/MiDK2YJB69/S0pvCMxCqVk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ow4Gh18VjTP5fMk6BLRChptdUXHktYRS7gxSm5DDzjuxZ/lt1b/mRk6t1zPiCH9EPHhu2iyRtpE6ka9cV3TLRaZoQhGbOkN5VP7wqydkl0HqSVsdfN+LRgM9uqUMyZW96yT5sNEqJpuLIgCwLVTB0f4Nym+JUn/n2Xy+qusu2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XYrjk4zgXz4f3jLm;
	Thu, 24 Oct 2024 11:19:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EE1321A018D;
	Thu, 24 Oct 2024 11:19:24 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBX94O5vBlnW7YyEw--.40278S2;
	Thu, 24 Oct 2024 11:19:24 +0800 (CST)
Subject: Re: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
To: Byeonguk Jeong <jungbu2855@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
 <26f04a6b-4248-6898-8612-793e02712017@huaweicloud.com>
 <Zxil/uyqq5qDHuRX@localhost.localdomain>
 <da89a4cb-1824-2228-31ef-ad33ad6099cd@huaweicloud.com>
 <ZxmnZWjSRVHgtbGZ@localhost.localdomain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a7cbcc55-0913-fdcb-3100-b9f71817bfaf@huaweicloud.com>
Date: Thu, 24 Oct 2024 11:19:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZxmnZWjSRVHgtbGZ@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBX94O5vBlnW7YyEw--.40278S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF13Aw1fAw4xtFy7uw1rWFg_yoWkCwc_ur
	s8ZF92kw47CFnIgFZayr45Jr9rGFy8tF9rurW8Wr17JryrJanIq3ZxGr9Yvay5Ga13Z343
	tFn09rWrtw13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/24/2024 9:48 AM, Byeonguk Jeong wrote:
> Hi,
>
> On Wed, Oct 23, 2024 at 05:59:53PM +0800, Hou Tao wrote:
>> Alexei suggested adding a bpf self-test for the patch.  I think you
>> could reference the code in lpm_trie_map_batch_ops.c [1] or similar and
>> add a new file that uses bpf_map_get_next_key to demonstrate the
>> out-of-bound problem. The test can be run by ./test_maps. There is some
>> document for the procedure in [2].
>>
>> [1]:  tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
>> [2]:
>> https://github.com/torvalds/linux/blob/master/Documentation/bpf/bpf_devel_QA.rst
> Okay, I will add a new test. Thanks for the detailed guideline.
>
>> Which procedure will return -ENOENT ? I think the element with
>> prefixlen=0 could still be found through the key with prefixlen = 0.
> I mean, BPF_MAP_GET_NEXT_KEY with .prefixlen = 0 would give us -ENOENT,
> as it follows postorder. BPF_MAP_LOOKUP_ELEM still find the element
> with prefixlen 0 through the key with prefixlen 0 as you said.

I see. But considering the element with .prefixlen = 0 is the last one
in the map, returning -ENOENT is expected.
> .


