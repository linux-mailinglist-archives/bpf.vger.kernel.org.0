Return-Path: <bpf+bounces-78705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01648D18BB0
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B1223024B65
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7021A296BA9;
	Tue, 13 Jan 2026 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RQbd5wCG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A58207A0B
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307587; cv=none; b=tOKGQIBnYEgbMwWELqzFUI4GL5iuxdp6LWKSDunf3k7hSEixuFpWzReeo7GWW93Y6TSZqsXMizukEszahUBrdNfkWEBVwvrGPVsV2LoCF1x5JPDV5ZdAtElsSqnqJfYOxNw5vNIUArHdSHSkQbDhPQfDUKdCv3DjRWQ2JdmmidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307587; c=relaxed/simple;
	bh=dEbEAnCGy+pafrbRBLIoJyaTclKmc9Kn8AmsVMZrZr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmvXJflHWgimZYLk8jXcE+UUa+4Js5BR80r3BjmdA3TXFe5BMPROZaMXD3ljF0Cf05rz9KgGJ8Do0yegie8C6Uxs7lVsXgoK0V6QsuWuc6/T34Dl/fHoDUsdPD5OhrrLBCdUYXVquh4o5+K8QIPvXHQgHw1Su4woRZk2qix5eZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RQbd5wCG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b83122f9d78so1185154766b.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768307584; x=1768912384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88S5rbYPKp/7kLImc9Htsmsd5c09rInIOHsU9gp+T3Y=;
        b=RQbd5wCG69RdQTzp4U25QVSLsP8yyZxZd2ix4ds3Em7E5AmGzrzYqYcsVGrvhQu1OR
         Pi488xOJ74XRtwz92HF1RGIXmVqyPLow9eXANF40RyI0MBGOPwE/rZjE+P6XO4Sw0qaG
         xP9cCfDSRLVw2WdVDUEkAnB26HCr0Kv/JIRWVdPFf9kaRZARFpojduKiRGIoQvVRPNB4
         UBgoOLqDun3c01fAAyhuladVL0zA7KYUULkpBAbN0WL1Jncxjw5BdC1aMhdHWk/1lioo
         9fkBqxnoViCOmcFpNqeZuS1lbqTxi9ynElM1fdUbT10211V+5lihVQAuGYi114DMcvDl
         CKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768307584; x=1768912384;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=88S5rbYPKp/7kLImc9Htsmsd5c09rInIOHsU9gp+T3Y=;
        b=dSxHO2tqFTj0iu0v3xSamPWh1w1/rvQ42FLIPXMnfJYxZHokNhqa0KTn4EFlcqNLMa
         lnpy6ieVtg6HdN5BnhNC5A50TlwSiFDI48p4KcLTKQsCukggSFimfqSg7Yj6LtIWHAdJ
         APPOcpdlL/iA4EIjUsqVNLWUSZ84e9VBeEBgnb/XUmu0PefczVXIIqQt271VS8ONnqp8
         xPVu+gMoQ+pFCAA3EuRQlMwE1r32KPRE/shpEp2KONv8e0LPlp+qbMvoKqgWX4DmNiRO
         megNbB9IgDMACfMliuIprF6V793wOWFYj1Fwubys6iCmX0M2v6VWa+9lzADOwews18MC
         2k0w==
X-Forwarded-Encrypted: i=1; AJvYcCVWnX614wk9CnAfBUeGOCE6VFE9oUNX7Q4KZJF8EjcJhgVk9hjkSbOuFBKfbP/yz67ty2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ljgsVZoGOAROcph6mJJPEYbI0gyRa/9JZ50IOd6jiAOkijSz
	PulXG1eorb6lERK3QSpPxZEK0vfCExW4h2zfWeYCh4PIYyq4pzzfDbeKi0O6jZkellI=
