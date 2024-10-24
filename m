Return-Path: <bpf+bounces-43014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440689ADB22
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D62836E2
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C74170A29;
	Thu, 24 Oct 2024 04:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ka96vJ8A"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFB9474;
	Thu, 24 Oct 2024 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745371; cv=none; b=KLEHW2scrBpX4dHTrJa/Uc4cojr3qjuYxzQg6/kFZJrZt9fGFpOxpu0otd32ropdHp8vgGsJHMV28H7zXRtto+idc1nV0RBlWtnCHOrLYG8cx7/huRi4Z8Vm0D2oLUzWQEGVJAMrT/oPFdRJzTSixBE2naB33xwiqK2MREXbo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745371; c=relaxed/simple;
	bh=A2PjJARB/fw8n8qTNn2259+mELoQ3NLH5OdpTAW5aek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWinroVmu7l598FiMHQWxeDM93J/nPbJKFPkyVs1Xy5pcC4PpOw2JcdGTMyUCpU9md9FcNojQMZNIJf+HR7ivi4PoiejfiYEXsh4V11yTZ8ToQ8fho6+SYrBpkMFJlmV4XcQmdqBslzWYPi4WhvR8ebQrq09SEnNRuK0pS5TyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ka96vJ8A; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729745358; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iwmxYZ0CXYfXJAMg2rSfDvfc82uItayVWx9BloNjOyo=;
	b=ka96vJ8A6Zas8/5Zelf4ToH+lT+NeuK+3sVJEIs/4JYR4LsjnKeLLpS1Jc2DF2wdojFa+rQIUsqOly2Lo3LQxlhyxOcxLhnClxssIo6ZtotyZJ3J+De8WgMWiePW8G+jR8NIVU2omDKmAyDe91gzHtYJ2Ux2F61/sIsBcoqVC3E=
Received: from 30.74.129.183(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WHnso7r_1729745355 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 12:49:16 +0800
Message-ID: <284e3cb9-9f27-413c-9c05-f017171fa40e@linux.alibaba.com>
Date: Thu, 24 Oct 2024 12:49:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] bpf/selftests: add simple selftest for
 bpf_smc_ops
Content-Language: en-US
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, sdf@google.com,
 haoluo@google.com, yhs@fb.com, edumazet@google.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
 guwen@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-5-git-send-email-alibuda@linux.alibaba.com>
 <2006b84c-e83a-431b-ac35-bb357459fa96@linux.alibaba.com>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <2006b84c-e83a-431b-ac35-bb357459fa96@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/24 12:04, D. Wythe wrote:
> 
> 
> On 10/24/24 10:42 AM, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This PATCH adds a tiny selftest for bpf_smc_ops, to verify the ability
>> to attach and write access.
>>
>> Follow the steps below to run this test.
>>
>> make -C tools/testing/selftests/bpf
>> cd tools/testing/selftests/bpf
>> sudo ./test_progs -t smc
>>
>> Results shows:
>> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> 
> Sorry for just found an issue with vary config. I will fix this issues
> in the next version.
> 
> D. Wythe

This doesn't build with !CONFIG_SMC.

Maybe you should create an individual dir. (like what sched_ext does)

