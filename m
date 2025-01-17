Return-Path: <bpf+bounces-49189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FAA14FBD
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A003A8D7D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26F1FF5F6;
	Fri, 17 Jan 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep/c6L0/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23230197A92
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118621; cv=none; b=B56MvaXMjQtC//7CpRgC4X50t/axvdsDexmBZXe/2voGW4oqd68RiL9ZkaPlwPRL5C4pIYoEDoRpcvqxYCFaELJ44OuTtyu1dZBxN2P0WCoPkJ/2QOmDVZBMKD0Ob/EYcBcodCA++7/uBaWyqBgfYJ8OK25unq/FP7dFdvfLvm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118621; c=relaxed/simple;
	bh=aTVho8AOByn1YepMWxN84zHPjm3oXGLDzyOU12rA3sQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IszbE9I9aNdyGcV6iTRQnGC1PZXPJDp9ZhghD0k0QLygBGxfQwAX4dklCGZ5YW6cw4SWHE7yaVTktCDt4vb2/5LBZwKA0HlLJq5oZpC9r9IrkgYNoNkvb8xODu7wRWQlz9fGfeWMDLvoO45UHz5OQpvy1X0RQgmJ4mm7Ml6XD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ep/c6L0/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljy9OBJQv1xjgRSfCuYEuq1WMWKhZpYM5ej1GNWwrgg=;
	b=ep/c6L0/xnr3ZIqRD+QdesG2qfKC2Wj5Ti8L5RACd9gjQhsgYDLtQMOibHTejJGxrorpTE
	Vx+9VW9z5eKI7JjBOlLGn3Wlvb4L9YPMKCsazZ/FOkFftMR3i8ghoTZJv8UjgBcNLLeVsN
	pKJ0yHexafkiexwtm6atDRw1hAEdFCY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-QDRbjeIwOMeSMJXL0jCgZw-1; Fri, 17 Jan 2025 07:56:57 -0500
X-MC-Unique: QDRbjeIwOMeSMJXL0jCgZw-1
X-Mimecast-MFC-AGG-ID: QDRbjeIwOMeSMJXL0jCgZw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa68fd5393cso283748666b.0
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 04:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118616; x=1737723416;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljy9OBJQv1xjgRSfCuYEuq1WMWKhZpYM5ej1GNWwrgg=;
        b=UCy0oKGV7PF/2zUPWLVnMX/r85ZINT6EkQcsCBqgGbnsuu4K9O5O8WQW0F/eyoJXVT
         qnFywqGlN9GcAUdQrgR/TuUnDrDAnGX+a27pcGU+DzD9yd2LptHdXYXZ1D71MsmM5oEU
         Q3egnzrjcnq8asA+SffSpDir0bmCv4PICZ4Ah/l5xQB3LozZcaoKaBVQPkmdzdXaVJ29
         UbnlZYVgL5J3ozbHB1oCIaRr4o+/+gUKgTqTDAOwr0B8meyzy6KPF0kvo7yPwhZsdSe8
         VGOtG2EaCGUYLekFmQRKbVgxhpwWcCPo1BvgCby75kzg0qZuZCaPIrNC3U+dXHwjUf6q
         oKFw==
X-Forwarded-Encrypted: i=1; AJvYcCWC3wT7L94j8aB4vI5jO/boGSqzUoxr/WA+JwFiOcHoD2AGiQTQTodC+W+Y7pgsqndlK2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCVMy1P0UEuiHrim6EYjQDjamHZ4xEkzf4GiaZuV0VnAL7CLU
	I4LiiuZEiXtpqAqG1DTzWuxVmwtE5k2Ad+72ehThWNhaYuYFYMkVBpierXum1irsJAenHB+Ijcl
	YNeEc6eGDDhGLw0YNMHwbS+fLgj52n7+ahDCFlaXFcbmMpN8NSA==
X-Gm-Gg: ASbGnctkKVIn3fSvLzCW9+2ZhnZXXe35vmPWN0gLzw9Uls3KSgtsOGj/QrtGqKlloJd
	SfwJf1aCN+HpDoU/h10g/B9b8AXAnixj4bzCt5hGRvNPYeiERplF08GdGkL5rpYRbsaj7o8i3HL
	u1jtMdl4y2cnq8jjRa//zctzNjyWBr8fz5cE8Xj3bK3CfNU451ErTyYh9V9NyMNQJuRHVxJn9Do
	EaXy1eLs1+q6ggLqccqz5dlYDSMkE/RiEm3cU30u3t9KWjQKVpON7hQegQt9FECxKL1zLkKlQLn
	d718KQ==
X-Received: by 2002:a17:907:7dab:b0:aa5:1d68:1f43 with SMTP id a640c23a62f3a-ab38cc5cfd4mr198273866b.11.1737118616477;
        Fri, 17 Jan 2025 04:56:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxaKgdK7JoJbBu6MZvil0YKC/KT9C4PJcYlKIm/WK2Gh3c/UvTHSx0h4SJ3YHwYv67jGcLwA==
X-Received: by 2002:a17:907:7dab:b0:aa5:1d68:1f43 with SMTP id a640c23a62f3a-ab38cc5cfd4mr198270766b.11.1737118615950;
        Fri, 17 Jan 2025 04:56:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c60746sm167663966b.4.2025.01.17.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:56:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9851D17E7871; Fri, 17 Jan 2025 13:56:54 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 5/8] net: skbuff: introduce
 napi_skb_cache_get_bulk()
In-Reply-To: <20250115151901.2063909-6-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-6-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:56:54 +0100
Message-ID: <877c6toay1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Add a function to get an array of skbs from the NAPI percpu cache.
> It's supposed to be a drop-in replacement for
> kmem_cache_alloc_bulk(skbuff_head_cache, GFP_ATOMIC) and
> xdp_alloc_skb_bulk(GFP_ATOMIC). The difference (apart from the
> requirement to call it only from the BH) is that it tries to use
> as many NAPI cache entries for skbs as possible, and allocate new
> ones only if needed.
>
> The logic is as follows:
>
> * there is enough skbs in the cache: decache them and return to the
>   caller;
> * not enough: try refilling the cache first. If there is now enough
>   skbs, return;
> * still not enough: try allocating skbs directly to the output array
>   with %GFP_ZERO, maybe we'll be able to get some. If there's now
>   enough, return;
> * still not enough: return as many as we were able to obtain.
>
> Most of times, if called from the NAPI polling loop, the first one will
> be true, sometimes (rarely) the second one. The third and the fourth --
> only under heavy memory pressure.
> It can save significant amounts of CPU cycles if there are GRO cycles
> and/or Tx completion cycles (anything that descends to
> napi_skb_cache_put()) happening on this CPU.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Neat idea!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


