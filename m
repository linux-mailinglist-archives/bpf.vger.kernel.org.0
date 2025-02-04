Return-Path: <bpf+bounces-50354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAADA269CC
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A2C1885531
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503813635C;
	Tue,  4 Feb 2025 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENNUWW25"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509788634D;
	Tue,  4 Feb 2025 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738632396; cv=none; b=a9jVEaK+trIg1qt8bWbONQB51+HmiaaPEt5dIlZJ3DuK5FmZ+V29oAEe3wY6zjdQA25EbmdREq9uclr+cjZpDsynN6yZtTYpMG0RCV5ibnZYMOEZfBrfoKpmDxrw7qwnI1T2aTj1LmUkn3HMce3VnhCx9mUAxUIaA5kal8TgCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738632396; c=relaxed/simple;
	bh=tdi8cIM2nYVlUwzENNMjTtNR4PGh3DXhggQp5vrm9nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnuoXCMg2iOUVHmhISTfDy4+pPa+7Gjb/Jw46ag1YXNSVpM24crEfd5F7Sn5y63y4denHe8AX6rEk4aRBOzwR+TT8PNfPJafXfsxWvQ/GHdc8pL2B0GkutACRearf3QH8ibSm1kx5+qOM6U3rEs652n7IFtHT6GNBwh477EAGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENNUWW25; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so34169345ab.0;
        Mon, 03 Feb 2025 17:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738632394; x=1739237194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xEuU3f51uBZuOrVvy4eNNgJpherNRZNlPEuceK9wHE=;
        b=ENNUWW25K/4tB5xowmyE5zb7/vALC8d4Lpw00unpMfvCZ+v3gela1ymMIQxAHmXjDE
         TeMOkjejuLA4+Nx/q1eLowgJ5xZwx9Vff/0gR00wcSvQwK+H51TP6HGM4OxUGPVQbtCz
         0g7JUE6XnmBdgKPKAQfxZTEUl1HxqeK1R8EDx4rRMMHl81qSgMP0lsetKQ+7vGrbXU/r
         k6NBqs86JWUm8Auso78WHMqV4lF13UT+zji9gRDCg0aniRThFF7QyxNGOK/Pcp78GBBf
         USI41J3Qs0eTJ1wiwOMhIvdTXmbPtFPVgImeOQF9Krf/BPCQFWquZEYjtE30eRjEfbIX
         PSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738632394; x=1739237194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xEuU3f51uBZuOrVvy4eNNgJpherNRZNlPEuceK9wHE=;
        b=ebi/LvPeGRuOLhk9RAun7GWl9AbjdJKpHq3AnEQSy7Z1pQTmtZ7UhoxUATlf4KAXB1
         lar8ypcGsHJAtT1CNQZ0SDHt7/xyEvgVTYbQYg+H9155YI3I8AiU5nYNC8vnyFsmOTgM
         KEl/i16XpaQGyGUzp+25BedqGAL9crcMfJ13fTQH9HbhsdRBSCThN+wZmIRv1nwetq8L
         aU9Xx0VIkc5TFk+tPXK5p46BIYfuBXRwxm0IDo4a+7WOJeDZ1P9UQOrHqOawKqpMVg/Z
         UgJqI/bL4S8NXstlO+lzMQee2MVbIE9peOfug6J15Uho/9Phx49JxhLGNxVXaS4+u92I
         S4zg==
X-Forwarded-Encrypted: i=1; AJvYcCUWlSemdE7GEKC8aspdNVxB98YUSh5eDkw+GeVW2HSkwTtt6pTaIZS/gygT0bszAJg5ofl2Ekbh@vger.kernel.org, AJvYcCVc9MKfmkMW14DmYzP4U8MWydaCy2lyEcEqKvrvGAVMFbDcWUhqXFRRZHJ+a8h1l2X4TRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gzvIvMxyyfsG9rtVPr19NFneTsXf2MwVrW5gf4WPwtO1zUNv
	E5eQAgt53o6x7f9ovI/OiPM8ZKBaiPeXiCdX038a90riVEPgge/b13xNc9ucm6sQb6z43u4pr28
	lzeTn8FC9EGA61S3bAkBvtIenll+Wy8N2yBiJZw==
X-Gm-Gg: ASbGnctqCYgEo6Njzs4o+91YItjn3gDevbrdCW7I6jtfnNi2qev5LaCeiRMKH2pCWAP
	x2SuG7FE19sx7X8yHZuLIMV8EfuE0EyqxyVftLlBqirZp3SU0bUVvh/rsakzHXWC4WU4CjX0=
X-Google-Smtp-Source: AGHT+IEAm/4zv4OmXuRM39y1IFzLy94Wx/M5x3UfLUFD22lX1DHfZoyBhgsytnksRzzTLAdBOU1quaYlHUYrAIKB2Zc=
X-Received: by 2002:a05:6e02:98:b0:3cf:b2b0:5d35 with SMTP id
 e9e14a558f8ab-3cffe3e5d8emr227176585ab.7.1738632393935; Mon, 03 Feb 2025
 17:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-13-kerneljasonxing@gmail.com> <b02ff49f-4ffe-475d-ac5e-4fa0eb5919c1@linux.dev>
In-Reply-To: <b02ff49f-4ffe-475d-ac5e-4fa0eb5919c1@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Feb 2025 09:25:57 +0800
X-Gm-Features: AWEUYZkjjoozGwnQ0i5uHPg-mG7dbF1ySNRa6f9q9J5ZG9qz3ICsGsmzEVdGTb8
Message-ID: <CAL+tcoBRXtVGXJyOKTyoO0W6_o-x6b3jEkRi3DT-CUKmMtrBAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 12/13] net-timestamp: introduce cgroup lock to
 avoid affecting non-bpf cases
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:22=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 1/28/25 12:46 AM, Jason Xing wrote:
> > Introducing the lock to avoid affecting the applications which
>
> s/lock/static key/
>
> Unless it needs more static-key guards in the next re-spin, I would squas=
h this
> one liner with patch 10.

Got it. Will do that. Thanks.

>
> > are not using timestamping bpf feature.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   net/ipv4/tcp.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index b2f1fd216df1..a2ac57543b6d 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -493,7 +493,8 @@ static void tcp_tx_timestamp(struct sock *sk, struc=
t sockcm_cookie *sockc)
> >                       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len=
 - 1;
> >       }
> >
> > -     if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> > +     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> >               struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> >               struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> >
>

