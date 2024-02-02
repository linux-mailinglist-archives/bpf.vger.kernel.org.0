Return-Path: <bpf+bounces-21044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 231EF846F5D
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 12:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9B8B2DACA
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8955B4BAB5;
	Fri,  2 Feb 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaDXZzyc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EEF13E223
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874141; cv=none; b=FAgaE67XtCdpJwhDcUYaCTNKDIarkAtfIxtAuQmTOf7Kxhl493tAyrXZN4rKwf191pmiMrG4gxavnuuavshp43FTkr1AXe+PxKgizTLab6XInrRU+YnasIXgWV+3Mf5TdWOBqbig34aOmpJUh4FAOYjARTJmUUfZ4yApHNDhwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874141; c=relaxed/simple;
	bh=0Uz+i8MjJSenirZh0mUrgqQNJWmb68i5QhXBdv2XStY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nlsqWeJOtouKW5xGYLm3/FW7MZB1hcJ23ki0sY/DFiB6KsjsBCo9HCafybT10fJtdJqTKcjpsNSYqSzCnYrrvwhFXLrmBpb2TVX5fBHbOeyrRcbocoOBgKMGRu79KwfFDMNW3CpGI6OTkSz+zTFLWdwPiMRWCjk6r6/6nliwk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaDXZzyc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706874138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Uz+i8MjJSenirZh0mUrgqQNJWmb68i5QhXBdv2XStY=;
	b=HaDXZzyc+drzuAjtb+NltNX1+BwTuLIqu47+DSCSiJQtkae8O88ZVO5a7jWUphWYwGuy2A
	a9P/y1ah8rWyFOe8/vsoy8TN9CeM9QMI2InZBt3xaCrYdcPQHINWbU3cO6Rlm69mbmuIJy
	o93kB7Yw1yVrSmEj1JT3C67T5EDm6Bg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-OmM8PC1XMDyE2O8UPPmXcQ-1; Fri, 02 Feb 2024 06:42:16 -0500
X-MC-Unique: OmM8PC1XMDyE2O8UPPmXcQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2c4e9cb449so139387066b.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 03:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874135; x=1707478935;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Uz+i8MjJSenirZh0mUrgqQNJWmb68i5QhXBdv2XStY=;
        b=MB4fDO5KixkYotqLk1WsGfSZgBEQVsL8E+v1wr4rGdw5x/sFgV8J2MUI5DCy0VySiP
         cQIu0F2EAP0kiWTEfSwYURSLj9uqrs2j/bK0JkOtmOc3nqT+WsfwyKZmd5zY0pcYCDTr
         kMTKcoldbUTUzlq0pLvDPYsj/1Q+ms8dMASq2SPrf0JXkucjqRnjM28AQ7/h6Gp8sezw
         l9BASs+RnGDylliB3MwMicX0+f5+N/jOEPP2uHM3hi5dTU7mcVbaUVP+3YOYROBtp54Y
         GefLrSX59G1pBxnJyYiTEvt80Ua/LMz+SQ5h0jyd+xpFYNQARxOoooWTuQnmI6Pkmbf6
         erJA==
X-Gm-Message-State: AOJu0YyKyddHEeosmi5fD6/eqCQsKH7nSlXTzN6VH8BtzwuhXAvfkXIc
	GB1S1c5ONaycVy0oaD+aWDE7aI3n/FizcPZhJdMzh6gkzzjwi7u3+9yHeVLMerXHFWdumm2AHY7
	v7LPeuXfXVc11CXzDi+zeCaNwIsb9gtfBZx04qAOdDpkT8JXrlA==
X-Received: by 2002:a17:906:2e87:b0:a34:adce:b5be with SMTP id o7-20020a1709062e8700b00a34adceb5bemr6466426eji.1.1706874135615;
        Fri, 02 Feb 2024 03:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE0Q9OhxrbEM9zN9VXsMVO/3rEJNZuM7N92oHBfjcS4SBq2/nYTkciBJ+OdsCi6sR/PYcpaQ==
X-Received: by 2002:a17:906:2e87:b0:a34:adce:b5be with SMTP id o7-20020a1709062e8700b00a34adceb5bemr6466382eji.1.1706874134305;
        Fri, 02 Feb 2024 03:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWgUQiW0qmIr+l4Jg9ciixIdW/YmYCKOhjgS3IH3EzAuLSRKebUrBBhFWPpGuLvnehbdToaj/HGLwWybsB27JZNTmrBqVAY4EU11wL4+wEoH3+4Lzp7Ku3Ol5jJRTq3ogo6tWH/p+oz5SaklMvHG/J4cZz7dFsPDOsoisrh5GbweO1+YF0+ZL7ZU4RIEZFQ5R9suQ4vBXTuJM/VXlv6N1qTGA0MeViXTSqI4xpy02YI32F/gGhsch868eu4XBJp71HYWW5+CYFjSdRptV2i2xEwKNWW59cJSHOSvF55C8GWh0sd4L3NgXaGDaDKB73tlbNPXK5zDkgIbQoJAfzQ0iqe5YhPHGIJZlG7er252Gj+/ZSv20Y3UfJv6PVjES6wr0Qacy4cJCiPtnWLm6L9Zpo1ktCFPjc=
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id di10-20020a170906730a00b00a34ae71e58dsm798363ejc.147.2024.02.02.03.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:42:14 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A0116108A839; Fri,  2 Feb 2024 12:42:13 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com
Subject: Re: [PATCH v7 net-next 3/4] xdp: add multi-buff support for xdp
 running in generic mode
In-Reply-To: <35486ef21c3a74931e81b5e9c604734781ca1213.1706861261.git.lorenzo@kernel.org>
References: <cover.1706861261.git.lorenzo@kernel.org>
 <35486ef21c3a74931e81b5e9c604734781ca1213.1706861261.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 Feb 2024 12:42:13 +0100
Message-ID: <87plxfxfca.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Similar to native xdp, do not always linearize the skb in
> netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> processed by the eBPF program. This allow to add multi-buffer support
> for xdp running in generic mode.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


