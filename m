Return-Path: <bpf+bounces-61327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1AFAE5834
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 01:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5427A96B8
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 23:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7E22DF85;
	Mon, 23 Jun 2025 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awlZUWTu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C452F88;
	Mon, 23 Jun 2025 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722900; cv=none; b=paGb2opGhUyJ4C6McOIVM+Ljh/NbbfM9vMAF5+8iltFHjaq6e2pIkK5JTvw/Po7rpGcUVEVmbPotXXCQnNUgR4H0UTZJ5G3iK+F0yK6Fef68ux1TCIcFU8pJJFB7csbOsMxZvSnkqek22OshpjcAV4LooooA6am0zWA5mMVr9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722900; c=relaxed/simple;
	bh=3vWHVubH81WvqeFnvNvOfRONRFFAfmZct9THUsdR2pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUKckoRcfsVZF+xrm2OvRZJ8mZKb4Gx6Lg2v+R4aFGYpLN9KBxPtDXBzYpZXaeIWki9xf/JSrba2LZeK6sIv9IfRimm9ubqyxLVbs2VtgyTqVuRv1Umncc01rn20brRW9K70HkLc6e66yuyJkB9EwDveKcCbftRGbbSL0REJk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awlZUWTu; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso20305285ab.2;
        Mon, 23 Jun 2025 16:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750722898; x=1751327698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS262nr1YqD4iSvkVXAF+yWKGEdn5aCMiFwwKXBvYLw=;
        b=awlZUWTuiAjEmzNt4UomSPBd2Nn+TeIEJrm2Vuk1oYbNU3Si3lUSq6y7ZB5CBCQkcJ
         EIt6fN6+X2gINrgtnExUfDCloqC8SB0rgwoRTWVjA58O3EqEILf7EUmRMaL10uiToRWd
         nJ/1ztOc2TlM8a+bZWENPiEcesRTAPE1v7xreB/trEborRzOX2E8RflV1ZKSthJdNaeI
         Qn1UQeh3UNH4O9fmnT7wD8URjTLXusao1IB0zYusPnP5s0UZlWSN40GFjFBW8sQiiHP8
         DOIsFuT6LPpvvusRFyQbEmo8UxVbqa8gsTeoQIv/sAgzUG1WcgNa5SYqrc/FOZpgL6iP
         NqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750722898; x=1751327698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS262nr1YqD4iSvkVXAF+yWKGEdn5aCMiFwwKXBvYLw=;
        b=b4JwI7LPC1SYoFu5XhL3Ql6BfNBYuA7CLaqFt+TEHF2w0mcGR20zrg+6/NrPwQ1fcc
         P8VYUxm74KS/9OhXgM+mRFEMAGUfeF9py3pWGW8UIhWTy22Rj7jGrpIbtNMAw6cKdrxI
         SThuIfXK8z4WmwlKWT/IAUssV8/ex/R0DsoCknaGln+FuGolcRCCpwb5VZfgtkzB6NM6
         HXnkWe4Mp8uPi2heEwCaRsYgaHDBpjq+WrWcfoedFeonkJW7prHpuaY6E5BvB9mZZOiz
         0FoABzWJqUMvJvTfYVyiOzdriDryjIL3/IrrtAF7sWA0w60MrF4Iccvzv3DCt2Sar4ro
         tKnA==
X-Forwarded-Encrypted: i=1; AJvYcCVU4lMRz0vups2kRC+g9yuLhVYO99ZY4q1LZTvzgvKVz8Cs86YvrAZKc8Y9UPauI+nxv80=@vger.kernel.org, AJvYcCWteLzBMA417WGynY52A95s2G1jA5LJHsZ2FoC5Rt4W0BSh58WZsPW6RRdtEmGypTnQ3H+3EyS4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5TQNSoabKUz6C26Q6UPXW4FvkF7L1wbY+krHmyTDyf7T1wV4
	bQ3doQjjjLt0Y4IT6ym/iUkHWijctwpavBS6e44IIhmDd0mRynkCzFpHYfsXbRkcFqJJRmU+Ynp
	RGG+O1EMX66Dc2ctLTzUR5vFPr6mdTGc=
X-Gm-Gg: ASbGncvu1lInJVUh5+oz6d6/sY/sF5SeVEhi0OX45Ben8KIl9GR3L1nGM9eqGnlmiop
	btmexP9ySmTPSJz6XmNN7zaY5szWIXss8fEQJqCMWdL/A4DbMbb3s23gyOG4Atb6ttaZgtDxHyX
	jRDHkrshKu+GsSL6i+w+DNE9rFtXUyFrq2fnqR45SyZy4=
