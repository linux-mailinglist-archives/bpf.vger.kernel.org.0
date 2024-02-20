Return-Path: <bpf+bounces-22289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B17985B3C9
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 08:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1AB1C2184E
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 07:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5725A4E9;
	Tue, 20 Feb 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TvXaKTq7"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC05A110;
	Tue, 20 Feb 2024 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413558; cv=none; b=FYalkARt2uCe46L5Y0GbjKgT4wBtnJIgF2gJFzXdZ6IHMbpRkADc5wKHkphAmerY7Muj7thB9MU7jTY2Ndo0ROuLtROneF5Q5qQ9n2TFk3T3bvJDeooC+Iw3A1u2Jrn5XkQ4e7YALaOYQrgrQ0RZhrjCwk9tKzKgdN5H6q/u57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413558; c=relaxed/simple;
	bh=S9XetiB1kCGvDGsBJEicmEP9gLUMjlR4V0Egs8d7+co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGkPegf3Kyo2QzK5Xk1YNJDlvHvXSbjfjkd8zpkHxdouR9kCPvVy6NKh18t8PM0IbvskGnUN5ueinZVu2nBTJINHXTRqninuXHb9ev824W29NcRqEcQ2p9Gwmt81DhtQawNtDDBlPlHY8pXXiEwpXJKwT/dy+fFMje2uEWcOthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TvXaKTq7; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708413554; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0d8HScRQIx6W+ruLqSv3M+jMj6lFLshZVIqZSQ4AXqQ=;
	b=TvXaKTq7eny4+YEHY1Xt+yDME2e2p+wWOoOUCWufEjntpAgHiESPDOSWC/qYxVg6NEDV3pcxw7b7yTBqCgnMzlWD+wR0XgpTYY/BNb+BcUOpAJmWH+Y4h51qLNafAaeU/e/ttgnB3n4uw/UgxCPoj9stpKRz5uMo6AvEJGoDLyk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W0w1yEa_1708413552;
Received: from 30.221.148.206(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0w1yEa_1708413552)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:19:13 +0800
Message-ID: <53654d84-9fe3-4a8d-98ba-ab052df91852@linux.alibaba.com>
Date: Tue, 20 Feb 2024 15:19:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC nf-next v5 0/2] netfilter: bpf: support prog update
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org
References: <1704175877-28298-1-git-send-email-alibuda@linux.alibaba.com>
 <70114fff-43bd-4e27-9abf-45345624042c@naccy.de>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <70114fff-43bd-4e27-9abf-45345624042c@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/15/24 12:10 AM, Quentin Deslandes wrote:
> On 2024-01-02 07:11, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patches attempt to implements updating of progs within
>> bpf netfilter link, allowing user update their ebpf netfilter
>> prog in hot update manner.
>>
>> Besides, a corresponding test case has been added to verify
>> whether the update works.
>> --
>> v1:
>> 1. remove unnecessary context, access the prog directly via rcu.
>> 2. remove synchronize_rcu(), dealloc the nf_link via kfree_rcu.
>> 3. check the dead flag during the update.
>> --
>> v1->v2:
>> 1. remove unnecessary nf_prog, accessing nf_link->link.prog in direct.
>> --
>> v2->v3:
>> 1. access nf_link->link.prog via rcu_dereference_raw to avoid warning.
>> --
>> v3->v4:
>> 1. remove mutex for link update, as it is unnecessary and can be replaced
>> by atomic operations.
>> --
>> v4->v5:
>> 1. fix error retval check on cmpxhcg
>>
>> D. Wythe (2):
>>    netfilter: bpf: support prog update
>>    selftests/bpf: Add netfilter link prog update test
>>
>>   net/netfilter/nf_bpf_link.c                        | 50 ++++++++-----
>>   .../bpf/prog_tests/netfilter_link_update_prog.c    | 83 ++++++++++++++++++++++
>>   .../bpf/progs/test_netfilter_link_update_prog.c    | 24 +++++++
>>   3 files changed, 141 insertions(+), 16 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c
>>
> It seems this patch has been forgotten, hopefully this answer
> will give it more visibility.
>
> I've applied this change on 6.8.0-rc4 and tested BPF_LINK_UPDATE
> with bpfilter and everything seems alright.
>
> Thanks,
> Quentin

Thanks for your testing. I will send  out a formal version soon.

Best wishes,
D. Wythe


