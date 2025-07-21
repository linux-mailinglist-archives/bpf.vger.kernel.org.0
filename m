Return-Path: <bpf+bounces-63893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D6B0BFC9
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 11:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB43D189E32C
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E163221DA8;
	Mon, 21 Jul 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI1nVT0U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B40EAC6;
	Mon, 21 Jul 2025 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089382; cv=none; b=nIiEqd18DVUJsN9436LLQ/mLqIeoS+UUJu5bChFDE+/y3aSQ0PDhfFxUWra5RF8jZ71BCZG3TP3YOfAIxH7mnsxrEl7+WcfB3i5Ts4EKHlkHuP3CPuSDrsMMBJ4IrNTQ1mAgPWC9pQmjnv0CN1D9LD9EPjI0/9PC0DTrpZYfFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089382; c=relaxed/simple;
	bh=lZztgRWc++8D+GdQu/vkTNbkXwp0jOO0RZ1Iu+pizso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlyqPfkAoHB+hx+JwBXyRW6k+dVrPUXN/6sQ1uqrPqegB7wNnX+hmohHxZ+GTfTLwr2arRAc1t9B9hc5hYy3KYqyLny/ifvBRLgxa2pBYJWu/bXEAAjVdmjZqXYelgbIeGWK7kLDVVtYU1Dpi+a2IgFNI1aYPk3zDqwppf3yVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI1nVT0U; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3dda399db09so54677665ab.3;
        Mon, 21 Jul 2025 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753089378; x=1753694178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWTCrJr+jkFbr7yY/GDDx9r5qnemW4sfX9ZnAt73ZW0=;
        b=FI1nVT0U/rdP42vMlvPmxVKIb8jGJLiJBuIF4Apba0oFot/wkSegVO9ym+8JrfbT2F
         JT8ytpErXDX1PsPu3RwtE2hnzYwKW0aBMpkfoK30s9wKFA8vcM+f1JPKA0O+8GfwiRkw
         SXEaYxQeIK8bDHKa5/TSEuiXGqH9TK88XZNunf0eCgS12JV5LJEfgLSqGGuApWfo6Zqx
         zZ7KrV0q4k//sy3af28sNem9Oxg2Rs5sHDMWfXkUfwX4dOwcBrciCS4cmgsSMHBoiaIv
         XS8zA+1AG2KkjwOlEJvXZFPNH0EtsuOvnw2AP3SnZLMKecpGHq36UMSdIeY/CNmAgnXo
         7fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753089378; x=1753694178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWTCrJr+jkFbr7yY/GDDx9r5qnemW4sfX9ZnAt73ZW0=;
        b=xPSWo/QqqRPKH9J00MW2IzT0DKW2P/P25YYF05/laH85239JpBp/fdjJUGSWz29oF/
         7zGG3he5Mt2SuYPsWeF0J/SFtC0zQSN9DKm1lcKTboVE6jvdJdwIatVKPIt5yzWQRo3e
         ummTwtKJBzhQYj1WJNCNUAh+9mQ885eYsCrVZfw/PqfP5QuGsRRHtc3y8XBco13KAKyw
         3kdAyiBoNDwWU+/UBfekPwtuSGbTNB7EWz3P3w3hbwVeQhi/f6Q3vnNx2b3wHtPrMVoa
         XcumiMZZj+4XiFBpGtEHLiT0YHy9fWxPW4U776o9BPZU9fcDrjmYSIlVCHS+C3DS2h8L
         KVyA==
X-Forwarded-Encrypted: i=1; AJvYcCUHRY5a4BfrvQOp1I5DhJ51AzUQK1UOooze1p3MRlwKxZ3BPLC7DjbFnJVtLXkgtou+eRU=@vger.kernel.org, AJvYcCVHtPLVl3LyL2Q9y5CvF1SxTMeuoiNSHTk7rzu8JMkkBACCB8Rjji7BcgvWsaJDM7P/bzynOPyI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7dWRGs2BV/Bnsq4ZQB2y3eaRAXKMKSYM5XxDCbiqq7xTSoLm
	Im91NiCY8wwV2iPcpZbXpb03jIEwbzxZkQUO82/lVT1peMVIHrLBP1VCb0xJ8BK5lX8SeIwbOyQ
	qCMyEx1R3ri2yNroWLSswBJrhJtdp9O8=
