Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC41E1CD4E6
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 11:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgEKJ3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 05:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKJ3j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 05:29:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A1BC061A0C
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 02:29:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m18so6964675otq.9
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRBSoRQ4M6cwSQ+ObIZWkajufOTOp+t/e1nMXtsYcos=;
        b=IKNdddfcY8Q3IXT0FNwvJlYi12ASu0KpHP7O7K1FrQEk5/5evxoDk/Hkn3hp8ZDqVZ
         8tnlrAK0ZIeYQOE1qZSJgHX8nsUbDQLAA8EtWGkw9WQWkD6SrF6DiZ3pPTTVsl9xTeg6
         X3WPeQWADX7H94pRqN98OVhI1fs9soRNs8A5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRBSoRQ4M6cwSQ+ObIZWkajufOTOp+t/e1nMXtsYcos=;
        b=To1CclFUkl6YwXmQ86YdpRV+S9kOqnF8Uu9x9RPWuTURk/HMfHT9GlDCOIDLovrI4V
         tFdxTUK7oMRA8VTIhoTZ4/mctTIu5BCT+9Vdor51M1ZYz5YljDZZmrMW6NCFCMLkAcl9
         KeTuyGBbeZmie4/ovBnwRk3zDpyV+1kwCO5Z/28qYbC+EXZTMi6W6t0RrRiADfs3B1P9
         Xbbbti5Nb4LDu4wKuQPvWi2gRk8Wq/6rEbhbhOYtZwoUwdl1LYVjtSr796jm36jywWRc
         AO0fn1LZeQUZzIyqVNkd1B/QiXgHKdLY6SwlApcI1pBUryn3vZQeqf4QrVaELzY/Xh1B
         s6nQ==
X-Gm-Message-State: AGi0PuYbc7TeJ4A0uccpmqTf4l/yIQCS+0Mc5MIFNDZzJ3Ma6Sh2mFw9
        R0uDCsfDkERi6rKYm7fu4jM49x+qtI/1lCM/rLK1MQ==
X-Google-Smtp-Source: APiQypK26QnIqiFUVTwCwKDBKF20S30tkFWcio23cHYajMF2wUu09T7RE6+ehFxqgHG6Mqir8HHEN0GtngsolBV4X80=
X-Received: by 2002:a9d:629a:: with SMTP id x26mr10860804otk.147.1589189378209;
 Mon, 11 May 2020 02:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
 <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
 <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
 <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net> <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com>
 <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net>
In-Reply-To: <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 11 May 2020 10:29:26 +0100
Message-ID: <CACAyw99_GkLrxEj13R1ZJpnw_eWxhZas=72rtR8Pgt_Vq3dbeg@mail.gmail.com>
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

On Thu, 7 May 2020 at 17:43, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/7/20 5:54 PM, Lorenz Bauer wrote:
> > On Wed, 6 May 2020 at 22:55, Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 5/6/20 6:24 PM, Lorenz Bauer wrote:
> >>> On Wed, 6 May 2020 at 02:28, Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>> On Mon, May 4, 2020 at 9:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >>>>>
> >>>>> In our TC classifier cls_redirect [1], we use the following sequence
> >>>>> of helper calls to
> >>>>> decapsulate a GUE (basically IP + UDP + custom header) encapsulated packet:
> >>>>>
> >>>>>     skb_adjust_room(skb, -encap_len,
> >>>>> BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO)
> >>>>>     bpf_redirect(skb->ifindex, BPF_F_INGRESS)
> >>>>>
> >>>>> It seems like some checksums of the inner headers are not validated in
> >>>>> this case.
> >>>>> For example, a TCP SYN packet with invalid TCP checksum is still accepted by the
> >>>>> network stack and elicits a SYN ACK.
> >>>>>
> >>>>> Is this known but undocumented behaviour or a bug? In either case, is
> >>>>> there a work
> >>>>> around I'm not aware of?
> >>>>
> >>>> I thought inner and outer csums are covered by different flags and driver
> >>>> suppose to set the right one depending on level of in-hw checking it did.
> >>>
> >>> I've figured out what the problem is. We receive the following packet from
> >>> the driver:
> >>>
> >>>       | ETH | IP | UDP | GUE | IP | TCP |
> >>>       skb->ip_summed == CHECKSUM_UNNECESSARY
> >>>
> >>> ip_summed is CHECKSUM_UNNECESSARY because our NICs do rx
> >>> checksum offloading. On this packet we run skb_adjust_room_mac(-encap),
> >>> and get the following:
> >>>
> >>>       | ETH | IP | TCP |
> >>>       skb->ip_summed == CHECKSUM_UNNECESSARY
> >>>
> >>> Note that ip_summed is still CHECKSUM_UNNECESSARY. After
> >>> bpf_redirect()ing into the ingress, we end up in tcp_v4_rcv. There
> >>> skb_checksum_init is turned into a no-op due to
> >>> CHECKSUM_UNNECESSARY.
> >>>
> >>> I think this boils down to bpf_skb_generic_pop not adjusting ip_summed
> >>> accordingly. Unfortunately I don't understand how checksums work
> >>> sufficiently. Daniel, it seems like you wrote the helper, could you
> >>> take a look?
> >>
> >> Right, so in the skb_adjust_room() case we're not aware of protocol
> >> specifics. We do handle the csum complete case via skb_postpull_rcsum(),
> >> but not CHECKSUM_UNNECESSARY at the moment. I presume in your case the
> >> skb->csum_level of the original skb prior to skb_adjust_room() call
> >> might have been 0 (that is, covering UDP)? So if we'd add the possibility
> >> to __skb_decr_checksum_unnecessary() via flag, then it would become
> >> skb->ip_summed = CHECKSUM_NONE? And to be generic, we'd need to do the
> >> same for the reverse case. Below is a quick hack (compile tested-only);
> >> would this resolve your case ...
> >
> > Thanks for the patch, it indeed fixes our problem! I spent some more time
> > trying to understand the checksum offload stuff, here is where I am:
> >
> > On NICs that don't support hardware offload ip_summed is CHECKSUM_NONE,
> > everything works by default since the rest of the stack does checksumming in
> > software.
> >
> > On NICs that support CHECKSUM_COMPLETE, skb_postpull_rcsum
> > will adjust for the data that is being removed from the skb. The rest of the
> > stack will use the correct value, all is well.
> >
> > However, we're out of luck on NICs that do CHECKSUM_UNNECESSARY:
> > the API of skb_adjust_room doesn't tell us whether the user intends to
> > remove headers or data, and how that will influence csum_level.
> >  From my POV, skb_adjust_room currently does the wrong thing.
> > I think we need to fix skb_adjust_room to do the right thing by default,
> > rather than extending the API. We spent a lot of time on tracking this down,
> > so hopefully we can spare others the pain.
> >
> > As Jakub alludes to, we don't know when and how often to call
> > __skb_decr_checksum_unnecessary so we should just
> > unconditionally downgrade a packet to CHECKSUM_NONE if we encounter
> > CHECKSUM_UNNECESSARY in bpf_skb_generic_pop. It sounds simple
> > enough to land as a fix via the bpf tree (which is important for our
> > production kernel). As a follow up we could add the inverse of the flags you
> > propose via bpf-next.
> >
> > What do you think?
>
> My concern with unconditionally downgrading a packet to CHECKSUM_NONE would
> basically trash performance if we have to fallback to sw in fast-path, these
> helpers are also used in our LB case for DSR, for example.

