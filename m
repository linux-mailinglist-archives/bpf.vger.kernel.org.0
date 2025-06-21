Return-Path: <bpf+bounces-61223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713CAE26A6
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 02:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D163A7B04ED
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 00:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8E68BE8;
	Sat, 21 Jun 2025 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYDZAHPW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA14A35;
	Sat, 21 Jun 2025 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750466450; cv=none; b=Ssx6QO6WAJGWON0PQ4Xr1Afn3Lz9Zs/4xpU3WTxHJjmVD9qlTyQMk0WDxgLumJG5pbS5BV2GDhLAkiDy1i/vi5DgPcaVvwN+GvyHHHZmrJkgH7KpYL4e47tuPVX35lx54UuPUdvQGDexWgX7O/ZrDO4vb3pHO3UFeCu5KGsDVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750466450; c=relaxed/simple;
	bh=b3l7q/zYy3M7RbCLsH1q/7gW+nGgdArO535ClG/5q1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU4ei867MM+4QITZ3zxmN/h7/cpPPZi7xmVFjCVejI2sOTuB3QRHMHXfY0fDHb6X9XC/+X2XeZ+j6slWhwv4HkbaEpQMlNeE+p1vdkbfk0LKgBVpcGQSb2NH41F6FE1B+pLzZy6Ksxe1QW3q/mdATzz3i02Ua06EEW83bgz3QMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYDZAHPW; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-872886ed65aso188968439f.1;
        Fri, 20 Jun 2025 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750466448; x=1751071248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVJ012qlo34+OkFVKxCvvps77WHbwLWwAdWVC2t5ATA=;
        b=eYDZAHPWAEOWyuLi0yp4tI9A8f1IAeDBINJtvTPxQ5JbUF9bmkgKs9hokY9cXJbcE9
         11Ud4pDOO2dCqAvjc8c6SI8VtWLdLwWyJaoTDlbuTgurPMTrGtoGv/93TCipqm2/ZMV6
         h1IYXZWvMWvhFMuoOjFivxf7TxxRdjZtW3NJPEjRYxBiX34cUvu+QR0V7j10+oZD9nD2
         ADEaVA2OJi1KGMpYI1VQ5PZPE8iOAWf4Y3m12umIKaAXwKUzqK3MXYI6ABd8z65B/0IT
         Ae9Y+cjIrOQUoqjvN4Zwh71DqaQ6TAZnCeTr8unTDLo7WuIQnwp8uejILpul1mq2UuUD
         jrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750466448; x=1751071248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVJ012qlo34+OkFVKxCvvps77WHbwLWwAdWVC2t5ATA=;
        b=pabsYegWhSAJMOhxeFTB30tYwvH60tMcntUAAsSM5wqcs8pu125KrnNOljZfsRm39G
         sCAbzRruw2/Dg7GbUEGoOLP8o7wfoMn+fH2brg2kjtojQnQYXOJbY8ibQkyCmFPD+qvN
         Vt6RphIPopyQA3q6KsICYIarqeuRX2OxAehMnFbYifxc1PfGeY9H2SEWxuaKYnv6VaM4
         ZqisK0G7tWea1rw42oE+CxPMXJ6cwC5GH3F7BpvqMAeNNH28ZcXZJE+0z3W7+d2PS/0U
         kyVWn2RlAkoWCDOpkCIo6FapjuevpnTc5sc8E/VV/mlq7pIG09CgFaUYUOlhaqK0/CDD
         KLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8dAAJvWXFLhluFmO5wEbu/oSuvUSoDgZtUFOBvZ5UKIfjsrzq9tLqOEZ5w8bWqcuoA1ipRj45@vger.kernel.org, AJvYcCVmA8i0rKqNKxLQl48yAsxYPxxewjub/c0CHwscQW9VveHJgLdxzmXwg1TvlLxUV/DSw/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjm1CDAupycu1KqFEETqihpaXTf406frlMJEXcrfADK03I9qUj
	NH2nre0KRopZxkxBIhGMGepejPTNNTbevLZ2MG3e0uo/KsYgCp8anZkpAqi6PFptA0pwmESbqeP
	XHZ8JyoeK64heNlWPjtE8IUZSC/kbUEM=
X-Gm-Gg: ASbGncskBuF/i3wxnAOUoR/J/+9tANbJ17Tv8BajxGmhiTICtb9RQnrJy6u/HLOu096
	zHWiU11AbAy79ZvgS9K2wU+jhm8TjgiHyDkQFny3TCFxOsOb+W+K/QJzjJeR4onWUjahqCmnZWM
	iWghZ89k4Ja2VlXu+F1TETBa9v21EE3w0iiy6A/pERf5U=
X-Google-Smtp-Source: AGHT+IGiMTbCo3njpiaBXeCzBj9uS37h5r+k3v/ZmBqV5fXOQTKBNB6yBolrU8G/JPcR93aNP3GqRUAm0QH4DBZ7yjY=
X-Received: by 2002:a05:6e02:221e:b0:3dd:d6c0:cccd with SMTP id
 e9e14a558f8ab-3de38ca54bemr46490885ab.13.1750466447736; Fri, 20 Jun 2025
 17:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org> <CAL+tcoA=KQCLdthH3VXPhd-z=sieKQu_xOPgQEzxdy0Mtnycag@mail.gmail.com>
 <68556722b5c47_3ffda429453@willemb.c.googlers.com.notmuch>
 <CAL+tcoAfr_3g6mD0i8dzMnm6aO+FzWRBo_eoHv7+mjDLve90Ww@mail.gmail.com> <6855df87665e3_1ca432948d@willemb.c.googlers.com.notmuch>
