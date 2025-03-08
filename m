Return-Path: <bpf+bounces-53635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C1A5785E
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 05:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40D53B602C
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 04:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D87017A31C;
	Sat,  8 Mar 2025 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qGrXwgnn"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21D182CD
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741409612; cv=none; b=s+RxxBZ92n6wCTf95NOmAJV4VN7jjFbcwT+fP8yeUgvFKJJdvxl/EmkYKNGSjK7Gs57czQtNWxPYb+FBfxma1AJ2IgMrnkgr1HrhIDkH57COjSku8Rllwfshk1HK2tit6Ja2w49a0/sSf7pFjdVYSgDZ7KOqcm3x4j+4MQrgjcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741409612; c=relaxed/simple;
	bh=38q6r1hShXW6cfWqvUvK5iyEFWqJAt3hZmXdzkUSLAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvL2nTxj6pxMsKKKvIS9uOM9NYKzz5q7O2LFACNuqDO2s97GRVoz+XohrESdG0KyfZfTK/zd3aL6o1+ejs5v7UpAk/akVFuz0di0EqmXKX9qa5ahC9ryZD02uyIVAynqIWu57VsMgI6kplvkH5t3mZOnfsoW5XLpn4+0NULzsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qGrXwgnn; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f709292b-c17f-47c3-8fce-4f1b63893746@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741409606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nOXBdjdqPqE12RJtMgBWZ3jBrJI+AcTTNCjYW2gwPU=;
	b=qGrXwgnnlX+tUkAxtu96VJu9K9XlRYfioCXPkHsk99W5gFIyLPOt0PLgIcQFNUi6EJriCg
	fbRyBISCyqO/2zzvFRUh0Nv2pDqRb3w1N7iex9bdC6x4+fCsjnQ9N48VqsnZnmW5lWLdEj
	k0CI/ppuxSaoA/ERsOVvetigB/RmwQc=
Date: Fri, 7 Mar 2025 20:53:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/4] bpf: BPF token support for
 BPF_BTF_GET_FD_BY_ID
Content-Language: en-GB
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
 <20250307212934.181996-2-mykyta.yatsenko5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250307212934.181996-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/7/25 1:29 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
> allow running it from user namespace. This creates a problem when
> freplace program running from user namespace needs to query target
> program BTF.
> This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and adds
> support for BPF token that can be passed in attributes to syscall.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>   include/uapi/linux/bpf.h                      |  1 +
>   kernel/bpf/syscall.c                          | 20 +++++++++++++++++--
>   tools/include/uapi/linux/bpf.h                |  1 +
>   .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
>   4 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bb37897c0393..73c23daacabf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1652,6 +1652,7 @@ union bpf_attr {
>   		};
>   		__u32		next_id;
>   		__u32		open_flags;
> +		__s32		token_fd;
>   	};
>   
>   	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 57a438706215..188f7296cf9f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5137,15 +5137,31 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
>   	return btf_new_fd(attr, uattr, uattr_size);
>   }
>   
> -#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
> +#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
>   
>   static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
>   {
> +	struct bpf_token *token = NULL;
> +
>   	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
>   		return -EINVAL;
>   
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (attr->open_flags & BPF_F_TOKEN_FD) {
> +		token = bpf_token_get_from_fd(attr->token_fd);
> +		if (IS_ERR(token))
> +			return PTR_ERR(token);
> +		if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID)) {
> +			bpf_token_put(token);
> +			token = NULL;
> +		}
> +	}
> +
> +	if (!bpf_token_capable(token, CAP_SYS_ADMIN)) {

If bpf_token_allow_cmd() failed, token is reset to NULL and used in
the above bpf_token_capable(). I think this is not correct, if token
is available from bpf_token_get_from_fd(), here we should use that
token to represent the proper userns encoded in that token.

Something like below?

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c51193ced383..5bb10b531174 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5121,20 +5121,20 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
                 token = bpf_token_get_from_fd(attr->btf_token_fd);
                 if (IS_ERR(token))
                         return PTR_ERR(token);
-               if (!bpf_token_allow_cmd(token, BPF_BTF_LOAD)) {
-                       bpf_token_put(token);
-                       token = NULL;
-               }
+               if (!bpf_token_allow_cmd(token, BPF_BTF_LOAD))
+                       goto out;
         }
  
-       if (!bpf_token_capable(token, CAP_BPF)) {
-               bpf_token_put(token);
-               return -EPERM;
-       }
+       if (!bpf_token_capable(token, CAP_BPF))
+               goto out;
  
         bpf_token_put(token);
  
         return btf_new_fd(attr, uattr, uattr_size);
+
+out:
+       bpf_token_put(token);
+       return -EPERM;
  }

> +		bpf_token_put(token);
>   		return -EPERM;
> +	}
> +
> +	bpf_token_put(token);
>   
>   	return btf_get_fd_by_id(attr->btf_id);
>   }
[...]

