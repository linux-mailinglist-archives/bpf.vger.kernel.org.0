Return-Path: <bpf+bounces-53638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B17A57867
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 06:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57987A519E
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 05:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C391E1779B8;
	Sat,  8 Mar 2025 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rcY61l+S"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6CE28F3
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741410151; cv=none; b=a71/1WP8rIocNAynhQUSQMoWLIvwraPH1lxMEGCvH9JYQ2UFdiOHW5mYdlVxQqWUKQEr+2Je7889mI92vskt8Xw9rLhTzXTGm8rK6W28W0R/8rzuwz6gD4OvfDPuKkKxz+9sd4cjtyrAog8qr4yZYaB2TSGL1afkltUzl5puac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741410151; c=relaxed/simple;
	bh=yyZW0NwIljvuIgRfavDnd21we2kqZHHlYTdTIstDi+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZewM6CmlZWcj4v77pQgfN8Ioq1t10MMdto2B59wbckEPbEdtpi7SMInwdZX0BnLq0aa82YMcn2LQzLHkzRFoqsg2JQZ6pzCNvn/p8K8JYLynpw5NbSnP+wxP6IPmU5OTx59Qz7irvh/i5VlX9bHgyBupBDtQ1EHIs98IcJ1Mmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rcY61l+S; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <473d1583-4663-44da-93f9-82fa331ca16f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741410147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i48TSRwJV2W6xhZxzIHhY5kAPNLE9cnnZMuazjARevA=;
	b=rcY61l+S29yiP66y19fsPg4Q0FxnIShrMfLZFr9aHhaGKX8xzU38vPLrSRiBsAnB1UGJ/L
	7612e0Bvi/o8EXQJZTzmf82TbldyqIH/U9W2AmBLtbHDXK3GXCBAvmiRumV5ckeZinm6R9
	of6JdoqaOXlrBQjub4cW7Cc9Y+jESPQ=
Date: Fri, 7 Mar 2025 21:02:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: pass BPF token from
 find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
Content-Language: en-GB
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
 <20250307212934.181996-4-mykyta.yatsenko5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250307212934.181996-4-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/7/25 1:29 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Pass BPF token from bpf_program__set_attach_target to
> BPF_BTF_GET_FD_BY_ID bpf command.
> When freplace program attaches to target program, it needs to look up
> for BTF of the target, this may require BPF token, if, for example,
> running from user namespace.

LGTM with small nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>   tools/lib/bpf/bpf.c             |  3 ++-
>   tools/lib/bpf/bpf.h             |  4 +++-
>   tools/lib/bpf/btf.c             | 14 ++++++++++++--
>   tools/lib/bpf/libbpf.c          | 10 +++++-----
>   tools/lib/bpf/libbpf_internal.h |  1 +
>   5 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 359f73ead613..783274172e56 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1097,7 +1097,7 @@ int bpf_map_get_fd_by_id(__u32 id)
>   int bpf_btf_get_fd_by_id_opts(__u32 id,
>   			      const struct bpf_get_fd_by_id_opts *opts)
>   {
> -	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
> +	const size_t attr_sz = offsetofend(union bpf_attr, token_fd);
>   	union bpf_attr attr;
>   	int fd;
>   
> @@ -1107,6 +1107,7 @@ int bpf_btf_get_fd_by_id_opts(__u32 id,
>   	memset(&attr, 0, attr_sz);
>   	attr.btf_id = id;
>   	attr.open_flags = OPTS_GET(opts, open_flags, 0);
> +	attr.token_fd = OPTS_GET(opts, token_fd, 0);
>   
>   	fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
>   	return libbpf_err_errno(fd);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 435da95d2058..544215d7137c 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -487,9 +487,11 @@ LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
>   struct bpf_get_fd_by_id_opts {
>   	size_t sz; /* size of this struct for forward/backward compatibility */
>   	__u32 open_flags; /* permissions requested for the operation on fd */
> +	__u32 token_fd;
>   	size_t :0;
>   };
> -#define bpf_get_fd_by_id_opts__last_field open_flags
> +
> +#define bpf_get_fd_by_id_opts__last_field token_fd
>   
>   LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
>   LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index eea99c766a20..466336f16134 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1619,12 +1619,17 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
>   	return btf;
>   }
>   
> -struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
> +struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd)
>   {
>   	struct btf *btf;
>   	int btf_fd;
> +	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
> +
> +	opts.token_fd = token_fd;
> +	if (token_fd)
> +		opts.open_flags |= BPF_F_TOKEN_FD;

To 'move opts.token_fd = token_fd' under if condition? Something like

	if (token_fd) {
		opts.open_flags |= BPF_F_TOKEN_FD;
		opts.token_fd = token_fd;
	}
?

>   
> -	btf_fd = bpf_btf_get_fd_by_id(id);
> +	btf_fd = bpf_btf_get_fd_by_id_opts(id, &opts);
>   	if (btf_fd < 0)
>   		return libbpf_err_ptr(-errno);
>   
>
[...]

