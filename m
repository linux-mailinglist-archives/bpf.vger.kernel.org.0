Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853B502ED4
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343720AbiDOStT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 14:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346923AbiDOStT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 14:49:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4366FAF
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 11:46:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k22so11566783wrd.2
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xifGS2jtF7JW/vcBS05vsf/ClDjf3TmwQJRRDYHl1VY=;
        b=Efs5oXLvln7u5UUsYwIdsNa1ohbQev3/Pg/MynKPUrXIvELUiHns22jmed9DUWe/X4
         dJvoP/ZUw8U2kY6cJCfAjiBfG72x0Qd7TI3P3RvDyoklKYE804s3BqTsJVse6oPy0sqo
         n1ZKL8oqzLrvTETFx/MEfh9n0ZHioi4Va0d06YerOVUCHDnpDUCczXLzc3t1xzv3hCD5
         yEkpHqOp+ExQ/WKKKslYIzMItZol426GOBgSboRW0KUqXy6ktAVWUK10z3+PoIh9Foex
         ez8poOReaaiT3j4MlVWdvD4lXLql+ElAffE2FxZj6Fapy3b4BWwUlrX1bMPpFTCYZgGj
         jI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xifGS2jtF7JW/vcBS05vsf/ClDjf3TmwQJRRDYHl1VY=;
        b=x3B26lrx5dPvn/qMRRm5fPeNtsnMwnd6EB0NOJkjVsBrtpm++Md7yPgdkX1g5wjAnv
         AzgcgqRT9BMTMtOS4tcrRouWNnOiAOP9W0sfZD6vLITJWnaervOgdg/8FZxAOy3d+zNq
         vJBqUjjqFps4fzgZ8X7rHeGEPpo0tJ/i3+RRfanD1q7mZVZjZB3V9vCDTSZkj1h4XZWu
         fnF7D1b0uv8zeqqEy1uU6i4NnedsEs/Vb9PehCDTsJZ1ciV2kT9VW6rBEFe5oOg3tTmv
         wGbGhmA1PJNYMqsc295uYVS0dvenbS819G8dGIytT+PjBqbC39UJBqMV7mdQSKDhdW0N
         Jkhg==
X-Gm-Message-State: AOAM533maH2Nat3mMrgg/x8dULvgc7o+vBNzRTMMy8b6fi10NP/aKibH
        adf+czdWBs5O7J2VHU738JA6a+WDyqTzqM8/nAk1cg==
X-Google-Smtp-Source: ABdhPJx5wm/GQ33NIUb2qaiVJy63Gy48wqlqYL7vMFN8iniKMKHs7e9LeT1oQOiEVMao9wGUnFML7sFhyv5Inh8rzfc=
X-Received: by 2002:a05:6000:168c:b0:20a:84ea:6647 with SMTP id
 y12-20020a056000168c00b0020a84ea6647mr320150wrd.191.1650048408138; Fri, 15
 Apr 2022 11:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220407223112.1204582-1-sdf@google.com> <20220407223112.1204582-4-sdf@google.com>
 <20220408225628.oog4a3qteauhqkdn@kafai-mbp.dhcp.thefacebook.com>
 <87fsmmp1pi.fsf@cloudflare.com> <CAKH8qBuqPQjZ==CjD=rO8dui9LNcUNRFOg7ROETRxbuMYnzBEg@mail.gmail.com>
 <878rs66xv3.fsf@cloudflare.com>
In-Reply-To: <878rs66xv3.fsf@cloudflare.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 15 Apr 2022 11:46:36 -0700
Message-ID: <CAKH8qBvaxdNN1AAwqE1qON0k-o+jmoiY4nK5+8Ew1hHC_6V1jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] bpf: minimize number of allocated lsm
 slots per program
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 10:49 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> On Mon, Apr 11, 2022 at 11:44 AM -07, Stanislav Fomichev wrote:
> > On Sat, Apr 9, 2022 at 11:10 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> [...]
>
> >> [^1] It looks like we can easily switch from cgroup->bpf.progs[] from
> >>      list_head to hlist_head and save some bytes!
> >>
> >>      We only access the list tail in __cgroup_bpf_attach(). We can
> >>      either iterate over the list and eat the cost there or push the new
> >>      prog onto the front.
> >>
> >>      I think we treat cgroup->bpf.progs[] everywhere like an unordered
> >>      set. Except for __cgroup_bpf_query, where the user might notice the
> >>      order change in the BPF_PROG_QUERY dump.
> >
> >
> > [...]
> >
> >> [^2] Unrelated, but we would like to propose a
> >>      CGROUP_INET[46]_POST_CONNECT hook in the near future to make it
> >>      easier to bind UDP sockets to 4-tuple without creating conflicts:
> >>
> >>      https://github.com/cloudflare/cloudflare-blog/tree/master/2022-02-connectx/ebpf_connect4
> >
> > Do you think those new lsm hooks can be used instead? If not, what's missing?
>
> Same as for CGROUP_INET hooks, there is no post-connect() LSM hook.

There is inet_conn_established, but looks like it triggers only for
tcp. Selinux is the only user, so I'm assuming we should be able to
extend it as needed?

I'm not sure how far we can go with adding custom hooks :-( So moving
to fentry/lsm seems like the way to go. Maybe we should follow up with
a per-cgroup fentry as well :-D


> Why are we looking for a post-connect hook?
>
> Having a pre- and a post- connect hook, would allow us to turn the whole
> connect() syscall into a critical section with synchronization done in
> BPF - lock on pre-connect, unlock on post-connect.
>
> Why do we want to serialize connect() calls?
>
> To check for 4-tuple conflict with an existing unicast UDP socket, in
> which case we want fail connect() if there is a conflict.
>
> That said, ideally we would rather have a mechanism like
> IP_BIND_ADDRESS_NO_PORT, but for UDP, and one that allows selecting both
> an local IP and port.
>
> We're hoping to put together an RFC sometime this quarter.
