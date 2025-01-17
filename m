Return-Path: <bpf+bounces-49190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E54A14FC4
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E147A17D0
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48941FF7A5;
	Fri, 17 Jan 2025 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aS9Y5yQt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B61FBC96
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118716; cv=none; b=GcFu9A7LJGn1z6CfYk7/kM1yL8ncbC4g2HiNEP6gnLO3WjsK1P396MhZCZj+kvbnh7sQi0VZUhEfpy12iSPOCXBCvu1cAk+nuZAtLU3yH+lsSQ1fifUxbokTuV4No0utRM9nlUp8AlKbm9vpTnB+stpWqHwgXqBYgNa1eO/+QlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118716; c=relaxed/simple;
	bh=un1b/p+etlaRZvGTnj0wGy4rWWQjEn54RRTXDwwF4Cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CZlhUsXrNRigR89YEjdVqZfvPHEbewdZ40jxB2yGSN/juSu2LYVpNKX/hy4krWqW87YVJFi38nLCRrSf8jGbFvkYEm9+Awr+g8Emekxd8NDmS38QbkHwnjNgN1fIxN3ApkWbU7a/t8HjrXNNigvG5jWMkTYxaWOiCeUE8GJ/e5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aS9Y5yQt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7IA/4+Igfj/5zI/g3T0/mubsjPOaD5i2z7Uf9OFwuY=;
	b=aS9Y5yQtDcg5ZQEXSgJ4hdP5rSbFOK+CDpMD8LeOgsOgyy2exI6k5aWJPgEjnRhJjWxU2r
	G1cLL4nyGRcBp+gJziBf70HXgbzOQudzKXZ8y4TFxbNGwGq9H3s+ncZwMLwTRdFffwmvlq
	5RG9QNEWxfuyq/ZNhmsAwEbm5vNO958=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-z4AJ_gU_MOSMoMikx_Jq5g-1; Fri, 17 Jan 2025 07:58:32 -0500
X-MC-Unique: z4AJ_gU_MOSMoMikx_Jq5g-1
X-Mimecast-MFC-AGG-ID: z4AJ_gU_MOSMoMikx_Jq5g
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab2e44dc9b8so405398466b.1
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 04:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118711; x=1737723511;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7IA/4+Igfj/5zI/g3T0/mubsjPOaD5i2z7Uf9OFwuY=;
        b=jS8Ej2uW9/v9Ds6jKenT3RKhRyZ11FccinqNExe842K36iu+X0GdSP97Y1wgtRrWuD
         BGg6m7X0tmqiJHwmScwS/lhl74yqTniVtm21rPV/pBNDHb+AJ0jnLvnW4UXfmbt8AMv0
         RQ/ofPBZdeK0vyUIFbvi148DuIoTiwhyrpc+S0pu3jRyR90wrFQ0+n4Kip16MXH0EkaM
         hL+DFjPX/4jjr4kCN6T2AyaSNdvOk6TQtNresMAheYRz3ARBWEPCIR5KfQCFjVSliNuP
         1ZiPwvYaJbNJH6SluRXBxB6UwngZNWBJ/VaZaArJAhJy55oPjcKM89YzFVgQFUs5DtXL
         lubA==
X-Forwarded-Encrypted: i=1; AJvYcCXH19haOrH56bX78Vy7yCCbrwmElsCI3ANHwC2j80+8gxJ8WyMe53WhoPqqDCmeMOI0cps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKUG1AK0O+CTHZhLNOIObq4tBB+hpiXF09wHoXAqvAOvIl/o6
	Oi0MeplvsTpaHfs2TiPzQLnF+qZxK8Avr7t/psJ67H92yEB0VkHP7cPq920q2YOErpCrgFqkduE
	+5SifsHQs9m8y5H3o6k9KyfMgYGfR+ddeyAlypP/i5NP3kG1Omw==
X-Gm-Gg: ASbGnctUQttDWQi67xzVOsG4I9CxVkWBBOlk8Gl+JPp3qtkyf6aiJ24vbrSqe+sdV7Q
	l3O64Ipe45aE/Kjakh/2GR0Y8OBAy4/jcvSbgsE7NwZEQ3j4LLkLDZVHTt8AD6wLo679DyGK341
	ENMEarSXJxEnJDZmgl3NGWIAaev4WO72neneiF8aJOIHxyVq3YlcOsqpu05wUzGW9mKMwz5KZ6a
	yIqsre7UWghuXdohjFA76F7f2erHgTSYSIuv2oXYSmtHF4zdIzBnMeG+xpFx23SyYEOQ2z4Ikws
	MovVTg==
X-Received: by 2002:a17:906:99c2:b0:ab2:faed:fad5 with SMTP id a640c23a62f3a-ab38cc8f4afmr176759066b.15.1737118710943;
        Fri, 17 Jan 2025 04:58:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC3t1kll5oxU2z48Sg1MKuVMUZmjw7/P62bWkfTQ1ddyFTQEqfnRkWMl7N2wCb/X4hazKIFQ==
X-Received: by 2002:a17:906:99c2:b0:ab2:faed:fad5 with SMTP id a640c23a62f3a-ab38cc8f4afmr176756066b.15.1737118710597;
        Fri, 17 Jan 2025 04:58:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2d583sm165329266b.84.2025.01.17.04.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:58:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4604617E7873; Fri, 17 Jan 2025 13:58:29 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 6/8] bpf: cpumap: switch to
 napi_skb_cache_get_bulk()
In-Reply-To: <20250115151901.2063909-7-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-7-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:58:29 +0100
Message-ID: <874j1xoave.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Now that cpumap uses GRO, which drops unused skb heads to the NAPI
> cache, use napi_skb_cache_get_bulk() to try to reuse cached entries
> and lower MM layer pressure. Always disable the BH before checking and
> running the cpumap-pinned XDP prog and don't re-enable it in between
> that and allocating an skb bulk, as we can access the NAPI caches only
> from the BH context.
> The better GRO aggregates packets, the less new skbs will be allocated.
> If an aggregated skb contains 16 frags, this means 15 skbs were returned
> to the cache, so next 15 skbs will be built without allocating anything.
>
> The same trafficgen UDP GRO test now shows:
>
>                 GRO off   GRO on
> threaded GRO    2.3       4         Mpps
> thr bulk GRO    2.4       4.7       Mpps
> diff            +4        +17       %
>
> Comparing to the baseline cpumap:
>
> baseline        2.7       N/A       Mpps
> thr bulk GRO    2.4       4.7       Mpps
> diff            -11       +74       %
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


