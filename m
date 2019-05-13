Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D21BEEF
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 23:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEMVCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 17:02:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36495 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfEMVCm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 17:02:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so7093712plr.3
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RyYeiTkXVG6rOzRfWLj4K86vKbyG5AHSg6mr8z5PfUE=;
        b=lrqk6UdUat1UwUQfIm/0l/kpxCLpTYDzDaI47rkR4Cu5NMm4+PrCWKTg6oDlmkVmY9
         E/e8pOkS437aCyHc/6yHw7v6j9DWuYP2XYZDlduFZUUhQOdL07hOLJCE4+JDdjt3UoE3
         y94tec1GcGFsHydW2Qar+mK66L0lUW3SQqDnLw/ZdoPbNgvZ+PrlAmAVNCbBhskbDc14
         GCMDR6A9biCoZ3E2/h/ZIfJjtaE8f1hRwnD1vrzvwVU8SYlSoJeXcZvJZh0RsoZTb1YE
         XiJnJMVh/SGPsEAHmwUYzrLd/bidmMFekwQa/Lf16sgoTZZ4jvFzbiBwERbXJha0QLL6
         JwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RyYeiTkXVG6rOzRfWLj4K86vKbyG5AHSg6mr8z5PfUE=;
        b=XmV8Z2jCmBciyEg2cC46PAasX+45NKJWyCCBF8kqJeigRIdmidXxW+Ii7lhMlMersc
         gu8hiwLeLb9m4j0oRKT7LaD8N9j1Y9CKINruTWRD3UxoFviZlRtvAdOTvcSpzY7aLHgO
         4/QJuEbZztEhqgrpskeOOB3fZGM2w/kIiw6XE15I+ZL+kbD/tiJSTZdf87bKQOTIhOSt
         BSEqszrIPYo+dDmOYqjFnsLkM2JtPX1z9atlMXKWSDRq9dHP/HTNA7XYPMN2laYBL+YK
         Nk0v63Y2udeXIhCa0NhbHHYq3D5AiblTT8pYMGv76zoElZJNn5Vx2bQxjjkWQXPOUiY7
         C7wg==
X-Gm-Message-State: APjAAAUi9QhMrcMa3BG1lBHQDwELVRYm0hDWZg9u34/dZGSRtZUvgc0x
        NdOkgUmpQ+1NfKsS/DkHhyf8Ig==
X-Google-Smtp-Source: APXvYqwK4VuHRPYHhNYnmgegXEvj3Fnde6rs8rzHmcBVo10rxY0/+vu6Lxl3+6BYt5bsM5pP00la+w==
X-Received: by 2002:a17:902:b58a:: with SMTP id a10mr4120130pls.83.1557781361143;
        Mon, 13 May 2019 14:02:41 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id y3sm19251992pfe.9.2019.05.13.14.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 14:02:40 -0700 (PDT)
Date:   Mon, 13 May 2019 14:02:39 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>
Subject: Re: [PATCH bpf 1/2] flow_dissector: support
 FLOW_DISSECTOR_KEY_ETH_ADDRS with BPF
Message-ID: <20190513210239.GC24057@mini-arch>
References: <20190513185402.220122-1-sdf@google.com>
 <CAF=yD-LO6o=uZ-aT-J9uPiBcO4f2Zc9uyGZ+f7M7mPtRSB44gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-LO6o=uZ-aT-J9uPiBcO4f2Zc9uyGZ+f7M7mPtRSB44gA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/13, Willem de Bruijn wrote:
> On Mon, May 13, 2019 at 3:53 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > If we have a flow dissector BPF program attached to the namespace,
> > FLOW_DISSECTOR_KEY_ETH_ADDRS won't trigger because we exit early.
> 
> I suppose that this is true for a variety of keys? For instance, also
> FLOW_DISSECTOR_KEY_IPV4_ADDRS.
I though the intent was to support most of the basic stuff (eth/ip/tcp/udp)
without any esoteric protocols. Not sure about FLOW_DISSECTOR_KEY_IPV4_ADDRS,
looks like we support that (except FLOW_DISSECTOR_KEY_TIPC part).

> We originally intended BPF flow dissection for all paths except
> tc_flower. As that catches all the vulnerable cases on the ingress
> path on the one hand and it is infeasible to support all the
> flower features, now and future. I think that is the real fix.
Sorry, didn't get what you meant by the real fix.
Don't care about tc_flower? Just support a minimal set of features
needed by selftests?

> >
> > Handle FLOW_DISSECTOR_KEY_ETH_ADDRS before BPF and only if we have
> > an skb (used by tc-flower only).
> >
> > Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  net/core/flow_dissector.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index 9ca784c592ac..ba76d9168c8b 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -825,6 +825,18 @@ bool __skb_flow_dissect(const struct net *net,
> >                         else if (skb->sk)
> >                                 net = sock_net(skb->sk);
> >                 }
> > +
> > +               if (dissector_uses_key(flow_dissector,
> > +                                      FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> > +                       struct ethhdr *eth = eth_hdr(skb);
> 
> Here as well as in the original patch: is it safe to just cast to
> eth_hdr? In the same file, __skb_flow_dissect_gre does test for
> (encapsulated) protocol first.
Good question, I guess the assumption here is that
FLOW_DISSECTOR_KEY_ETH_ADDRS is only used by tc_flower and the appropriate
checks should be there as well.
It's probably better to check skb->proto here though.
