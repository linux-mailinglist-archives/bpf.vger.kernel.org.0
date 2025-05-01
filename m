Return-Path: <bpf+bounces-57143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA7AA6339
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 20:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E341BA293A
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EF3223DE3;
	Thu,  1 May 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmSTS+wX"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA72153FB;
	Thu,  1 May 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125704; cv=none; b=bRN8yAAOfw1SooCtvuzF/0ZAByM/eTpI9qRPNZYMIahh9MCrSMxuEKmsjVaHxhxrFM6aUDge3Y5rYJxsDHGgEK+gUeirx7qHFfEBaYEXR5LGYIM8ATJ55jTTKzNg1iROHT3db+HinLy7jVUXAxxAlxxuwwWTic5Z/0MfgkNDrMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125704; c=relaxed/simple;
	bh=2DYy0GORSPiLBzJwFVEVpSkTacK93FpViQCRmrdDxSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCPXn6ydeven5xtTpqHMxx5AIgtpjzjceveijsgGgB3YgboDbQntQs/bMz5IFYCvoG2VGe/XGus83rt0era6cdWQyxTgzesb2glLzwhYUKRqK9XbsGzKSgWxb7yzBZ9qPF54lECkf5MtDF4KrXEDyZozqJ3181fWbVYnv0j6NC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmSTS+wX; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ccb3470-0218-4bca-af17-4f9bd1e758a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746125700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYE4BYmFRb6CY1OabEySNJKaGCbSWdCRvCGc3xqQ15g=;
	b=qmSTS+wX3BHcVseUpZXRsi4lR2h+QHAMcREFSm4jcDZgzoRcS6oCCwLGgRvbYM8lWJPHyb
	tNP3C6kEXW9LgC7w+JW7sPvjcyoFFGt7tOd5Tw1/Mjr2bvfTwkB2FEa0ZPxikyXZELTZCm
	bSU17ekb/orQJ1jN4sVFDFLTQIcmwH0=
Date: Thu, 1 May 2025 11:54:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 bpf-next 4/7] bpf: udp: Use bpf_udp_iter_batch_item for
 bpf_udp_iter_state batch items
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250428180036.369192-1-jordan@jrife.io>
 <20250428180036.369192-5-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250428180036.369192-5-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/28/25 11:00 AM, Jordan Rife wrote:
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 57ac84a77e3d..866ad29e15bb 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3390,13 +3390,17 @@ struct bpf_iter__udp {
>   	int bucket __aligned(8);
>   };
>   
> +union bpf_udp_iter_batch_item {
> +	struct sock *sock;

A nit. just noticed this.

Since it needs a respin, rename the pointer from "sock" to "sk". It should be 
more consistent with most other places on the "struct socket *sock" / "struct 
sock *sk" naming.

