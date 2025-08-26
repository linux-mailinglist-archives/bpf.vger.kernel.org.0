Return-Path: <bpf+bounces-66490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F65B35080
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E36D1A87B95
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1A257830;
	Tue, 26 Aug 2025 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6HWOrHs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756C239E9B;
	Tue, 26 Aug 2025 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169523; cv=none; b=a9HsoTLldoD7MT7uRB1yhe2i9pnrIHa5yKvx2tlzC18+NkX5uzVHCsZegZuxgMeSsaO9RGi/jDq5xoF4mz/ksgffgOBntx0gp2/ld+GD78i82sYvZShFpoq6yBMenuM7qZCrtBFfbMhbRbPbUjDK2jPLXs6hVSlELaR1Cf1aWxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169523; c=relaxed/simple;
	bh=AY/3qc6duOWO+wuq51Y9LVeB+srEpg+tuupMwtFG4CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Etsnh8e1q9OswQI12L96KAvt0lQbxF3W3uw9w++RMQI9RaDSj6hN8PgLmzfdcnl/egggSbIaIYUxaMdhT37cuK4MdSKpo2vZm1RMXgvbfi7UjhQSNIT1uM1QjyQFHHV5NHVjlDkwbgwFtfdz6reb3OeyQ+asrG+7K/9NN3/wp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6HWOrHs; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ee6485e7d7so5064155ab.3;
        Mon, 25 Aug 2025 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756169521; x=1756774321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SjzXmsoNG9tezThv2jXhDq+AS/yG0+qJZwh8uyk8D4=;
        b=f6HWOrHsOdHTVdQepvCIg/j75JPaI0x+87+SaXqVJNCnxYzgXOhDfu2IDfl/Ug9OU5
         am05j8ey9ndN+0f+aNYfiIlyEqGaD4k9KQEi1gbGx8cXK0WaaYb6Bh0SWdtwZquNxzRH
         y5Ot/UfscvV+/QYgZt2o+uJEd2+x050329ezOBMWHbPQaASQWO8KhF5V6Kimy096Us5E
         wHtc1CYESWR6luXJOUIMVqGTSjGqp1mpXDs6PcxAvCbvGNXl+28H0o2pWADH2eEKlCz0
         i28269pzyYZh2yLornsNlhsiya36k4i52RiC+RzAL+iZsJdd9paq2BYnJVsNBG+ZtqzV
         ajPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756169521; x=1756774321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SjzXmsoNG9tezThv2jXhDq+AS/yG0+qJZwh8uyk8D4=;
        b=HBovKdG7UTMSkVud1kqYGnr/KkvRxCSl2De0sIA7iyoQwBQwzkZrsjB4cOfFkQH2Ji
         KrH4/Fw2q0Dp2NOqDXy/mtkcKhdUoj8l0/R3NJcTI+rPcIYkp5D/KcvbzMbx2uF5EOY8
         kwELaQZ5ZFITWYgAcBIIlUIbYv2vZWHMwjER92VopqlNDfG4e7p6ZAQ7hm1figsQceY5
         /IEOwNi7+M7EVC+6YZME1kWjuePWQl8ye1hOS0hD+arzB4NsOQriSu3RXr+uXJE4pYne
         TuSHlQPtenoTCUGTIDPC/3qbRTVHAvMiEUxSGzHl+WOzG350dpngq7J++9vJgiyu6ZJv
         iEqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV02+cUD2FOEKzBu/UmvO1nrDdDXDINg/85NElZTvGqWvWT+jT9x7ny7YNlVrGWVkrhEtfWwFd7@vger.kernel.org, AJvYcCWXp9VimGDbplzrHRT9pr+JGC8KkuNLdnVi3n3J/8U26qo6nUIAkDXJpMKHaRgV/OhueC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0cf+iLeeb9218ZegxM5L9QzTmE60lqIFLPNCloi5hNdi2K05
	b9vVbwY/MSM7cvXY/S9vtud59pEUArE5003GXXC0NXLnboLHDVSLSAf9CdPA8XTmfeVOQEzarXg
	PWnsIzPMX2g40eDCq3DD2KzIpydR6KZE=
X-Gm-Gg: ASbGncuiZV+FlOuq9LM9+Sz6ysaV6+8USZd6bzFpznXDpt7RhpMFUrJ2rgnYS95BmHp
	Eea96m5pCzROiv+j4Mygu8G2A6XLkRVcSz/YMipS+wYL5cnzMAs+F1XNHDWCkCYoLLuox/raFte
	oDRhVos+5bNllaG3tacYEi5QA/UjklYFgNwZHdx8eLectCezR24DLr/yRqQCweytM1Y8xFEORoF
	bgb3w==
X-Google-Smtp-Source: AGHT+IFm6LjwOEbGNI66waAjKyiA0SM/Skiw3YWBHoGHcCGN48FjY6pwl/CYa0m+iMVLib0EAwEowKhV3KRHDfehLEM=
X-Received: by 2002:a05:6e02:18cf:b0:3e6:7df0:ec19 with SMTP id
 e9e14a558f8ab-3e9201f40afmr44543745ab.8.1756169521333; Mon, 25 Aug 2025
 17:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825104437.5349512c@kernel.org> <CAL+tcoCxzyBxhCes-4OfBAePpQK3jvSRSBufo0eu6afb4hdSaA@mail.gmail.com>
 <20250825172928.234fd75c@kernel.org>
In-Reply-To: <20250825172928.234fd75c@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Aug 2025 08:51:24 +0800
X-Gm-Features: Ac12FXx0c0QNcFelQ_ZqD84FYMUKpBt16D-434_JVWSl5UT361BtMNzzH9iPaQQ
Message-ID: <CAL+tcoCa3nfO+PJE-uccnOfQaZnUa+78AmJXwjaLod4WvPPfog@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/9] xsk: improvement performance in copy mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 26 Aug 2025 08:01:03 +0800 Jason Xing wrote:
> > On Tue, Aug 26, 2025 at 1:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Mon, 25 Aug 2025 21:53:33 +0800 Jason Xing wrote:
> > > > copy mode:   1,109,754 pps
> > > > batch mode:  2,393,498 pps (+115.6%)
> > > > xmit.more:   3,024,110 pps (+172.5%)
> > > > zc mode:    14,879,414 pps
> > >
> > > I've asked you multiple times to add comparison with the performance
> > > of AF_PACKET. What's the disconnect?
> >
> > Sorry for missing the question. I'm not very familiar with how to run t=
he
> > test based on AF_PACKET. Could you point it out for me? Thanks.
> >
> > I remember the very initial version of AF_XDP was pure AF_PACKET. So
> > may I ask why we expect to see the comparison between them?
>
> Pretty sure I told you this at least twice but the point of AF_XDP
> is the ZC mode. Without a comparison to AF_PACKET which has similar
> functionality optimizing AF_XDP copy mode seems unjustified.

Oh, I see. Let me confirm again that you expect to see a demo like the
copy mode of AF_PACKET v4 [1] and see the differences in performance,
right?

If AF_PACKET eventually outperforms AF_XDP, do we need to reinvent the
copy mode based on AF_PACKET?

And if a quick/simple implementation is based on AF_PACKET, it
shouldn't be that easy to use the same benchmark to see which one is
better. That means inventing a new unified benchmark tool is
necessary?

[1]: https://lore.kernel.org/all/20171031124145.9667-1-bjorn.topel@gmail.co=
m/

Thanks,
Jason

