Return-Path: <bpf+bounces-61188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 462B0AE2011
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F391C2160A
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C22DFA57;
	Fri, 20 Jun 2025 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmW2DxtZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D928937B;
	Fri, 20 Jun 2025 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436806; cv=none; b=eunVNPf+fmNERZmoDpCCtNN+awH88JkxK44BR6d04dG4D0e7OBZ0gstYZyXQWjoeonxZPbQhUFYtHsZIVwa0Rg+FaklrXL3JDvrN92mzJr2iHxc7veJjbSQuUnZwlesj/dvdt1LcTsS/J0f15uTF2p1Lc/HQowp0wxhqIpmj0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436806; c=relaxed/simple;
	bh=QNBjxIfGuRqEtLTOpu/Dyea9Qwe6PKHjiYv0TnDII/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWn5sFTq9HCwIRDra0olH7EQtIbvI3ImxFtw5RSl+od3SO2KKM46f+iDLYztxPf30NtibApL7fZXAKWYq9/Q6delxYGy5/vh1Mf80ATwgWz03wQ5l2JgqKvce1H/wnAWM3QzWht5Xcf83fuCrJKgfbMjLNurSyMFqInFleKY7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmW2DxtZ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3de1875bfd4so8183545ab.1;
        Fri, 20 Jun 2025 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750436803; x=1751041603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPj9vXF/haHIu7KdTvp6A5jvrauJQopfSYXCbwbTtNc=;
        b=hmW2DxtZQWo2/dczUGIhNGAv8YX/bbjl731DekKdF4sKHCEqOnm9jycYOhKx4DjIrK
         rsl7HOeq7Og/XTG7A4lOJDX0O6XEz2tY2Q2czzFpnlIWIihn/NgE4Yb2foQqlOhnrVV5
         4mDWtEAsg/OjBfb0RfLyUFnOpWPh7NcBm0yPtjij1i2HsX0/1fQgb59p4n5g9s1U6hgH
         dpkFIuxKZ78iz13pFYwFNjeKF00P/eGJbxl+Zx0VKcH0oNWrkMjdV+XAoR0jfr572WsL
         zC4R1ciD0FyxhNDrGd5WKdlvG7RyuP2BqAOd+PWNQqfHzaU/4PkyzD0uPi1GbHJuVOQ4
         LlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750436803; x=1751041603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPj9vXF/haHIu7KdTvp6A5jvrauJQopfSYXCbwbTtNc=;
        b=gfX9V9CMwgySUUPHBcqC1HwipfXRx9YuxwR9dozTkfjWsYJy6kAykgySnBz9IOdpQM
         8oqK7AJS6Q57uPsGuFgfYEIbCsfO7LEfb0gSl7kgjfO796Z0+a3MunqbxOQPoGyq4XU8
         SUOWObH0c04rrUlfFERnKuUukIXvuWxKxyO+qwLPzmWDhRxXL745/iQrryIT8koWTCBn
         cRllQNhud2i6N9qaO3iXgQ/EWTIAxr377KWtKcBBfk83fgJg2U5EeHokFdZunvIiDUV+
         GFBe2HWV8SR2RfQIcwqZAa+pwNEwLyz0OLLd6DJ2E9njBEWolqLoJDPpSdpBpDhJ38L7
         AoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKzEIP0L+6tp5NWYOVWAoLvZEZrGjHmxO+6wwhfk1ytcRO6xiO2oUN1iPFCn7KmCwaI70tIWRB@vger.kernel.org, AJvYcCVnYygpR/Fsg+GkUQ+ttrGt0ki4aydR1KXGpzuCps5YebBS+/WinptWAbWO2z2YFXp2JkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPgr1gVSdZLmL4Zqs2UEWII4neJ2GYdT+rskVu8Vxn5Q2jda1
	AZN4qvdWFzjsTn7ae8GZxPaXT8B+9fHDeo+dW2hkvExSG5HlDt3EaTQ46LgqbSwQ11NAlRCjLur
	uYjD9ZwlA+Cro+UDYwP//UqGpKCe/qNA=
X-Gm-Gg: ASbGncsf/JcKRuGnhWwfGDYcHw4vb2lKIxil4bN/72Bu+WIDBTgMAA3m/U9zAKVbDDt
	BlBAxQtOJAo59ukoADg1NWAFblM0HtE0pEpQOFk6AhYNtBC/E5cK7r1npx5OU26H9N1EvS0/D2i
	0b6PCxPVY6hll89LUcZNjK1jC11GJbCF5HjvCcIHv6nSs=
