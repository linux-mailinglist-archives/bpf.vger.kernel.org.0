Return-Path: <bpf+bounces-72687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C49C188F1
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 07:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC070352572
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB2B3081CD;
	Wed, 29 Oct 2025 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSUP2HTZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D02D061D
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721062; cv=none; b=ckVbpT22+pZscW63/AQVuZxzlpde3xnHqPQ26OT7ZGt8KQKJB6ZIcCDUzHCaUMvvbEfpsoD77noXp8uP67phhFWMi9y7sM4Qi+MMr+Lt34+1w5h6gcVaDUUB2dwONlzMOMBXftJLWZckLhPn2i46BAoY7kx0PYMcwJd2XP4MP2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721062; c=relaxed/simple;
	bh=o70LrdaTcmZAep8Ppo/GXv6T0uH5MZcqOulGJyJB3sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h95/2xKaFZEg+WCipDWWFi3dzWJjR+RZWxParhj4he3Uoi6tSauUMGQzBKnWdzanhxdMW/a88FV8LW7O3IJEWdcqPvSdyefLloSu3qqxEysFjqVl1F6noKk6m2bjJb1YJNN/GR1LDJfVOUBgNFbjztXe6xNcw0FuAjZrxdhdGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSUP2HTZ; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71d71bcab6fso64568347b3.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 23:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761721060; x=1762325860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbCgVFEzX8577A9DDwWGOWRS7BulG4xBlkKpiiYDRug=;
        b=CSUP2HTZk8EGA4uK2hQQphzWIA7XMYYTnNxFFz8DEY2OcSmdE9RrXEczbNv3TnwPFq
         FSJuRXjfactlnBmfjuFK+Ru4p3XL8LacortiAoI0stAzZjZaVMmgz0TG4Md37+s+d1+E
         CzZqpln0n4VkeNLcKVyI33KA65iGOxMnaamPMEoV2VuHZJMd/V9Bn4EwdVXnaHAcW4Ef
         2iEN2TnCQvECo4Hs89FGlXqyWnmfDNQL88HJO7uaZq4z0UWcRyQYlr4m7+VOlhDgPHRO
         AQXPSLYM2dXtr0Ps8o8ghNjQc7w/5lLMhayx2yFhvbm7BLaW5qI399xcqGr9kR4X9Suv
         OVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721060; x=1762325860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbCgVFEzX8577A9DDwWGOWRS7BulG4xBlkKpiiYDRug=;
        b=Ey+DqAp5ptFdMFNTYiQPkcE4Ybg5s7aPHQyffj4U56BbVEdGfvyqPYw1olOAnvw2HG
         6UfpPoYIMUDGKetnvnTMfm9vaXSZUg6X4Zf+yEy+aXMHtfE9p3xj0+gDYBVS0F7ePtEm
         A6kDSy9fVvoWicS6IKSnjnXFYhKrz51wLb+by4pUhz/BuE4X0xTum0/mxBO7Okp/GTft
         gOHh2QYJ82LV7ny+GljVeHBMnSpU3JglIHlENWlyZgFf36IxvFpFZxb4D1KihqaRowxl
         D9Auqg+TNTOdD/on1jcnX18ee9R639Kev50CLTSzAtNZRZVA4oIfrMb+HLbUcykwKGiu
         HGCw==
X-Forwarded-Encrypted: i=1; AJvYcCVzZPZfNJb7CddLHVzkSFgaFd803/HU8DSVZZHjbAooNwK5qDvLVociOLPTYpm3uMvWbzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7DbmG3fvCeXidRbfHkSN8xFmeuLkcDV53j1BoZ0pIFmX0shXz
	2AIZ2Zt+Sh/DfT5xXNKz7TgF2FmjSRXYOgcX84mEDv87IOVTmj64kIgrff+RLaXbzyRynsexAKx
	TS+opHJtDRKu6hcic4n8YYck/SlzZcyI=
X-Gm-Gg: ASbGncu5d4fsMamlWfJSNwubfCm6AeKjrfeVtKD7kmEpo/7MBr5AKqjvOVai2uh+BDz
	cXwnQje+cGUHQG0YH02jupkmGNmWU07Yp8P4bW5IeWcsCI89UJITs146SUpOsqPL/tLMOsW58hs
	ZY6mvG/ThEIGCezG+0tinqcct6KooTWYkLDMaBhYGscgzxRXF/LmnzOnAqRp/xeOjJvQLHjyEcY
	OYPf6ptwKRYaBRAczaL+YFmqfT8ITEkTppHSpuYe6i7Mbxai8JWIdfazfZ9lLYWFRu5rDEOK0A=
X-Google-Smtp-Source: AGHT+IGG3tSEotsRGPM/qL2Z7zc/4Vnb7Qt9+XB1zXw/dQYTAIJgwEQOEjw7RLjJIeE1mnaPSJKaCOwEtapvnSLPTW4=
X-Received: by 2002:a05:690c:5c12:b0:783:72c4:5bc2 with SMTP id
 00721157ae682-78628f93d7cmr13723697b3.35.1761721059935; Tue, 28 Oct 2025
 23:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <176167501101.2338015.15567107608462065375.git-patchwork-notify@kernel.org>
 <CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com> <23eddad8-aae3-44ce-948a-f3a8808c1e24@linux.dev>
