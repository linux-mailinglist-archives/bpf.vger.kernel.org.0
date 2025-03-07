Return-Path: <bpf+bounces-53538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432ADA560FC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 07:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE1B3B2ACF
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA8119E7FA;
	Fri,  7 Mar 2025 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elqfkVdR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092BE2FB2;
	Fri,  7 Mar 2025 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329402; cv=none; b=Dm5utJKZ2LSh3W8W50z8O8nZGgtHlJ6TxWPWnNWF953Y29pChzC75clwfanMaf29yjSTIk1MchSE6JxYClIo+Vtmlppsv08i+3lA+MhlWFuTBCgLKWS8xKbzOh6U3cp2Rzf8Ue22HmF0Hs4HThgfyX6E/xMa6DHrV75G64ft/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329402; c=relaxed/simple;
	bh=xUeBg7/aaB7+6NWpYZYBimJ5AYHYRrBGms2UlVJJomY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5PsbaGWoh0oLRcxUksuzhhyNDwIBVpiB/lZnWwjF/3YbZPrIWFTlZplsHXBE0Ki7lWmdOzNwqkIpb4RVq90nAVOAhR5HN5Ki3U1/fCeKP+mhHxiueaDXjMCZpwZxOe9SFnzIALlGqeSIRZliutpU9SwFAPO7Tt73p+fZEy2K8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elqfkVdR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bd87f7c2eso8224045e9.3;
        Thu, 06 Mar 2025 22:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741329399; x=1741934199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnx0PoywwI0sGB1pc9lEvtY+76lGDZnKoDgNYWRCk0I=;
        b=elqfkVdRqcpn9a9KISU6HgJwxaFMEjhGsLNMvdhwtktEQ6+vGooUvJAW9EExcVyaRi
         yGrIQiYjOh1eChpa25W+XoVG1SIlM2cTrjxypuiZh9cR+0fyyMZ9rhfenjeIOcMLCnCf
         039y4zoAPWdOIR/7Zdp/OCcVO3SGovUMC8yOtqDheXAc0dkD6VbUyu500OQOkNI6B3qP
         jN54aIyvDXECPb+8wy9lbs7NAfg+D5gP8NJUUJbgf7BnPtxcZLLCspDHnIVT9f1LSW4v
         Jql9re3VhsBhCrzT0shApg1RvKLYqKxo4FJgVlcvqP/7sSfyyfTOvMd105O9a/CAeyAg
         BhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741329399; x=1741934199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnx0PoywwI0sGB1pc9lEvtY+76lGDZnKoDgNYWRCk0I=;
        b=KqgvMh9+67p5uVUaYqipH2VPKgtVqeQHt4uA1LwRO/4F6Pa+33josVVeBqmMqSeC5X
         CvoM1QUTkGcwwx6Fbcf4gA71XX/FhDDCdVyuJ6zq+lHw6l/2x7QDnFhaVZ0RQa1fCheB
         pSrysu06MqbKqPa+l9NPWzCgfOdXXEiSFC/77ZAb8Jle0QvBQDZrsFIdR9Lw6QdBts0K
         SuLuDFwmk59wpr+4Nxc6FV6z4UmNxGEd0Blm6E0f2mLc574s/zHwEbM0lRXkFoUTHSSZ
         SWevjCwMHrYJRRMrAl77vyn/vqaeyODHZhfrbq6m3woh5UOIiv4Tdw7JfHIWCOtnbElr
         O0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUbnGi0+DGgpsHFI6Tn9aexFV8clAwGLRwRQXpsceoKb9RdCAxm+Q8irBqW7ksGRk+2UQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXmn77YykWRb9mJtgDrdpcW28cP4TLHB7+LUpkqYbzs3gCmzWU
	0q6xkL3VZR3clQPejJljTFywGQGjNeWlVjTP4pQjr+56Gqy4nbAUhG4ViXyrrO0XbSG4UGpvrqe
	sgqo7LMiZDoA38TCzR6XGqVAjlw0=
X-Gm-Gg: ASbGncuBN1v35t7dH/Qa1BELWNRox3fMmJdKR6IYiBd5jyPSY1fhL/h3B6xr47Ja3hR
	Wo7XVTj9tD4zPFw1cfmTdudZUMn7lN/yXIRAihyYlPz/zdjy7gAGUV05ciw/fdCdQ1NoIKojMVQ
	/aea3QPoyhBYmbX/g7pKBXGXoCjZyKgSUmloenaWnQ4Q==
X-Google-Smtp-Source: AGHT+IGm3T5E4n8fCXMc7JtKl8S87X2JTrJ5G0Is/HbIMrSioJOVu88Cszut6Fu5UeMw+DCDkpBPUElDIMK3kSoZxCg=
X-Received: by 2002:a05:600c:198b:b0:43b:b32e:f429 with SMTP id
 5b1f17b1804b1-43c5cf3da50mr12639915e9.27.1741329398995; Thu, 06 Mar 2025
 22:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com> <20250305-afabre-traits-010-rfc2-v1-1-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-1-d0ecfb869797@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Mar 2025 22:36:26 -0800
X-Gm-Features: AQ5f1Jop9oStoAdkedpa50kX438xjEsQIXNE15U53sBFu0IVeAXcEzvrOr6dJqA
Message-ID: <CAADnVQ+OShaA37-=B4-GWTQQ8p4yPw3TgYLPTkbHMJLYhr48kg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 01/20] trait: limited KV store for packet metadata
To: arthur@arthurfabre.com
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>, 
	jbrandeburg@cloudflare.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <thoiland@redhat.com>, 
	lbiancon@redhat.com, Arthur Fabre <afabre@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 6:33=E2=80=AFAM <arthur@arthurfabre.com> wrote:
>
> +struct __trait_hdr {
> +       /* Values are stored ordered by key, immediately after the header=
.
> +        *
> +        * The size of each value set is stored in the header as two bits=
:
> +        *  - 00: Not set.
> +        *  - 01: 2 bytes.
> +        *  - 10: 4 bytes.
> +        *  - 11: 8 bytes.

...

> +        *  - hweight(low) + hweight(high)<<1 is offset.

the comment doesn't match the code

> +        */
> +       u64 high;
> +       u64 low;

...

> +static __always_inline int __trait_total_length(struct __trait_hdr h)
> +{
> +       return (hweight64(h.low) << 1) + (hweight64(h.high) << 2)
> +               // For size 8, we only get 4+2=3D6. Add another 2 in.
> +               + (hweight64(h.high & h.low) << 1);
> +}

This is really cool idea, but 2 byte size doesn't feel that useful.
How about:
- 00: Not set.
- 01: 4 bytes.
- 10: 8 bytes.
- 11: 16 bytes.

4 byte may be useful for ipv4, 16 for ipv6, and 8 is just a good number.
And compute the same way with 3 popcount with extra +1 to shifts.

