Return-Path: <bpf+bounces-49191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C176A14FCB
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973AF166B3E
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CEB1FFC5F;
	Fri, 17 Jan 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LproePKH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B91FFC42
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118729; cv=none; b=Ge/s1lqEFctyVSHyB/l74SJPuNnBYHqrVuVYRPbn1goyQbSEom/FVUKQERg868Y/cGB/hDMCqTtmxJfKBDaSAsuoIfNrs5L3lTNbXlyWBvVD24iGRSmMYh84x84JayIgXi2/UnPBOqsg3wGxy7WXjz8gm+W1DlW4Z2+cNYC8rWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118729; c=relaxed/simple;
	bh=PlR6BI0pnwGwhH26X/m5utIA1jO/eGa1YHXFOyu++WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OmrhBeWsR7G7kphjYoYvD0BDxAW7Ee6CnWja04ns5Z3NMgeg0im9RFPsST5TX0nOXH4GJMSrOyJjQhGpAGhoU0IOCfIVgL137f1qeHIsOgHj0rtKZFa20XdW+XABITD+YA9M6CV8E6KcEwGttDa0FYQEHVRdPfqin+siYCdbSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LproePKH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlR6BI0pnwGwhH26X/m5utIA1jO/eGa1YHXFOyu++WE=;
	b=LproePKHCr8qiG3W1OdyD8m/zsaHpk7xnzqPOvYyp9coN5uTe5q6HuFZHUL8KTxVQ8qkx+
	mUDc61R9OYfaSjindiRUm68ufHRoc2bS3HoMRyI73kYm1nxQw62h54TvwHd7WdW/RT/sjU
	bVhLJ+dWlB6Whn++TyBBPwHXRYQObsQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-1wTjnTOSONulZjx72k_ecw-1; Fri, 17 Jan 2025 07:58:45 -0500
X-MC-Unique: 1wTjnTOSONulZjx72k_ecw-1
X-Mimecast-MFC-AGG-ID: 1wTjnTOSONulZjx72k_ecw
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa67fcbb549so183518566b.0
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 04:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118724; x=1737723524;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlR6BI0pnwGwhH26X/m5utIA1jO/eGa1YHXFOyu++WE=;
        b=Tr+/hKOAODV1Fh4vv1kqKIk4Nn2IUoxxzVLSDcVpI1VvnG0hNsuip6HkjYympfmxsP
         GhCC6/cAx55TvlMT6J2oSex9OVH0WOV+Xk5VXMwOyVkP0h2EeuLVd3cUyNds4W9qDZY9
         0EgLaIoF1j7rLiiVxPq7zf/IIrihkZFH3oZ1wq5XyrJLnSNm93SZAyUL5u10NF1Mz+HS
         99HaJiTsSAzeVwe+qwLC9lolfUFKq2S2JwGcYE++zIF1lwzPVtMaAGY+magfUP5SA9yd
         /lFBjm+FGqOGjvAWtrpVe5ChkS/b2difAt5srSMp9hG/LIgP30nikt7UQ+UlPl63ix7x
         Y1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVjNe7hDDRT7lEeKVtFJ/ASwl0WPXdi4ye7IzMEGYqxKOKfAp1djDf5YOW5wJLDQuJarCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybEjuEIELfnj2CWTwdbIWa/EXR3C4Ifc5U+asSV0JXiXYqekE9
	FjzAG3XOplctDIXX8OI/tnHp8j0gzU+c1SnB4twQrHzjfXpBr8cQAEQGeLlBQoUBoiRVpImRC8O
	5FqL/kcZW15wNUcIHyg2EdRZxpE9RZ57OqZ7c6203BwGpSXF8SQ==
X-Gm-Gg: ASbGnctAqkegdJrlgU/bhZaWfuHg7OiC8/4HumXvqn0x3KaVe4liF2HNLK4JO4Q6vIN
	yxjLFmD8dVjmhheOGhCzH0ylT1/VIgeJqmVkS/73cbSshWM2aerEQz/ZXZnEHuAurgLIOgZ6Jgz
	wwQ7dsOLm8NJbZb+KckFxtTpbkrniOORchOphPQbQ85C7ecMTam6Kxjb6lEmh81aES3yZybA/Io
	itzfnQoLnLo1P91XGvgRcuBqrvwSPiblKDutTUEBmTFa2VrTkX+3sc/6PbUZhUbGs59a1yUt4ti
	Ybpfsg==
X-Received: by 2002:a17:907:7ba9:b0:ab2:c0c8:383f with SMTP id a640c23a62f3a-ab38b0b684fmr250596966b.1.1737118723762;
        Fri, 17 Jan 2025 04:58:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGolLPypoV7vv1FU38Hl5hboOPUMjKRFS7YTrKUY9FAV3KoHCbQhbcHSkkSusXoVKy1aDv2tA==
X-Received: by 2002:a17:907:7ba9:b0:ab2:c0c8:383f with SMTP id a640c23a62f3a-ab38b0b684fmr250593166b.1.1737118723388;
        Fri, 17 Jan 2025 04:58:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce11eesm167839466b.38.2025.01.17.04.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:58:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 35A4C17E7875; Fri, 17 Jan 2025 13:58:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/8] veth: use napi_skb_cache_get_bulk()
 instead of xdp_alloc_skb_bulk()
In-Reply-To: <20250115151901.2063909-8-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-8-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:58:42 +0100
Message-ID: <871px1oav1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Now that we can bulk-allocate skbs from the NAPI cache, use that
> function to do that in veth as well instead of direct allocation from
> the kmem caches. veth uses NAPI and GRO, so this is both context-safe
> and beneficial.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


