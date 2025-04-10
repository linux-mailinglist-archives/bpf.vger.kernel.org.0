Return-Path: <bpf+bounces-55694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661EFA84F74
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 00:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5CE4482AB
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 22:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81012202F7B;
	Thu, 10 Apr 2025 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPmFKTzm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE3EEB1
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322551; cv=none; b=WlcUMccQ4i/KHOUgrrOuAIxv+Bv75HsQ66Ml9MOe1hZ2OxeCyW6Fy/hYMdn5Ym4xif0swrmMEYO8fqXHWh7kVTt6teIwrzWc8v9TLEQe7FgxbMi0XX8fnr3J2rKmqucHQoP9shTQ7/Sx2rCL9wPASErLQRJYmcqumr5gSsVb1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322551; c=relaxed/simple;
	bh=IZYGw+95dlQpZ71EvfbN2r6k9R2LiBt8kel24Dwzi14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLx97TTlkgpjpWYT8dFGyBEwV7QebKDwHacrsOuuekoTXkV3ly4kyg+5R/DIk6BD7YOhz2CI8JjyOOho/uyTc7l9xfqDETfHAnG+jFMHn0WFIWkJZoUZN4nkAaVzKmRa7QC+Tg3lwFZHHYPSf42jIh2tyOFLZwdcT9zLKt/AJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPmFKTzm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso14547485e9.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744322548; x=1744927348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPMpa+oLAKEPdnb134Ebp7PsiMxwFdAwiTYRw3R/N1c=;
        b=dPmFKTzmeu7lPRVc34MCi8cilSS/JdD6RtKnOlQ4JTAhrz7+vzFYHpe+ufyHc1/PMd
         YkZvYPj/ynQSU7p0Wh/0UKSPTKaIgWlmpcjLiVd7CHjxKiIk/RcGfX7AzsthGQHeW+Wr
         vCk8f1n5R1LSdqUxkIgrRKNwpj0tH9H0zH8uP0Bbo13bn/XKBGSFVIAgdKk2zw3mTXh3
         l7YJRbUBlGlc33WGM//GR4s54VsOm6+tBMMY/xOEzeMUSKxa85oQ2nWJsClFNFarPggT
         qtxMGeVEb6SXx1QDLgi78Kzj4K6aGVlyDbG9iteVWDJBBsfCLxsSb1ZRKzpfyaGhFplX
         IQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744322548; x=1744927348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPMpa+oLAKEPdnb134Ebp7PsiMxwFdAwiTYRw3R/N1c=;
        b=c1R16uDrX1o3dlbluCi+ISvL2jMtpEP3wJCik+suz75gyPYcxPv40zcAauIe06UIq+
         7MglNq5coTmmEHwzXUl4Hdj4qWsk8HqZfMFNJveZJAe8tG93mut6Zh60Yd5fjU3C3nKf
         0S2qETxPR33HjUhy2CSJOznylbkykKvDoJLcfA1IhTqOMEFBE7rSZyLDy6phZdTWeZ3Y
         IWgrE4PVOH9ZrOjZiSsvKI71npZl6nJOuGUWOFs9twT2wUAl8H+57mK7/H0xb117aEgX
         p8cY1nNS8gQw4cYR3/hO2t2xwq4eNmOoKS0wk9yX0h0eH84sYxzHrwJ11fXLmUMFh4xZ
         AVgw==
X-Gm-Message-State: AOJu0YxhY68teVgclElVjkc/NkpcXt2ooE7UF45MYB25c253yQFH4l4Z
	1AdcsbNkUwGVbgnjZXZexiBISjQ43gpmskLSx/x46BaN///yvmW4q7yEQnNyT8tP0LVqGALpDDh
	rWjSSGP8/LC77RyzIb1oPJZZwg24XjA==
X-Gm-Gg: ASbGncs9LKobgh9ZLYXuUrR/QhVJV6U/BgWN1MJpDHxW6YpBgAfsb4gP3A30POJwlBs
	8To+swFBJhRzzriOHm5fVQmI3shU2ZfIP95GdLbgq4PpzaK489P5Hvss5DUxCUTjD1UGRzJYd5/
	45qTnb6nk5Joe+t6og/9uwYpTYAKEXr8YfCFYpjg==
X-Google-Smtp-Source: AGHT+IH8gRjycYuA1H7Sigfd7BuhVKS0cpkyKGOK9SBmHLj/g7EavxT8QR8rLA1fxLJ9T18ljjHnDG0H+HvFF8J0Yr0=
X-Received: by 2002:a5d:64e6:0:b0:391:2d76:baaa with SMTP id
 ffacd0b85a97d-39eaaec75cbmr235194f8f.46.1744322547446; Thu, 10 Apr 2025
 15:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410153142.2064340-1-memxor@gmail.com>
In-Reply-To: <20250410153142.2064340-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Apr 2025 15:02:16 -0700
X-Gm-Features: ATxdqUGBl3hZfOmrje5smR0uf4HhSjux73rfCKnfrQMk32gyitt_OcZZFSeGp7w
Message-ID: <CAADnVQ+uMU6x_FUTJchuzwPenAYCcwUy8FtUhU+7YvgGD-OhHQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Convert queue_stack_maps.c to rqspinlock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
	syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com, 
	syzbot+252bc5c744d0bba917e1@syzkaller.appspotmail.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 8:31=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Replace all usage of raw_spinlock_t in queue_stack_maps.c with
> rqspinlock. This is a map type with a set of open syzbot reports
> reproducing possible deadlocks. Prior attempt to fix the issues
> was at [0], but was dropped in favor of this approach.
>
> Make sure we return the -EBUSY error in case of possible deadlocks or
> timeouts, just to make sure user space or BPF programs relying on the
> error code to detect problems do not break.
>
> With these changes, the map should be safe to access in any context,
> including NMIs.
>
>   [0]: https://lore.kernel.org/all/20240429165658.1305969-1-sidchintamane=
ni@gmail.com
>
> Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000004c3fc90615f37756@google.c=
om
> Reported-by: syzbot+252bc5c744d0bba917e1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000c80abd0616517df9@google.c=
om
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/queue_stack_maps.c | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)

pw-bot and pw are down.

This patch was applied.

