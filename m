Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7C81C77D3
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 19:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEFR0h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 13:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgEFR0h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 13:26:37 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB4F20746;
        Wed,  6 May 2020 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588785996;
        bh=MW9vcNYWrWecEZbAj0mvg9SMomA5kMMKuUMYN+XHLmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mudWu7d+jOC9nVWC1b+v2cOa+JfW43OicYDrM9uELmDwshyuqczs2RhQvhYoRaJo7
         BCT8RRe8ift857TJG5u3esWskjyq5DjzfeFjgqXjcZ5rQDuoVJ0qJvh7PiYz+XeglJ
         5Nyzf6I+q8ktzt0mw3nH5uhuEpYe8NZ2UtFJwrBU=
Date:   Wed, 6 May 2020 10:26:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: Checksum behaviour of bpf_redirected packets
Message-ID: <20200506102634.2c745f83@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
        <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
        <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 6 May 2020 17:24:43 +0100 Lorenz Bauer wrote:
> On Wed, 6 May 2020 at 02:28, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 4, 2020 at 9:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:  
> > >
> > > In our TC classifier cls_redirect [1], we use the following sequence
> > > of helper calls to
> > > decapsulate a GUE (basically IP + UDP + custom header) encapsulated packet:
> > >
> > >   skb_adjust_room(skb, -encap_len,
> > > BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO)
> > >   bpf_redirect(skb->ifindex, BPF_F_INGRESS)
> > >
> > > It seems like some checksums of the inner headers are not validated in
> > > this case.
> > > For example, a TCP SYN packet with invalid TCP checksum is still accepted by the
> > > network stack and elicits a SYN ACK.
> > >
> > > Is this known but undocumented behaviour or a bug? In either case, is
> > > there a work
> > > around I'm not aware of?  
> >
> > I thought inner and outer csums are covered by different flags and driver
> > suppose to set the right one depending on level of in-hw checking it did.  
> 
> I've figured out what the problem is. We receive the following packet from
> the driver:
> 
>     | ETH | IP | UDP | GUE | IP | TCP |
>     skb->ip_summed == CHECKSUM_UNNECESSARY
> 
> ip_summed is CHECKSUM_UNNECESSARY because our NICs do rx
> checksum offloading. On this packet we run skb_adjust_room_mac(-encap),
> and get the following:
> 
>     | ETH | IP | TCP |
>     skb->ip_summed == CHECKSUM_UNNECESSARY
> 
> Note that ip_summed is still CHECKSUM_UNNECESSARY. After
> bpf_redirect()ing into the ingress, we end up in tcp_v4_rcv. There
> skb_checksum_init is turned into a no-op due to
> CHECKSUM_UNNECESSARY.
> 
> I think this boils down to bpf_skb_generic_pop not adjusting ip_summed
> accordingly. 

Sounds like we need a call to __skb_decr_checksum_unnecessary(),
but as you indicate below when and where to call it is challenging :S

> Unfortunately I don't understand how checksums work
> sufficiently. Daniel, it seems like you wrote the helper, could you
> take a look?

