Return-Path: <bpf+bounces-70869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB7BD71FF
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 04:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5F94214FE
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A899930648D;
	Tue, 14 Oct 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzfWp0Q6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93068255F22
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410223; cv=none; b=duwF59C1XJNbNYapYKgqBj5jzeUthC5n+EB4ZsPWwJXzsIe2r/RYWlW/qZhMcgr+B2P6/tbIttqrxHQnHlm3XpV4STRE+l18HdEhmhuxq3S6iU7Nnk96nfWcE/Tsxptk5ytYWs25pecUDS0EgOjfV9p4C9rEWnbL0BvdBXCNYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410223; c=relaxed/simple;
	bh=RrBAZIy0TteWe1rNbnE+vumd8Hb0TdY/5ho6tkbZS8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zksx6+56xsRl1dVduFim1WdtJm5HAfzFariql8rZAhzVJoPCTFJ3v5wHTaf0HMFwU7DHgzYg1/PZTsyyupoA2blAG2avTZdAEHHwUDphWOAkS0+/T6MWzJiNrap+YQ+vnWRoBaTgBN6ugyFZC9FZxySw0la5sBbIULToyBMUALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzfWp0Q6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2578150f8f.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 19:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760410220; x=1761015020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dsk3/CfBAO5ltJKDJvUsPAsJ58KzLDJtMB6cqf8BZM8=;
        b=NzfWp0Q6QxUZ5DHBA6xbTZturPACKrm8NGPXJ+4MGfLmQYgNG/WmQpnvNVjxejKQxF
         b80ozgGh01zu2aHDsJiWYUS6f2nLxUHmRwjcCoT3ch4CvV8MXStPlrkAsvDEOcCEzIIH
         1Zam2EqBEKMX9LEcKKlRksJcDGg2dxCQxYrRQdoC9Uu9FPNOAG9+uKcCMWIq3ISs4xnu
         E0rXuzZmBxBdIY2C0oTs/FB4PjUtlq5B0rmL2/bZoUS1Zj0coBwFkqxpFmgVwqVL/o/2
         jkukL+1rMk9emaOJ4DO0mYP1N/oXQItBfBphsCe/DfGb1jRFl0uhyQbRIMF1L7AHwGRv
         L1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760410220; x=1761015020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsk3/CfBAO5ltJKDJvUsPAsJ58KzLDJtMB6cqf8BZM8=;
        b=JFTR0NtVdWJwDvW9XxPestgUCmnx8VEydc0LAEVnK/IFChMZjzXlCii05EMbASLhsD
         h7Dmnb5kLRjulaAi2tt/8FWiydyBoBVu0rr/g3C72FEVPOwgX9jbcDLaNnwZLoebbmcY
         RpYsW/KJIxksreIpjLEfH1+zkiUxOMZdkZHvb3l60fmpWPHc2YaNsg79CWeiM6ko7eAn
         k2p2bzqcUO/QbfZV7Mlk+u+FN0cPjBIO706Ks6elBGWHvW13dJwNlf/7qK348+Y1knTW
         mPHNnRh23RvQxDWmOhUvJNTIce57ygk/Rm7T3mf9wCwa3U8st1Qj2G52UKCVZs8uW/3g
         Cp6A==
X-Forwarded-Encrypted: i=1; AJvYcCUHDjC25hYy4wC+V+2apNOMRYG03fcEFT2fo54emXFwl7q6JUFSBWjRnZRjpoECFnF5lGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM7nUv4Rqj8NP2eGIv6z1Vgo7C+OWBOBJ7cvkbJOD5Xy7wwdAx
	vc1QAn2f/tPiT0F+RSOyuNqLDPYxYyXboBrOnf/oz6Vc2LEkJ4QRnyGDoQmgtZMvdd7zHVEJG4z
	KboC/zUEWcSoM6leXUYNQZJXQDLEEA/4=
X-Gm-Gg: ASbGncsLSj0TNa5eqX3vA5CUPXcFjMzMDmeLzPlo7cJ11XGkC7ayp4pX3dhA0Fw30iM
	uB6KStNzOCEnuX6wrTaO5rq3kSR9D1XjR+pyZY+h+REbwdCW1ZBuTep8eWLtl0AkMDC1OITtxs0
	Gzk+K+KVYPAyCV+BF39Q948kRNrC5Hlewyu/TimcZNaqeAAxt2b0kBCGblYJiHeFdb2JYg+oJnP
	e0B0jvoskFeFMOWYGSVlxcIo2lEGScaYeCrnF3j5yPKEF9t/UBLmbv5jeYBfVemIoY7eQ==
X-Google-Smtp-Source: AGHT+IG9mJh8ykO/cRsI1p26T3hRTaGKLUk4Twtr59/y1RD7cuCR/M359pO3FDOyWU1KemQ7oMxv+1oAoHB6goCn2Uo=
X-Received: by 2002:a05:6000:2087:b0:3ee:1563:a78b with SMTP id
 ffacd0b85a97d-42667177dc7mr15344285f8f.20.1760410219591; Mon, 13 Oct 2025
 19:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014023450.1023-1-chuguangqing@inspur.com>
In-Reply-To: <20251014023450.1023-1-chuguangqing@inspur.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 19:50:08 -0700
X-Gm-Features: AS18NWDYezDAswt7t7gVgX0LbcpsbXLar9N7zvRnvMlP9Bm7rix-FersDRs5Vy8
Message-ID: <CAADnVQKMgbDV2poeHYmJg0=GD-F2zDTcjSxcUDZSO3Y5EwD17Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Some spelling error fixes in samples directory
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kwankhede@nvidia.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 7:35=E2=80=AFPM Chu Guangqing <chuguangqing@inspur.=
com> wrote:
>
> Fixes for some spelling errors in samples directory
>
> Chu Guangqing (5):
>   samples/bpf: Fix a spelling typo in do_hbm_test.sh
>   samples: bpf: Fix a spelling typo in hbm.c
>   samples/bpf: Fix a spelling typo in tracex1.bpf.c
>   samples/bpf: Fix a spelling typo in tcp_cong_kern.c
>   vfio-mdev: Fix a spelling typo in mtty.c
>
>  samples/bpf/do_hbm_test.sh  | 2 +-
>  samples/bpf/hbm.c           | 4 ++--
>  samples/bpf/tcp_cong_kern.c | 2 +-
>  samples/bpf/tracex1.bpf.c   | 2 +-
>  samples/vfio-mdev/mtty.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

Trying to improve your patches-in-the-kernel score?
Not going to happen. One patch for all typos pls.

pw-bot: cr

