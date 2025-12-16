Return-Path: <bpf+bounces-76689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C22CC1142
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 07:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E677301C933
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE36833D6DC;
	Tue, 16 Dec 2025 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlobOlEV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893B33C525
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765865971; cv=none; b=LtPh5/pVKAt1F3F0gALm8QoKDoI64nMWlK7S49pWk4lP+9xZpxicimAL2pYdSH01PXRr5aSmB89fOK3jtqxJCCUZFodEf316YBlwh/rGCe4YtI9MNVJ4qkXIT239qO8HxUTYEzDaKkD1N7hUpTBXT3hJ3VFHV8UTl6U7Yy8WLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765865971; c=relaxed/simple;
	bh=pZtl3hclI/YVZs/mocw9Ud06k2UyIyQhmqh/2CTzXTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGTry60raZDdpmT6QM5wdrJXKnBGdCYBBWM4zgAjtN+Gg0YRB9d03LbUj1qeUkAldXQYYW0k1Hslajd5hWPs8lL1R/svJx6KfKYJTBCGAVGNPDGTsQzzTOOJ/Im4XGgmxVlAvU2uPPm1DiPA/XU+4BWdNjtPEqKZLHwU+E4XicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlobOlEV; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-657523b5db0so1260178eaf.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 22:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765865963; x=1766470763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwbmoXbPjGCi6tDWqsOk1Z9HEPGkbvpnV1+pVc88VLU=;
        b=TlobOlEV7ToSMqRyX7o+qhFslQzfry3OW4CHp9OK06TyxHXZ83CRWKbz0B7+yHimEr
         qRe3m/WQESpj4C0Fo+5o9ZkfLnD0F5a+zyPgBgig2ZlwUv1+LZPE/QvwWxY6qd9I0jLl
         +GO6lsDwUxX8INq0eQxFjG9lJA5pzj2Vd7xytdVjgkMqO8e0JApMOYJ3fSLEd0mI1vso
         IDGNyZlIxhMNxWkpuQFzb4KvMFlgYo9Wh60gOa42JJ5pwRpQEAlaWu8IzTqTwB3B0nlR
         jscA2xcVTPTtGUPKFgGBYI4QLilzFf/TaWXHaUIzhZwW9eZI6kG8wdUHxpvPrGgwvonf
         YsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765865963; x=1766470763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwbmoXbPjGCi6tDWqsOk1Z9HEPGkbvpnV1+pVc88VLU=;
        b=HiPh6QO5rbN7RvpUu9ILIeyogI5yaFoRuQg1BHlrwFZ6WtImARg8BOdf5U5hJ90llO
         na1SmFAz6nxNhTO7C41RF0CgjWFbdqAYKiACePMaHVQ63idQR3PzfstUgqkIWzdjjw4J
         5a8SU8XfoSKBRuQ+rjjscgOc1sH5hCNzH07CwU+YOFlfe+MbTFbCRh2u2fWqp1qjDJlH
         JCeE1S8N1jDE6GPHxTng91xK6oGRjdLO9pjqNmeYD3ohV0RlHCv7Av7yl04W/k3ty5MA
         8RK9nri7hE6xPWlboAh9rDZLSCHTa9TlI1x4xWIFj4nZp4Ny835a70+3CAxKkrPGK++7
         sIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfZs8PQkq6C2tOXgMq7L+4sRTiKtM3cSi9rTrVlWlnBOTFHUuhkp5jyh8+IwH4sxDhbdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDzIU/7+/C//Qko87cEYyJSSdjobLer+hofIYA9galTqCz0PU
	XAJRNvv/f5Vb669qtHtk1w5iLbv38vdMPRpQGYOlVU1fwXr3ghutdBwrG6Sq0Xt5q+n+RpPEsmA
	PW9ltVQxIKnoMdwcvOe+HXGAfKc2zmGo=
X-Gm-Gg: AY/fxX5B/MDHmdmVugo1mPcZGsTLXuZJIwvda1bgF39MgVFmbn7+wMGnsHDsciXANeP
	kfk6dcdR6RGJiQvOs0EO3c8/C4x1nb8iiBt1OOQZ+0Sgzhu27tK3npiMu9Pp6GrncXoHKOO4Nef
	EsnlGjVex/Gz+wQiyT9fNTzhWO/zGuR6mEAdPWZDqgEujH8voZJrRyJb+6xqvSDP3Fdr2l5B5D/
	RSkjteyoCw0Ge7hEwunfPk93FZ0p7GAhU73lkEBWyxEpq6okqatybzC/lQWS/JrAZUzLsmW
