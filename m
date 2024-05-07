Return-Path: <bpf+bounces-28892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131C8BE8C4
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA131F25BAD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9516C853;
	Tue,  7 May 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jr5PuPpk"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062015DBAE
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099022; cv=none; b=B6+v2J+KWNXKGcJGyq83rK+Hzdx2J0Q28bPeju7+aLbXU8AEC4uBx2DJrKwTHLA6TBtYHiTTlYoDawgxqcLxfZZGxRodvGrfayFLkD81+pFZZXFsj7dcccg9FwMDnOj4yNsjp4aMI3j9qtJejf4BNWLe/1+JhFHHrmP1tZSSldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099022; c=relaxed/simple;
	bh=JYETHVpXfG/IOE1NocStmqlr4mjTnSvPEil736MhzI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojiYZZwI6dCMbzGQb1UN2WUDWyd6rU8aGOtY7x5q4MzocXiqPvB8hOZj4nLpJKvp924z1bCU8vU4QOLPfbDvyHVW2fX+k20JXxa0tIpvY8fXzfZUjApX5nTxeTL0M/toUz0itvyRNiQIttHvv2KttLgtLNLEvXNCrzuSE5iO38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jr5PuPpk; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <263a563a-3abe-4c88-8a1e-e10fb8a6dfad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715099018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3QSPEp3QVLFM+pfahGDqaxQBjZmMDI7OLyr2e9NWdY=;
	b=jr5PuPpk6GKfCLeRe70BEVUkJ4O2QsjAsN+b467nK8v6+B8W3p1m9MCZZk3hnXJ5CIMjTE
	qojzDQ5347ivZgbHaR1u4QRPXntju81luiJteXk65Ko1rGVz11AftIBegT/pNpvAKZeKJh
	QTuDmKL0ta4iwPSVU4FirYQZ2+j+wgA=
Date: Tue, 7 May 2024 09:23:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: avoid uninitialized value in
 BPF_CORE_READ_BITFIELD
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20240507113950.28208-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240507113950.28208-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/7/24 4:39 AM, Jose E. Marchesi wrote:
> GCC warns that `val' may be used uninitialized in the
> BPF_CORE_READ_BITFIELD macro, defined in bpf_core_read.h as:
>
> 	[...]
> 	unsigned long long val;						      \
> 	[...]								      \
> 	switch (__CORE_RELO(s, field, BYTE_SIZE)) {			      \
> 	case 1: val = *(const unsigned char *)p; break;			      \
> 	case 2: val = *(const unsigned short *)p; break;		      \
> 	case 4: val = *(const unsigned int *)p; break;			      \
> 	case 8: val = *(const unsigned long long *)p; break;		      \
>          }       							      \
> 	[...]
> 	val;								      \
> 	}								      \
>
> This patch initializes `val' to zero in order to avoid the warning,
> and random values to be used in case __builtin_preserve_field_info
> returns unexpected values for BPF_FIELD_BYTE_SIZE.

In clang, __builtin_preserve_field_info either returns correct value
or caused compilation error. Do you mean for gcc __builtin_preserve_field_info
might return an unexpected value here?

BTW, your change makes sense to silent this warning. So Ack below.

>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/lib/bpf/bpf_core_read.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
> index b5c7ce5c243a..88d129b5f0a1 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -89,7 +89,7 @@ enum bpf_enum_value_kind {
>    */
>   #define BPF_CORE_READ_BITFIELD(s, field) ({				      \
>   	const void *p = (const void *)s + __CORE_RELO(s, field, BYTE_OFFSET); \
> -	unsigned long long val;						      \
> +	unsigned long long val = 0;					      \
>   									      \
>   	/* This is a so-called barrier_var() operation that makes specified   \
>   	 * variable "a black box" for optimizing compiler.		      \

