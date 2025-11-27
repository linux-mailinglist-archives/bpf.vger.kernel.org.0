Return-Path: <bpf+bounces-75667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D9C905C3
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 00:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9CA14E3A73
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 23:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284B327BE6;
	Thu, 27 Nov 2025 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OliMPUV1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA63277B8
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764287329; cv=none; b=R00HeAvPWgLFauDVJdgbqTFBur4QmiAZsMXQ/z+eRH5/EHa/fQPPyvr5ZATVZ2/xyfAglEp1A4hyDu7lfx/334OOgUK7OXPTxB4iRy9QK/TaLg5V4K342rKMOX9hH/stVnBWH1Oduce2WWpXCrVUHpLYAMuB6n9XSFYD7NcaEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764287329; c=relaxed/simple;
	bh=YsduwoMsD8hIAekUKDxK/MSUACtfE2yvVw+moofjTR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvI9ALMXEZ2dFSBwvSi2RchzNTXU1oI9zumgFkM2Bs90s/mNtS2BTCtm4XuDs4oh+uvQPgqTWKKHc+oArQqtCIQLWPppqfkXGTUnPBPmA/Og43zN+uC6SJzwJiM1P7wAjTvPTfNrS3HrUpslZnqpBUyc5/9TSMpHR88QoWU9HUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OliMPUV1; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-43479d86958so7017305ab.0
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764287324; x=1764892124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PW1RKfkdQpyyU5Qki8GTuvVDzxfLQHQ2GUmA7S/TM0=;
        b=OliMPUV1wIXEINDdZB099CUtUlBCtuTFKdc91JsJxdPwQUe/DlqJlZ06d5sAlVWKm+
         Fm848SmymRHSMbd9XoGStDA15UMBL1YMhlusIMLvMbBww8piShgUhicNN6kUtfueQxtV
         pH+0N4BAPWwT6OtIONY6fAXx4dEHc1NhV9jsvKjZb4xaSHGKUT8DWD4RYSdIhGEm9vRH
         bOeB1gl39Wzyf34aiYk8LR+Whs3gVhi9ttgCaS7UDjR6a+Ic8pbhLqKpe4qOfd6VVVIb
         rk2u45/4o907/qQWTQMLbMD9acIhVB4FynW05cKmKMnx0q49Kj9KsHvw2+2+KrJz7mmV
         TaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764287324; x=1764892124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PW1RKfkdQpyyU5Qki8GTuvVDzxfLQHQ2GUmA7S/TM0=;
        b=Uzn6oq3nURbjCP7cdU57wfKljzGCMOwOc6KdtEWsbcpc32xWBQPIfiuGffqHOodzCW
         hSBZz0vHwa9sc1LMGwNSGdcnlVWcK40ZQ58OieJdL55OtUtb9AsNWCNXYhYXrgN8GBql
         jjtauxtoz+wxZqzHlKHjgkblfrGDjmYRRmy0SSOXTQXYJfGuo5jMtyxShk7qfp9zEjmR
         NKo7jULIZsuSa8ya4KAbOek/kGyk2jMiQ6833Z+UvHrw0V7ctsZKwn5wXx7GJB+2fRhM
         i9ckqwRsVU1Gzux30VdDIPV09cpohtPB0/6DyKjyJGSJTTo/T/k7QwZpF2QPx1v56uuM
         jvjw==
X-Forwarded-Encrypted: i=1; AJvYcCUpERdprks9HyHg+Dj/v+2xughra4oFYAHNC8P2SNcaEa23vNtAg790hrsx98I4mw4lhBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnQTZe1zy1cD88RzAYIkmenYOtp3+L5dpuE+3s/sZhNPXtIxl
	yfG/gjW0wChq3tG+/iQcx4/jyJ85jvAu64WQEwjC/W+WNtgqO5QbvOJhd0TqT81CKggM3ebf9Cf
	ds2vkAhwOaLkD8Nea3vkILo1hS1sjs2c=
X-Gm-Gg: ASbGncskl9XS9Mlam41uTEB6BJ9vi2Ey9W9wOGpL/gImETGiEGkxinfjMCABttZsYUj
	S9w29ffhBgwjJhYIxC4S2mOtATwlwBFml0A4fL1m5tTryw5aT3L4t/AD4A9OgrCYlpYnbzns59W
	TQEto4+z1xjrGFG++lGoZSZa+Wx5JgU6hnf75ooOi2oUOJphJegQz1az8n/BCEThs1jmZOkGEIi
	+ku9vhYUhGqhuhxZ0KWWw1/BMKTzPvU6BkfYbgMrqBWq9n3pOkgBIQ0WumWlEnvY3HBjz8=
