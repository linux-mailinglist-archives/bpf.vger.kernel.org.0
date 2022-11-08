Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1A621C69
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 19:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKHStN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 13:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKHSsy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 13:48:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463FE83B9C
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 10:47:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00244B81C18
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 18:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A454AC433B5
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667933238;
        bh=z+CPLTjXOvcKaHD7sqdmx5cvgbmmPAEMI+9ZTDKgU5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g/KilDaRGmIWdlgjLmZcCW+rDC+8T/amW2KqpxeJVna1+TvIWZHNkDVhor4iY0GLm
         9cLJuYwrEBvIv7vqXhs+8QD83Jyss4F9zDbT5awlwdq9GzS9y3H3jN4D7dxwCptGkz
         8Salt6utZaWGoHVYcpZ9ml1Bck2H5N8WkqoqMnS95QB1CdVWmTHaQiJo34+SYpJe0u
         sHbtgsp12PSJKDj6j1VQRgADZGi4WaFNOQD2iZK5DAMBDJqCrHeUN0giDqI8EEv5QN
         PyqTsZQDRKFs6G/UXUAZ7SaMPnTFNx2h20f3t0JblKZ445JP/pe3WUEflyyGqjrwya
         gLHue/6Zdnq8w==
Received: by mail-ej1-f53.google.com with SMTP id n12so40896115eja.11
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 10:47:18 -0800 (PST)
X-Gm-Message-State: ACrzQf1b1fwS8dsySko4GobNurfsSlK/AEZVM9q5hwH5uReg2nitceaB
        mRihaI4UYwMJKCpE/OGg3MDFKCxgj0hnIwS61hQ=
X-Google-Smtp-Source: AMsMyM6/n5sNyYm3bPxmQ3Bi8IhUP0Itp6tKeAntlNLg5w8zLtfvooWXxV2+9DtQzViBforLIbg38ELWFGdIgkdfrC4=
X-Received: by 2002:a17:907:b602:b0:7ad:e82c:3355 with SMTP id
 vl2-20020a170907b60200b007ade82c3355mr41167636ejc.3.1667933236913; Tue, 08
 Nov 2022 10:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <83277694-6cb3-3fc7-b300-d39f82ac5b04@csgroup.eu>
In-Reply-To: <83277694-6cb3-3fc7-b300-d39f82ac5b04@csgroup.eu>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Nov 2022 10:47:04 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7a6dAHQC1Qt7ryxxZ0RA8kfL3SWh+jrAKFaGDKguCexg@mail.gmail.com>
Message-ID: <CAPhsuW7a6dAHQC1Qt7ryxxZ0RA8kfL3SWh+jrAKFaGDKguCexg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 3:44 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
[...]
> >
> > execmem_alloc() manages a set of PMD_SIZE RO+X memory, and allocates these
> > memory to its users. execmem_alloc() is used to free memory allocated by
> > execmem_alloc(). execmem_fill() is used to update memory allocated by
> > execmem_alloc().
> >
> > Memory allocated by execmem_alloc() is RO+X, so this doesnot violate W^X.
> > The caller has to update the content with text_poke like mechanism.
> > Specifically, execmem_fill() is provided to update memory allocated by
> > execmem_alloc(). execmem_fill() also makes sure the update stays in the
> > boundary of one chunk allocated by execmem_alloc(). Please refer to patch
> > 1/5 for more details of
> >
> > Patch 3/5 uses these new APIs in bpf program and bpf dispatcher.
> >
> > Patch 4/5 and 5/5 allows static kernel text (_stext to _etext) to share
> > PMD_SIZE pages with dynamic kernel text on x86_64. This is achieved by
> > allocating PMD_SIZE pages to roundup(_etext, PMD_SIZE), and then use
> > _etext to roundup(_etext, PMD_SIZE) for dynamic kernel text.
>
> Would it be possible to have something more generic than being stuck to
> PMD_SIZE ?
>
> On powerpc 8xx, PMD_SIZE is 4MB and hugepages are 512kB and 8MB.

Currently, __vmalloc_node_range() tries to allocate huge pages when
size_per_node >= PMD_SIZE

How do we handle this in powerpc 8xx? I guess we can use the same logic
here?

Thanks,
Song
