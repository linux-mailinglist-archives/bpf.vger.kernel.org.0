Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB81C7631
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 18:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEFQY5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 12:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729341AbgEFQY5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 12:24:57 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5E3C061A0F
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 09:24:56 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id t12so621176oot.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PP9L83s6CfD0+en6vgV3WIo4aL6f+bLAH17qAcnYdw=;
        b=g9ZOH7vNz3pq7qaff5jL+FbNrPfjqqMdS9SdtQYowaJ2jKphzdTtaR5qDMaMbpQlZW
         6FlIg0HteMijfIxq0RP4GGzz8OTTblvvC9EEMwp5fWLjV9SbuxGfR6HtDCUFFIVnskov
         ckb3qD7ASJgr/MOz4FkGVP6DGNWuehvTTUT8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PP9L83s6CfD0+en6vgV3WIo4aL6f+bLAH17qAcnYdw=;
        b=EN7RR1MRYiagZUlM3hupYJ+1Qosb7x9PCLDCYRVgJt4JMZnb21nsFIo9sYRuJzYuJp
         37OlKSYa3+vmuoQksVdgCqtp83yb8tgk2ItQmMovrwqkST52EJSM+32K9sXQLaZzv7SM
         K0tJTJPIwGZEfaW08BS3ERSKDIi4S7b61QRml7PeL5Okt/hdJJX0+f+ZOgk3c3BALu3B
         l8/kiABGvvEPr+Uga8K0rXl75w9jNCvhlUlzt0lbV0jOnAZCOPtDLT7JlN0M8+Nqc7kx
         /iB2iKjuzDO+AHK80hHuFeuv9Lz14R4AaM8ngQNQu5Y4NIc/pv61Hww9ATcHFK1OhTbu
         ipvA==
X-Gm-Message-State: AGi0PuYL18tjcfgym3DeuQEGbYGgG0tU8+oTi5TK8QPTjQv0ZPKxV0EN
        D/54xECaU+aPpc8+q2uLarvbtjbSKSAllySwe51obA==
X-Google-Smtp-Source: APiQypIfm8F2vC1A10Q+HEpp4v6afxOZB7/wXUUhJcZbkumVfUecWZ21jFiR66fC1ls8UZfHZKa0zn4AYiRDrDockZM=
X-Received: by 2002:a4a:e60d:: with SMTP id f13mr7832719oot.6.1588782295352;
 Wed, 06 May 2020 09:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
 <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
In-Reply-To: <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 6 May 2020 17:24:43 +0100
Message-ID: <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
Subject: Re: Checksum behaviour of bpf_redirected packets
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 6 May 2020 at 02:28, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 4, 2020 at 9:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > In our TC classifier cls_redirect [1], we use the following sequence
> > of helper calls to
> > decapsulate a GUE (basically IP + UDP + custom header) encapsulated packet:
> >
> >   skb_adjust_room(skb, -encap_len,
> > BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO)
> >   bpf_redirect(skb->ifindex, BPF_F_INGRESS)
> >
> > It seems like some checksums of the inner headers are not validated in
> > this case.
> > For example, a TCP SYN packet with invalid TCP checksum is still accepted by the
> > network stack and elicits a SYN ACK.
> >
> > Is this known but undocumented behaviour or a bug? In either case, is
> > there a work
> > around I'm not aware of?
>
> I thought inner and outer csums are covered by different flags and driver
> suppose to set the right one depending on level of in-hw checking it did.

I've figured out what the problem is. We receive the following packet from
the driver:

    | ETH | IP | UDP | GUE | IP | TCP |
    skb->ip_summed == CHECKSUM_UNNECESSARY

ip_summed is CHECKSUM_UNNECESSARY because our NICs do rx
checksum offloading. On this packet we run skb_adjust_room_mac(-encap),
and get the following:

    | ETH | IP | TCP |
    skb->ip_summed == CHECKSUM_UNNECESSARY

Note that ip_summed is still CHECKSUM_UNNECESSARY. After
bpf_redirect()ing into the ingress, we end up in tcp_v4_rcv. There
skb_checksum_init is turned into a no-op due to
CHECKSUM_UNNECESSARY.

I think this boils down to bpf_skb_generic_pop not adjusting ip_summed
accordingly. Unfortunately I don't understand how checksums work
sufficiently. Daniel, it seems like you wrote the helper, could you
take a look?

Thanks!
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
