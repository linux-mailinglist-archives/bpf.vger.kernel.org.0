Return-Path: <bpf+bounces-23252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E986F186
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4FBB23501
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266A29416;
	Sat,  2 Mar 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bQSv1WjY"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5829420
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398760; cv=none; b=NEtzI8YA8FHB7+CwfuOcEkH4l5HThZ5j4jf4t+8W++xfL/OIoIxVdsdtkA50QZjp0sCAQuvS/ZauTtecwGhubEC68WHKtLwAZnSDctMWR6j/0LTlYHvvMxc1Q0ZYsfqax2QTt6d052UhmwBFJvFqTTw4r1Y7x5UXiseKqgLEKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398760; c=relaxed/simple;
	bh=SlI2ClZ+5LPqvIHlireEvXOD30hAh27j5dJEujG6hUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSAmtbC8gxGVyqSQ7/LepoGBXvH62/iY6qyQ1bvnnL3ueDsRVXrCJ9oE2YJjjs4Z+fmgtRsPqPjWRR24aiqykF4/VJfK3U4YXIP3CWMgbbESqUnBixSIkYpddQb2ugYAeKh2tT8wy6WWoBZZ7OX8Wxs/lcKXuia2PQS4L8rMwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bQSv1WjY; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5fa03ec8-9862-4c9d-8dac-02b8cacb82b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709398754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkSfUhG/grqYOmm1TAx/V5sIiLQYtY7QQhS29PWMvbE=;
	b=bQSv1WjYJmbeESjjSdkT9gBOeuKGFbchXqUWaxzqfONVvRzJo8lpB3CbDFWZm5LbHxkNdi
	b1ZC+gKA5WpqTdupdYjHV54soW3jAP73V1//WSi9lXIQXZXK5WZSEuq9oWGO26XyDkJSMW
	Oi9iwH/N0WQ+09zlb+xMhn3+xJx8GC0=
Date: Sat, 2 Mar 2024 08:59:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: Remove unneeded conversion to bool
Content-Language: en-GB
To: Thorsten Blum <thorsten.blum@toblux.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240302005453.305015-2-thorsten.blum@toblux.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240302005453.305015-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/1/24 4:54 PM, Thorsten Blum wrote:
> Fixes Coccinelle/coccicheck warning reported by boolconv.cocci.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

See
   https://lore.kernel.org/bpf/229F1668-2FE9-4B09-8314-DFB13B3D0A12@fb.com/

This has been discussed multiple times and recommendation is to keep it as is.

> ---
>   tools/lib/bpf/libbpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index afd09571c482..2dda7a6c6f85 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1801,7 +1801,7 @@ static int set_kcfg_value_tri(struct extern_desc *ext, void *ext_val,
>   				ext->name, value);
>   			return -EINVAL;
>   		}
> -		*(bool *)ext_val = value == 'y' ? true : false;
> +		*(bool *)ext_val = value == 'y';
>   		break;
>   	case KCFG_TRISTATE:
>   		if (value == 'y')

