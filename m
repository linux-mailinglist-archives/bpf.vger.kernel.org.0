Return-Path: <bpf+bounces-61522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA46AE8327
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 14:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FBF178959
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03526156F;
	Wed, 25 Jun 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L36Fm4ho"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5B25D1E0;
	Wed, 25 Jun 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855818; cv=none; b=hQN7vIYJoaGg3y8KcO+Lm2Df9jAxnHsgHgZhDhKnouyRh+i+f9oe8p9BbcwVr76nzxtg5ncViRXW8NA3TWCsjecbgvMUpVo4Zs59sTCUbPUg3n81OjsVPCI5I50wQeVhmTXeYrRWjrJ8TOAUim7D8Y+M8vFQ9Oo1IcQh0mN+Afc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855818; c=relaxed/simple;
	bh=QLGFzP3/sxNPrkfh2CP+Tmg64IAG2Scn6S3cbmRklr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUD6jkQE+fG1a/lxDhg22KauK42F4zl3hLwWr8zjg32NJF+eGYvKXVwulBwLH6RkMduBO3nTBydeUj4J9zcruN2TCkhzahsJozx3qqQ7JNxC1vhSMBoiSXhF6GEJUQ8guqQ1aHgT0Um8AX+6w4za3GShCAmOB1UJz73gx3jhAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L36Fm4ho; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86cf9f46b06so216619239f.2;
        Wed, 25 Jun 2025 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855815; x=1751460615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEB+t9cZhMhKXuNVDSpqcCgPij5UADE4sfitMU0dBr0=;
        b=L36Fm4ho3pLVCuTMbpD6erwzR8e2EjzDrIuswakDJKlmTH+pHCV2HqqxQ91jPw9cHe
         8lDL2n6MV3XORKI/Jp3g3k3oUHrTnPnazQDh5TgmY79UoBfhU9euff1sEvkhpoJBA2tI
         W85QhtyLdEn9QEjxdULyGS8ntCaeGo4sMrjBOHxEkkQ24GOzbH33Fwc2h52k53dBhuBG
         AxgaaOWKo9SH2xSdhQo3vRPPtx6CtPt/RxU+VH9rU50MSdskaVfvfeEsFzOZbRFmiOkO
         LUV+BtxfWiGtahtpHkhTaeRXM7bM5rSBCN6DH85pFDHEQzC2kFsVCSLI17LbgV2RElp+
         xeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855815; x=1751460615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEB+t9cZhMhKXuNVDSpqcCgPij5UADE4sfitMU0dBr0=;
        b=jWuI2EAkFtmUIvqN5QaYmC1zowTA78xyuWlN/GYvU3a4kmehrXL5IT71BzySRItshG
         t3avfvr2+bZcYodR6oNzYHDllSLrTPSo3w8RDDnO/Bm2sHTdIKIV7qxG9dKtZVquBxZu
         zSUiUoQO5O5Aaq5HEWnwdiq+jXY5SFju9zKzYQZSAX9s8kgzDeKRUwEQk5GDECBl7JXY
         +Zu4hNNrqgS2Jm2STrBmtxmXN32ZWpAAjgDR5HoTcMtx2VAU6jgTHlIICHlGGo5xlvTk
         ZeYzU62pp+EohM9AMHwuFoScXO0hmxKPNYass57rC2k3iveaHMdCdc7sf4xaKPkSMLBO
         PHXA==
X-Forwarded-Encrypted: i=1; AJvYcCVRc5KFMqix/0NvYJw3OFY5eMxuMAa6zDBH+7cQJbZUBB5k3TlqO3a4Ug1Zwi/u+t2+9Bk=@vger.kernel.org, AJvYcCWmTVpVG+yF6Mh16r7OtnzgIG7H+nKZklbyH7zA8IBR4KZtCq7o5BrZeQKv/M6ehhqfj5euf3Ae@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz3vEO+o8DtsFa/KMBiJ5GaVHTBXM9tW4SoV3FV960Ay7CBHJW
	d0kPL8LDm2iIDQrKJv7Ft7gJpkc0Bd5Lg66h+TUjK53EtZd+K1PVKR0fIQEGp1ZjuPnDOlCSqGA
	kZ6eVEhMRXHKx/vCHafVYdbwJBtihgho=
X-Gm-Gg: ASbGncsdX35l1jrUjBa2TI/9PwXGAWfTJKuzqoWezqJZaY/OcmAcFz70jviz1NZ9elh
	DGOW+5Boi7wSofU4FdqU7TTpleB2Fp24zzsqxWGRPONy/k/ZBX03lScre3dg7l014VHeyldVnDG
	ExWo5z9jCDt8wKsN2zr8gHb0VShcmOmbNi0A+DE5H2RnI=
