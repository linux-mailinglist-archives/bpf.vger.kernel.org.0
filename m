Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57740628A3C
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 21:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiKNUNb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 15:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNUNb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 15:13:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27033DE0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:13:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2DB5B81200
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 20:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89440C433B5
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668456806;
        bh=evWACerkMgPDV2iTZqsEi8ywuNBzXAvxPW2Xk8G2OBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C65L8kYtUw2wQtwX+8t8BIb91ZDeXHBRWBps4GPdZ/BWu/hQGauagjA2DGsLyrBnM
         ETfRraPQMVzI2QM8Rq8kj2fltQZ+SbbV4UeDD+rQ2ojCzAi4MAHdFpnRR0jRXpOq40
         vToOftpvY3fEeUxctQRx2vHCuU84f5+onNEGbS0DpGbaZ5DoW86dhQwpPnLurEhdTk
         dZWekuVpCYo/IEHkiM7cUz3jUlOYQ3eGSU31juIIjx2Jj6l4rbtanaPPO1kDYcTiwo
         ke+t+RCb8pmOKzZk43wYI3uVgb1RrVm49rwMrKnX02hY8c2JpZ9kKst0i3k7xGRDIM
         ozyEJxISzzI1A==
Received: by mail-ej1-f49.google.com with SMTP id f5so31104574ejc.5
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:13:25 -0800 (PST)
X-Gm-Message-State: ANoB5pm/ScrsbLiBhIUozAFFbnSqPTwNJZPewH02U+z4AzphBqFCjAVR
        WtrNVAtcU0FvfzuhJXCYSMw8JsJRwO2eGtCDkdU=
X-Google-Smtp-Source: AA0mqf7ENa/NO+V3ctrhT8zWG2na9i2XUmqqM9TNRdX64zkoNebB/7px/ngcBRNTKeo5RRwFgFU9PJ8Z64UIfAUao0w=
X-Received: by 2002:a17:907:1308:b0:7af:bc9:5e8d with SMTP id
 vj8-20020a170907130800b007af0bc95e8dmr2955180ejb.3.1668456803725; Mon, 14 Nov
 2022 12:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org>
 <CAPhsuW7xtUKb7ovjLFDPap-_t1TzPZ0Td+kHparOniZf7cBCSQ@mail.gmail.com> <Y3C/4Y5bt5eXadzJ@kernel.org>
In-Reply-To: <Y3C/4Y5bt5eXadzJ@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 14 Nov 2022 12:13:11 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6Opkg0_qc53jQ3RyN5XKB2i3X3qNfoXLNrmUbD3AzcFA@mail.gmail.com>
Message-ID: <CAPhsuW6Opkg0_qc53jQ3RyN5XKB2i3X3qNfoXLNrmUbD3AzcFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 13, 2022 at 1:59 AM Mike Rapoport <rppt@kernel.org> wrote:
[...]
> >
> > There will be some memory waste in such cases. But it will get better with:
> > 1) With 4/5 and 5/5, BPF programs will share this 2MB page with kernel .text
> > section (_stext to _etext);
> > 2) modules, ftrace, kprobe will also share this 2MB page;
>
> Unless I'm missing something, what will be shared is the virtual space, the
> actual physical pages will be still allocated the same way as any vmalloc()
> allocation.

What do you mean by shared virtual space, but the actual physical pages are
still the same? This is a 2MB page shared by BPF programs, modules, etc.,
so it is 2MB virtual address space, and it is also 1x 2MB physical huge page.
For example, we will allocate one 2MB page, and put 1MB of module text,
512kB of BPF programs, some ftrace trampolines in this page.

>
> > 3) There are bigger BPF programs in many use cases.
>
> With statistics you provided above one will need hundreds if not thousands
> of BPF programs to fill a 2M page. I didn't do the math, but it seems that
> to see memory savings there should be several hundreds of BPF programs.

powerpc is trying to use bpf_prog_pack [1]. IIUC, execmem_alloc() should
allocate 512kB pages for powerpc. This already yielding memory savings:
on a random system in our fleet (x86_64), BPF programs use 140x 4kB
pages (or 560kB) without execmem_alloc(). They will fit in 200kB with
execmem_alloc(), and we can use the other 300kB+ for modules, ftrace,
etc.

OTOH, 512kB or even 2MB is really small for module systems, but iTLB
is always a limited resource.

Thanks,
Song

[1] https://lore.kernel.org/bpf/20221110184303.393179-1-hbathini@linux.ibm.com/
