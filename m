Return-Path: <bpf+bounces-43021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7B39ADBA7
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 07:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563361F219AA
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 05:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ADA174EDB;
	Thu, 24 Oct 2024 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tByxvxZS"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95D43ACB;
	Thu, 24 Oct 2024 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729748985; cv=none; b=U31hYVUM2RWJOLPn8Lp1feBSRmXcQpA10zSQYz7i3H49TPg1+yQqM4h90X8ofI97VtQyUgqWsLh9XDAOP4He2WIZ/AbhwVkctIyhuTqAZE8n1MmY9feFElo2UxAq1w6LbXz09/4YWBAAFAppKKhxUxQ7Re8Mm7FIUrqWK2Dx5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729748985; c=relaxed/simple;
	bh=PfaPHb6N84Ggiq/7uzRDzg1B90UbdHecRky5BAIKIzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBAflJ+Dg3qDm1G6CKOB/mW64pdVgsX0IDdmf+TxJRyuMuGbmU49170AW8B2ecV/T5I0xwQfxXhjA8d9NGDxl8On6OUk8dlvtkaCBExGlw5PRWpLllI/JPNJr8ggYZO7sEgSlDedLc2+l3L7jaGyrvCiVV2muq2QxwXFcXzSp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tByxvxZS; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729748979; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qI2X3JNmf4ad1kTgTPuG2xPBcGK0wWOZXmUAGVTv79M=;
	b=tByxvxZS5xPS9E3UPZt7mgThLOj7FF6Z7Q4wGU/pc0UgGMn7ulJPUU7Q0SPzg0kcxDaiyjimAEIPQb10lvwUanOnNfbYgvNwU2jiViVVWx5VoVx4actwK+n/xUTSe0TrLlxnZk2U7VFNARmftkZU8UIH+UOLnuSihTGR6nzhn9s=
Received: from 30.221.147.97(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WHo.a3s_1729748976 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 13:49:37 +0800
Message-ID: <a5843fac-c6d3-40f2-b2cb-7bbfde93365e@linux.alibaba.com>
Date: Thu, 24 Oct 2024 13:49:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] bpf/selftests: add simple selftest for
 bpf_smc_ops
To: Tianchen Ding <dtcccc@linux.alibaba.com>
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
 <284e3cb9-9f27-413c-9c05-f017171fa40e@linux.alibaba.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <284e3cb9-9f27-413c-9c05-f017171fa40e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/24 12:49 PM, Tianchen Ding wrote:
> On 2024/10/24 12:04, D. Wythe wrote:
>>
>>
>> On 10/24/24 10:42 AM, D. Wythe wrote:
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> This PATCH adds a tiny selftest for bpf_smc_ops, to verify the ability
>>> to attach and write access.
>>>
>>> Follow the steps below to run this test.
>>>
>>> make -C tools/testing/selftests/bpf
>>> cd tools/testing/selftests/bpf
>>> sudo ./test_progs -t smc
>>>
>>> Results shows:
>>> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>
>>
>> Sorry for just found an issue with vary config. I will fix this issues
>> in the next version.
>>
>> D. Wythe
> 
> This doesn't build with !CONFIG_SMC.
> 
> Maybe you should create an individual dir. (like what sched_ext does)

It's true, I do intend to create an individual dir, and send the patches for
BPF and SMC separately. Thanks for your advises.

Best wishes,
D. Wythe



