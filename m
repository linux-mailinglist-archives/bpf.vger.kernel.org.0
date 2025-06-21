Return-Path: <bpf+bounces-61224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78117AE26C8
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 03:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FB34A657A
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 01:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732FE12E7F;
	Sat, 21 Jun 2025 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ9ZgpI6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E023173;
	Sat, 21 Jun 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750468003; cv=none; b=d3Hxh49knj5c/2QBXknL/IpDvz+LRCa5iOA2V9e3P9CxrmSpZU7qpG07KdeGkzqQIqFPuk2AY4Fo6yO+PVtkutf1lEEetG3xlcaLL11/2wyW7rOEWicMut2lH9E3x3jIf83/ufHDulek1wLkmhAI/rXdRY5rYNrD6mOnq92H37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750468003; c=relaxed/simple;
	bh=/zUEP/ZthdU/jL5hhulkFW79OME62AvtfmvxYVKjDY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pz+8DUzMoLGcllHNolrbTFNX5nrcN/ph9iqhFOjEK17eatFnBtdsUfVDJWgnbOTd6Wa67dCsm9wkmfgKdtzZS9Anew3VNE4Y1xlsX6Mpb98MPmYwKWbO9dOyXWB3+OaktwvXzKNtw+byHhE12OBaedt3FLxeFxfixyH76+5VQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ9ZgpI6; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddd32e3955so8393895ab.2;
        Fri, 20 Jun 2025 18:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750468000; x=1751072800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPKKNAvlZSp+QOhtTY1FDg2ly4OUD3/RjCrMWA/mLac=;
        b=UQ9ZgpI68plX4RZFqW+ayR+4N7EzcxYuxwaltsSlF1jVEI7wkE/Gro171kExNElTct
         YeiecsVph7AmGL6vo5fhqB7D+rMbGwjqcmCJ7JS2CIV8tpSyfVtqBF/OhEZE2wb7Nhau
         rYXFGYFpDiBRt2yDVM9IkgukVr8ePxHqMYERhG8s6Wn4AnmMg/kLccxxTWiMk53aVLmv
         A6dmzyAZitWzRtsbL/Dejpm1lbYB3pyR3kzuUdmSczqBPzdTSXkwR20zSLNiH8QQkQe1
         Y5vo0XUfft3q3dcYf1lOCY2frEBh+MKyGuH7Z2sSbl8JYyWhrG97OMSna7Mc4QQXeTbK
         bv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750468000; x=1751072800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPKKNAvlZSp+QOhtTY1FDg2ly4OUD3/RjCrMWA/mLac=;
        b=AOLsRu6RY73WGWWgN2SBphNIyaDfcGyBb9YJzPVBgXwuAfS9yG22+Njl9tXWjmwWdO
         mGcmZQfNKl8iz+CWGqV/Oe0IW+PB8ld5jrY0Evk4jV5onoYhwVhvmfX8WfNd5Fm2Bgl3
         SHYumClucTNCgy+BTp7+C8l9mMIk4taTg00Lyw4o5udhycbC2DdfK4RcSUIQnOtlpssf
         Ss+zeRrS8Eio+C5WO5AuuvSQo4buje9+ROR6cCTP857+7suI0ZloqCJp/IO5tBejl2I3
         RcuCBkNYXWFac5t5HkpBIrxR4HhwUG4ecPlqn9hVE5fRvmZcRw8cECytMxxdSoQmFX80
         jLtw==
X-Forwarded-Encrypted: i=1; AJvYcCVWOHliAA4Lf92GNjYiCQvpZX0fbsmK0dycPQzMU16RZI8n5GSklMSgkRe7qIOaOMzRoEw=@vger.kernel.org, AJvYcCWv6TV0efQiJVEXfcITbuJsoAFY5mo7hk3GpetAGuXsU1dSKWZezBipF7ozqhKNYQp7qqYn80Pm@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlsJUtsEjk+sYRdyXLi+6ddskMginNtONmtUfFycBurD0WrY5
	Vxa45RZCQUaGcHiVIJSC5yxnB1r6JEqBQub8j1QaKFLCls3v28FbMhT2FP2ILy7AixenJJ0QZAy
	h0VoV4jCPTZmfJbjwi/Y6THyAhziZSbo=
