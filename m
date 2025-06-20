Return-Path: <bpf+bounces-61219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B1AE25B5
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 00:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E61890C25
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C4248F41;
	Fri, 20 Jun 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW8sLYcI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F8238C0C;
	Fri, 20 Jun 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458251; cv=none; b=hKNirvjDegjtqcPalgSqzhnJzIrTra4RhghSq2ZHCCBSmt5zSMnzN3p8a1t0yGPIQgDBc5asqAa0YQCQwD0ulEa0jzaLbX769mqlZHfhicwbfjH95oxxkRX05xEgfKUG0YVn7cTTydVnnIakcrEB5hzjqYwScAhlfdcp4/Wi5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458251; c=relaxed/simple;
	bh=jFp6Sgs2fq7ctYabHNbQLclGHoPgsrh2MuXAHF7g6jE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DcZjJ15IJsbDsefHSEir45htLifXXCGLixcylDN7z5nkWvat3N2bfjAXqB/j1XpO/yiIhFp4hkydJCr0PSHj/0VE1IAL3Pt4pizDCIKk9iUJJzVyKi4AcnPwqymMD7KW+6AW2Bj6U01ZRx93xfKU+YU2HiZVh+rrXZHK0BewIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW8sLYcI; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e81877c1ed6so1989152276.0;
        Fri, 20 Jun 2025 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750458248; x=1751063048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIPpvOd50Sst+ihpm+EcV5dV6M5UNz7expt4AKbJBu0=;
        b=QW8sLYcIF5wbqyNzcm5/Gu3ybuTDpIfuV0mxCuEwkQBvuhic09e+qSSoAtmC73YjvH
         7ipioIixwVjZJKZMJDPU1fIpWRgxZvxQyd3dRkFRlMWdATest/Uxce87wY1PramHtnAG
         WjrK6vu5F859T6YgQ/2Adt6e7UnrFT2hHSvD1qymw5kofkMppVxyC+gRD0UGN7ecrdq1
         /SwzO4JxXlRiAZZtMeB1QAoLTajStaSDKMpxOzMNALaUnZb6zsYLMb8E4VYgVhfBIOz6
         XtcjeVpbtRfN3FL1PQTVbZFTFJyBcyGoF6eDNGgq+Cq0X5W1Gc6lv1rp40uO6cC0NFbD
         2aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458248; x=1751063048;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZIPpvOd50Sst+ihpm+EcV5dV6M5UNz7expt4AKbJBu0=;
        b=DzJh1CFBuSthT6zy6Xov8JGSFUb2hU2X/xinlHL8Ijb2rpiv42GtorCMTP4BrH8wXi
         7uwgIAWVR3k/HGm4pzRRQSh+BrnFkeUSr2T+R1Pd8cLozdxWEaS2Y/XUq/OcORWvoEJQ
         EhfJ9dH3tOKYqlLbPtmk+uUKbAvhQx7eKGYA19xgQUAvBZi/BDE2YBcaQ8TylAa59zoY
         p9/8xAPudUmN7KeAupqHztM6yw3xX0xVW0u5qqo9LWMdDatydkaGUu7xDOHgGl+h7j6F
         Ej/WIBO63d2DetdKJn7gNUhpQ5hZCxdD7nyuX531IIO/CMi+AD3pOo4URBkMdUhtgtdt
         RfXA==
X-Forwarded-Encrypted: i=1; AJvYcCVSdoIc4iFMPaFqtPjMO58RjlqAqaawtatuPVdmI3KfBXIXCrF6a5da8/hfC7wt56jYKaU=@vger.kernel.org, AJvYcCWboYBkLFZtFrg0HOTTsJxSL+2tGQgpYPonSMvHiLfYAgtQYmerxxA7re7AKgnWvi0lbmifRzmn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/c4MWwVFhDHVajGi0RakXWq1w1e3T3NFNIKaYM8aF+29G65r
	Foz/e28o4ThGXxx9Y89HRZr75cL0m3CQPPkzCe2dz2Pd65UigrICQ6jI
X-Gm-Gg: ASbGncsU7qjCDbYxWlDHdVS40j78m0oFMHE8caOjE9jd7sOiBrGxujfiLwSdauYfO3L
	28dnAU2vKMVHf/NMXKRHB+05Cw0sbXvZb21Q00Wyr75/dSbsnrRsHVhSWZ6rv+rzUZunmwvLc3S
	wOWotwYTZDhhhorRwwBL9JNiBLm49LDX4MyvwfAeG4YNjxVvvQbhNwY+q8Pyi2Gaqb2F3llBrZe
	5ixOsjRRlL3u/2GAqghzjg0DLaT/5k2g14cJC2+TZtUb3MJyp9eu6DMMCSE47GMqMi0opYZavQd
	Yz4N1hbqxQry606sXQeGM3FQLgtqKJHK3jOIRtdv7s4LuM5LQkhGZj1qE9XH/nL46sKM+ICOrHC
	KJ74ShsulIQbwX3jaMVxFfHbLDwLxR8tSlH0Tp3nhiw==
