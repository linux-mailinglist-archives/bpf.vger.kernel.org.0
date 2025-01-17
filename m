Return-Path: <bpf+bounces-49185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04DBA14F79
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4373C167ED0
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC151FF1DC;
	Fri, 17 Jan 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0jq7dr6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1021FC0FD
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117824; cv=none; b=FwM3khqKUvT9QGUGBVH9FsISDPq+irlWltu0PnXBlQ+YcHkhN6HXUanMUhVluv0TbrD9EWiJWvxUmSPHS/cXluSWYcqGxkVjUHydzTkAkzgIIbWY6tsY89OXfGsmbo6QszMBt8nOV202XoadAxP6cW7hLOTG9Ex3hhe99WLWhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117824; c=relaxed/simple;
	bh=cd54XL3aliFy0NpAyf3XBTHTvds4Rpx46S1hRQhFiU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z4j070PNBF0XR/sXvuZpCP8mm4lR7O+8EYLF2+e25W0FTzLxg/lso3cqd1X6gZRji+MEZnOt82wvgidGfajD4vsgqqzsCNiSGt3oYx/WHdLB32rZ2DfEixhde9L2W8x0qskRPlkmWYY86KQG5vJYofr1C5c4x2uvPbj644WoFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0jq7dr6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737117821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cob0lF5N6/+utp7g7nFV/A1Rwu4ms+yA3+XLT1WVBjE=;
	b=K0jq7dr6eCRPMjPxSHJud+bY7cgtBAEo6loPsVgBJ7mX/OwDbykwPDEGgK/Z73EZ7VB84C
	ncB0lYBPEoCL1FeX5J+d+x/nckTDXucQRNSZcScYfgqU6xvEU2hXZJSgP2Zjg2MdviYNS8
	PV75KOXAIBaJFTGtXTNJnxbK4Ls0e7o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-S-WCBEKgN-GoDvr_q34w5Q-1; Fri, 17 Jan 2025 07:43:40 -0500
X-MC-Unique: S-WCBEKgN-GoDvr_q34w5Q-1
X-Mimecast-MFC-AGG-ID: S-WCBEKgN-GoDvr_q34w5Q
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa66bc3b46dso172850366b.3
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 04:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117819; x=1737722619;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cob0lF5N6/+utp7g7nFV/A1Rwu4ms+yA3+XLT1WVBjE=;
        b=XQjntIYcLXYH6d5NoahPLp90R+Du7u/v9x2/nX/us5R5F5rASS0X5tcOA9KI8SWDMt
         AeB41aw4q+ni3Z2OWJRk/3T9EQYH+IPmKadUI2F7cuUmSbAAy4GmHQ7JQ7v4AK7lilox
         5sGkOlTupmbPXBUyX9pBUy7CMCWtxHZNp4vHLttz9o4k/0ehnviyd1OLJq+njt3GIQ5Z
         LYkDfI5sQ7anRrUK8zAwBdyFvSnTk3lbck7Y82+7vOrVyN2LW/r+RhzmQW/PRytR62Ds
         qNy5dgdUf+MC7NUHbiKYSFZ8cta/YvqNcXaR/EsuzfXTH4jyvoTDRB9aBGqNAqyVD97+
         5ScA==
X-Forwarded-Encrypted: i=1; AJvYcCV4L/AD8FLmPpO07MDHxeCe5e4iLAFvUyeu/iywNfHFP55e82Oysvo9fdDnjnPiv0G1eGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPy0XHM81pkB+0zd55pLRjLERe8NRSEH7FcFQsBauWqjDTpKE6
	uUBowbE7OlxvgAdScvTJMegWI0N34ctQU9N58coZA4KNgLUFV5ifX0WTYS9mX6nBTJzPFjnRoM3
	F6tg1JTIGI1sZoG1yTPsdmOJ606RutWdWVpwlrgRShWhEGTa1+Q==
X-Gm-Gg: ASbGncuZX9H6Kao1oyj7c6nviH1UJxfPNQ6itWJ8InJ4+Zt5SlqVdAtVKJ6xkNEQEOs
	TO33YxiO0CzvO+MCdDMh7JbSId64eiHJVYcQZzQa2QImfP24apS85mF/srqH/r6m9nPfI6An3i0
	3n8nyqoTIRMYo+2snEkPJVrdMUnGdFSDrvkbzV6GNUPz5ivXe85sWBAU3kMcC9fetrP1zmBGY3v
	Z0YxuhqIfnm0XNbpE/XKHW189az0ZzRCBK81pXBdX/ulYymdBmBjRcq5SGQijwRcmyQDctOfqWG
	pU4hdw==
X-Received: by 2002:a05:6402:2706:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5db7db078c2mr5461826a12.24.1737117819440;
        Fri, 17 Jan 2025 04:43:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExD7igQimPr+aQ0ED+vHaFPU0l3YZshIqVzmzRJdN8CGUD9UBkdkZfSFMOOMOsnPZQQHv4Sw==
X-Received: by 2002:a05:6402:2706:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5db7db078c2mr5461773a12.24.1737117818999;
        Fri, 17 Jan 2025 04:43:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73edc8b7sm1400986a12.76.2025.01.17.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:43:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BFCCD17E7866; Fri, 17 Jan 2025 13:43:36 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 1/8] net: gro: decouple GRO from the NAPI layer
In-Reply-To: <20250115151901.2063909-2-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-2-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:43:36 +0100
Message-ID: <87ikqdobk7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> In fact, these two are not tied closely to each other. The only
> requirements to GRO are to use it in the BH context and have some
> sane limits on the packet batches, e.g. NAPI has a limit of its
> budget (64/8/etc.).
> Move purely GRO fields into a new tagged group, &gro_node. Embed it
> into &napi_struct and adjust all the references. napi_id doesn't
> really belong to GRO, but:
>
> 1. struct gro_node has a 4-byte padding at the end anyway. If you
>    leave napi_id outside, struct napi_struct takes additional 8 bytes
>    (u32 napi_id + another 4-byte padding).
> 2. gro_receive_skb() uses it to mark skbs. We don't want to split it
>    into two functions or add an `if`, as this would be less efficient,
>    but we need it to be NAPI-independent. The current approach doesn't
>    change anything for NAPI-backed GROs; for standalone ones (which
>    are less important currently), the embedded napi_id will be just
>    zero =3D> no-op.
>
> Three Ethernet drivers use napi_gro_flush() not really meant to be
> exported, so move it to <net/gro.h> and add that include there.
> napi_gro_receive() is used in more than 100 drivers, keep it
> in <linux/netdevice.h>.
> This does not make GRO ready to use outside of the NAPI context
> yet.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


