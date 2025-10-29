Return-Path: <bpf+bounces-72661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB4C178BB
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E481C8160E
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5882C0F89;
	Wed, 29 Oct 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hdiX8RxG"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05442C029D
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697835; cv=none; b=gPgmJp3ZDCinvSUg2vzbWm0mZZckIb3n/fHlHdbzOydn8lyyx0JrmzZA+kw7IH3Zuef4CtwB2x+uug3+lEwWDayGZe+AQfvP/DkoiuMiSjvjd9i74Nk+4j6lVaB9uI3U5Puzkk3OOEVtQ3XoljJbNZrbSjXwC9w+7EKV8csd/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697835; c=relaxed/simple;
	bh=BFp2VOOXg/vvY0+wkx4HQcNTNHWlJAGVc0AZqw9NsnE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MX7LRj0xne7xN0JPjJjbTbMCNyyDPC+1e1t7DoE69O2AsCksM9qdETl8CRjdL+9Loi5O86DxIlM+lIDZh1chLwkOQF/dz93558vzjyWwOL8B0FlwfWd+lGTQ0lmZJeCCQrBJJ0UW8IQ4x7GrcZUyl1GJpQofey9Xww2d26XsnyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hdiX8RxG; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fea9adf1-3c61-4213-bc84-9429bf3e82a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761697821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnDCxLRbb/ZeQwXZ8FgEr+f0AbXz70y90EJMoOKVMHs=;
	b=hdiX8RxGb2RboeKk0VMWeCaghnXKANApyvNT0I0fIoEjyZDg05i77VsME2kNXhIBlUTTr7
	YNECrdAvnVI07ow6pgQTDoawMYsDbl/7ttV89qz8pM9NwIdP0SwrjSUYPfUD3GHU7+9Id8
	CY1NaAY7ZIdHmWfUg2orAX/0vg6647w=
Date: Tue, 28 Oct 2025 17:30:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v3 0/3] net/smc: Introduce smc_hs_ctrl
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: martin.lau@linux.dev, ast@kernel.org, andrii.nakryiko@gmail.com,
 daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com, song@kernel.org,
 sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
 mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
 dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, bpf@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com,
 jaka@linux.ibm.com
References: <20250929063400.37939-1-alibuda@linux.alibaba.com>
 <20251028121531.GA51645@j66a10360.sqa.eu95>
Content-Language: en-US
In-Reply-To: <20251028121531.GA51645@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/28/25 5:15 AM, D. Wythe wrote:
> On Mon, Sep 29, 2025 at 02:33:57PM +0800, D. Wythe wrote:
>> This patch aims to introduce BPF injection capabilities for SMC and
>> includes a self-test to ensure code stability.
>>
>> Since the SMC protocol isn't ideal for every situation, especially
>> short-lived ones, most applications can't guarantee the absence of
>> such scenarios. Consequently, applications may need specific strategies
>> to decide whether to use SMC. For example, an application might limit SMC
>> usage to certain IP addresses or ports.
>>
>> To maintain the principle of transparent replacement, we want applications
>> to remain unaffected even if they need specific SMC strategies. In other
>> words, they should not require recompilation of their code.
>>
>> Additionally, we need to ensure the scalability of strategy implementation.
>> While using socket options or sysctl might be straightforward, it could
>> complicate future expansions.
>>
>> Fortunately, BPF addresses these concerns effectively. Users can write
>> their own strategies in eBPF to determine whether to use SMC, and they can
>> easily modify those strategies in the future.
>>
>> This is a rework of the series from [1]. Changes since [1] are limited to
>> the SMC parts:
>>
>> 1. Rename smc_ops to smc_hs_ctrl and change interface name.
>> 2. Squash SMC patches, removing standalone non-BPF hook capability.
>> 3. Fix typos
> 
> 
> Hi bpf folks,
> 
> I've noticed this patch has been pending for a while, and I wanted to
> gently check in. Is there any specific concerns or feedback regarding
> it from the BPF side? I'm keen to address any issues and move it
> forward.

The original v1 started last year. The bpf side had been responsive but 
the progress stopped for months and the smc side review had been slow 
also. I doubt how well will this be supported in the future and put this 
to the bottom of my list since then.

The set does not apply on bpf-next/net now. Please re-spin.


