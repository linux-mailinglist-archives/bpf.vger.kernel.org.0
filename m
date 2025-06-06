Return-Path: <bpf+bounces-59868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981E6AD044F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F8817ABC9
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412C1C831A;
	Fri,  6 Jun 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hMtKoXXh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68314AD2B
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749221831; cv=none; b=RDvRDoAxhvZNQuIPg6/S8SKC6LbPOshwpP61O1q5HsE+mD/MJKElwVBWTVymC4crfZ+i1h31JpQVwZz+d18HTtBYxlMye2upBZS7WfuXHtnR/y2yHtbuSWoqhKB8LhofUohOSFzYHLZnAecYEUVQXNIAT/Qbo21bxLgUmFL4Ouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749221831; c=relaxed/simple;
	bh=5rLk0Y1o9Yqu936oDGAf+guTBOuXSZ/KP5hY7VpGzCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8x7Z87GkYHCV+5JEhopNr1r4wsUX/IbY0TXBx8Y8B6QlsX+FaIaxI6ItcIFqG9GuMg7XWi2UXnoIm2zLhMSwJ6pPhtcEpHeMUq3I66A0CemrD81GSpTOgnIX+gox87XRRNFCynVDxzzvJnNXlHyeCtsiA8RUay4+M+2zLOG4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hMtKoXXh; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86d01686196so65659539f.1
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749221828; x=1749826628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4SilW7Kz/GqOrsdyu9o99hQfeO+kZMJ6kTTI3SZL88=;
        b=hMtKoXXh8+5SC4d//xyI/YsWQof1pTyJgp8PvZMRjJEr+ZXGQDP6PiKucpYcvXxhgt
         R/v1olg0Jg27bs2vAvbXLvE45rYoG68EZ58vWZtBT+YKvSE/Y61EG6Jgsuv5c7j7Q4CT
         N/ZaM/yXxUEhAabGOWU23a3e2mAqusOZvhacUnQPB8HTsuTR9UlfgAN8gIV3ssAnmWfq
         YqQLiPlal2Hv22VEolt+uyoxborkDCIxNRXuov18yx2KNRy3TAqCcSFxGpvuQVV8gXia
         HlbkOMQthwezDppKAreITxg5uCk6PNvrqFLM4Aw9kHo6ObeJR3xcgVGqd6O2DVHzEjiY
         Txdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749221828; x=1749826628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4SilW7Kz/GqOrsdyu9o99hQfeO+kZMJ6kTTI3SZL88=;
        b=A+0yHRKm40sUcZ4IxLLw23tXuEtF0nhR168v/WpgNCLHxZOkqYjEaMTvLttjhBPNPB
         PQj7NWscoXhdPZqtOXtOA100GGRyqrwBA4obJ2AcMXw9KXLKgFMjiSvRAOl2IjBLQIRs
         n4kjcVLqqbapAQU9RLfSTYuM3J/ObBGRjKFe96aqACKT/1GETTTIFiwk0UQu0uvK/gRR
         Yd7JB0EMfm3QJcvO3tE37/UpkM+58bBiFt2y8mWKfSHQEeX86c5ECmrerdID55w6sahQ
         3OaWpiOuysTkvl4WbzWg53IXQj07lJT9ZQfnYFR+wv7Oq3ATRoBVHXZiRa2DoPf1K0cS
         G9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0or2j+oj/ObVr1gKi/0r8/Ot/X7MebF4tGNzoFs1Zp0lBBTCKsor67QAA9RM0ugBuM0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI53E9O/GLdVxBW5k7NbiI8dv03VvBKfL9eMsIrn0v2tWhBdGX
	YokWvokB1JOUq4PgoCN3C9uxu5kAwxWRa0dVDE1YIp1/4kgxuW//FRxbYYSX94/THdE=
X-Gm-Gg: ASbGncuRu28SOu+PF5pFG7Ajs6Yu2rSjFl8dCuxsXxnjL/jy0U3BcLDnLZZKpejVW4q
	3alGAHbn+eB0rZ/nSfi91UVeS9onfjjPmN5hmfIjs2/n/4bPFQRBBpcxq/eHe+CfZgfkHu3/dni
	tib93P9c+p6oyA13eF2p7EEavsPN1Xw/k/+HktAwRn8bD9BV/6F4Zt+tpk1G20WL4RnVARhDrhT
	SkspjzmLAPf3PFFzAA594zpucBwiZg+RiqFKj3o4ISdAIK7iwwVgYxKFErkDutM46iYJHvBtva9
	4oSkJ4flVH82kvfZjybMqVXTVvbWTy5hMYOC2tPPMj2SCre3XObvppnK3A==
X-Google-Smtp-Source: AGHT+IHCqdvcPc2EHD8OF2SGiY28FRz5VxV/iMut9sL/Iq4G5xTeNxhhacKuQVTKYCyvf5H+SS82Sg==
X-Received: by 2002:a05:6602:4c03:b0:86c:fa3a:fe97 with SMTP id ca18e2360f4ac-873366c4eb2mr364557439f.10.1749221827729;
        Fri, 06 Jun 2025 07:57:07 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87338782c7dsm37099439f.2.2025.06.06.07.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 07:57:07 -0700 (PDT)
Message-ID: <9b9199f0-347b-42fb-984a-761f0e738837@kernel.dk>
Date: Fri, 6 Jun 2025 08:57:06 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/5] io_uring/bpf: implement struct_ops registration
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1749214572.git.asml.silence@gmail.com>
 <f43e5d4e5e1797312ef3ee7986f4447bddac1d3c.1749214572.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f43e5d4e5e1797312ef3ee7986f4447bddac1d3c.1749214572.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 7:58 AM, Pavel Begunkov wrote:
> Add ring_fd to the struct_ops and implement [un]registration.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  io_uring/bpf.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  io_uring/bpf.h |  3 +++
>  2 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/io_uring/bpf.c b/io_uring/bpf.c
> index 3096c54e4fb3..0f82acf09959 100644
> --- a/io_uring/bpf.c
> +++ b/io_uring/bpf.c
> @@ -3,6 +3,8 @@
>  #include "bpf.h"
>  #include "register.h"
>  
> +DEFINE_MUTEX(io_bpf_ctrl_mutex);
> +
>  static struct io_uring_ops io_bpf_ops_stubs = {
>  };
>  
> @@ -50,20 +52,83 @@ static int bpf_io_init_member(const struct btf_type *t,
>  			       const struct btf_member *member,
>  			       void *kdata, const void *udata)
>  {
> +	u32 moff = __btf_member_bit_offset(t, member) / 8;
> +	const struct io_uring_ops *uops = udata;
> +	struct io_uring_ops *ops = kdata;
> +
> +	switch (moff) {
> +	case offsetof(struct io_uring_ops, ring_fd):
> +		ops->ring_fd = uops->ring_fd;
> +		return 1;
> +	}
> +	return 0;

Possible to pass in here whether the ring fd is registered or not? Such
that it can be used in bpf_io_reg() as well.

> +static int io_register_bpf_ops(struct io_ring_ctx *ctx, struct io_uring_ops *ops)
> +{
> +	if (ctx->bpf_ops)
> +		return -EBUSY;
> +	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
> +		return -EOPNOTSUPP;
> +
> +	percpu_ref_get(&ctx->refs);
> +	ops->ctx = ctx;
> +	ctx->bpf_ops = ops;
>  	return 0;
>  }

Haven't looked too deeply yet, but what's the dependency with
DEFER_TASKRUN?

-- 
Jens Axboe

