Return-Path: <bpf+bounces-61177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC9BAE1E0C
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0F81C20ED4
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6022BD5B9;
	Fri, 20 Jun 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETy/Zvzi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CB30E85E;
	Fri, 20 Jun 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431869; cv=none; b=lU+yySGmClUmixlgrWr5dnKDxx321UKEsLwTtBITIh7zmnd5mRuetvch1kORR8gegYG34PCrvq6ZsvrRistNN9RRyrdnxaf3HwOxXKGggWqMZK638QZtIiwm3KwL3H4knS1+4YMIwv0yghaAuw3Kb+V4agapCP2pEvxrgoA5RMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431869; c=relaxed/simple;
	bh=nsit4ot+qTGMbE0hGNxmGUmgpO+QWLiArQtHhSL/ufQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/jo9DGPoUaA8QQxea8N0TUPa+98XwKpBr6ZAcn/o7FHcueXFhn7mseVdwN9u7cbIqt3PBmz/68WMpj5gArKAUad4UJMJJT+se477VJc6DiT12xLXtp5MNhxDCOzuDtvb4rPgp68p6+mMH6gwuvtaIJjmMSo6NHs8t81q/n+2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETy/Zvzi; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddff24fdc4so21422975ab.2;
        Fri, 20 Jun 2025 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750431867; x=1751036667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4sPcw7S5y2eePbAkNoKjIjARaBKxAiqtotdPzTf0F0=;
        b=ETy/ZvziwtPiXI3cM9NGr+LwE95QAJf/DpqDouBgZUjR4vgAPT/ZTnrImqXaJ++ruB
         cWQNnzqBMuq4aGkPsA9xRygREu/xzWl4TOs/dNb19YwIxLpmjWxFFNQtWm1kKL7zgXhT
         uMkmVShisu9q9N0OZnM5uQpVG290zaKUndxnanpte/9odUCejAoP4hmHybKVL9tejeOo
         0lVxosadLzSzskxcFieUF2+nb1R09p5Y5ITDDgFQ94WHEYW35AJKyxDqXvaWI0bJyNUd
         4yUXi7+fZ9vmca4YyAHahLB0/wu5LDMhM3h5ONVb3nHoLYY2yizpWeTlK0tpS1iOCwiO
         4Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750431867; x=1751036667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4sPcw7S5y2eePbAkNoKjIjARaBKxAiqtotdPzTf0F0=;
        b=rwH1dyIOJ6zH8PTuw+VPomiC3gDzD5aIOzZ/szPV4ljGHmAd4ytfcgfFU1GpmNcs8D
         zh49Z8sRtD70pQPkCjJh6X+nle5zDsMYwBrZNvJGseI7ppuJ5R68BcZfu/fwL1vhANB1
         5+XX+AUMAnt6mUQP5cRmLvdN32zzH1u8YoPrdDDhEHUNEpdf8uLdMsfq/ebrm+9dIa+k
         Qs3pMR9jAL1fxRUZb6ZHvhk1aB3hn9ftR9p9mH6mB0g62HGv/JqzXDGgV1uOveJF63L0
         4uGWuDxTmBBVLjyp/aaWNE+hNpvxH+9bdxDFYFBXvvU3D1LhlDy8xlZrvMaUNxfCIUjB
         ZO7w==
X-Forwarded-Encrypted: i=1; AJvYcCX6KKTv8DOpJeWAztwAaeT4STs6cuPj8bZ/hRq6U+kcd+HGHpn9kOuCN8Q7qb9d9X1wl4A=@vger.kernel.org, AJvYcCXuvhgpCxDhLMwVuiFqoDl/mlklZP51tIO/aptdC6Bmmlr7v4jC/zZn9C9TATbHtduCdnWEDF+N@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Oo768tlZoyeL2AES8t0enMnCKgze74l05uDlWCoTTX0yvtLu
	lfajjTyYx1NpLHGFM8dpJ6F1/G2jRsvkIV8oFryXsEarsUQ0uwBGQPNiNFrARdvQHLrtAifqQaC
	kqtaVVPM2LhMqXdz0ZfMTLfaYG9kK7I4=
