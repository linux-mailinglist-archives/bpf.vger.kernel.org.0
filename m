Return-Path: <bpf+bounces-22397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAD685D768
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 12:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC144284065
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 11:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66246436;
	Wed, 21 Feb 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Ghy0n0Ke"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6941775
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516173; cv=none; b=e84XfWuCV6X7EJHF5QZF/TldP4rUATmCq/tfh6d9OwB/y2+9T+Q8UYIUWT+nrBssJ5ZFOEuU2vFjQVm3OUvXYK+EMmbBsx/eo+iHCM9jIYcx4PGdp3G4MRZQvzFmVuI5c/bl/ZVdXmAHMsllQVeOrB2DFyLC3awfEQIjbZB0LYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516173; c=relaxed/simple;
	bh=W3Kwcu/ujCQApPr4uF0biI0qipm51biUc1s8jJmXDbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpM3AmWCotpNoO708lj5FsqoxnuWczbYYoMaxpnDk2SJs2axCFTtps4Vt81E0+ISs5/veLZ+Hdt2EwjPScKXg2Pm/axjfoj2DDMF3EcFeibPFvwwErhfyH3YfrEIDTa9S2ze6P9ueAs4Y2tt8reUBmr02g+ZU+ksg/0MXaLbq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Ghy0n0Ke; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512bde3d197so3170676e87.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1708516170; x=1709120970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grmOaAjV+QGi68h9I/s4sgIpVFboBy0EDbJS4Le3C2Y=;
        b=Ghy0n0Ke982nEFhHfTW2tXmtbGQWgT6uH9kyCe89Iq5lg2Me13a/+YgIfd4GeNSI/Z
         pYPNNBDNeN2XjMNg609DTbDjDv9IJCYMfQg8e+WDHx+p1cNG/RFoKkMK9apu6gDgYGDL
         db91O8CDbnJGV0IgSxs2HxT81jD0ZWhT2/XcqG6yMa3qMaH74C7u1b+bzXg6HNW91DY5
         TSdNH02GcVgP6GoC9pDKMKuzMbkVn6OhkiD6+1w2E7QjibGU2/DOcUy5HKS4ohvxXLsp
         KckbqS2cptvrh6xQmDnYN90qe/60moBhBsb83OEWuo5Hsa4iQT34+K0uSdppNPl+5Jjp
         Z3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708516170; x=1709120970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grmOaAjV+QGi68h9I/s4sgIpVFboBy0EDbJS4Le3C2Y=;
        b=YDTCl11kOz0lYJ+JIIL4ENEnvfzzlMvnmSGGXJAIZFNo1nNLgQXjdsOjla691sSla5
         6rFpKiLFxqLaMop0oF6fQFpbIFt0RVbO6O0jJM3ify2Hy8HFcZIEsRW41Voeq0IfJb7g
         Sv9hiqTzj1IzPbP8cGowK2x/8BeQXN8RRzn0hS3UodxuKKfp4NY3WWh9Wv6z8pJ6bKNT
         cOjM8z22vPnTgSlkQtlIGqIDfpswlGnAgvJSxvKOqdbTCdA3nD7LDzUcQe+UtsYtSJN0
         cxn+jfkw3Vf1xeXV227XTkrzuJWauLBjupQTEwyCpmuxKbGjT1HoGfIvD+R9e3lVreD3
         UaFw==
X-Forwarded-Encrypted: i=1; AJvYcCUWJ4AkfE2AUicHvHvtgAtFCUYIOx2rAZ+zXciikZ11Qd5wY5e5KBnC7A8skBJlbLISX1IAHlOCiZJe5Y+P8fZL/c2S
X-Gm-Message-State: AOJu0Yz3qtpdmENhpFXRdMuqJeVlDHQaIatb0qkyiYEtWE8kqXIBjdbI
	dqCG+xBAYzQZydbMcK2DoUafaDAn4F+SKqq0Oj6tmoAncN7+ydujrJ8ci9zDzpM=
X-Google-Smtp-Source: AGHT+IFFEMrf1qVTNo7ZJ8ZXmDa71MY/95TwHk8/5LiUG5sUSEWTkiuvr7Th1vBN79g6w3uFqKCuiA==
X-Received: by 2002:a05:6512:78a:b0:512:d689:51cb with SMTP id x10-20020a056512078a00b00512d68951cbmr558880lfr.26.1708516170104;
        Wed, 21 Feb 2024 03:49:30 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:94d:9869:c48b:acac? ([2a02:8011:e80c:0:94d:9869:c48b:acac])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b00412590eee7csm14945004wmq.10.2024.02.21.03.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 03:49:29 -0800 (PST)
Message-ID: <fc37d1cd-6fbe-4507-b496-2a2dd622934f@isovalent.com>
Date: Wed, 21 Feb 2024 11:49:28 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/5] libbpf: expose resolve_func_ptr() through
 libbpf_internal.h.
Content-Language: en-GB
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240221012329.1387275-1-thinker.li@gmail.com>
 <20240221012329.1387275-2-thinker.li@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240221012329.1387275-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-02-21 01:23 UTC+0000 ~ thinker.li@gmail.com
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> bpftool is going to reuse this helper function to support shadow types of
> struct_ops maps.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c          | 2 +-
>  tools/lib/bpf/libbpf_internal.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 01f407591a92..ef8fd20f33ca 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2145,7 +2145,7 @@ skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
>  	return t;
>  }
>  
> -static const struct btf_type *
> +const struct btf_type *
>  resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
>  {
>  	const struct btf_type *t;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index ad936ac5e639..aec6d57fe5d1 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -234,6 +234,7 @@ struct btf_type;
>  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
>  const char *btf_kind_str(const struct btf_type *t);
>  const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
> +const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id);

If you respin, please add a comment to mention we expose it to bpftool
(see bpf_core_add_cands() in the same file), to avoid people trying to
remove it from the header file in a clean-up attempt.

Quentin

