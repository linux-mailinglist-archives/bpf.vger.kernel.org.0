Return-Path: <bpf+bounces-32375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB790C300
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 07:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F0F28438B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 05:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7201B947;
	Tue, 18 Jun 2024 05:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="Cvf75pCQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail72.out.titan.email (mail72.out.titan.email [209.209.25.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C318C3B
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 05:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687085; cv=none; b=OjaUAaVVTM4v6kVbSamEWBVapggBAT0iarfIvIzmBOi8VWZpEnkGD+330Dep4RzY+dihWlP2Uc3g5vFw6Ym2zHt8ry+7Xj4nSekh0Gk6LiLlUHM5trQbOZSCz7daA+rnPBC0UM/jAh7GvvGDkxiLrsXvKLT6zUH02VVj7rACPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687085; c=relaxed/simple;
	bh=86+uxPOT7jYaEUuS95xJdBl6EB62PXewhd0xF4YEMuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSu8kZCYCPjQAiYbIkcHT2re0s103CH2clrhBm9l1M7ZPC6nqDG985RF8oW5g1pmRdjVpXe+ZbCuq4/Y6WsXZrNJS8McH+4T7NBniwwDL97YLnBtMsKCPPqoJm41yA2mSXwlJtHpL+o6JNQQ07boZ6QPtpMfPa3JOD2YaHkTK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=fail smtp.mailfrom=rcpassos.me; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=Cvf75pCQ; arc=none smtp.client-ip=209.209.25.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=rcpassos.me
Received: from smtp-out.flockmail.com (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4D658100083;
	Tue, 18 Jun 2024 02:35:01 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=g2fj+MwQl3zZvk/rOIrcfEzkpdi9XA1fKmWFpHbh8+w=;
	c=relaxed/relaxed; d=rcpassos.me;
	h=cc:subject:date:to:references:mime-version:from:in-reply-to:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1718678101; v=1;
	b=Cvf75pCQRflp5gajnX3IqSNnmEIKqUnkW6IpiK9KOA1elWxrbo9T1/t5rv2/WlKUHs9ZwPRB
	DWHMsendXfseeWjtYAcFLFHYoRzY2rtIyhkEzk+dlHxgOpTFvkOB6qAOJPauVHaLkYlxOfUo7ZX
	Zqpei1OE0/okNcV19BQuvbnM=
Received: from [192.168.0.20] (unknown [179.95.148.155])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id C9D351000F8;
	Tue, 18 Jun 2024 02:34:58 +0000 (UTC)
Message-ID: <e86698a4-b17f-47a7-b6b8-c5b78448d4bf@rcpassos.me>
Date: Mon, 17 Jun 2024 23:34:40 -0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 0/3] Fix compiler warnings, looking for
 suggestions
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bp@alien8.de,
 daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
 mingo@redhat.com, puranjay@kernel.org, tglx@linutronix.de, will@kernel.org,
 xi.wang@gmail.com, bpf@vger.kernel.org
References: <20240615022641.210320-1-rafael@rcpassos.me>
 <Zm_3nE-ho-MDZbyp@krava>
Content-Language: en-US
Feedback-ID: :rafael@rcpassos.me:rcpassos.me:flockmailId
From: Rafael Passos <rafael@rcpassos.me>
In-Reply-To: <Zm_3nE-ho-MDZbyp@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1718678101225861812.1680.7129100453215520909@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=T9KKTeKQ c=1 sm=1 tr=0 ts=6670f255
	a=WPZPIP4Du+QqB6/QjpJ8/w==:117 a=WPZPIP4Du+QqB6/QjpJ8/w==:17
	a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
	a=o35cwU6MAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=kZQDvevhITlzlJWLChAA:9
	a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
	a=---8k2CCGq07aBBJLGWX:22 a=DpOgBPUa0pETyyFpiVXn:22
	a=AjGcO6oz07-iQ99wixmX:22
X-Virus-Scanned: ClamAV using ClamSMTP

On 17/06/2024 05:45, Jiri Olsa wrote:
> On Fri, Jun 14, 2024 at 11:24:07PM -0300, Rafael Passos wrote:
>> Hi,
>> This patchset has a few fixes to compiler warnings.
> curious, which compiler/setup displayed the warnings?
>
It took me a few tries with different configs.
My most successful one was using gcc (14.1.1)
  make -j24 ARCH=x86_64 W=12 2>&1 | tee warnings.log
I dug through the Logs (with grep)looking for BPF and
  non macro expansion warnings.
Thanks!

>> I am studying the BPF subsystem and wish to bring more tangible contributions.
>> I would appreciate receiving suggestions on things to investigate.
>> I also documented a bit in my blog. I could help with docs here, too.
>> https://rcpassos.me/post/linux-ebpf-understanding-kernel-level-mechanics
>> Thanks!
>>
>> Changelog V1 -> V2:
>> - rebased all commits to updated for-next base
>> - removes new cases of the extra parameter for bpf_jit_binary_pack_finalize
>> - built and tested for ARM64
>> - sent the series for the test workflow:
>>    https://github.com/kernel-patches/bpf/pull/7198
>>
>>
>> Rafael Passos (3):
>>    bpf: remove unused parameter in bpf_jit_binary_pack_finalize
>>    bpf: remove unused parameter in __bpf_free_used_btfs
>>    bpf: remove redeclaration of new_n in bpf_verifier_vlog
> lgtm, nice cleanup
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
>
>>   arch/arm64/net/bpf_jit_comp.c   | 3 +--
>>   arch/powerpc/net/bpf_jit_comp.c | 4 ++--
>>   arch/riscv/net/bpf_jit_core.c   | 5 ++---
>>   arch/x86/net/bpf_jit_comp.c     | 4 ++--
>>   include/linux/bpf.h             | 3 +--
>>   include/linux/filter.h          | 3 +--
>>   kernel/bpf/core.c               | 8 +++-----
>>   kernel/bpf/log.c                | 2 +-
>>   kernel/bpf/verifier.c           | 3 +--
>>   9 files changed, 14 insertions(+), 21 deletions(-)
>>
>> -- 
>> 2.45.2
>>
>>

