Return-Path: <bpf+bounces-19283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CF9828E1B
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 20:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9085E1F21905
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 19:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2A3D3A5;
	Tue,  9 Jan 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fLrETZHQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2520A3D3AE
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82f55c0e-0ec8-4fe1-8d8c-b1de07558ad9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704829243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsdEHeEwRYmVyFsFYFedUjisXdYoKaXuYf8Fki4RZuY=;
	b=fLrETZHQx/JZZ5zipm54JSKGvNoZAzqY4Q1B1yXvx7aG5TlMzcJI+FIHGUyYoj8nwCVXsd
	3DvHJf549YTYpCopq4+lVeCE9GTiqRg3M58jdh93gZoFxTJspRAYpXxV2gUBCNT6c+nEN9
	vTgJpWSNyH3RkT0KAyG8OaW3hHShm08=
Date: Tue, 9 Jan 2024 11:40:38 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix potential premature unload in
 bpf_testmod
Content-Language: en-GB
To: Artem Savkov <asavkov@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, jolsa@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240109164317.16371-1-asavkov@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240109164317.16371-1-asavkov@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/9/24 8:43 AM, Artem Savkov wrote:
> It is possible for bpf_kfunc_call_test_release() to be called from
> bpf_map_free_deferred() when bpf_testmod is already unloaded and
> perf_test_stuct.cnt which it tries to decrease is no longer in memory.
> This patch tries to fix the issue by waiting for all references to be
> dropped in bpf_testmod_exit().
>
> The issue can be triggered by running 'test_progs -t map_kptr' in 6.5,
> but is obscured in 6.6 by d119357d07435 ("rcu-tasks: Treat only
> synchronous grace periods urgently").
>
> Fixes: 65eb006d85a2a ("bpf: Move kernel test kfuncs to bpf_testmod")

Please add your Signed-off-by tag.

I think the root cause is that bpf_kfunc_call_test_acquire() kfunc
is defined in bpf_testmod and the kfunc returns some data in bpf_testmod.
But the release function bpf_kfunc_call_test_release() is in the kernel.
The release func tries to access some data in bpf_testmod which might
have been unloaded. The prog_test_ref_kfunc is defined in the kernel, so
no bpf_testmod btf reference is hold so bpf_testmod can be unloaded before
bpf_kfunc_call_test_release().
As you mentioned, we won't have this issue if bpf_kfunc_call_test_acquire()
is also in the kernel.

I think putting bpf_kfunc_call_test_acquire() in bpf_testmod and
bpf_kfunc_call_test_release() in kernel is not a good idea and confusing.
But since this is only for tests, I guess we can live with that. With that,

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 91907b321f913..63f0dbd016703 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -2,6 +2,7 @@
>   /* Copyright (c) 2020 Facebook */
>   #include <linux/btf.h>
>   #include <linux/btf_ids.h>
> +#include <linux/delay.h>
>   #include <linux/error-injection.h>
>   #include <linux/init.h>
>   #include <linux/module.h>
> @@ -544,6 +545,9 @@ static int bpf_testmod_init(void)
>   
>   static void bpf_testmod_exit(void)
>   {
> +	while (refcount_read(&prog_test_struct.cnt) > 1)
> +		msleep(20);
> +
>   	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
>   }
>   

