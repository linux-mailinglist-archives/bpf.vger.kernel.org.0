Return-Path: <bpf+bounces-22404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208E85E036
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 15:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0984283A39
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA807FBC0;
	Wed, 21 Feb 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhT+WZ1+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B57F47A
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526936; cv=none; b=mq/z1hF4WuRR2RsWBYT0VNrX7g0X29YHBGu+yI5bNF8z4cCq3TmpzURMs0Pp25nRCySIP4RDZ+E/Rb8mLqH5QXfYPjdE75kgOj68LtF4G3Cj+EfFs3E0U8BWoi+ZMwh122ZlnAAD1ud6VUSOKJnA4IvMYEIcCI2j8CYK3yrddn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526936; c=relaxed/simple;
	bh=gOTD+KKWRxWSAwHO+4bRhi73I30/f1TI2Yd+ByEZBe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eLrjNWZkMbhmpOiRvCOdYZicBadQ8HU6LlT1ZKg86pjtAmm/32L9hn5oHYw7zD5rmvcMYFOPB1FlnbO44oLsZ8uAupnzQfBijRTM2DRYNeZaHax2ii+X/8MjCA+rD6Nbw3w0ULygmdKWU1osmHklHvBAxq2jwQSwvEHcHfwrKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhT+WZ1+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708526933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOTD+KKWRxWSAwHO+4bRhi73I30/f1TI2Yd+ByEZBe0=;
	b=UhT+WZ1+JYl3hO4QK/NKICwL+V0f8GoEUz0nzl2GMAYXlfUEL6zXdOqj5je4BqF0TyDlEh
	FLizJKlY/0IzK5U06b+21XQFR+6FklCn5v1iz+ZgPph1T+znBOFW1RUPdXUOgent2HhEXa
	0+yGR3NadwkMeCehWCpcvBT4OLeW09I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519--w-hzu3HPmyLs25W_MX0VA-1; Wed, 21 Feb 2024 09:48:50 -0500
X-MC-Unique: -w-hzu3HPmyLs25W_MX0VA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3ed1fb115eso183928766b.2
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 06:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526929; x=1709131729;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOTD+KKWRxWSAwHO+4bRhi73I30/f1TI2Yd+ByEZBe0=;
        b=V+YIDrzyC3WVHNi6iKg//K5kXsdiV3lArQL62pvd2A8z/1rPcOgCNmM/BxPFwcLuxr
         7c4IZ62Q3ITQ8xk+O+pZ6OX0203DqY61phqLM47Z0qFokt9r9gseS7ByAQIY/pCT2Ypc
         30EYOxAy0UePjA5RiSWOD3BkioPTEBYIfntqWiA1+uCCOd1Rc6zA25oiTK2VLkGqSt+t
         4YXAnXfAV58EWcEwzmsqRlzzs4VhdcyRlKu5wpTM5O2DTuQH7qr0Q460RUCQPY+X1t++
         B0G01LJQMROabFdkTtyntwIK/fyAzbwB/UV29T+/2IV5Y+ikDHTGgMDkVgTxpH1uqWaz
         P8qw==
X-Forwarded-Encrypted: i=1; AJvYcCXXLLKNZF+4YGAqREZZTRR3l9xWNeRf3GWEfh0t5+99Lgu9xcOuiZQgySH6H0QLYhbyxrXrPmJFykPrLdUc7RE13MsW
X-Gm-Message-State: AOJu0YxTPHSfzOrL/CpOVGP2C63zMNT3lwvO3EiYyMWzLRWH0FV3XikE
	VMyQdqbpg4HvFep6MKlKudu0yHH7xE90t/oadAhVb6hrrGa6MmqPshgGK5X0oP1JmJ97mzY+iI1
	7syNYApGP0O+7pGdN1wJrfDxOLNVF1ACn5Ur3vyYvfgwOQBXlPQ==
X-Received: by 2002:a17:906:c9c6:b0:a3e:272e:7b98 with SMTP id hk6-20020a170906c9c600b00a3e272e7b98mr7573921ejb.40.1708526929762;
        Wed, 21 Feb 2024 06:48:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG82Opb+cFDAfYT6H0h3uOKz3esKxcunes5mY2+eJEBxnlbQm9TjvlUm8DfSoW7K+viDtxo0g==
X-Received: by 2002:a17:906:c9c6:b0:a3e:272e:7b98 with SMTP id hk6-20020a170906c9c600b00a3e272e7b98mr7573909ejb.40.1708526929477;
        Wed, 21 Feb 2024 06:48:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a3f2bf468b9sm852539ejc.173.2024.02.21.06.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:48:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B401310F6582; Wed, 21 Feb 2024 15:48:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] bpf: test_run: Use system page pool for
 XDP live frame mode
In-Reply-To: <20240220210342.40267-3-toke@redhat.com>
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-3-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 21 Feb 2024 15:48:48 +0100
Message-ID: <87sf1lzxdb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> The cookie is a random 128-bit value, which means the probability that
> we will get accidental collisions (which would lead to recycling the
> wrong page values and reading garbage) is on the order of 2^-128. This
> is in the "won't happen before the heat death of the universe" range, so
> this marking is safe for the intended usage.

Alright, got a second opinion on this from someone better at security
than me; I'll go try out some different ideas :)

pw-bot: changes-requested


