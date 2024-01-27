Return-Path: <bpf+bounces-20500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E983EFFD
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 21:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7C42835EA
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6FBE50;
	Sat, 27 Jan 2024 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c61PrMy9"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6BAB677
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706387419; cv=none; b=J5p6lcqaZJs5jZuAtJc2sUiAGeY/8yjynggh+9D+4zkR21y5E8enmCCvbu+CiaAKtdSwZTL2iCiryB4yoHel88Vk5y/F4fqz43FaDEsZABq6UZPR7zELyiQL06CS2Pei7Q9oUdZ8owxukZt5oMNMju7J7Y4xJbDlbX3vxLmHhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706387419; c=relaxed/simple;
	bh=Pq/VcIhFUqNM7LGwCbWJh7pF4opBJjDvXZC9cNQtga4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfVTxtQ0rx5l78e7Xfh+JWQ6PqyvDTRTHjMceF5b+EzHiYoZCce4BgXomxvQC+YAeCr2sfJKvYNzaPgksxFPvUNuoULSu/AbBuI6j0J8dwDSeStd5ieo02fz3G4nbTdJnI1qGQWS01SEv0H3ncxRixqlCq7gOz3cfZ7Oh3GCRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c61PrMy9; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4493711-52c9-43fe-b1b5-4bf210b768e8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706387411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFkwhL04wc/gZpiHy6blxi2jTH6thcOEmheEwVdXoDY=;
	b=c61PrMy9KjXjRKOVjfHNyoTldzHmMkqlztpPae4kmTsINZPDZpn2+ewcmIu+VqUYU20k9z
	8K4U5/Ym63wX5VSCbThPffQRwvhaSvXie8TYPjIFkPHpxFRRSGp7qrVaSyAnjMVsQi///M
	vkT1+nsyWFzjxXBhsd6mzucPTun8GSE=
Date: Sat, 27 Jan 2024 12:29:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: generate const static pointers for kernel helpers
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, eddyz87@gmail.com,
 cupertino.miranda@oracle.com, david.faust@oracle.com
References: <20240127185031.29854-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240127185031.29854-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/27/24 10:50 AM, Jose E. Marchesi wrote:
> The generated bpf_helper_defs.h file currently contains definitions
> like this for the kernel helpers, which are static objects:
>
>    static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>
> These work well in both clang and GCC because both compilers do
> constant propagation with -O1 and higher optimization, resulting in
> `call 1' BPF instructions being generated, which are calls to kernel
> helpers.
>
> However, there is a discrepancy on how the -Wunused-variable
> warning (activated by -Wall) is handled in these compilers:
>
> - clang will not emit -Wunused-variable warnings for static variables
>    defined in C header files, be them constant or not constant.
>
> - GCC will not emit -Wunused-variable warnings for _constant_ static
>    variables defined in header files, but it will emit warnings for
>    non-constant static variables defined in header files.
>
> There is no reason for these bpf_helpers_def.h pointers to not be
> declared constant, and it is actually desirable to do so, since their
> values are not to be changed.  So this patch modifies bpf_doc.py to
> generate prototypes like:
>
>    static void *(* const bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>
> This allows GCC to not error while compiling BPF programs with `-Wall
> -Werror', while still being able to detect and error on legitimate
> unused variables in the program themselves.
>
> This change doesn't impact the desired constant propagation in neither
> Clang nor GCC with -O1 and higher.  On the contrary, being declared as
> constant may increase the odds they get constant folded when
> used/referred to in certain circumstances.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: alexei.starovoitov@gmail.com
> Cc: yonghong.song@linux.dev
> Cc: eddyz87@gmail.com
> Cc: cupertino.miranda@oracle.com
> Cc: david.faust@oracle.com

LGTM. Please add proper tag in the commit subject, e.g.,
"[PATCH bpf-next]" instead of "[PATCH]", so CI can pick
up the patch and do proper test.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   scripts/bpf_doc.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index 61b7dddedc46..2b94749c99cc 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -827,7 +827,7 @@ class PrinterHelpers(Printer):
>                   print(' *{}{}'.format(' \t' if line else '', line))
>   
>           print(' */')
> -        print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
> +        print('static %s %s(* const %s)(' % (self.map_type(proto['ret_type']),
>                                         proto['ret_star'], proto['name']), end='')
>           comma = ''
>           for i, a in enumerate(proto['args']):

