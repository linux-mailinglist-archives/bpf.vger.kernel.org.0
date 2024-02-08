Return-Path: <bpf+bounces-21465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857E84D753
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA08B230DF
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB211DDBE;
	Thu,  8 Feb 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jt8t54q4"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5741E87C
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353812; cv=none; b=mF5bTNU42VQY4IBHbjZIVRUPUNEOIKaojwJ/B9AytaqJCO1H/Bw5Ljzj2+vj2o0c5ULazche15MfHeVek3Akhzk/UQzSSFfOLdx9ETA3kRiESIBjenya69Th/bq2SI4cCVTkm7Ip9FggnTsnYZRQ2fYa6y05lCDLKY8B7nmf5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353812; c=relaxed/simple;
	bh=YSVEOwOXY3unIk2yJuWpBuglzT+OFNM05+tj5o41UKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+OQG+tVH9/e7BUMuJd9QBbeFZuSJdM/yOVQWCxm8RcHnPQb1tYwC/XiUH3KAaqRoUA8AxOVd8cFDad3Xh1Ie3MSG2LcuGKc5D1LtzvnGlq/AQhDPn0/dm9HZVtQdJEss4aVUSdikRROG7KFE3o9+cxTGvLA80Q0mSqUyh+Re50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jt8t54q4; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0dbeee01-6a41-41b9-a485-943ba371a476@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707353808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tjHW7jJFGY74RYnFCZM+qhfaS7aaaSGJcQmtqonX48=;
	b=Jt8t54q4kvRhi7sXom5RwpXT1wex2wcKx/zd751P8G3Ws0aj5XJVv+HgmckUOIScL6KZRw
	ke3NVLHnQjSrCtWS0k55/tp5a+m1++2kB76IR20FlK8S5C6xbfTAAqGwxldaLIr6miVoQU
	5tJ5wUN677TEtHTNAGxAATUX/VAckVs=
Date: Wed, 7 Feb 2024 16:56:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/3] bpf, btf: Fix error checks for
 btf_get_module_btf
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Matthieu Baerts <matttbe@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1707314646.git.tanggeliang@kylinos.cn>
 <d79e5dd6b4a189252af696a10df8ce585e9cb46d.1707314646.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <d79e5dd6b4a189252af696a10df8ce585e9cb46d.1707314646.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/7/24 6:07 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To let the modules loaded, commit 3de4d22cc9ac ("bpf, btf: Warn but
> return no error for NULL btf from __register_btf_kfunc_id_set()")
> changes the return value of __register_btf_kfunc_id_set() from -ENOENT
> to 0 when btf is NULL.
> 
> A better way to do this is to enable CONFIG_MODULE_ALLOW_BTF_MISMATCH.
> 
> An error code -ENOENT should indeed be returned when kernel module BTF
> mismatch detected except CONFIG_MODULE_ALLOW_BTF_MISMATCH is enabled in
> __register_btf_kfunc_id_set().
> 
> The same in register_btf_id_dtor_kfuncs(), give the modules a chance
> to be loaded when CONFIG_MODULE_ALLOW_BTF_MISMATCH is enabled.
> 
> Fixes: 3de4d22cc9ac ("bpf, btf: Warn but return no error for NULL btf from __register_btf_kfunc_id_set()")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   kernel/bpf/btf.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f7725cb6e564..203391e61d93 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8103,8 +8103,11 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>   			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
>   			return -ENOENT;
>   		}
> -		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> +		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) &&
> +		    !IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {

I am not sure this new test can be added here now. Otherwise, the existing 
kconfig that does not have CONFIG_MODULE_ALLOW_BTF_MISMATCH set will fail to 
load a module with btf section stripped out as described in commit 3de4d22cc9ac.

A module with stripped btf section does not mean BTF_MISMATCH also.

>   			pr_warn("missing module BTF, cannot register kfuncs\n");
> +			return -ENOENT;
> +		}
>   		return 0;
>   	}
>   	if (IS_ERR(btf))
> @@ -8219,7 +8222,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
>   			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
>   			return -ENOENT;
>   		}
> -		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
> +		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) &&
> +		    !IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
>   			pr_err("missing module BTF, cannot register dtor kfuncs\n");
>   			return -ENOENT;
>   		}


