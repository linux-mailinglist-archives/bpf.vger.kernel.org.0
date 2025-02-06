Return-Path: <bpf+bounces-50578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836AEA29E07
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B071888DDF
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7421B59A;
	Thu,  6 Feb 2025 00:46:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC9291E
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802775; cv=none; b=VlemEBnaToFp+ZuJ5L48gFlR0mZf8tEL0B/WQnUjVVvfDB6nXA9G2HX0rqj2hdz1DdOYi7+ffmnDGm5an6wuaYQQ6eUdzJzIIMk+O0Atw7rEa9X7etQs4KbC+v14UmoeCfRuISS40liyiW6ZO5SWTif5iPgG9+9Sdcthc1MTRBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802775; c=relaxed/simple;
	bh=ksF6ZZ0vSe3dOkS6ABK0nY/9JaPrqWupgSHv1fSbS7E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jx1YFXsKl1eEAB8I5mZjOOG3hcMIDFlQU8gpzpFd6qs2M2AW1sv+itEeD7Kxkxu/sq06Jqizb3/exAvhCFgjYCx+uTtqQbuOMi52CSLQpowwCl57YiTSvPTgkCEGkf4c53OvGV63Dz0NMll3Lj0YiE3Tt4t6BuwbyKnm7WvTwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YpJLT02yrz4f3jq4
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 08:45:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D8CFE1A14AB
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 08:46:08 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXu3tNBqRn6mP2Cw--.1058S2;
	Thu, 06 Feb 2025 08:46:08 +0800 (CST)
Subject: Re: handling EINTR from bpf_map_lookup_batch
To: Yan Zhai <yan@cloudflare.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
References: <Z6JXtA1M5jAZx8xD@debian.debian>
 <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
 <CAADnVQLNSUOz7kSwMr0dfgT1gk02S1wNgJOhk-5h_d01AM2RbA@mail.gmail.com>
 <CAO3-Pbqbj_pi3BrA7h3qtRsrcm_wJVLnJwyKwuuNLYg==_QvRA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3d906727-1872-ca7e-759c-65c16b0f339f@huaweicloud.com>
Date: Thu, 6 Feb 2025 08:46:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAO3-Pbqbj_pi3BrA7h3qtRsrcm_wJVLnJwyKwuuNLYg==_QvRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXu3tNBqRn6mP2Cw--.1058S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4xCF43GFykJF1DJw45GFg_yoWkXrc_WF
	Wv9an7GrsF9F4Fya4DCrs8Zry7XF1vyr1aqa4qq3WfZw18Xay3CF1Ykr97ZryUJw4rJr98
	ur4Yyasa9rn0vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/


Hi,

On 2/6/2025 12:27 AM, Yan Zhai wrote:
> On Wed, Feb 5, 2025 at 3:56 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> Let's not invent new magic return values.
>>
>> But stepping back... why do we have this EINTR case at all?
>> Can we always goto next_key for all map types?
>> The command returns and a set of (key, value) pairs.
>> It's always better to skip then get stuck in EINTR,
>> since EINTR implies that the user space should retry and it
>> might be successful next time.
>> While here it's not the case.
>> I don't see any selftests for EINTR, so I suspect it was added
>> as escape path in case retry count exceeds 3 and author assumed
>> that it should never happen in practice, so EINTR was expected
>> to be 'never happens'. Clearly that's not the case.
> It makes more sense to me if we just goto the next key for all types.
> At least for current users of generic batch lookup, arrays and
> lpm_trie, I didn't notice in any case retry would help.

I think it will break lpm_trie. In lpm_trie, if tries to find the next
key of a non-existent key, it will restart from the left-mode node.
>
> best
> Yan


