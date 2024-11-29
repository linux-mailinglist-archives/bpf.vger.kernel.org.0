Return-Path: <bpf+bounces-45859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F089DBEF7
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 05:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A50328124D
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 04:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1A154C15;
	Fri, 29 Nov 2024 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iB8vO8Nc"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319F45C14;
	Fri, 29 Nov 2024 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732853507; cv=none; b=pkSVUemamAaYCxwKGa/HGMW1ojhosVkx6h5S54CizTqkePjpRExrmsXM35sjS0Ykb/k31M5o3vfOB1eAAw+MUuyu+CQNTWYQW0v6darSLHE78SkQMeqpM660q0OZ+5qQfqvrhkzXpJpeIheLVmiOEgqPSFHS4NLgIIJ3uMSdCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732853507; c=relaxed/simple;
	bh=wr1uJvr4G8JBoARQHlYSi9m1EVlinWeH0+nVZKa6aHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSP7ZWba6A9lrtTue1049rGjeEAhJFLqNt1dy12OW1HJQmT1iXtYedpcDe4KdNDitnMMvkgU+pC+mHtSoKblxtCCZDr6V9GQDl/lDFmnj+1RhANSEomuURHbAxHJD8g2uxuf46dG/JnyRwN8dJnLwJr0bi8q+1Xm3VgtKSj93/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iB8vO8Nc; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732853494; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VVRHyGfrwrHOIjO/cmIEiDL6rMRsXuS3jPw6EV6dE+A=;
	b=iB8vO8NcPn80Bno1ckLh06UZDRlDC/AjTRKa1o7rdhanKGWZ2mHkpZqZQUBfIGAIYcUfxU8SneB1fWMP7FczA0ikXLfQRnAtOlgE5eAdoclFay+xHOCQnK0oB0LbGvwDXps0QBZQauYzT7H43kbMp2P00Sr37OCdJG53SOMA+HE=
Received: from 30.221.148.39(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WKSUOK6_1732853491 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 Nov 2024 12:11:32 +0800
Message-ID: <b6a676fe-d6e5-40e5-a2f0-b25c43cef225@linux.alibaba.com>
Date: Fri, 29 Nov 2024 12:11:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] bpf/selftests: add simple selftest for
 bpf_smc_ops
To: Martin KaFai Lau <martin.lau@linux.dev>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, dtcccc@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-5-git-send-email-alibuda@linux.alibaba.com>
 <8c06240b-540b-472f-974f-d2db80d90c22@linux.dev>
 <e8ba7dc0-96b5-4119-b2f6-b07432f65fdb@linux.alibaba.com>
 <0a8c2285-29c2-4a79-b704-c2baeac90b70@linux.dev>
 <c96fe7a8-8512-48e8-b253-d5ff8a0f4755@linux.dev>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <c96fe7a8-8512-48e8-b253-d5ff8a0f4755@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/26/24 7:32 AM, Martin KaFai Lau wrote:
> On 11/25/24 2:52 AM, Zhu Yanjun wrote:
>>>> # ./test_progs -t smc
>>>> #27/1    bpf_smc/load:OK
>>>> #27      bpf_smc:OK
>>>> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>>>
>>>> The above command is based on several kernel modules. After these dependent kernel modules are 
>>>> loaded, then can run the above command successfully.
> 
>>>
>>> This is indeed a problem, a better way may be to create a separate testing directory for SMC, and 
>>> we are trying to do this.
>>
>> Got it. In the latest patch series, if a test program in sample/bpf can verify this bpf feature, 
>> it is better than a selftest program in the directory tools/ testing/selftests/bpf.
>>
>> I delved into this selftest tool. It seems that this selftest tool only makes the basic checks. A 
>> test program in sample/bpf can do more.
> 
> sample(s)/bpf? No new test should be added to samples/bpf which is obsolete. The bpf CI only runs 
> tests under selftests/bpf.
> 
> There is selftests/bpf/config to tell the bpf CI about what kconfig needs to turn on.

Is it acceptable to add a new kconfig to selftests/bpf/config? I don't know that...

To solve the compilation problem of this test, we originally planned to add a separate testing 
directory to SMC. If adding a new kconfig is acceptable, it will make this patch simpler.

Best wishes,
D. Wythe

