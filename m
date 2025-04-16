Return-Path: <bpf+bounces-56070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AFBA90E88
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 00:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106581904D9B
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 22:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B121C188;
	Wed, 16 Apr 2025 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="FpC0n1JM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DA2DFA42
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841904; cv=none; b=c5EqNn23LnLeC9Ff7JwdkIkbDhuaxA7PtwmsASZxdzbIbNHVBfX3g4ie7OzXuUjgsnUJbOk1Mc90PR3v81ReKJMb2/47c4VlXpx3+rsPPEGOQsHC8bcGdNa+hr84a2U7IKE7c4YGB4Rwz3Lpz0JtIopuYv1Pz/s7IlRCQzsa/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841904; c=relaxed/simple;
	bh=VCemrEPNIoQEBU1oN0HmKJ3Q5kAFJTR/Ly4+yYEWwac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMm+D4DHFxi8KlAi44wFJ3PljEz9ajXhAOw5WqXemo4xjzV0dsyn/uZE2JwGPbcD7JjeDI8n0zH+juA8zmkDpIzNy//kf1rJRQor6W5Re4gN8OBfYMs0jCviSVhJdDxjQwCoskHAlZTumbnwXAG/U3l6uZVpK+8QUPGDMWhAjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=FpC0n1JM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso76424b3a.2
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744841900; x=1745446700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCemrEPNIoQEBU1oN0HmKJ3Q5kAFJTR/Ly4+yYEWwac=;
        b=FpC0n1JMIn8p84AyEmx/ZWODaN9FREKLsFE0WSfM5Siw4D0s98EA/BJABpvEPmoUEG
         0M///KvMwWY7QLh00CqgXF7zBz2ydceOYcz3FrF04sk/W60q2GzLY8Zv+4GO13i/N0dc
         iitWEswR8Si28zfU0Ib9ai9LsFVGBTgel/8n6PSxfzDbOEHMn4CnPTiOWiKLmtw67myg
         ia0WGIGC2xAKdiTT93Ga2an8cI2d6ItIpPijS8gzBtY9Es1KXyebI3oFhqEmoVRy3K5k
         0TlZVXdv66yE+0j7hre/xY12LL5h4T6u2E9jM9OBLElvntbt+DbUgjC7fFtjnTLpN3pz
         JugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841900; x=1745446700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCemrEPNIoQEBU1oN0HmKJ3Q5kAFJTR/Ly4+yYEWwac=;
        b=gK9u6WXwzN9LluBQi/+Vn9sC/gkovePrgXCQ444/9jmrRX3N0J3CJs/Q3McNntqFWO
         pNce7bS3heVa/riQizyuyDqw3ijH2LLWNy/iU+A/juJ6tQz9Em93uNpTQBgn1m0Djc8B
         t3/Ggt2g4Sa4YI8/+y3ofn3UeynEILJlfWjHX1jzBviYj3mPXoe0PnUYpYTSMqpop4yB
         7Iy5/fK+Cyivb54NSlf+XgoMy9YelXea9gqgpfGJM62Fa6Hc1M93XW5R3hTYQxaZg2H6
         G0NA5IP+UXVF0IUaC7rqDZTAzOQrdGDM1xs4XTxOIEF7Hw8idzdoCFOwzV1XhG9Hn0gU
         PmsA==
X-Forwarded-Encrypted: i=1; AJvYcCWQeG9NpuwJJWwY1fFyURUySgjTFaQcOMJ1KpYyPmYLqoP6Cr2ix3SdoMmvrPSSzH97pQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbivnpe3S8xHpmSILLAdtNQoLxx09FeOMYTBt4stOKEXHEZtTb
	LKauXMGKNuAzY5wdF5iWr03kc6cu7j98XZ69PUNJJ2hCfXqlidYrB0LZ3zE9PxiSwyQVEYmpjxL
	UjNlS0Mt12ITjU+nbdwvO2vazMtWj7tAp1qNv
X-Gm-Gg: ASbGncsndxb2ZDaaK/iFN2Vx04LeDRgG4THpKyVuaxVKRwGfqNVcN4rKuWWXXeapjmf
	MQbK3xoRo12k2DbC5GBZKje6fclDKyilKwr9uj+MP0niG2p0OULk/anrmiUzxeAfuWt0LvdA/la
	ADncfWXbAOq0K+uSa3+rbJjTVXqDzs4gQn
X-Google-Smtp-Source: AGHT+IE/Lk58kaacF4Jl2k/ZktHdR+pjI5AiitSqNs/IbSN2x/kpyvBkA3H9yrf2gCwfFfoLxbO1iTf7V+l006TtqUU=
X-Received: by 2002:a05:6a00:3920:b0:730:d5ca:aee with SMTP id
 d2e1a72fcca58-73c267ecd69mr4811210b3a.23.1744841900435; Wed, 16 Apr 2025
 15:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416200840.1338195-1-kuba@kernel.org>
In-Reply-To: <20250416200840.1338195-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Apr 2025 18:18:09 -0400
X-Gm-Features: ATxdqUFCk9X7eO6fm5AsfXwDznBYAGl5MGiYl_NMSixm0W5n17kVp5sNrly34tM
Message-ID: <CAM0EoMnLaqZMaSqdH88GexEWYVhXFSD9_YyiteurUoWJAdvMjQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add UAPI to the header guard in various
 network headers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	m.grzeschik@pengutronix.de, jv@jvosburgh.net, willemdebruijn.kernel@gmail.com, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	nhorman@tuxdriver.com, kernelxing@tencent.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, idosch@nvidia.com, gnault@redhat.com, petrm@nvidia.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> fib_rule, ip6_tunnel, and a whole lot of if_* headers lack the customary
> _UAPI in the header guard. Without it YNL build can't protect from in tre=
e
> and system headers both getting included. YNL doesn't need most of these
> but it's annoying to have to fix them one by one.
>
> Note that header installation strips this _UAPI prefix so this should
> result in no change to the end user.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

For the tc bits..

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>


cheers,
jamal

