Return-Path: <bpf+bounces-60143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C81AD34A9
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3383A9AD5
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D228DF51;
	Tue, 10 Jun 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMyjGVvw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5828DF36
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553933; cv=none; b=au25ogGx1gZZTsFZa1SHongwUY1RPwpziCNdoGKhhkaUpoPk221bUke5j/GvTZ4vkF3q0QiLYbwFwv9GcpcLQ3mPpm5WosyLWhC2dZ8HZ/Sbr9VRQE/xQXFv3LD4CNVm/uhvXz9PN4Ya4Gr1cL+fxXkUyU4XjyYWpKFz9UjAVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553933; c=relaxed/simple;
	bh=8Ot61PXl5kGzjjeEPSDiyR6snSZqeBq24oaab28mpFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rohLV6NI7qAdbrQPNbfx8uZQ+eL2I0MBkNLFPiQHvu0ddcEqCpP4UtA/1NFybbQ3z9vdcNrzGVQiaxyG9ZW3ZdbJxzj4gp9+ynCwS0ofBthaM+utqQHKMCpjVJr2fN1G9rjl+S5kiP2afozq9MuCvGHW2d/5bUOXJoUJ5FGb/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vMyjGVvw; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e23e9aeefso38715667b3.2
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749553930; x=1750158730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAasWsF+eqCK/f8XAQ+UlekFNlTdm6esn8JjFvKIvek=;
        b=vMyjGVvwBEzqh17Qp5EZTGx6bH2Txuqs90sQMuM2Wilh1nsEDscklsVuVMwIGlM/oM
         zdNkwXMoDW1oY2BWguA10kAfpc7pX0fxv9cB1zGjb5dImYi+n3Q8+5IuOWBD6Vek2wTP
         cxhdSbsClMybDELMkMTLMhH0ugPGCEQZbTiSiDWR3I5EnF8NWuFu/TR539c5r4L5vjZf
         6ccC1nER+Q8KF7N1IejidmLZl9/c6AR22Mu6VMg/g8JRneqU5Y62QwWyuvNs2Lm8w3xb
         519IfL0KWHigCWqF4NjmL7jvRRNn3G109c9VmtGVA/0N69nK5fuDB2bAGus5kNR5JFrZ
         y3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749553930; x=1750158730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAasWsF+eqCK/f8XAQ+UlekFNlTdm6esn8JjFvKIvek=;
        b=qjExL2zjuvfHra7W+2a96Jyas6WCDHhk0YVWFXg6FUVaOY4bcPCApD8AfFnFyq2aQq
         1IX2GF1HocIlGAgtIz3dZuw/oJSXdGaghS+TJ0a/QJDZ6LR+QXJhspiy7hOjP47IsAz7
         oucAaCzYVocMW9uNjqMNoW1PDpDAmjnc+16tWJTRzzekUGt4iboCwSdNpJ2ICoLXLZXA
         ElKS0nUGOOTYiXr+cPvaysS75/fRVsSQ0Dnnoaq8ced0fRU0gy8cILhxPJ3mcUjsofTA
         XQCf2QA3sjmDrDlf3hJPTsrOzvqfwqy3zIPE+pAgUXexeZwyZImKAnr3t8eqe3pzzKET
         b4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVZY0bDBiRFCpl2laIPQD09wJf3WpX3fR0boa78dfFGOcLnmFY7+6vGJKDS4zlUlvyLX0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KEUyOP5N/eJc/3/oSzQIWeXGyIlGMhq0A4Cimxup0zGzNPTC
	PkGVIpt/X2NETxA3KUVVmUhm7IWjS8O1sAkLwOQCM73uuQEP8dHQzElfSR1DwppDnMvdVzdSZOM
	zDz7xS3eTM2T8k6Gx8MG5okqc+X0gL7k3N4FDrYIJTA==
X-Gm-Gg: ASbGncvtVv4hHyBcw2/kJDkHskQYq/I/tchlQmzozws0DdsenNv8X29txd5ks3BwROD
	N4/68Pl+UCvmkM2PNEkg54MUnHVD7ySmXxGpUKjsnEpCEqJxpvdIaTcO/TwRvSm7hn3/VccGcnw
	Z+pxNfbs0oS1L5KzzXeHR04UOp7ko1K/4UwWNqj0KpH7pi
X-Google-Smtp-Source: AGHT+IEus4fAgfpA04VnzbpCBIk4pcLfZh1F4oLtFfc4L//yX8/NM2y06/TIMi8ieJhHRR9+7Ovs9MDTFh1COb9mV8I=
X-Received: by 2002:a05:690c:700e:b0:702:52fb:4649 with SMTP id
 00721157ae682-710f770f580mr243841697b3.27.1749553930576; Tue, 10 Jun 2025
 04:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-7-byungchul@sk.com>
In-Reply-To: <20250609043225.77229-7-byungchul@sk.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 14:11:34 +0300
X-Gm-Features: AX0GCFuhc6OdkS5KHRqDnMJaP6aChThQllVzaiTd7yB-canYZ7c373Kcyan1HIw
Message-ID: <CAC_iWjLbwkXTKfu27umzu4PmmxHAi7TN76t_VNHiS8WxCM0UQA@mail.gmail.com>
Subject: Re: [PATCH net-next 6/9] netmem: remove __netmem_get_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jun 2025 at 07:32, Byungchul Park <byungchul@sk.com> wrote:
>
> There are no users of __netmem_get_pp().  Remove it.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  include/net/netmem.h | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 65bb87835664..d4066fcb1fee 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -234,22 +234,6 @@ static inline struct net_iov *__netmem_clear_lsb(net=
mem_ref netmem)
>         return (struct net_iov *)((__force unsigned long)netmem & ~NET_IO=
V);
>  }
>
> -/**
> - * __netmem_get_pp - unsafely get pointer to the &page_pool backing @net=
mem
> - * @netmem: netmem reference to get the pointer from
> - *
> - * Unsafe version of netmem_get_pp(). When @netmem is always page-backed=
,
> - * e.g. when it's a header buffer, performs faster and generates smaller
> - * object code (avoids clearing the LSB). When @netmem points to IOV,
> - * provokes invalid memory access.
> - *
> - * Return: pointer to the &page_pool (garbage if @netmem is not page-bac=
ked).
> - */
> -static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> -{
> -       return __netmem_to_page(netmem)->pp;
> -}
> -
>  static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
>  {
>         return __netmem_clear_lsb(netmem)->pp;
> --
> 2.17.1
>

