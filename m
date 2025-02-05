Return-Path: <bpf+bounces-50474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D093A281A7
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 03:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3103A3D98
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5547A78F4C;
	Wed,  5 Feb 2025 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVm12PgV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540625A65D;
	Wed,  5 Feb 2025 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738721749; cv=none; b=sXO6bVLdG93hr05CnJdFuAo2tVXgAoTO6FMQ27XW6zZvLBt6TyTd6kdrmjFptq4sPq7zunaVNbwWEq/agtj7U557d/REq6zzv4dqNCCcL27tPBZC6rCTX2nm048OgxRwodgywtRpICCZSMRFZrNxSN+kIX6ermvdQtjYG1BH4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738721749; c=relaxed/simple;
	bh=x2tEdem3Ik17OkInIJFc4iTU2q7reVcy30KddYOnshM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhG0bLuMtq9sJzOWKxyg4Q1p6eBj4PJfVY4iwxj7UqR9Fas+JVMzUVUxdSRd+vj8y77x2qQ+GeoVaMh059S4czBEBvGwoVbj0oHunkchMqm2oNmm1M05ZO9M60nfAhYx6XtGQUvfgtXfVINr/Fco656Ic8mhb3EdjHLZpa7vWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVm12PgV; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d0521f966aso239485ab.2;
        Tue, 04 Feb 2025 18:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738721747; x=1739326547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scZducT+gjUFCl8qT4T5qYdPVEFyUKIYp2avv5H+gQI=;
        b=YVm12PgVXONR8J0ysi5qfuFp70kceiPcSW7SK0XFUXeCEoyq9h92yuOMP+/x5yS96I
         aT9Wl76FKJb2PEVYGXQr/cFwNn9zcdUfRA87f+epXfqrzR9S+dNkio2Ua9sPNzA2FRjS
         fr3WA2wOFyVLjmqxtLFkfg+IIJvS0nePq9sjobfHZGwTyEVyl6dREaDoG3YSoQ13Q0bL
         Lzwy8u+vZS2TWKL/PlTeEQpXfzoirqyZR2BgP77rv4Z2zo3B/MJBe8Czb8lcewkn6tYR
         JnPAsR97IEsAVvT4DStuzTUGGTZOVVl3uXrttTCB0kpWA38CV1FSgmIbTJ3hBO6uhqSa
         ZZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738721747; x=1739326547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scZducT+gjUFCl8qT4T5qYdPVEFyUKIYp2avv5H+gQI=;
        b=R+LMG4YMuk+7jIbS1UeQUIaLhPmsCfLBbL5cbhnozoS/LSXAkCiYEDayzTteiDDS/L
         unFY3ehaHTBeNWwR+Y4UjRwYtUoWGezCAXWErNMhv5Co45oXOZndLrIwYjkFE87EY1z8
         yjXxN8zac4cXAlFFL7efnbPHc759L1L5D9f9adOS5KHTTsj9MMYH0OZd1gRbWzjkiKAf
         ilO4UWWJCrxLPi1DM/yd1G39OZ9MYWt1ayJ3dmsFO4GcPbeiL6ayH+AM1k/ol2n+vx8I
         9vciKUr/AgalCxgvGiQCVN2LYn4DJDvOgJ7yDc1SOhpy4oTe2aTPY+9FRJ1gEbg6euNN
         Lm8A==
X-Forwarded-Encrypted: i=1; AJvYcCV7qv10Ibva3ArhKCbG+B+Sa6WHNPJfKqUCrlqtZQlN7BScQ3/gU+oBFfKbnpWTptajOThtbl1k@vger.kernel.org, AJvYcCWqICE0PF3GOPdfT4GyrGOgJQwr0suiitYvB1KA2CrIY5sOZhQkZ08bHY7Izi6ogRnDyUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFEU7+wbiQFXd9s3i7BB/zUERqpwB9PqjIhZGIIhMRti00qL9L
	Z0fAQZO8xTQ7r1Vdy7At5ZNn4ak0YjssQpNxkUEZGu3ObTOhBLmyi4mZrgiqmn3zZf2XqtQtvIr
	2KfVjmpkm2KelR3s4bxSdkvU9y68=
X-Gm-Gg: ASbGncuCG4fZ/06Z+Zhd1QC0uM5PB+oGWnQzff3n0vweRPMi1AP+GHD1RBLzMM4lGiw
	t4WohHuDPy8I105tn9gpqOgtuIXY4NiANaHFoDJNTMe4x3DtMDRzbpcstkwaKV3Wa8SAwOHlz
X-Google-Smtp-Source: AGHT+IGxCUN01/sX53kpbs5420ur3pDVOcBg5iGT0cHETwPyy0P7pIDIcuV5QYOdlpoE5ouq9fcszjuZF3VbYXCN2h4=
X-Received: by 2002:a05:6e02:348d:b0:3d0:1101:9d07 with SMTP id
 e9e14a558f8ab-3d04f45d6b1mr11154915ab.10.1738721747203; Tue, 04 Feb 2025
 18:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com> <20250204175744.3f92c33e@kernel.org>
In-Reply-To: <20250204175744.3f92c33e@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 10:15:11 +0800
X-Gm-Features: AWEUYZlwzd5dAZZz-IndkAF5WiXXnavuG_TDBdFKn_5-HxSTnhHgP6KhTriZgCc
Message-ID: <CAL+tcoAXn7hct4HjU2QpTkPJohCdTH4eqH0AwAj54fqxXLrqsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 9:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
> > +     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> > +             struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > +             struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> > +
> > +             tcb->txstamp_ack_bpf =3D 1;
> > +             shinfo->tx_flags |=3D SKBTX_BPF;
> > +             shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> > +     }
>
> If BPF program is attached we'll timestamp all skbs? Am I reading this
> right?

For now, not really because tcp_tx_timestamp() gets called only when
dealing with the last part of this sendmsg(). So not all the skbs will
be traced.

>
> Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whether it's
> interested in tracing current packet all the way thru the stack?

This flag is mainly used to correlate the sendmsg timestamp with
corresponding tskey, or else the skb travers the qdisc layer without
knowing how to match its sendmsg.

Thanks,
Jason