X-Google-Smtp-Source: AGHT+IFF/MSS6LG1uXWwc1hy3Z4g6azHbL5reDKn6gkrWnDL/EVPHGh9mYk6hbAtvUFyTjteNkEmZFBdCmnmOJoJ8cY=
X-Received: by 2002:a05:6e02:3c86:b0:3dd:babf:9b00 with SMTP id
 e9e14a558f8ab-3de38c1b8d9mr40681285ab.1.1750436803283; Fri, 20 Jun 2025
 09:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619093641.70700-1-kerneljasonxing@gmail.com>
 <aFVr60tw3QJopcOo@mini-arch> <CAL+tcoBLAMWXjBz9BYb84MmJxGztHFOLbqZL-YX0s7ykBjNT7g@mail.gmail.com>
 <aFWFO2SH0QUFArct@mini-arch>
In-Reply-To: <aFWFO2SH0QUFArct@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 21 Jun 2025 00:26:07 +0800
X-Gm-Features: AX0GCFvHwhc1_wLO9Px3cWXyAScsjDmdYgSH48QGgVyulliogmMRp5sxiSVHDC8
Message-ID: <CAL+tcoDu-h8crLBsxTVCy6D30vgcB6aarjOpdXE+f4kX1NM8_A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: xsk: update tx queue consumer immdiately
 after transmission
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 11:58=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 06/20, Jason Xing wrote:
> > On Fri, Jun 20, 2025 at 10:10=E2=80=AFPM Stanislav Fomichev
> > <stfomichev@gmail.com> wrote:
> > >
> > > On 06/19, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > For afxdp, the return value of sendto() syscall doesn't reflect how=
 many
> > > > descs handled in the kernel. One of use cases is that when user-spa=
ce
> > > > application tries to know the number of transmitted skbs and then d=
ecides
> > > > if it continues to send, say, is it stopped due to max tx budget?
> > > >
> > > > The following formular can be used after sending to learn how many
> > > > skbs/descs the kernel takes care of:
> > > >
> > > >   tx_queue.consumers_before - tx_queue.consumers_after
> > > >
> > > > Prior to the current patch, the consumer of tx queue is not immdiat=
ely
> > > > updated at the end of each sendto syscall, which leads the consumer
> > > > value out-of-dated from the perspective of user space. So this patc=
h
> > > > requires store operation to pass the cached value to the shared val=
ue
> > > > to handle the problem.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/xdp/xsk.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 7c47f665e9d1..3288ab2d67b4 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -856,6 +856,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > >       }
> > > >
> > > >  out:
> > > > +     __xskq_cons_release(xs->tx);
> > > > +
> > > >       if (sent_frame)
> > > >               if (xsk_tx_writeable(xs))
> > > >                       sk->sk_write_space(sk);
> > >
> > > So for the "good" case we are going to write the cons twice? From
> > > xskq_cons_peek_desc and from here? Maybe make this __xskq_cons_releas=
e
> > > conditional ('if (err)')?
> >
> > One unlikely exception:
> > xskq_cons_peek_desc()->xskq_cons_read_desc()->xskq_cons_is_valid_desc()=
->return
> > false;
> > ?
> >
> > There are still two possible 'return false' in xskq_cons_peek_desc()
> > while so far I didn't spot a single one happening.
> >
> > Admittedly, your suggestion covers the majority of normal good ones. I
> > can adjust it as you said.
> >
> > >
> > > I also wonder whether we should add a test for that? Should be easy t=
o
> > > verify by sending more than 32 packets. Is there a place in
> > > tools/testing/selftests/bpf/xskxceiver.c to add that?
> >
> > Well, sorry, if it's not required, please don't force me to do so :S
> > The patch is only one simple update of the consumer that is shared
> > between user-space and kernel.
>
> My suspicion is that the same issue exists for the zc case. So would
> be nice to test it and fix it as well :-p

Oh, well, I will take a look at how the selftest works in the next few days=
.

Allow me to ask the question that you asked me before: even though I
didn't see the necessity to set the max budget for zc mode (just
because I didn't spot it happening), would it be better if we separate
both of them because it's an uAPI interface. IIUC, if the setsockopt
is set, we will not separate it any more in the future?

Or we can keep using the hardcoded value (32) in the zc mode like
before and __only__ touch the copy mode? Then if someone or I found
the significance of making it tunable, then another parameter of
setsockopt can be added? Does it make sense?

Thanks,
Jason

