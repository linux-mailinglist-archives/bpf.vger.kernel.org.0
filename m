Return-Path: <bpf+bounces-67198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BBEB409BB
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 17:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835011B63274
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE132A3D1;
	Tue,  2 Sep 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Qq+etEVM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F32D47FD
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828335; cv=none; b=VKS6pmMJm9sf8+mRrl136GXoie1bxwNWrxy8P4LD9EwzSNCs9EhL9OOkQZ6s4maBqC7O8/75deemcOWLqXpngA1Mg9FLJzxcjGLDtpoTV5pQvdCkkyvSP14SKjqmSbybywoDeO3tg14AkALF+TZiYA6/uqSyDWUYhw+9IqzczVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828335; c=relaxed/simple;
	bh=stLhhV7bm1vUFI/iU1WBQlYtrw7OG6XE8jShsR81V70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJ4vq9r7IMQQAbatHsZUowjsafb/3g6gQ7gPfhX/sCd/SG21kUIUq13/xWY9f8FVRRTT/NaBWHGlQ/MIi8pw3fOWGOiHVwrUSLr+8WqvT44bJQ0te/4kaU0H0mYUnohVg9RJm81QlQUXaAkpEe4w5H7U7pz4AKIPT6/Nu50upM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Qq+etEVM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333f92a69d4so42610861fa.2
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756828332; x=1757433132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stLhhV7bm1vUFI/iU1WBQlYtrw7OG6XE8jShsR81V70=;
        b=Qq+etEVMTaV7CZJy7fbVjo+Myg6LqBVoCHuuF77GYt9ClZywNx/aUME0GgLd8w5dha
         WLLGLNEzAyVQ/KF5pK90CRxR4fTHDQi0nRTNbkxcgrq/1y4xKSex43PcaZkA5VtaS8TJ
         aQeWwu0wgTvY/uvT8GfAvDg/8qd7zu9cF8dbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828332; x=1757433132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stLhhV7bm1vUFI/iU1WBQlYtrw7OG6XE8jShsR81V70=;
        b=u9r6gs703ZJSV7GtPFdsZxtgb9BStLA/bjxrBvpXwJhZBaMQTs5i9byX73hBMcxepB
         uPYXREUYOegYgVegfHxhbcTE0jJIbTKy8d8GB8F/u7YdfAGG8YrzbtLlMPbWHkVDW11y
         oM4GlNtkjwLzJ52ResKkSCpzxMQTv29EFl5Um29D+Eac0TH9Og9t+qCLOEs6av7rQD3m
         ekJFsKPqMMu8Hxcl1ErOtVXfis9IueTAW26+6xUP2IhNhuE85RUvZ0MFEdwCGZn17tTC
         X87CE3cdRLvzKzpOSC/lJW0MDV41gV/ta8m9bgC7VVyAgdVL0KLyq/VCsrHWu146ijQm
         SPOw==
X-Forwarded-Encrypted: i=1; AJvYcCUjsBvozAY4Y6d6FuKtMUSYYPOwbG4mQus0r8lSMAanjl+OwIv9cZQqI3BolLKT9+gm4Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Tw19J2uElbUMhzpuYbaKfYH7HLH7IGT/X4zc//5vU8gGOrmp
	Ii/y5MTsKVTruDQk4qghDMmwHG/kMhJGGeQAOSJMQwTGp/Qk7s6QGjiauL1cnW3zuTCtSxCBDma
	djKwrM6G/nPP5dbdaDVgcjtv/6nbQadO7rVZGBR0Sutnm+0v7Yng4I6XbHA==
X-Gm-Gg: ASbGncvxg6B23c4nyvdUTadfuPJ5gNDZCoavqgm+auA1rGAZUce+N3IWPu2F7Vwa7N7
	/3lgimmD4jAvwtmItK2Y/+1HVYmUxPO8ZyRjmEhzM0BXPf1iNlAkC7s74Y0LChbfUd3Sshi25ZC
	SbEY33uT0ZusKUyg3FrSmCpt9X3MbrgQ2D1qesUUklhpbOAYhUIRXbL19hg9+uj4ATFGjKTnAVe
	/8aum18ikpbivbn/aI56egcxQ+XnGIc82d4YZ2pVv01QNnqlDxsuoZcTdLAVlut
X-Google-Smtp-Source: AGHT+IFLBXCpi7DHnKmwPh1wQEtdxsg94/MOK5AfXLAdui68Z928N/2/I1UOJHxa5Rdvs1rNz3Fh7wKz3/vUOpXEgLw=
X-Received: by 2002:a05:651c:4183:b0:335:2d39:efe8 with SMTP id
 38308e7fff4ca-336cb148b70mr30923391fa.44.1756828332127; Tue, 02 Sep 2025
 08:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <aLIs_-lDKHCLTrTy@x130> <e0786dbc-4681-4bee-a54a-e58c1b9b7557@gmail.com>
In-Reply-To: <e0786dbc-4681-4bee-a54a-e58c1b9b7557@gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 2 Sep 2025 08:51:59 -0700
X-Gm-Features: Ac12FXzhLOJq0ytlrXGx13ITo2PO1Hdam1DCDF49TdzDn0Pda0hF-4fNTx9ov7Y
Message-ID: <CADg4-L8+c+kHHzJhEaxKoNowbONqfMPVuqyOw7_DqhKFqzzLFw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Tariq,

On Sun, Aug 31, 2025 at 2:28=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmail.c=
om> wrote:
>
>
>
> On 30/08/2025 1:43, Saeed Mahameed wrote:
> > On 28 Aug 20:36, Christoph Paasch via B4 Relay wrote:
> >> When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
> >> copies parts of the payload to the linear part of the skb.
> >>
> >> This triggers suboptimal processing in GRO, causing slow throughput,..=
.
> >>
> >> This patch series addresses this by using eth_get_headlen to compute t=
he
> >> size of the protocol headers and only copy those bits. This results in
> >> a significant throughput improvement (detailled results in the specifi=
c
> >> patch).
> >>
> >> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> >
> > LGTM, I would love to take this to net-next-mlx5 and submit it back to
> > netdev after regression testing if that's ok? Christoph? Anyway I will
> > wait for Jakub to mark this as "awaiting-upstream" or if he
> > applies it directly then fine.
> >
> >
> >
>
> Hi,
>
> I recall trying out similar approach internally a few years ago.
>
> eth_get_headlen() function didn't work properly for non-Eth frames
> (ipoib). I believe this is still the case.
>
> Extra care is needed for the ipoib flow, which I assume gets broken here.

Are you actually sure that ipoib goes through
mlx5e_skb_from_cqe_mpwrq_nonlinear() ? Because, as far as I can see,
IPoIB disables striding in mlx5i_build_nic_params().

It's rather mlx5e_skb_from_cqe_nonlinear() that handles both, ethernet
and ipoib.


Christoph

>
> According to the perf gain, it is worth splitting to multiple code paths
> via branches/function pointers.
>
> Regards,
> Tariq

