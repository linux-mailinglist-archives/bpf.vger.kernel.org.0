Return-Path: <bpf+bounces-46551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B549EB9CC
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366B7165878
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2732046BE;
	Tue, 10 Dec 2024 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZIolccC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BDE194080
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857587; cv=none; b=TNpq1laczcNmqWvjOTgZDZ3pkVy/jeEhQLcu7PCzYW4dmXk9ytm012BgEmEFco8QZQPHP3cQHHta/a9gRmU4EjXUFUsLUSHYFVy9ihUyVpYy+h8J1ZPO70D3lbNKht6mUuxXxV+eyaHLcYR4ka9hF0tS6ba0fHBptjsPUMyjO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857587; c=relaxed/simple;
	bh=asReW2YFFKk5u55QzBPPcFYQ0z12OX8Yx061CxjDgD0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLb6T+84GpTwJwyKvew5439BJsSqz7sIZquct/bC3tSiXP6KCH8G+MeCX3WlCGAnbPQiAGZ3whYmkFxAn69uPqcu2VGVF/vHe7EoEnT1Cza3phhdzFJ56LudcPd5tEEtZBVAA/VON4UByiHm6rFkO98ZeTDPY+qF2fmA9GhcPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZIolccC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725abf74334so4920472b3a.3
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 11:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857585; x=1734462385; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=asReW2YFFKk5u55QzBPPcFYQ0z12OX8Yx061CxjDgD0=;
        b=kZIolccCADNMXR8EpvxHoPoCxFZiVLI0F8MSQiOST9YxHXnly0QeIkkFVegKvKEy0l
         sYp/FjC7tVWQlcnZx63HJfa44a0jgeL6oYCg+2KEz6YwQYxPuzBeruxPYrHWHEE0/Mbo
         Md5asG4axGU7lwb364h0YC4Gnw+N3cev5A4TgO8M1YpRSm4XdXtb+0n4SILJBb5dFUJf
         ZhbYa1+FQmhGQjRsWyhF4rTIS/mLYWCHDkMy30Kl5OLV6aL0JiyHzkuOqDSsKz34+K7a
         HZBCpJBbO2HaB81PSS+NBB7GWGDczJpsm3ZK5Jsbcw/HxecP54D2XxYo1bXbZdx9S5nC
         HR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857585; x=1734462385;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asReW2YFFKk5u55QzBPPcFYQ0z12OX8Yx061CxjDgD0=;
        b=qoUo1jNOsgQdjFfp3kiFH2HXRQfRG4iiUlILomNaRJFLU8ZNFNdXpmJXgJkXkQM0Qr
         JdiT6RZQJp4CwyrhzMp8sKiTRo+wexb2dQF/BzDbvfnLxAwsm+kwBY5QSiXlgCPnyePm
         QD6dMWq0EkJJ+9sJXesjqt/RSoz+zqtM8EBiINW88CRntEY5ZG2m4NCxWTQ3XuO5zfSI
         G/P3wq6fLbDxQKQ2/WcQQLiKcStG0YWhqfF0Mp3UVS6rpJgrSjhasDxWQPZ0KB2wZPIS
         fxNA7v3GFvaHRA0nEz3eYlauLbTEv6jmkFm5P3PB4spRr1ablaKkLYTpbXESTkiyJ2oz
         Clfg==
X-Forwarded-Encrypted: i=1; AJvYcCVywTlN48eWM+Y3Y69U0JMWCe1YhD5QIF4AHpP2YuvBxU8JGSjz424pxpD5b1MwhCM6Xuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ag7vdBWRDsDM5AZxdfdnjdgPfNoofU/pkqZPWcCPzOXomUIA
	PXMxcHG+43u+wId80+ftWc9DorQlKLivqWoOz+GmXErkHNzXpSQK
X-Gm-Gg: ASbGnct+VKdepXSRK1FPJTZK+IfYTWrowECjw3AKkguzY2vWsi7YlZSfJD1shvvd7pc
	81LwggO+P1LOUAhNYIVj5AXP3iNeEu7qMRr2pggIn/K887vGfkaxolwV9ez4nLejmbZhhWeb3ah
	Mfeur4T7FXnwETH4/QKHHtBXNSpZ1/JX0ivEHZIHu3J20SNBUNjfgQ+JxdRzp1a28Cm8Qkauhf7
	H55ufzdr/ynUJSR6HNwtSpHnHx1SeIC1qh87M8lAw+2E4eAD/Q=
X-Google-Smtp-Source: AGHT+IEukBeU4v+rGh0CgjCBkfWUmgjCXx0yB0cTt9A3g0p/sfp0I64s/mf/jHQpBNBOpIRX2GX2XQ==
X-Received: by 2002:a05:6a00:c90:b0:725:f153:22d5 with SMTP id d2e1a72fcca58-728ed48ba0amr124406b3a.18.1733857585454;
        Tue, 10 Dec 2024 11:06:25 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157b003bsm8182348a12.59.2024.12.10.11.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:06:24 -0800 (PST)
Message-ID: <a87db11c0a3ce7617bba1e5ddba7c239e072fc3e.camel@gmail.com>
Subject: Re: [PATCH bpf v2 7/8] bpf: consider that tail calls invalidate
 packet pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,
 Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 10 Dec 2024 11:06:20 -0800
In-Reply-To: <CAADnVQJjJRYoMoGTLK5XHYmSy+zyeCcuOKqBNmaJbje1TqE+UA@mail.gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
	 <20241210041100.1898468-8-eddyz87@gmail.com>
	 <EC7AA65F-13D1-4CA2-A575-44DA02332A4E@gmail.com>
	 <CAADnVQKBmQrvnEYqqSpUL6xjmccBW9vnyzQKDktd3uvZUyY83A@mail.gmail.com>
	 <82110da58b8ee834798791039155074a9aaba7a0.camel@gmail.com>
	 <CAADnVQ+hsXZirUYJ6Dshn+K6XNJB7LC=cS5ZzHXiMQbot+SJ3w@mail.gmail.com>
	 <7bc3b90bc810df379f9463ebc62210c3819725bd.camel@gmail.com>
	 <CAADnVQJjJRYoMoGTLK5XHYmSy+zyeCcuOKqBNmaJbje1TqE+UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 11:00 -0800, Alexei Starovoitov wrote:

[...]

> bpf tree is for fixes only.
> We typically send PR every week.
> Once it lands in Linus's tree we merge the fixes into bpf-next.
> At that time follows up can be send targeting bpf-next.

Will send next week, then.
Thank you.