X-Google-Smtp-Source: AGHT+IH3H9K/mkBkrTyjQRJcGeR21bsCoDU0DsuIvEr5SxhGY71/KjekmELK+T+SK1ngADJysvcHvhbYC0OnyOdY7eY=
X-Received: by 2002:a05:6e02:240f:b0:3dd:dd41:d3dc with SMTP id
 e9e14a558f8ab-3de38c1d694mr189599775ab.1.1750722897899; Mon, 23 Jun 2025
 16:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org> <aFVvcgJpw5Cnog2O@mini-arch>
 <CAL+tcoAm-HitfFS+N+QRzECp5X0-X0FuGQEef5=e6cB1c_9UoA@mail.gmail.com>
 <aFWQoXrkIWF2LnRn@mini-arch> <CAL+tcoB-5Gt1_sJ_9-EjH5Nm_Ri+8+3QqFvapnLLpC5y4HW63g@mail.gmail.com>
 <aFliLQiRusx_SzQ4@mini-arch>
In-Reply-To: <aFliLQiRusx_SzQ4@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Jun 2025 07:54:21 +0800
X-Gm-Features: AX0GCFvNtWp9KipRNYoFWaKGebo42MbnK4Osnwpv0ZzHsCptVVsEeyMwbbNwS8M
Message-ID: <CAL+tcoBub4JpHrgWekK+OVCb0frXUaFYDGVd2XL3bvjHOTmFjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:18=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 06/21, Jason Xing wrote:
> > On Sat, Jun 21, 2025 at 12:47=E2=80=AFAM Stanislav Fomichev
> > <stfomichev@gmail.com> wrote:
> > >
> > > On 06/21, Jason Xing wrote:
> > > > On Fri, Jun 20, 2025 at 10:25=E2=80=AFPM Stanislav Fomichev
> > > > <stfomichev@gmail.com> wrote:
> > > > >
> > > > > On 06/19, Jakub Kicinski wrote:
> > > > > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_poo=
l *pool, struct xdp_desc *desc)
> > > > > > >     rcu_read_lock();
> > > > > > >  again:
> > > > > > >     list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) =
{
> > > > > > > -           if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGE=
T) {
> > > > > > > +           int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > > > > > +
> > > > > > > +           if (xs->tx_budget_spent >=3D max_budget) {
> > > > > > >                     budget_exhausted =3D true;
> > > > > > >                     continue;
> > > > > > >             }
> > > > > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(stru=
ct xdp_sock *xs,
> > > > > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > > > > >  {
> > > > > > >     struct xdp_sock *xs =3D xdp_sk(sk);
> > > > > > > -   u32 max_batch =3D TX_BATCH_SIZE;
> > > > > > > +   u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > > > >
> > > > > > Hm, maybe a question to Stan / Willem & other XSK experts but a=
re these
> > > > > > two max values / code paths really related? Question 2 -- is ge=
neric
> > > > > > XSK a legit optimization target, legit enough to add uAPI?
> > > > >
> > > > > 1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy mode=
;
> > > > > whether we want to affect zc case given the fact that Jason seemi=
ngly
> > > > > cares about copy mode is a good question.
> > > >
> > > > Allow me to ask the similar question that you asked me before: even=
 though I
> > > > didn't see the necessity to set the max budget for zc mode (just
> > > > because I didn't spot it happening), would it be better if we separ=
ate
> > > > both of them because it's an uAPI interface. IIUC, if the setsockop=
t
> > > > is set, we will not separate it any more in the future?
> > > >
> > > > We can keep using the hardcoded value (32) in the zc mode like
> > > > before and __only__ touch the copy mode? Later if someone or I foun=
d
> > > > the significance of making it tunable, then another parameter of
> > > > setsockopt can be added? Does it make sense?
> > >
> > > Related suggestion: maybe we don't need this limit at all for the cop=
y mode?
> > > If the user, with a socket option, can arbitrarily change it, what is=
 the
> > > point of this limit? Keep it on the zc side to make sure one socket d=
oesn't
> > > starve the rest and drop from the copy mode.. Any reason not to do it=
?
> >
> > Thanks for bringing up the same question that I had in this thread. I
> > saw the commit[1] mentioned it is used to avoid the burst as DPDK
> > does, so my thought is that it might be used to prevent such a case
> > where multiple sockets try to send packets through a shared umem
> > nearly at the same time?
> >
> > Making it tunable is to provide a chance to let users seek for a good
> > solution that is the best fit for them. It doesn't mean we
> > allow/expect to see the burst situation.
>
> The users can choose to moderate their batches by submitting less
> with each sendmsg call. I see why having a batch limit might be useful fo=
r
> zerocopy to tx in batches to interleave multiple sockets, but not
> sure how this limit helps for the copy mode. Since we are not running
> qdisc layer on tx, we don't really have a good answer for multiple
> sockets sharing the same device/queue..

It's worth mentioning that the xsk still holds the tx queue lock in
the non-zc mode. So I assume getting rid of the limit might be harmful
for other non xsk flows. That is what I know about the burst concern.

Thanks,
Jason