X-Gm-Gg: ASbGncugsIG7OKrJQmBoyWZb4QCxAuqUwpkjAXMo4X1/mT1IpNWJiYv6dgsMfIMdhSS
	rzPib2ruPsyCYdpHjcjXQSVMDTWTn53b+VrFnz11rPfN0CoL4Pc3GNJmnWEaiooEFnYRENq2WPO
	zRSPyU9xbAQG1LaFcgtIx50pXjUIE53a35lSWWaidM4w==
X-Google-Smtp-Source: AGHT+IHSSj9HQHp5o9T6GF1C361xaJPbcRgskLn/Hx7dddvXBBqvzo02wjpm6tyMK61F8hBH0vnUWEP/dz3OVRekpBk=
X-Received: by 2002:a05:6e02:3189:b0:3dc:8075:ccde with SMTP id
 e9e14a558f8ab-3de38c15a7dmr41515805ab.4.1750431866955; Fri, 20 Jun 2025
 08:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org> <CAL+tcoA=KQCLdthH3VXPhd-z=sieKQu_xOPgQEzxdy0Mtnycag@mail.gmail.com>
 <68556722b5c47_3ffda429453@willemb.c.googlers.com.notmuch>
In-Reply-To: <68556722b5c47_3ffda429453@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Jun 2025 23:03:50 +0800
X-Gm-Features: AX0GCFslcvmx8W07JMgch-uJelRRCCZwYk4ie78Vsja1aayDNuNVw5yCfw7leZw
Message-ID: <CAL+tcoAfr_3g6mD0i8dzMnm6aO+FzWRBo_eoHv7+mjDLve90Ww@mail.gmail.com>
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

On Fri, Jun 20, 2025 at 9:50=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Jun 19, 2025 at 11:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *poo=
l, struct xdp_desc *desc)
> > > >       rcu_read_lock();
> > > >  again:
> > > >       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > > -             if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> > > > +             int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > > +
> > > > +             if (xs->tx_budget_spent >=3D max_budget) {
> > > >                       budget_exhausted =3D true;
> > > >                       continue;
> > > >               }
> > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > >  {
> > > >       struct xdp_sock *xs =3D xdp_sk(sk);
> > > > -     u32 max_batch =3D TX_BATCH_SIZE;
> > > > +     u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > >
> > > Hm, maybe a question to Stan / Willem & other XSK experts but are the=
se
> > > two max values / code paths really related? Question 2 -- is generic
> > > XSK a legit optimization target, legit enough to add uAPI?
> >
> > I'm not an expert but my take is:
> > #1, I don't see the correlation actually while I don't see any reason
> > to use the different values for both of them.
> > #2, These two definitions are improvement points because whether to do
> > the real send is driven by calling sendto(). Enlarging a little bit of
> > this value could save many times of calling sendto(). As for the uAPI,
> > I don't know if it's worth it, sorry. If not, the previous version 2
> > patch (regarding per-netns policy) will be revived.
> >
> > So I will leave those two questions to XSK experts as well.
>
> You're proposing the code change, so I think it's on you to make
> this argument?
>
> > #2 quantification
> > It's really hard to do so mainly because of various stacks implemented
> > in the user-space. AF_XDP is providing a fundamental mechanism only
> > and its upper layer is prosperous.
>
> I think it's a hard sell to argue adding a tunable, if no plausible
> recommendation can be given on how the tunable is to be used.

Actually I mentioned it in the commit message. One of advantages is to
contribute to less frequencies of sendto() and overall higher
transmission speed.

>
> It's not necessary, and most cases infeasible, to give a heuristic
> that fits all possible users. But at a minimum the one workload that
> prompted the patch. What value do you set it to and how did you
> arrive at that number?

One naive question from me is why the number of packets to be sent is
definitely required to be limited within a small number by default?
Let me set tcp as an example, a simple sendmsg call will not be
stopped because of the hardcoded limitation.

For one application I saw, I suggested using 128 because I saw two
limitations without changing any default configuration: 1)
XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
this was I counted how many desc are transmitted to the driver at one
time of sendto() based on [1] patch and then I calculated the
possibility of hitting the upper bound. Finally I chose 128 as a
suitable value because 1) it covers most of the cases, 2) a higher
number would not bring evident results.

[1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gma=
il.com/

Thanks,
Jason

