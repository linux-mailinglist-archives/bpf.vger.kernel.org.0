Return-Path: <bpf+bounces-45134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C789D1D02
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A231F22626
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 01:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA25A77111;
	Tue, 19 Nov 2024 01:10:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A85FB8D
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978650; cv=none; b=abwSdKgrgwujQ4xguZa8I9oD+KEJcae0h3w6YjVC4DM/FaE0qMqRnNa56fk90N3qVVnCzrhreUQdCXoc85a2GfWvqZ0hrmQWp/fYwy6HS22YbbVuSERiNEhre4pa7nhGcjuCzI3SCXlK/4a7SIgV3iJnBOpJRFF7+byC78T7MUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978650; c=relaxed/simple;
	bh=t8iNjcAfEfXzilDV5CqaDd8h3NJywgn1J70g9AKaksA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rh/d28PwTxPLXKIP+zgSXoFtFGtvLP58niZxfbk554av8XUkMF9ApjUgzHjwOH4mtnyFRY9hbOcjO3WwZ802hqvOjltrOEOnQQHeGbvOY4qdfHFwkg+RA3Zk2Vg0jBS+wLncDZxiT8w6OauuVfpbcVihWv2xQupeX7jOvnZySME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsmdN0Y1nz4f3kK0
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:10:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 75BE71A058E
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:10:45 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAnT4OS5TtnOxvBCA--.7836S2;
	Tue, 19 Nov 2024 09:10:45 +0800 (CST)
Subject: Re: [PATCH bpf-next 10/10] selftests/bpf: Add more test cases for LPM
 trie
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-11-houtao@huaweicloud.com>
 <5dff53f5-042c-401c-9554-6bf3d90f1e34@iogearbox.net>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <0c55ef0b-9d4e-ac85-2e32-82667bbe1bdb@huaweicloud.com>
Date: Tue, 19 Nov 2024 09:10:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5dff53f5-042c-401c-9554-6bf3d90f1e34@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAnT4OS5TtnOxvBCA--.7836S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw43Gw1kZryrKr4fXF1xAFb_yoWktrb_WF
	4q934DJw4Iyw1xJFn8KrnxGry3KFW8Kr1DGw45uFsruwnxCrZ5XFn5WryrC3yUu3yFvF9I
	krnag34Yyw4xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIoGQDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/19/2024 1:46 AM, Daniel Borkmann wrote:
> Hi Hou,
>
> On 11/18/24 2:08 AM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Add more test cases for LPM trie in test_maps:
>>
>> 1) test_lpm_trie_update_flags()
>> It constructs various use cases for BPF_EXIST and BPF_NOEXIST and check
>> whether the return value of update operation is expected.
>> 2) test_lpm_trie_reuse_leaf_node
>> It tests whether the reuse of leaf node as intermediate node is handled
>> correctly when freeing the intermediate node.
>> 3) test_lpm_trie_iterate_strs & test_lpm_trie_iterate_ints
>> There two test case test whether the iteration through get_next_key is
>> sorted and expected. These two test cases delete the minimal key after
>> each iteration and check whether next iteration returns the second
>> minimal key. The only difference between these two test cases is the
>> former one saves strings in the LPM trie and the latter saves integers.
>
> Just to clarify, the added tests in 3) exercise the fix in patch 5,
> correct?

Yes. Sorry for failing to mention it in the commit message. Will update
the commit message accordingly in next revision.
>
> Thanks,
> Daniel