X-Gm-Gg: AY/fxX4brli+9iRpjhdg3AYbauJC985MkbMisJBIug12DKz97ews8qKJcacHfgcr40X
	mjFgt8KuobDZQBBjmG4JPz9QRDfooOO1vLnRwk2rrwB4O8iWBH/0BZ953nPjMHeIF/bW+NGOrui
	ViAesLPgRIESsKlgrMZh5qeLX6UG3hD74e5nNIQldzgDVYHRGjrSDGaem+RgLtld8tuP++izodk
	vxaSt8kM/2u1yZKHuo+NTl4lbGkvXIt4oKWS1hNBPX7x0LZ6uQCL6AuoTQ1LrLe8KMhkGceGATF
	A5u95N5Hnji/469Rd4w6adYdUBnFwD/m+LxT/pIldfES66r/qPriQQwuqDXBkDPp5da3xqhHbRt
	MP74yOOJ/O4Dquw1gSuQo/Y/Hf68NwCAr1v5dvLjgtNYhN4c3AjolIOe4aAGC4xBZrkEVWIecgJ
	v35w==
X-Google-Smtp-Source: AGHT+IHY7NQknvOmV9bLxVz7dTnEjqdLKDpwYX1JJB9eQfKUuNEJjCFIN/0JIzGRucK4wgXDThpJ9Q==
X-Received: by 2002:a17:907:a4a:b0:b79:c879:fe71 with SMTP id a640c23a62f3a-b84451e156bmr1964823966b.19.1768307583834;
        Tue, 13 Jan 2026 04:33:03 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:1cb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872152ee10sm497403166b.34.2026.01.13.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:33:03 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Michael Chan <michael.chan@broadcom.com>,
  Pavan Chebbi <pavan.chebbi@broadcom.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Tony Nguyen <anthony.l.nguyen@intel.com>,
  Przemek Kitszel <przemyslaw.kitszel@intel.com>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Leon Romanovsky <leon@kernel.org>,  Tariq Toukan
 <tariqt@nvidia.com>,  Mark Bloch <mbloch@nvidia.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
In-Reply-To: <20260112190856.3ff91f8d@kernel.org> (Jakub Kicinski's message of
	"Mon, 12 Jan 2026 19:08:56 -0800")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org>
Date: Tue, 13 Jan 2026 13:33:02 +0100
Message-ID: <87bjixwv41.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 07:08 PM -08, Jakub Kicinski wrote:
> On Sat, 10 Jan 2026 22:05:14 +0100 Jakub Sitnicki wrote:
>> This series is split out of [1] following discussion with Jakub.
>>=20
>> To copy XDP metadata into an skb extension when skb_metadata_set() is
>> called, we need to locate the metadata contents.
>
> "When skb_metadata_set() is called"? I think that may cause perf
> regressions unless we merge major optimizations at the same time?
> Should we defer touching the drivers until we have a PoC and some
> idea whether allocating the extension right away is manageable or=20
> we are better off doing it via a kfunc in TC (after GRO)?
> To be clear putting the metadata in an extension right away would
> indeed be much cleaner, just not sure how much of the perf hit we=20
> can optimize away..

Good point. I'm hoping we don't have to allocate from
skb_metadata_set(), which does sound prohibitively expensive. Instead
we'd allocate the extension together with the skb if we know upfront
that metadata will be used.

Things took an unexpected turn and I'm figuring this out as I go.
Please bear with me :-)

Here are my thoughts:
=20
1) The driver changes do clean up the interface, but you're right that
   it's premature churn if the approach changes. If the skb extension
   approach doesn't pan out, we're ready to fall back to headroom-based
   storage.
=20
2) How do we handle CONFIG_SKB_EXTENSIONS=3Dn? Without extensions,
   reliable metadata access after L2 encap/decap would require patching
   skb_push/pull call sites=E2=80=94or we declare the feature unsupported
   without CONFIG_SKB_EXTENSIONS=3Dy.

3) When skb extensions are enabled, asking users to attach TC BPF progs
   to call a kfunc to all devices the skb goes through before L2
   encap/decap is impractical. The extension alloc/move needs to be
   baked into the stack.
=20
I'll focus on getting a PoC together next. Stay tuned.
=20
Thanks,
-jkbs

