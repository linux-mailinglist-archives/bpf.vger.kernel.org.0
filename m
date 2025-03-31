Return-Path: <bpf+bounces-54916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0976A75D80
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 02:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976AF1684F2
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CA529D0B;
	Mon, 31 Mar 2025 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEt6/a+o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B92E3391;
	Mon, 31 Mar 2025 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743381625; cv=none; b=JPhc8QNnCQ2tJ+D4xmYqEE30QvV6BIZAnEYehtM0Xpoa4E2cnrfMOSVYJ5abUpjNVCTP+ce8/zczs1pefebVLJotFa8Z5xOJUmMPzrB3I/WoPppdtn+fyYQrIO74QKYYJAAMLl+S1is7Gc24addd3bwHO9zc1tkwhrxETJ/JJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743381625; c=relaxed/simple;
	bh=CKpFOxFM9RiaLlkNxdeKxCbkNLU4hkniP8PEEHv41ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MU4EXxGKUlOeWsdIemxgY+lCwlG9xGbxuwFOoRjmakMCDnrLs9E1+lEq7T2iBIkaseyiCqq3o/SGCX7BR+UIstzF9KUBDrqO70LMB7nCdOjKxwMRon395LSehouYojU2d8p7UwtYAj2hsm1vzjlO3itiD16PS4qsgxnYwwXBO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEt6/a+o; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d45875d440so15502665ab.0;
        Sun, 30 Mar 2025 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743381623; x=1743986423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTi8tTiuzmW2svwLSuHqGg7YclWCnvqmfA6Gyx6yOyE=;
        b=AEt6/a+oYVCND3KDUYRBLOd8AMAa3w6IwsfIOOQuuTaKEB6cl4a40zLujkrqDBdB6B
         n5q+rITakTwuEeuHIT+vUecOnNFftQ5G3hxkdp7qz2acddYPhyR9j3NHX/a+oWQhMD/+
         sTM6iuAu9vq+6hzhmFAyVAZRqexTXtq9sTnywgvTIr64RZN/n+t8q9oGLxvd01ZrZgLK
         wH19zlLB6lU6lQbfF096lRRwDfApI14Sw7UFMvzh5sfS7cXPo+GduzaS8fcmZ7QBsxDK
         jZXHvOjnoukY+idDXmf58763FL0qUHU7JvSFOcB5uaNt9IsvrAMGbwmmT1AVzrexXVHp
         xSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743381623; x=1743986423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTi8tTiuzmW2svwLSuHqGg7YclWCnvqmfA6Gyx6yOyE=;
        b=ovACxTQe6xTa/L3rByqR5U2Yh/Sg5cblt+v0ca4qglAEFimZ12PPhVj7i0u6zRmFkc
         GtCPnMr7ANWUr9uy39HHN4NanngvldlZZuseUGnDnh8mGuQ6hRDlD32doG1XOpGQwQ47
         Ts7FM/EBTglp5WPm4V9CEqdlhEDoH5Cy78JUjAt/yVz8k5hjFHK4IYWdMy0CW1BorP+Y
         XKYPU2QgB7zCO0lfqLnD+FUAnBBEC8cgBXKtKi3kq8RclNkkxRpNzIBANfYaptNTicU/
         6zqIvg4C01yeAdbMN2g3tnrE8XabJvnEALwyyPZWfM7z1LcFpWE2MoZ5laekJpO7IMvO
         SYLg==
X-Forwarded-Encrypted: i=1; AJvYcCVQibeU8ltxfA2K91X8B/NXSmBYvYJHVqM0oX2CJRqCrWGYRNkCOhXQzc+NM5drj3QZ2D4=@vger.kernel.org, AJvYcCW48gvFjbeL61D/n1bNuusRaY5xqI/9DBuPXEXV7gbeYh0LhzGwQhHPAzom8KIPhiELR8mgaRx/@vger.kernel.org
X-Gm-Message-State: AOJu0YxD1TgRg0KrBfk6s3Sp4flLkzCslvLqrMmy3mLs1x413KTVUKqS
	ww2tWAWdwE0tjTlM4ED1cSJQHDtN8zwGrDfzdfaPja3ZetlL56Zyd3vFKpVQ9aV4r+MuD82f97F
	tIODBGKSo0o3aRDKPyZyuZQp4Qyc=
