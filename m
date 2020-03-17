Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA1E187D7E
	for <lists+bpf@lfdr.de>; Tue, 17 Mar 2020 10:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgCQJ4I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Mar 2020 05:56:08 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45372 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQJ4I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Mar 2020 05:56:08 -0400
Received: by mail-ot1-f48.google.com with SMTP id e9so13757323otr.12
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2020 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3McFaeY5HqyQTOmxau05fc/1b6hfhgDgXIGehcLbXg=;
        b=f8wvOJ630VsUvYsOoR6g5enUMo9TuP3ZXJoTCHedVGiqX8TUs1XpXxpqhj9oeu/q8l
         aChmwxFu2iolys/Au9ALXBQix7LvygcpWNQcy3ZLHSAt6cdLB6hxrWQ0saXQxE39zPan
         7OpkrIhDyx7PWOZo9IfYiHvmkte+9dhOyyMVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3McFaeY5HqyQTOmxau05fc/1b6hfhgDgXIGehcLbXg=;
        b=ufxko/m0xmMdxl+rtt78vbRIULeOQ4rxs4Hk4pFxuMMdPFPldKRfxChwSqg8e4+gJZ
         v8sg/UzbQ2WFX5PhxJT/Gj6sWSS1RGhN+1jb/JQT/dhSuP52ZRW4yupD6+6ueyCz7G2j
         /huW/+6e1CbCdPrimKmgmMQhB7vU8gaEPU2KbnMhqwb86+B7t4VpwUXoUDwl/rvDOMe5
         rcYeDyBNEBRgsaJfqSMgOA1CgnrCia12xrwxTyFSOty5Kz1TKnFGwCjiUuiSKNUFzfea
         +FlK23xdiNWyHYDyS2gFMRb7VzurWh4A0M9FKCG7DQBi5zTC7ADHk2mUoyKpuuivU+y0
         Xzfg==
X-Gm-Message-State: ANhLgQ2B+IsNHk5y1WvJRTot6p0J/u3APDyC0EkgwgdIwXonItRN2xpF
        f11XosxhCVa2AMAkQwriv4mM6CPSCTq4hj2iHcFpkQ==
X-Google-Smtp-Source: ADFU+vvpxkkBhwxP7rb3PcvOajDYNaOSt6mrdj7zsXQIBpCnEb0V6suBiONQDVzh+klYxh1CRngaWfyZRuiBzITwLkQ=
X-Received: by 2002:a05:6830:13c7:: with SMTP id e7mr2981268otq.5.1584438967649;
 Tue, 17 Mar 2020 02:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200310174711.7490-1-lmb@cloudflare.com> <20200312015822.bhu6ptkx5jpabkr6@ast-mbp.dhcp.thefacebook.com>
 <CACAyw9-Ui5FECjAaehP8raRjcRJVx2nQAj5=XPu=zXME2acMhg@mail.gmail.com>
 <20200312175828.xenznhgituyi25kj@ast-mbp> <CACAyw98cp2we2w_L=YgEj+BbCqA5_3HvSML1VZzyNeF8mVfEEQ@mail.gmail.com>
 <20200314025832.3ffdgkva65dseoec@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200314025832.3ffdgkva65dseoec@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 17 Mar 2020 09:55:56 +0000
Message-ID: <CACAyw99HC70=wYBzZAiQVyUi56y_0x-6saGkp_KHBpjQuva1KA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Return fds from privileged sockhash/sockmap lookup
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 14 Mar 2020 at 02:58, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I'm not following. There is skb->sk. Why do you need to lookup sk ? Because
> your hook is before demux and skb->sk is not set? Then move your hook to after?
>
> I think we're arguing in circles because in this thread I haven't seen the
> explanation of the problem you're trying to solve. We argued about your
> proposed solution and got stuck. Can we restart from the beginning with all
> details?

Yes, that's a good idea. I mentioned this in passing in my cover
letter, but should
have provided more context.

Jakub is working on a patch series to add a BPF hook to socket dispatch [1] aka
the inet_lookup function. The core idea is to control skb->sk via a BPF program.
Hence, we can't use skb->sk.

Introducing this hook poses another problem: we need to get the struct sk from
somewhere. The canonical way in BPF is to use the lookup_sk helpers. Of course
that doesn't work, since our hook would invoke itself. So we need a
data structure
that can hold sockets, to be used by programs attached on the new hook.

Jakub's RFC patch set used REUSEPORT_SOCKARRAY for this. During LPC '19
we got feedback that sockmap is probably the better choice. As a
result, Jakub started
working on extending sockmap TCP support and after a while I joined to add UDP.

Now, we are looking at what our control plane could look like. Based
on the inet-tool
work that Marek Majkowski has done [2], we currently have the following set up:

* An LPM map that goes from IP prefix and port to an index in a sockmap
* A sockmap that holds sockets
* A BPF program that performs the business logic

inet-tool is used to update the two maps to add and remove mappings on the fly.
Essentially, services donate their sockets either via fork+exec or SCM_RIGHTS on
a Unix socket.

Once we have inserted a socket in the sockmap, it's not possible to
retrieve it again.
This makes it impossible to change the position of a socket in the
map, to resize the
map, etc. with our current design.

One way to work around this is to add a persistent component to our
control plane:
a process can hold on to the sockets and re-build the map when necessary. The
downsides are that upgrading the service is non-trivial (since we need
to pass the
socket fds) and that a failure of this service is catastrophic. Once
it happens, we
probably have to reboot the machine to get it into a workable state again.

We'd like to avoid a persistent service if we can. By allowing to look
up fds from the
sockmap, we could make this part of our control plane more robust.

1: https://www.youtube.com/watch?v=qRDoUpqvYjY
2: https://github.com/majek/inet-tool

I hope this explanation helps, sorry for not being more thorough in the original
cover letter!

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
