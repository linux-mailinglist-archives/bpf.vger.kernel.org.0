Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98362614E0B
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 16:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKAPOc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 11:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiKAPOK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 11:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A8410AE
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 08:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31CE761628
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 15:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845F7C43470
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667315423;
        bh=SvaVKbWOjcFGtjuIbSMRORNEt7RV6wTMc3qGo9fRoHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mCAyYxTn1+Ofy90gjdiSr0pbgIzT0AOavTYASfGvCVJPiLIYS7BzFDEirkF1SScEz
         zlpj3m0p1Ayek7Mk4O5g5zStaIxLgLShQPaj89r9meXtDD4fN13T8f06HwkdZMFeoW
         2bznp1WfIyZYLxTNz5OC98mJMenjjzwbOVLLhj+qZOMm4nfQzfNkLH24AX6WMHt1cy
         8/1pssu5LD0rZqbZVj3HlBxQMtwYpwgsQlcga6RWBmDSXV1+US9hpITgvd9ec8bKDA
         BRAuU0IScrMZidJvfvHFSjxjXTXrIk0Idb6a0+SmutU7UEGgVX+Vz01cycpRyu7way
         IL7ut6PorMhjw==
Received: by mail-ej1-f48.google.com with SMTP id ud5so37820121ejc.4
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 08:10:23 -0700 (PDT)
X-Gm-Message-State: ACrzQf1qw8RwuU5ozx7fnOV+9QsgfdXKFMFwxdmvctXa3s7fUanOJmYo
        9zhKmDZ0R/p8tQ7QUsEaI/aqokiabdErL5SG6v4=
X-Google-Smtp-Source: AMsMyM69dgUaX6bBMYm+cT69IFBD4HBkrrN+5lGvxawemeKrQOqvu287AHj7ONU6nWREeWeP6S7S0bJH3jDaHtnDq3o=
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id
 wu1-20020a170906eec100b00782638476bemr18620906ejb.756.1667315421694; Tue, 01
 Nov 2022 08:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221031222541.1773452-1-song@kernel.org> <20221101112642.GB14379@lst.de>
In-Reply-To: <20221101112642.GB14379@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 1 Nov 2022 08:10:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ZQuYNmuQD0F713wriNsXDSC2LnvUye=3oG=-by9J2+g@mail.gmail.com>
Message-ID: <CAPhsuW5ZQuYNmuQD0F713wriNsXDSC2LnvUye=3oG=-by9J2+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 RESEND 0/5] vmalloc_exec for modules and BPF programs
To:     Christoph Hellwig <hch@lst.de>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 1, 2022 at 4:26 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Oct 31, 2022 at 03:25:36PM -0700, Song Liu wrote:
> > This set enables bpf programs and bpf dispatchers to share huge pages with
> > new API:
> >   vmalloc_exec()
> >   vfree_exec()
> >   vcopy_exec()
>
> Maybe it's just me, but I don't like the names very much.  They imply
> a slight extension to the vmalloc API, but while they use the vmalloc
> mechanisms internally, the API is actually quite different.
>
> So why not something like:
>
>    execmem_alloc
>    execmem_free
>    execmem_fill or execmem_set or copy_to_execmem
>
> ?

I don't have a strong preference on names. We can change the name
to whatever we agree on.

Thanks,
Song
