Return-Path: <bpf+bounces-54558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AD6A6C5E1
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 23:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01AA3B64FF
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 22:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A556B2327A1;
	Fri, 21 Mar 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF1GdA0h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F601C3F0C;
	Fri, 21 Mar 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595852; cv=none; b=NlbQJJf3fXWLA1a65iSo6hSEYMHzIS7kGE/cT6VdQm5RHrORSka3WqYWG4wIJwqjX48zAoknYFzS7/LGIHTPbA6FvfTNnrQRkMhQwdR6PHlffhF8axorpnGyKGirNg288lGuCLvbtrwP7r0636GmyE3/r4QXfm1a38Z1KxMGmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595852; c=relaxed/simple;
	bh=0YkPzCxkfOAlHN0wqWyLmmk4ddNfU4ie91D9ISjUL9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFNlb6Ylxby9DNC4RmpjR8R/RMgN3p06ZM4Od/y+Jpz6T4s15608DcfGz+pFknGV1YATvYTMJ68IxqscgOP6fS901gA8etebKPzk09HYT2cj68jF69vsuiq9KQyMvewIHRCJwN4WH6D+Slcd5tXaAev+zNy7vc1aWC8l2SF6Nyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF1GdA0h; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2260c915749so35450265ad.3;
        Fri, 21 Mar 2025 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742595850; x=1743200650; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5tf2Ikh9NqR1U+q6oew+ZklnvlQHvC0og7D+/5iMioM=;
        b=dF1GdA0hrJASxP3viZhZEGLQuBUrLnu+cXR4TJ4EMzhFtKJk4FO6tdywNW7BcfIusM
         9L/Y4s0JBDJtZmmmgDDBhVBbYbZD2Yyb6gl6ZjuciAA82S8bgr/JHjUfMrijMNvQtq/K
         VGAizbagKDPEGzOAmUaXbr9UtbxyaZTez/Hxf/RQQlCYeO/Dhuu4FbRDYodlZc4sKJIO
         dmrvqIsL2zMxh7XgxW0vM4K1Q+eKw9fYrU5Te67wUGUAqYhOJvdGhCxDYjYstsZz6jiB
         EqEIa2aDjg+BLTVzVHYghuXq02UanCWFejg2+tQup6UFHpFcDW1bibKYb+tJl8uHddvC
         sKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595850; x=1743200650;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tf2Ikh9NqR1U+q6oew+ZklnvlQHvC0og7D+/5iMioM=;
        b=aT6vHUsyhyI2fwaqekYiOR9b8KsAnJHv5FGm/QFgz0Jzldqa1mv1TRc34VpRZxIy2U
         /fcXbL/39f8KTmCSA0BYWIpvMYOdRf5xqyj6kHLC2cPzct97I9gjhO3taelly9m10AyA
         wU03SQLeN6RQY/auhzNfBAVdj26Cf2V1+aS7JwBONFGBwiofXabykS//QsL1/LKZwWSW
         MwpzjCWv3O9BFQDTrodGQYzYBB5geX8NuZZ1KgOAsQW4X8mK+FQRFe7crurGa5N2B88l
         qwmBSAtkiJHwHFp+0eIj+8J66x8iKplmkVXsVdaDYhsqnpIb1QfG04BOFYkOrhv7VynH
         vwDw==
X-Forwarded-Encrypted: i=1; AJvYcCUK++8bGzYHPxS4r7d9nPTER2jN5quyBabOwNsCbjISYBa8O496ipNnSS0NOUqJ6ZByBso/gVTG6qY0xuKP@vger.kernel.org, AJvYcCVjrK6vsPWW4SImh8IzSy5lWHz5iP6uAkQMSjqpphUJrn/5GQBFy1REpR+1YQahoDZyFP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOvyZUXhK6b2FpGE6EV5PvjzLwq7SMqb30pZFVQJAAovA4UCgw
	2sbNQaVP1oy1BGOoGj6J6qPNjW2vLbL02AQmLIwQ1GJoidKdyAo44VvxVQ==
