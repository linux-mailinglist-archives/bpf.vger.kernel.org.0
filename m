Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398E64EE18D
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 21:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiCaTSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 15:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbiCaTSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 15:18:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E6F91550
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:16:29 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id k11so478575ilv.5
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvlaQ+Tn2znnxaUOffCyk0RLUJRuirgU/fSco9aZeUY=;
        b=DFxnZmU7uSoVNqeX8Fjj+CtmqMuBjRA61389f8jBmCbiVWGIksY8HEelgYIalI6+bJ
         npB8mqj/prelEjIc5FwqIXiHMoIUgMGncZqzcKDDB/Gtl0ABPFmPbP/C55ojCiX3c+iR
         4GVJJHr2nOlx2uJbBDZa30kaPA3JyMlvsTpTZt4Z5/Sc7xDlwC/FgVYddD3FxXSZNgax
         pFU3pXfqO1vG0NW3iSaaHN9in69DGtDzCsccsK9amLtCId5BrMOveB6WDYGI8qgFsbZl
         VUrY9s2zd0D7w34CpDwLswjK67O64zJDtf+uMtGjA0dWWfY8KO1LBt8BOw5gl5yztcml
         ECOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvlaQ+Tn2znnxaUOffCyk0RLUJRuirgU/fSco9aZeUY=;
        b=tfVPAaF4ES0Z1ZbKRxEa/qLlgene1f4bV7kE0pEgRiigeuRx2JNKBoUY8tT6e8OQXt
         +yFYvK3qfdvlOtmGyRcojWcElI2OU98aWv30i6jutO6gwI/25KHrp3b0ldnWogUszW83
         k1xBvagXH+kXS0JsKrHqX6EOJTH+bkRJQWEUVKi+W36TWh+OTMp7hsJjmcEaO+XrzKsH
         UA2Iz3wQwjqql4YpA+Jvq/FgS2HefTkF7EfLaWt4Ey+S2j/ku920tBrSzi4AlaSWQWu8
         KfmHykhJhef3e4Y3h+uR3SiBRSqaM0AN4lmj6LFY9Q+MCULtC5wPbTYnZ8mSxjALoRED
         73JA==
X-Gm-Message-State: AOAM530dNC1UGONWZns1D0XMiDBxzMwGr0HIZ2VJUtd5Ai43Yf0FvSyG
        2liOTurWwXLdfvorXOBvUAkrEyFjjB62vytz8xGldpvN
X-Google-Smtp-Source: ABdhPJyVzHYaMTA9Lr9cpAvyY3+H5OtY02mdIICB4zGBPSNK1mPerW4vDZ/WMHqU1RceT7QQ3VpG1HyYxzZGYEFa8Jk=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr14408692ilb.305.1648754188594; Thu, 31
 Mar 2022 12:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-5-andrii@kernel.org>
 <alpine.LRH.2.23.451.2203311518530.22469@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2203311518530.22469@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 31 Mar 2022 12:16:17 -0700
Message-ID: <CAEf4BzZ9XA_dC7+zoKJ1FdGmvbtKBE13Y2C3kg8zQfLcz+-icA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: wire up spec management and other
 arch-independent USDT logic
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 31, 2022 at 7:50 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Fri, 25 Mar 2022, Andrii Nakryiko wrote:
>
> > Last part of architecture-agnostic user-space USDT handling logic is to
> > set up BPF spec and, optionally, IP-to-ID maps from user-space.
> > usdt_manager performs a compact spec ID allocation to utilize
> > fixed-sized BPF maps as efficiently as possible. We also use hashmap to
> > deduplicate USDT arg spec strings and map identical strings to single
> > USDT spec, minimizing the necessary BPF map size. usdt_manager supports
> > arbitrary sequences of attachment and detachment, both of the same USDT
> > and multiple different USDTs and internally maintains a free list of
> > unused spec IDs. bpf_link_usdt's logic is extended with proper setup and
> > teardown of this spec ID free list and supporting BPF maps.
> >
>
> It might be good to describe the relationship between a USDT specification
> (spec) and the site specific targets that can be associated with it.  So
> the spec is the description of the provider + name + args, and the the
> target represents the potentially multiple sites associated with that
> spec.
>
> Specs are stored in the spec array map, indexed by spec_id; targets are
> stored in the ip_map, and these reference a spec id.  So from the BPF side
> we can use the bpf_cookie to look up the spec directly, or if cookies are
> not supported on the BPF side, we can look up ip -> spec_id mapping in
> ip_map, and from there can look up the spec_id -> spec in the spec map.
>

Correct, I'll incorporate that into comments I'm going to add in v2, thanks.

> Dumb question here: the spec id recycling is a lot of work;
> instead of maintaining this for the array map, couldn't we use a hashmap
> for spec ids with a monotonically-increasing next_spec_id value or
> something similar?

We could, but hashmap lookup is significantly slower than ARRAY
lookup, so I chose performance in this case. Maintaining the list of
IDs isn't that big of a deal.

>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> one suggestion below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > ---
> >  tools/lib/bpf/usdt.c | 167 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 166 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index 86d5d8390eb1..22f5f56992f8 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
>
> <snip>
>
> >               opts.ref_ctr_offset = target->sema_off;
> > +             opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
> >               uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
> >                                                             target->rel_ip, &opts);
> >               err = libbpf_get_error(link);
>
> should be uprobe_link I think.
>


Nice catch, will fix.
