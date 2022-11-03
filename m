Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06A3618A5C
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiKCVOK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiKCVOK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95111838D
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7588662017
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5953C43140
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667510047;
        bh=h9p794TMeyeY42pyHV5I4uNCv+zJGK8jrdRhCTMQMmo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r0biYds1D2pMU7sWY1aXIwcqRdKsZeIXajJQVj91NgEln8pZdZn8EmkOlaHMPOGnZ
         Y4QhimekaNIBrm85n6vTurhe5tUZx7OoJKt36clrYKjBxI45MQfyfGFK0r1dT4ESTR
         gVDii7Yq7PfTU3LSf64QP8ZwNlM/tg8ubvWD2U/JpbfLuczVXWRl+EoiVi/6qwTt0A
         hZtEVgh/56fdBzv8FUTLyPNXlcUMjvsSZXm2jTsds9UpAuYd6sx3FbFWadfHY1T7XI
         W83FVml+FMC9QPBFfjHVLjxTGKSqVCk3xEjG91wMWQv8dpUjA2j4Q4OCOyo54UmF3Y
         QOt1EegR8qVYQ==
Received: by mail-ej1-f43.google.com with SMTP id kt23so8641407ejc.7
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 14:14:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf3CJuee8Qf4IrL38W1HLgePGts4GSL5gK56PXKXhWaDcK4cRVM8
        RuX25E8OpP3WGHEk+SJYLch7WuDQjO1yoWaaF3E=
X-Google-Smtp-Source: AMsMyM5FJMrio3LZXgI/Wj7a52zZr5jFZCFaYP2IQehQpidns2jdpGn0RkchlqOfjU2x5FCORDDZOirmjofkCwFo+4g=
X-Received: by 2002:a17:907:b602:b0:7ad:e82c:3355 with SMTP id
 vl2-20020a170907b60200b007ade82c3355mr17780468ejc.3.1667510046000; Thu, 03
 Nov 2022 14:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221031222541.1773452-1-song@kernel.org> <14dfef4f077b3c9ebce2526ba2cfebd2c151a036.camel@intel.com>
In-Reply-To: <14dfef4f077b3c9ebce2526ba2cfebd2c151a036.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 3 Nov 2022 14:13:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6FvtLcMN4v4iM9sctcoY_JV9f5+2wuJ2JhYa_eSbgQeg@mail.gmail.com>
Message-ID: <CAPhsuW6FvtLcMN4v4iM9sctcoY_JV9f5+2wuJ2JhYa_eSbgQeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 RESEND 0/5] vmalloc_exec for modules and BPF programs
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 2, 2022 at 3:30 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-10-31 at 15:25 -0700, Song Liu wrote:
> > This set enables bpf programs and bpf dispatchers to share huge pages
> > with
> > new API:
> >   vmalloc_exec()
> >   vfree_exec()
> >   vcopy_exec()
> >
> > The idea is similar to Peter's suggestion in [1].
> >
> > vmalloc_exec() manages a set of PMD_SIZE RO+X memory, and allocates
> > these
> > memory to its users. vfree_exec() is used to free memory allocated by
> > vmalloc_exec(). vcopy_exec() is used to update memory allocated by
> > vmalloc_exec().
> >
> > Memory allocated by vmalloc_exec() is RO+X, so this doesnot violate
> > W^X.
> > The caller has to update the content with text_poke like mechanism.
> > Specifically, vcopy_exec() is provided to update memory allocated by
> > vmalloc_exec(). vcopy_exec() also makes sure the update stays in the
> > boundary of one chunk allocated by vmalloc_exec(). Please refer to
> > patch
> > 1/5 for more details of
> >
> > Patch 3/5 uses these new APIs in bpf program and bpf dispatcher.
> >
> > Patch 4/5 and 5/5 allows static kernel text (_stext to _etext) to
> > share
> > PMD_SIZE pages with dynamic kernel text on x86_64. This is achieved
> > by
> > allocating PMD_SIZE pages to roundup(_etext, PMD_SIZE), and then use
> > _etext to roundup(_etext, PMD_SIZE) for dynamic kernel text.
>
> It might help to spell out what the benefits of this are. My
> understanding is that (to my surprise) we actually haven't seen a
> performance improvement with using 2MB pages for JITs. The main
> performance benefit you saw on your previous version was from reduced
> fragmentation of the direct map IIUC. This was from the effect of
> reusing the same pages for JITs so that new ones don't need to be
> broken.
>
> The other benefit of this thing is reduced shootdowns. It can load a
> JIT with about only a local TLB flush on average, which should help
> really high cpu systems some unknown amount.

Thanks for pointing out the missing information.

I don't have a benchmark that uses very big BPF programs, so the
results I have don't show much benefit from fewer iTLB misses.

Song
