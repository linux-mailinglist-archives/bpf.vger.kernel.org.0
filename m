Return-Path: <bpf+bounces-29148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED938C085E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 02:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501481C20EDF
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 00:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013738C;
	Thu,  9 May 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGkJqAI1"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C11373
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214138; cv=none; b=j+O1Bn1TJM65p1/ZxY+hZeJHhRYYS0+1RBQ3rrpFTggVrDXfBVpCONQW2YFvJCcKZFLzqq/dlDitqzQqxgSrkXv5R5IMylPfZICmKARNcODQsHkg70dE/AyBJkMdyFEWevIRGNNhB/2PNGBl+RWSe6/vlZ0EUdxjgs4QtWNxheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214138; c=relaxed/simple;
	bh=RPXT4UI0DgnIfQM9z092rZ9WixWEerGEz34NovH9I74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SathnSxlQi73h4mmBMGEdhpBkSj0TdMNDfdkXSkVoSp39xn8AdCjur0uiV8rp1RWlpcKMY1L8bCNXFrkUrOzsIxuEpD2FW0c9zGsST6JSZQdqJlGDlmqWSOLSBWaOaY5XJNT5QHKHwnoph3y9poSuTBUEQL1R5Vy/nuOjX0KsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGkJqAI1; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df48bfa9-5845-457b-a908-9ceab6c82421@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715214134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu1CnNQ91WpuvjkquDhqO28oL5jmOhnTwMqomlM0czA=;
	b=iGkJqAI1qSgtU26jMb413GeMj4VeWTMbrD4vbBfcLwNBn5PcIWH+gfOqGZfv+vN5WXZ0hv
	B9Z7YjiQG7KN0ATuqGVrKjRAk/gsGo/ifXOWpcGd4ENM3zUmwVfuKxv4KFN7mdNhzf9gu0
	iloNbemX2gYTlRCiJZuAIny4MsojndU=
Date: Wed, 8 May 2024 17:22:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Expand skb dynptr selftests
 for tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, drosen@google.com, xuanzhuo@linux.alibaba.com,
 bpf@vger.kernel.org
References: <20240430121805.104618-1-lulie@linux.alibaba.com>
 <20240430121805.104618-3-lulie@linux.alibaba.com>
 <5e3d1bd3-0893-41b0-89e1-9311d53c2198@linux.dev>
 <e2b00a10-db9f-4b8f-82ac-49a3f9b301ed@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e2b00a10-db9f-4b8f-82ac-49a3f9b301ed@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/6/24 8:15 PM, Philo Lu wrote:
> What do you think if I replace "struct __sk_buff" with "void"? The diffs are 
> appended below.
> 
> Because we are not to read anything in these cases, I think using void* is 
> enough to avoid confusion. On the other hand, to use "struct sk_buff" here, we 
> have to introduce the definition, and tune codes as the input type of 

The sk_buff definition is in vmlinux.h. However, the dynptr_fail.c does not use 
vmlinux.h now, so it may need some more changes.

Yep, I think "void *skb" here is fine.

> bpf_dynptr_from_skb() is defined as struct __sk_buff in "bpf_kfuncs.h".


