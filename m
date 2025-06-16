Return-Path: <bpf+bounces-60707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D3ADAF19
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 13:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE3B3A3670
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98BE2E92B9;
	Mon, 16 Jun 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBWQf6eH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC92E337C
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074704; cv=none; b=OTdxOkkTuJEL7auERohB9Ayx2nSHw8+Bad8jYNDWL20tMmpUYcFzPxy4WMCtDn/2srv8KavpFSAlmjeW3qqi23Flu6X2W/I1VP7JFToIpVLMFWrgOvvXB56qBz/NjwcOpKQnHaqCPbEfGz6cdJcAA5dLz5EIY2ZkSApQqgrrjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074704; c=relaxed/simple;
	bh=recUC0kFFnGzEdaWQH7H0BilUe9FaISxYjWJllf5NjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uqTmuyg4vl+G/GY2FGwp+glTNQysJwnDUKmrU3ariMqbNUgzbjv9eeoFHKzQfObqyfeyOuqI2V2aVmEt5K5+jMipSe1Ysw8zk9EjxA/wiNQcUszuqo9SZ23JyvepbTe12c6gCT/aPUeiV4hNtZ+986NA0jqB/uYEFJKNjg+4z1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBWQf6eH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750074699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=recUC0kFFnGzEdaWQH7H0BilUe9FaISxYjWJllf5NjY=;
	b=VBWQf6eHcVydY/eOFX6n/21wDk2w+RchqqaQ18gmC2MilqbQ3c1IFQR2n9xD09l9bpYxWl
	AAjVKcaBENb0KYk2Dcy1iSt0Tx2NXvl1DT3fVfGvrEzECdW5YLIy55pOrtTIc+1EYUThKy
	pnQx8OWUEAGKLcR/Xc3lJtAQh0cZJ7M=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-pMwslcpeM8SG0E9u1dw0Tw-1; Mon, 16 Jun 2025 07:51:37 -0400
X-MC-Unique: pMwslcpeM8SG0E9u1dw0Tw-1
X-Mimecast-MFC-AGG-ID: pMwslcpeM8SG0E9u1dw0Tw_1750074696
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-553af33d98aso1917958e87.1
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 04:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750074696; x=1750679496;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=recUC0kFFnGzEdaWQH7H0BilUe9FaISxYjWJllf5NjY=;
        b=Lf6G5CMnlJNS5njuJ3jvTwk0phaVLPqCTiYo4hdr+JKmx4IGjwFWKoWEg6G3jFKA4J
         pKyWpR+ol9jFNVR94EK120TPW6kFUjluW5P1+hNr00bJ41L0xPRoGRvtC5+s2KKp/q7+
         +zVZVpXIzeyyFqP0VjgTQy93GdxP6USBy1+6ZuU+JCCQ5v5o3jvM9CMnAv/Qxf76CSUh
         IPbFaSc0/2L4bggwTplZ5i2Z56lk91XFibkN+RIRYSbWqKeCrLmHltURLV01TmDzcFEk
         QpwsKRQxN1hws9789VoJP2mbYjzitvvTDusXouWH6kcquBFmGNUmV6PP4woTRoqQDQX9
         BV1g==
X-Gm-Message-State: AOJu0YxQMncCEVfl+NMTjcAjO7jQr8WDSlb2VOX4eFpPRey9dWVzOzEy
	O5B4aaaqnDjttNfjmnSyz+LMF0xSkZoCgJ9DtSWA6r/O5rp7f83DMm/VsaZtDd0qeidWg91PPZO
	hn1q6QN1ZBg3U7HHcUKoNeFMUEcU4K2LegN34nwprmzuUh8FxnFipWQ==
X-Gm-Gg: ASbGncvVX4n6HyxnEA1WZbAgeVc9/o6E2Nuin26r05NZ1IHr26plUvsi7XYNKa5A0rH
	rQf9HlJ4Wd6RnOrK7wqgkHugJk5Afa/uiokT6zklL8BsM+5w1OVHVg7wrBr+5i3dstYIVVftBdu
	4qR+rWShmByRuL6Pjvz8UxYcHo+M+eBY41DurkBrJoDyLsSutuUeByoWxBSndRYwV3WgtugivZ0
	26vSa2F8vmckI/dDduUE4TUe4s08sMTSlmZZWdRc4Ne75ERc4G6dZ7ilHcarXHodUp7ie+QelJG
	I+waJEs0FjV4cHLI+I4=
X-Received: by 2002:a05:6512:e9d:b0:553:b054:f4ba with SMTP id 2adb3069b0e04-553b682f08dmr2304070e87.12.1750074696114;
        Mon, 16 Jun 2025 04:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq1zDdCtdfik3lRAowzxz5xWaAFhlaXBXpx5e4xCVEJd3HNErL6veyBK7eMHOuxk7R+o8hsw==
X-Received: by 2002:a05:6512:e9d:b0:553:b054:f4ba with SMTP id 2adb3069b0e04-553b682f08dmr2304056e87.12.1750074695677;
        Mon, 16 Jun 2025 04:51:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac135c22sm1526086e87.65.2025.06.16.04.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 04:51:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4D6F31AF7026; Mon, 16 Jun 2025 13:51:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev
 <stfomichev@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, lorenzo@kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, sdf@fomichev.me, kernel-team@cloudflare.com,
 arthur@arthurfabre.com, jakub@cloudflare.com, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
In-Reply-To: <75b370cb-222c-411a-a961-d99a6c9dabe0@iogearbox.net>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk>
 <75b370cb-222c-411a-a961-d99a6c9dabe0@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 16 Jun 2025 13:51:31 +0200
Message-ID: <87zfe7lxa4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 6/10/25 10:12 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
> [...]
>>> Also, have you thought about taking the opportunity to generalize the e=
xisting
>>> struct xsk_tx_metadata? It would be nice to actually use the same/simil=
ar struct
>>> for RX and TX, similarly as done in struct virtio_net_hdr. Such that we=
 have
>>> XDP_{RX,TX}_METADATA and XDP_{RX,TX}MD_FLAGS_* to describe what meta da=
ta we
>>> have and from a developer PoV this will be a nicely consistent API in X=
DP. Then
>>> you could store at the right location in the meta data region just with
>>> bpf_xdp_metadata_* kfuncs (and/or plain BPF code) and finally set XDP_R=
X_METADATA
>>> indicator bit.
>>=20
>> Wouldn't this make the whole thing (effectively) UAPI?
>
> I'm not sure I follow, we already have this in place for the meta data
> region in AF_XDP, this would extend the scope to RX as well, so there
> would be a similar 'look and feel' in that sense it is already a
> developer API which is used.

Right, but with this series, the format of struct xdp_rx_meta is
internal kernel API that we can change whenever we want. Whereas
exposing it to AF_XDP would make it an UAPI contract, no? IIRC, the
whole point of using kfuncs to extract the metadata from the drivers was
to avoid defining a UAPI format. This does make things a bit more
cumbersome for AF_XDP, but if we are going to expose a struct format for
this we might as well get rid of the whole kfunc machinery just have the
drivers populate the struct before executing XDP?

Or am I misunderstanding what you're proposing?

-Toke


