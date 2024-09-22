Return-Path: <bpf+bounces-40178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D4897E2C5
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 19:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F019B20F10
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8053716D;
	Sun, 22 Sep 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBBj+mpu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE229D1C
	for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727026773; cv=none; b=DxYskfU+zNOun/HagDLh6DMDTQ4r7luM3v0I4+8uYJ/gDFwbWssF8/lVHIIQMiocs2sEYV+o6bPtbMII4LCmskOhCCLWhSm8roYp/RxRJfVrN7N/oLkDsTAXbx/oHd43ZATV1DZsKNFBVZwWyZ6TdFh9SJwzPj2XFyXf7yIPn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727026773; c=relaxed/simple;
	bh=O1lotOYrmxqxROlwXz44VaBG2u/73HB6scPqwKg4AkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVQMSZRf18XOF6GlQdHtT0HVUeflyPHnfLzDKNag+jm7Y6yCKHvpixZ7wUyTkAKITv8nVFh45ukL5+OtQFrOlDe07GtMa21GPJFAqNzAO4pTnH75I2e5hC6Z7QNLKzLkm4WPpNOsD0EzBpMD2YfDfPCrGRK6oBEH4hOXz/EJSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBBj+mpu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c413cf5de5so4955480a12.0
        for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727026770; x=1727631570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpGAB+CE62FRMTTUXNO0uAcJsLoHQPKChAlcetMB+aU=;
        b=eBBj+mpui6UZvZo+c5MUQY40C5gJRpWl2/DfYCHkk1tQ8FteEgUv+g7TGTEkkX6CIx
         R7TD/9aFgSpDbdLMOD5EWfbpZBFVXJ9JpRYwA3/wvQ+118nFektS5rNi/DJyQZiPp65x
         E4GD7cNl7XpSqrejPZQrAoCMeogD1RD45+5Q1hjYaNYHOO7b6b2JXJoo7gJAoWo6xu4P
         Nwha9sE8K04ZyfttNBlxODAlCbVRn2q93HvFQXkCZNcF4IA8ER0BT601F/48JxZ33+5l
         9s9jbddRzLhkVy5fV0zqP2K3k/SFGRkNMj7siT+0znuaGTdiX/eDX3+BdlnCUh4svy+0
         voyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727026770; x=1727631570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpGAB+CE62FRMTTUXNO0uAcJsLoHQPKChAlcetMB+aU=;
        b=VAbo+XQT1YA5hVDOX09WMqAbiTzio7QNNYOf0MzukVCo5Oiyi6Y5aAoNTL051ogbxr
         3tHeZzBB4SvCzUXH06Vz4TiVxPrCX2vgJ3l3p24ibHy+5tiSDLUX0VctLFLPnkzZd5qz
         zyQHk9uGbn2WZ570U3TyUEfuAYoKkWhmvHoekeEjMVsZ57RSGUmkhogEeDZt4xQE9awp
         2jNt/E7fhqgdXModx2Dwr9fKWMib4N22vW1Ptt928BfnwnPYDKrYobHci642fPIPUZ4l
         RbQT1h05iANZv4e4kdFePlaXJdWHQcROfvSAo36yjZ1vBs6DrwvwZJVvgbDEFYr0wC3D
         2K/g==
X-Forwarded-Encrypted: i=1; AJvYcCUdw1OcfeLyIzPEt4YCcFKQP/cuFwf1vTuGiBLJs/ScyLV68NmybzFS/KdGZz2+susZbBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx723JQiLRx8s+m43T2vU6r61bcQdQogUTczQA9+THO5LSxYj6Y
	s7DNdW5Ckr+gg4HFNSyIZzqf0cbIjYPiAAG5qGi3wHtUpnDdPXdSgZOnFKMDPdiD0N9ctRmVjv6
	hHKIDqA5Im9I1WNofRwl9k90Llr12h4fRCuA5
