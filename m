Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0511CD4ED
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEKJb5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKJb5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 05:31:57 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD6C061A0C
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 02:31:57 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id j4so6980236otr.11
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8A3MYPcEXP7i4I+pMJaBBrNf6dUsE+4VKRcNyHbV0o=;
        b=ox221MsLllUxdMif0kkl+xzJ3rSNAAPzx1DbvfCFEdkcv7/LDYbEIqh3nfYO71eJN0
         K6qL8c41oWMbgMu/zNx/iC46exYNGOM9JSyFmuXhrumfSvMAsafiLtu4Z6ledWA5YGO5
         OGOHuRfwSqIJ74U4XjRBuIH30NcV9OdFjCwrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8A3MYPcEXP7i4I+pMJaBBrNf6dUsE+4VKRcNyHbV0o=;
        b=tK6J8NDi9LOPwz2yUQ/4anArptJJb3JcpTJMqFGNDnxUkFWZ9A9Gt9rk66umhi4woM
         Lj2Qcgho4LSgHMzY7NsBhHim164XKcbCUztW5P7NcHtQfiz1BCDYyQ9yNX9pl4lWKRnz
         UhCPeu1KFQOb6FZoph9SOZYqT9jdGPTieeDPRzYsOiQyhZDRnoYEkjwaWOcnrIgeknXy
         bb3jM9T0RsG61j8pqFF5u+gMVyNQ6/04tFa5FzGSPfDy6GVn+LZiwFVlGPgtg/lJ6Txp
         nBecfEfuB7udtNezPpxRRz3sF7qgNLH1VUimh7/5pALCW1ZI5V/yKANJFG+quxjFoolv
         2sdQ==
X-Gm-Message-State: AGi0PubF30kY2TMbag4o0W1gwPuzqpAm9WMWISyfNzjb6BJx5iB1jwZr
        HgOTUt9MsNDhZBDghbmqlvQeKuc1AeZ06fJT2hud9Q==
X-Google-Smtp-Source: APiQypKhoBvNr+fvOG3dPPyU/nGTJKu3HSnKwCDfKBiYnqjtas2eexZU5YAtxV+VLtS8k7Ua/1Ad5W+gDZfw34T6Odo=
X-Received: by 2002:a05:6830:241b:: with SMTP id j27mr11522457ots.132.1589189515850;
 Mon, 11 May 2020 02:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
 <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
 <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
 <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net> <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com>
 <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net> <20200507142518.43c22a1b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200507142518.43c22a1b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 11 May 2020 10:31:44 +0100
Message-ID: <CACAyw9-Hf7977K3f6hM3gWawz2Y_KgkJ0URmivkAxX8kKH1iEA@mail.gmail.com>
Subject: Re: Checksum behaviour of bpf_redirected packets
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 7 May 2020 at 22:25, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 7 May 2020 18:43:47 +0200 Daniel Borkmann wrote:
> > > Thanks for the patch, it indeed fixes our problem! I spent some more time
> > > trying to understand the checksum offload stuff, here is where I am:
> > >
> > > On NICs that don't support hardware offload ip_summed is CHECKSUM_NONE,
> > > everything works by default since the rest of the stack does checksumming in
> > > software.
> > >
> > > On NICs that support CHECKSUM_COMPLETE, skb_postpull_rcsum
> > > will adjust for the data that is being removed from the skb. The rest of the
> > > stack will use the correct value, all is well.
> > >
> > > However, we're out of luck on NICs that do CHECKSUM_UNNECESSARY:
> > > the API of skb_adjust_room doesn't tell us whether the user intends to
> > > remove headers or data, and how that will influence csum_level.
> > >  From my POV, skb_adjust_room currently does the wrong thing.
> > > I think we need to fix skb_adjust_room to do the right thing by default,
> > > rather than extending the API. We spent a lot of time on tracking this down,
> > > so hopefully we can spare others the pain.
> > >
> > > As Jakub alludes to, we don't know when and how often to call
> > > __skb_decr_checksum_unnecessary so we should just
> > > unconditionally downgrade a packet to CHECKSUM_NONE if we encounter
> > > CHECKSUM_UNNECESSARY in bpf_skb_generic_pop. It sounds simple
> > > enough to land as a fix via the bpf tree (which is important for our
> > > production kernel). As a follow up we could add the inverse of the flags you
> > > propose via bpf-next.
> > >
> > > What do you think?
> >
> > My concern with unconditionally downgrading a packet to CHECKSUM_NONE would
> > basically trash performance if we have to fallback to sw in fast-path, these
> > helpers are also used in our LB case for DSR, for example. I agree that it
> > sucks to expose these implementation details though. So eventually we'd end
> > up with 3 csum flags: inc/dec/reset to none. bpf_skb_adjust_room() is already
> > a complex to use helper with all its flags where you end up looking into the
> > implementation detail to understand what it is really doing. I'm not sure if
> > we make anything worse, but I do see your concern. :/ (We do have bpf_csum_update()
> > helper as well. I wonder whether we should split such control into a different
> > helper.)
>
> Probably stating the obvious but for decap of UDP tunnels which carry
> locally terminated flows - we'd probably also want the upgrade from
> UNNECESSARY to COMPLETE, like we do in the kernel
> (skb_checksum_try_convert()). Tricky.

I guess this is an argument in the direction that bpf_adjust_room is too
low level an API?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
