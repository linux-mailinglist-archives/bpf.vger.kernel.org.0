Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7EE225A1
	for <lists+bpf@lfdr.de>; Sun, 19 May 2019 03:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfESBUu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 May 2019 21:20:50 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:33930 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfESBUu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 May 2019 21:20:50 -0400
Received: by mail-lj1-f176.google.com with SMTP id j24so9426580ljg.1
        for <bpf@vger.kernel.org>; Sat, 18 May 2019 18:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGwvZjevVE2OQtRlZP5/0AHtykyUsY5+86ngoMkR7UQ=;
        b=Xv/BBCS0bqJpTH5BmpL04QO9RjcsVkaeZ60gR4dC9LQbtOoPGFVOBgP0/cG8liS9ik
         3P9iQlqCBjqpuivLksS+BCcHVnxmKYUwTaq0Ya3L0ROuy1MPMLdrhXYkC0ZvNjN45PSm
         9vEWNg5NojMfxTkcHpF4Ho/kpgPuo92aJhONQdrwRkNezqkPlOl8StH5u5VgZmDSYIN+
         WFqKqsRzjgE7qS2sTG4RVSKg7JZ6aGqvy0ll4Yr66K4olrFlQZeAwam4IsOL5l5+NGTS
         L2NLtSi2/GPhBn76RyAhvLyFyJnlEeZctmoluJk89Nu09MFdSaIcezJqPJcr6mytJYYb
         2+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGwvZjevVE2OQtRlZP5/0AHtykyUsY5+86ngoMkR7UQ=;
        b=n8kJ/IhG5W7IJ3nb7b5jSP66z+nBKt/i8qckO9AOxFo+jf87O/Dt2jWoBwmFkxRJQF
         TNho9pE2W1012q48MOYTXhYNIxj4f6H7iOA1egfzvEQSX6xGJFf0zaifnym0hM+FnIEd
         XrWiDvk5qmz6VRG7MBy969scYZvKe2aH/QEI/4q/zpL2HxyD/9t5Lp/J/qMDew5nFiAQ
         B9GtDBrLOMd+36WPiEPATg/9H4SQ5oiAdXM1+rb6jzrk3t3KOGO9ievNnkl0Mkm5yZ1L
         QFFvsqlPzgbHHyOKTvYzw47f6QpLvCBVToKoIW95lksoHS7vrNxwq39o/k8vwXoE4+bC
         pxGA==
X-Gm-Message-State: APjAAAW9wAvKEp/AbQdJSkuL/ukKDff7WShxghrawFIRgJfmQKPj58Mv
        7SMiJ8q+v5yaGK03P2C4029sgQES9bkRsqVOpzVlIA==
X-Google-Smtp-Source: APXvYqzsLfqPeK0euDSGnppL73eC7TFJNrP/R4wKGABmhdLlKARFiitHzUVncjeJYvVU5zxClLIjO677zhOAJ9BBTCM=
X-Received: by 2002:a2e:9acb:: with SMTP id p11mr3833616ljj.129.1558228847330;
 Sat, 18 May 2019 18:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw98+qycmpQzKupquhkxbvWK4OFyDuuLMBNROnfWMZxUWeA@mail.gmail.com>
 <CADa=RyyuAOupK7LOydQiNi6tx2ELOgD+bdu+DHh3xF0dDxw_gw@mail.gmail.com>
 <CACAyw9_EGRob4VG0-G4PN9QS_xB5GoDMBB6mPXR-WcPnrFCuLg@mail.gmail.com>
 <20190516203325.uhg7c5sr45od7lzm@ast-mbp> <CACAyw9_yq_xVjh0_2QhAg-2vOLHUCMce4Jhy466N+F4zH7dPmw@mail.gmail.com>
