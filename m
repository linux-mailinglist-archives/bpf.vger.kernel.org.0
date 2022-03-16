Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16C34DB5B5
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 17:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbiCPQOy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242693AbiCPQOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 12:14:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9496DB7CF
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 09:13:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o23so570101pgk.13
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z02blqoxThuGkhi9wvej2czZDkzHuDmLTnoYf50M1uc=;
        b=cGZXSXrsgc31cO4Sk0bWUlfS1YHAUJEfGTBf5TIBee1N2O1v51N7loA1ZZpKIMLhQU
         ZL4G+LW3sc0mD2+VrXcSsn2ki9iK3vUoZBFy+e+ymKKFCYoQ+YANqSB0U4QAHY9uDFXB
         SafWbfwTRZGMBUkBvqQatRHY7TtVrEWAZlgYsjZQpgb3TmjgnxKesoFw28mzwz8qsMx3
         NyfJIBCq/S3dp8Nn2WH5a8J4Z0pUttEIw8/bVGsy6obvllTS6Lt/V7qPFQ8r+oGvrktt
         7x5mr0KfJ+CGeeCF427uudGKR4pMiwgAi/lgMMyclVWd9GIeS9bxCskxGnxeAA+7BFqV
         Ye+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z02blqoxThuGkhi9wvej2czZDkzHuDmLTnoYf50M1uc=;
        b=WL5LtNIrQQFAhmBeQK2QspZqHF/8OaTpNkkXlVnTJlWB62nT1McfhT1FxNug1OTm5N
         vtLAlo0txlUa24aUjYl4PfRGVJzR8ZaAugDo2JX6yCq04nnPLg+qYj3IUTLrhDcdrWyS
         jBfKo9LsDD9oaXOY2100NEz157p9pS7z0P9i9nSl4166KG8EffPcPPET+UulIre2S9E+
         4dKdlIvKGaA09iAwL5PU0Dd0PS8w+5Qqa5W0oTLM+z7sbzyHyjxbnnnvb296M2swKF5U
         kXjSB1FM6/vB808K765nybuzcNRyN9pyN+L9AMoyt2QMYKSs9UYFqKQw70xT+2E/+Wuv
         m3zw==
X-Gm-Message-State: AOAM53386JGz/FSAHe+QE8RhuWPNFigtQF/XC3XQD5fEuSSuq+5vZv0q
        EUQKKTO7jTJD8I0TlML6t+yLqAlqBZs6Ccr1qN5zjA==
X-Google-Smtp-Source: ABdhPJzy/6N3/PYQ7f+k69lwS1R1FqLXCJ2jyBfTrGN9DVuznSeyY9IHKWkgrsllbUI26ZmLok3HTwQWVmcOo994kQ4=
X-Received: by 2002:a65:6091:0:b0:35e:d274:5f54 with SMTP id
 t17-20020a656091000000b0035ed2745f54mr306553pgu.200.1647447216944; Wed, 16
 Mar 2022 09:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
 <CAPhsuW5qHSZNSEh8CQK3wYqtJ4XB+EwFEJWKA9SkA+wGFbvNCg@mail.gmail.com>
In-Reply-To: <CAPhsuW5qHSZNSEh8CQK3wYqtJ4XB+EwFEJWKA9SkA+wGFbvNCg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 16 Mar 2022 09:13:00 -0700
Message-ID: <CAJD7tkYGXVX+ehGsOMidfaKCbjuB2HeAK=Up_2evg6iOZD1z-Q@mail.gmail.com>
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 11:05 PM Song Liu <song@kernel.org> wrote:
>
> On Wed, Mar 9, 2022 at 12:27 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> [...]
> >
> > The map usage by BPF programs and integration with rstat can be as follows:
> > - Internally, each map entry has per-cpu arrays, a total array, and a
> > pending array. BPF programs and user space only see one array.
> > - The update interface is disabled. BPF programs use helpers to modify
> > elements. Internally, the modifications are made to per-cpu arrays,
> > and invoke a call to cgroup_bpf_updated()  or an equivalent.
> > - Lookups (from BPF programs or user space) invoke an rstat flush and
> > read from the total array.
>
> Lookups invoke a rstat flush, so we still walk every node of a subtree for
> each lookup, no? So the actual cost should be similar than walking the
> subtree with some BPF program? Did I miss something?
>

Hi Song,

Thanks for taking the time to read my proposal.

The rstat framework maintains a tree that contains only updated
cgroups. An rstat flush only traverses this tree, not the cgroup
subtree/hierarchy.

This also ensures that consecutive readers do not have to do any
traversals unless new updates happen, because the first reader will
have already flushed the stats.

>
> Thanks,
> Song
>
> > - In cgroup_rstat_flush_locked() flush BPF stats as well.
> >
> [...]