In-Reply-To: <23eddad8-aae3-44ce-948a-f3a8808c1e24@linux.dev>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 29 Oct 2025 14:57:29 +0800
X-Gm-Features: AWmQ_bkLvcykX8zmNuKPqnBYs3bc5ZytYMQH3yHLtNht1gNW5lGGNuEzgcKcGSs
Message-ID: <CADxym3YRi+ACP1+uCDaDZDPGobrZiUmZrPZfr73W1cHCtKHEgw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and
 local storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, patchwork-bot+netdevbpf@kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, 
	linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:50=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 29/10/25 04:22, Andrii Nakryiko wrote:
> > On Tue, Oct 28, 2025 at 11:10=E2=80=AFAM <patchwork-bot+netdevbpf@kerne=
l.org> wrote:
[......]
> >   [  424.982379]  ? bpf_lru_pop_free+0x2c6/0x1a50
> >   [  424.982382]  bpf_lru_pop_free+0x2c6/0x1a50
>
> Right, this is the classic NMI vs spinlock deadlock:
>
> Process Context (CPU 0)         NMI Context (CPU 0)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =
     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     syscall()
>        |
>        +-> htab_lru_map_update_elem()
>        |
>        +-> bpf_lru_pop_free()
>        |
>        +-> spin_lock_irqsave(&lock)
>        |   +-------------------+
>        |   | LOCK ACQUIRED [Y] |
>        |   | IRQs DISABLED     |
>        |   +-------------------+
>        |
>        +-> [Critical Section]
>        |   |
>        |   | Working with LRU...
>        |   |
>        |   |                      +-----------------------+
>        |   |<---------------------+ ! NMI FIRES!          |
>        |   |                      +-----------------------+
>        |   |                      | (IRQs disabled but    |
>        |   |                      |  NMI ignores that!)   |
>        |   |                      +-----------------------+
>        |   |                                 |
>        |   | [INTERRUPTED]                   |
>        |   | [Context saved]                 |
>        |   |                                 v
>        |   |                     perf_event_nmi_handler()
>        |   |                                 |
>        |   |                                 +-> BPF program
>        |   |                                 |
>        |   |                                 +-> htab_lru_map_
>        |   |                                 |   update_elem()
>        |   |                                 |
>        |   |                                 +-> bpf_lru_pop_
>        |   |                                 |   free()
>        |   |                                 |
>        |   |                                 +-> spin_lock_
>        |   |                                 |   irqsave(&lock)
>        |   |                                 |   +------------+
>        |   |                                 |   | TRIES TO   |
>        |   |                                 |   | ACQUIRE    |
>        |   |                                 |   | SAME LOCK! |
>        |   |                                 |   +------------+
>        |   |                                 |        |
>        |   |                                 |        v
>        |   |                                 |   +------------+
>        |   |<--------------------------------+---+ ! DEADLOCK |
>        |   |                                 |   +------------+
>        |   |                                 |   | Lock held  |
>        |   | Still holding lock...           |   | by process |
>        |   | Waiting for NMI to finish ---+  |   | context    |
>        |   |                              |  |   |            |
>        |   |                              |  |   | NMI waits  |
>        |   |                              |  |   | for same   |
>        |   |                              |  |   | lock       |
>        |   |                              |  |   +------------+
>        |   |                              |  |        |
>        |   |                              |  |        v
>        |   |                              |  |   [Spin forever]
>        |   |                              |  |        |
>        |   |                              |  +--------+
>        |   |                              |  (Circular wait)
>        |   |                              |
>        |   |                              +-> SYSTEM HUNG
>        |   |
>        |   +-> [Never reached]
>        |
>        +-> spin_unlock_irqrestore(&lock)
>            [Never reached]
>
>
> +---------------------------------------------------------------------+
> |                       DEADLOCK SUMMARY                              |
> +---------------------------------------------------------------------+
> |                                                                     |
> | Process Context: Holds &loc_l->lock, waiting for NMI to finish      |
> |                                                                     |
> | NMI Context:     Trying to acquire &loc_l->lock                     |
> |                  (same lock, same CPU)                              |
> |                                                                     |
> | Result:          Both contexts wait for each other =3D DEADLOCK       |
> |                                                                     |
> +---------------------------------------------------------------------+
>
> We can fix this by converting the raw_spinlock_t to trylock-based
> approach, similar to the fix for ringbuf in
> commit a650d38915c1 ("bpf: Convert ringbuf map to rqspinlock").

Nice shot!

>
> In bpf_common_lru_pop_free(), we could use:
>
>     if (!raw_res_spin_lock_irqsave(&loc_l->lock, flags))
>         return NULL;
>
> However, this deadlock is pre-existing and not introduced by this
> series. It's better to send a separate fix for this deadlock.
>
> Hi Menglong, could you follow up on the deadlock fix?

Yeah, with pleasure. As I see, this is not the only place
that can cause deadlock and rqspinlock should be used. And
I'll follow up on such deadlocks.

Thanks!
Menglong Dong

>
> Thanks,
> Leon
>

