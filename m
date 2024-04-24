Return-Path: <bpf+bounces-27728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC518B1504
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A941F23D21
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62955156985;
	Wed, 24 Apr 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R5FeLZGw"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7410156679
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992728; cv=none; b=S13GC8QfknQPamtr1GEiM8X6Z2Z7HG4ylhqaRiH0TcS9eZz+HkRRyd5OP4DaUQsJlNntw4URLVifd0J/8moIV1QMVQB49gF1EZkE9UF+M+owBceLbhS7WbtgkblMrcAVIwTn8w6VUV1Ql3zu3/BAyMLxFNUzxnUiJERtO4CTJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992728; c=relaxed/simple;
	bh=3rnEzPTPTQC6VyByZI00ZeWiAz6Qkdns7h1jm5DXG8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJ0ettuF2aU6DYS4qKihq+NAJ7+FngIo/GMSke54gzstD8HZM5TN4l4Dzkv38rax0pS2EWvv7TxiaTNTKDfOIdnURWjcMXDIcdv2h3OManDfvWlaN+FbN/CK795FNo9DL37ujHWGQ9LcqXeu3wVKHi19OuyeVYFBuUnppbW6GEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R5FeLZGw; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713992723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbAJpa13HL36j8LqNaT6BJ4OtHgpsGlyGcBm3l4z/dM=;
	b=R5FeLZGw7fi4oPEXx7G9yG6GwPBwGgS4IkBTTlQAcabbJt8BirRwtA+60sxdL9I/t1pGJ6
	tnEok+zWu7X8JHpH0aK4p+5PmGkPl0xKIPbJKQgvrMkoweMr28/DYYCLzYtR/WmHUUdjuS
	XcCnFRwujUiCMLyuQQOaEsJF0B5O048=
Date: Wed, 24 Apr 2024 14:05:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in
 selftests/bpf/Makefile
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
 david.faust@oracle.com, cupertino.miranda@oracle.com
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240424084141.31298-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
> This little patch modifies selftests/bpf/Makefile so it passes the
> following extra options when invoking gcc-bpf:
>
>   -gbtf
>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.

Could we do if '-g' is specified, for bpf program,
btf will be automatically generated?

>
>   -mco-re
>     This tells GCC to generate CO-RE relocations in .BTF.ext.

Can we make this default? That is, remove -mco-re option. I
can imagine for any serious bpf program, co-re is a must.

>
>   -masm=pseudoc
>     This tells GCC to emit BPF assembler using the pseudo-c syntax.

Can we make it the other way round such that -masm=pseudoc is
the default? You can have an option e.g., -masm=non-pseudoc,
for the other format?

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
>   tools/testing/selftests/bpf/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index edc73f8f5aef..702428021132 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -442,7 +442,7 @@ endef
>   # Build BPF object using GCC
>   define GCC_BPF_BUILD_RULE
>   	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
> -	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
> +	$(Q)$(BPF_GCC) $3 -O2 -gbtf -mco-re -masm=pseudoc -c $1 -o $2
>   endef
>   
>   SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c

