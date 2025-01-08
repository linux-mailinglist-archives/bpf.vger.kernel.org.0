Return-Path: <bpf+bounces-48298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C24A0662D
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2F63A73B7
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC25202F67;
	Wed,  8 Jan 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TCqYsdWM"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4A920127D
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368112; cv=none; b=Oyh7RbOkBFTwYPSQncrzPHkenmTAzf0NtlkHuObpCMGTrS+4VIfWsx6D/HxJ3jHQcqW14qv1RB6a9Zf/7B+dgh6HLPO+XWgucVme/CKz1Mlj2uTvSRUHwuNiNG61LaGPwqstX6ov1SeH5o1WXQlTV2MMT/kxJ2ct/6xDguuQnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368112; c=relaxed/simple;
	bh=4mNVQBxEaE3fZIFuHb/xYVT7Vk/Ya7y5IdK5A3iVZeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvGaDXKzv1JnaeaZtWtUad4bPSriJTQ6ggoOcnrGbejtCDOFtQPWlyIGqz1thYXKnCUAHjw6Kc95Iza6m1G4IZrOGH8WUhmLG+mptTrSKJ//ny2mZNZaS2vy6S8HqGxoCjShz8SnDEkayNUNAo7HiyXJsrQi4lN0f0lp8TqEywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TCqYsdWM; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <93955687-a82b-4365-931c-d53ecd1dacd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736368103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mG3i4oEN3GwQ2iVcDpe1ei6y/mwBbh+jaJPTaZeG+Z4=;
	b=TCqYsdWM7pGPhhOE44WwwGIyQIbRwqiPFj4gDlcpFIH918kW8lHfzr5dc2AYekNTd3eVpX
	ulxAS6YA7CJc+iVyhJ7Z4GxcEYBOvTVJOxkai14fshkePEl2IaHagDrNd3I4B8YstwUE2C
	/29VhmcTZAvtiKduwzVG/oupMqlo8vg=
Date: Wed, 8 Jan 2025 12:28:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Compiler support for BPF at LSFMMBPF 2025 - Is there interest?
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: elena.zannoni@oracle.com
References: <87ikqpmf81.fsf@oracle.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87ikqpmf81.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/8/25 8:40 AM, Jose E. Marchesi wrote:
> Hello people.
>
> The deadline is approaching and we were wondering, should we prepare a
> proposal for a discussion around BPF support in both GCC and clang for
> LSFMMBPF?  Like in previous years, we could do a recap of the on-going
> work and where we stand, and discuss and clarify particular issues.

Thanks. Indeed this is a good topic to discuss w.r.t. clang/gcc related 
issues.