X-Gm-Gg: ASbGncuJLXKK3ZcAF+7b+/6MstbPUoBK++zd4qypisqbgHgb3n6Il8mAD6pMdFfX2EG
	B1DjcBERULUFqIe0ThxxuagYi3F3yjWApbM1zrSbWD4ZGbmPdKMb3O+rlBMw+TXW78eKBFfEJq2
	7s1BKDKyFn0bmm5Zdw+Ng+Wunz
X-Google-Smtp-Source: AGHT+IEG2me0G6zAaE4m/FhI4fxfPP7RqjG7OBqfejMtUHFMdpdNanLAAkYJUVIJcvHDCrEAbKpNqjkUXq2QCFL6aQk=
X-Received: by 2002:a05:6e02:17ce:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3d5e0a093b2mr76160105ab.19.1743381622902; Sun, 30 Mar 2025
 17:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743337403.git.pav@iki.fi>
In-Reply-To: <cover.1743337403.git.pav@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 31 Mar 2025 08:39:46 +0800
X-Gm-Features: AQ5f1JoVuXTXHl4OZ6-Pj0C0gXm60GE5eQjrZqTptP7zoCwFTx3OkG9S97GF3Lw
Message-ID: <CAL+tcoAvFCm9xCOwCLAp18JpT-JBzXQ2yziTZvO8QvZdL5gRZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] bpf: TSTAMP_COMPLETION_CB timestamping + enable it
 for Bluetooth
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Mar 30, 2025 at 8:23=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add BPF_SOCK_OPS_TSTAMP_COMPLETION_CB and emit it on completion
> timestamps.
>
> Enable that for Bluetooth.

Thanks for working on this!

It would be better if you can cc Martin in the next revision since he
is one of co-authors of BPF timestamping. Using
./scripts/get_maintainer.pl will show you which group people you're
supposed to cc.

>
> Tests:
> https://lore.kernel.org/linux-bluetooth/a74e58b9cf12bc9c64a024d18e6e58999=
202f853.1743336056.git.pav@iki.fi/
>
> ***
>
> However, I don't quite see how to do the tskey management so
> that BPF and socket timestamping do not interfere with each other.
>
> The tskey counter here increments only for sendmsg() that have
> timestamping turned on. IIUC this works similarly as for UDP.  I
> understood the documentation so that stream sockets would do similarly,
> but apparently TCP increments also for non-timestamped packets.

TCP increments sequence number for every skb regardless of BPF
timestamping feature. BPF timetamping uses the last byte of the last
skb to generate the tskey in tcp_tx_timestamp(). So it means the tskey
comes with the sequence number of each to-be-traced skb. It works for
both socket and BPF timestamping features.

>
> If BPF needs tskey while socket timestamping is off, we can't increment
> sk_tskey, as that interferes with counting by user applications doing
> socket timestamps.

That is the reason why in TCP we chose to implement the tskey of BPF
timestamping in the socket timestamping area. Please take a look at
tcp_tx_timestamp(). As for UDP implementation, it is a leftover that I
will make work next month.

>
> Should the Bluetooth timestamping actually just increment the counters
> for any packet, timestamped or not?

It's supposed to be the same tskey shared with socket timestamping so
that people don't need to separately take care of a new tskey
management.That is to say, if the socket timestamping and BPF
timestamping are turned on, sharing the same tskey will be consistent.

Thanks,
Jason

>
> Pauli Virtanen (3):
>   bpf: Add BPF_SOCK_OPS_TSTAMP_COMPLETION_CB callback
>   [RFC] bpf: allow non-TCP skbs for bpf_sock_ops_enable_tx_tstamp
>   [RFC] Bluetooth: enable bpf TX timestamping
>
>  include/net/bluetooth/bluetooth.h |  1 +
>  include/uapi/linux/bpf.h          |  5 +++++
>  net/bluetooth/hci_conn.c          | 21 +++++++++++++++++++--
>  net/core/filter.c                 | 12 ++++++++++--
>  net/core/skbuff.c                 |  3 +++
>  5 files changed, 38 insertions(+), 4 deletions(-)
>
> --
> 2.49.0
>

