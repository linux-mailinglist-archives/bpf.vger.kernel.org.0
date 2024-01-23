Return-Path: <bpf+bounces-20125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A8839AEF
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D251F2C180
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5D33CED;
	Tue, 23 Jan 2024 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DcoAyG9m"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B82C1BC
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044789; cv=none; b=s56j+IWq9y9j3tiwJkn+uPL5g9c6ECKjUG5hI0NG10FeXtWBmvjuYIU32dcg7yCebZ1+iMHp6I0ISxmDkXadTZSMoJpKfyTxLvlISkuYo/bYm6FM3jRvjOLoU56OmLvh1KxfYkOKlXdRDwQBEJnUjGgB/lTMfeBAUhqMteC6i5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044789; c=relaxed/simple;
	bh=lX5Jf9zS07qov3bFFdCeZ4yjvGPA5ABSUhfxSI0fgHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ln3Zr5SebTH5U/egZmndMxyDkDheuOI6UWJlQYB0m/S5hWTNL9V7AdHYaq+4Du95jsnfsRjqZXGh7yl6IpIywIw07g7JquNhyuBL04cB1s+UyXzgiuz0VjeiU6vGcSTPL2tLf/UYZB2/KEFPTc6Iz67nEPR8XYejyv6Lze3+cTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DcoAyG9m; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb8b375a-fdc7-40db-9ebf-ebc89a12f5c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706044785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1IBNR0wJj4FmeRMzXNAzIUucYoOzwez+lyYiya88Do=;
	b=DcoAyG9mGmufuvEqCcZFIhBiUTY36cyaN7paaDC+l+Yq4QthMneFWZd3PcA0SjhgDdmRvI
	H801q6BjZ6L3f/ui7ROH14d27Ut1JaIk0y+6An3r39E1nYQX0C+TasycfEJQdp+ZtaSMAE
	eMyF2t529wXB4Tjx6Mu6WWEmnn3CiEg=
Date: Tue, 23 Jan 2024 13:19:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf_helpers.h: define bpf_tail_call_static when building
 with GCC
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
 david.faust@oracle.com, cupertino.miranda@oracle.com
References: <20240123185945.16005-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240123185945.16005-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/23/24 10:59 AM, Jose E. Marchesi wrote:
> The definition of bpf_tail_call_static in tools/lib/bpf/bpf_helpers.h
> is guarded by a preprocessor check to assure that clang is recent
> enough to support it.  This patch updates the guard so the function is
> compiled when using GCC as well.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> ---
>   tools/lib/bpf/bpf_helpers.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 2324cc42b017..3306f50c5081 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -136,7 +136,7 @@
>   /*
>    * Helper function to perform a tail call with a constant/immediate map slot.
>    */
> -#if __clang_major__ >= 8 && defined(__bpf__)
> +#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)

Do you want to guard with a gcc version as well here or you assume any gcc which supports bpf
should be okay here?

>   static __always_inline void
>   bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>   {

