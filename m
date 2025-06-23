Return-Path: <bpf+bounces-61260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617BFAE34C2
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 07:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FD41891723
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 05:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65161C5F2C;
	Mon, 23 Jun 2025 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5NONZjc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7BA94A;
	Mon, 23 Jun 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750656744; cv=none; b=QykjeoJeAsV70g77f/lFZ67rww/mXhyAge5HLdXf5427p0dk9FBOl/LUUqObbRuZ9g81a41b+0HSKJaA3QUia1XfdNXtvPBt0rlkkZsAt+Hk1CBfC8qZTXpyhJmI4hOb4UeGMsGDf7w4183f35hR2nOrQwNcgjuU0PI3MCt/Yyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750656744; c=relaxed/simple;
	bh=E9z4e7s2uQVO9h0Ov63rqlGh/C2/1kMwsbmh51gr50k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUD3bycY9f4EOMnv1UoUlopsWF7H7HlI7GfHq2awaj4nbDl5XV4zuwv/D2HqXAc63WOwSEC8Cjkdbg6IVFnIfdjHWpuh7IFvA4GgawqvOTreHQTD958OXIUWSJXMWJrOLO/Y485Ey9agCAMRw6KFzNVfASCcnEaZvllA1eyv7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5NONZjc; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso36669735ab.0;
        Sun, 22 Jun 2025 22:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750656742; x=1751261542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7LciVUQWo6KzDlBpZAsr1crD+PFweTX3WBGTlA1qmk=;
        b=Y5NONZjcgaq8NJC3henWrd6Etg/8QTcO62PmDcM0cD4D8R7B25ovCDLNy5YtkFXwro
         tsmPUt8bNY/OX5QTa95fQDQJubjzLWedZMy0xO7hkQSylsVDqFM/y2J2Lxzxoq3MQnT5
         wPzQurBs5DxkjdyDAeCpDxOybgHDbVFy6wEZvOQGnZSvMCUtJ7m3NmFmzh/BiuIw4nLN
         IJjA26iKC54+KmxrnOwPmUve87z2tUpC80Mhve5MruoSFWWxEJRZR7B+U+wQVOI8OORH
         a/O0fH4Eq1iSK3o0dIS4cYkXLkwgO3CbGiKeFy/juV8CpDfN97YSl2nmkAVUq0wiV7Ew
         U5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750656742; x=1751261542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7LciVUQWo6KzDlBpZAsr1crD+PFweTX3WBGTlA1qmk=;
        b=Jv546kUdfE65J9nFlSHb6NmH9iyI+GMVq3256dRIT7RrH6yzqT0W5J2yK8xzpibO0R
         30LrCdz8q6qj6onJoUwbDzoQOus89wfLBm7EKJdyNT5ivQAXhTMJO9fq5T16pfnsWk0d
         zTIgw5aWkvz3QTK9ZbFPSUVQTaVVP9ozyv/7Pmx0JI2yuNV4aH4CLzV2WEtDKSE/z1Hp
         01U9cmuWar8ZTpfFOIPbNrlGzDjJazHJYLks+fRL9dhy9fIKzjmWchh00YIXbjV4xuRx
         8WkjO2UFQkSqr1wdVZryv0u86XwPsEvQOSh6fInhrLfaWh3XtcVY03ZUaKp4fOECaRb+
         iVCg==
X-Forwarded-Encrypted: i=1; AJvYcCW9tHPOvr5wyzud6UOCbTOdelLi3tMorvGTCw1j2Hd0pxqIZ1ucUThGCBRng+9oxmunBT8=@vger.kernel.org, AJvYcCXbPpn5pvRmr7+FB1jfsr1cH1oF9lLZ4SyQ8kagImr8mCJSeaOnSu3foQRHDZ1nIsvpZhxZVKyx@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJHMjeM4a98PZxt76+4UbR8yV+1Zf9h7KtREdSOpoHT4peiNw
	f3FGSjaPdjvO8zl9Nu7RH+oFbnbJ2zYdbdFsaorx8Ccc2ewmF6s37X3oc3php7jw8KT8D7WZ8aK
	Y3uWrQ702wFh9M/noNONESqbS+eM/+Z8=
X-Gm-Gg: ASbGncu/5XRxfk9Iy7Q5gryfusvXDt/+mSuh2sMDKpnjEs8eM9m4wpTjBOE629HjwKw
	IUXeCMcpObS7t0aBYkCSh1dVq12A4a3BIBCREF0p0tGTXwpklPX3dTwTQJFnTlAw+GWcITj0ELm
	gMQtXLdRQG97WfjGW7iN/ZxpJElBfkJ+ABmSEHpMSE3uk=
X-Google-Smtp-Source: AGHT+IFzy2XnGAL5HLGzTOwELofaRCvqkhnsEv9L2eYBrQSm9LJBBgzmQYRj3xu180tj0AKVIpbzlGxTEvnW8loGlxs=
X-Received: by 2002:a05:6e02:1fc4:b0:3dd:f743:d182 with SMTP id
 e9e14a558f8ab-3de38c2204emr133405675ab.5.1750656741820; Sun, 22 Jun 2025
 22:32:21 -0700 (PDT)
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
Date: Mon, 23 Jun 2025 13:31:45 +0800
X-Gm-Features: AX0GCFuZpFXovIUu_6Eyhadg_XHtrhRm97hDqysS8Uh_fDzZ7rFbKiVlCgDd9mI
Message-ID: <CAL+tcoDHe=bMESuJe-zVXyU6r7QHmZ3w6CK0g=N6Dqvf8ONh3g@mail.gmail.com>
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

After digging into the logic around xsk_tx_peek_desc(), I can say that
at the end of every caller of xsk_tx_peek_desc(), there is always a
xsk_tx_release() function that used to update the local consumer to
the global state of consumer. So for the zero copy mode, no need to
change at all :)

I will soon send the v2 with the 'if (error)' statement in the
__xsk_generic_xmit().

Thanks,
Jason