X-Google-Smtp-Source: AGHT+IEnPr5vqUgfk5C1HQbuqZp/7fOYioCcZbjCxTrQu4/Fo45MYW2Fl8uHhs6poJBrUpPZxjRXGk9KE1XbEdnfV+E=
X-Received: by 2002:a05:6402:4489:b0:5c5:5493:7570 with SMTP id
 4fb4d7f45d1cf-5c55493766emr6447964a12.21.1727026769586; Sun, 22 Sep 2024
 10:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322122407.1329861-1-edumazet@google.com> <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
 <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
 <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
 <CAADnVQ+OhsBetPT0avuNVsEwru13UtMjX1U_6_u6xROXBBn-Yg@mail.gmail.com>
 <ZgGmQu09Z9xN7eOD@google.com> <d9531955-06ad-ccdd-d3d0-4779400090ba@iogearbox.net>
 <CANn89iJFOR5ucef0bH=BTKrLOAGsUtF8tM=cYNDTg+=gHDntvw@mail.gmail.com>
 <CANn89iKZ0126qzvpm0bPP7O+M95hcGWKp_HPg+M7vgdDHr0u0A@mail.gmail.com>
 <3050c54d-3b3c-53b0-6004-fa11caca27b6@iogearbox.net> <CANn89iK25-UnBaz_=15SCZKzAmh2-vgMhfStv5GqFg=95VJE+A@mail.gmail.com>