X-Gm-Gg: ASbGnctrJEFFTjSp0t2jQF59O5pWcgjaddkZSk1j62Ac2DrF2vPie/I0gZf/1bOQOha
	f84aQTEApdygLkfmkGp3rUNZQwImGqqO3h7F5fprtuvMHc10KJy5wyMSqct1Ryibyd1CuwtrLsV
	Wtky+S65HDoQV9+mTvqy6OOQ7qNtjL/65UZHFtHVAx5HiFsap2m4H+OqTjgkHvfzVHQOHaSTh0d
	aH1K0bpqS54YNjYuK0zljE15qy/QKjdfzg+oPUYsReknSxpMgrbDt6vARyolB0kOJWTGnIxYIyw
	1Evqv64E9nabarMlbbPZF3+Mz5YDeQMIvZwytx0m
X-Google-Smtp-Source: AGHT+IHB+5AwTCUriSk+8m+jnYaDcxMN0yxif6zPGeg4oT8NcJaiOvkgjZx06CxF5bpaBiF7f3SxGg==
X-Received: by 2002:a17:902:f64d:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-22780e3f214mr73252335ad.52.1742595849969;
        Fri, 21 Mar 2025 15:24:09 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da369sm22930475ad.170.2025.03.21.15.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 15:24:09 -0700 (PDT)
Message-ID: <65ff9c62d0d2c355121468b04c0701081d3275fd.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for
 load-acquire/store-release when register number is invalid
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kohei Enju <enjuk@amazon.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Peilin Ye
 <yepeilin@google.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Kuniyuki
 Iwashima	 <kuniyu@amazon.com>, kohei.enju@gmail.com
Date: Fri, 21 Mar 2025 15:24:04 -0700
In-Reply-To: <20250321110010.95217-6-enjuk@amazon.com>
References: <20250321110010.95217-4-enjuk@amazon.com>
	 <20250321110010.95217-6-enjuk@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-21 at 19:59 +0900, Kohei Enju wrote:

Hi Kohei,

Thank you for adding these tests.

[...]

> +SEC("socket")
> +__description("load-acquire with invalid register R11")
> +__failure __failure_unpriv __msg("R11 is invalid")
> +__naked void load_acquire_with_invalid_reg(void)
> +{
> +	asm volatile (
> +	".8byte %[load_acquire_insn];" // r0 =3D load_acquire((u64 *)(r11 + 0))=
;
> +	"exit;"
> +	:
> +	: __imm_insn(load_acquire_insn,
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, 11 /* invalid reg =
*/, 0))
> +	: __clobber_all);
> +}
> +
>  #else /* CAN_USE_LOAD_ACQ_STORE_REL */
> =20
>  SEC("socket")
> diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b=
/tools/testing/selftests/bpf/progs/verifier_store_release.c
> index cd6f1e5f378b..2dc1d713b4a6 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
> @@ -257,6 +257,20 @@ __naked void store_release_leak_pointer_to_map(void)
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("store-release with invalid register R11")
> +__failure __failure_unpriv __msg("R11 is invalid")
> +__naked void store_release_with_invalid_reg(void)
> +{
> +	asm volatile (
> +	".8byte %[store_release_insn];" // store_release((u64 *)(r11 + 0), r1);
> +	"exit;"
> +	:
> +	: __imm_insn(store_release_insn,
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, 11 /* invalid reg */, BPF_RE=
G_1, 0))

On my machine / config, the value of 11 was too small to trigger the
KASAN warning. Value of 12 was sufficient.
Curious if it is my config, did you see KASAN warning locally when running =
this test
before applying the fix?
Maybe set the value to 15 here and above to maximize probability of KASAN w=
arning?

> +	: __clobber_all);
> +}
> +
>  #else
> =20
>  SEC("socket")



