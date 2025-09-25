Return-Path: <bpf+bounces-69757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0ABA0F02
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450E21C2312D
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A430F55D;
	Thu, 25 Sep 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vROjpSYr"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBD30DD06
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822473; cv=none; b=c/q0DHSrJfuu2Yfu3vPMHyc3gfdc2HSaAtYiIdkUKH/L/9IMz/XUhA3OSmVGsNCmSRCz89789X+TUeSsxn+rzooXkVfaAGLhUplMinzZu7RK8v4ORG0T4XRJ2bPFFC4Gsieh46hwWawBJi+KwLkIrDOfhOs+ZrdDq8fSBgHVjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822473; c=relaxed/simple;
	bh=gQJx0hw8ktpOVzMQgzJ4UPoa4UdFT7S097c0TWcF5tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tzb1LT6rdXhr5oXq8G5V3R2VgfZth6/mAUXBtJRPIfEN8Fyzxgn81NKjl2R2Z3T3UlVdgy/fXQ1fxus38xkPREV5wu+T1BowHXmsViCC1p3En/LzV2pDfeDZELTB42tuNjh3rFLmFAVKHowDZjd8PmqNr5N02X7e9XiAMRthm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vROjpSYr; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac326390-3a3b-4d2d-9be8-f9ec2152eb6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758822469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltxiZCxj4vl+4564rdV2K0enablBoYFfJi76z7YT/pg=;
	b=vROjpSYrAmjkgNq+rdHra4kZh80mMNaBnPoq+Z/Ax/5u0cVg2cUlR+uqus4Q/8f7yz/RRV
	sXIBsogKceCOif3eCHogeJpB5FpoOd12GerknH/iXceDSe29LNzTsxBa/9J5P8AD250mq6
	WJBppgeaGYkCKapQiZkB5QJ1fIR1lFc=
Date: Thu, 25 Sep 2025 10:47:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/1] selftests: drv-net: Reload pkt pointer after
 calling filter_udphdr
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, stfomichev@gmail.com, kernel-team@meta.com
References: <20250925161452.1290694-1-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250925161452.1290694-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/25/25 9:14 AM, Amery Hung wrote:
> Fix a verification failure. filter_udphdr() calls bpf_xdp_pull_data(),
> which will invalidate all pkt pointers. Therefore, all ctx->data loaded
> before filter_udphdr() cannot be used. Reload it to prevent verification
> errors.
> 
> The error may not appear on some compiler versions if they decide to
> load ctx->data after filter_udphdr() when it is first used.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

