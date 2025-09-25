Return-Path: <bpf+bounces-69705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F5B9ED67
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E06C3AF87E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E54A2F532B;
	Thu, 25 Sep 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="edjWrsJp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3714658D
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797899; cv=none; b=sSPUSYvMdmM3h4nG8u0/q2/O26NGpZ1th/XwpHJGAPZOeYQoqpaDCtqFZad4yALPN0/Xi9+Sa3emzC8nQfH9UZdocvEshcaBzv+kBD5bg/rroDlGCmqRdBZKNd5m03OCPNFit23HP2OcPpIzya27+9iCOToQqx9UWMDZH3DhyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797899; c=relaxed/simple;
	bh=goeEHV8pp0nSp3KK7+LsINEPmAxyg+E+nyBBoSFwzRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smZtPpTDp+w7Pif3I2U+HQpL93RLlXWW+qAYXdwGNuzeR04Qzvs/MIA3SezPUJkvTQdyjBpDFDPWJLP/SNxa+/Z0tDTwpRx1y/Ej5mypJPzDdhnrqNrmzWvPq/USjIvxLL9XlWTBtKCzLvp31fdV+7+xwW9P9NqAZKMJ9n49nKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=edjWrsJp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b04ba58a84fso140034966b.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758797896; x=1759402696; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoutmRJfBiooSSHCtQV7QJz0oS7nanw5QS3919xibtc=;
        b=edjWrsJpcWLUjAgftTi47573qE+Q2uX/ylea3V3EEONhCNHIf2DLvmZ8SvZQGb2KjT
         afCEBcg3p72MbxotM1nz9kMB5kI/42aQ+B7POIUtqbeopzcAHrHKT347OIMG6aetH/RZ
         XWOEOxsr+Ei3h6yBi6i5Amml64oj73cAtYwN5gI0NQPKDevh7WqD3ZRGlBW7cBiM5hAo
         mJs71VaPRjU5N3bal6U+XTCx8+Tt47G8QNWHMptXPSIVeFQradmAWPlhUaUh533GhGrH
         4mXKm3hk1g6BlfT/nJ77+7HTEWgSiKtd3QzRr1rPSpnMpAPGui+RFunYX5FHzElgO54A
         Vsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797896; x=1759402696;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoutmRJfBiooSSHCtQV7QJz0oS7nanw5QS3919xibtc=;
        b=su8xGtMFTKvgwVRjFBE9dRhfmvAbLAN+Q32w0M9UfROzJTBnGaMwVbAt77CTeNoI1k
         QQdeIY4LpDWqbg3OEigoEVeqdNGS16AMdfcFjnKF9looWWpfgDJiRjD+A9VnzSf/0kkr
         8GFUwVcGajfMCOzBKSAX4WefIRXAdFcVhFLvTmpOI5I9JezBUzhFjV5wPnbf5/F7ewYV
         8i/578ecNY3COFDFzf0aGwK7U2XhoTviaCb3G9o+nbY5Ke98R4SFRSqSqvWk9ToEGBC8
         GhI66epSd54a2wyfGB5NP2ELHlmIrSZgsUt/nsGO3OixjBOrxPPrjZvIwVsqyubWOKdc
         eH4g==
X-Forwarded-Encrypted: i=1; AJvYcCUhVY54pnRr+GVBqwumdOGcOYcJLct3Xrry8cHUVpP1JAz6y1Rp7wtgB3Rv8NdOdDIwyUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOE5q5KqJbRAr9pwILiuz3B/0aSkr7ZpBUMxAFUNUy0IPBnQdf
	OLgyOkC2zj55beNhhauQ50M4nIVAwFUVMVI7z6tU42UVbzYBEYEklbua1PKG5S31zQY=
X-Gm-Gg: ASbGncuZrcb/IixFedUAlOdgiaoSB6w/2q98otdhIketuwXmUVSrxoa3vHzJN6k2dI4
	KHDMlaf/EsnL2Vlo1HTFvzzM3bA8SPmm6nvBUFsx2nmvfZvhup832vWSbiUMUauXe1rnRhnBVha
	yoR8rFqDltc0wctdZYjgsy77IqaX3u4BTgNchqdjVAfpFPqu73xlWxpZo8Sb0bkSOkZyw7X9Pc2
	iX3K1/GuCCDZlUICYtUEmUrUScoHq+Q35un/ID0ZkUWtb24AtX4YEz81mzxLynZ6YukqHy3jL2S
	4H4mcGNBgHfiswDram1id9Y/u+zO7pA8n3oJCFVqJaYSqp/I5GEr+k/C7DuUMzTZ0EBXCsqfBW5
	GT2ySLQYFiRghBNA=
X-Google-Smtp-Source: AGHT+IEinH3OcipauCDmRqja5aQEPZ/J+HFOTVgp17H/W3ZS2eXjpFNwJ5ilU5Q4ue35F4Z7ahPnlw==
X-Received: by 2002:a17:907:3d90:b0:b10:3eb2:2074 with SMTP id a640c23a62f3a-b34baa34934mr375500866b.18.1758797896306;
        Thu, 25 Sep 2025 03:58:16 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa4c35sm143452466b.26.2025.09.25.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:58:15 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,  Jakub Kicinski
 <kuba@kernel.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Jesper Dangaard Brouer <hawk@kernel.org>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Alexander Lobakin
 <aleksander.lobakin@intel.com>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  intel-wired-lan@lists.osuosl.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW
 RX checsum in eBPF programs
In-Reply-To: <aNUb2rB8QAJj-aUX@lore-desk> (Lorenzo Bianconi's message of "Thu,
	25 Sep 2025 12:39:22 +0200")
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
	<87bjmy508n.fsf@cloudflare.com> <aNUb2rB8QAJj-aUX@lore-desk>
Date: Thu, 25 Sep 2025 12:58:14 +0200
Message-ID: <87tt0q3ik9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 12:39 PM +02, Lorenzo Bianconi wrote:
>> On Thu, Sep 25, 2025 at 11:30 AM +02, Lorenzo Bianconi wrote:
>> > Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
>> > RX cheksum results in the eBPF program binded to the NIC.
>> > Implement xmo_rx_checksum callback for veth and ice drivers.
>> 
>> What are going to do with HW RX checksum once XDP prog can access it?
>
> I guess there are multiple use-cases for bpf_xdp_metadata_rx_checksum()
> kfunc. The first the I have in mind is when packets are received by an af_xdp
> application. In this case I think we currently do not have any way to check if
> the packet checksum is correct, right?
> I think Jesper has other use-cases in mind, I will let him comment
> here.

Can you share more details on what the AF_XDP application would that
info?

Regarding the use cases that Jesper is trying to unlock, as things stand
we don't have a way, or an agreement on how to inject/propagate even the
already existing NIC hints back into the network stack.

Hence my question - why do we want to expose another NIC hint to XDP
that we can't consume in any useful way yet?

Shouldn't we first figure out how we're planning to re-inject that info
into the stack?

