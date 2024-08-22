Return-Path: <bpf+bounces-37886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFE095BD57
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E443B288081
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0DF1CC899;
	Thu, 22 Aug 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OJlrXBU7"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1A1D12E4
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347942; cv=none; b=a8V7orWCEoJptiM08/q/hlqcE7MEBgrj8RI0Nqh2ArCNLeoX/X651L8i+S9q0LgnZx+uI7svqMhqxOhdxqmKMmDinuMQzFLKyErBRr7ld0sO25LREUBg56JezHf0gYZa62gbriMlYCcExJpay0ObwnIMoEdx6vH25BZaLsiAc0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347942; c=relaxed/simple;
	bh=l9+yX4Ex6yhOMPu4DNejR05mY1QqAKF5SNMZR2Uz0YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cXSN/oWCZVTsc5NMmM9ytYjbjy7/Xpo2+44hRFBpUyoGH3tB/40IbGJ75LWV19NPKthj2T3JmmKbkPcHm2BaINrU8Il9AgTpUJk7PhXvxYjd+8rNYIbNOYlxIn1fhZ13/Tquhl3pI/1tAGRfSyMKizEt0YAWQb2TtTRVCtx5VM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OJlrXBU7; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9df3f58f-d484-4be6-88fd-297c635c13d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724347938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLpx6yNjFpVksxFl8Ivf+aqGiXNjWA8Zc/cvKtcF4w0=;
	b=OJlrXBU7YxQFUmz6k61R4ZNtjI6xRmUc0bhD3JdBhed8sewdoethS6Z81rtgjdzUy9ymdL
	slzho8FJ3Dr6C7MR2Xc6qIPRRlg1/bmmQMRiHvKK45HR4SoAYm83qED2aYkyRMlgf3OMCA
	5pcyEFQ1K4BcIicjLADvkNKBtazG964=
Date: Thu, 22 Aug 2024 10:32:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Correct recent GCC incompatible changes.
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
References: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
 <6c07765b-952f-4132-aa99-b31010eea598@linux.dev>
 <53eb5273-6a10-460d-a525-8f56b8fc4f8e@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <53eb5273-6a10-460d-a525-8f56b8fc4f8e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/22/24 10:02 AM, Cupertino Miranda wrote:
> Hi Yonghong,
>
> Working on it. I am almost done!

Great. Thanks!

>
> Cupertino
>
> On 20-08-2024 20:42, Yonghong Song wrote:
>>
>> On 8/19/24 8:11 AM, Cupertino Miranda wrote:
>>> Hi everyone,
>>>
>>> Apologies for the previous patches which did not include a cover 
>>> letter.
>>> My wish was to send 3 indepepdent patches but after the initial 
>>> mistake lets keep
>>> this as a series although they are all independent from themselves.
>>>
>>> The changes in this patch series is related to recovering GCC 
>>> support to
>>> build the selftests.
>>> A few tests and a makefile change have broken the support for GCC in 
>>> the
>>> last few months.
>>
>> Cupertino, it would be great if we can speed up to add CI test with 
>> gcc-bpf, even
>> just for compilation only.
>>

