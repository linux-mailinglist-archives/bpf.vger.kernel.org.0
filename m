Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D461C9586
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEGPyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgEGPyQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 11:54:16 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E7EC05BD43
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 08:54:16 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a2so5385006oia.11
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOUu0D7336P36H05oPpjM3f6a/82CvC4g/rll5ZECZc=;
        b=ken/L1wWaXEw+zmZ1w/5G11cO4XN2DoysuJKXIrsQ6O3ZxbQD4y8TaiuY7mLGj52UN
         /bL2CeoDBAcWVEHJkuiT3Tld5wAv5rM6mgMEkbYMsl4GAoyIFyW7U6p1bCmb6kegS0wk
         oITTOQSCWY/k6Q0pTg9DX60/0+SvmtG/hYDjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOUu0D7336P36H05oPpjM3f6a/82CvC4g/rll5ZECZc=;
        b=Ait1UjmcfYXt8ogZORoOlw2qLahUFLnUpIUn0JnBDNEqiWoR0r3jJPchTXbSBV+Maw
         qvsaS9YIGSrwY+jhrAnxMUs/lcQURgnTlJZSYaxLUqHEwBEP1Et697XQpnxH37Q8c18+
         qiU1ofSTOZ8QYMoB/vY/EgRfa9eLsVxEF60C1g6yzdWT0y6zrHaMynIIMAJjzMstPE4U
         oEIlddTCP96KxAauK4rqfpotgD+wJdiMinEwUbZaBL9ZwA2WTXXEB95YqvPj8aiO972Q
         M3MbfzutZL9X8anihK9pmeW1jh/6/JseJK6gYW29EFiU/QUrPj0xucuL8ILADG7af9HS
         gWSw==
X-Gm-Message-State: AGi0PuazLLuiQfYMHlFnZYz6/lavRt+6u34nb5h/YP6ksxntC4cfiGOF
        JrkLE31XC0O1BhdVL3VSy1MXeTe3Om6AGZyqPt+nmw==
X-Google-Smtp-Source: APiQypKR5V23HZuxsnKC93pS8odKjA2VB8dAn/JztHydJtop76t/HghRcCGZs0Ki1N7GhYsX+ucHIyhQIJD2rDH7Ptc=
X-Received: by 2002:a05:6808:a91:: with SMTP id q17mr6739486oij.102.1588866855521;
 Thu, 07 May 2020 08:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
 <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
 <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com> <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net>
In-Reply-To: <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 7 May 2020 16:54:04 +0100
Message-ID: <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com>
Subject: Re: Checksum behaviour of bpf_redirected packets
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 6 May 2020 at 22:55, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/6/20 6:24 PM, Lorenz Bauer wrote:
> > On Wed, 6 May 2020 at 02:28, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Mon, May 4, 2020 at 9:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >>>
> >>> In our TC classifier cls_redirect [1], we use the following sequence
> >>> of helper calls to
> >>> decapsulate a GUE (basically IP + UDP + custom header) encapsulated packet:
> >>>
> >>>    skb_adjust_room(skb, -encap_len,
> >>> BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO)
> >>>    bpf_redirect(skb->ifindex, BPF_F_INGRESS)
> >>>
> >>> It seems like some checksums of the inner headers are not validated in
> >>> this case.
> >>> For example, a TCP SYN packet with invalid TCP checksum is still accepted by the
> >>> network stack and elicits a SYN ACK.
> >>>
> >>> Is this known but undocumented behaviour or a bug? In either case, is
> >>> there a work
> >>> around I'm not aware of?
> >>
> >> I thought inner and outer csums are covered by different flags and driver
> >> suppose to set the right one depending on level of in-hw checking it did.
> >
> > I've figured out what the problem is. We receive the following packet from
> > the driver:
> >
> >      | ETH | IP | UDP | GUE | IP | TCP |
> >      skb->ip_summed == CHECKSUM_UNNECESSARY
> >
> > ip_summed is CHECKSUM_UNNECESSARY because our NICs do rx
> > checksum offloading. On this packet we run skb_adjust_room_mac(-encap),
> > and get the following:
> >
> >      | ETH | IP | TCP |
> >      skb->ip_summed == CHECKSUM_UNNECESSARY
> >
> > Note that ip_summed is still CHECKSUM_UNNECESSARY. After
> > bpf_redirect()ing into the ingress, we end up in tcp_v4_rcv. There
> > skb_checksum_init is turned into a no-op due to
> > CHECKSUM_UNNECESSARY.
> >
> > I think this boils down to bpf_skb_generic_pop not adjusting ip_summed
> > accordingly. Unfortunately I don't understand how checksums work
> > sufficiently. Daniel, it seems like you wrote the helper, could you
> > take a look?
>
> Right, so in the skb_adjust_room() case we're not aware of protocol
> specifics. We do handle the csum complete case via skb_postpull_rcsum(),
> but not CHECKSUM_UNNECESSARY at the moment. I presume in your case the
> skb->csum_level of the original skb prior to skb_adjust_room() call
> might have been 0 (that is, covering UDP)? So if we'd add the possibility
> to __skb_decr_checksum_unnecessary() via flag, then it would become
> skb->ip_summed = CHECKSUM_NONE? And to be generic, we'd need to do the
> same for the reverse case. Below is a quick hack (compile tested-only);
> would this resolve your case ...

Thanks for the patch, it indeed fixes our problem! I spent some more time
trying to understand the checksum offload stuff, here is where I am:

On NICs that don't support hardware offload ip_summed is CHECKSUM_NONE,
everything works by default since the rest of the stack does checksumming in
software.

On NICs that support CHECKSUM_COMPLETE, skb_postpull_rcsum
will adjust for the data that is being removed from the skb. The rest of the
stack will use the correct value, all is well.

However, we're out of luck on NICs that do CHECKSUM_UNNECESSARY:
the API of skb_adjust_room doesn't tell us whether the user intends to
remove headers or data, and how that will influence csum_level.
From my POV, skb_adjust_room currently does the wrong thing.
I think we need to fix skb_adjust_room to do the right thing by default,
rather than extending the API. We spent a lot of time on tracking this down,
so hopefully we can spare others the pain.

As Jakub alludes to, we don't know when and how often to call
__skb_decr_checksum_unnecessary so we should just
unconditionally downgrade a packet to CHECKSUM_NONE if we encounter
CHECKSUM_UNNECESSARY in bpf_skb_generic_pop. It sounds simple
enough to land as a fix via the bpf tree (which is important for our
production kernel). As a follow up we could add the inverse of the flags you
propose via bpf-next.

What do you think?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
