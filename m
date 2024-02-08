Return-Path: <bpf+bounces-21552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7484EB68
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01AE1C250D3
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207C50245;
	Thu,  8 Feb 2024 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VB46UtBY"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E194F8A3
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430337; cv=none; b=iBeXI9tre7ZtqTBBUXCu0ybTz/MOMZ5gJS2Vxrtxk0zjg1BUXN4uGDLhvo1JnXwtW8SX4t/61cd4Sgh68k6gVXT10FWwjH9XLEUasalwC/U4lJ780GgrB51Dx8LZkX83N1Az1uDQ4lrBriXfYzSMj+ZcsBCWo1z81HWLgYYcamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430337; c=relaxed/simple;
	bh=wlXMM6BD3D0VZzCaKJTnUgbkJ3H/iX9cQTQ7HpuWSlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMVf2GVvbVDt0wVv4TSpdIyCiQENClpUX1xyA++ZYZJ6pZ9nN3QAg9mLu5WfWBqwn7NwFQdI9/KUaJrplUC/7IiCNNKi7hkemXS+OR1rYGmsxEb5upXQUfpNEjenzG2pQt7FqsrjdzAA+TrR4rrVYMcpuRtgF8+rzhX9AEU+kDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VB46UtBY; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cff448e3-f751-482d-ae4d-65a2bca82b20@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707430333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXg57P56aym5qVyBjjCCLuyG8BCFl6psEMcQVBwro6A=;
	b=VB46UtBYtoNVzQvgMwwaDEAv6vFNSN6+YA7NqMu76qSh8yZ0XOFmlYYJSTytQswUv5qbcY
	WcxMQz4yjPgtrSjkUzwSsnqr2uJsykm1uisxAoRxlmF6g5IvSfGmNjvRY91jrfdGfLZEhP
	Yb+a3nEUAxsmCKEVzJqIU0c5buLUAvo=
Date: Thu, 8 Feb 2024 14:12:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V2] bpf: abstract loop unrolling pragmas in BPF
 selftests
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, david.faust@oracle.com,
 cupertino.miranda@oracle.com
References: <20240208203612.29611-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240208203612.29611-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/8/24 12:36 PM, Jose E. Marchesi wrote:
> [Changes from V1:
> - Avoid conflict by rebasing with latest master.]
>
> Some BPF tests use loop unrolling compiler pragmas that are clang
> specific and not supported by GCC.  These pragmas, along with their
> GCC equivalences are:
>
>    #pragma clang loop unroll_count(N)
>    #pragma GCC unroll N
>
>    #pragma clang loop unroll(full)
>    #pragma GCC unroll 65534
>
>    #pragma clang loop unroll(disable)
>    #pragma GCC unroll 1
>
>    #pragma unroll [aka #pragma clang loop unroll(enable)]
>    There is no GCC equivalence to this pragma.  It enables unrolling on
>    loops that the compiler would not ordinarily unroll even with
>    -O2|-funroll-loops, but it is not equivalent to full unrolling
>    either.
>
> This patch adds a new header progs/bpf_compiler.h that defines the
> following macros, which correspond to each pair of compiler-specific
> pragmas above:
>
>    __pragma_loop_unroll_count(N)
>    __pragma_loop_unroll_full
>    __pragma_loop_no_unroll
>    __pragma_loop_unroll
>
> The selftests using loop unrolling pragmas are then changed to include
> the header and use these macros in place of the explicit pragmas.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com

Acked-by: Yonghong Song <yonghong.song@linux.dev>