X-Gm-Gg: ASbGncu/UrR9lxiyqHfVVibzzB1MTFBECrRjwCYux9YxbtR/+Cw0+ak1hvysTeK5/Ww
	SDLzqEtELfX8kATuAbJy9NlHdAWDw1J3NPQ5OXcM1zBrd7XVoCee0y1CM+kRFXULLeljkRyCpIY
	rVbbbNB+LGAoKsYy7xtZ0SolNZOTQO0LrBKmmnXwCl6Q==
X-Google-Smtp-Source: AGHT+IE/Nwiw4ZighNENV+5mjdW0ijfvaQezgdCgMFiM/p+8kjUkbGTiT2fr1TuOHDxksvCkse4ZrOv3dqeCyJnBycw=
X-Received: by 2002:a05:6e02:2217:b0:3dc:7a9a:4529 with SMTP id
 e9e14a558f8ab-3de38cb10cdmr58268895ab.16.1750468000468; Fri, 20 Jun 2025
 18:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org> <aFVvcgJpw5Cnog2O@mini-arch> <6855deade401b_1ca4329456@willemb.c.googlers.com.notmuch>
In-Reply-To: <6855deade401b_1ca4329456@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 21 Jun 2025 09:06:03 +0800
X-Gm-Features: AX0GCFv0krLjmeVrJvtIlqPv_bisd_76ZoX3YG1MQEZz4IgaTCk-dCALd5WXTU4
Message-ID: <CAL+tcoD6gkyirk=CQ0yepk3fkZVf+28Zc7nUoModeCT3Po7VYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, magnus.karlsson@gmail.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 6:20=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Stanislav Fomichev wrote:
> > On 06/19, Jakub Kicinski wrote:
> > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *poo=
l, struct xdp_desc *desc)
> > > >   rcu_read_lock();
> > > >  again:
> > > >   list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > > -         if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> > > > +         int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > > +
> > > > +         if (xs->tx_budget_spent >=3D max_budget) {
> > > >                   budget_exhausted =3D true;
> > > >                   continue;
> > > >           }
> > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > >  {
> > > >   struct xdp_sock *xs =3D xdp_sk(sk);
> > > > - u32 max_batch =3D TX_BATCH_SIZE;
> > > > + u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > >
> > > Hm, maybe a question to Stan / Willem & other XSK experts but are the=
se
> > > two max values / code paths really related? Question 2 -- is generic
> > > XSK a legit optimization target, legit enough to add uAPI?
> >
> > 1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy mode;
> > whether we want to affect zc case given the fact that Jason seemingly
> > cares about copy mode is a good question.
>
> The two constants seem to be only tangentially created.
>
> If there is fear that one tunable modifies both, it is simple enough
> to remove the unnecessary dependency and only tune the first.

Last night I was thinking only let the first one take effect and keep
the zc mode untouched. IIUC, if we publish the uAPI (setsockopt),
we're _not_ allowed to remove the unwanted one when we spot some
problems? If so, I will only make the copy mode work :) If the latter
needs this in the future, another setsockopt can be easily added. Am I
right?

>
> > 2) I do find it surprising as well. Recent busy polling patches were
> > also using/targeting copy mode. But from my pow, if people use it, I se=
e
> > no reason to make it more usable.
>
> That's a very fair question.
>
> Jason, have you tried XDP_ZEROCOPY? It's quite plausible that that
> would address your issue.

Not yet, but I will try and verify maybe at the beginning of next
month as you suggested.

>
> I have had a use for copy mode, but that was rather obscure. A small
> packet workload where copy cost is negligible, and with copy mode it
> was easy to make to reinstate flow steering in XDP to specific XSKs,
> akin to
>
> https://lore.kernel.org/netdev/65c0f032ac71a_7396029419@willemb.c.googler=
s.com.notmuch/

Interesting. Thanks for the pointer  :)

>
> The main issue with that remained that driver copy mode also implies
> the slower generic copy based Tx path, which goes through the full
> dev_queue_xmit stack.

To be more specific, not the full dev_queue_xmit stack as
__xsk_generic_xmit() bypasses the qdisc layer.

Thanks,
Jason

