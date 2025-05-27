Return-Path: <bpf+bounces-59014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85730AC5B16
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 21:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12153B81AA
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F220297C;
	Tue, 27 May 2025 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QiPPFB3G"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092451FFC4F
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375828; cv=none; b=I+6C2bYZuqAABQOQX/rG8P4WVyWBBPljqVjP1Gz6edYe8JEGxWv5FnGJUQ8y+uJ5JeLy6ivlZkMNrhVaO/QfV/M5svJCihAqUEJ0FbuA54Ci+9KKyr08f9d7TYVYS1a7lMUIlgzY1A/Ymw7B5sMmhhaTx6oXs1Xo9Haojm+0mCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375828; c=relaxed/simple;
	bh=Z8QSB6HG9YYeQLXMcUVbLxvcyC2gGfWeQB6L9uTKzlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCax2669YjBr37/uUCLdVmZs4ZDTQ3ZJmJw5eIUcAQOAXqITlhuHgjUOgFnFAx7K5iadVMHHwfjS/j1A/y0fqwM4FMGrLWaAl3IL6bFv2leUocKqvXyfc7htvpAR8Lc1FCWmbQxXb4A68pJggJPce+EdxysddFFeQZhY7a1yPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QiPPFB3G; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7aed6949-1076-4c8f-8939-35b47072d431@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748375820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6EVwXwy/iw5zAL88BgUvHPBitBadtIPlIDZl2zi2l0=;
	b=QiPPFB3G8phHO+W9NPix5uvMl5Mp/bCK42CM5vaGIOeUpipuyAD6z1KJMQpR/VWGtjgmhc
	VcqoC/fmA0zG2DpMORX1wepj410sfpdfaM7aK/xU8TGmxlQjUp0gwMoKTnXgfVCuiBX5Bc
	PoLKncxBhvEibHlPQPg9WSjyiLGWFqw=
Date: Tue, 27 May 2025 12:56:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Specify access type of bpf_sysctl_get_name args
To: Jerome Marchand <jmarchan@redhat.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org
References: <20250527165412.533335-1-jmarchan@redhat.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250527165412.533335-1-jmarchan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/27/25 9:54 AM, Jerome Marchand wrote:
> The second argument of bpf_sysctl_get_name() helper is a pointer to a
> buffer that is being written to. However that isn't specify in the
> prototype.
>
> Until commit 37cce22dbd51a ("bpf: verifier: Refactor helper access
> type tracking"), all helper accesses were considered as a possible
> write access by the verifier, so no big harm was done. However, since
> then, the verifier might make wrong asssumption about the content of
> that address which might lead it to make faulty optimizations (such as
> removing code that was wrongly labeled dead). This is what happens in

Could you give more detailed example about the above statement?

   the verifier might make wrong asssumption about the content of
   that address which might lead it to make faulty optimizations (such as
   removing code that was wrongly labeled dead)

This patch actually may cause a behavior change.

Without this patch, typically the whole buffer will be initialized
to 0 and then the helper itself will copy bytes until seeing a '\0'.

With this patch, bpf prog does not need to initialize the buffer.
Inside the helper, the copied bytes may not cover the whole buffer.

> test_sysctl selftest to the tests related to sysctl_get_name.
>
> Correctly mark the second argument of bpf_sysctl_get_name() as
> ARG_PTR_TO_UNINIT_MEM.
>
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> ---
>   kernel/bpf/cgroup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 84f58f3d028a3..09c02a592d24a 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2104,7 +2104,7 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
>   	.gpl_only	= false,
>   	.ret_type	= RET_INTEGER,
>   	.arg1_type	= ARG_PTR_TO_CTX,
> -	.arg2_type	= ARG_PTR_TO_MEM,
> +	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
>   	.arg3_type	= ARG_CONST_SIZE,
>   	.arg4_type	= ARG_ANYTHING,
>   };


