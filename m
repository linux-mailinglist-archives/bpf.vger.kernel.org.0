Return-Path: <bpf+bounces-70261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A957BB59DC
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 01:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F4D1AE1477
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165EC2BEC53;
	Thu,  2 Oct 2025 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mggcXN8i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4B254B1B
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 23:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448264; cv=none; b=s/tf7ICQuwb/LM0ympehVlxjueFwSwhIf4+lQOlSsEmE+fFSQNx+iFDg6zdoJauOqOdRYTwi1eTTiEeUIXln44Fj2WdnbWVStfFNO0vi6MJ26rn6UqWkxiSHtgWCekHURz1e8HVcZQXveBBEAixLK16Qqcs9FoM+oFbeI9uYJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448264; c=relaxed/simple;
	bh=a4iHp1m1jUq01D2H8VN4n08fE9MhQ/vRj7/00NmGVWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn3QeWNpYV491aCKC449oEciMcyFiRxKJTkG/Sjx55xwDGbgoNHik7xwaNZSv8EWCvQ5BOZRa6+yRJYQhrPx7FPYPK1JQZFzcKqA5ah0X1+hCZYPRQIIFMKPKUnLMHmCwHqBNRwRNedJucwBlatLoDXoi0LoHsW3u9Qoukw+B0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mggcXN8i; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4256866958bso54016f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759448261; x=1760053061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYyRjvvcClZsqK4bgOK/mSlQ3JwKmg6n0DCRi23dNek=;
        b=mggcXN8iUgsoPa7cHGX0eI6ZYyaZrOdrl36ZDU8CpUOwQTkHTR77sfBGvFNbkMjY4q
         2a3bAzHnjZoi/ebYKwnvKTUaBfySnOsNQOGjNUX3nn/uOMsTGMyh+dD63CarqyqrLDgz
         zMoQipnZotf9ZmQOzWcW8J6L/NDLmFBtaU3WZqxBct8SduU/rHZYfvbpqSFZHKnnSO2p
         pNtaNkqGqzSaDiQhX797jDPiDsSUhWeWcriDsz9vkYTd9mpO9jbwG/LHrdD2WThdY/sk
         AlYJbvR8tEgIP+tSaLe+xDehWB1qraZGZPeWfkOMNBfWItfnpmamdwPHy/D6tfkEjSAY
         fV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448261; x=1760053061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYyRjvvcClZsqK4bgOK/mSlQ3JwKmg6n0DCRi23dNek=;
        b=iuPiR/zTnxI01zunaspOa2ytf/j8oIpUJV44i/jLA0mEv9oEaMAyROuKA5AQ+lYDDm
         js+Jy4bVJ7OZbqhfLL3XPvH+bMXaIiUoES8eJQqjJIvN+eNBPhMdg7P3AhfrUpDLPMSz
         R4OWsugwUYwJDkfAW2lAFTLnC7HW8deMNPNEx8DDqVVsoBMbmRertWAtcOZtRTz06iRY
         UaGaX7tbU3sKy0loN1ouAzDqeNDc5pVDGaK827HrpsdHSpWAdvvBY2VzhWX+EGZEoHGY
         TQo//qtlZpb9509vxel1iXxltEjwUOtlERNg6bMw+NnSu7yno0vmlGIwyDySGaJD9A+u
         Wz7w==
X-Gm-Message-State: AOJu0Yy7JK3YrNpK813pRgN4R2aFUYbOBtW2IfQwxowP3nIylav03jYX
	cxL8mllMGHNUmobTVAEVS2Le9e3x0UJ2eUEYiKcA9P/CA+ntvKg2yNUafl5+FAZOfhawYWofgXF
	3aKyQwAqYUe6BIrD8tEfdkIbLTibnz1JRiQ==
X-Gm-Gg: ASbGncuhCDhn/iwmW5vLcstdXI1VvLOkbLTdE13EHLkxjVpkjl7NwMX0/svVnnfO3XR
	/LD5YvzNKiSkb5sIo+lhrNmShNXLSuvB3LficIN2xp8Xo4nLS+q3aPQZq6mINZCHUdzkj/yewVH
	3wb+g5VDozwhzlPYLq3zyzJaTp4JRN5JhrDGGUOEjkVpWqJvQdx9e74DkXk5vskJ0Kowkf70Rnc
	TnFlF0opFD4HU1IKxiGqla7Cz1wxvTK0lU29x/WF2g0ypaseBlGXcsjCc8b
X-Google-Smtp-Source: AGHT+IHb95C9UaqPZtGL0P5fKptKfIz8ZAhVPywIiTLzHIHUdC8qi4d7wOijDm27RI3QjHtP/ObVzgdzJG1YjW47LZY=
X-Received: by 2002:a05:6000:230c:b0:3ec:3d75:1330 with SMTP id
 ffacd0b85a97d-425671b037amr505734f8f.52.1759448261224; Thu, 02 Oct 2025
 16:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002225356.1505480-1-ameryhung@gmail.com> <20251002225356.1505480-7-ameryhung@gmail.com>
In-Reply-To: <20251002225356.1505480-7-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 16:37:30 -0700
X-Gm-Features: AS18NWBzOrTlE6SWnP9vH5g1d0_y8ZQPBBlzY0EtKr4sLtLnv87FvFw_6jM2fys
Message-ID: <CAADnVQ+X1Otu+hrBeCq6Zr9vAaH5vGU42s6jLdBiDiLQcwpj4Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 06/12] bpf: Change local_storage->lock and
 b->lock to rqspinlock
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:54=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
>         bpf_selem_free_list(&old_selem_free_list, false);
>         if (alloc_selem) {
>                 mem_uncharge(smap, owner, smap->elem_size);
> @@ -791,7 +812,7 @@ void bpf_local_storage_destroy(struct bpf_local_stora=
ge *local_storage)
>          * when unlinking elem from the local_storage->list and
>          * the map's bucket->list.
>          */
> -       raw_spin_lock_irqsave(&local_storage->lock, flags);
> +       while (raw_res_spin_lock_irqsave(&local_storage->lock, flags));

This pattern and other while(foo) doesn't make sense to me.
res_spin_lock will fail only on deadlock or timeout.
We should not spin, since retry will likely produce the same
result. So the above pattern just enters into infinite spin.

If it should never fail in practice then pr_warn_once and goto out
leaking memory. Better yet defer to irq_work and cleanup there.

