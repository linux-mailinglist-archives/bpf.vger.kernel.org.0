Return-Path: <bpf+bounces-37810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F5595AA9B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5157A1C21649
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2379C2;
	Thu, 22 Aug 2024 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S5cFcC2C"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3C11711
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290731; cv=none; b=QquO8Qh6AGUs98kSMG1HQ5Shn5ouQmYXz1CETM1LE9ciOCTS8h0+VJICR+o6jLSprhh6yJBQlc9DgvL8TJC+BodWlknBLT1rJtpzzQzXFXm9FUMQoAX/ZioB7qrF6VQ/QqpiM7NCyggFYXeo2Tncjt6d5QdP1RDGxvmSJpZ6H6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290731; c=relaxed/simple;
	bh=ugA5GzRB80VSDB1x0QYVBi727H6utv7CE/AJC0QHglE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuc6y1RoWKzypE8vqRGzU+50w91QSItrqKw0ZLpQONsXmyvoMZguxoB2gjgdeEsYKaVxUqbYfskTYLOhlcZqGkqkDX2MaXEZ/76hcKz38nXRheOvuJSedD7xVdKzuCXuCOWOGmn55HTg+VC7yLRrnAMguM660EgFYZHcI78L7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S5cFcC2C; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e080afa6-5bc2-43e4-95d6-91c2c142696e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724290727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BT0lWJaosXegXJyhEYn0Gpg8bdgEk0No948170IeTUo=;
	b=S5cFcC2CR4G1gFDXLlJUkksqnzwwp4VjuiCZC/hARl++3AO6OXgRh49sjul9zOWsfykYoz
	4kR24AkVz09q/1ta/dOG8eJ7WZ0VGSIlBHEp0iIf0J3IdmgqhPTPvnEWumVybGviIl39mJ
	uIert+PDS7zUjGjbInKb6E/rQVP9gHI=
Date: Wed, 21 Aug 2024 18:38:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: check if bpf_fastcall is
 recognized for kfuncs
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, jose.marchesi@oracle.com
References: <20240817015140.1039351-1-eddyz87@gmail.com>
 <20240817015140.1039351-6-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240817015140.1039351-6-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/16/24 6:51 PM, Eduard Zingerman wrote:
> Use kfunc_bpf_cast_to_kern_ctx() and kfunc_bpf_rdonly_cast() to verify
> that bpf_fastcall pattern is recognized for kfunc calls.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

LGTM with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../bpf/progs/verifier_bpf_fastcall.c         | 50 +++++++++++++++++++
>   1 file changed, 50 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> index f75cd5e3fffe..97c2420ccb38 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> @@ -2,8 +2,11 @@
>   
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
>   #include "../../../include/linux/filter.h"
>   #include "bpf_misc.h"
> +#include <stdbool.h>
> +#include "bpf_kfuncs.h"
>   
>   SEC("raw_tp")
>   __arch_x86_64
> @@ -793,4 +796,51 @@ __naked int bpf_fastcall_max_stack_fail(void)
>   	);
>   }
>   
> +SEC("cgroup/getsockname_unix")
> +__xlated("0: r2 = 1")
> +/* bpf_cast_to_kern_ctx is replaced by a single assignment */
> +__xlated("1: r0 = r1")
> +__xlated("2: r0 = r2")
> +__xlated("3: exit")
> +__success
> +__naked void kfunc_bpf_cast_to_kern_ctx(void)
> +{
> +	asm volatile (
> +	"r2 = 1;"
> +	"*(u64 *)(r10 - 32) = r2;"
> +	"call %[bpf_cast_to_kern_ctx];"
> +	"r2 = *(u64 *)(r10 - 32);"
> +	"r0 = r2;"
> +	"exit;"
> +	:
> +	: __imm(bpf_cast_to_kern_ctx)
> +	: __clobber_all);
> +}
> +
> +SEC("raw_tp")
> +__xlated("3: r3 = 1")
> +/* bpf_rdonly_cast is replaced by a single assignment */
> +__xlated("4: r0 = r1")
> +__xlated("5: r0 = r3")
> +void kfunc_bpf_rdonly_cast(void)
> +{
> +	asm volatile (
> +	"r2 = %[btf_id];"
> +	"r3 = 1;"
> +	"*(u64 *)(r10 - 32) = r3;"
> +	"call %[bpf_rdonly_cast];"
> +	"r3 = *(u64 *)(r10 - 32);"
> +	"r0 = r3;"
> +	:
> +	: __imm(bpf_rdonly_cast),
> +	 [btf_id]"r"(bpf_core_type_id_kernel(union bpf_attr))
> +	: __clobber_common);
> +}
> +
> +void kfunc_root(void)

It would be good to add some comments for this function to indicate that
this func intends to enable BTF generation for kfuncs bpf_cast_to_kern_ctx()
and bpf_rdonly_cast() which are necessary for the above two programs.

> +{
> +	bpf_cast_to_kern_ctx(0);
> +	bpf_rdonly_cast(0, 0);
> +}
> +
>   char _license[] SEC("license") = "GPL";

