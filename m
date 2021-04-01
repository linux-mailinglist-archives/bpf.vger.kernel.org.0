Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547FA351B82
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 20:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbhDASIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 14:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235957AbhDASCD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 14:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617300120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xtPfAAAJy1W1ZuMTZmz02S6W4QAF358aNIU9a2+4cc=;
        b=AiW9urNhUmtG3TbQ+e2z4XzC9bYx5x7Yroq22D95TLq5wkbKMLatyRzuWrFXeNRVoQacq3
        QqIffU3Vtwl+/HKtmB+LUs2S92kVCIefdvf7jddlKhnTzwryCgX3SwDlurrsHVF3wKlsgq
        U8CxMR5ITKx6mTxPf2N2kRTmDwavONQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-Dq_mjEEiM4mH89XAcs1z3g-1; Thu, 01 Apr 2021 14:01:59 -0400
X-MC-Unique: Dq_mjEEiM4mH89XAcs1z3g-1
Received: by mail-lf1-f72.google.com with SMTP id i31so2330060lfv.5
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 11:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5xtPfAAAJy1W1ZuMTZmz02S6W4QAF358aNIU9a2+4cc=;
        b=e0vk/ef01iyFrSWJmXTjE9t/d6iyUNaaAwn8kwjyEiyY2t3VKJsu5N8BbFjOEClrmM
         /5hZO226n+6b/eApWSVWaQ0mNnqt3nkVjE2GI0GktWFy5vihaPwcNTqBRICPVW9xZtcD
         IRI9JFuvoBPtGam5aHsxtg97XHC9dJtMkbXe5d19lyR41R+d7xU3eYs1re6m3A96pL+r
         EssQF4c4wTShIMtzByWF20IcgrIOcF/JWzfLFzTRTPoVWG/uVIrhLhFhSRHTfOdbCdOH
         j3jUQYSBtgqgVM9EupW/3LigdcP7m1U9s6ltWhJWbJIfmz2/5hYzjb5NVmQq+U4SjeYw
         mJew==
X-Gm-Message-State: AOAM531nK5mhfE/uLe+B9N0CL/bISag2vJ2uR6bQfag/guF7h4gsKoew
        kP7KjFkmt8bG9296a0rGKcnwA65EafHcWSCfyCQLfjv+MDiJHdUNOGGvNPKSWorpZXi5hO/BKKD
        gdfTLT3KHuRIC
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr6409811ljh.353.1617300116102;
        Thu, 01 Apr 2021 11:01:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEvNTqUpB96qRJzsRY4K42cea0+6Zh3lsJjmF0YzdZ5l+1SixMJ9O2GMrgivwIu3CE6Im4PA==
X-Received: by 2002:a50:d753:: with SMTP id i19mr11221832edj.43.1617300103790;
        Thu, 01 Apr 2021 11:01:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bx24sm3138774ejc.88.2021.04.01.11.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 11:01:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B83CE180290; Thu,  1 Apr 2021 20:01:42 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 9/9] net: enetc: add support for XDP_REDIRECT
In-Reply-To: <20210401160943.frw7l3rio7spr33n@skbuf>
References: <20210331200857.3274425-1-olteanv@gmail.com>
 <20210331200857.3274425-10-olteanv@gmail.com> <87blaynt4l.fsf@toke.dk>
 <20210401113133.vzs3uxkp52k2ctla@skbuf> <875z16nsiu.fsf@toke.dk>
 <20210401160943.frw7l3rio7spr33n@skbuf>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 01 Apr 2021 20:01:42 +0200
Message-ID: <87lfa1nat5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Vladimir Oltean <olteanv@gmail.com> writes:

> On Thu, Apr 01, 2021 at 01:39:05PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Vladimir Oltean <olteanv@gmail.com> writes:
>>
>> > On Thu, Apr 01, 2021 at 01:26:02PM +0200, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> > +int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>> >> > +		   struct xdp_frame **frames, u32 flags)
>> >> > +{
>> >> > +	struct enetc_tx_swbd xdp_redirect_arr[ENETC_MAX_SKB_FRAGS] =3D {0=
};
>> >> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
>> >> > +	struct enetc_bdr *tx_ring;
>> >> > +	int xdp_tx_bd_cnt, i, k;
>> >> > +	int xdp_tx_frm_cnt =3D 0;
>> >> > +
>> >> > +	tx_ring =3D priv->tx_ring[smp_processor_id()];
>> >>
>> >> What mechanism guarantees that this won't overflow the array? :)
>> >
>> > Which array, the array of TX rings?
>>
>> Yes.
>>
>
> The problem isn't even accessing an out-of-bounds element in the TX ring =
array.
>
> As it turns out, I had a relatively superficial understanding of how
> things are organized, but let me try to explain.
>
> The number of TX rings is a configurable resource (between PFs and VFs)
> and we read the capability at probe time:
>
> enetc_get_si_caps:
> 	val =3D enetc_rd(hw, ENETC_SICAPR0);
> 	si->num_rx_rings =3D (val >> 16) & 0xff;
> 	si->num_tx_rings =3D val & 0xff;
>
> enetc_init_si_rings_params:
> 	priv->num_tx_rings =3D si->num_tx_rings;
>
> In any case, the TX array is declared as:
>
> struct enetc_ndev_priv {
> 	struct enetc_bdr *tx_ring[16];
> 	struct enetc_bdr *rx_ring[16];
> };
>
> because that's the maximum hardware capability.
>
> The priv->tx_ring array is populated in:
>
> enetc_alloc_msix:
> 	/* # of tx rings per int vector */
> 	v_tx_rings =3D priv->num_tx_rings / priv->bdr_int_num;
>
> 	for (i =3D 0; i < priv->bdr_int_num; i++) {
> 		for (j =3D 0; j < v_tx_rings; j++) {
> 			if (priv->bdr_int_num =3D=3D ENETC_MAX_BDR_INT)
> 				idx =3D 2 * j + i; /* 2 CPUs */
> 			else
> 				idx =3D j + i * v_tx_rings; /* default */
>
> 			priv->tx_ring[idx] =3D bdr;
> 		}
> 	}
>
> priv->bdr_int_num is set to "num_online_cpus()".
> On LS1028A, it can be either 1 or 2 (and the ENETC_MAX_BDR_INT macro is
> equal to 2).
>
> Otherwise said, the convoluted logic above does the following:
> - It affines an MSI interrupt vector per CPU
> - It affines an RX ring per MSI vector, hence per CPU
> - It balances the fixed number of TX rings (say 8) among the available
>   MSI vectors, hence CPUs (say 2). It does this by iterating with i
>   through the RX MSI interrupt vectors, and with j through the number of
>   TX rings per MSI vector.
>
> This logic maps:
> - the even TX rings to CPU 0 and the odd TX rings to CPU 1, if 2 CPUs
>   are used
> - all TX rings to CPU 0, if 1 CPU is used
>
> This is done because we have this logic in enetc_poll:
>
> 	for (i =3D 0; i < v->count_tx_rings; i++)
> 		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
> 			complete =3D false;
>
> for processing the TX completions of a given group of TX rings in the RX
> MSI interrupt handler of a certain CPU.
>
> Otherwise said, priv->tx_ring[i] is always BD ring i, and that mapping
> never changes. All 8 TX rings are enabled and available for use.
>
> What I knew about tc-taprio and tc-mqprio is that they only enqueue to
> TX queues [0, num_tc-1] because of this, as it turns out:
>
> enetc_xmit:
> 	tx_ring =3D priv->tx_ring[skb->queue_mapping];
>
> where skb->queue_mapping is given by:
> 	err =3D netif_set_real_num_tx_queues(ndev, priv->num_tx_rings);
> and by this, respectively, from the mqprio code path:
> 	netif_set_real_num_tx_queues(ndev, num_tc);
>
> As for why XDP works, and priv->tx_ring[smp_processor_id()] is:
> - TX ring 0 for CPU 0 and TX ring 1 for CPU 1, if 2 CPUs are used
> - TX ring 0, if 1 CPU is used
>
> The TX completions in the first case are handled by:
> - CPU 0 for TX ring 0 (because it is even) and CPU 1 for TX ring 1
>   (because it is odd), if 2 CPUs are used, due to the mapping I talked
>   about earlier
> - CPU 0 if only 1 CPU is used

Right - thank you for the details! So what are the constraints on the
configuration. Specifically, given two netdevs on the same device, is it
possible that the system can ever end up in a situation where one device
has two *RXQs* configured, and the other only one *TXQ*. Because then
you could get a redirect from RXQ 1 on one device, which would also end
up trying to transmit on TXQ 1 on the other device; and that would break
if that other device only has TXQ 0 configured... Same thing if a single
device has 2 RXQs but only one TXQ (it can redirect to itself).

>> > You mean that it's possible to receive a TC_SETUP_QDISC_MQPRIO or
>> > TC_SETUP_QDISC_TAPRIO with num_tc =3D=3D 1, and we have 2 CPUs?
>>
>> Not just that, this ndo can be called on arbitrary CPUs after a
>> redirect. The code just calls through from the XDP receive path so which
>> CPU it ends up on depends on the RSS+IRQ config of the other device,
>> which may not even be the same driver; i.e., you have no control over
>> that... :)
>>
>
> What do you mean by "arbitrary" CPU? You can't plug CPUs in, it's a dual
> core system... Why does the source ifindex matter at all? I'm using the
> TX ring affined to the CPU that ndo_xdp_xmit is currently running on.

See, this is why I asked 'what mechanism ensures'. Because if that
mechanism is 'this driver is only ever used on a system with fewer CPUs
than TXQs', then that's of course fine :)

But there are drivers that do basically the same thing as what you've
done here, *without* having such an assurance, and just looking at that
function it's not obvious that there's an out-of-band reason why it's
safe. And I literally just came from looking at such a case when I
replied to your initial patch...

>> > Well, yeah, I don't know what's the proper way to deal with that. Idea=
s?
>>
>> Well the obvious one is just:
>>
>> tx_ring =3D priv->tx_ring[smp_processor_id() % num_ring_ids];
>>
>> and then some kind of locking to deal with multiple CPUs accessing the
>> same TX ring...
>
> By multiple CPUs accessing the same TX ring, you mean locking between
> ndo_xdp_xmit and ndo_start_xmit? Can that even happen if the hardware
> architecture is to have at least as many TX rings as CPUs?
>
> Because otherwise, I see that ndo_xdp_xmit is only called from
> xdp_do_flush, which is in softirq context, which to my very rudimentary
> knowledge run with bottom halves, thus preemption, disabled? So I don't
> think it's possible for ndo_xdp_xmit and ndo_xmit, or even two
> ndo_xdp_xmit instances, to access the same TX ring?

Yup, I think you're right about that. The "we always have more TXQs than
CPUs" condition was the bit I was missing (and of course you're *sure*
that this would never change sometime in the future, right? ;)).

> Sorry, I'm sure these are trivial questions, but I would like to really
> understand what I need to change and why :D

Given the above I think the only potentially breaking thing is the
#RXQ > #TXQ case I outlined. And maybe a comment documenting why indexing
the tx_ring array by smp_processor_id() is safe would be nice? :)

-Toke