In-Reply-To: <CANn89iK25-UnBaz_=15SCZKzAmh2-vgMhfStv5GqFg=95VJE+A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 22 Sep 2024 19:39:16 +0200
Message-ID: <CANn89iK3M7W1PJKCyH65JePkmEd7r0UeymNqA9N1bMR4UAe_Nw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Guillaume Nault <gnault@redhat.com>, patchwork-bot+netdevbpf@kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:08=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Mar 26, 2024 at 6:57=E2=80=AFPM Daniel Borkmann <daniel@iogearbox=
.net> wrote:
> >
> > On 3/26/24 2:38 PM, Eric Dumazet wrote:
> > > On Tue, Mar 26, 2024 at 2:37=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > >> On Tue, Mar 26, 2024 at 1:46=E2=80=AFPM Daniel Borkmann <daniel@ioge=
arbox.net> wrote:
> > >>> On 3/25/24 5:28 PM, Stanislav Fomichev wrote:
> > >>>> On 03/25, Alexei Starovoitov wrote:
> > >>>>> On Mon, Mar 25, 2024 at 6:33=E2=80=AFAM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > >>>>>> On Sat, Mar 23, 2024 at 4:02=E2=80=AFAM Alexei Starovoitov
> > >>>>>> <alexei.starovoitov@gmail.com> wrote:
> > >>>>>>> On Fri, Mar 22, 2024 at 7:10=E2=80=AFAM <patchwork-bot+netdevbp=
f@kernel.org> wrote:
> > >>>>>>>>
> > >>>>>>>> Hello:
> > >>>>>>>>
> > >>>>>>>> This patch was applied to bpf/bpf.git (master)
> > >>>>>>>> by Daniel Borkmann <daniel@iogearbox.net>:
> > >>>>>>>>
> > >>>>>>>> On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
> > >>>>>>>>> Some drivers ndo_start_xmit() expect a minimal size, as shown
> > >>>>>>>>> by various syzbot reports [1].
> > >>>>>>>>>
> > >>>>>>>>> Willem added in commit 217e6fa24ce2 ("net: introduce device m=
in_header_len")
> > >>>>>>>>> the missing attribute that can be used by upper layers.
> > >>>>>>>>>
> > >>>>>>>>> We need to use it in __bpf_redirect_common().
> > >>>>>>>
> > >>>>>>> This patch broke empty_skb test:
> > >>>>>>> $ test_progs -t empty_skb
> > >>>>>>>
> > >>>>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> > >>>>>>> [redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingre=
ss
> > >>>>>>> [redirect_ingress]: actual -34 !=3D expected 0
> > >>>>>>> test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redire=
ct_egress] 0 nsec
> > >>>>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> > >>>>>>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingres=
s
> > >>>>>>> [redirect_egress]: actual -34 !=3D expected 1
> > >>>>>>>
> > >>>>>>> And looking at the test I think it's not a test issue.
> > >>>>>>> This check
> > >>>>>>> if (unlikely(skb->len < dev->min_header_len))
> > >>>>>>> is rejecting more than it should.
> > >>>>>>>
> > >>>>>>> So I reverted this patch for now.
> > >>>>>>
> > >>>>>> OK, it seems I missed __bpf_rx_skb() vs __bpf_tx_skb(), but even=
 if I
> > >>>>>> move my sanity test in __bpf_tx_skb(),
> > >>>>>> the bpf test program still fails, I am suspecting the test needs=
 to be adjusted.
> > >>>>>>
> > >>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
> > >>>>>> index 745697c08acb3a74721d26ee93389efa81e973a0..e9c0e2087a08f1d8=
afd2c3e8e7871ddc9231b76d
> > >>>>>> 100644
> > >>>>>> --- a/net/core/filter.c
> > >>>>>> +++ b/net/core/filter.c
> > >>>>>> @@ -2128,6 +2128,12 @@ static inline int __bpf_tx_skb(struct
> > >>>>>> net_device *dev, struct sk_buff *skb)
> > >>>>>>                   return -ENETDOWN;
> > >>>>>>           }
> > >>>>>>
> > >>>>>> +       if (unlikely(skb->len < dev->min_header_len)) {
> > >>>>>> +               pr_err_once("__bpf_tx_skb skb->len=3D%u <
> > >>>>>> dev(%s)->min_header_len(%u)\n", skb->len, dev->name,
> > >>>>>> dev->min_header_len);
> > >>>>>> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> > >>>>>> +               kfree_skb(skb);
> > >>>>>> +               return -ERANGE;
> > >>>>>> +       } // Note: this is before we change skb->dev
> > >>>>>>           skb->dev =3D dev;
> > >>>>>>           skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb)=
);
> > >>>>>>           skb_clear_tstamp(skb);
> > >>>>>>
> > >>>>>>
> > >>>>>> -->
> > >>>>>>
> > >>>>>>
> > >>>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> > >>>>>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> > >>>>>> [redirect_egress]: actual -34 !=3D expected 1
> > >>>>>>
> > >>>>>> [   58.382051] __bpf_tx_skb skb->len=3D1 < dev(veth0)->min_heade=
r_len(14)
> > >>>>>> [   58.382778] skb len=3D1 headroom=3D78 headlen=3D1 tailroom=3D=
113
> > >>>>>>                  mac=3D(64,14) net=3D(78,-1) trans=3D-1
> > >>>>>>                  shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 ty=
pe=3D0 segs=3D0))
> > >>>>>>                  csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D=
0 level=3D0)
> > >>>>>>                  hash(0x0 sw=3D0 l4=3D0) proto=3D0x7f00 pkttype=
=3D0 iif=3D0
> > >>>>>
> > >>>>> Hmm. Something is off.
> > >>>>> That test creates 15 byte skb.
> > >>>>> It's not obvious to me how it got reduced to 1.
> > >>>>> Something stripped L2 header and the prog is trying to redirect
> > >>>>> such skb into veth that expects skb with L2 ?
> > >>>>>
> > >>>>> Stan,
> > >>>>> please take a look.
> > >>>>> Since you wrote that test.
> > >>>>
> > >>>> Sure. Daniel wants to take a look on a separate thread, so we can =
sync
> > >>>> up. Tentatively, seems like the failure is in the lwt path that do=
es
> > >>>> indeed drop the l2.
> > >>>
> > >>> If we'd change the test into the below, the tc and empty_skb tests =
pass.
> > >>> run_lwt_bpf() calls into skb_do_redirect() which has L2 stripped, a=
nd thus
> > >>> skb->len is 1 in this test. We do use skb_mac_header_len() also in =
other
> > >>> tc BPF helpers, so perhaps s/skb->len/skb_mac_header_len(skb)/ is t=
he best
> > >>> way forward..
> > >>>
> > >>> static int __bpf_redirect_common(struct sk_buff *skb, struct net_de=
vice *dev,
> > >>>                                    u32 flags)
> > >>> {
> > >>>           /* Verify that a link layer header is carried */
> > >>>           if (unlikely(skb->mac_header >=3D skb->network_header || =
skb->len =3D=3D 0)) {
> > >>>                   kfree_skb(skb);
> > >>>                   return -ERANGE;
> > >>>           }
> > >>>
> > >>>           if (unlikely(skb_mac_header_len(skb) < dev->min_header_le=
n)) {
> > >>
> > >> Unfortunately this will not prevent frames with skb->len =3D=3D 1 to=
 reach
> > >> an Ethernet driver ndo_start_xmit()
> > >>
> > >> At ndo_start_xmit(), we do not look where the MAC header supposedly
> > >> starts in the skb, we only use skb->data
> > >>
> > >> I have a syzbot repro using team driver, so I added the following pa=
rt in team :
> > >>
> > >> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> > >> index 0a44bbdcfb7b9f30a0c27b700246501c5eba322f..75e5ef585a8f05b35cfd=
dbae0bfc377864e6e38c
> > >> 100644
> > >> --- a/drivers/net/team/team.c
> > >> +++ b/drivers/net/team/team.c
> > >> @@ -1714,6 +1714,11 @@ static netdev_tx_t team_xmit(struct sk_buff
> > >> *skb, struct net_device *dev)
> > >>          bool tx_success;
> > >>          unsigned int len =3D skb->len;
> > >>
> > >> +       if (len < 14) {
> > >> +               pr_err_once("team_xmit(len=3D%u)\n", len);
> > >> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> > >> +               WARN_ON_ONCE(1);
> > >> +       }
> > >>          tx_success =3D team_queue_override_transmit(team, skb);
> > >>          if (!tx_success)
> > >>                  tx_success =3D team->ops.transmit(team, skb);
> > >>
> > >>
> > >> And I get (with your suggestion instead of skb->len)
> > >
> > > Missing part in my copy/paste :
> > >
> > > [   41.123829] team_xmit(len=3D1)
> > > [   41.124335] skb len=3D1 headroom=3D78 headlen=3D1 tailroom=3D113
> > >
> > >> mac=3D(78,0) net=3D(78,-1) trans=3D-1
> >
> > Interesting.
> >
> > Could you also dump dev->type and/or dev->min_header_len? I suspect
> > this case may not be ARPHRD_ETHER in team.
> >
> > Above says mac=3D(78,0), so mac len is 0 and the check against the
> > dev->min_header_len should have dropped it if it went that branch.
>
> mac header is reset in __dev_queue_xmit() :
>
>          skb_reset_mac_header(skb);
>
> So when the bpf code ran, skb_mac_header_len(skb) was 14,
> but later the MAC header was set (to skb->data)
>
> >
> > I wonder, is team driver missing sth like :
> >
> > diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> > index 0a44bbdcfb7b..6256f0d2f565 100644
> > --- a/drivers/net/team/team.c
> > +++ b/drivers/net/team/team.c
> > @@ -2124,6 +2124,7 @@ static void team_setup_by_port(struct net_device =
*dev,
> >          dev->type =3D port_dev->type;
> >          dev->hard_header_len =3D port_dev->hard_header_len;
> >          dev->needed_headroom =3D port_dev->needed_headroom;
> > +       dev->min_header_len =3D port_dev->min_header_len;
> >          dev->addr_len =3D port_dev->addr_len;
> >          dev->mtu =3D port_dev->mtu;
> >          memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len=
);
> >
>
>
> I have confirmed that team min_header_len is 14, nothing seems to be
> missing I think.
>
> team_xmit(dev team0, skb->len=3D1, dev->min_header_len=3D14)

FYI, I am releasing today a syzbot report with the same problem.

