Return-Path: <bpf+bounces-72187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13FDC08E74
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 11:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743561A6702C
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D42E2DE6;
	Sat, 25 Oct 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjkoloqU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA91531C1
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761384520; cv=none; b=NlEKT3u4W7LqyjVM7CTOk/wAPaVdJlRFD9qw7m93/t2r6OL+k/pcABwiPaAN5YGtDFPm/OXu9IE9ajo8ikvEQ+fjIOdPFVc22ZHgiwY4ItwP32KhAf0iQklcP+1rhaLfS0BU4AngMcnYPscTPBGWYK8H8Oxu+Eln1LvPemUn+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761384520; c=relaxed/simple;
	bh=vkmTLMpvpm/Qa6GR83vugp7lS0yOQgGxQYJ58GDReT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9UYiilSHJJQpO68nfNED6PzJrqEvN+ua36y3rPydmiMfxparhZm4ThoPZmzz4yWcoawbrPcWYLy+13AgkUbxfKj7ZIlgrZq09deJTsaT6fsIeBgQVAIiQVF68pyv30fgdrLJugyJGlC4Dv+fAMbLn2eMa/aT++zbsdvmvLG+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjkoloqU; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso29028575ab.2
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761384518; x=1761989318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHS+rYA72OACrxZRCGvYNKYLOg/36EJkZI8te9neMR0=;
        b=BjkoloqUoTgzTbOxZJFzL1o6OrrIVXzhxRwCEdyPPwlL1OSx1cjxH5hCS5+KHfe6j7
         t6AF/yIXQHSEMk2IFVVEhfKq7VjkYrlyfYuuktbdWeG3Ps5/o+85XmyJlthnCw38DBYO
         jV1Ag3upZxSkOnTLlQf3NL2kzlqkuizmJxkfeI4iMDCW+bpgmW3AtvJl/cMBeK0YmNWc
         iKjIcWUyPsBR6BdvyEHel2Y9XyqI3BKxVMzsa8ZFqTDFqQj15PAfbJZlpJsr7nlu/oxD
         ax8PekEYV0WgTl8BaN46o4Qol0TlLgJszvvKgrRy9gUGgolvLlbUBz0DjIUuUyeU9eQX
         YzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761384518; x=1761989318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHS+rYA72OACrxZRCGvYNKYLOg/36EJkZI8te9neMR0=;
        b=UxvqkpZoArk13c38HzkvZl2MIAeqZ1qUgAeFpIlkECZMG/eZ+A+hz5S7xxrvJ39A+n
         /z/j4fSFVUDzuCUbX2kNOh86BZt21bzvf8kZUxYq6F5+jED/TvzKPPCRenTvji5siMgU
         R5FaYBgkeEjNiEpqRdBigW+cqBpFoHwME8hygwqnepufztMKaB1QsNxEv7lAMXOdSfpn
         c/8dX4ZvLC6i0Uy/H36zptT2kywsl8N9OdNk+6kqVOtiapnW8d24bqkejX1m/KVblDgA
         ixs4mgVYs6I5tDeEU+hXmMOBfFYfXHBBX/y1v1obGJ70NVud0qIXMpcogFe+w82BjTme
         oV1g==
X-Forwarded-Encrypted: i=1; AJvYcCUmLAhxKZREulWWUjCVRsqLP+qzaRptAA4SXOLeX5ix2TkUuzFqnqcE0pwxScDOTUUXcpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiV13J7R1iCm/6fRYaLQrT9e9LUAOU+IghpugJa70T2QDPx2Tk
	7jQN8RsF3KT/bnVqN2kV1xhOMJozVOl8h8yV2f9fTwteHB5DiRmqk6okQwsRA25gIfYOo09UPf2
	v0Su1Ldia7CNP817N3Ra1zEGVGg3/Szk=
X-Gm-Gg: ASbGncshFOLgYwduB3ulTud6t1cNRZEobkb6XOAK4x8KFyN+kV236ZdcTd6/f3S8jol
	y5J+3OdkqrNI3Ai7R+JhKCXK6SbOvZrZ8uJmLYK0niQNlzWsP0uac5SPr2PPZLNPvNioSvBs243
	VRAsq+PQy2RaaDJ4mVF7IcSCIYP7EIvkKp0LW3yyRA3U7Kn8KsR/6YQ4j1M+FEkv8uIfbypwD43
	SOYjtGaJHdGTLYqjU4qWAplo+3tZYQ4FKFufH1eW/FnSdWB71tucQyitaKRlxRvg5+AAQ==
