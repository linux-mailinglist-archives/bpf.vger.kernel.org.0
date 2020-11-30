Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B2D2C89B4
	for <lists+bpf@lfdr.de>; Mon, 30 Nov 2020 17:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgK3QjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 11:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgK3QjB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Nov 2020 11:39:01 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C2BC0613D4
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 08:38:15 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 1so9005218pgq.11
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 08:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UX816yw8DAh1erZp5BAVsdx8QFf8rexiapeSutLKtDU=;
        b=aWSKDPWCTob0IK1uVdpoZExn/2n8CYvY2YxJHGV7pOqCTh4+TONEsVWIUMaAUuguq2
         dcBlye7LYlvaYBk4/yHBfa+BmQE3wZJBjzNhNEWXi4g4v2SMBKRi1T4yrZ2ffvOzi+mr
         7nSJTU4YOQd+6xMVkTn9qrdzxKd6wNWjx7pFSnRt2RsKiw9fTCIr0JeHoguG6ifQfP3P
         jNF7hh97DpSLS4NSF8AKpq0m00ZudomNZgURlpW8rPXmlSrjlQgSKBWlTEeOp6b5QDJ5
         IWM7na3y74brpwholwgkLE8EAM89Z/ns7MxWq3V1W1JO19ULqNDYKVlIpTwHFm7sjdCv
         xNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UX816yw8DAh1erZp5BAVsdx8QFf8rexiapeSutLKtDU=;
        b=GIZq8ulXTcy1y3T7R5SL1W++hj2ajFrx1OliFnG5MwJEtJusnTGC+MDZYVUVrvXkXG
         BSDrGMycZtgRQHXlzPGzc6iIqPKfu++9d/BvbtTPeuwQVswY94ptB8XJ4b39JwyX1u7I
         6iEHUVvo9jBo2lZAOXtIuT3MY5jZ2ve497EkO6yAoXqs6r2EECmb3+Cy71NFsYN+46B9
         Ejtnub1cUE6lHopx0d5dITez5NeK1BnABnX3yZrLR8x5FV1dYUdAUTfZsWLBTLAeu729
         nlpQ7i+Iz04wS5/N/vuS0/NuS1mQEzWDW7iBPqN6yjUZN841CpeycEcZeCXH4M8w7Tyo
         SPTw==
X-Gm-Message-State: AOAM530T3FeeE61Ki+tzimFQq4eH1KataNh6otwqfXiV2vm4DUC/fyPV
        atJbr18P8FAgdJQANOA7yQZHtaQ=
X-Google-Smtp-Source: ABdhPJxxRiSiL9TZBSG3e6fLHbVnNFg0unRsc3Mpp53zJ4Q+9PeSkn26dUkTkrBDuAqW0MgjKB3SlLo=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a17:90a:f691:: with SMTP id
 cl17mr27419417pjb.206.1606754294970; Mon, 30 Nov 2020 08:38:14 -0800 (PST)
Date:   Mon, 30 Nov 2020 08:38:13 -0800
In-Reply-To: <20201130010559.GA1991@rdna-mbp>
Message-Id: <20201130163813.GA553169@google.com>
Mime-Version: 1.0
References: <20201118001742.85005-1-sdf@google.com> <20201118001742.85005-3-sdf@google.com>
 <CAADnVQLxt11Zx8553fegoSWCtt0SQ_6uYViMtuhGxA7sv1YSxA@mail.gmail.com> <20201130010559.GA1991@rdna-mbp>
Subject: Re: [PATCH bpf-next 2/3] bpf: allow bpf_{s,g}etsockopt from cgroup
 bind{4,6} hooks
From:   sdf@google.com
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/29, Andrey Ignatov wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> [Tue, 2020-11-17 20:05  
> -0800]:
> > On Tue, Nov 17, 2020 at 4:17 PM Stanislav Fomichev <sdf@google.com>  
> wrote:
[..]
> >
> > I think it is ok, but I need to go through the locking paths more.
> > Andrey,
> > please take a look as well.

> Sorry for delay, I was offline for the last two weeks.
No worries, I was OOO myself last week, thanks for the feedback!

>  From the correctness perspective it looks fine to me.

>  From the performance perspective I can think of one relevant scenario.
> Quite common use-case in applications is to use bind(2) not before
> listen(2) but before connect(2) for client sockets so that connection
> can be set up from specific source IP and, optionally, port.

> Binding to both IP and port case is not interesting since it's already
> slow due to get_port().

> But some applications do care about connection setup performance and at
> the same time need to set source IP only (no port). In this case they
> use IP_BIND_ADDRESS_NO_PORT socket option, what makes bind(2) fast
> (we've discussed it with Stanislav earlier in [0]).

> I can imagine some pathological case when an application sets up tons of
> connections with bind(2) before connect(2) for sockets with
> IP_BIND_ADDRESS_NO_PORT enabled (that by itself requires setsockopt(2)
> though, i.e. socket lock/unlock) and that another lock/unlock to run
> bind hook may add some overhead. Though I do not know how critical that
> overhead may be and whether it's worth to benchmark or not (maybe too
> much paranoia).

> [0] https://lore.kernel.org/bpf/20200505182010.GB55644@rdna-mbp/
Even in case of IP_BIND_ADDRESS_NO_PORT, inet[6]_bind() does
lock_sock down the line, so it's not like we are switching
a lockless path to the one with the lock, right?

And in this case, similar to listen, the socket is still uncontended and
owned by the userspace. So that extra lock/unlock should be cheap
enough to be ignored (spin_lock_bh on the warm cache line).

Am I missing something?
