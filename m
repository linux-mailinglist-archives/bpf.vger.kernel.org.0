Return-Path: <bpf+bounces-77919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B31FCF6997
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 04:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8224E3008195
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 03:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1002D21A92F;
	Tue,  6 Jan 2026 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQev8DxU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6C1C5D44
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669941; cv=none; b=YhFJlmAVL8MuUSowTZwKdAIJbHT7Ljfk8KC8oymu47dlr+0YOJqZCiJLDDUyxPFALVO5+suXVuGeZbSxtgbPPKs04JkMpIbpYlvejW69POvUxSpzkdd/zTRkrz1ogg8uedQXjv7a0RA3TiYMq1kpXgJOqJtszuwQogXtLRwyWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669941; c=relaxed/simple;
	bh=fFdZERkQq7qcoX44VzNM9NF/W5K6GE3Gkb6xhhWGgiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgjaBvmdEb+njQoPywpk+uNbdrDFjhdcF+qq2wGO/DTRTjECLGXcFlydzrzLBykM5cCzYf1hTr357MeyE+kb5QgH/FHEXOAjasRvo8mestwJQUtd/rtj1Os7ExYcwWeY83wBp7wN+u7qxnoIYVFG3vlgzb2vP2oQyGuHVc4Dxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQev8DxU; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65ec86c5e70so344071eaf.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 19:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767669939; x=1768274739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7adoCRWWLhZQUEHRqlXRuMHWuAIXead0Q42trhJ7/5c=;
        b=WQev8DxUoroT658VM5yA6uZvGDDXtncDyL8daFIqtnZJbqpKr6sBoF+OtWPk06m976
         1SPOC9vGV6zSxADREkl5H0UIYl9Q8RLlcfI69/u062DS+4kpR0aF+oxMvdS9deQbXLhR
         UI0E0eCMAcv0KOPmGVGhdNDdutSn3HT8V7MT9bqbQVgbov8Axjj0AoVEC345dBU78wQA
         71YAVkl3qtg1CMaRdFJxLm0wJ7WtduS7mmLNDzC49KZHVjWJZsExhp5ta7hXF3ENRAtx
         RtZw3zp03pMHvDFynY8ra/ZPotEtXo4IZXKTLAxJrISgk+uVFUhNJ93oqUxaJG3twuDK
         WElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767669939; x=1768274739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7adoCRWWLhZQUEHRqlXRuMHWuAIXead0Q42trhJ7/5c=;
        b=YBVWdt2L4J1WaLMCc9Gz/C0+Vh9Bjrs2V3WCtyFLqKOUvTLLOH/f1AknTQtH637K4j
         3ph2FYseChLDSePlSqytNEYuwIF+KGqyPWe3IyZZ2nFhpG0kJTqeM7ojQtXs2JubeS/+
         AtPaoklv0NKJMt5PBbDLnL+LCgEIl1bhNSr2+ArPFgpPPObWx1zy5XBu38adAOnhYwTD
         KocisEfNT6vxdkqCzp7B0+EO86G+iSlQG0hwhyAa9G7wTkItp89KQsEvozdUAXTiEuVa
         8VaW0b1FAO+nwK4EH2CzZQt6/6Qn/eGcLXQvoa61ovMPcXhq8i50xb2zGrynpOIJg+q7
         TSkw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ihRiGd0JmX8CEUdgu6ZH+i7ABW6cYU7g9sRprAJeuPtTIdAoB5KMDf2IHMgFwlrOKR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZ0vehzi8/zcSJez7fRv8k0bGCxKHuO2biwtlDVttHmPUlpW6
	IFx1X0ywn2N0pjdQ83mYYxbNes/4VeMl8P4579uS0QS4LnAZ22n70iBPz5ZuaILY0kuNlOvcJgn
	yistLInTxaJWCfBxeinUOj4CdNGJgWKA=
X-Gm-Gg: AY/fxX6CiOdsu5pQ6KecAsJdA9CBuLJzkCKbn7JDgXJ6UZCMLp1ftahlyUMBT1q82Sj
	PuMwt+98u2jLSK3dHiCKzPsjWxqMqiECJ4fTEhgNr+VepVlzBAkWF08alU/3seUV7FjSjugG8kL
	Z+yS5cYrUVyxstE9Da5El8TNj7EtBNYX48lA7yTVdeDd4TWVNkLOax0SZ8NOKkbT+IV9F+Q8qZy
	UvwCyR0/4ZVnru1HSpFkM5HV/YqEu8ybHkxCsOlTI/QYqHkiPUY4fJWomuW0Xsq4Z4EFh38
X-Google-Smtp-Source: AGHT+IE5K5h7PkETUmLZNIi2espKhWrZ/bV63HHw1GbilIoMq0LWNjMm/em3uFC9RVyPysLjbOR4QCMhToU5QexgT0U=
X-Received: by 2002:a05:6820:1501:b0:65d:88b:c012 with SMTP id
 006d021491bc7-65f47ab1515mr1059429eaf.72.1767669938846; Mon, 05 Jan 2026
 19:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106013112.56250-3-kerneljasonxing@gmail.com> <89fee0bdf782c9fab10781be2a42c099bfb9f99a53c342dd6e41fd99651943f6@mail.kernel.org>
