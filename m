Return-Path: <bpf+bounces-45135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 144439D1D65
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 02:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7D3B23076
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 01:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D612C7FD;
	Tue, 19 Nov 2024 01:36:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59081798C
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980163; cv=none; b=QIrCFIxirlAm3b0pA0ihf5PCSUyfVLy3+mGEyWmsA4f+mGFjNEceZb1BW3peLB2ZAZ01RRZLxQRcCen7dsOlTWmGrNl/ud/VUGOKGT1W4bmP5sDfveY9hcVqSApqotZ2XDSuUNHsGK9S3yqc3qf3DImAgyPv18Ee24Zl2+b0dd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980163; c=relaxed/simple;
	bh=ig7zb2hR76j2vT0zIP1eVz5jFyV924pUgZTCVpmwdZ4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NwPPVXMcAsDUqurdRS5CADZ3E2Wb2VKb6BeNBtxXxldYdz/oqKThS4Zuu+70SkgoO6iyEPw7OrG+1ocHjGkVhK7TT6JpOsMwTEJg4JHK3VSHQO8EVLVMTQzCJ4PfBNRYcsA+MKnPiEVZLxoOlPHIuCWrRpwM1GebrKwUnx4q75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsnBQ4ZQgz4f3l7t
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:35:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0AF941A058E
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:35:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDHoYV36ztnd8rCCA--.16905S2;
	Tue, 19 Nov 2024 09:35:55 +0800 (CST)
Subject: Re: [PATCH bpf-next 00/10] Fixes for LPM trie
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
 <20241118153901.izwoXYhc@linutronix.de>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6919992c-179e-300e-9f5f-dc3a8a7bdaf3@huaweicloud.com>
Date: Tue, 19 Nov 2024 09:35:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241118153901.izwoXYhc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDHoYV36ztnd8rCCA--.16905S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1xGF43uw4xurWDZr1UKFg_yoW8Aw4DpF
	4fta4Yqa1kXryvvw10yw4DWa4Fkwn3Ar1YgryrKr4Ykwn0q34S9FyxKF4j9FZ2krZ2934j
	qa1vqrZ3Gas8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Sebastian,

On 11/18/2024 11:39 PM, Sebastian Andrzej Siewior wrote:
> On 2024-11-18 09:07:58 [+0800], Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
> Hi,
>
>> Please see individual patches for more details. Comments are always
>> welcome.
> This might be a coincidence but it seems I get
>
> | helper_fill_hashmap(282):FAIL:can't update hashmap err: Unknown error -12
> | test_maps: test_maps.c:1379: __run_parallel: Assertion `status == 0' failed.
>
> more often with the series when I do ./test_maps. I never managed to
> pass the test with series while it passed on v6.12. I'm not blaming the
> series, just pointing this out it might be known…

Thanks for the information. 12 is ENOMEM, so the hash map failed to
allocate an element for it. There are multiple possible reasons for ENOMEM:

1) something is wrong for bpf mem allocator. E.g., it could not refill
the free list timely. It may be possible when running under RT, because
the irq work is threaded under RT.
2) the series causes the shortage of memory (e.g., It uses a lot memory
then free these memory, but the reclaim of the memory is slow)

Could you please share the kernel config file and the VM setup, so I
could try to reproduce the problem ?
>
> In 08/10 you switch the locks to raw_spinlock_t. I was a little worried
> that a lot of elements will make the while() loop go for a long time. Is
> there a test for this? I run into "test_progs -a map_kptr" and noticed
> something else…

The concern is the possibility of hard-lockup, right ? The total time
used for update or deletion is decided by the max_prefixlen. The typical
use case will use 32 or 128 as the max_prefixlen. The max value of
max_prefixlen is LPM_DATA_SIZE_MAX * 8 = 2048, I think the loop time
will be fine. Will try to construct some test cases for it.
>
> Sebastian


