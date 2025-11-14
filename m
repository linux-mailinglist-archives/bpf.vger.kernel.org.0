Return-Path: <bpf+bounces-74480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41105C5BD78
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 08:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70A9E358645
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F5F2F60A3;
	Fri, 14 Nov 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4O4XUEC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DED42E719E
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763106538; cv=none; b=QBjKax3ORJimKvBKhmNh8UQ0Ngi0Vco9OfAYLd6XzU2w1KJ1AVGAIfmYPeUpYqpCpYF8AAIo5UDp6cJGj2buI2PHZC4fpBwJqDGjj3G8jAA7O73ov9xEYG7bzO36hlg55IQdOn33W1ZWWcr/aZEWo5+Kq/ay1cosvR+JEXKL0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763106538; c=relaxed/simple;
	bh=zU3Jz33VlhMhXlakQDGY65Ou3aco1Oh1MhoX9RalW7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=st62eB6AFxP+TlNvywlCgoc8NU0uSdhuvW/m90bUWna2FaOID38kcaBROlMBT/Qp4+DChu1uZ9LIlYxU6t0Wgu816yxd4U0/NYBrmD70fXiiOgrz8T2u71ll61KZWs7is6p8xZ86+ZRwbMv//RqLTAejd6BGEmoM6aBYXADRkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4O4XUEC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343684a06b2so1405162a91.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 23:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763106536; x=1763711336; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zU3Jz33VlhMhXlakQDGY65Ou3aco1Oh1MhoX9RalW7c=;
        b=m4O4XUEC4+qNa5pE+6lgAvj217A0Mrl9PvhWmla3v8FqhoO3eOsbhkaThx1hdbo76s
         1J/1t3x7m4bZRJqiAWs1G4+cUKjRRIIXlNLvIqB+A5fwBibjmfb98m9lzWviHQJKiMO3
         32mWADBIHl4k8VUovH3Ya1hmYSsSCAM2LA2wT/HHoBmHMVJrXse9Hdye+YSow29005/h
         LRXild7tmEAxRV6JN3gmb1fPMC0GEOw381VsYp9TFpMSWzqZpPrYHIrWCKNW6DJsdywt
         inqlxlIRBRs1asMnkP6kUpLosoPXh4+/QcmLFRABe2f2qBD6mZT2urOvuAoib0nRMj11
         3jfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763106536; x=1763711336;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zU3Jz33VlhMhXlakQDGY65Ou3aco1Oh1MhoX9RalW7c=;
        b=MLpK0pIZa7rcXZWq7G+3vpa3UnhqVuKgZbIvRP5uTiZxWv5fYWwwuX9pk4+U77raOp
         CR1yYhruqdFlZG7rQCacrlnRVHdevOcsZR/ozxmac+7lJiBffoxX5jjk6pC0Lgrwm73c
         njK+ErHOi4tBqhDhRFzRxoTmv6+T4MHhJXLlCJj5GpEyk1J9KW9eVe61ehe/Idwlw6Du
         fUXKfaz1Rgh0YjECdRxFlqnCxj1qqhb/RgQGudA6OvOasf738F2B8kENOcSQdt5zR8Y8
         TNlQmtoY+xCdQCGY6PXLI2PYmKatZ8Tce8ubsqshSQBwoIQhgpj6gc/eAoqbOkYbsgI+
         NyWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcBFp4j5RINRU4+/YYyJzRl3nOBD+vNkwDI8jBkgLOY6eAkWF8wGAtGwJyICyXlMZB+D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHo+k2kmT+/PUZVV/WjU8mecofi4tXTUya+FePZ+VywHe8tES
	hxxkZWS3/TNorNM3UgfNNM/5hVepN8XpoMHBdqy9xbxt41Lxhu2FqII3
X-Gm-Gg: ASbGnctsj1IBKxBNEx7Uh4YDnATtoEd2FWuTxbaPdcmc23LPFUqchKqMGTCQISwFfNx
	9Dxt9GBpYSwfCO5gyLB578UU08GkFpPbj7j4Pgq1RlNMU7X02MWbCPtHP8ndFknkCI8DmlA7FBK
	h/w07F4ZyxWfbFJ1DbLVi1RuyQqaiiSmhys/Wbei58Q69M5d1DvKXGBG/I737lwNgt5XUX8tt/o
	ZYtXlsxNW1xdhzQGlnltzSYF9/Ka2VUrs1tsxzzrUeTovyvEWl+xebeYelQJ5lv7LDv/M0Szka5
	led5QK6D8AquOBv4zv5sS+fjh6Finf739QqJa2e+02I0wVwI4VAjxHGsxiuuYO+4HWZqBKocUed
	/A+oQilX5yV5ibU4GDtj1zs8d6M/jj99Af+zUwfKaE73xT+x3R5yu+GKMmw/KTJDuzrg5u405
X-Google-Smtp-Source: AGHT+IHZqFOQ39QbDl/5FI1Y42lLcB677c7dz/dxDMgaLQatrJydcVM0ARmxlMoIk0SFmSjxg5gzbg==
X-Received: by 2002:a17:90b:51cb:b0:340:ec6f:5ac5 with SMTP id 98e67ed59e1d1-343f9e915bbmr2111332a91.2.1763106536188;
        Thu, 13 Nov 2025 23:48:56 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07ba2a4sm8304529a91.15.2025.11.13.23.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 23:48:55 -0800 (PST)
Message-ID: <62b71f16bf43e6045fb3c37a7b4db7d959a17739.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Recognize special arithmetic shift in
 the verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sunhao.th@gmail.com, kernel-team@fb.com
Date: Thu, 13 Nov 2025 23:48:53 -0800
In-Reply-To: <f273691ffc4f2ca3a4f6b16abb50804f60aa4fe9.camel@gmail.com>
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
	 <f273691ffc4f2ca3a4f6b16abb50804f60aa4fe9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 23:26 -0800, Eduard Zingerman wrote:
> On Thu, 2025-11-13 at 19:10 -0800, Alexei Starovoitov wrote:
>=20
> [...]
>=20
> > 227: (85) call bpf_skb_store_bytes#9
> > 228: (bc) w2 =3D w0
> > 229: (c4) w2 s>>=3D 31=C2=A0=C2=A0 ;
> > R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-1,smax32=3D0,va=
r_off=3D(0x0; 0xffffffff))
> > 230: (54) w2 &=3D -134=C2=A0=C2=A0 ;
> > R2=3Dscalar(smin=3D0,smax=3Dumax=3Dumax32=3D0xffffff7a,smax32=3D0x7ffff=
f7a,var_off=3D(0x0; 0xffffff7a))
>=20
> Forking states is an interesting idea, however something is fishy with
> the way we handle &=3D. After arithmetic shift the range is known to be [=
-1,0].
> I would assume that binary 'and' operation cannot widen the range,

Ok, that's not true for negative numbers.
Each switch from 1 to 0 lowers minimal value bound.

[...]