X-Gm-Gg: ASbGncuCC35Up7hRXminea+zOLPmyAGYcpO+Bv2nAwqpWrz9EBwzkRRKDB5rDzacb0j
	40upvpWwRFfbworz4d5Db/PIM/QDjs2LhZO5u8Q4MmHoDArTV3satN4ZinSQFr5qY/CJvrIDRvh
	wnmrq/LOVho8doQZEmt9Q47C1n6/nMgjTEW4KYSJu6Qf1iaFabn2P63Wy90VgdPF4+/sBvMBwlf
	jKTDg==
X-Google-Smtp-Source: AGHT+IG2nZhptU5sMShiQM05wOmbJqhauf2H0RI8O2kKSAiSqbryj8HoWrcq2C8YGYvMd2oBpjurux1VpzbYVEFH93k=
X-Received: by 2002:a05:6e02:19c7:b0:3dd:e7d6:18bb with SMTP id
 e9e14a558f8ab-3e2824f58c8mr214595465ab.17.1753089377803; Mon, 21 Jul 2025
 02:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com> <8c9e97e4-3590-49a8-940b-717deac0078d@molgen.mpg.de>
In-Reply-To: <8c9e97e4-3590-49a8-940b-717deac0078d@molgen.mpg.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Jul 2025 17:15:41 +0800
X-Gm-Features: Ac12FXxJ1BHePlaT48Hqw0KdfZnHkKmI2oq2Xb6hjs7o-cBEjOG5DrUKN96fo1c
Message-ID: <CAL+tcoAP7Zk7A4pzK-za+_NMoX11SGR3ubtY6R+aaywoEq_H+g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] stmmac: xsk: fix underflow
 of budget in zerocopy mode
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Jul 21, 2025 at 4:56=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Jason,
>
>
> Thank you for your patch.

Thanks for your quick response and review :)

>
> Am 21.07.25 um 10:33 schrieb Jason Xing:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The issue can happen when the budget number of descs are consumed. As
>
> Instead of =E2=80=9CThe issue=E2=80=9D, I=E2=80=99d use =E2=80=9CAn under=
flow =E2=80=A6=E2=80=9D.

Will change it.

>
> > long as the budget is decreased to zero, it will again go into
> > while (budget-- > 0) statement and get decreased by one, so the
> > underflow issue can happen. It will lead to returning true whereas the
> > expected value should be false.
>
> What is =E2=80=9Cit=E2=80=9D?

It means 'underflow of budget' behavior.

>
> > In this case where all the budget are used up, it means zc function
>
> *is* used?

Got it.

>
> > should return false to let the poll run again because normally we
> > might have more data to process.
>
> Do you have a reproducer, you could add to the commit message?

Sorry, I didn't have a reproducer. I cooked this patch after analyzing
the whole logic (because recently I'm reading the zc xmit
implementation among various drivers.)

>
> > Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index f350a6662880..ea5541f9e9a6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2596,7 +2596,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv=
 *priv, u32 queue, u32 budget)
> >
> >       budget =3D min(budget, stmmac_tx_avail(priv, queue));
> >
> > -     while (budget-- > 0) {
> > +     while (budget > 0) {
>
> So, if the while loop should not be entered with budget being 0, then
> the line could  be changed to `while (--budget > 0) {`? But then it
> wouldn=E2=80=99t be called for budget being 1.

Right, so it shouldn't be '--budget'.

>
> A for loop might be the better choice for a loop with budget as counting
> variable?

Sorry, I didn't follow you.

>
> >               struct stmmac_metadata_request meta_req;
> >               struct xsk_tx_metadata *meta =3D NULL;
> >               dma_addr_t dma_addr;
> > @@ -2681,6 +2681,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv=
 *priv, u32 queue, u32 budget)
> >
> >               tx_q->cur_tx =3D STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma=
_conf.dma_tx_size);
> >               entry =3D tx_q->cur_tx;
> > +
> > +             budget--;
> >       }
> >       u64_stats_update_begin(&txq_stats->napi_syncp);
> >       u64_stats_add(&txq_stats->napi.tx_set_ic_bit, tx_set_ic_bit);
>
> Excuse my ignorance, but I do not yet see the problem that the while
> loop is entered and buffer is set to 0. Is it later the return condition?

Let me give a simple example. Supposing the budget is one initially,
at the first round, the budget will be zero. Later, after this desc
being processed, the 'while (budget-- > 0)' statement will be accessed
again, and then the budget will be decreased by one which is u32(0 -
1), namely, UINT_MAX. !!UINT_MAX is true while the expected return
value is false (!!0, 0 is the expected budget value).

i40e_clean_tx_irq() handles this correctly, FYI.

Thanks,
Jason

>
>      return !!budget && work_done;
>
>
> Kind regards,
>
> Paul

