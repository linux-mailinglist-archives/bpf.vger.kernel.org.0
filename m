Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEE61D1744
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbgEMOOh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbgEMOOh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 May 2020 10:14:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1659C061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 07:14:35 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i13so21528690oie.9
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXcJKBfucTESHqB8BAQasQtplZs967vv6AaM0P8pFrE=;
        b=Zky1IDdcOX0C8kIAPrGVhM4SWT0keCUTfrvRGzwSkt34mGV/NDUudhRG18+t1GIZHd
         EIaE+OByCgWnpXPSGXp0EBhOEdlR+rcND/ET+IYNat2r7d2jwyCVwd9brpky4IAmX28f
         1rX4DgV8alOTvbOZmKM/s+FqV/jiHtHKNneoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXcJKBfucTESHqB8BAQasQtplZs967vv6AaM0P8pFrE=;
        b=JabIn9XZaGjAjZZ96zu8goPH/i+xxD3Jm8oCUA2jJBvv/f1yMmbOymKPGo7d3Mj6Ca
         E14adP12QLC1gTe83bYr98DEbF4cb/60YpJCfNx2TdENM8CLlw/J42dmGxjTZ4xPKGX3
         YUVtwM4MhQfXxmayUGnWignb97pUw/kib3qMiYPv6HNdYghhDpsO8t0Z1XmkxZr2vmuy
         4V7m2ngKgKJdvOQrm4tpg8gqwRFwYuD8lZa9eN6XFlFY7tvqmTJDtZx9UZchBmC/hfg0
         vw10AY1B4xyT154B6r+6HThUFHMtzzkqBz9Xvh0PYV69afIPaSruwaEguQ1k/Mq5bKFT
         w3YA==
X-Gm-Message-State: AGi0PuZcRDgyHr2/fh8FEexLafAuLuZRHIpDqjnYCbZZBBlvqGEnQLHs
        b7F6QonEhuwQG8DEKPnOZle74atC//kfdrFQOAVS6A==
X-Google-Smtp-Source: APiQypIMxaFogBcUv6UkA12+6BGPtP924FFFodd4DRjWydo5v5/jKDSccC7G2IScq7RhsNS4IEepj4FFucsz6sOs65k=
X-Received: by 2002:aca:c441:: with SMTP id u62mr28330554oif.110.1589379274828;
 Wed, 13 May 2020 07:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
 <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
 <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
 <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net> <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com>
 <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net> <CACAyw99_GkLrxEj13R1ZJpnw_eWxhZas=72rtR8Pgt_Vq3dbeg@mail.gmail.com>
 <ff8e3902-9385-11ee-3cc5-44dd3355c9fc@iogearbox.net>