X-Google-Smtp-Source: AGHT+IFkOflAVJIcfkrlHh3OLPrDoh5av7X6K+QmRFpbZP8PR22wEMPRyE5zUf1GY4G8+OVIQP754A==
X-Received: by 2002:a05:6902:1023:b0:e81:8760:15a1 with SMTP id 3f1490d57ef6-e842ef53c15mr5101418276.11.1750458248400;
        Fri, 20 Jun 2025 15:24:08 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842aab9446sm895117276.9.2025.06.20.15.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:24:07 -0700 (PDT)
Date: Fri, 20 Jun 2025 18:24:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 bjorn@kernel.org, 
 magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, 
 jonathan.lemon@gmail.com, 
 sdf@fomichev.me, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 joe@dama.to, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6855df87665e3_1ca432948d@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAfr_3g6mD0i8dzMnm6aO+FzWRBo_eoHv7+mjDLve90Ww@mail.gmail.com>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org>
 <CAL+tcoA=KQCLdthH3VXPhd-z=sieKQu_xOPgQEzxdy0Mtnycag@mail.gmail.com>
 <68556722b5c47_3ffda429453@willemb.c.googlers.com.notmuch>
 <CAL+tcoAfr_3g6mD0i8dzMnm6aO+FzWRBo_eoHv7+mjDLve90Ww@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Fri, Jun 20, 2025 at 9:50=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Thu, Jun 19, 2025 at 11:09=E2=80=AFPM Jakub Kicinski <kuba@kerne=
l.org> wrote:
> > > >
> > > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool =
*pool, struct xdp_desc *desc)
> > > > >       rcu_read_lock();
> > > > >  again:
> > > > >       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) =
{
> > > > > -             if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGE=
T) {
> > > > > +             int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > > > +
> > > > > +             if (xs->tx_budget_spent >=3D max_budget) {
> > > > >                       budget_exhausted =3D true;
> > > > >                       continue;
> > > > >               }
> > > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct=
 xdp_sock *xs,
> > > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > > >  {
> > > > >       struct xdp_sock *xs =3D xdp_sk(sk);
> > > > > -     u32 max_batch =3D TX_BATCH_SIZE;
> > > > > +     u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > >
> > > > Hm, maybe a question to Stan / Willem & other XSK experts but are=
 these
> > > > two max values / code paths really related? Question 2 -- is gene=
ric
> > > > XSK a legit optimization target, legit enough to add uAPI?
> > >
> > > I'm not an expert but my take is:
> > > #1, I don't see the correlation actually while I don't see any reas=
on
> > > to use the different values for both of them.
> > > #2, These two definitions are improvement points because whether to=
 do
> > > the real send is driven by calling sendto(). Enlarging a little bit=
 of
> > > this value could save many times of calling sendto(). As for the uA=
PI,
> > > I don't know if it's worth it, sorry. If not, the previous version =
2
> > > patch (regarding per-netns policy) will be revived.
> > >
> > > So I will leave those two questions to XSK experts as well.
> >
> > You're proposing the code change, so I think it's on you to make
> > this argument?
> >
> > > #2 quantification
> > > It's really hard to do so mainly because of various stacks implemen=
ted
> > > in the user-space. AF_XDP is providing a fundamental mechanism only=

> > > and its upper layer is prosperous.
> >
> > I think it's a hard sell to argue adding a tunable, if no plausible
> > recommendation can be given on how the tunable is to be used.
> =

> Actually I mentioned it in the commit message. One of advantages is to
> contribute to less frequencies of sendto() and overall higher
> transmission speed.

Understood. It is just informative to have more quantitative data.
What value worked for you.
 =

> >
> > It's not necessary, and most cases infeasible, to give a heuristic
> > that fits all possible users. But at a minimum the one workload that
> > prompted the patch. What value do you set it to and how did you
> > arrive at that number?
> =

> One naive question from me is why the number of packets to be sent is
> definitely required to be limited within a small number by default?
> Let me set tcp as an example, a simple sendmsg call will not be
> stopped because of the hardcoded limitation.
> =

> For one application I saw, I suggested using 128 because I saw two
> limitations without changing any default configuration: 1)
> XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> this was I counted how many desc are transmitted to the driver at one
> time of sendto() based on [1] patch and then I calculated the
> possibility of hitting the upper bound. Finally I chose 128 as a
> suitable value because 1) it covers most of the cases, 2) a higher
> number would not bring evident results.
> =

> [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing=
@gmail.com/

This is indeed helpful context.

Another limiting factor is the XSK TX queue length?

So even if a user passes UINT_MAX, nothing terrible will happen.

Still, it is better to not accept obviously bad input to begin with.

Normal packet processing loops give up control after tens or maybe
a few hundred packets at a time.=

