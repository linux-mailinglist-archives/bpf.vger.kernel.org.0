Return-Path: <bpf+bounces-20065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAA0838636
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 05:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB91C256B6
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 04:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6EF1866;
	Tue, 23 Jan 2024 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bm1XLAAK"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A1E17CA;
	Tue, 23 Jan 2024 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705982441; cv=none; b=CdHuy0E9DiXVRHiIjZMCGPzWL+6KtMmB3zeapy+Ht2elP+6MMZ6Y7lDu2YO3pI5RYet6qUyFjwQGWhWS9PtO3k3NggsQ1UiUtkwe6/WT5fQEiERB28FrMosIdWNsWKxaOzMuohNBWe6pG0Vl92zBg+rI+3MAaubOXDBIE3DJbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705982441; c=relaxed/simple;
	bh=HTux5BIIrgAHQKFYDFlexQlarUVDF1tSoVhHVafuXxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMq5E8A3+ovxW6CgOpEEsi8sGMdAhvwbGIoeg7eQuSAsQMMe+0JRZI5oq0W8C5z6frH9T3frdzmeVyIMZ2xxrWnhTBui9weLGnpe2VBCus6IvsveYVLQrsCk35tHZ7lAzlOdbkSP1XW9V5u7zFeG+YnAMA68e8VEQZCGbQzZYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bm1XLAAK; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <15d65e11-d957-4b03-bec3-0dcd58b50f97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705982436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA4VNi6lPEO0ZICt6dBnkKo/XOB/bUMthg+BctCwUxc=;
	b=Bm1XLAAKMEvSvDemIU6gUhClAonnXT67w/fiNGxXIPcgbAVK3rp+5sv/Tnwlp63HOvjlEq
	9Nmkzk6IKsLu1kOf1GIKubHSZTb29PHEb7qHfssHboTr8j+yCOU0Mv31PUGbUDzHlx74PD
	boSChrGpZL96zpdtMMWcTwknaIKPGDE=
Date: Mon, 22 Jan 2024 20:00:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 43/82] bpf: Refactor intentional wrap-around test
Content-Language: en-GB
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-43-keescook@chromium.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240123002814.1396804-43-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/22/24 4:27 PM, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
> 	VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   kernel/bpf/verifier.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 65f598694d55..21e3f30c8757 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12901,8 +12901,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>   			dst_reg->smin_value = smin_ptr + smin_val;
>   			dst_reg->smax_value = smax_ptr + smax_val;
>   		}
> -		if (umin_ptr + umin_val < umin_ptr ||
> -		    umax_ptr + umax_val < umax_ptr) {
> +		if (add_would_overflow(umin_ptr, umin_val) ||
> +		    add_would_overflow(umax_ptr, umax_val)) {

Maybe you could give a reference to the definition of add_would_overflow()?
A link or a patch with add_would_overflow() defined cc'ed to bpf program.
The patch itselfs looks good to me.

>   			dst_reg->umin_value = 0;
>   			dst_reg->umax_value = U64_MAX;
>   		} else {
> @@ -13023,8 +13023,8 @@ static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
>   		dst_reg->s32_min_value += smin_val;
>   		dst_reg->s32_max_value += smax_val;
>   	}
> -	if (dst_reg->u32_min_value + umin_val < umin_val ||
> -	    dst_reg->u32_max_value + umax_val < umax_val) {
> +	if (add_would_overflow(umin_val, dst_reg->u32_min_value) ||
> +	    add_would_overflow(umax_val, dst_reg->u32_max_value)) {
>   		dst_reg->u32_min_value = 0;
>   		dst_reg->u32_max_value = U32_MAX;
>   	} else {
> @@ -13049,8 +13049,8 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
>   		dst_reg->smin_value += smin_val;
>   		dst_reg->smax_value += smax_val;
>   	}
> -	if (dst_reg->umin_value + umin_val < umin_val ||
> -	    dst_reg->umax_value + umax_val < umax_val) {
> +	if (add_would_overflow(umin_val, dst_reg->umin_value) ||
> +	    add_would_overflow(umax_val, dst_reg->umax_value)) {
>   		dst_reg->umin_value = 0;
>   		dst_reg->umax_value = U64_MAX;
>   	} else {