X-Google-Smtp-Source: AGHT+IGSeOl1abZhEz6haRZS6F363yMwLkHnsQeAmDxWQ4dsIqhIhX11adSgTwjP6ka+EDTNz6LBI6qqtHbCVW6VAs8=
X-Received: by 2002:a05:6e02:2389:b0:433:5a5c:5d75 with SMTP id
 e9e14a558f8ab-435dd06a9f3mr103094115ab.18.1764287324153; Thu, 27 Nov 2025
 15:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
 <20251125085431.4039-3-kerneljasonxing@gmail.com> <0bcdd667-1811-4bde-8313-1a7e3abe55ad@redhat.com>
 <CAL+tcoCy9vkAmreAvtm2FhgL0bfjZ_kJm2p9JxyaCd1aTSiHew@mail.gmail.com> <f4ca72ea-e975-431e-9b7a-e32c449248ca@redhat.com>
In-Reply-To: <f4ca72ea-e975-431e-9b7a-e32c449248ca@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 28 Nov 2025 07:48:07 +0800
X-Gm-Features: AWmQ_bn1RrO6F9wHfjxgTzZoV5sAqGSoQ2rFYDySfa4EFa9ImHxo6OumszU2P8M
Message-ID: <CAL+tcoA7ZMsw1f6e=3WtpoyaT53cM9ryumcxT-b40VaUfuj-jw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 11:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 11/27/25 2:55 PM, Jason Xing wrote:
> > On Thu, Nov 27, 2025 at 7:35=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 11/25/25 9:54 AM, Jason Xing wrote:
> >>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> >>> index 44cc01555c0b..3a023791b273 100644
> >>> --- a/net/xdp/xsk_queue.h
> >>> +++ b/net/xdp/xsk_queue.h
> >>> @@ -402,13 +402,28 @@ static inline void xskq_prod_cancel_n(struct xs=
k_queue *q, u32 cnt)
> >>>       q->cached_prod -=3D cnt;
> >>>  }
> >>>
> >>> -static inline int xskq_prod_reserve(struct xsk_queue *q)
> >>> +static inline bool xsk_cq_cached_prod_nb_free(struct xsk_queue *q)
> >>>  {
> >>> -     if (xskq_prod_is_full(q))
> >>> +     u32 cached_prod =3D atomic_read(&q->cached_prod_atomic);
> >>> +     u32 free_entries =3D q->nentries - (cached_prod - q->cached_con=
s);
> >>> +
> >>> +     if (free_entries)
> >>> +             return true;
> >>> +
> >>> +     /* Refresh the local tail pointer */
> >>> +     q->cached_cons =3D READ_ONCE(q->ring->consumer);
> >>> +     free_entries =3D q->nentries - (cached_prod - q->cached_cons);
> >>> +
> >>> +     return free_entries ? true : false;
> >>> +}
> >> _If_ different CPUs can call xsk_cq_cached_prod_reserve() simultaneous=
ly
> >> (as the spinlock existence suggests) the above change introduce a race=
:
> >>
> >> xsk_cq_cached_prod_nb_free() can return true when num_free =3D=3D 1  o=
n
> >> CPU1, and xsk_cq_cached_prod_reserve increment cached_prod_atomic on
> >> CPU2 before CPU1 completed xsk_cq_cached_prod_reserve().
> >
> > I think you're right... I will give it more thought tomorrow morning.
> >
> > I presume using try_cmpxchg() should work as it can detect if another
> > process changes @cached_prod simultaneously. They both work similarly.
> > But does it make any difference compared to spin lock? I don't have
> > any handy benchmark to stably measure two xsk sharing the same umem,
> > probably going to implement one.
> >
> > Or like what you suggested in another thread, move that lock to struct
> > xsk_queue?
>
> I think moving the lock should be preferable: I think it makes sense
> from a maintenance perspective to bundle the lock in the structure it
> protects, and I hope it should make the whole patch simpler.

Agreed. At least so far I cannot see the benefits of using
try_cmpxchg() instead as the protected area is really small. Probably
in the future I will try a better way after successfully spotting the
contention causing the performance problem.

I'm going to add your suggested-by tag since you provide this good
idea :) Thanks!

Thanks,
Jason

