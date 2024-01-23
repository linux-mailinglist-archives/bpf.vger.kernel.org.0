Return-Path: <bpf+bounces-20122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B21F839ADA
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1079B1F2CA68
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3C52C1B0;
	Tue, 23 Jan 2024 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vCgjwDLO"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AE1A27A
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043976; cv=none; b=X6UoZQlAiwmkN7v/D8sk7NzEpGQR3/GXmXZ6LPWDxr12NHqv84u+dPgI3Ngfy4Ubk15HDzZgAie+ihNljsMgzo97LEfTPEQyaaXNXXGsUpntIrN7QKpVIzDU0ucB+1Nr7ozp78WeQHBAJ1bBTbEe5gM5a8zIeb1GUzb86VddVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043976; c=relaxed/simple;
	bh=P9m1s0it9AR9iqihCcq/NiVZUEkFjimmU6MlXQQ+Eno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSMv1Gg4283wsvIN33cs63iO5X63I1HBMcJWrq6AdA04faGj5PCJBIiHSVGU0AliFnLkrQanh93AtawFqjZYLisKkdREQuSeHmN1Ghib7vWuxdaX8b2rdaMXmMnvx8pZWhFO8ylmS7Jq61K+S9SUWpaBJNd0ysAbQY8pNyUyhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCgjwDLO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e966e13e-282b-4f18-878f-c68de7939daf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706043971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9giDe6/46mShrAE/YTH2n9/fB/qyZz/RqpmRXR5U30=;
	b=vCgjwDLOG5M9bweoc4qLsvvfZZUxms9StAXTrbzdGY37ocHYuXi9KbYhX+I6PIobBPjSRe
	fH5diq5UAAQuK2V5REjyl6JKeVow3w5NgK8mU+rEZgG1TJntP6QxVy8OJ9iP55WtiogGbi
	BVKFVFClSdjgGB8gUr+0DlU18RtXuqU=
Date: Tue, 23 Jan 2024 13:06:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: avoid VLAs in progs/test_xdp_dynptr.c
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
 david.faust@oracle.com, cupertino.miranda@oracle.com
References: <20240123201729.16173-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240123201729.16173-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/23/24 12:17 PM, Jose E. Marchesi wrote:
> VLAs are not supported by either the BPF port of clang nor GCC.  The
> selftest test_xdp_dynptr.c contains the following code:
>
>    const size_t tcphdr_sz = sizeof(struct tcphdr);
>    const size_t udphdr_sz = sizeof(struct udphdr);
>    const size_t ethhdr_sz = sizeof(struct ethhdr);
>    const size_t iphdr_sz = sizeof(struct iphdr);
>    const size_t ipv6hdr_sz = sizeof(struct ipv6hdr);
>
>    [...]
>
>    static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
>    {
> 	__u8 eth_buffer[ethhdr_sz + iphdr_sz + ethhdr_sz];
> 	__u8 iph_buffer_tcp[iphdr_sz + tcphdr_sz];
> 	__u8 iph_buffer_udp[iphdr_sz + udphdr_sz];
> 	[...]
>    }
>
> The eth_buffer, iph_buffer_tcp and other automatics are fixed size
> only if the compiler optimizes away the constant global variables.
> clang does this, but GCC does not, turning these automatics into
> variable length arrays.
>
> This patch removes the global variables and turns these values into
> preprocessor constants.  This makes the selftest to build properly
> with GCC.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com

Acked-by: Yonghong Song <yonghong.song@linux.dev>


