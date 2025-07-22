Return-Path: <bpf+bounces-63971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92290B0CEA3
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 02:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C023C160C09
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182421388;
	Tue, 22 Jul 2025 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnshyzbr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EBA2D;
	Tue, 22 Jul 2025 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753143189; cv=none; b=qVAB5Z/qK3v9k6AbKqcczNPrUAJa4XNkPcPkSKwVlmEKqM8Lgq0aymgpCDtyhkTSv4ARd+QVb4vRwmGlJxNe3eaULUSdI7zjJ7PFvQQUPDcyy0fB6lEnzqj2Yg3yAJmdjfgnQBMUNrUN+NUdp1QT/ABHTl/pTc1oXtcXF5U5QzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753143189; c=relaxed/simple;
	bh=GRxrulTdupzpOXGsEWoI7YP7UHAiVyq3iNIC3yQp9to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SO1dEpdfxcVI2lDMjeKXugrDsFWifgZcmvR6PD2pE7LOwp70JLKrdJ5M3kiQxlrKUB+sCqTXJdYtz6T5oLwm6aEofbbmDL/U7Ln+IM98V1jktzA5crv3HhRMnuuQ99BwiqrUBNbegMRSDrFDBe16zfvacFMPU+f5gydwLWQGw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnshyzbr; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-87c070b2dfbso143267139f.3;
        Mon, 21 Jul 2025 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753143187; x=1753747987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI2QMNGgMj3J8RDFB4fygTxaPTI02cve37bjkV39hu4=;
        b=cnshyzbrgJHl+cZX8gK8T1LoV2zluECyqxLYxLBD6V3OeXnCg7LkOvzEOKRJQS16Xd
         FIxmnApBpO+vvuPl4RrXHOYFfxquljc+zO0eZC8kycEUXBNka/EgFSAq8Zy2XnSArFa/
         EYEbHaCEH/dcLrFpxUxC8wxgsBozHK/TdIVVUeCgLRct7RbmGXBiZq4qYnbJ42HNr2tX
         Xl9wTtICnOUJzAUPB9DQczBFrwtHf8JpaWIZ33XmDnq+5P1F4RT/EPeK4btNHI8IVZwa
         9dPTXdctImCTohq8RGaXFEK4ajeUCa/44oSuUGMfXTRGbsV9XzpUIB+CqivO+b8F+PKX
         QReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753143187; x=1753747987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nI2QMNGgMj3J8RDFB4fygTxaPTI02cve37bjkV39hu4=;
        b=Z06AV/75aQDkrjPcRUt191tzd1Wq8rFlMbFIi5W3AGYCVxd44DDY8CJMtVQNoKTGRR
         zioVg3gmMeNorShctZhFWyn8fOPYxmFmdoCT9TfsQcEcbSC4QFBqlXJHMw1Pi15xL3qU
         KY99LrHOinp/Sj6wroko3sTwRygSqnV2zXZnnygXwyrIUfHdMwG9m//fay0Pzt6BTos8
         bwTH+gczXQYpVbIAMLFPxEkIjOVTWD897v/sbiixUkRuwDLDLyrRSYEX1pi5mEzQdSsa
         GOJ6ypmzXkZRszjnPXNjnK4e/8dsgH0T1wOH1UElbaDQRaTVH6xOeJ+Ym8prTei6QUgl
         iQUA==
X-Forwarded-Encrypted: i=1; AJvYcCUpMsEkmNQb/4uxABA6YE7G+QqP3Tq8pcSuftCywONZVCPkQ9ahy1gYiHzjNXYwR9uP0TsgCZ5n@vger.kernel.org, AJvYcCX1vT9R3Pcdr36zUIskcE8pWwsAD+lf1NIwtVDsjH2hfmnO7VyUqNlAGIP1+eY1xjufFxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmH1jgZp8BOk9JrV6pYMVV2lst7T2IOSYsLFl/pp0M9ZqTdBG
	ch0FPmYhQCqRnWaTV0xVFG2iKyvHqECN4/DwuE0rGsmRh7++at62XaL/kf1iwkfETAx+/vYZEZ1
	cqhBljfGF00iamGcleFYD3isAfW9qXjw=
X-Gm-Gg: ASbGncuN4Pf7020OnZq308kiBFlCucUs7p1XwP+WfoscZ4HlPHuflDwtKJCbz4Gf9vZ
	XgQ6l/GMb9QUKUZvPSNkBT+jJMA3hHkHh887EdywGiFx0GFT695ThtmBKC1dKKgayo47Zx5Toz0
	okYnkDU9jbrlDlxDwR65q8SpXM7jcg42xFL760IXi2v5vqVFXcD6OaPFbdWE8rYTwZrHXyBKvTj
	OkWY5I=
X-Google-Smtp-Source: AGHT+IHkIo1E+xz5iEr8q7c7k+6dv3JOxmpiAY/Iii9TcI5lbuWd/CS88OtlDMQETFPvj7tY1e+BLPWawYxnyx/DaCw=
X-Received: by 2002:a05:6e02:3c87:b0:3df:5333:c2ab with SMTP id
 e9e14a558f8ab-3e282e64ee3mr249275185ab.17.1753143187112; Mon, 21 Jul 2025
 17:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com> <aH5exXo_BdonTfmf@mini-arch>
 <CAL+tcoB9U-YnJ7MPn7FQ4+ZsW5cgQXE3Tks-7=kGMhUE6nNprg@mail.gmail.com>
In-Reply-To: <CAL+tcoB9U-YnJ7MPn7FQ4+ZsW5cgQXE3Tks-7=kGMhUE6nNprg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Jul 2025 08:12:30 +0800
X-Gm-Features: Ac12FXwDqdw8CTdPU0GZ9MGtwXJTttOt4N3GfGIw0dI8oN7Gjar3PdzKubKY-XQ
Message-ID: <CAL+tcoDo3p52+j8hahpDVAcWF-pGPAoGY5Z_=wkn25C=eH3FNA@mail.gmail.com>
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

On Tue, Jul 22, 2025 at 7:05=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Jul 21, 2025 at 11:37=E2=80=AFPM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 07/21, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The issue can happen when the budget number of descs are consumed. As
> > > long as the budget is decreased to zero, it will again go into
> > > while (budget-- > 0) statement and get decreased by one, so the
> > > underflow issue can happen. It will lead to returning true whereas th=
e
> > > expected value should be false.
> > >
> > > In this case where all the budget are used up, it means zc function
> > > should return false to let the poll run again because normally we
> > > might have more data to process.
> > >
> > > Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driv=
ers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index f350a6662880..ea5541f9e9a6 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -2596,7 +2596,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_pr=
iv *priv, u32 queue, u32 budget)
> > >
> > >       budget =3D min(budget, stmmac_tx_avail(priv, queue));
> > >
> > > -     while (budget-- > 0) {
> > > +     while (budget > 0) {
> >
> > There is a continue on line 2621.
>
> Thanks for catching this!
>
> > Should we do 'for (; budget > 0; budget--)'
> > instead? And maybe the same for ixgbe [0]?
>
> Not really. I think I can move the 'budget--' just before the
> 'continue' part. If we convert it to use 'for' loop and then we end up
> with one of 'break' statements, the budget still gets accidently
> increased by one whereas ixgbe driver even doesn't handle the desc
> this time. IIUC, it should not happen, right?

Sorry, I was totally wrong. Your suggestions work and I will revise
them as you said :)

Thanks,
Jason

