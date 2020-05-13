Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1C1D20B7
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgEMVOv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 17:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgEMVOu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 May 2020 17:14:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52422C061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 14:14:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s1so881254qkf.9
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26k2U+qWGSWeHztuUp6d2PF6l57b502E7BsHG3bV7Kw=;
        b=hmqTagrkwBq4YN3N6zPB2PA1vADY8DMubtCBZvL2pdiG4o8oImNTTe6qQ4UTazM0n8
         BDiY6g6i8Hn3IngXLtJ79u5GM7yNpKZ8a5Hb3O3AK62WMzJQqkhTiqMdZw0H4PZilt7E
         xxTAW1wa3Vx6aDbTTLzCgs1an6/7i7QUwodgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26k2U+qWGSWeHztuUp6d2PF6l57b502E7BsHG3bV7Kw=;
        b=DreW5IBiOdXIUdUvwLf1Dkevbi24cVeEUmou80R5Xl+7OWIPRI1yLC/RopFz7L7PtR
         LCHsMnGQrpBzNHt/8yaAZXcQfbbn+HbtG+Ae7CySVTr+2IdJlhczpkpFz9T3Tv0k1Dyt
         EeJzCKb5tYnZdpsSTnsaaHqyXpRgCaMo+Yd0Xe3JtT9K2CG9LpqwDx/XJ8R3OOie2dKT
         XK/vvQ+O9wOO4Zs1ci4DEfTIFiU7aYpyG17nvDr1n6W2XquGAUMhH85OxcbWH+V46BBX
         LwHJ21JmBQ8UEof5A1LTny01/axTChiimsYhnZpDm0G1qPLtBpqqVyawlhcWxpK2BXYr
         zc3g==
X-Gm-Message-State: AOAM532OvnOf5RDdd4u0YcosrrDChOQVNNcoaxU2fkFvMD6lTexoV80n
        HRa9Jq4QI3YNTJDsq7Bu5g1K2NRn54daI89oIN5z2A==
X-Google-Smtp-Source: ABdhPJwyLwkh+Z+nGiq30nDEqDSwapL8UBhyZ6SWCCEMD/iJR5qN086AjCeolLUJpALni6A7zZ9PJjnrj93RkArI654=
X-Received: by 2002:a37:9d4f:: with SMTP id g76mr1709510qke.235.1589404488363;
 Wed, 13 May 2020 14:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200513031930.86895-1-alexei.starovoitov@gmail.com>
 <CAJPywT+c8uvi2zgUD_jObmi9T6j50THzjQHg-mudNrEC2HuJvg@mail.gmail.com>
 <20200513175301.43lxbckootoefrow@ast-mbp.dhcp.thefacebook.com>
 <CAJPywTKUmzDObSurppiH4GCJquDTnVWKLH48JNB=8RNcb5TiCQ@mail.gmail.com> <20200513185452.6dvzhpz5sgs7hcti@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200513185452.6dvzhpz5sgs7hcti@ast-mbp.dhcp.thefacebook.com>
From:   Marek Majkowski <marek@cloudflare.com>
Date:   Wed, 13 May 2020 22:14:37 +0100
Message-ID: <CAJPywTLneBjG6Lx7mS6GG-D93XHa1s1_aSGMoMjnfmMNrzvEnQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/3] Introduce CAP_BPF
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        network dev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, linux-security-module@vger.kernel.org,
        acme@redhat.com, jamorris@linux.microsoft.com,
        Jann Horn <jannh@google.com>, KP Singh <kpsingh@google.com>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 7:54 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 13, 2020 at 07:30:05PM +0100, Marek Majkowski wrote:
