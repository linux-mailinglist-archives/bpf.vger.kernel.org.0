Return-Path: <bpf+bounces-28912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0448BEAB3
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016B51F2601F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671216C853;
	Tue,  7 May 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xjLA1wT5"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650340BE2
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103686; cv=none; b=Di/wG/N7xs6LvBKIkWhcpilQxHJVlN4Oc+aaMmaCv6R8+hbbOGrzzCbGdinjRb+WiukAf+xarO+UZqa5+jYcSKn0VATdKLKGRBsgOSfctNsr57I7T/CfnFR/HDv92Yv41FUbuQGUeWiYDXee1qDINjhTOJPeLcJVS+Z84bCTflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103686; c=relaxed/simple;
	bh=XiGTImf6ALTx2G9ZY/ywi9qQBNEVTqUH7+1fkpZkQkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX+xwx2YRfikjFahg6Cmvm9sICQi/r7CZ3MNLjSYF3QDwF4Sct6r/0lHQjXvc1lWQpO2UndHZwVhYbzIE3f5ohG08ZZII6VzZDpAJ7L/syi0xHWdKK/wiTI1bZXxpmz7ZegV7lQZJahuEfIofSaRuezQat753+GeQC0YHG58I8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xjLA1wT5; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <223e5ab8-83da-40b7-b10b-0f6341aacb27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715103677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VUpCvzEYqWt3KTHjG8stgwjh3syA9a9hmb8NY49okU=;
	b=xjLA1wT5+PsrXzOt+6F7YaUo6nLj9aL8yIB3wY0PAL91/ndIJbGTSfomErfuYaToORHHwo
	p+rTrNf/fIJ+C7qIv5kKMK6ugBuLsmbVTf+Yor8KcCe5SuRecuyJHIVO8aAbl/eBE8aA6/
	9ocPbH3jbs+Lp2pzRLsThDLDsvDQ9dY=
Date: Tue, 7 May 2024 10:41:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: avoid uninitialized warnings in
 verifier_global_subprogs.c
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20240507140540.3972-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240507140540.3972-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/7/24 7:05 AM, Jose E. Marchesi wrote:
> The BPF selftest verifier_global_subprogs.c contains code that
> purposedly performs out of bounds access to memory, to check whether
> the kernel verifier is able to catch them.  For example:
>
>    __noinline int global_unsupp(const int *mem)
>    {
> 	if (!mem)
> 		return 0;
> 	return mem[100]; /* BOOM */
>    }
>
> With -O1 and higher and no inlining, GCC notices this fact and emits a
> "maybe uninitialized" warning.  This is by design.  Note that the
> emission of these warnings is highly dependent on the precise
> optimizations that are performed.

Interesting. The error message is 'maybe uninitialized' but not
an error to complain out-of-bound access. But anyway, since gcc
produces a warning, your patch silences it and LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>
> This patch adds a compiler pragma to verifier_global_subprogs.c to
> ignore these warnings.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/testing/selftests/bpf/progs/verifier_global_subprogs.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index baff5ffe9405..d05dc218b7e9 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -8,6 +8,11 @@
>   #include "xdp_metadata.h"
>   #include "bpf_kfuncs.h"
>   
> +/* The compiler may be able to detect the access to uninitialized
> +   memory in the routines performing out of bound memory accesses and
> +   emit warnings about it.  This is the case of GCC. */
> +#pragma GCC diagnostic ignored "-Wuninitialized"
> +
>   int arr[1];
>   int unkn_idx;
>   const volatile bool call_dead_subprog = false;

