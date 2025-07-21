Return-Path: <bpf+bounces-63966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BB6B0CD89
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1867A6AE2
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88812242D8F;
	Mon, 21 Jul 2025 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXjVF5mz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC018D643;
	Mon, 21 Jul 2025 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139174; cv=none; b=AksJXZ3yHD28V44d7mBl9AFBp8dgpIFh82dtWE7iqxlewM3XrNkSdjIMTn6CA+G5kGBs3o3zQ6AY7OU1lNmCHHCNaw7TfLDHHfOPj0wH/NVYZRezOghFVm2sbNM5nLvPAVb9wpuj6Ih+DFiTOynJ8BYZhJBvp4kqezEcJtNrPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139174; c=relaxed/simple;
	bh=v1GzKQ/2OH/U4QZ6QZG/B49zrfbUhnYprM4zjVWA5l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8agI7wzEzfECVRchZxHonVFcPWenwQFR8eOhr29XrEfm1aML1/d10lNsDABwF91TaSmmgKQovEu67BEQJlJxlTKr1RNfgp4AdddFSDemB06Ok+esss9jqmEBZRyQ0p5/CsCyaFooBXCyRXBqAb9C4jVwi4nH+vufg1hT1oqi8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXjVF5mz; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3de252f75d7so46634355ab.3;
        Mon, 21 Jul 2025 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753139172; x=1753743972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEFwVf9DCXPYhb5E+L2S2B43pN/gLrA3tUcn9Sv1yes=;
        b=JXjVF5mzSJkMkYaplfh5tM8ssSFBiMd9LCszS9nBN1lP114R618AxMStrNHsyGkPxx
         M+4bgDheO5g8vcYrzEnmu1mU7fRoi86kbb7emsoCqm3JlEGl8Lv2VayBWRzwRZYoiWdc
         v6BHbXKgowVMkDjIvRpgQAZ9A+ptj68DsNWPS0ITBn+QWGagn2RBkK8fX1tZA+Sn1Fc8
         6m0oiCBqEF3Zhe72k6thQrp5IMzvyp3uo5/9lHOf97CZ9LsRAVddelBiyoV9ulOBWoL0
         LYScSRa3m7DYT993cxfTQAUmy7Aqu2dTpmUMwkCY3ZkMfOKgmwb3+DQV0uFObW/q3Wty
         yQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139172; x=1753743972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEFwVf9DCXPYhb5E+L2S2B43pN/gLrA3tUcn9Sv1yes=;
        b=IY5OKk1uUP5rgWwV7523U6BOaH/OhTRqHWhlX2t+Yg5aIXh/vWFVeQTnCkTrJ0z41d
         uAIu6jNCX9ek1Y7sWezY0HAH+I0QPlEiX7fbskcqcoirj7UKUH5XxOLZsRkftcwlGboU
         INU/LXmRIZ3BlkJ6mTLPAK+XlB6unKGMc+O6seMBZK1g7KzTkahhuBPr4XykrwUyyB/T
         KUAfzHk/BMTHT0dYKQ9UFKmArpZ8KE471ea0FmdFP7WtCBv/M8Hh/jRYMsur+uUYJlHA
         E+ht74uMSOMO5QqW/oEO+/yRhUGGiwuisByH7z2ho2xqI4IFOEWg9m3SdHA4xCRrDSv4
         OXEw==
X-Forwarded-Encrypted: i=1; AJvYcCVAdKhaKrrUaP67BKIvtoXciTZxpu/8uCH0kEacMyb8XLxhVZP0kicQH7l1pU8FHFp3UNs=@vger.kernel.org, AJvYcCVOT5jvY7zaRXIYZ3AiI3hTGjLvdTq6HiZlLM78HzX3bYdUo9a+EBqU75TdH1UKN6xiAap3+7Mk@vger.kernel.org
X-Gm-Message-State: AOJu0YxXu3ArbkmnpWv1DQhUbABfRtdQ1x7or9AXZl/vbQja9V3leDm7
	9yL+GRMiyhxGDHpcX2dsfh+HoUeOC4oFX45Jk73WWuM6YfWUIx5Qq2sXTL4KHV79DBVi91ZjthX
	x9NdgUKUj9KmULtI859Q3GxYUmc7rYys=
X-Gm-Gg: ASbGnctPUT496obUOwQRHS+DQSetsDyab0YhAy7SsXO/QVq59Dhz9ie5DI0gLeiarXN
	Kw6jL6eYkEJl6Gr63U4aXps503Oa4zS+tKGOhssXsPMSU/W2SK05Nq64xmiDLFdXOC5vsQ9pkUw
	KQqVKq4fnAOBlriDksm7xLVIBsCqIE6V63rYPWJ2X948f7UuIRmTBuSseeChYTeg/ygFjxXvrwJ
	gR/hwM=
X-Google-Smtp-Source: AGHT+IG5RIx4CUBqOhyC6+z/etJI6PdiSzvihPpHLIk0ADX/H+hEWkFMYdf4iuelppqsril2kN/LOnjdXOMfNu/RNqM=
X-Received: by 2002:a05:6e02:1d9d:b0:3e2:8ddd:b406 with SMTP id
 e9e14a558f8ab-3e28dddb51amr192280595ab.17.1753139171561; Mon, 21 Jul 2025
 16:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com> <aH5exXo_BdonTfmf@mini-arch>
In-Reply-To: <aH5exXo_BdonTfmf@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Jul 2025 07:05:35 +0800
X-Gm-Features: Ac12FXzrl82q1J1EBI4gPmmpTws7FVNkFQm2LLp1FtXXiWxpRliUiuaDdNslSpc
Message-ID: <CAL+tcoB9U-YnJ7MPn7FQ4+ZsW5cgQXE3Tks-7=kGMhUE6nNprg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] stmmac: xsk: fix underflow of budget in
 zerocopy mode
To: Stanislav Fomichev <stfomichev@gmail.com>
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

On Mon, Jul 21, 2025 at 11:37=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 07/21, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The issue can happen when the budget number of descs are consumed. As
> > long as the budget is decreased to zero, it will again go into
> > while (budget-- > 0) statement and get decreased by one, so the
> > underflow issue can happen. It will lead to returning true whereas the
> > expected value should be false.
> >
> > In this case where all the budget are used up, it means zc function
> > should return false to let the poll run again because normally we
> > might have more data to process.
> >
> > Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
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
> There is a continue on line 2621.

Thanks for catching this!

> Should we do 'for (; budget > 0; budget--)'
> instead? And maybe the same for ixgbe [0]?

Not really. I think I can move the 'budget--' just before the
'continue' part. If we convert it to use 'for' loop and then we end up
with one of 'break' statements, the budget still gets accidently
increased by one whereas ixgbe driver even doesn't handle the desc
this time. IIUC, it should not happen, right?

>
> 0: https://lore.kernel.org/netdev/20250720091123.474-3-kerneljasonxing@gm=
ail.com/

The same logic as above can be applied here as well. There are three
'break' statements in ixgbe_xmit_zc().

Hence, IMHO, I prefer to use while(...) in this case but I ought to
adjust the position of budget--.

Thanks,
Jason

