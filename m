Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B081A4DA4F4
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 22:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiCOWAc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 18:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiCOWAb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 18:00:31 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F32E095
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 14:59:17 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r2so436080ilh.0
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0s8yWBBFBmBU1vRY2mCJlG9rE40hKokZrRjySfGKmE=;
        b=W+oyh3wqQJGScLyvb2QcI+GBVPVp/amGMVdAiTbR2ZcN7vHUxgAv+DFx6c1Lx3/U5/
         L0NijlVM61XdERRqr0uEMe4R4AoQqHZaRv+9lUvV08cor6z9cVOYIsQgTWvBnOYu5ElY
         FhIht1UrUnsW8mYpiXaWr8Aw0NCGn0iRLG7WcrUUjQxeR9b9eHD/R8ydGm18dqewlSmu
         5ylFj7WkTsDPcoGr+HWo80S6BLiP6Vnx4vZ/PIKPm8JyYVAtkcOZ+AqEsSVz3IVFAuVM
         pBAzUTz8YDaxsw67Apw7nImUBI2Y6uvfDO7D7TAw0HTj+gxxA4evwWc55oUqEpuwBrDZ
         Jzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0s8yWBBFBmBU1vRY2mCJlG9rE40hKokZrRjySfGKmE=;
        b=PJ1nohzrzD8aRMBlBaezHkoGRr5JNnLdczH0X2blwxwepwK4ShKxPE9bTg5+2RSStA
         WENKNa9STgXbTtnftikYpV6r5fZWbiFTN1SR2SIzwqI23Btev3RNc/BW6+3L+i28es/z
         oYXcyn4R8TWDs7rYjJPSHhUjXFDGOTgxFLrcnoM/lvClm//5h7RinHw/w4kXcVcfmO4G
         V/mhgdwafFtZ+ZGkBewAKAi1twrAFPahG+I8PSLg3NfU6yduZyS4jzvdRJxnZZWdJEpM
         TfTjwKSyHYhKHOeO4L86GcDDZuP86u2ejt+HrP+NK250SGKjz+HZ6ItR2JKZqDxN24Jv
         r+hA==
X-Gm-Message-State: AOAM533cNi5bYoJ13e2u7ptbZe14IIIFRlRmmEGSKnjmSfS18BZpaRWV
        1T13LkK0cW8+wltwB12pLw5gati8dCpe666jA9AzZMJzbug=
X-Google-Smtp-Source: ABdhPJzIbaIfhp3WGu0DCoxxtdXQ1lB+4bJGlrkxOjRcXkdQdxIu3v16AKpV97akRPfjCXGuJLr11ZdwgjYZD08Wv8w=
X-Received: by 2002:a05:6e02:1a8e:b0:2c6:3b01:1ffe with SMTP id
 k14-20020a056e021a8e00b002c63b011ffemr23554024ilv.239.1647381557232; Tue, 15
 Mar 2022 14:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oXGvzTsPDTE9yLEfxJbjFvBt7-HzfO5Aa94PWXKWXPCzA@mail.gmail.com>
 <CAEf4Bza2qS0AaTTUDAncz+gCzn5-w=+DVLh_Tt=1kjNqctWahg@mail.gmail.com> <CAO658oWagXsQDeFtRA2vZBzov7cwwVNTs5nHE9fMGrMOs6bbpQ@mail.gmail.com>
In-Reply-To: <CAO658oWagXsQDeFtRA2vZBzov7cwwVNTs5nHE9fMGrMOs6bbpQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 14:59:06 -0700
Message-ID: <CAEf4BzYb5WzHP0zhDwabkk9zMKhr6oq3AqE_YMD+MTe=SJjCbQ@mail.gmail.com>
Subject: Re: bpf_map_create usage question
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
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

On Tue, Mar 15, 2022 at 12:46 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 2:50 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Mar 15, 2022 at 1:22 AM Grant Seltzer Richman
> > <grantseltzer@gmail.com> wrote:
> > >
> > > Hi there,
> > >
> > > If I call `bpf_map_create()` successfully I'll have a file descriptor
> > > and not a `struct bpf_map`. This stifles me from using a lot of the
> > > `bpf_map__` API functions, for example `bpf_map__pin()`. What's the
> > > reason for this? Is there a way to get a  `struct bpf_map` that I'm
> > > missing?
> > >
> >
> > bpf_map_create() is a low-level libbpf API. It does create a map and
> > returns FD. But it is not "integrated" with struct bpf_map APIs, which
> > are so-called high-level libbpf APIs. bpf_object/bpf_map/bpf_program
> > and related APIs are high-level APIs and they expect ELF BPF object
> > file to declaratively define everything. You can use low-level APIs by
> > getting FDs from high-level bpf_map/bpf_program using bpf_map__fd()
> > and bpf_program__fd(), but constructing bpf_map from FD isn't easy or
> > straightforward and should be avoided, if possible.
>
> Thank you for the explanation!
>
> >
> > But one way to do this is to still declaratively define map in BPF
> > object file, but then do bpf_map__reuse_fd() to substitute already
> > created map by FD. This way libbpf won't create another map, it will
> > just use your FD. But definitions of maps have to be compatible in
> > terms of key/value sizes, max_entries, etc. In short: it's painful.
> >
> >
> > As a bit of aside, I do think we are missing high-level APIs to work
> > with bpf_map elements, something like bpf_map__lookup_elem() and
> > bpf_map__update_elem() has been on my mind for a while, but I haven't
> > gotten time to get to it. It would further minimize the need to drop
> > down to low-level APIs.
>
> Would these just call into bpf_map_update_elem() and
> bpf_map_lookup_elem()? They'd take a *bpf_map  and pass the member fd
> to the low level functions?

Yes, but I'd model API to accept explicit key/value sizes and validate
them internally based on bpf_map's definition. It's a pretty common
mistake (especially with per-CPU maps) to pass insufficient buffers to
write/read data to/from. Requiring users to explicitly specify the
size seems like a good idea.


>
> >
> >
> > > Thanks so much,
> > > Grant Seltzer
> > >
> > > P.s. been a while since I've worked on adding docs, but I will finally
> > > be getting back to it!
> >
> > Great, looking forward!
