Return-Path: <bpf+bounces-52645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E485A462FB
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E56175EA2
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50622154D;
	Wed, 26 Feb 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIsFvBTX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6919CD0B
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580479; cv=none; b=fbf9FCUOZCFkOzztoPu+Vr8CdLqNrqWqRD9W70H6BGmqyJoC42f4Rtxs4eaX1pSHKOlKwm0StobW8d9KJXU7mspcMrs5jFpkgIbMjTrkgihJHcFxsIMoohEu5sqAtrOwNAD1DCJlnjdI8wGUS/PXCj6Zh8jkyDVxjstGik3DmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580479; c=relaxed/simple;
	bh=YyCpz0uWpWPAf6onuGLVPfQZfeGkMfnDiPwuUr11n0c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khrdkgZNxqJ0trMWFn+wzSChiXe82YdPeebYnZYUR6sybcxxA7pEAIh47gMY5DuHwdFW488Po3AbGyP700MFvq+lYXgzERhIae31E8DGT7szY2OFCBojSWsWFYj/4anHNJEZaOVMCEXRzmN2GQnL7CyExkL/wqKKJFS7BuWUOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIsFvBTX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43984e9cc90so6107595e9.1
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 06:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740580476; x=1741185276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTFsnq3jGegPMwm5aWBoacY8oO6p3gbzwVyRnL+0QlM=;
        b=KIsFvBTXD0Y/vcshaapmfVVpO+YPNpqAKyLgi4eiEfEeULnchyIuMsjESAiSXK/Suc
         c7kADQ0FnJm9mLg9KUsCVZF3dcSvjWTrQAgGZBci8rXMThdlg6MZaRD+PbV9WgPTHplV
         o5DJXccy+9c9377tQ2y+kDb25MMmxNt+4uNaC+Mhrnqn+K4Y/0hrlLZay9z8+HGkLrlv
         1N0+tvz8qcDMBw5oLwerxNBjvWyTOyDGdwIqdYTUws+TiMMP1YN157fAY1/ehCJlY3Uh
         HWKKq8x805UU0qmtCt1besVYxD+W5/Yies2AMRYuY6bP4Ysj0LOcKBw/KeyxL9QMtmRA
         yD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580476; x=1741185276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTFsnq3jGegPMwm5aWBoacY8oO6p3gbzwVyRnL+0QlM=;
        b=ZW4U/WfbEajSA95qZcWggEgVfSz+JB1/sfEo1dClwu6dgDsLfSPrwUD0P6odjwfBN/
         Q9JVXrr3GGYArJ4rQwcVPo8amBFeRi/cy7z41C11IAMgbDE7FpnwIjwMQk83BaN9IM9Q
         /SEJ9n/j/tuQUlEi5ksng8RRn6EDw3ByZg81qqa37V7O3/6/L5rnLIPSLsUIFkwxqJvv
         6EXzZY0GcOm/KE+kKSZ/+BLKDLXfHTQ6NJQ0+JXYffJjlD01WSq0KxHWmDw1473m7Fbp
         0QcT6/9aJTRuEGIuHR8RdSJldbVqaXU9p5KbO9iDMdU6yHBvXCEWKkSxkaJyF4zbm9HW
         tAJA==
X-Gm-Message-State: AOJu0YxWzAV0GrJtcR6Yi8jOu6ugBkC0jGA0Eji6CN7Q5wp9XPksXV8j
	KDPJIWC+qhtTHiu7+zt+HFvKHWhl5xehsTC1YK1VGBCTMa7dBBSH
X-Gm-Gg: ASbGncveF6Pf/v8+1R088uy5sr+j2zQKAfpaZ+SQ/yD9mH09UEv0FRmC9yGuHaIovZD
	gLhsKs/ZlVZiPMTLYDZhC9dQFCH3/5/B9sSVh3fr2BzpeWfuLdjjT1U1CxHTghbFICx+5ITEVOA
	Db3Xl0UxBmIINHmlVo9Ywc1S845rvcnwfY4xzVovuZlIEbWPJ3YMh/hqzEDyNchx3jn/G4n/otK
	+r76qHVmBbzzNXbon0xwK1NJs7YE14tje9BFyONCTAbf2tb1oDCuBRX6T+jO4suPGPH8Zpd4KnZ
	wcTWXTq/nu2hFw0DCsc=
X-Google-Smtp-Source: AGHT+IH1/YjPh35ptdLRsmajFrnPpd0/LHOcS8gxg/uK3vuD7Nn9/oquYwI5G2DXUQEaXf4p9ajjrw==
X-Received: by 2002:a05:600c:c8b:b0:439:7ef0:a112 with SMTP id 5b1f17b1804b1-439a30d4ef3mr211851015e9.10.1740580475596;
        Wed, 26 Feb 2025 06:34:35 -0800 (PST)
Received: from krava ([2a00:102a:5013:7b7d:132e:7dd4:845b:548e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5871f4sm24251155e9.39.2025.02.26.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:34:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Feb 2025 15:34:32 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: implement bpf_usdt_arg_size BPF
 function
Message-ID: <Z78meJOKZ1AGsnwl@krava>
References: <20250224235756.2612606-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224235756.2612606-1-ihor.solodrai@linux.dev>

On Mon, Feb 24, 2025 at 03:57:55PM -0800, Ihor Solodrai wrote:
> Information about USDT argument size is implicitly stored in
> __bpf_usdt_arg_spec, but currently it's not accessbile to BPF programs
> that use USDT.
> 
> Implement bpf_sdt_arg_size() that returns the size of an USDT argument
> in bytes.
> 
> v1->v2:
>   * do not add __bpf_usdt_arg_spec() helper

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> v1: https://lore.kernel.org/bpf/20250220215904.3362709-1-ihor.solodrai@linux.dev/
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/lib/bpf/usdt.bpf.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index b811f754939f..2a7865c8e3fe 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -108,6 +108,38 @@ int bpf_usdt_arg_cnt(struct pt_regs *ctx)
>  	return spec->arg_cnt;
>  }
>  
> +/* Returns the size in bytes of the #*arg_num* (zero-indexed) USDT argument.
> + * Returns negative error if argument is not found or arg_num is invalid.
> + */
> +static __always_inline
> +int bpf_usdt_arg_size(struct pt_regs *ctx, __u64 arg_num)
> +{
> +	struct __bpf_usdt_arg_spec *arg_spec;
> +	struct __bpf_usdt_spec *spec;
> +	int spec_id;
> +
> +	spec_id = __bpf_usdt_spec_id(ctx);
> +	if (spec_id < 0)
> +		return -ESRCH;
> +
> +	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> +	if (!spec)
> +		return -ESRCH;
> +
> +	if (arg_num >= BPF_USDT_MAX_ARG_CNT)
> +		return -ENOENT;
> +	barrier_var(arg_num);
> +	if (arg_num >= spec->arg_cnt)
> +		return -ENOENT;
> +
> +	arg_spec = &spec->args[arg_num];
> +
> +	/* arg_spec->arg_bitshift = 64 - arg_sz * 8
> +	 * so: arg_sz = (64 - arg_spec->arg_bitshift) / 8
> +	 */
> +	return (unsigned int)(64 - arg_spec->arg_bitshift) / 8;
> +}
> +
>  /* Fetch USDT argument #*arg_num* (zero-indexed) and put its value into *res.
>   * Returns 0 on success; negative error, otherwise.
>   * On error *res is guaranteed to be set to zero.
> -- 
> 2.48.1
> 
> 

