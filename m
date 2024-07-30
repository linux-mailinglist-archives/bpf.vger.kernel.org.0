Return-Path: <bpf+bounces-36059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775A9941129
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 13:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A31B28A07
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987918FC82;
	Tue, 30 Jul 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDXlJQbZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C5166316
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340254; cv=none; b=pWw5LnErc8Z88rpAL5Bz9f2OxMfFDxqZ7Ex0t63ZA4GxWW1oReEsXAw9cuBq6mDuDLQkqR/F0Iw+VypsCemu71GBjXeNKR73NX13Gzk6G32h2ONBIz6ImGZNdW7kMK8yuIXEFO3ITJ8qtW6bHUiaLg05E6+u3G29VtWR9OiUWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340254; c=relaxed/simple;
	bh=/Gur3ofaBDV/CQBYfPljGCUWCgNZq+TErEX6GZE/i04=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xih+jO/2gXMXKpxLYUbDd1mxzcnEWeNUyxDJWR4nNiXrD/QQ266GTSAyaN3aUP4MIr5pGyYR8SwYZDY16GzwOZSJv9k/wIH1TLSCwdKFXJE2vtjgSVmr6qQTfZ2mvIw0kG5Cv66U0f9a5wDB+c7qaj3mPznU/F/JsqDImjMGguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDXlJQbZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so16233525e9.0
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722340250; x=1722945050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/T48/fichyDTbOCumPADzryXKhO1LLQwnEtgQ2EPaaA=;
        b=ZDXlJQbZjilahi5xGK7eKhH/0fXCfWwUTDpWiSZZiTQQU8c5BbPLGGfXv51uiUftqt
         unMz+lVP5inWavNDyQO0g40Kn+RHeE4Wk6ZEbJf18eHDTq0FeyY6NcAFSMixJl1a/FX/
         M78tmhrxT0D283rFv2ddaET/Lo1d0CkBOvldkxFv7ZL7T0jSF0wQYltSGXte2B+fnxSf
         iuIS2AfoWu53fNV1o3gwGTyMGvFfDAT5/lldlV+KSHnHxbm6Ddhz9Oy8NXaqoH2AH6Dz
         gtgSOIdb8cHBbz3ANns+o2pXnyVbFqQ2wKokjrdF1kGtlfwJ/ZFi+Cd/naC21f+0Amqo
         q5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722340250; x=1722945050;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T48/fichyDTbOCumPADzryXKhO1LLQwnEtgQ2EPaaA=;
        b=Rf9mrPNQbLD/Ugt5uqKUq6DnRZ/oFQ+nu9p6QytAjFYuaVXYit+DUMdkpfAe9zgWvC
         8Ia2GeUEzSNjFDE32C5qRe7clvDDFxwjG1obdp8RZxHXCZLzb1x8jfVnCPgIUMR4Rdcb
         lLmAnuJ+Fl7zM8QozV2ptz1RCme0yXzT3bAhkmXBP7cHVnD4XgkNYJKravx4DHDQ808q
         EPpFcb1FnhBesgSYw6Gj+syKsWffDcsxl/Gj21+R0X+GLjiv5DNP/q2gKf9CYd4SqCtu
         Hr+yp/t8Y9zkTgzvMQrxEri7mVqtXuMHK18F0eiuDFR8xHa40jytZMJAPkYtq8t0D8pi
         cjLA==
X-Forwarded-Encrypted: i=1; AJvYcCUkmHnIYy6QvYKj6sW/9+Y0A/r3noDQ3yhgeBbhCqO3dQsoIxd/KDCxJHzvUTgeZQKzaAGVHacJfHzIQZz2s7lI0n/j
X-Gm-Message-State: AOJu0Ywo4xqvktPVg05Qa3K4tHCzCvF5wZaWAynyq3EabpAxaZHbJJLi
	4gEQINOIiuWP08f/HDILGqpIyvjneZM7rGQ6JiFZd3QCBasnq0mL
