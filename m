Return-Path: <bpf+bounces-50487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1208A282C8
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 04:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6F43A3191
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 03:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D29213237;
	Wed,  5 Feb 2025 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCWaQSZY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713AF25A647;
	Wed,  5 Feb 2025 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725848; cv=none; b=MmtyN/Upn/jgknhKfwl8P20/OKrGgHYdGshPA3uNfRb9OLVDhbPbptj6rEPV/ZWVLZM1uM5PwG0Ywbp8Q9gavaqVx5JUMoNgWXFt7TV4FCE4O78RH9I0nkZNrwaTaaWKDIm7fyuvBqbJYIw3KUfgMA8dPS/tNYdqBmRL7W2QSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725848; c=relaxed/simple;
	bh=WtNEHVweG1WnhXAZy2DAPYFhp8lLj6RbMngr8u1gpwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp69pEdrRI//zQ1XWUexUacE2tHy6/DcypA3DE02/C6Uos0JHExiqE0saN5dqTdlX5KcxjzPvOEUQHGnL8xBFlJG7vNUPeZ6sQLPT82Nae4pvLdZUmpkoCO8sc7FvLPfM9kPdaAp6x3bEPJTI0bKLnPBbX8hHn8nieLT4vi49mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCWaQSZY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d051dca3b6so547475ab.1;
        Tue, 04 Feb 2025 19:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738725846; x=1739330646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtNEHVweG1WnhXAZy2DAPYFhp8lLj6RbMngr8u1gpwU=;
        b=HCWaQSZYTFnvRT8YU07/f8ObyxVSX0yurBCXQKXNekCeO/NM3dkLNc/WS4GcG0idfS
         ZIFPlmV2UGrzpkH+bXfEz9x+m0a3uzfj8QkNnimxC5t7FA+pfzW0CvVkFtNOYXnlSIRy
         csqI6k0H9VwPyCCHaWYp1V/WnOCL+ot8wuyD4p9RUJE0tV6CDWiTOvMPh5kgrEtbcxdZ
         z+7WSwTa6IwXsMFNgsS3Tc69hn9+rt1HWnFRydfWhIztIiz/pxxRsvCpl+evPf6+6cru
         GRwfD5gW0CdCSOiObyC9bgI1KENaSjMJTqw2L5sUY692NAES68A5fOroZ4NmwWWUVtPV
         kqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738725846; x=1739330646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtNEHVweG1WnhXAZy2DAPYFhp8lLj6RbMngr8u1gpwU=;
        b=uNuRywVOyKV38cVlxoXCLcK5OGFJ/ijJnf1N2L503ZvDYtNOwjJLr4w5H1/Bo2zYwL
         ipULPcxW01ODYq/dw+nnALazIDH8ro4HS0J325WwcHQHr+H6BqtI8RQLeUEzLUog7+4j
         uz2P4MhW054ooSxNgtFq5MSOdGICRDvUxpTRzbKtmlS22AP+g9E1gbyAEWnL4ONgdZra
         8OqQDyXzPUc/lCt0v+Rmv7bClWXEY3g9fhLwd9WqVdfqYhDleNnsF800vJ17Frhdf87Y
         xxCoyvTr2jz3kjFljnxbz+O18VdTYx5uVTpPI54lFyANI8R+SVrYIpa+hyqiQ4puFe0G
         drIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz261JlEyWPMzY2/5A30OIsm2sLvyL4NqhgTOiEZR/XL2MP1SCxtFtRAlBEDFFl7XAzhE=@vger.kernel.org, AJvYcCXvYcaJqhQsMwMN1C5V2htDQk/pdieyu0F536gCiAPfOvEDHzaGk+M8NyaC4W6AfbqKHylCs1r/@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMDdQrtjffWr9eOHPzfOgiLh99ZlY7zUG+OJd/1LipTKwLy1d
	abWG1VK+7PT51hF1IOKHHu2IBRwXQA8L3N12TJFMizUGhxC500koEffiVA3H+6yvlAGDnXF0fBj
	Vn34KH7EKadygUuAUM9D/mjFNUAfkbdwnmFzHKg==
X-Gm-Gg: ASbGncueJabLB7wmvt7WffV6BdhkdGy2dJDt0U2/HQG/SkKnolQQCV264AX10Y3n0N9
	J2xKPtux3YXDjjAgXMKX8UiGcmrooGy3RMnId3fW3clP5HpYqzVbl6ri5CoXGO7afiqK8ONdH
X-Google-Smtp-Source: AGHT+IEvIUhzyVhaDONSSdD8f4RiFwRAa7i/GK76/IPnV5lPi5BKwJDw25TdSHN6d4kdrVYNMVwitdeuyAroit5TwaY=
X-Received: by 2002:a05:6e02:158b:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3d04f40350bmr12522915ab.1.1738725846464; Tue, 04 Feb 2025
 19:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-6-kerneljasonxing@gmail.com> <20250204174750.677e3520@kernel.org>
 <CAL+tcoDcJd9zNNnsxaCocA1W-eTj+=Ca=B-DoL5Qm6ENfSZ_Fw@mail.gmail.com> <20250204191433.4cfa990a@kernel.org>
In-Reply-To: <20250204191433.4cfa990a@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 11:23:30 +0800
X-Gm-Features: AWEUYZkdy_3nlnAZ0lc5sYktARA6Cvy6ryzsOEM9FxJcfSrvnYpOnpyvGdUlRus
Message-ID: <CAL+tcoATMrBd_b8==4fu-Nj4xB33X+F8t7RhKetAnhA_zTGJ9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 5 Feb 2025 10:40:42 +0800 Jason Xing wrote:
> > I wonder if we need a separate cleanup after this series about moving
> > this kind of functions into net/core/timestamping.c, say,
> > __skb_tstamp_tx()?
>
> IMHO no need to go too far, just move the one function as part of this
> series. The only motivation is to avoid adding includes to
> linux/skbuff.h since skbuff.h is included in something like 8k objects.

Thanks for clarifying. Will do it in the re-spin.

Thanks,
Jason

