Return-Path: <bpf+bounces-46821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55C9F03DD
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 05:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D0C188A607
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 04:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C96017B50E;
	Fri, 13 Dec 2024 04:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s4wPCuuX"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211E2F43
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 04:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734064899; cv=none; b=tQ5eaEvo5qlaPeroyppmP8guvu28MvUi6t+qLhUzAGyfhjL0c2EJcaDRLRMPQPN0bUA99Mn66frMfn+1pFXioDq3iDjnYQ58Ca4n5yDu6FFv5Z4FVNl+N7b9yGK20dPEKqF0Uh6LW3tae4NKfMjsY536L+TOFVwZiY/ueUrgxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734064899; c=relaxed/simple;
	bh=jVKCBqfCv807J9PpkKNzROeSumf5q/PqRKeFSjbm2Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1dEICDPC81DVHlX51jWV0Namx58XDTBzQvXXfSc78fDKdsVD8eSMZOY80+sVGXcqcGQw3p6LP+iqOgjkF93LV96Ph4ReM5uTV3+24cfDmKd7f976fWVjibVfl1X72AF47QYFwKO1zjL6OlByG2UUVMocgf4FKoVqMSubko1MS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s4wPCuuX; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c2b0ca13-6e8c-4690-bdf0-f433a65d65bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734064892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/k/ta4AK8DaRoHaoCujrFsB1Y+SL4mTA33LMiMxnSFo=;
	b=s4wPCuuX8r72M/iHo7oIqb4JArD+cS6BePJVchhOanph73Ygcj1LodB9hfNDpjgkRDuFm5
	YpO5EeoltrcD6d0QiIB5q1QvUBh78PKSpA1GjXKc03XE0B4LerrhLPzcgvvZT8H50gy6B0
	H+Ltu1bOdYlByV2DugVF4D4Y5JA1T4M=
Date: Thu, 12 Dec 2024 20:41:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: make BPF_TARGET_ENDIAN non-recursive
 to speed up *.bpf.o build
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com
References: <20241213003224.837030-1-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241213003224.837030-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 12/12/24 4:32 PM, Eduard Zingerman wrote:
> BPF_TARGET_ENDIAN is used in CLANG_BPF_BUILD_RULE and co macros.
> It is defined as a recursively expanded variable, meaning that it is
> recomputed each time the value is needed. Thus, it is recomputed for
> each *.bpf.o file compilation. The variable is computed by running a C
> compiler in a shell. This significantly hinders parallel build
> performance for *.bpf.o files.
>
> This commit changes BPF_TARGET_ENDIAN to be a simply expanded
> variable.
>
>      # Build performance stats before this commit
>      $ git clean -xfd; time make -j12
>      real	1m0.000s
>      ...
>
>      # Build performance stats after this commit
>      $ git clean -xfd; time make -j12
>      real	0m43.605s
>      ...
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

LGTM except should target to bpf-next.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index bb8cf8f5bf11..9e870e519c30 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -461,10 +461,10 @@ $(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PTR|LONG)
>   endef
>   
>   # Determine target endianness.
> -IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
> +IS_LITTLE_ENDIAN := $(shell $(CC) -dM -E - </dev/null | \
>   			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
> -MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> -BPF_TARGET_ENDIAN=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
> +MENDIAN:=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> +BPF_TARGET_ENDIAN:=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
>   
>   ifneq ($(CROSS_COMPILE),)
>   CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))