X-Google-Smtp-Source: AGHT+IFUraZa+rGLwO1dY8KOrau+eiIRKtZ+2dXCo4DRo62WivkFpMIMzxZG/7u+CYTa58OQ3bjGaA==
X-Received: by 2002:a5d:4e87:0:b0:368:3b89:df1d with SMTP id ffacd0b85a97d-36b8c8fdbe7mr1309933f8f.22.1722340250190;
        Tue, 30 Jul 2024 04:50:50 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0344sm14635731f8f.2.2024.07.30.04.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:50:49 -0700 (PDT)
Subject: Re: [RFC bpf-next v1] bpf, verifier: improve signed ranges inference
 for BPF_AND
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Xu Kuohai
 <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>,
 Matan Shachnai <m.shachnai@rutgers.edu>
References: <20240719081702.137173-1-shung-hsi.yu@suse.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <9505522b-de45-cf52-162b-76a3a52a6efe@gmail.com>
Date: Tue, 30 Jul 2024 12:50:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240719081702.137173-1-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 19/07/2024 09:17, Shung-Hsi Yu wrote:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8da132a1ef28..f6827f9e2076 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13466,6 +13466,40 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
>  	}
>  }
>  
> +/* Clears all trailing bits after the most significant unset bit.
> + *
> + * Used for estimating the minimum possible value after BPF_AND. This
> + * effectively rounds a negative value down to a negative power-of-2 value
> + * (except for -1, which just return -1) and returning 0 for non-negative
> + * values. E.g. negative32_bit_floor(0xff0ff0ff) == 0xff000000.
> + */
> +static inline s32 negative32_bit_floor(s32 v)
> +{
> +	u8 bits = fls(~v); /* find most-significant unset bit */
> +	u32 delta;
> +
> +	/* special case, needed because 1UL << 32 is undefined */
> +	if (bits > 31)
> +		return 0;

If I'm understanding correctly: this case happens when the input
 is nonnegative: v >= 0 means ~v's msb is set, so fls(~v) = 32.
Might be worth calling that out in the comment.

> +
> +	delta = (1UL << bits) - 1;
> +	return ~delta;
> +}
> +
> +/* Same as negative32_bit_floor() above, but for 64-bit signed value */
> +static inline s64 negative_bit_floor(s64 v)
> +{
> +	u8 bits = fls64(~v); /* find most-significant unset bit */
> +	u64 delta;
> +
> +	/* special case, needed because 1ULL << 64 is undefined */
> +	if (bits > 63)
> +		return 0;
> +
> +	delta = (1ULL << bits) - 1;
> +	return ~delta;
> +}
> +
>  static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>  				 struct bpf_reg_state *src_reg)
>  {
> @@ -13485,16 +13519,10 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>  	dst_reg->u32_min_value = var32_off.value;
>  	dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
>  
> -	/* Safe to set s32 bounds by casting u32 result into s32 when u32
> -	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
> -	 */
> -	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
> -		dst_reg->s32_min_value = dst_reg->u32_min_value;
> -		dst_reg->s32_max_value = dst_reg->u32_max_value;
> -	} else {
> -		dst_reg->s32_min_value = S32_MIN;
> -		dst_reg->s32_max_value = S32_MAX;
> -	}
> +	/* Handle the [-1, 0] & -CONSTANT case that's difficult for tnum */
> +	dst_reg->s32_min_value = negative32_bit_floor(min(dst_reg->s32_min_value,
> +							  src_reg->s32_min_value));
> +	dst_reg->s32_max_value = max(dst_reg->s32_max_value, src_reg->s32_max_value);

Either comment or commit message could maybe point out that the
 work the deleted code was doing (propagating u32 bounds into
 s32) is done by the caller later via __reg_deduce_bounds().

It's a bit of a shame that we can't get the sharp bound
 [-13, 0] in your example, for which we technically have the
 information we need — src_reg being constant means its tnum
 carries information that negative_bit_floor(smin_value) is
 throwing away — but I don't see an efficient way to handle
 the case (it happens basically because only one operand
 crosses the sign boundary, so the other operand's tnum is
 informative) without going down the range-splitting road you
 (I think rightly) discarded as unnecessarily complex.

Apart from that this all LGTM, so:
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