> > On Wed, May 13, 2020 at 6:53 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Wed, May 13, 2020 at 11:50:42AM +0100, Marek Majkowski wrote:
> > > > On Wed, May 13, 2020 at 4:19 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > CAP_BPF solves three main goals:
> > > > > 1. provides isolation to user space processes that drop CAP_SYS_ADMIN and switch to CAP_BPF.
> > > > >    More on this below. This is the major difference vs v4 set back from Sep 2019.
> > > > > 2. makes networking BPF progs more secure, since CAP_BPF + CAP_NET_ADMIN
> > > > >    prevents pointer leaks and arbitrary kernel memory access.
> > > > > 3. enables fuzzers to exercise all of the verifier logic. Eventually finding bugs
> > > > >    and making BPF infra more secure. Currently fuzzers run in unpriv.
> > > > >    They will be able to run with CAP_BPF.
> > > > >
> > > >
> > > > Alexei, looking at this from a user point of view, this looks fine.
> > > >
> > > > I'm slightly worried about REUSEPORT_EBPF. Currently without your
> > > > patch, as far as I understand it:
> > > >
> > > > - You can load SOCKET_FILTER and SO_ATTACH_REUSEPORT_EBPF without any
> > > > permissions
> > >
> > > correct.
> > >
> > > > - For loading BPF_PROG_TYPE_SK_REUSEPORT program and for SOCKARRAY map
> > > > creation CAP_SYS_ADMIN is needed. But again, no permissions check for
> > > > SO_ATTACH_REUSEPORT_EBPF later.
> > >
> > > correct. With clarification that attaching process needs to own
> > > FD of prog and FD of socket.
> > >
> > > > If I read the patchset correctly, the former SOCKET_FILTER case
> > > > remains as it is and is not affected in any way by presence or absence
> > > > of CAP_BPF.
> > >
> > > correct. As commit log says:
> > > "Existing unprivileged BPF operations are not affected."
> > >
> > > > The latter case is different. Presence of CAP_BPF is sufficient for
> > > > map creation, but not sufficient for loading SK_REUSEPORT program. It
> > > > still requires CAP_SYS_ADMIN.
> > >
> > > Not quite.
> > > The patch will allow BPF_PROG_TYPE_SK_REUSEPORT progs to be loaded
> > > with CAP_BPF + CAP_NET_ADMIN.
> > > Since this type of progs is clearly networking type I figured it's
> > > better to be consistent with the rest of networking types.
> > > Two unpriv types SOCKET_FILTER and CGROUP_SKB is the only exception.
> >
> > Ok, this is the controversy. It made sense to restrict SK_REUSEPORT
> > programs in the past, because programs needed CAP_NET_ADMIN to create
> > SOCKARRAY anyway.
>
> Not quite. Currently sockarray needs CAP_SYS_ADMIN to create
> which makes little sense from security pov.
> CAP_BPF relaxes it CAP_BPF or CAP_SYS_ADMIN.
>
> > Now we change this and CAP_BPF is sufficient for
> > maps - I don't see why CAP_BPF is not sufficient for SK_REUSEPORT
> > programs. From a user point of view I don't get why this additional
> > CAP_NET_ADMIN is needed.
>
> That actually bring another point. I'm not changing sock_map,
> sock_hash, dev_map requirements yet. All three still require CAP_NET_ADMIN.
> We can relax them to CAP_BPF _or_ CAP_NET_ADMIN in the future,
> but I'd like to do that in the follow up.

Agreed, we can discuss relaxation of SOCKMAP in the future.

> > > > I think it's a good opportunity to relax
> > > > this CAP_SYS_ADMIN requirement. I think the presence of CAP_BPF should
> > > > be sufficient for loading BPF_PROG_TYPE_SK_REUSEPORT.
> > > >
> > > > Our specific use case is simple - we want an application program -
> > > > like nginx - to control REUSEPORT programs. We will grant it CAP_BPF,
> > > > but we don't want to grant it CAP_SYS_ADMIN.
> > >
> > > You'll be able to grant nginx CAP_BPF + CAP_NET_ADMIN to load SK_REUSEPORT
> > > and unpriv child process will be able to attach just like before if
> > > it has right FDs.
> > > I suspect your load balancer needs CAP_NET_ADMIN already anyway due to
> > > use of XDP and TC progs.
> > > So granting CAP_BPF + CAP_NET_ADMIN should cover all bpf prog needs.
> > > Does it address your concern?
> >
> > Load balancer (XDP+TC) is another layer and permissions there are not
> > a problem. The specific issue is nginx (port 443) and QUIC. QUIC is
> > UDP and due to the nginx design we must use REUSEPORT groups to
> > balance the load across workers. This is fine and could be done with a
> > simple SOCK_FILTER - we don't need to grant nginx any permissions,
> > apart from CAP_NET_BIND_SERVICE.
> >
> > We would like to make the REUSEPORT program more complex to take
> > advantage of REUSEPORT_EBPF for stickyness (restarting server without
> > interfering with existing flows), we are happy to grant nginx CAP_BPF,
> > but we are not happy to grant it CAP_NET_ADMIN. Requiring this CAP for
> > REUSEPORT severely restricts the API usability for us.
> >
> > In my head REUSEPORT_EBPF is much closer to SOCKET_FILTER. I
> > understand why it needed capabilities before (map creation) and I
> > argue these reasons go away in CAP_BPF world. I assume that any
> > service (with CAP_BPF) should be able to use reuseport to distribute
> > packets within its own sockets.  Let me know if I'm missing something.
>
> Fair enough. We can include SK_REUSEPORT prog type as part of CAP_BPF alone.
> But will it truly achieve what you want?

It will make the security model much more useful and sane for me and
other users of stuff that depends on SK_REUSEPORT (like nginx + UDP).
So yes, long-term it will help. Thanks.

> You still need CAP_NET_ADMIN for sock_hash which you're using.
> Are you saying it's part of the different process that has that cap_net_admin
> and nginx will be fine with cap_bpf + cap_net_bind_service ?

At this moment good old SOCKARRAY is sufficient. Having both SOCKARRAY
and SK_REUSEPORT_EBPF depend only on CAP_BPF is a good start. Thanks
for considering that. We can discuss relaxation of SOCKMAP in the
future.

Marek