In-Reply-To: <ff8e3902-9385-11ee-3cc5-44dd3355c9fc@iogearbox.net>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 13 May 2020 15:14:23 +0100
Message-ID: <CACAyw9_LPEOvHbmP8UrpwVkwYT57rKWRisai=Z7kbKxOPh5XNQ@mail.gmail.com>
Subject: Re: Checksum behaviour of bpf_redirected packets
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 12 May 2020 at 22:25, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/11/20 11:29 AM, Lorenz Bauer wrote:
> > On Thu, 7 May 2020 at 17:43, Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 5/7/20 5:54 PM, Lorenz Bauer wrote:
> >>> On Wed, 6 May 2020 at 22:55, Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>>> On 5/6/20 6:24 PM, Lorenz Bauer wrote:
> >>>>> On Wed, 6 May 2020 at 02:28, Alexei Starovoitov
> >>>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>>> On Mon, May 4, 2020 at 9:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >>>>>>>
> >>>>>>> In our TC classifier cls_redirect [1], we use the following sequence
> >>>>>>> of helper calls to
> >>>>>>> decapsulate a GUE (basically IP + UDP + custom header) encapsulated packet:
> >>>>>>>
> >>>>>>>      skb_adjust_room(skb, -encap_len,
> >>>>>>> BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO)
> >>>>>>>      bpf_redirect(skb->ifindex, BPF_F_INGRESS)
> >>>>>>>
> >>>>>>> It seems like some checksums of the inner headers are not validated in
> >>>>>>> this case.
> >>>>>>> For example, a TCP SYN packet with invalid TCP checksum is still accepted by the
> >>>>>>> network stack and elicits a SYN ACK.
> >>>>>>>
> >>>>>>> Is this known but undocumented behaviour or a bug? In either case, is
> >>>>>>> there a work
> >>>>>>> around I'm not aware of?
> >>>>>>
> >>>>>> I thought inner and outer csums are covered by different flags and driver
> >>>>>> suppose to set the right one depending on level of in-hw checking it did.
> >>>>>
> >>>>> I've figured out what the problem is. We receive the following packet from
> >>>>> the driver:
> >>>>>
> >>>>>        | ETH | IP | UDP | GUE | IP | TCP |
> >>>>>        skb->ip_summed == CHECKSUM_UNNECESSARY
> >>>>>
> >>>>> ip_summed is CHECKSUM_UNNECESSARY because our NICs do rx
> >>>>> checksum offloading. On this packet we run skb_adjust_room_mac(-encap),
> >>>>> and get the following:
> >>>>>
> >>>>>        | ETH | IP | TCP |
> >>>>>        skb->ip_summed == CHECKSUM_UNNECESSARY
> >>>>>
> >>>>> Note that ip_summed is still CHECKSUM_UNNECESSARY. After
> >>>>> bpf_redirect()ing into the ingress, we end up in tcp_v4_rcv. There
> >>>>> skb_checksum_init is turned into a no-op due to
> >>>>> CHECKSUM_UNNECESSARY.
> >>>>>
> >>>>> I think this boils down to bpf_skb_generic_pop not adjusting ip_summed
> >>>>> accordingly. Unfortunately I don't understand how checksums work
> >>>>> sufficiently. Daniel, it seems like you wrote the helper, could you
> >>>>> take a look?
> >>>>
> >>>> Right, so in the skb_adjust_room() case we're not aware of protocol
> >>>> specifics. We do handle the csum complete case via skb_postpull_rcsum(),
> >>>> but not CHECKSUM_UNNECESSARY at the moment. I presume in your case the
> >>>> skb->csum_level of the original skb prior to skb_adjust_room() call
> >>>> might have been 0 (that is, covering UDP)? So if we'd add the possibility
> >>>> to __skb_decr_checksum_unnecessary() via flag, then it would become
> >>>> skb->ip_summed = CHECKSUM_NONE? And to be generic, we'd need to do the
> >>>> same for the reverse case. Below is a quick hack (compile tested-only);
> >>>> would this resolve your case ...
> >>>
> >>> Thanks for the patch, it indeed fixes our problem! I spent some more time
> >>> trying to understand the checksum offload stuff, here is where I am:
> >>>
> >>> On NICs that don't support hardware offload ip_summed is CHECKSUM_NONE,
> >>> everything works by default since the rest of the stack does checksumming in
> >>> software.
> >>>
> >>> On NICs that support CHECKSUM_COMPLETE, skb_postpull_rcsum
> >>> will adjust for the data that is being removed from the skb. The rest of the
> >>> stack will use the correct value, all is well.
> >>>
> >>> However, we're out of luck on NICs that do CHECKSUM_UNNECESSARY:
> >>> the API of skb_adjust_room doesn't tell us whether the user intends to
> >>> remove headers or data, and how that will influence csum_level.
> >>>   From my POV, skb_adjust_room currently does the wrong thing.
> >>> I think we need to fix skb_adjust_room to do the right thing by default,
> >>> rather than extending the API. We spent a lot of time on tracking this down,
> >>> so hopefully we can spare others the pain.
> >>>
> >>> As Jakub alludes to, we don't know when and how often to call
> >>> __skb_decr_checksum_unnecessary so we should just
> >>> unconditionally downgrade a packet to CHECKSUM_NONE if we encounter
> >>> CHECKSUM_UNNECESSARY in bpf_skb_generic_pop. It sounds simple
> >>> enough to land as a fix via the bpf tree (which is important for our
> >>> production kernel). As a follow up we could add the inverse of the flags you
> >>> propose via bpf-next.
> >>>
> >>> What do you think?
> >>
> >> My concern with unconditionally downgrading a packet to CHECKSUM_NONE would
> >> basically trash performance if we have to fallback to sw in fast-path, these
> >> helpers are also used in our LB case for DSR, for example.
> >
> > Our setup also uses DSR, so I wonder how you manage to avoid this
> > checksum issue.
> > Why is Cilium not affected by this bug as well? You never pop headers?
>
> We have different modes in our LB on how to apply DSR: pure DSR and hybrid. In
> pure DSR, DSR is used for TCP and UDP, and in hybrid we use DSR for TCP and SNAT
> for UDP (under the assumption that the main workload is on TCP anyway). For the
> proto under DSR we basically use ctx_adjust_room(ctx, 8, BPF_ADJ_ROOM_NET, 0)
> for IPv4 and similar ctx_adjust_room() for IPv6 (just of different size). Meaning
> we push/pop an IP option for these cases w/ svc IP/port (for TCP under DSR only
> in the SYN, but not subsequent packets). Now in the example of CHECKSUM_UNNECESSARY
> ("skb->csum_level indicates the number of consecutive checksums found in the packet
> minus one that have been verified as CHECKSUM_UNNECESSARY. For instance if a device
> receives an IPv6->UDP->GRE->IPv4->TCP packet and a device is able to verify the
> checksums for UDP (possibly zero), GRE (checksum flag is set) and TCP, skb->csum_level
> would be set to two") the IP hdr does not account for it, which might also explain
> why we haven't seen it on our side so far.

I can see two explanations for this: first IP receive processing
ignores RX checksum offload from
what I can tell, it always calls ip_fast_csum (from ip_rcv_core).
Since the TCP pseudo header
doesn't include options things work.

Second, I think you never modify the packet in the RX path if you let
it continue up the stack.
Looking at tail_nodeport_ipv4_dsr, I think that even unconditionally dropping to
CHECKSUM_NONE will not make a difference to you: you add the header,
do a fib_lookup
and then redirect into the device egress. Checksum offloading can't
even kick in at this point.
Maybe option 1 is feasible after all?

>
> > FWIW, currently the only work around I know is to disable rx
> > checksumming for ALL
> > inbound traffic via ethtool -K bla rx off. Which in theory trashes
> > performance for all
> > RX traffic, not just the one going to the load balancer. I applied this in a
> > couple of production data centers, and did not see an increase in
> > softirq, which is
> > where I assume this would show up. My guess is that this is because our
> > RX << TX. Unconditionally setting CHECKSUM_NONE would be even less visible,
> > since we could turn rx checksumming back on in the general case.
> > Is there a way for you to quantify what the impact for Cilium would be?
> >
> >> I agree that it
> >> sucks to expose these implementation details though. So eventually we'd end
> >> up with 3 csum flags: inc/dec/reset to none. bpf_skb_adjust_room() is already
> >> a complex to use helper with all its flags where you end up looking into the
> >> implementation detail to understand what it is really doing. I'm not sure if
> >> we make anything worse, but I do see your concern. :/
> >
> > Having those flags seems fine to me, you're right that it's already complicated.
> > My concern is really with the current state of the helper however: I think that
> > as it exists right now it's buggy wrt checksum offload, and we need a
> > backportable fix.
> >
> > Option 1: always downgrade UNNECESSARY to NONE
> > - Easiest to back port
> > - The helper is safe by default
> > - Performance impact unclear
> > - No escape hatch for Cilium
> >
> > Option 2: add a flag to force CHECKSUM_NONE
> > - New UAPI, can this be backported?
> > - The helper isn't safe by default, needs documentation
> > - Escape hatch for Cilium
> >
> > Option 3: downgrade to CHECKSUM_NONE, add flag to skip this
> > - New UAPI, can this be backported?
> > - The helper is safe by default
> > - Escape hatch for Cilium (though you'd need to detect availability of the
> >    flag somehow)
>
> This seems most reasonable to me; I can try and cook a proposal for tomorrow as
> potential fix. Even if we add a flag, this is still backportable to stable (as
> long as the overall patch doesn't get too complex and the backport itself stays
> compatible uapi-wise to latest kernels. We've done that before.). I happen to
> have two ixgbe NICs on some of my test machines which seem to be setting the
> CHECKSUM_UNNECESSARY, so I'll run some experiments from over here as well.

Great! I'm happy to test, of course.

>
> > I guess there is also Option 0, add a flag but don't backport, which to
> > me is admitting defeat. If we were to do that we'd at least
> > want to document the problem. Thinking about how to do that already
> > makes my head spin:
> >
> > - If you have a NIC that does CHECKSUM_UNNECESSARY
> > - And you pop network headers
> > - You will run into this bug
> > - To fix it you have to disable rx checksum offload
> >
> > How do users figure out whether a NIC does UNNECESSARY vs. COMPLETE
> > vs. NONE? I have the luxury of only caring about two different drivers, but
> > what if I ship BPF (like Cilium does)? Ultimately vendors would either have
> > buggy programs, or would tell people to unconditionally disable rx
> > checksumming I believe.
> >
> >  From my POV, I'd prefer option 1 or 3, since I strongly believe that the
> > helper should be safe by default, and that the user can assert invariants
> > via flags to get better performance.I could live with option 2 as well since
> > I just have to care about a single kernel version.
> >
> >> (We do have bpf_csum_update()
> >> helper as well. I wonder whether we should split such control into a different
> >> helper.)
> >
> > I'm not sure what you mean, maybe you can elaborate a little?
>
> Meaning, a different helper to control these settings, e.g. bpf_csum_adjust(skb,
> {inc/dec/..}) which would then fall into option 2 category though.

Ah, okay. I think option 3 and this aren't mutually exclusive.
Backport an opt out
flag and add a new helper to bpf-next. Maybe we can even come up with something
that hides the checksum mess.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
