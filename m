Return-Path: <bpf+bounces-19836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0038320E3
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C29B1F252F9
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2292EB06;
	Thu, 18 Jan 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JbIuMh21"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A52E405
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613414; cv=none; b=KStJsun+MMZkx8pP1E7gy1r1fXw9Bvei9E2SfaHQD3dtv96XluB4HmDPMuxVqIpppmNImOfrC8EeBEpN6LciHNb3AXJE2ifGDam5YxWgIMpmGN93dteYBt7zFF8IoT5ZNIpIO1D5Us3FCGss5Xdi04aD3J4YB4htwiecB9LNmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613414; c=relaxed/simple;
	bh=7WQsJ8Tf7CaGSXDKCFoa+BtJgZ4fKTlml45/gJFkPDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXJ1x6f9zc2LPuBuGAuGFu1B9ghB6GjoFPdz/3/InFkEnE8GStxpVa3W3IKt7auaaNsfJVbPLtutqZObjO2unIBawmx3rNnvLzTJJhvgm+qzyxopw8zuKJJaOvs+qYHQjLbUBmyzVOx7xzG3ofpClhpfBkk4Roh9jlmwl84+AdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JbIuMh21; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5c4ad938-eef4-4d6a-84e0-ffb10630fef9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705613410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeFgCIWyJdy38ixF0n0UBEtxo16pAI1iqb5H63NyGug=;
	b=JbIuMh21/QokojpOA6zsLxr1kYY5hRrmEY+dSYTkyGAZplbtQCvoqwe2vwrbKEzIGCcV3K
	2dp2pZojWsKALftKch6Ud4USMQ94lbTn+MaUZuuhojRMem8t7ZYjZmeogkcWrr6ja920rQ
	XYAw8gQd3RtM+tYSh0xaPt3Yj6g0I5Y=
Date: Thu, 18 Jan 2024 13:30:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v16 03/14] bpf, net: introduce
 bpf_struct_ops_desc.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240118014930.1992551-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
> @@ -1750,11 +1755,6 @@ static inline int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
>   {
>   	return -EINVAL;
>   }
> -static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
> -{
> -	return -EOPNOTSUPP;
> -}
> -

This patch is about adding bpf_struct_ops_desc. Why the 
bpf_struct_ops_link_create() is removed here?
An unrelated (and unnecessary?) changes?

