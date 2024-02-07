Return-Path: <bpf+bounces-21397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A684C818
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 10:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2806A1C21EBA
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3C2375A;
	Wed,  7 Feb 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQUG6FWK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BD2555F
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299829; cv=none; b=AWsLe1Xwbgr4n1tJSHeOBD75o7PTlcto/CS3uZmMHUTjDo17JX1kM9i43mWTL1X9butxYzwAHf30XRL2lz0Xin6VG4gdL7WMDDO3xLxtr9q2YgafxE9cf04A6ek6aLjTUkLDPdinP/q0wwF0jUTHGAuuPjmJg4uc+aWTihYQqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299829; c=relaxed/simple;
	bh=Cv7/9dP3yWXOSwSLBEBu/XNpX5fgFWr4tiIcfDvbPTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LsHWmcXHO0Yc+Om6VS04XK1UugpF6FXY5vExfqlXo73DlX6NVeJQLS0FTmFmvewg2Q1eulq3FGv4InLvsu5Xu/pHH2xzizjvFZ1KrW3F1IQE+zI0eWsONSo1KfY4pwRzpUTcl3s18282F0H5ZD28Zuqzwnl+dVh5kXPUVYDAegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQUG6FWK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707299826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv7/9dP3yWXOSwSLBEBu/XNpX5fgFWr4tiIcfDvbPTA=;
	b=EQUG6FWKlOc+3A0XZaZh2RLHmAendT8545+S/yDLKTq7DESppFJew9t0NHT6AQwLzFUIgG
	n0P+1rkx6kDLKfx8TRFAiNtlyxxdNi7SqUHjgEfpJj05scAVO287aeeJJHid7TogJvyxp3
	DIMwLlf6bjAixqKZ7RrFy5E74LFMSB4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-agl2rEOzO6uu_APtg9oYsg-1; Wed, 07 Feb 2024 04:57:04 -0500
X-MC-Unique: agl2rEOzO6uu_APtg9oYsg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2f1d0c3389so29288466b.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 01:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299823; x=1707904623;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cv7/9dP3yWXOSwSLBEBu/XNpX5fgFWr4tiIcfDvbPTA=;
        b=ryLPvhn4jHxARftC1KHz1GECBMJzzCRZ7ESbOIWLMjQASaJWXTrMHBeGQO6ztA1KtK
         TtyZW29TECNwk7b4QZStVrz0aciiEkIbk7nZKDi3A2noCE1uVVhUde2To7fGu4W6omSJ
         Ia2l2L3l7el1TrCEWVJrTWjLmWI9Fpmga1h1XASWHYIibAghHvg44shCyhbMNKvIyS7t
         2eDD6s+lgc4QtPKWjAKEx8Ljwy6uV/RcHU+PayUY7la5S2QNw6AJsiZAMTH63dZikDmU
         ApjkFW+thF/6ZPtwM4m8IdQH0duSn1EXK8aJ+YfGamSWEf3I08jHJos1k7W34NW/Wsxp
         fP0Q==
X-Gm-Message-State: AOJu0YxQG6X9T7+zDUybhC3ktgMBE1IIWU71tDp3dUuoywQyyWZzPeBN
	Tvj7qCmrBesvSVV8DnAhsxhe7X60t6nNt3z08epfl0/CT7fLVpdFV7xf/1cR6UmEdsJYWdnevTJ
	ukOSKj7pErXTxdD71AaKxDurO3viWDIgtrEW8MoCu2vjGxuR5Yg==
X-Received: by 2002:a17:906:81d2:b0:a35:b7e6:e6f1 with SMTP id e18-20020a17090681d200b00a35b7e6e6f1mr4063793ejx.1.1707299823630;
        Wed, 07 Feb 2024 01:57:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSwAmWY9RJJ9TUjSBXFh9kgpiVX2NKugmz0T8d/UqurWryGKbM7hfHALn2pzP7Yq20/18XtQ==
X-Received: by 2002:a17:906:81d2:b0:a35:b7e6:e6f1 with SMTP id e18-20020a17090681d200b00a35b7e6e6f1mr4063775ejx.1.1707299823283;
        Wed, 07 Feb 2024 01:57:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKPS/bKWSeOFffzQPpPbeysS2Op/4B+/Qoow7qwB8GhXD86cynZcog4BGMd4I60H8vixL+cC8niAaW1ySC94GbWKcNSflNMSQG04ekaxvBAnLyhTMdxLpWZsFDVSin1nkDSKZpCeuSOjq2U972amigDIJ3AU5jYq5tFJ4VN27SXgvqXq1uKew0P//+jLkGnTCq61+oi8x7iUedqBEcML+jdjxLHAW1WIjB81xIPxEbm6GGy8ppiJkl0Evy6HsOcE1Bokn17YCFVVkpooJ3aS9Y76b2NQbY4fNNUfSttEOuSE2dx255nykkBsrYZ660ZjnkZTPenXfIBV+PSDHyLVuBbwou1MaIy1VqXHZDM/TKFkL2/7wpGoXydWAUyrox2dGh8Q8hJeWeyQTfgb/wa6WHgqAlTXFhd8nvptkPOi2c4aVsVXAunpObTBNnd6JXIrajzohFvbU8H5PFEE0kenT2C3tTJs3JpqSy5O8eiMv/dVYx0+M/nrI0nb6DxSjl0pu+mVrsszw=
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id vw4-20020a170907a70400b00a3881262235sm337321ejc.78.2024.02.07.01.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:57:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1F71D108B18B; Wed,  7 Feb 2024 10:57:02 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, magnus.karlsson@intel.com,
 bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, maciej.fijalkowski@intel.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, j.vosburgh@gmail.com,
 andy@greyhouse.net, hawk@kernel.org, john.fastabend@gmail.com,
 edumazet@google.com, lorenzo@kernel.org
Cc: bpf@vger.kernel.org, Prashant Batra <prbatra.mail@gmail.com>
Subject: Re: [PATCH net v2] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
In-Reply-To: <20240207084737.20890-1-magnus.karlsson@gmail.com>
References: <20240207084737.20890-1-magnus.karlsson@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 07 Feb 2024 10:57:02 +0100
Message-ID: <87plx8vbpt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Do not report the XDP capability NETDEV_XDP_ACT_XSK_ZEROCOPY as the
> bonding driver does not support XDP and AF_XDP in zero-copy mode even
> if the real NIC drivers do.
>
> Note that the driver used to report everything as supported before a
> device was bonded. Instead of just masking out the zero-copy support
> from this, have the driver report that no XDP feature is supported
> until a real device is bonded. This seems to be more truthful as it is
> the real drivers that decide what XDP features are supported.
>
> Fixes: cb9e6e584d58 ("bonding: add xdp_features support")
> Reported-by: Prashant Batra <prbatra.mail@gmail.com>
> Link: https://lore.kernel.org/all/CAJ8uoz2ieZCopgqTvQ9ZY6xQgTbujmC6XkMTam=
hp68O-h_-rLg@mail.gmail.com/T/
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


