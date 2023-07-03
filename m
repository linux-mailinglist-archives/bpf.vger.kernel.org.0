Return-Path: <bpf+bounces-3862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75A745968
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 11:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A51C208FE
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BC443B;
	Mon,  3 Jul 2023 09:54:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9E4430
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 09:54:44 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878304ECF
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 02:54:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98e109525d6so767918966b.0
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688377994; x=1690969994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iGJp3Y6rXle8uuZs1n28iqn7SIORXWqojx1agj3edY=;
        b=bphMktEdQ7kRVbqtpfQc9RhJUAIleyS9jzfQeitBsbWpVglcgIukNLf9QojsnXBl7Y
         7eSdQy3YQHS1OPoADbZmcuSsaRZk5STkaHKVeeDw93oo9EAUhXR/se9R2HA9zB8B1VDE
         Le4q6+XaE3HFMyVECQlhecyHDUQuiUUPLRD7mp5u6Bxo+6wHggU+aOaulkVVtGAp76P0
         8JohFw9mCyGO+KeT4U2cyNE33w6VinERfsudUV3K+H2VQIHfmayxDP6tk371iFBFPODB
         21ChH2nQM3TqMuFdKHgponFeeppDmhBjYU6CKFWh8OrHzAE35TxFrdfoPBcyBpQ5hdzP
         +S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377994; x=1690969994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iGJp3Y6rXle8uuZs1n28iqn7SIORXWqojx1agj3edY=;
        b=CVNU0F0JivP8pGQnX51sBhj1D6jbkm+Wi2qCLz5LuEJ2Nj8ftdki4X9SOcPUHJxT9G
         cxEDGdfHBAk0RL/WT5nQriryfeQ9N5x5ovANaHpAlPjlTLMCvrtxg8SU8wHTu4zT37ry
         PsDBCEtWrS/B9YFLIuZlXuVWaO3sGz3aNL3ohYVR0PDbXqand512Rykf7Dtt1oywrG0I
         OTb4cNuZ0vaajOK09bTfaq0e3vx1Ny1GpyGUjNliMPfTiFO2q5vlzMui/xs9if/7wL6q
         OTokI1DvMp6CG6bmkMNCHmkhajrC0bWEKueQVaneLKHXgDvQntyxB5sqFaKEilyZdr9n
         EjQg==
X-Gm-Message-State: AC+VfDx+BzOs04W2d3VXEn33wpqm898Ccg8AxIj0lyBHzCIS7a7bcGpa
	O3Kr0d0rwf4dF+s3zM6nC8SIhuMCqBclMzESVKEZQw==
X-Google-Smtp-Source: ACHHUZ7bIeou5Mbf5sQ4AuXdSmgs0EUefiJOjBpKJhnQ5LCHfzQaSsQLVcAmXDOIi1h+QBWptSoHuOL31iaBYoluKuQ=
X-Received: by 2002:a17:907:720c:b0:988:565f:bf46 with SMTP id
 dr12-20020a170907720c00b00988565fbf46mr10110365ejc.32.1688377994535; Mon, 03
 Jul 2023 02:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613-so-reuseport-v4-6-4ece76708bba@isovalent.com> <20230628185006.76632-1-kuniyu@amazon.com>
In-Reply-To: <20230628185006.76632-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 3 Jul 2023 10:53:03 +0100
Message-ID: <CAN+4W8iktigV4j3t11HiVoo1BLW4r0UsDv+adaE_OZp_bemkOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/7] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, joe@cilium.io, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 7:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:

> > +     } else {
> > +             return sk;
> > +     }
> > +
> > +     reuse_sk =3D inet6_lookup_reuseport(net, sk, skb, doff,
> > +                                       saddr, sport, daddr, ntohs(dpor=
t),
> > +                                       ehashfn);
> > +     if (!reuse_sk || reuse_sk =3D=3D sk)
>
> nit: compiler might have optimised though, given here is the fast path,
> we can save reuse_sk =3D=3D sk check.

Ack.