Our setup also uses DSR, so I wonder how you manage to avoid this
checksum issue.
Why is Cilium not affected by this bug as well? You never pop headers?

FWIW, currently the only work around I know is to disable rx
checksumming for ALL
inbound traffic via ethtool -K bla rx off. Which in theory trashes
performance for all
RX traffic, not just the one going to the load balancer. I applied this in a
couple of production data centers, and did not see an increase in
softirq, which is
where I assume this would show up. My guess is that this is because our
RX << TX. Unconditionally setting CHECKSUM_NONE would be even less visible,
since we could turn rx checksumming back on in the general case.
Is there a way for you to quantify what the impact for Cilium would be?

> I agree that it
> sucks to expose these implementation details though. So eventually we'd end
> up with 3 csum flags: inc/dec/reset to none. bpf_skb_adjust_room() is already
> a complex to use helper with all its flags where you end up looking into the
> implementation detail to understand what it is really doing. I'm not sure if
> we make anything worse, but I do see your concern. :/

Having those flags seems fine to me, you're right that it's already complicated.
My concern is really with the current state of the helper however: I think that
as it exists right now it's buggy wrt checksum offload, and we need a
backportable fix.

Option 1: always downgrade UNNECESSARY to NONE
- Easiest to back port
- The helper is safe by default
- Performance impact unclear
- No escape hatch for Cilium

Option 2: add a flag to force CHECKSUM_NONE
- New UAPI, can this be backported?
- The helper isn't safe by default, needs documentation
- Escape hatch for Cilium

Option 3: downgrade to CHECKSUM_NONE, add flag to skip this
- New UAPI, can this be backported?
- The helper is safe by default
- Escape hatch for Cilium (though you'd need to detect availability of the
  flag somehow)

I guess there is also Option 0, add a flag but don't backport, which to
me is admitting defeat. If we were to do that we'd at least
want to document the problem. Thinking about how to do that already
makes my head spin:

- If you have a NIC that does CHECKSUM_UNNECESSARY
- And you pop network headers
- You will run into this bug
- To fix it you have to disable rx checksum offload

How do users figure out whether a NIC does UNNECESSARY vs. COMPLETE
vs. NONE? I have the luxury of only caring about two different drivers, but
what if I ship BPF (like Cilium does)? Ultimately vendors would either have
buggy programs, or would tell people to unconditionally disable rx
checksumming I believe.

From my POV, I'd prefer option 1 or 3, since I strongly believe that the
helper should be safe by default, and that the user can assert invariants
via flags to get better performance.I could live with option 2 as well since
I just have to care about a single kernel version.

> (We do have bpf_csum_update()
> helper as well. I wonder whether we should split such control into a different
> helper.)

I'm not sure what you mean, maybe you can elaborate a little?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