In-Reply-To: <6855df87665e3_1ca432948d@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 21 Jun 2025 08:40:10 +0800
X-Gm-Features: AX0GCFtYL84Jm9D4foTHAUrHNPNqxLpF4Vutgr_cEHaYzFLt0qbUs4Jlo3Ytb3E
Message-ID: <CAL+tcoD=4UKY-YK8NWGvTnbUUGpDa+5Orh3a3zE-YT5MFvBMbg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 6:24=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Fri, Jun 20, 2025 at 9:50=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Thu, Jun 19, 2025 at 11:09=E2=80=AFPM Jakub Kicinski <kuba@kerne=
l.org> wrote:
> > > > >
> > > > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool =
*pool, struct xdp_desc *desc)
> > > > > >       rcu_read_lock();
> > > > > >  again:
> > > > > >       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) =
{
> > > > > > -             if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGE=
T) {
> > > > > > +             int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > > > > +
> > > > > > +             if (xs->tx_budget_spent >=3D max_budget) {
> > > > > >                       budget_exhausted =3D true;
> > > > > >                       continue;
> > > > > >               }
> > > > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct=
 xdp_sock *xs,
> > > > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > > > >  {
> > > > > >       struct xdp_sock *xs =3D xdp_sk(sk);
> > > > > > -     u32 max_batch =3D TX_BATCH_SIZE;
> > > > > > +     u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > > >
> > > > > Hm, maybe a question to Stan / Willem & other XSK experts but are=
 these
> > > > > two max values / code paths really related? Question 2 -- is gene=
ric
> > > > > XSK a legit optimization target, legit enough to add uAPI?
> > > >
> > > > I'm not an expert but my take is:
> > > > #1, I don't see the correlation actually while I don't see any reas=
on
> > > > to use the different values for both of them.
> > > > #2, These two definitions are improvement points because whether to=
 do
> > > > the real send is driven by calling sendto(). Enlarging a little bit=
 of
> > > > this value could save many times of calling sendto(). As for the uA=
PI,
> > > > I don't know if it's worth it, sorry. If not, the previous version =
2
> > > > patch (regarding per-netns policy) will be revived.
> > > >
> > > > So I will leave those two questions to XSK experts as well.
> > >
> > > You're proposing the code change, so I think it's on you to make
> > > this argument?
> > >
> > > > #2 quantification
> > > > It's really hard to do so mainly because of various stacks implemen=
ted
> > > > in the user-space. AF_XDP is providing a fundamental mechanism only
> > > > and its upper layer is prosperous.
> > >
> > > I think it's a hard sell to argue adding a tunable, if no plausible
> > > recommendation can be given on how the tunable is to be used.
> >
> > Actually I mentioned it in the commit message. One of advantages is to
> > contribute to less frequencies of sendto() and overall higher
> > transmission speed.
>
> Understood. It is just informative to have more quantitative data.
> What value worked for you.

I see what you mean. Now I think I had better add more details as
follows to show how I arrived at the certain value in the next
version.

>
> > >
> > > It's not necessary, and most cases infeasible, to give a heuristic
> > > that fits all possible users. But at a minimum the one workload that
> > > prompted the patch. What value do you set it to and how did you
> > > arrive at that number?
> >
> > One naive question from me is why the number of packets to be sent is
> > definitely required to be limited within a small number by default?
> > Let me set tcp as an example, a simple sendmsg call will not be
> > stopped because of the hardcoded limitation.
> >
> > For one application I saw, I suggested using 128 because I saw two
> > limitations without changing any default configuration: 1)
> > XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> > this was I counted how many desc are transmitted to the driver at one
> > time of sendto() based on [1] patch and then I calculated the
> > possibility of hitting the upper bound. Finally I chose 128 as a
> > suitable value because 1) it covers most of the cases, 2) a higher
> > number would not bring evident results.
> >
> > [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing=
@gmail.com/
>
> This is indeed helpful context.
>
> Another limiting factor is the XSK TX queue length?

Right, through setting setsockopt(SO_SNDBUD) to increase the queue
length can avoid frequent premature exit from __xsk_generic_xmit().
FYI, the call trace is
__xsk_generic_xmit()
    ->xsk_build_skb()
        ->sock_alloc_send_skb()
            -> if (sk_wmem_alloc_get(sk) < READ_ONCE(sk->sk_sndbuf))

>
> So even if a user passes UINT_MAX, nothing terrible will happen.

Right. And the BQL feature is another possible limit.

>
> Still, it is better to not accept obviously bad input to begin with.

Sure, I can do that. What exact value of upper bound should be, I
wonder? It's not easy to set a hard limit.

Another thing is that what you said on the lower bound in the previous
email is what I missed in the current patch. Thanks for your reminder.
And sorry. I forgot to set it to 1 as my first two patches did. At
least, lower bound is required which is an explicitly unexpected
behaviour.

I'm about to set the lower one _only_ in V4 to see if it works for everyone=
.

Thanks,
Jason

>
> Normal packet processing loops give up control after tens or maybe
> a few hundred packets at a time.