X-Google-Smtp-Source: AGHT+IFJblhjspcL9/xJzcahHCa03/6ApQYMcbTIledhe3BA10tbDbNZGa7Ygqlui7ZUNY7gnHtQNoN8RMjuHQiBuVo=
X-Received: by 2002:a05:6e02:1789:b0:3dc:8b29:30b1 with SMTP id
 e9e14a558f8ab-3df3299f953mr35562645ab.14.1750855815228; Wed, 25 Jun 2025
 05:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
 <20250625101014.45066-2-kerneljasonxing@gmail.com> <aFvY10KkS9eUbcOw@boxer>
In-Reply-To: <aFvY10KkS9eUbcOw@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 25 Jun 2025 20:49:38 +0800
X-Gm-Features: Ac12FXxSgQDtJuisoQNMD07REoeT0RG7U_jUcSi5OKYd-dziDZCmw0xIPTOI5RM
Message-ID: <CAL+tcoBfg-HfMxYHTnP6xb0ZWp68KiP4R0U-AdUt9UE=UJYCkw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: xsk: update tx queue consumer
 immediately after transmission
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Wed, Jun 25, 2025 at 7:09=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jun 25, 2025 at 06:10:13PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > For afxdp, the return value of sendto() syscall doesn't reflect how man=
y
> > descs handled in the kernel. One of use cases is that when user-space
> > application tries to know the number of transmitted skbs and then decid=
es
> > if it continues to send, say, is it stopped due to max tx budget?
> >
> > The following formular can be used after sending to learn how many
> > skbs/descs the kernel takes care of:
> >
> >   tx_queue.consumers_before - tx_queue.consumers_after
> >
> > Prior to the current patch, in non-zc mode, the consumer of tx queue is
> > not immediately updated at the end of each sendto syscall when error
> > occurs, which leads to the consumer value out-of-dated from the perspec=
tive
> > of user space. So this patch requires store operation to pass the cache=
d
> > value to the shared value to handle the problem.
> >
> > More than those explicit errors appearing in the while() loop in
> > __xsk_generic_xmit(), there are a few possible error cases that might
> > be neglected in the following call trace:
> > __xsk_generic_xmit()
> >     xskq_cons_peek_desc()
> >         xskq_cons_read_desc()
> >           xskq_cons_is_valid_desc()
> > It will also cause the premature exit in the while() loop even if not
> > all the descs are consumed.
> >
> > Based on the above analysis, using 'cached_prod !=3D cached_cons' could
> > cover all the possible cases because it represents there are remaining
> > descs that are not handled and cached_cons are not updated to the globa=
l
> > state of consumer at this time.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v3
> > Link: https://lore.kernel.org/all/20250623073129.23290-1-kerneljasonxin=
g@gmail.com/
> > 1. use xskq_has_descs helper.
> > 2. add selftest
> >
> > V2
> > Link: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxin=
g@gmail.com/
> > 1. filter out those good cases because only those that return error nee=
d
> > updates.
> > Side note:
> > 1. in non-batched zero copy mode, at the end of every caller of
> > xsk_tx_peek_desc(), there is always a xsk_tx_release() function that us=
ed
> > to update the local consumer to the global state of consumer. So for th=
e
> > zero copy mode, no need to change at all.
> > 2. Actually I have no strong preference between v1 (see the above link)
> > and v2 because smp_store_release() shouldn't cause side effect.
> > Considering the exactitude of writing code, v2 is a more preferable
> > one.
> > ---
> >  net/xdp/xsk.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 5542675dffa9..ab6351b24ac8 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -856,6 +856,9 @@ static int __xsk_generic_xmit(struct sock *sk)
> >       }
> >
> >  out:
> > +     if (xskq_has_descs(xs->tx))
> > +             __xskq_cons_release(xs->tx);
> > +
> >       if (sent_frame)
> >               if (xsk_tx_writeable(xs))
> >                       sk->sk_write_space(sk);
>
> Hi Jason,
> IMHO below should be enough to address the issue:

Sure, it can.

Can I ask one more thing? Technically it's not considered a bug,
right? I'm not sure if it's worth telling the stable team to backport
in older versions.

>
>         if (sent_frame) {

Using this condition means the consumer is updated in majority cases
including those good cases [1]. The intention of the current patch is
to update the consumer only when the error occurs because in other
cases xskq_cons_peek_desc() does it.

[1]: https://lore.kernel.org/all/aFVr60tw3QJopcOo@mini-arch/

>                 __xskq_cons_release(xs->tx);
>                 if (xsk_tx_writeable(xs))
>                         sk->sk_write_space(sk);
>         }
>
> which basically is what xsk_tx_release() does for each tx socket in list.
> zc drivers call it whenever there was a single descriptor produced to HW
> ring. So should we on generic xmit side, based on @sent_frame.

As you said, they would be the same :)

>
> We could even wrap these 3 lines onto internal function, say
> __xsk_tx_release() and use it in xsk_tx_release() as well.

I can do it in the next respin.

But I have no obvious opinion on how to write it. If no one is opposed
to the taste of patch, I will follow your advice. Thanks.

Thanks,
Jason

>
> > --
> > 2.41.3
> >

