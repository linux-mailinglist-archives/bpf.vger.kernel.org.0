Return-Path: <bpf+bounces-39524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477E79742BB
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6006A1C2619F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11F1A7055;
	Tue, 10 Sep 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loyvOcxe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D11A4F11;
	Tue, 10 Sep 2024 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994324; cv=none; b=J45vJZ6ztjmM2Pzm8RxvLp520dC30m/v1zJQzRGBe4fETtdSUwuM0GmPmSgioK5TFQKQMp3eV9zw2bBL42XzAcvCBLSoKGPTXu+kCk5KjD1mgCNjKve9bW2kbJTEpfBZWuOLYN9hfZAJwRmv5dDyus7S+KJ7dNzYZJtn8ptxxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994324; c=relaxed/simple;
	bh=O6D95LB3RVB/aMbNQnyXI2zLpqGsUYkaY59bRHiWSIc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAGdkIHmLZoFDrQmkhhKmZFkxKJkZfW8aQbWJmYuMP9QD8GzUGYL6n3z9R+PnvWEY5Z5jTjfPw97Z9XCCS2bLHljQRXjnBkOkJD1t0ovqmAOq/tPFQouJXxkbNPwdCzStv+3bJEA/AnJGi7bUBOevidZ87KJFqrXBpH57TIp+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loyvOcxe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so11368325e9.0;
        Tue, 10 Sep 2024 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725994321; x=1726599121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=db2Jvj2YpxsiieK/030/+nusw2uTTxGxsMk+B07gfPg=;
        b=loyvOcxekylbrdfrT7espau2PIlqim1eUeiDjIsF6Sw+CU39la5ck85qN+gUtyvT+Y
         OklteIgwwdrnWxbJPzEduEEA7Ni6SzvRI51ppUBvhR1TuLV8ixwlJfSvtlAuE92lpUIk
         lpvlEycNLpj2KdyH5VtaI/GjK4IJz6rID20+REwj68rwkzJhkIdAPPf8HWSGNl9k2d67
         opM0lJdi6P642paIqLgGOzwvby93ZQL6igMdOc/wDY4pehMsO5T/uRjku6pP3FhPgUFf
         f6eJxPAczRyYLh54Z01SGwAJK9RTaWyOOL90Lzz3rZ3AhqnwKhJsOSbBJUZZ2OEUZaIi
         AcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994321; x=1726599121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db2Jvj2YpxsiieK/030/+nusw2uTTxGxsMk+B07gfPg=;
        b=LvDEQWqt+uSNPwYpvxr6lRM+4R3JAGAfMQ8fa90YhwE0LE2MOAIJFcNOOXAkPJTRdp
         IFgL5I7ha8JPIo4FyMu9tKlJSj9+KirWSqhgPwATdlmq80WrcY58brysBGAlUOPs/zMR
         kYRu+Odv/FSuOnMfwGHFe+gCGE6cZVxNZADk1jQQWRxiNdKTIV5OLMRbRbWnJfaERH7n
         YNX3NMflIcMky9VLkWn/f4EvwuhO6jRpKix8GafaXGA8VK/v27clHdAhQ4I6fZqrEACP
         ++XqddOw/jllXllbtKK0Yc3+k3Kxucub+pqGAk8PuuTHawlTb7sLF8R/vbRHUqtGCyl+
         uFSA==
X-Forwarded-Encrypted: i=1; AJvYcCVkCvNiz5cv1mCVIovMyA2iz8Z9rx+8gwMd8fDIRDV0SCnPl/d894qPaEIXrheUwZ6zp3nckt5IN1B/p+ODxzze@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2r1hrqFy1issfP2KxgkMHS1gaxAwRaPBcfxS7OY7GyKSiVm2
	NRD9HV1FiYPiUDH5eOX6YI6tenEtvttylF+1riG65fNkJ3ca7u2Jt3fksC18
X-Google-Smtp-Source: AGHT+IHHUZYY7zCm6GMKW1WHxZLJQwJgUkIjC2XLDYZunzoUddLHpeLKvHZ6Km814qx2LAh7cs1awQ==
X-Received: by 2002:a05:600c:1987:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-42ccd35b222mr4959005e9.25.1725994321160;
        Tue, 10 Sep 2024 11:52:01 -0700 (PDT)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc137556esm27141515e9.1.2024.09.10.11.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 11:52:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Sep 2024 20:51:59 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, akpm@linux-foundation.org,
	linux-perf-users@vger.kernel.org, song@kernel.org
Subject: Re: [PATCH bpf-next] MAINTAINERS: record lib/buildid.c as owned by
 BPF subsystem
Message-ID: <ZuCVT8EzqZxOxZFx@krava>
References: <20240909190426.2229940-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909190426.2229940-1-andrii@kernel.org>

On Mon, Sep 09, 2024 at 12:04:26PM -0700, Andrii Nakryiko wrote:
> Build ID fetching code originated from ([0]), and is still both owned
> and heavily relied upon by BPF subsystem.
> 
> Fix the original omission in [0] to record this fact in MAINTAINERS.
> 
>   [0] bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f328373463b0..a86834bb4c25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4098,6 +4098,7 @@ F:	include/uapi/linux/btf*
>  F:	include/uapi/linux/filter.h
>  F:	kernel/bpf/
>  F:	kernel/trace/bpf_trace.c
> +F:	lib/buildid.c
>  F:	lib/test_bpf.c
>  F:	net/bpf/
>  F:	net/core/filter.c
> @@ -4218,6 +4219,7 @@ L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	kernel/bpf/stackmap.c
>  F:	kernel/trace/bpf_trace.c
> +F:	lib/buildid.c
>  
>  BROADCOM ASP 2.0 ETHERNET DRIVER
>  M:	Justin Chen <justin.chen@broadcom.com>
> -- 
> 2.43.5
> 

