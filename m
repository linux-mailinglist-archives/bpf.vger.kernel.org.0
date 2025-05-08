Return-Path: <bpf+bounces-57748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC3AAF74E
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD9F4E2001
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1846C1C84CD;
	Thu,  8 May 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tH7SxnWE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD02CA9
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698474; cv=none; b=ZXfJBCOJ4QNtlumCX2Xy+0ldZAiTlIk3DM97Z0oVXzMe6GpMCpXPbdHBILqGDYN0RhR+Z2RU9ryNAfqO2aLkg0AwZJqOrxZfZrFWgOa+RNVu8pBPQbYfIa1Ke2N7zL63tneeDuYwPm3+enikHVjUTiOM3qjT+azVmLnt8gDkDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698474; c=relaxed/simple;
	bh=yCmPbavZasXyZK2LzAOfmhkicxEWdieO3xsj3pII0v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXNCZq04mSvmn18CXYXHRsrB2mB5EP4BZV47xphn0ClBT3wsjrULEamI3a48j+2SD9Xo3l+lETbRpq1G14yxRu4kNCjEV4I25MGgM0xLdZDU+HmbhiuMJR25sk/YWnruijmns7pMDtu9QwJ1DeD7OLEjlZ/wI5qKkaIrAU86xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tH7SxnWE; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3104ddb8051so7951681fa.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746698471; x=1747303271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKuIs4bD7hmTmBBuWS0gS4IWCByDc925DpPRPOTwVhk=;
        b=tH7SxnWEsKdFK19bIvq/rjG38oXvNuzxNwTsFAK7G1nCCoLp8SZgqLUIr1KM4U9WSj
         Wh/vxAPbfAw5in9PVHx5KFZgacVwKyFTlOR/vPHrVXSqKx7e/pSWmLd555vxTHMBps/N
         IcAzZlFc1geRLCi82WACPXiW+awlqpJIIxZrpsNtQvTRp5kx5SDz3VCF5yzL7qWMzr40
         tJvevSnTlz6f3ebmCE8HUbP9Rv/LTFKExdoSAPHRSCb8pMdGBmUhbhdY0RvEdUHxebh6
         NyHmEg6Bt24tzv4u3PGps25sc7rjig+6SXD/DZouK7qPXIXnmNhWBJWhAo7YjSthWw2D
         62LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746698471; x=1747303271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKuIs4bD7hmTmBBuWS0gS4IWCByDc925DpPRPOTwVhk=;
        b=Lic+MeMhsPTKcP1hFpX8w7+6vQBlI1Mh3GnEF14A7JKLQ84kb9QI9uAnHRq1cBByH7
         a1oRAULY/V3SXj1HOa5IK6uddeblg3grlqSwbvQYXI1eFvx/zInxfTRNA4KJKVrN4hF3
         eTZeGL918524Ora4lcW4awpH2n0EO62DDNMZDqbptQjpu7V/JrAbfJ8A57bTBSvRJV/Y
         aca0FarLqRO6APVLJZRObmtY+oj3O4zj2LBG6rIiKoSRXs+ee9v4V0Wiji/j/HGBMUzQ
         M2o/n0xZguC2OD1KabsDtjnljR7qnjpCHyYqLQ9E14/h5uG2j58XKV4oZs9GL4DmPUKR
         gMnw==
X-Gm-Message-State: AOJu0YwgzuUkJjUFQ3U0bB7UaOeoo1LvbZxt0l5QeLLnj6wGwbsNb/+M
	hocuTxPkuOfPWTHhcnJECJLIm3zusOW8DhV8U3MzFbP48bi7DQgCVzA8ezTs3PvDqNLOVi0CjC0
	Y0CYb
X-Gm-Gg: ASbGncsHLw/8e0PhhR1clvCZfKI49VJdeJXdv2IkscXghGQikKUor78ikZ2HELJLKGF
	FSGMLkTDLLxUAhk8W8xmr3pTcO0bjjiD0OqhqgYmgv5WZ+81W4DDfLkp8CZ72gBdKXKF/lCVVgx
	Y2hngh8ershtQeRuS9a8Ur7k2sEbT4NZIL44KqHfV9QIcMiVI2+TB4bh6Ev1HyvTqYZzkp84Vad
	/uKe7sQwFZzzIrtfquqis6BjdfuqchyCaDuS6/03fCBZe2IOmbm9cNKmX5JkUJnHoVpGCrTDg4M
	fyqPYc44wHRd6yLQgUv/GqRzuBSnY32pUoT25xZFA3EyIGZ3lHQJMElGgWcqH5EaDcQWZSTgxj0
	V03GEPjE=
X-Google-Smtp-Source: AGHT+IE/s7lPN5vUCzksRaYR2B7bj4kJTFfHdhYwtVVBT+3QBxGeiK2BZt3LablW7b/dF67NnuKtHg==
X-Received: by 2002:a17:907:7249:b0:ad1:fd0f:a0b5 with SMTP id a640c23a62f3a-ad1fe6fd715mr244883266b.30.1746698459943;
        Thu, 08 May 2025 03:00:59 -0700 (PDT)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895095d7sm1054555166b.151.2025.05.08.03.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 03:00:59 -0700 (PDT)
Date: Thu, 8 May 2025 10:00:55 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/4] uaccess: Define pagefault lock guard
Message-ID: <aByA1wael6H4tMo8@google.com>
References: <cover.1746598898.git.vmalik@redhat.com>
 <39416cac1d011661601caffc6ac38195c82ede86.1746598898.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39416cac1d011661601caffc6ac38195c82ede86.1746598898.git.vmalik@redhat.com>

On Wed, May 07, 2025 at 08:40:37AM +0200, Viktor Malik wrote:
> Define a pagefault lock guard which allows to simplify functions that
> need to disable page faults.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  include/linux/uaccess.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 7c06f4795670..1beb5b395d81 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -296,6 +296,8 @@ static inline bool pagefault_disabled(void)
>   */
>  #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
>  
> +DEFINE_LOCK_GUARD_0(pagefault, pagefault_disable(), pagefault_enable())

I can't help but mention that naming this scope-based cleanup helper
`pagefault` just seems overly ambiguous. That's just me though...

