Return-Path: <bpf+bounces-13478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1274A7DA165
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35719B2147B
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFD13DFF3;
	Fri, 27 Oct 2023 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmnrvFM8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFDC3DFE0
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 19:38:23 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD8D1B1
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 12:38:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso346439966b.0
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698435499; x=1699040299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HResry5JndYeZBSzTVAWBwxzRl7+fUNF38GNSOea4NU=;
        b=AmnrvFM8pY/WSb2SEchOnNX9gmzhPV4+ItnmSD7Iy6POFrPij3pF1vnkfNgRYSti7p
         WnY1oDILFqn4zNB2vfh3KktUXk7FAiCo/q2Li84ORALTfsnGiAL13vqaY4zDW6P3mFQY
         8HSBRA6Rit29fhhvWZWSI5LKJxuWzsIvqUUej4amgzmShIS67fpq1a6kiT+zqDKaEXjG
         8xhGdPfNoPH8GYGqYTwq23u7AqXfsOdaMYE1Qh7xn7Gv7CC1AeyaH4aNgjZebT7nUTMW
         KrhbZtO+7WKQoH6LPdJnYfUuPx+lZa/E7C1VJHB/iWQjg96ipT9fHzV+cf7dXfrNVQU8
         2dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698435499; x=1699040299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HResry5JndYeZBSzTVAWBwxzRl7+fUNF38GNSOea4NU=;
        b=MGwuG2WqLJZK3bn6LmU4gFxBuqNrJLG3gG0XEUiZYIuKn+3MFsXgV6GMDHbBLi1g2T
         xcMAj2Fj1PUjegBLbUEyIqe66gxFdHZREHJaSmlBdf65C75bDZG+G3H3eUK4JWYhKKOf
         oNIlR49oBOzH196wbwkaQqklIdJ3xoDw3r3cJV4TGzWYdDvTHHJh4GyGiNcumrM4oLpy
         3sOyf4/DX/l0NkS84huHrp+nAYvSiHTeFgAnD/p9HhEuUWJxEAnzxOnHMLgOS9r//oCe
         Ie7iBxZwXEEHhr79iwK455yHdPjc3koayPhDzdtNPgDfoRfKTx2uQZtNXaVmK008jAGX
         6JMg==
X-Gm-Message-State: AOJu0YyO89rHyZGcYnsYp5rEyuBQjbFgZP+mJVyVUM/Y0ugNxI3kYRME
	1PNlSjkHQQHIiHptOQKYaQXlt2jewT9e1NNhKXRPjQ==
X-Google-Smtp-Source: AGHT+IGfiH7/vZwPOYNJYfiPFBz2VHBIUsAkZ3hwTXH1qOBLB7kLIxeiWKyV6/erRjPKyouXW2aFwt8n98N0Q3p+tfY=
X-Received: by 2002:a17:907:9341:b0:9b2:b71f:83be with SMTP id
 bv1-20020a170907934100b009b2b71f83bemr3210322ejc.1.1698435498762; Fri, 27 Oct
 2023 12:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com> <20231026220248.blgf7kgt5fkkbg7f@skbuf>
 <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com> <20231026222548.rqbp5ktgo2mysl6w@skbuf>
In-Reply-To: <20231026222548.rqbp5ktgo2mysl6w@skbuf>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 27 Oct 2023 12:38:06 -0700
Message-ID: <CAFhGd8r9Y2tavxA2KVpELm-SRdvD+iEmYW=s7tf_dPpmVT3WeA@mail.gmail.com>
Subject: Re: [PATCH next v2 1/3] ethtool: Implement ethtool_puts()
To: Vladimir Oltean <olteanv@gmail.com>
Cc: GR-Linux-NIC-Dev@marvell.com, UNGLinuxDriver@microchip.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com, 
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 3:25=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Thu, Oct 26, 2023 at 03:09:59PM -0700, Justin Stitt wrote:
> > Should I undo this? I want my patch against next since it's targeting
> > some stuff in-flight over there. BUT, I also want ethtool_puts() to be
> > directly below ethtool_sprintf() in the source code. What to do?
>
> (removing everyone except the lists from CC, I don't want to go to email
> arest because of spamming too many recipients)
>
> What is the stuff in-flight in next that this is targeting?
>
> And why would anything prevent you from putting ethtool_puts() directly
> below ethtool_sprintf()?

The in-flight stuff consists of patches I sent changing some strncpy() usag=
e
to

ethtool_sprintf(&data, "%s", something[i].name);

We can see them here [1]. I went for this approach initially but then
discussion came up about introducing ethtool_puts() which now
made my patches (some accepted into next already) semi-outdated
and in need of another swap from sprintf->puts() -- hence this series.

As far as the rebase, I simply took my commits and placed them on
top of next/master and got merge conflicts when ethtool_puts()
was placed below ethtool_sprintf(). All I have to do is move the hunks
around but since I formatted the file it's appearing in the diff. v3 will
be a clean diff.


[1]: https://lore.kernel.org/all/?q=3Ddfb:ethtool_sprintf%20AND%20f:justins=
titt

Thanks
Justin

