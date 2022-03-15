Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F34DA370
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 20:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351457AbiCOTrS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 15:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351455AbiCOTrR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 15:47:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4785521C
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 12:46:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n19so255215lfh.8
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNVNvCVNwVKu5U1LTf8MIQSIvt3rSWR+z0yUg0dmz+0=;
        b=RecVgMpjWDL4wCFj5pGnb4SjmFBYAPZzQ84uYXBj3vIQliw6MoUlWkP+Fr0FGr62t7
         ttM8YvfO/IjHeoaXjHaS5hPx5/KiEmk4Dv87FxSD8b+w8JSXni6zksmdmbp1oYclzI5A
         mrjDyapJ7szoU/1LSf4x8s17LZmCs4HAg8/Ke1TWKs2WTU8R+L7uALfGfffRmHnsXyU3
         4mBR1d9owu0oz+qG8MOW3rJK7msSiwCq9Tt+W7//8Q0lZd9QV9VcKKXKEXPmH0jNpX3l
         lX8OePrB/wwQ9EV23PuywB8j3d1DmSydNOKbbLIR3mLgFiwtrJE4mo2vdgLSNgorbcq4
         8eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNVNvCVNwVKu5U1LTf8MIQSIvt3rSWR+z0yUg0dmz+0=;
        b=ZSd7w5oxVnHMrkK7IQLmF/qPEafdtgbJIankPWEMc/r/jXmiGSIE4dRic6SMMP1PkN
         YybpQUf9fXvdOCclcjlz3IzVcvshbhD03mFBWxqNCNMcviDpVnGJxHbyBrZNJ4MBTW0Z
         fQJ0n5nIvVjqDNjieuih/9ccz1OBHCcRC1d7ro+A5lljziMohvNNhyMXEq7knnFsaIOf
         dwEvhYf5n4GyCVrLivinoNnrzUoX8VjyS+uEh8BJS9T4jiiA/mCIc1MoDx9VgI/8kmoe
         R7A3z+RH5I/uZ+FYeBZ0/CeyUKFJdJ17WvGFcAdos4Lj8jQ86KBgoEOAZdTIDNVgQ/R/
         DKbQ==
X-Gm-Message-State: AOAM531kR67SQzAk9fiMmlzxL4v8Ec/fOT5mQkEI4TSDwe6Upl8mZquM
        RSe39VH2O5VFhsEEiYme4zId0AdD89RdIcmjEhCPGa9y5ps=
X-Google-Smtp-Source: ABdhPJzBczAIct9M8iu9WGCFAB+1Fzj5E3RUjjkWs3ycc5eclPl4+ALRZkUg88bb83lSQ2WgtUCzPNpwBpxTA9XrjLQ=
X-Received: by 2002:a05:6512:22c9:b0:448:92dd:f26b with SMTP id
 g9-20020a05651222c900b0044892ddf26bmr7332556lfu.134.1647373561758; Tue, 15
 Mar 2022 12:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oXGvzTsPDTE9yLEfxJbjFvBt7-HzfO5Aa94PWXKWXPCzA@mail.gmail.com>
 <CAEf4Bza2qS0AaTTUDAncz+gCzn5-w=+DVLh_Tt=1kjNqctWahg@mail.gmail.com>
In-Reply-To: <CAEf4Bza2qS0AaTTUDAncz+gCzn5-w=+DVLh_Tt=1kjNqctWahg@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 15 Mar 2022 15:45:50 -0400
Message-ID: <CAO658oWagXsQDeFtRA2vZBzov7cwwVNTs5nHE9fMGrMOs6bbpQ@mail.gmail.com>
Subject: Re: bpf_map_create usage question
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 2:50 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 1:22 AM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > Hi there,
> >
> > If I call `bpf_map_create()` successfully I'll have a file descriptor
> > and not a `struct bpf_map`. This stifles me from using a lot of the
> > `bpf_map__` API functions, for example `bpf_map__pin()`. What's the
> > reason for this? Is there a way to get a  `struct bpf_map` that I'm
> > missing?
> >
>
> bpf_map_create() is a low-level libbpf API. It does create a map and
> returns FD. But it is not "integrated" with struct bpf_map APIs, which
> are so-called high-level libbpf APIs. bpf_object/bpf_map/bpf_program
> and related APIs are high-level APIs and they expect ELF BPF object
> file to declaratively define everything. You can use low-level APIs by
> getting FDs from high-level bpf_map/bpf_program using bpf_map__fd()
> and bpf_program__fd(), but constructing bpf_map from FD isn't easy or
> straightforward and should be avoided, if possible.

Thank you for the explanation!

>
> But one way to do this is to still declaratively define map in BPF
> object file, but then do bpf_map__reuse_fd() to substitute already
> created map by FD. This way libbpf won't create another map, it will
> just use your FD. But definitions of maps have to be compatible in
> terms of key/value sizes, max_entries, etc. In short: it's painful.
>
>
> As a bit of aside, I do think we are missing high-level APIs to work
> with bpf_map elements, something like bpf_map__lookup_elem() and
> bpf_map__update_elem() has been on my mind for a while, but I haven't
> gotten time to get to it. It would further minimize the need to drop
> down to low-level APIs.

Would these just call into bpf_map_update_elem() and
bpf_map_lookup_elem()? They'd take a *bpf_map  and pass the member fd
to the low level functions?

>
>
> > Thanks so much,
> > Grant Seltzer
> >
> > P.s. been a while since I've worked on adding docs, but I will finally
> > be getting back to it!
>
> Great, looking forward!
