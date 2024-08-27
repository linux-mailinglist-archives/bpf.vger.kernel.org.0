Return-Path: <bpf+bounces-38122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8195FF01
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 04:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B901C21B83
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 02:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3089CD53F;
	Tue, 27 Aug 2024 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tb8x4Umb"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE3DDAB
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725452; cv=none; b=efK7YBPSYCh0tz8WnYFTuIye414C+Ygz2AHA8KIgmFSq5bO0XHPtebTds7btyRctuXfMGhIIhodPEV0e+CkO4wUpMwos8DH2Pvnxpq701E1fBSe6cAZ11ytuVoakqrvOze728InpilPU5kYJR2gncCofiJSuTa7nTIGa26p+2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725452; c=relaxed/simple;
	bh=RwkFbmGA6dJ+h4u68iDFj48fOepnJCi3ZshlyPHpCRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWMajRHtPi9M1f3q8/mvnWiTrt/aQK201XS0Q+MPfv8AiT+qMt07opjUw2OAjKdk35ODBXXwDZ1mDNSzncfBZSDHrJr6YxHweDo6UTGi0st/j7Q4GRANupIo1H0qOQ9/YYCycxVb1cFt6kN0/2UUC4BM8DP+OVnv82asYzsZpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tb8x4Umb; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0900df03-b1cd-41fb-be04-278e135cc730@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724725447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adKqNrir+w51CfDtvwt9u64x3ymutTqSZEZs+xEHFXM=;
	b=Tb8x4Umbr7+j4jS3uYWeE437sp0IetV6127DS5cEqr+ujNuGtq23W5owL7QPIyF3jG3d91
	85He2JH4uBi2Kj15/HMVduRLZqBEBnOWaCO7NI0atxNW80ieHymelcKkT0JY4VSvsbcDl4
	sSwSL2qUqnFb7wMxPFQZoA5kPVQUbxM=
Date: Tue, 27 Aug 2024 10:23:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-3-leon.hwang@linux.dev>
 <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 26/8/24 22:32, Xu Kuohai wrote:
> On 8/25/2024 9:09 PM, Leon Hwang wrote:
>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the same
>> issue happens on arm64, too.
>>

[...]

> 
> This patch makes arm64 jited prologue even more complex. I've posted a
> series [1]
> to simplify the arm64 jited prologue/epilogue. I think we can fix this
> issue based
> on [1]. I'll give it a try.
> 
> [1]
> https://lore.kernel.org/bpf/20240826071624.350108-1-xukuohai@huaweicloud.com/
> 

Your patch series seems great. We can fix it based on it.

Please notify me if you have a successful try.

Thanks,
Leon

