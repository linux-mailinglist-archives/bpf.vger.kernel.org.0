Return-Path: <bpf+bounces-26917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA518A6506
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 09:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE4F283B2B
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E701811E6;
	Tue, 16 Apr 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4I51/Cs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642326EB75;
	Tue, 16 Apr 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252213; cv=none; b=JhFjWBMiPA4k4yE6ZlDRDUUJq1+hGxtS/VhcuOA1swuRmjjFZZxclnvsrEC7+uexIW+aZ5vx/7+YlPx8a/fhi78+6k6HXiOOwHZpoiNcWf+C7ttHWxKYXOICQcJ+MxyGgKu7AR4820bYWFZ8Yna2pqdyEYjERkntjXaD6WjCe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252213; c=relaxed/simple;
	bh=9Cw6OWP2u9Aes3pseofoNzXPv/fz2bmg6PUjArK3J9Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5FZaHubs+S9GvyfRTBpO+VKhJJ5elVGI8Qsq2/aCQRpJgaW3tsX2vmHj3TAN7Wei8ZpSVQa1XxWwJotxgX8UjkdcIW0lfsELLVOMkRGDANH7sF/2KwyvWu/XHw+r/VO57eAAR33eVUjSoZE7cfC2uvlou+XkEvKK0E/wvpTT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4I51/Cs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2da888330b2so35731731fa.2;
        Tue, 16 Apr 2024 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713252209; x=1713857009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HwPoHiyB6a6BiMxMqmc7hqhHWyqah1NK8r1aIJ0ba5s=;
        b=S4I51/CsFzVhu+N+qiQyLSN01aHZba4oUcXjcLbG1+nnj6o0c2GV59fK9HmTwZ8YwF
         rJGi/m7D3BJOTKHeUyh/5PzvVZvA+LJG7hz+V90PE417Fs2VwfW87zivfEV3eFA6CbUm
         MGVlJ15H8vQhN9gPn0ryh419GXLLCn57hqBpIYexIKzkv4wDwssyTfFD6hvniGASKpB2
         /G8tf1ff/JhL6+HavCnVvX6eBMUSjNlhQS48GrRQeguLEVXJgWnIA1TlXoVsnpD/L5wq
         iaEBRXQ8/FaDrPXNBl4GPi+5FWpPn1DY+wnrh0NNPfaobcG3mL7OQS6sqL/J/3tjPJd5
         oUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713252209; x=1713857009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwPoHiyB6a6BiMxMqmc7hqhHWyqah1NK8r1aIJ0ba5s=;
        b=DsjmnOOQ1Zr6Lg4zXMXJF53RiQEKyPWbAeq5QV3CY96ZtsPpB0atxJJHw2bdJx5Je0
         n8iADHnDd6NQXcfCjfOZDsS/MvQXjvsj6v7y0s3gNt9dtgW3B/6mKsPM0nPRs5Xoeja7
         XJIQqSlbqASxicGVchJmp9Y3OHmKGaB6yTyKkc8t98JKgBr2l8tm7U8Cxc8X9ifyaQqT
         FaUbK9VGL5lQ3ofulmtqfNQuqilV1kdSLYKNRguieCPfidFSJWL6eV6l7JY1uz2gYv3e
         iCaqoN+bEHhRpo21x07DS1ywDxyiVO9Ik8q6WRSggHGawkeAaxloYgVbRy0GV7/sBtmR
         przw==
X-Forwarded-Encrypted: i=1; AJvYcCUzgU7zIt4IPsO6lsSKO/w3j24HiBnjT+qRyJnQJbVHmr+M1jvFvJPDH9ScXmg58BeYLhn/IjeON7mChFrN1ACEFg0oS10ej5oRdrGrklGs4pA3UYHjzCoEaZDCiJwWCy1/
X-Gm-Message-State: AOJu0YwS3bj2NvLCSXWHHl5lnfzcwTrRjE9n0RIj/cLcfXMD7ldoslOP
	4NqM3i2t0398Dh2QitJzmXvvbwMrAOW7kjzsjtDXyAbdg5ExaszQ
X-Google-Smtp-Source: AGHT+IH5Ye6SPlxy35avdKYsBR2Hv9ZPOjQHKm4uKt9nII/+USCnYiYvMkvevpeOqYTruYF+4XVduw==
X-Received: by 2002:a19:381c:0:b0:518:ed96:6b12 with SMTP id f28-20020a19381c000000b00518ed966b12mr3381349lfa.61.1713252209223;
        Tue, 16 Apr 2024 00:23:29 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id bf14-20020a170907098e00b00a52225b44e4sm6323741ejc.115.2024.04.16.00.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:23:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Apr 2024 09:23:26 +0200
To: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc: olsajiri@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, dxu@dxuuu.xyz,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	khazhy@chromium.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	ncopa@alpinelinux.org, ndesaulniers@google.com, sdf@google.com,
	song@kernel.org, vmalik@redhat.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2] bpf: btf: include linux/types.h for u32
Message-ID: <Zh4nbvndaho6kCRP@krava>
References: <Zh0ZhEU1xhndl2k8@krava>
 <20240416051527.3109380-1-dmitrii.bundin.a@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416051527.3109380-1-dmitrii.bundin.a@gmail.com>

On Tue, Apr 16, 2024 at 08:15:27AM +0300, Dmitrii Bundin wrote:
> Inclusion of the header linux/btf_ids.h relies on indirect inclusion of
> the header linux/types.h. Including it directly on the top level helps
> to avoid potential problems if linux/types.h hasn't been included
> before.
> 
> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> 
> Changes in v2: Add bpf-next to the subject
> 
>  include/linux/btf_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index e24aabfe8ecc..c0e3e1426a82 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -3,6 +3,8 @@
>  #ifndef _LINUX_BTF_IDS_H
>  #define _LINUX_BTF_IDS_H
>  
> +#include <linux/types.h> /* for u32 */
> +
>  struct btf_id_set {
>  	u32 cnt;
>  	u32 ids[];
> -- 
> 2.34.1
> 

