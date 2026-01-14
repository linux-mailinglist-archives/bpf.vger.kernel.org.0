Return-Path: <bpf+bounces-78874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702DD1E81D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDDD230C1B4E
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540C395DB1;
	Wed, 14 Jan 2026 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpRB2zxe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVI6bK2+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5434A797
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390745; cv=none; b=fnVLSIjflnnIVTHbKUUdMPcDsSv/yYBUPeYJmTfjpC52rI+yr/itzF5bVXyQJoGow7p6RemNQb8fzv6Ed24ROvbJIpa70z9HlipSOLiK0CCi0ZXjuu6JVptSQsffzmZu5HRWdR+RQKdtK5NZmJmdtM4G4Pc8WgSZ9KipVeZzeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390745; c=relaxed/simple;
	bh=neLz2vil6IOQSSPgC08IfhmglUGv7J3nJx9uQlZaosM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mjf2G8q5o7jv4DFr33ZfLMFA9YjfJOL3bEH/aCnDCCIjYUuWaJPHgohzxhZyFo7EtOmMBwrZDTqfqVJkKs6ddcNsAAuhjQi0kvIXII9CRk186Gn37iP1/YB1/oYWR1Mrpw/Y0sfCKRPMeZQ0mqxLgs42QbuBKg3z1rLvJZsPZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpRB2zxe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVI6bK2+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768390742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neLz2vil6IOQSSPgC08IfhmglUGv7J3nJx9uQlZaosM=;
	b=cpRB2zxeOVjbia4qVAtvnUj1oPPGvGZEqluitrbKVBftlfjFBFgmBSddMjEWs+RU9eepup
	hghAyMsKbuAPczkC55VNuBe7PBty5RByRHqZIwmEMVHPH3CCpZ8x3mSWsxKZ7t3HW/ySlO
	uVP/wNu6KbspdVvBn/Vd4vkFsAgp/sA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-k5hrJ5MZNdmNbg-trH5PKA-1; Wed, 14 Jan 2026 06:39:01 -0500
X-MC-Unique: k5hrJ5MZNdmNbg-trH5PKA-1
X-Mimecast-MFC-AGG-ID: k5hrJ5MZNdmNbg-trH5PKA_1768390740
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b871ea8299dso311583066b.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768390740; x=1768995540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neLz2vil6IOQSSPgC08IfhmglUGv7J3nJx9uQlZaosM=;
        b=MVI6bK2+0y/iGml0eyQRqyFMvmjHqHTOTtU5ny4NL+hHFZnvnV64FCprkOvBJzjnfP
         2CfUMrpWjsbTrXwU0fuCT7sHbqGD7rBOV/cHi4oIQuZr7CKUCHlGVq9u2m02hqJ9AFkQ
         +pBPkbTt+pykaQXnkMeu+A8C4dt8IdOyYbBELMW6kt9DNwv+qCZk2b+ae3ExCo946GLP
         ojylqVqJ6mMt5hEvpi0CDdwHk8aZ9PzSlX4aJ8f1L7XqO/apjbIaWpLZUWKzmpv+rIqa
         WUhQEAaLrrkEBF8tQFsZ4Pc46+WmfJlAQf7ZvTw4HP6GtNUUooKgGvjCBRlHyWBme5po
         D42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390740; x=1768995540;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=neLz2vil6IOQSSPgC08IfhmglUGv7J3nJx9uQlZaosM=;
        b=jgrhr+ZxHFr9eB/mr9b8gm2unNHFD91toqPPnGvuGYt3aMnSGGkiDPs2uV9riMmpEc
         LiJ2GqNOFc1AeUzznl/VitBKWEcrMRTlWFPFqcwelmNfIMJUIRgNnZ7pHLiD+VwXLTi+
         MgQEac987jjn3jJQw+3sqY4ue1GzTMFMxAdu6NKR+yu8l8pHjQAI4nMDfE28C5Y89FUN
         vm7/cW+CjK3Iaws6CcsRCDXz/pSiF/QtB/oHxXByCW6KiKrfo/QRqcdsT2Kn1GRn68RE
         qvvsQkxA+0cj3jzCnBaha6/bNi0Y+tu/rLtPK1f9nNOv6hobwnwJQu/8r0OQzLg0+c8j
         bvcA==
X-Gm-Message-State: AOJu0Yw+6gHtAUSx9isbWR7bujZTjqoZltUm2L/TGbeQ5Uyb8qefRZet
	yToNiAYh+N7ODd9QYPtHWHD+enz5vJMlDFzpsrXsoWQfI9SaR/45ta/+zEZQGg9gG2eSt+oNUn0
	xqs9aj/u5gW9a5pSsKSkUVbdwg98AJO5FRL1VxkLNKQdRk/Zfjs71EA==
X-Gm-Gg: AY/fxX5PX9fH1fc1gC3EvjPEZQHI4xnbWKerMRMolf9iribHwC9sUHYh9A9fsFfnli1
	2uW4/IKgQgw+QSpyzcioMl/+uxDkFW9ocL+P8EmisIy9QErbjWUHtOftrMb4ce6fknpAuK+lNeg
	g/NMeKjkzSxKfryRNbqzoUukwwbk8pOAsyWTS2Ax4Dps711er7G6h/Dex43nzy0+K2cTzRPypYZ
	mj+iSxgncu32Co8zdf2RaayKcdhSHBSiu/2gDuKBGEbduqGeUFCJFWuVkmrw2mQJ0thsSUWH+A/
	FKR3GuAs/Pp2UTOWwsrIJ+v6q2y96JcUY9hYjvWs+tOdF2kRxj83QD8M2vv09IwrrAaET5bjYU+
	i0rzkbvdFqmYq8O/9vP0IqFIjucX2dRfQ3g==
X-Received: by 2002:a17:907:d16:b0:b86:f558:ecaa with SMTP id a640c23a62f3a-b87676caa70mr149166266b.27.1768390740404;
        Wed, 14 Jan 2026 03:39:00 -0800 (PST)
X-Received: by 2002:a17:907:d16:b0:b86:f558:ecaa with SMTP id a640c23a62f3a-b87676caa70mr149162866b.27.1768390739898;
        Wed, 14 Jan 2026 03:38:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b871081b04bsm978445666b.53.2026.01.14.03.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:38:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6D7E8408B69; Wed, 14 Jan 2026 12:38:56 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, netdev@vger.kernel.org, Jesper Dangaard Brouer
 <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
In-Reply-To: <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk>
 <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Jan 2026 12:38:56 +0100
Message-ID: <87bjiw1l0v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com> writes:

> Sorry. I did not know it as this is my first time contribution, and
> did not check it.
>
> What about introducing a structured metadata extension area between
> xdp_frame and BPF metadata in packet headroom?
>
> Below is the example memory layout:
> Current (after redirect):
> [xdp_frame 32B][BPF metadata][unused headroom][data]=E2=86=92
>
> Proposed:
> [xdp_frame 32B][kernel_metadata 48B][BPF metadata][unused headroom][data]=
=E2=86=92
>
> But, the problem that comes to my mind while thinking about this
> solution is that
> additional 48 bytes of headroom beyond the 32-byte xdp_frame would be con=
sumed.
> WDYT?

Yeah, this has been discussed as well :)

See:
https://netdevconf.info/0x19/sessions/talk/traits-rich-packet-metadata.html

Which has since evolved a bit to these series:

https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-=
a21e679b5afa@cloudflare.com

https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls-v1=
-0-1047878ed1b0@cloudflare.com

(Also, please don't top-post on the mailing lists)

-Toke