In-Reply-To: <CACAyw9_yq_xVjh0_2QhAg-2vOLHUCMce4Jhy466N+F4zH7dPmw@mail.gmail.com>
From:   Joe Stringer <joe@isovalent.com>
Date:   Sat, 18 May 2019 18:20:36 -0700
Message-ID: <CADa=RyzQqRUWLEKfY6MuvBjN4MuGsB8dGcuDYBcOhx0SLyZJ1Q@mail.gmail.com>
Subject: Re: RFC: Fixing SK_REUSEPORT from sk_lookup_* helpers
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Martin Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 17, 2019 at 7:15 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Thu, 16 May 2019 at 21:33, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, May 16, 2019 at 09:41:34AM +0100, Lorenz Bauer wrote:
> > > On Wed, 15 May 2019 at 18:16, Joe Stringer <joe@isovalent.com> wrote:
> > > >
> > > > On Wed, May 15, 2019 at 8:11 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> > > > >
> > > > > In the BPF-based TPROXY session with Joe Stringer [1], I mentioned
> > > > > that the sk_lookup_* helpers currently return inconsistent results if
> > > > > SK_REUSEPORT programs are in play.
> > > > >
> > > > > SK_REUSEPORT programs are a hook point in inet_lookup. They get access
> > > > > to the full packet
> > > > > that triggered the look up. To support this, inet_lookup gained a new
> > > > > skb argument to provide such context. If skb is NULL, the SK_REUSEPORT
> > > > > program is skipped and instead the socket is selected by its hash.
> > > > >
> > > > > The first problem is that not all callers to inet_lookup from BPF have
> > > > > an skb, e.g. XDP. This means that a look up from XDP gives an
> > > > > incorrect result. For now that is not a huge problem. However, once we
> > > > > get sk_assign as proposed by Joe, we can end up circumventing
> > > > > SK_REUSEPORT.
> > > >
> > > > To clarify a bit, the reason this is a problem is that a
> > > > straightforward implementation may just consider passing the skb
> > > > context into the sk_lookup_*() and through to the inet_lookup() so
> > > > that it would run the SK_REUSEPORT BPF program for socket selection on
> > > > the skb when the packet-path BPF program performs the socket lookup.
> > > > However, as this paragraph describes, the skb context is not always
> > > > available.
> > > >
> > > > > At the conference, someone suggested using a similar approach to the
> > > > > work done on the flow dissector by Stanislav: create a dedicated
> > > > > context sk_reuseport which can either take an skb or a plain pointer.
> > > > > Patch up load_bytes to deal with both. Pass the context to
> > > > > inet_lookup.
> > > > >
> > > > > This is when we hit the second problem: using the skb or XDP context
> > > > > directly is incorrect, because it assumes that the relevant protocol
> > > > > headers are at the start of the buffer. In our use case, the correct
> > > > > headers are at an offset since we're inspecting encapsulated packets.
> > > > >
> > > > > The best solution I've come up with is to steal 17 bits from the flags
> > > > > argument to sk_lookup_*, 1 bit for BPF_F_HEADERS_AT_OFFSET, 16bit for
> > > > > the offset itself.
> > > >
> > > > FYI there's also the upper 32 bits of the netns_id parameter, another
> > > > option would be to steal 16 bits from there.
> > >
> > > Or len, which is only 16 bits realistically. The offset doesn't really fit into
> > > either of them very well, using flags seemed the cleanest to me.
> > > Is there some best practice around this?
> > >
> > > >
> > > > > Thoughts?
> > > >
> > > > Internally with skbs, we use `skb_pull()` to manage header offsets,
> > > > could we do something similar with `bpf_xdp_adjust_head()` prior to
> > > > the call to `bpf_sk_lookup_*()`?
> > >
> > > That would only work if it retained the contents of the skipped
> > > buffer, and if there
> > > was a way to undo the adjustment later. We're doing the sk_lookup to
> > > decide whether to
> > > accept or forward the packet, so at the point of the call we might still need
> > > that data. Is that feasible with skb / XDP ctx?
> >
> > While discussing the solution for reuseport I propose to use
> > progs/test_select_reuseport_kern.c as an example of realistic program.
> > It reads tcp/udp header directly via ctx->data or via bpf_skb_load_bytes()
> > including payload after the header.
> > It also uses bpf_skb_load_bytes_relative() to fetch IP.
> > I think if we're fixing the sk_lookup from XDP the above program
> > would need to work.
>
> Agreed.
>
> > And I think we can make it work by adding new requirement that
> > 'struct bpf_sock_tuple *' argument to bpf_sk_lookup_* must be
> > a pointer to the packet and not a pointer to bpf program stack.
>
> This would break existing users, no? The sk_assign use case Joe Stringer
> is working on would also break, because its impossible to look up a tuple
> that hasn't come from the network.

Right, in practice the bpf prog sk lookups for tproxy use case look
like first, look up with packet tuple, then if no tproxied socket is
found, substitute the destination port with the pre-configured tproxy
port and look up. Requiring packet pointer means rewriting the packet
for this case (not to mention the ext hdrs case that Lorenz mentions
below).

> It occurs to me that it's impossible to reconcile this use case with
> SK_REUSEPORT in general. It would be great if we could return an
> error in such case.
>
> > Then helper can construct a fake skb and assign
> > fake_skb->data = &bpf_sock_tuple_arg.sport
>
> That isn't valid if the packet contains IP options or extension headers, because
> the offset of sport is variable.
>
> > It can check that struct bpf_sock_tuple * pointer is within 100-ish bytes
> > from xdp->data and within xdp->data_end
>
> Why the 100-byte limitation?
>
> > This way the reuseport program's assumption that ctx->data points to tcp/udp
> > will be preserved and it can access it all including payload.
>
> How about the following:
>
>     sk_lookup(ctx, &saddr, len, netns, BPF_F_IPV4 |
> BPF_F_OFFSET(offsetof(sport))
>
> SK_REUSEPORT can then access from saddr+offsetof(sport) to saddr+len.
> The helper uses
> offsetof(sport) to retrieve the tuple.
>
> - Works with stack, map, packet pointers
> - The verifier does bounds checking on the buffer for us due to ARG_CONST_SIZE
> - If no BPF_F_IPV? is present, we fall back to current behaviour
>
> >
> > This approach doesn't need to mess with xdp_adjust_head and adjust uapi to pass length.
> > Existing progs/test_sk_lookup_kern.c will magically start working with XDP
> > even when reuseport prog is attached.
> > Thoughts?
> >
>
>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
