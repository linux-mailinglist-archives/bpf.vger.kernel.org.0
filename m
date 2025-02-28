Return-Path: <bpf+bounces-52908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4A3A4A3BD
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 21:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588ED189030D
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E527D77F;
	Fri, 28 Feb 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iee3yVRM"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C526FDB4
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773311; cv=none; b=Kq+LpzOVvINv6O4ZNBWqRm/wkG+93zBchghYA7D/s9YNeU6DFTz9UsCIIthi5Jqcffcpos1wuKIVn4KRGliVRKnuR9S8QkwBsGJidPm6IhC0hZsWhSZHH5JBuq/fnPOWY8pTp0hNLrCXfP+sV3QaaUhWeEDvGx3aBGv+X4SXDl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773311; c=relaxed/simple;
	bh=dN5erVEOdVNv3oiWJXPSnonCC/q7xzUNqwNCyBAEI3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hb+anhw0nJUTFVfMUg38Jw647uUgKGhLBr8eCvXYMJtL6Q+szr4z7Z9upEwFL/2Fma9oaxdLLf5Y758TCle7RwZ/ZnP38RYMndECtvDwQwjUa1G20F5WT50EWu0dtb9CczPOGk+hxCqJIyyCILg4Osc0YaNbe5XtGNx8Vq7t/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iee3yVRM; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ef054b4-3340-4b0e-9ba6-7b7409f9eb71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740773305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUG1i0ZL+wix5b2+TFEt5FV9JDKNxVcCuHH6kCyEvFM=;
	b=Iee3yVRM9G4Kqlw+8+wbdMX2GaTOnlnea8Slk0svUu1qmw1YouBr6SZsANz4314sMTIoTp
	9dEbz6DBjunvK69It02uhBvXu3ni7oBeseTGcz6qj6mZTYEAuUTXeSEPQZuFI0ypRhHFC6
	ksjX9h/XWWy6RwsiOVhMoZ10MPzgJYQ=
Date: Fri, 28 Feb 2025 12:08:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 0/2] Introduced to support the ULP to get or
 set sockets
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, yanan@huawei.com, wuchangye@huawei.com,
 xiesongyang@huawei.com, liuxin350@huawei.com, liwei883@huawei.com,
 tianmuyang@huawei.com, Network Development <netdev@vger.kernel.org>
References: <20250228085340.3219391-1-zhangmingyi5@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250228085340.3219391-1-zhangmingyi5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/28/25 12:53 AM, zhangmingyi wrote:
> From: Mingyi Zhang <zhangmingyi5@huawei.com>
> 
> We want call bpf_setsockopt to replace the kernel module in the TCP_ULP
> case. The purpose is to customize the behavior in connect and sendmsg
> after the user-defined ko file is loaded. We have an open source
> community project kmesh (kmesh.net). Based on this, we refer to some
> processes of tcp fastopen to implement delayed connet and perform HTTP
> DNAT when sendmsg.In this case, we need to parse HTTP packets in the
> bpf program and set TCP_ULP for the specified socket.
> 
> Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
> bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
> I'm not sure why there is such a difference, but I noticed that
> tcp_setsockopt is called in bpf_setsockopt.I think we can add the
> handling of this case.

Please stop sending multiple new versions while the earlier raised questions
still have not been replied [1]. Also, netdev is still not cc-ed.

[1]: https://lore.kernel.org/all/44668201-cf8b-49c1-9dd0-90e0e5a95457@linux.dev/

pw-bot: cr

