Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6615DC966E
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2019 03:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfJCBn7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 21:43:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40413 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfJCBn6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 21:43:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id d26so712544pgl.7
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rs32j8WvzeFPAreG4mHos0yN/N21nPcQuzu7RFp9WgA=;
        b=PG6f54CJHGJP01VMwqpJh7UxNpRQL/hXS7yBx5WXnXlISxAkAPYIslL166uoG3JHvQ
         dUftGEoz1sK6O8Nt/gVx9kvOJMR4zQjsfZ++a5yHoUmVwTzd4W2MTEzBQj3HbfAQAOm7
         Mk8/wQRXOBoHnXT4VkjgLIc018Ta0gSW0VK7HpBpRwJbcIWZfSvPY5uHhqAORsEcgbN5
         oCbg4PkHx8RTC8TRpWa2mK2hxk9ArDAILj/UM9eNJr2hrUGfsNVhCHivM7VfdNU9f7dR
         Iyp2r1Byds/P/XUj/9yGduO6DXc8qVAQT0cYYNSaxRn1W8aU9gqI172357d7UKN1xHyd
         XOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rs32j8WvzeFPAreG4mHos0yN/N21nPcQuzu7RFp9WgA=;
        b=i1mGUZWC/18GaGIsSxroCjg1bMsyABmLdlVhXtmouLorhQz1fbj9LWhp/lJrC+x2FT
         JXy3hi1hN5hkM5lBQSpDYOWiPjT4uyls5BDQlG++C2O6a9L3nauQzjZvYurjnuclPame
         TKWqfvzCt6PUCvx1Lsm738GjESCS93rQQ3lV+uV9THzuHHkc/Rp01LZj7C4qBhwXl8CI
         Z48CujeeFZNuW+ucv7XJzsoTUjL+UXjq+d7FGh6ghlm78tya9VLof8E0DL9BIWqCj80G
         Oo7pDfaqZ2dd+5eKgLJuHUDEN0IOYdmlfTysOafBsu4/I+Bc9RxFZhg5lKDzgKMv/dZT
         NcKg==
X-Gm-Message-State: APjAAAVOpGMDmAIvoANny1OFGgjeNj39fbngAU6Z+QA8zYC31Ie+LlXT
        AGp3eujoIn3j7lD2BxbtFmHBag==
X-Google-Smtp-Source: APXvYqxRqNvFGJLCtWBp7aCJHWXLYWi3Jyt+BJjHl7xXiqKelEL4mlRc9rs8PgwNF31AiSoBOH5khA==
X-Received: by 2002:a63:ba47:: with SMTP id l7mr6797580pgu.201.1570067037187;
        Wed, 02 Oct 2019 18:43:57 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id v68sm690402pfv.47.2019.10.02.18.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 18:43:56 -0700 (PDT)
Date:   Wed, 2 Oct 2019 18:43:56 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/flow_dissector: add mode to enforce
 global BPF flow dissector
Message-ID: <20191003014356.GC3223377@mini-arch>
References: <20191002173357.253643-1-sdf@google.com>
 <20191002173357.253643-2-sdf@google.com>
 <CAEf4BzZuEChOL828F91wLxUr3h2yfAkZvhsyoSx18uSFSxOtqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZuEChOL828F91wLxUr3h2yfAkZvhsyoSx18uSFSxOtqw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/02, Andrii Nakryiko wrote:
> On Wed, Oct 2, 2019 at 10:35 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Always use init_net flow dissector BPF program if it's attached and fall
> > back to the per-net namespace one. Also, deny installing new programs if
> > there is already one attached to the root namespace.
> > Users can still detach their BPF programs, but can't attach any
> > new ones (-EPERM).
> >
> > Cc: Petar Penkov <ppenkov@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  Documentation/bpf/prog_flow_dissector.rst |  3 +++
> >  net/core/flow_dissector.c                 | 11 ++++++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/bpf/prog_flow_dissector.rst b/Documentation/bpf/prog_flow_dissector.rst
> > index a78bf036cadd..4d86780ab0f1 100644
> > --- a/Documentation/bpf/prog_flow_dissector.rst
> > +++ b/Documentation/bpf/prog_flow_dissector.rst
> > @@ -142,3 +142,6 @@ BPF flow dissector doesn't support exporting all the metadata that in-kernel
> >  C-based implementation can export. Notable example is single VLAN (802.1Q)
> >  and double VLAN (802.1AD) tags. Please refer to the ``struct bpf_flow_keys``
> >  for a set of information that's currently can be exported from the BPF context.
> > +
> > +When BPF flow dissector is attached to the root network namespace (machine-wide
> > +policy), users can't override it in their child network namespaces.
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index 7c09d87d3269..494e2016fe84 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -115,6 +115,11 @@ int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
> >         struct bpf_prog *attached;
> >         struct net *net;
> >
> > +       if (rcu_access_pointer(init_net.flow_dissector_prog)) {
> > +               /* Can't override root flow dissector program */
> > +               return -EPERM;
> > +       }
> 
> This is racy, shouldn't this be checked after grabbing a lock below?
What kind of race do you have in mind?

Even if I put this check under the mutex, it's still possible that if
two cpus concurrently start attaching flow dissector programs (i.e. call
sys_bpf(BPF_PROG_ATTACH)) at the same time (one to root ns, the other
to non-root ns), the cpu that is attaching to non-root can grab mutex first,
pass all the checks and attach the prog (higher frequency, tubo boost, etc).

The mutex is there to protect only against concurrent attaches to the
_same_ netns. For the sake of simplicity we have a global one instead
of a mutex per net-ns.

So I'd rather not grab the mutex and keep it simple. Even in there is a
race, in __skb_flow_dissect we always check init_net first.

> > +
> >         net = current->nsproxy->net_ns;
> >         mutex_lock(&flow_dissector_mutex);
> >         attached = rcu_dereference_protected(net->flow_dissector_prog,
> > @@ -910,7 +915,11 @@ bool __skb_flow_dissect(const struct net *net,
> >         WARN_ON_ONCE(!net);
> >         if (net) {
> >                 rcu_read_lock();
> > -               attached = rcu_dereference(net->flow_dissector_prog);
> > +               attached =
> > +                       rcu_dereference(init_net.flow_dissector_prog);
> > +
> > +               if (!attached)
> > +                       attached = rcu_dereference(net->flow_dissector_prog);
> >
> >                 if (attached) {
> >                         struct bpf_flow_keys flow_keys;
> > --
> > 2.23.0.444.g18eeb5a265-goog
> >
