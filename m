Return-Path: <bpf+bounces-69807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989E6BA2CDD
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE1E1C0139D
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96127E071;
	Fri, 26 Sep 2025 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tha4Fn6e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C617A2EB
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872042; cv=none; b=a891r42D5CYchmD8JBEYwcfrGJtQb8mn1YzjlQPoYzXcs97vMDmq7iQRWjBeaCfbrJzzQWSombiRfIR3uPSFP2sHs1/y6wpIJQ6ItoNpJNygUonu5jvIh5/Mx5bXtD7eNdda/rULLGx7gOW7kxvKwGuGEzQX7rb2LyaPh6nHp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872042; c=relaxed/simple;
	bh=43+arxHIZZPcm1CwK9O5ILMH9H6gVenccJ0NbaovTm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6SRTzZ1NA7wXXo7hqfDaS44VwMQQbnYfTwyDY/nDauOliRsaDtwYIEihtWbwQXqo6CGsyCaVaD5xRbhAXrzCkl3FgDLLZL/NlK9xaHzrYApcavIHUnB0O9nUMdw0cU9MPuoLPMtyoDQ1YuZT0Byagu1SWwog5TGxhXmxJWDXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tha4Fn6e; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57dda094f6cso5085e87.0
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758872038; x=1759476838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBZhJSbHuJVNYFNQx8sDjlGQJWDTuWRThogwStulwmo=;
        b=Tha4Fn6ejp20uDxclEfPDzw7NIK1NBymvBn/1fEXlS31N+IyNhpxOEDSZqumUw0fQ8
         RpnCI9yZnTwSheTVTPhHrjJ+Smjk5vN91MSQ20+5L+CH8rTPG1BN7D6G0ORpliffEFTs
         BDrj4E8OqIY5aeLqwAjGbE5D7eL/MO5Lp/0h3tKfQUEqqdSmCTanftApbqGc/yGhJsNM
         TcGAwLqVvdEsl3g/uibutE6t/9b3XtjTsSuPS6RdBZjbb6ijc2FEckqqrY9GErUxe57F
         Ev/4rJ88RMxQLg6Pp2OOaPDbWYwWuGi9RWZo9IO0fgtwcDzkkA4V7cfT+RWB17SFnX0Q
         DQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758872038; x=1759476838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBZhJSbHuJVNYFNQx8sDjlGQJWDTuWRThogwStulwmo=;
        b=t0BjX6dzWvmozP4SX3DrLxSn8P6fpi9kEexUdfC49rR6qoHYHShugh5tJ2DMlGY0q1
         oiBBcgRJHKf3BiT7Ksz/9jwoYQUJCLQOuLas0Ixq3iNhdT2//a4CPN40Vr74CtLQxXdp
         oHOJnDhhC4d7+hnwDinFmgjIbEgeWjoO0jmBNkreBkRkbHWeygjV1IsQ4wDUMRI+1wBJ
         LTgTsaxl80PxRPTDWR0011hqR8wW00swnset5Nf32Gcma+iihOevrXxU2YiWSK+aboAO
         WR8CUT/kFECXDbZ+VA3dDovckcWHH9VoSXNnI7rpAholzfdSBtrMMiURmoaXKhXW8oVC
         jhmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzxfvvwSIXgixn5o+hrjbol7/3v6EjwSG6ZSMTv3y+uwV2xRCipvghnXC2svwjgf5G/QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQosLkHyx1+LfL03I0pFu8wfdY/arZcmzp9lP+qhHwKUS36WA
	KXZMHP2LJaEsAOyB1TAhrYxIAr4fKY92LQUtG1DRkv84fjFvpXoEofJM17sBONUhNS/XyVKBGrX
	TdyZJwFlL7uk+1o7hmyCc/Djn7XLmIVw36cPceAZM
X-Gm-Gg: ASbGncv5jY1zjV4AtfBP82ZlhlYQP2d5g2l8FCgBFbkfkQ/3fN8HwmDNsORAHu7euk5
	scH3CbVWp5y/zwDeG647342aBwncs7vjfIx4CBeTFRMt/UQc6DwOUYDupBelbNLo82zqDMSVqhC
	D4tSpKLOp6Eyr30+DorroEbOXULBXKXphIcqE9eidUDua6zwunAqXhqv3ZAFRSy2GK0z4Zzuotx
	la0NCB8FefkV6njcx61P8Rfz+5cY8hhz1+x2KeLrfq/9XE=