X-Google-Smtp-Source: AGHT+IF1hLo5NBIH9Hd1BHxmz1nDRYM/wJzsM/p3b1Df6ENEWycTKvPCtnQFcWSH1cp4NIQwGT49Ie/R1N+zQ7Mj+hM=
X-Received: by 2002:a05:6820:1529:b0:659:9a49:8e0a with SMTP id
 006d021491bc7-65b45273daemr6313467eaf.76.1765865963318; Mon, 15 Dec 2025
 22:19:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216052623.2697-2-kerneljasonxing@gmail.com> <0956384a0b29a47199ebc6f2d1e88c6e2da6eec21b145df1846e56e7097534a5@mail.kernel.org>
In-Reply-To: <0956384a0b29a47199ebc6f2d1e88c6e2da6eec21b145df1846e56e7097534a5@mail.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Dec 2025 14:18:47 +0800
X-Gm-Features: AQt7F2oom_qYDvmub8u_dowp1XQODiqr2KexOwSrqnyGvQW7eVkWpl6aCoQN9fM
Message-ID: <CAL+tcoB9Lw24NCc-7ZDD2Qs9WUPs6G6Fwb8=47n2T=2Gwwf9AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] xsk: introduce local_cq for each af_xdp socket
To: bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	kernelxing@tencent.com, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 1:46=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 23e8861e8b25..c53ab2609d8c 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -45,6 +45,12 @@ struct xsk_map {
> >       struct xdp_sock __rcu *xsk_map[];
> >  };
> >
> > +struct local_cq {
> > +     u32 prod ____cacheline_aligned_in_smp;
> > +     u32 ring_mask ____cacheline_aligned_in_smp;
> > +     u64 desc[] ____cacheline_aligned_in_smp;
> > +};
> > +
> >  struct xdp_sock {
> >       /* struct sock must be the first member of struct xdp_sock */
> >       struct sock sk;
> > @@ -89,6 +95,8 @@ struct xdp_sock {
> >       struct mutex mutex;
> >       struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
> >       struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
> > +     /* Maintain addr(s) of descriptors locally */
> > +     struct local_cq *lcq;
> >  };
>
> [ ... ]
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f093c3453f64..9b637d5e4528 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1212,6 +1212,30 @@ static void xsk_delete_from_maps(struct xdp_sock=
 *xs)
> >       }
> >  }
> >
> > +/* Initialize local compeletion queue for each xsk */
> > +static int xsk_init_local_cq(struct xdp_sock *xs)
> > +{
> > +     struct xsk_queue *cq =3D xs->pool->cq;
> > +     size_t size;
> > +
> > +     if (!cq || !cq->nentries)
> > +             return -EINVAL;
> > +
> > +     size =3D struct_size_t(struct local_cq, desc, cq->nentries);
> > +     xs->lcq =3D vmalloc(size);
> > +     if (!xs->lcq)
> > +             return -ENOMEM;
> > +     xs->lcq->ring_mask =3D cq->nentries - 1;
> > +     xs->lcq->prod =3D 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static void xsk_clear_local_cq(struct xdp_sock *xs)
> > +{
> > +     vfree(xs->lcq);
>
> Can this lead to a double-free? When xsk_bind() fails after
> xsk_init_local_cq() succeeds, xsk_clear_local_cq() is called in the
> error path, freeing xs->lcq. However, xs->lcq is not set to NULL after
> the vfree(). Later when the socket is closed, xsk_release() calls
> xsk_clear_local_cq() again, causing vfree() to be called on the
> already-freed pointer.
>
> The path would be: xsk_bind()->xsk_init_local_cq() succeeds, allocating
> xs->lcq. Then xp_assign_dev_shared() fails, triggering the error path
> that calls xsk_clear_local_cq(). The bind fails and returns to userspace.
> User closes the socket, triggering xsk_release()->xsk_clear_local_cq(),
> which calls vfree() on the dangling xs->lcq pointer.
>
> Should xs->lcq be set to NULL after the vfree to prevent this double-free=
?

Exactly. Thanks. Will fix it.

Now it's time, I think, to run the AI reviewer locally before posting
patches since it's quite useful to spot some corner cases...

Thanks,
Jason

