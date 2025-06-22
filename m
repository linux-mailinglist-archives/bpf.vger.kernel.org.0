Return-Path: <bpf+bounces-61252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0348AE2D88
	for <lists+bpf@lfdr.de>; Sun, 22 Jun 2025 02:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31831171F4B
	for <lists+bpf@lfdr.de>; Sun, 22 Jun 2025 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1A0AD2C;
	Sun, 22 Jun 2025 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft7DFIky"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4979F2;
	Sun, 22 Jun 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750550764; cv=none; b=rE9HVmj0zKAgshxXVtWnGe7NUg6idTowYV8QKk9nAStAlQod/wQj/a+JbNwWnQEi79XIoclxMB1ZZdE1ucugxEc/Mvi6wRMEQS95Ntfb4NVvgg8+YZonDLvjd/eEvLOTy2NWkYxBmcX4v2hW2ib3gVCkaWPLkkDeeHt1x/gKQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750550764; c=relaxed/simple;
	bh=6kalqdpjIuMNqziMPpTwBZo9eVzvo/E8jNdw29kLXXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQqltDZ4a+pF3DN6/+IC38OctZxxMFEsSM3ipbv99PMf7XGmjfbBgCi2Abg70yOvAJtpG6CeLLJRjCV2jGvsRcF8s7dNlirrmoNk0yEHWPbZBxpfBHBIJAU0qZYidxtJQwGyBlCvzRiXWIxgr7Cm2sM2W0cdPyMRMQFOwWPfcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft7DFIky; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddd78f7c91so10094255ab.1;
        Sat, 21 Jun 2025 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750550762; x=1751155562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kalqdpjIuMNqziMPpTwBZo9eVzvo/E8jNdw29kLXXk=;
        b=ft7DFIkyf1P7+7H6RZS6T+nedyHrlAqPZXqC0jCg910w8l908yl3Gf35BAphp/dvUH
         eVDJCUNKxxGJo+97rmSLsApj0I45TQoWeskPzW4mmQ/J4gPGIV3m9tBEJPAoHs1BSElZ
         jkD4Ku/00o4gjxj1AMtwHcvBFTgjsR963DIjlYdjOKZYFlDykPHYMP6Q0cn5I8jzWH1c
         2fb5Rsuj5SUfls/PNiAOJIBcjUI/RO9xZc9dpyNIJ4hTCVgmOO0MH/NQ0oMefeAMaZCm
         W/fMf7c1U77NfSiaynFe116wtfpQASF/5E7t1GAfc3sx+Zc8LErgeNHSMQrMPES05wmo
         LPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750550762; x=1751155562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kalqdpjIuMNqziMPpTwBZo9eVzvo/E8jNdw29kLXXk=;
        b=ahWe2i1NDDXG1249vTRnoiCquR0yeUeH3EMeYJgFvS9nu5hBIpaooFRAr1iMomKLLk
         7Z7gL68U4o1t0tjC4V4585U49Gx0dXiaEjS1jkGAArII4NfeLasDdqAowMZxA4UrxhcP
         7xBjCG3efAM2RpD05QaT/+oZvgK29DVOq0CS/q0yKz/CuXm53qGgX3U0Do+Hx1oYAHZe
         C3ApLMNljmuuLZ9vI6DEmBHU7as5aW6VEpV9C3+zqaBQdUCAWLD+bzwc2bKep5JQiUNR
         SQ6knrlkLO/CGKBrSge3mlvmnusNPHZ7WxY3GWpW0js0py/GnS0oJ/zqZpFh5SI0WPFQ
         8tMw==
X-Forwarded-Encrypted: i=1; AJvYcCXIPWuMzcUez11Ar6x006eXSjVeUqGcxsrqu9yo4iCYTFARBlZODtT85X+7yKkRgGbilq4=@vger.kernel.org, AJvYcCXQfGy9traAO+12kIOo0z2orO4bm41EUqYo52R3leYwhGH2uTkY9cvpfIL6AsUyYnH4q09LgBOD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7d6olkEu9oB3CJZej7aLWRtiwzO0BqNXM47p+zG6e6q0u3OA5
	YKzNBnNgSKBwV7yHjiihJwCLm0Rf643feJDfh0pduy9YEUuc6auJSTbDcEImuDLq977XoMOBxhj
	fnuQuNiYMFUKX1bN79IGRUwfygBR/p6g=
X-Gm-Gg: ASbGncuA3ND7CYime6QwzTdJc7b6HCDF80s1YyvBxjrEoeSADii6OsVhVrhAd3lV9fM
	6Sx5Y6/0xQm3P/lubnHLFhRcp2W1/B4z7AreKxSzF+fjVyr0woALrTf8e2F8BDxtL75kPxGtZvp
	hCv4HlLVUTS5M6wOFVfRmyJSybGUjOLrUSmg1g2Fs+fek=
X-Google-Smtp-Source: AGHT+IGjQ6XyI1uSBN9pHs04aEhYvvJi4larFZtREeAxZzXeMoDn0/534dNnIpw9scvBwIwC8g2bdro0XpwdRFoLsUM=
X-Received: by 2002:a05:6e02:1786:b0:3dd:bb60:4600 with SMTP id
 e9e14a558f8ab-3de3955bf4bmr77786705ab.5.1750550762059; Sat, 21 Jun 2025
 17:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org> <CAL+tcoA=KQCLdthH3VXPhd-z=sieKQu_xOPgQEzxdy0Mtnycag@mail.gmail.com>
 <20250621074324.63ab381d@kernel.org>
In-Reply-To: <20250621074324.63ab381d@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 22 Jun 2025 08:05:25 +0800
X-Gm-Features: AX0GCFsZYnVHLJ7io8swWLndqIeqKTr1aV21Lj1gqWHMKRXqRorvD3nyQdvZDPQ
Message-ID: <CAL+tcoCz6bK+NHs21QvC+vtZfir6s=k_qLAi+hu0+vw-7bc-2w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 10:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 20 Jun 2025 08:17:48 +0800 Jason Xing wrote:
> > > Jason, I think some additions to Documentation/ and quantification of
> > > the benefits would be needed as well.
> >
> > Got it.
> >
> > #1 Documentation. I would add one small section 'XDP_MAX_TX_BUDGET
> > setsockopt' in Documentation/networking/af_xdp.rst.
> >
> > #2 quantification
> > It's really hard to do so mainly because of various stacks implemented
> > in the user-space. AF_XDP is providing a fundamental mechanism only
> > and its upper layer is prosperous.
>
> Sorry for the awkward phrase. By "quantification of the benefits"
> I meant what performance improvement you have seen from increasing
> this "budget".

I see. A week ago, I saw a stable improvement of around 4% for both
PPS and throughput. Special notice: not all the cases, just one of
them I traced...

Less resources consumption was found to be observed by strace -c -p xxx:
1) %time is decreased by 7.8%
2) error counter is decreased from 18367 to 572

I will add the numbers into the commit next time.

Thanks,
Jason

