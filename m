Return-Path: <bpf+bounces-36898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E5C94F228
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0094FB23F6B
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41147186E58;
	Mon, 12 Aug 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFJ5Ny0u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B618562A
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478124; cv=none; b=tDCzmEsm+g50W3dV2a1hhc8x395jDN4kGOeYcI9GRPH+oS9UP3O/NMOf1qJMKiAMWvjApHpdUA1tVzAlyIbjFw8z7KsNmYaXzZZx6mB/7/wg/i8ybA+sAHlu1LiTMb1g6Y2wwGkRz6OIOrlqwWrG/jfiQ9heb+2hfJ4yULvQWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478124; c=relaxed/simple;
	bh=5mcILmHI5M7nKS+D+bN8jT2tH/4l9JfUS7gPWmLqzmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ro4PWvtp9Orl2KKlaItR0NMgWoDtltZutf1ucxvpCGFglMi8q7NBja65H0joqyG809UEabvdl53UgPremvPgiTG17W00zlEMMWSgvgb43LLj1xjXRyB3u3hkWWDFl+pMYhSKhuDBZMnaL/5Eh+sYq14lCBIPnwNotr0TK1NEb5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFJ5Ny0u; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7107b16be12so3714278b3a.3
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723478122; x=1724082922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wd4PsIn22RSfoNZNVdfqnDHDuuFItSvVVrDBg720kjY=;
        b=DFJ5Ny0uoywyrdU+LuqvYCOUO3VSzkFNGXXeld60jviHd1oc90AjyNpT6CNdwwDIOQ
         eUQEgMKcYHXugxu6YYo1Y/dbtlbmh9ld0LDZ79OCSOB+J88keKQ7M4bPaHuubVWxyNz2
         f3QGZwhzHIEsVYVwG9Ov4qGnHwZoCnROgMQljGnUONUqChoUdEQ0jkqWqrZ1CZ/Yt90o
         nCNGWbxYE5PqEvYiIjEyGDuNqfoSB/udajHeE/yWQ4D7WpIPQjZpAXWLfRVhJhq7cPRS
         ZFGTStychZuipu5FQdbDINg8966IKrv1ZBlwz0hV6m+f5wIPIlWqX0nWY8iHaCt8++no
         icUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723478122; x=1724082922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd4PsIn22RSfoNZNVdfqnDHDuuFItSvVVrDBg720kjY=;
        b=nV9nvHQ0Wc27xtGqcpRQgN1ahj82yxQAIGA6J6WktoTSVOLJ87TRzAqMFa74oSOfcJ
         Gl6qJJyj0Le5MfhqjplFw6bEuucMoPo2CHveXcPtwtzDdKwpBxQOTE2/DqaHv1tBI3Xc
         RLf0eBysQkLsckh+PjYt+jZdtqJVckxkXt9TQWxjCFNBw/dARciZWSN/kmj7TkQr+aXG
         Se1Gs+/EBSfqIz7brt4dpX+Iw+9/V1jbEsEcup9wP4d/MXUREzJ6vXc4eCU8/JucWil4
         DAhpa7I017TNjK3AWRGngXS5Y0UoU4Uh+jWM47m7F2OL/k2tEraTXPgF40DksH2uXifY
         Od5w==
X-Forwarded-Encrypted: i=1; AJvYcCWXJvtQlW/zM98cNQwS8K/d9BGLtljOMW+XD+YYQecA2ub2jfi9051gZzClTa+XTOor7IPtYIsiusD6vGV4cMiv8MsA
X-Gm-Message-State: AOJu0Yx/c1a6DgpVga9iLTdm3dBZNPTEcoA8vUxHmMUA6PuiXjtvHUi5
	gWEh8VGggvRCeZwUjcqysMBI0fXIfiRXdseNRB77K87rqU6oISUm
X-Google-Smtp-Source: AGHT+IFVjcbSvXKwg/6Gs7PljOnedvNCplTTzU8kN4TCURLn+ROR79YU5CZLVMNZTvKC+eFlXc3Wpg==
X-Received: by 2002:a05:6a20:4e17:b0:1c8:d8ed:4d54 with SMTP id adf61e73a8af0-1c8d8ed4d5cmr569450637.3.1723478122462;
        Mon, 12 Aug 2024 08:55:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd? ([2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fb69esm39597145ad.71.2024.08.12.08.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 08:55:22 -0700 (PDT)
Message-ID: <0be2afc8-1845-4c0b-b61b-d523e017d237@gmail.com>
Date: Mon, 12 Aug 2024 08:55:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20240811235439.1862495-1-linux@jordanrome.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240811235439.1862495-1-linux@jordanrome.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/24 16:54, Jordan Rome wrote:
> This adds a kfunc wrapper around strncpy_from_user,
> which can be called from sleepable BPF programs.
> 
> This matches the non-sleepable 'bpf_probe_read_user_str'
> helper.
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>   kernel/bpf/helpers.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..5eeb7c2ca622 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2939,6 +2939,37 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
>   	bpf_mem_free(&bpf_global_ma, kit->bits);
>   }
> 
> +/**
> + * bpf_copy_from_user_str() - Copy a string from an unsafe user address
> + * @dst:             Destination address, in kernel space.  This buffer must be at
> + *                   least @dst__szk bytes long.
> + * @dst__szk:        Maximum number of bytes to copy, including the trailing NUL.
> + * @unsafe_ptr__ign: Source address, in user space.
> + *
> + * Copies a NUL-terminated string from userspace to BPF space. If user string is
> + * too long this will still ensure zero termination in the dst buffer unless
> + * buffer size is 0.
> + */
> +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const void __user *unsafe_ptr__ign)
> +{
> +	int ret;
> +
> +	if (unlikely(!dst__szk))
> +		return 0;
> +
> +	ret = strncpy_from_user(dst, unsafe_ptr__ign, dst__szk);
> +	if (unlikely(ret < 0)) {
> +		memset(dst, 0, dst__szk);
> +	} else if (ret >= dst__szk) {
> +		ret = dst__szk;
> +		((char *)dst)[ret - 1] = '\0';
> +	} else if (ret > 0) {
> +		ret++;

I prefer to keep consistent with strncpy_from_user().
Considering ret >= dst__szk, it is not actually copying dst__szk bytes.
The last byte is generated by this function, not copying from
the source buffer.

Copying at most dst__szk - 1 bytes is more concise.
The code could be simpler with this concept.

   ret = strncpy_from_user(dst, unsafe_ptr__ign, dst_szk - 1);
   ((char *)dst)[max(ret, 0)] = 0;

WDYT?

> +	}
> +
> +	return ret;
> +}
> +
>   __bpf_kfunc_end_defs();
> 
>   BTF_KFUNCS_START(generic_btf_ids)
> @@ -3024,6 +3055,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
>   BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>   BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>   BTF_KFUNCS_END(common_btf_ids)
> 
>   static const struct btf_kfunc_id_set common_kfunc_set = {
> --
> 2.44.1
> 