X-Google-Smtp-Source: AGHT+IG0I1cuFdB5NzE00N0rhpCLOpSuSGU9Q2QmiolE+hhpYTRAWFN4+R73lM2EIdTtEteIap5lRAfNxHQuKEHssf4=
X-Received: by 2002:ac2:5ded:0:b0:57b:f611:f918 with SMTP id
 2adb3069b0e04-58438d03dfamr209489e87.3.1758872038112; Fri, 26 Sep 2025
 00:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924060843.2280499-1-tavip@google.com> <20250924170914.20aac680@kernel.org>
 <CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
 <aNUObDuryXVFJ1T9@boxer> <20250925191219.13a29106@kernel.org>
In-Reply-To: <20250925191219.13a29106@kernel.org>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 26 Sep 2025 00:33:46 -0700
X-Gm-Features: AS18NWC04uq5PgWIZ1vcjFQEJzvryXi-17sPAp4VHgGoES1fwf9NPZmqEHUgz1Y
Message-ID: <CAGWr4cSiVDTUDfqAsHrsu1TRbumDf-rUUP=Q9PVajwUTHf2bYg@mail.gmail.com>
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com, toke@redhat.com, 
	lorenzo@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 7:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 25 Sep 2025 11:42:04 +0200 Maciej Fijalkowski wrote:
> > On Thu, Sep 25, 2025 at 12:53:53AM -0700, Octavian Purdila wrote:
> > > On Wed, Sep 24, 2025 at 5:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > On Wed, 24 Sep 2025 06:08:42 +0000 Octavian Purdila wrote:
> >  [...]
> > > >
> > > > This can also happen on veth, right? And veth re-stamps the Rx queu=
es.
> >
> > What do you mean by 're-stamps' in this case?
> >
> > >
> > > I am not sure if re-stamps will have ill effects.
> > >
> > > The allocation and deallocation for this issue happens while
> > > processing the same packet (receive skb -> skb_pp_cow_data ->
> > > page_pool alloc ... __bpf_prog_run ->  bpf_xdp_adjust_tail).
> > >
> > > IIUC, if the veth re-stamps the RX queue to MEM_TYPE_PAGE_POOL
> > > skb_pp_cow_data will proceed to allocate from page_pool and
> > > bpf_xdp_adjust_tail will correctly free from page_pool.
> >
> > netif_get_rxqueue() gives you a pointer the netstack queue, not the dri=
ver
> > one. Then you take the xdp_rxq from there. Do we even register memory
> > model for these queues? Or am I missing something here.
> >

Ah, yes, you are right. So my comment in the commit message about
TUN/TAP registering a page shared memory model is wrong. But I think
the fix is still correct for the reported syzkaller issue. From
bpf_prog_run_generic_xdp:

        rxqueue =3D netif_get_rxqueue(skb);
        xdp_init_buff(xdp, frame_sz, rxq: &rxqueue->xdp_rxq);

So xdp_buff's rxq is set to the netstack queue for the generic XDP
hook. And adding the check in netif_skb_check_for_xdp based on the
netstack queue should be correct, right?

> > We're in generic XDP hook where driver specifics should not matter here
> > IMHO.
>
> Well, IDK how helpful the flow below would be but:
>
> veth_xdp_xmit() -> [ptr ring] -> veth_xdp_rcv() -> veth_xdp_rcv_one()
>                                                                |
>                             | xdp_convert_frame_to_buff()   <-'
>     ( "re-stamps" ;) ->     | xdp->rxq =3D &rq->xdp_rxq;
>   can eat frags but now rxq | bpf_prog_run_xdp()
>          is veth's          |
>
> I just glanced at the code so >50% changes I'm wrong, but that's what
> I meant.

Thanks for the clarification, I thought that "re-stamps" means the:

    xdp->rxq->mem.type =3D frame->mem_type;

from veth_xdp_rcv_one in the XDP_TX/XDP_REDIRECT cases.

And yes, now I think the same issue can happen because veth sets the
memory model to MEM_TYPE_PAGE_SHARED but veth_convert_skb_to_xdp_buff
calls skb_pp_cow_data that uses page_pool for allocations. I'll try to
see if I can adapt the syzkaller repro to trigger it for confirmation.

