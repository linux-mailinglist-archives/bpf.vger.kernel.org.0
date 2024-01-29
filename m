Return-Path: <bpf+bounces-20576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAA584060C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68514286D25
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F652627FE;
	Mon, 29 Jan 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anHH/X2R"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF130633E1
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533524; cv=none; b=sXl0H8z7v+kIgVbNXbpl5+sEblxpHXGTI97hBla7Q/bF20tSWZe9IxC4bQCEnj9RGzlkccKW0+dV3StRyYqAbzjkgrF67KsOJ6skFz8lrgcm6EnlM+fyW9XFz4FWLVU6saV4EbBaydUflXu1q/wD4GOMrUOFs+KwJHlwbMl47RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533524; c=relaxed/simple;
	bh=jhSXJBAa4IAI3G0hqBJhMzYpQuBKW9LSRNp5pHW1sMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYyNyAQNbzkQO28QfdxileyOHklQqmWua85Fpe8KOeOJFSHwbwJ9WCMmOA2gFWskkRlFSAEaEVmcCuuO5tvqtQDiE3s7XtsZLTRWvIQqJIxhyik1TXfahLnXbRfgOM7yeFlZZrwpCo5fwInQ1aYLpSRzv76IcAp+kidrFdU4z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anHH/X2R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706533521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhSXJBAa4IAI3G0hqBJhMzYpQuBKW9LSRNp5pHW1sMw=;
	b=anHH/X2R6zypXx4Hh4eREXzPMR+WrYLnx/7r/ale4SlEUkJxwelFfCQ0YXMsix+pHzSNKw
	kwGifTjGGVmGeFWpJ97wt2mGXxdMNoeYqSkgr1R3uRhOrpBKTYy2DTmUQmuvSNdITSQCb2
	wdfWOiwLOAhzt4SWFTSYw7UjHabBjog=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-VJ04MFEgPS-DzSP2jFxbyA-1; Mon, 29 Jan 2024 08:05:17 -0500
X-MC-Unique: VJ04MFEgPS-DzSP2jFxbyA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e49906305so23606335e9.2
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 05:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533516; x=1707138316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhSXJBAa4IAI3G0hqBJhMzYpQuBKW9LSRNp5pHW1sMw=;
        b=tfw1DwX649hnJbBFNnV8UUHgqRw9eqY46GM/J4FnKpxNpdvys+X4Im/dqiaLWoB1mb
         7Dlj7lj8BTLCUw3UGKYkKVz+FvVtIZp9CW9Wx5y/QTJw+4LrC5cq3HLJHUOgZuE0XJzO
         UxszRmfuJ8LADqftPwGpjoVPLZJG7iHHXAwNkqVaK0vkqQ57WJJD5ZxhuTQywD+iZIze
         xes8lvz5AuLbxik3DXcTG9v4MgIQm/txEhhetT83V0RsDIKkp5vnrmjLgE1ZIpS3bY/R
         AM8AvqUttP5eiSvIwxBxkk1/BGVvfgjiybtf+JGIi8dBobdPr0CAHaTOOyp6UgjRq0ku
         dkkA==
X-Gm-Message-State: AOJu0YxcrJg7jjUmbwr6zxx7F8BvIBJAxa/fVGCFGaWenO5Z3D86ASIw
	8bQOgl08sr9nVeoJ8xjG45UPu62CPUvtw/zRKB+qYMEFO1cj5IYBfvokYJu9jJ8GJnazPR/zKK/
	BRZjLxQ+8cpQ2HygzfWyzxq2K7rktqJpFGjd/tZV8survAHdySQ==
X-Received: by 2002:adf:ea51:0:b0:33a:e89f:1dc5 with SMTP id j17-20020adfea51000000b0033ae89f1dc5mr2668848wrn.23.1706533516577;
        Mon, 29 Jan 2024 05:05:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU83hZ2kx/bGUSTN6uw3JgXRUj/C6gYltlkxClcBEqa8p9rlT/xqzClncFGJThJD88kRnF0w==
X-Received: by 2002:adf:ea51:0:b0:33a:e89f:1dc5 with SMTP id j17-20020adfea51000000b0033ae89f1dc5mr2668828wrn.23.1706533516337;
        Mon, 29 Jan 2024 05:05:16 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b00337d980a68asm5721310wrv.106.2024.01.29.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:05:15 -0800 (PST)
Date: Mon, 29 Jan 2024 14:05:14 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 0/5] add multi-buff support for xdp running
 in generic mode
Message-ID: <ZbeiijYT0ZodYq4p@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <87msso1f9e.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QapcWhyXNDEADOc1"
Content-Disposition: inline
In-Reply-To: <87msso1f9e.fsf@toke.dk>


--QapcWhyXNDEADOc1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Introduce multi-buffer support for xdp running in generic mode not alwa=
ys
> > linearizing the skb in netif_receive_generic_xdp routine.
> > Introduce page_pool in softnet_data structure
>=20
> This last line is not accurate anymore... :)

ack, I just copied it from v5. I will fix it.

Regards,
Lorenzo

>=20
> -Toke
>=20

--QapcWhyXNDEADOc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbeiigAKCRA6cBh0uS2t
rLRSAQDLhngsfTJ/SkubtC4AZWQp8GJbJge2crWzr7Bday/t1AD/Z7x2KgJQgCnx
R3gJ2Z0WLiPby+RIC7SQmLmT9l/YXQ8=
=aIyH
-----END PGP SIGNATURE-----

--QapcWhyXNDEADOc1--