In-Reply-To: <89fee0bdf782c9fab10781be2a42c099bfb9f99a53c342dd6e41fd99651943f6@mail.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 6 Jan 2026 11:25:02 +0800
X-Gm-Features: AQt7F2rLl5PRrK_saI0AlLXbGM3sprVHqPrvdAsBvJqZUrt6U1Qh_jNjwM51pBM
Message-ID: <CAL+tcoAHRct5w4xpfzHcafpf0ZHiUAofDjLuhxKibwrB3aaZ=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] xsk: introduce a dedicated local
 completion queue for each xsk
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

On Tue, Jan 6, 2026 at 9:47=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f41e0b480aa4..f80721165fdc 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > -static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > +static int xsk_cq_reserve_addr_locked(struct xdp_sock *xs, u64 addr)
> >  {
> > +     struct xsk_buff_pool *pool =3D xs->pool;
> > +     struct local_cq *lcq =3D xs->lcq;
> >       int ret;
> >
> >       spin_lock(&pool->cq_cached_prod_lock);
> >       ret =3D xskq_prod_reserve(pool->cq);
> >       spin_unlock(&pool->cq_cached_prod_lock);
> > +     if (!ret)
> > +             lcq->desc[lcq->prod++ & lcq->ring_mask] =3D addr;
> >
> >       return ret;
> >  }
>
> [ ... ]
>
> > +/* Record the position of first desc in local cq */
> > +static void xsk_skb_destructor_set_addr(struct sk_buff *skb,
> > +                                     struct xdp_sock *xs)
> >  {
> > -     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x=
1UL);
> > +     long val;
> > +
> > +     val =3D ((xs->lcq->prod - 1) & xs->lcq->ring_mask) << XSK_DESTRUC=
TOR_DESCS_SHIFT;
> > +     skb_shinfo(skb)->destructor_arg =3D (void *)val;
> >  }
>
> [ ... ]
>
> > +static void xsk_cq_write_addr(struct sk_buff *skb, u32 desc_processed)
> > +{
> > +     struct xsk_buff_pool *pool =3D xdp_sk(skb->sk)->pool;
> > +     u32 idx, pos =3D xsk_get_start_addr(skb);
> > +     struct xdp_sock *xs =3D xdp_sk(skb->sk);
> > +     u64 addr;
> > +
> > +     idx =3D xskq_get_prod(pool->cq) + desc_processed;
> > +     addr =3D xs->lcq->desc[(pos + desc_processed) & xs->lcq->ring_mas=
k];
> >                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +     xskq_prod_write_addr(pool->cq, idx, addr);
> > +}
>
> Can this read stale or corrupted data from lcq->desc[] if skb destructors
> run out of order?
>
> Consider this scenario with a completion queue of 4 entries:
>   1. SKB1 reserves and writes to lcq[0], stores start_pos=3D0
>   2. SKB2 reserves and writes to lcq[1], stores start_pos=3D1
>   3. SKB3 reserves and writes to lcq[2], stores start_pos=3D2
>   4. SKB4 reserves and writes to lcq[3], stores start_pos=3D3
>   5. Backpressure - cq is full
>   6. Network completes SKB4 first (out of order), destructor reads lcq[3]=
,
>      submits to cq, space becomes available
>   7. SKB5 reserves and writes to lcq[0] (wraparound), overwriting SKB1's =
data
>   8. SKB1's destructor finally runs, reads lcq[0] which now contains SKB5=
's
>      address instead of SKB1's original address
>
> The old code stored addresses in a per-skb xsk_addrs structure, so each s=
kb
> had its own copy that could not be overwritten. The new shared ring buffe=
r
> design appears to be vulnerable to out-of-order completion corrupting the
> address data.

Right, this case makes me rethink if I should continue with this
series as it's apparently becoming more and more complicated than
expected.

I will try to fix it well with minimum changes.

Thanks,
Jason

>
> > +static void xsk_cq_submit_addr_locked(struct sk_buff *skb)
> >  {
> > -     u32 num_descs =3D xsk_get_num_desc(skb);
> > -     struct xsk_addrs *xsk_addr;
> > -     u32 descs_processed =3D 0;
> > +     struct xsk_buff_pool *pool =3D xdp_sk(skb->sk)->pool;
> > +     u8 i, num =3D xsk_get_num_desc(skb);
> >       unsigned long flags;
> > -     u32 idx, i;
> >
> >       spin_lock_irqsave(&pool->cq_prod_lock, flags);
> > -     idx =3D xskq_get_prod(pool->cq);
> > -
> > -     if (unlikely(num_descs > 1)) {
> > -             xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destruc=
tor_arg;
> > -
> > -             for (i =3D 0; i < num_descs; i++) {
> > -                     xskq_prod_write_addr(pool->cq, idx + descs_proces=
sed,
> > -                                          xsk_addr->addrs[i]);
> > -                     descs_processed++;
> > -             }
> > -             kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> > -     } else {
> > -             xskq_prod_write_addr(pool->cq, idx,
> > -                                  xsk_skb_destructor_get_addr(skb));
> > -             descs_processed++;
> > -     }
> > -     xskq_prod_submit_n(pool->cq, descs_processed);
> > +     for (i =3D 0; i < num; i++)
> > +             xsk_cq_write_addr(skb, i);
> > +     xskq_prod_submit_n(pool->cq, num);
> >       spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
> >  }
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/207350=
04935

