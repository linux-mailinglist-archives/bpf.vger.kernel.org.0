Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FB1C9D40
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 23:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEGVZV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 17:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEGVZV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 17:25:21 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54AC20731;
        Thu,  7 May 2020 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588886720;
        bh=n/si8ookLwao2yXd8GnQxdxJx8JIPI7P0aotBojVjv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zuaWoRGjOHl2KV+uAqgCJoFJzIQ1T29L3OkHMdSG0HD3rfobVCk6JCpPV6cuQCoKo
         oPcNIo+PqZMpf2R2XPpb6yESi6kg5iPkeDryWDh7rftr6lMUolg4JJhUwzzU2pwZMd
         j6BwcPRcSNFPr2baQAgFL9eqktdRumddmveriRwI=
Date:   Thu, 7 May 2020 14:25:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: Checksum behaviour of bpf_redirected packets
Message-ID: <20200507142518.43c22a1b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net>
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
        <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
        <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
        <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net>
        <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com>
        <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 7 May 2020 18:43:47 +0200 Daniel Borkmann wrote:
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
> helpers are also used in our LB case for DSR, for example. I agree that it
> sucks to expose these implementation details though. So eventually we'd end
> up with 3 csum flags: inc/dec/reset to none. bpf_skb_adjust_room() is already
> a complex to use helper with all its flags where you end up looking into the
> implementation detail to understand what it is really doing. I'm not sure if
> we make anything worse, but I do see your concern. :/ (We do have bpf_csum_update()
> helper as well. I wonder whether we should split such control into a different
> helper.)

Probably stating the obvious but for decap of UDP tunnels which carry
locally terminated flows - we'd probably also want the upgrade from
UNNECESSARY to COMPLETE, like we do in the kernel
(skb_checksum_try_convert()). Tricky.
