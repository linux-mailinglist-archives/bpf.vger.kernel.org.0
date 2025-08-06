Return-Path: <bpf+bounces-65134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DC1B1C8A7
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 17:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7240B5647DF
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3F291882;
	Wed,  6 Aug 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FwfM+kmF"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE528FFDA
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493929; cv=none; b=nHVEmCWrMerU8RqopIaZlXXDGJ8hG7BLS0UUIDyzvLCS/yKURhWwUhPxhGhDOBEXULq+1Vwc1hq2NsZDZhVovx0MXQvDMskWJn10Eij2DGu7T5j1aOchSN4Z66yAHHZXZzjYYZ4ZOPvWX5Oz6TYcktzDqUQFOfXTj6qBTBe24zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493929; c=relaxed/simple;
	bh=ULcIH6BVggBswLQbNkZJSrb/oMgsGp5NCCrIzHSDbOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCG26Xm0Wf5ml5crzfymL5E/o1ZizSa33rWCsec7EuKyx990P9F6jaRDtAawlf9wiqgTjpoCPj5XyCjLzmWmGQoKgP3a+w/N9lQ91BrT+5z/uNvvGouMiZm1D0gLCmvnLE6H3fs4cmF0Xycj0Zo7SgNo4TNtuOmpBNOdFuhbfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FwfM+kmF; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6cf6faf-f6bf-41f6-b2fd-2694bc62753e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754493915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q5/YSD3ttDTfg15v6aPsPKmNRREHnIKb5KKPhEjA5M=;
	b=FwfM+kmFqPhFxjT2oEfZtDKcoTmexlOlozpqKwp+AepwL+qgle74fQYK8CdA5OXa0L/x6u
	H9BTZFkTtHDQJEFdXfDpnEyk786eSmY81nkgWbSb6h6iYCG6MuEFdKYKlCnxoPWKHXYdRt
	JW/xQk5eQHvgPRSTtxkadtcAiQsEmc0=
Date: Wed, 6 Aug 2025 08:25:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] libbpf: Add the ability to suppress perf event
 enablement
Content-Language: en-GB
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 Thomas Richter <tmricht@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20250806114227.14617-1-iii@linux.ibm.com>
 <20250806114227.14617-2-iii@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250806114227.14617-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 4:40 AM, Ilya Leoshkevich wrote:
> Automatically enabling a perf event after attaching a BPF prog to it is
> not always desirable.
>
> Add a new no_ioctl_enable field to struct bpf_perf_event_opts. While

no_ioctl_enable =>  dont_enable

> introducing ioctl_enable instead would be nicer in that it would avoid
> a double negation in the implementation, it would make
> DECLARE_LIBBPF_OPTS() less efficient.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/lib/bpf/libbpf.c | 13 ++++++++-----
>   tools/lib/bpf/libbpf.h |  4 +++-
>   2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fb4d92c5c339..8f5a81b672e1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10965,11 +10965,14 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
>   		}
>   		link->link.fd = pfd;
>   	}
> -	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
> -		err = -errno;
> -		pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
> -			prog->name, pfd, errstr(err));
> -		goto err_out;
> +
> +	if (!OPTS_GET(opts, dont_enable, false)) {
> +		if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
> +			err = -errno;
> +			pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
> +				prog->name, pfd, errstr(err));
> +			goto err_out;
> +		}
>   	}
>   
>   	return &link->link;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d1cf813a057b..455a957cb702 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -499,9 +499,11 @@ struct bpf_perf_event_opts {
>   	__u64 bpf_cookie;
>   	/* don't use BPF link when attach BPF program */
>   	bool force_ioctl_attach;
> +	/* don't automatically enable the event */
> +	bool dont_enable;
>   	size_t :0;
>   };
> -#define bpf_perf_event_opts__last_field force_ioctl_attach
> +#define bpf_perf_event_opts__last_field dont_enable
>   
>   LIBBPF_API struct bpf_link *
>   bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);