X-Google-Smtp-Source: AGHT+IFrWh7z4CTVFu9vQ+xrjaz9LS2N1hcONurg46hZNqNrD28GNm/jDCqkOjutDT1/E7m6lZeIKMuGVQSjjz/6S/I=
X-Received: by 2002:a05:6e02:164b:b0:430:a8c5:fdad with SMTP id
 e9e14a558f8ab-431dc139f37mr127440375ab.6.1761384517763; Sat, 25 Oct 2025
 02:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-9-kerneljasonxing@gmail.com> <aPvK0pFuBpplxbXX@mini-arch>
In-Reply-To: <aPvK0pFuBpplxbXX@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Oct 2025 17:28:00 +0800
X-Gm-Features: AWmQ_bmu26OzQyT-TKJbwhXorr2a6Rp88JdSnJEBmxfy2w_9MDKpR8qmaP4z0GA
Message-ID: <CAL+tcoDssz0zPY3iKS5Zv6C0zq1ChbTZhRbwTPRq_6F0U6Jc8A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 8/9] xsk: support generic batch xmit in copy mode
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

On Sat, Oct 25, 2025 at 2:52=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/21, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > - Move xs->mutex into xsk_generic_xmit to prevent race condition when
> >   application manipulates generic_xmit_batch simultaneously.
> > - Enable batch xmit eventually.
> >
> > Make the whole feature work eventually.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 1fa099653b7d..3741071c68fd 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -891,8 +891,6 @@ static int __xsk_generic_xmit_batch(struct xdp_sock=
 *xs)
> >       struct sk_buff *skb;
> >       int err =3D 0;
> >
> > -     mutex_lock(&xs->mutex);
> > -
> >       /* Since we dropped the RCU read lock, the socket state might hav=
e changed. */
> >       if (unlikely(!xsk_is_bound(xs))) {
> >               err =3D -ENXIO;
> > @@ -982,21 +980,17 @@ static int __xsk_generic_xmit_batch(struct xdp_so=
ck *xs)
> >       if (sent_frame)
> >               __xsk_tx_release(xs);
> >
> > -     mutex_unlock(&xs->mutex);
> >       return err;
> >  }
> >
> > -static int __xsk_generic_xmit(struct sock *sk)
> > +static int __xsk_generic_xmit(struct xdp_sock *xs)
> >  {
> > -     struct xdp_sock *xs =3D xdp_sk(sk);
> >       bool sent_frame =3D false;
> >       struct xdp_desc desc;
> >       struct sk_buff *skb;
> >       u32 max_batch;
> >       int err =3D 0;
> >
> > -     mutex_lock(&xs->mutex);
> > -
> >       /* Since we dropped the RCU read lock, the socket state might hav=
e changed. */
> >       if (unlikely(!xsk_is_bound(xs))) {
> >               err =3D -ENXIO;
> > @@ -1071,17 +1065,22 @@ static int __xsk_generic_xmit(struct sock *sk)
> >       if (sent_frame)
> >               __xsk_tx_release(xs);
> >
> > -     mutex_unlock(&xs->mutex);
> >       return err;
> >  }
> >
> >  static int xsk_generic_xmit(struct sock *sk)
> >  {
> > +     struct xdp_sock *xs =3D xdp_sk(sk);
> >       int ret;
> >
> >       /* Drop the RCU lock since the SKB path might sleep. */
> >       rcu_read_unlock();
> > -     ret =3D __xsk_generic_xmit(sk);
> > +     mutex_lock(&xs->mutex);
> > +     if (xs->batch.generic_xmit_batch)
> > +             ret =3D __xsk_generic_xmit_batch(xs);
> > +     else
> > +             ret =3D __xsk_generic_xmit(xs);
>
> What's the point of keeping __xsk_generic_xmit? Can we have batch=3D1 by
> default and always use __xsk_generic_xmit_batch?

Spot on. Thanks. Then I can fully replace it with the new function.

Thanks,
Jason

