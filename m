Return-Path: <bpf+bounces-60789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D9ADBEF8
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 04:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE107A0702
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E94212B14;
	Tue, 17 Jun 2025 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1TdVCDR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4E1448D5;
	Tue, 17 Jun 2025 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126565; cv=none; b=UwXfjEshRpQKRxcH9e77Ce7JeH+omuKqshKB09g6qahQSTP/ioB0n0GorLRCuebJwqzwp4qAkgobB8FfYfWP33S9wXAByZeXRkgmJ6BmBzAMONqZl1jpCrtD7KPJM14XU7VDz6lsdp6xXyId/3Dz0bFImLU3HMoFJ20lydyEIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126565; c=relaxed/simple;
	bh=9Rs8vzAZ7KyK3Lqf11YHvEhxEo+LZ2hRXOosRo93hNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoXoqwIaf/dY3L9/v8nAgMHFKO8p2xNusa3CsuM51ABniwH6vjujbWvuzZZ0pr7W3Y8gzkDAsBcD3bsWEvD8MyHluQC9Y967IuwPE6wehN5bHO37slfCSTbkqtxlHLLfYVbOPN+vylxH31Le3MxvALYAvKfOOFt3ES5NnKdm26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1TdVCDR; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-86d029e2bdeso209788039f.1;
        Mon, 16 Jun 2025 19:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750126563; x=1750731363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Rs8vzAZ7KyK3Lqf11YHvEhxEo+LZ2hRXOosRo93hNE=;
        b=j1TdVCDRCwL+0f4/k0WkOc7RWXH6mbQ8bOMZoxeDLqlwFG4sxjFUqoA/Tj5E6hbIvC
         ujuRmU+on7LD0Dli6nKUiOqq0mhrWz9M0sIIvM6YFYHh7JcuZvK3UyzPP6PQbSx+YFzu
         ahH7T1plJVi8ZVqnT5EEIxybAW5VA8W5TRRnpbS29IR+hJV6uLhd5laUF7xNtGJJ8Abf
         pjXPHEjtkNKyzyh/2+bjHwAjb6WQyo9Xq6g3qcDLamp40j5YZYjHJUWMTpWZutl+lBT9
         ksp4cVU5W0i7PHMl/XiTIgap5eo4gN1t+w53voMWxUwgH1sWi8hQrPtolkavwD0H9yqB
         x7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750126563; x=1750731363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Rs8vzAZ7KyK3Lqf11YHvEhxEo+LZ2hRXOosRo93hNE=;
        b=HjlJI2538WUepDBJL2/5sxka0hMVX4nzXzNJlOjDLJBZ6FUf2SFWPkIF9vrOJJQ5DO
         NhU5PrgKZNBWhVcT/DYiHcfmd6OJ5FiiSm4AiHoii5Ei4trnJUbFXlmPZ/aIcH4EhOom
         4TeNhEH9f3jhbCGO80Ea2Q/jxZJuZW602laE30LJHim8AFfxtpObi7C1rur8AwuQKCLW
         xD3itJiVmq3rFrQ0mWKWy16UouhVQ7HgJnGfpT0UADouGO8BWwarnzTIwQqvUtUtNtUq
         X3sVpEOkIxVcRn333G8XC2OoqWdp37AGMEAGkYDP6CXOmqHlcSS9OOXL6MAe5cUQGfqp
         0/yw==
X-Forwarded-Encrypted: i=1; AJvYcCWr5zZ1LIleZvWojtgzCGNoHmBuwSK6/ewv99EzU8+5MaoOYmt1PJB4PDcwaiJQNi0Lrws=@vger.kernel.org, AJvYcCXbvReMVTCmMIB24PXd82qgvK7QdGnKJl/mjzbNFrzACuft1fZKR0ope1ZhLll0xu1R1y+1GhcM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw93UfHXB5wkYngpRPGGUBzcJkJ9oIy9AzqhKzE5x0Sw3MCzxhL
	xhF4PARBUv4QC51Wxs452UPnh+18rYwQq9GyKsJWj1Qf+qMGHe9V33CyI0EG8KuMfhXZ6vastuz
	4FF90yosNqSKfNu1+VsT//co2eDKFd3A=
X-Gm-Gg: ASbGncunRHn+GLtRQrdpm/nanY7dTXYsVnPLyZJMpRRNAVV+oKb2hMpo4TczbwNeHFg
	YWoTSeD1K4TLkrMD6m5urrvxZUfz9MkejXW9Wk6CKkNWdYf/7An6XdvKUTh3IalI/CfDctCwB7w
	obMqedwojcSQGmNsXI2TiFuAGN9ek8JSRdaTyLkAJP3b8=
X-Google-Smtp-Source: AGHT+IFCvjb73KQSXxgjC5qianq5cX/gQ5C0FQ4nChybXFM0jsB5uAd0qYuj2BDodabcEK+52Kyk3YMvBphQC6Wkd8M=
X-Received: by 2002:a05:6e02:2784:b0:3dd:bb43:1fc0 with SMTP id
 e9e14a558f8ab-3de22d3edb8mr6817985ab.11.1750126562959; Mon, 16 Jun 2025
 19:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617002236.30557-1-kerneljasonxing@gmail.com> <aFDAwydw5HrCXAjd@mini-arch>
In-Reply-To: <aFDAwydw5HrCXAjd@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 17 Jun 2025 10:15:26 +0800
X-Gm-Features: AX0GCFuL5VzRQrdRqTiHEiYEbm_3vgvV8cts9iF2G633evT8KwDF6LuTAnLSXmk
Message-ID: <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stanislav,

On Tue, Jun 17, 2025 at 9:11=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 06/17, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Introduce a control method in the xsk path to let users have the chance
> > to tune it manually.
>
> Can you expand more on why the defaults don't work for you?

We use a user-level tcp stack with xsk to transmit packets that have
higher priorities than other normal kernel tcp flows. It turns out
that enlarging the number can minimize times of triggering sendto
sysctl, which contributes to faster transmission. it's very easy to
hit the upper bound (namely, 32) if you log the return value of
sendto. I mentioned a bit about this in the second patch, saying that
we can have a similar knob already appearing in the qdisc layer.
Furthermore, exposing important parameters can help applications
complete their AI/auto-tuning to judge which one is the best fit in
their production workload. That is also one of the promising
tendencies :)

>
> Also, can we put these settings into the socket instead of (global/ns)
> sysctl?

As to MAX_PER_SOCKET_BUDGET, it seems not easy to get its
corresponding netns? I have no strong opinion on this point for now.

Thanks,
Jason

