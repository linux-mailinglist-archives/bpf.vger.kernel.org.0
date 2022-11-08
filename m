Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2207621EEB
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 23:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKHWPq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 17:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKHWPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 17:15:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D360693
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 14:15:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C246617B9
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 22:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745E6C4347C
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 22:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667945744;
        bh=Sw4tANTE+dawfZSjfyP+2ulbQaW96VNcPfkTetU8//8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nqqjsXfbcl6YB9Ih6IDvFHeWpOhcLLZkhJDk3ZQ4pqNaieOOapYR+0AXOd285CL0Z
         uIA+bfxino86moRCMHrkehN6HSbsDp/RGhro0TC8Z9YfWhg9mhAjOzCie1RQjQeEJV
         LGgDmMxwfeYB6MB0vclOTxOxGbO27h24hzNDeU77Nd/AyHetYSKAkknYC317uzubtZ
         RRsIYyXVphqxQ0l4dby2Q5lamHVpd+nlfutFMfClcN78E5QNybqBbMSPc6YgH4KdEF
         4BRnuJIHfVEdoFK07G9NXLTBPrtMPDhS7RnXvFKk0wRmDeqvEqeH+Zf7Nx/foKm2KT
         UBQJVROTAEJrQ==
Received: by mail-ej1-f52.google.com with SMTP id kt23so42126174ejc.7
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 14:15:44 -0800 (PST)
X-Gm-Message-State: ANoB5pmHy83BE43DEEhzm+Nur0zDWXrt2WLZdPmvFxwDuH6z4W8bfW21
        8oKckumIXMLvMAUpzp/AAv5e75suYqtKXL6aOGg=
X-Google-Smtp-Source: AA0mqf5tnnNsKl7S47XbEODY3KkyXwbDOhssxV+2Aj+ywStgbYqIfC4p6mZuEmh2qPEX8Y+PdlBa+PAhuGF0hXPDYVU=
X-Received: by 2002:a17:907:2995:b0:7ae:8956:ab56 with SMTP id
 eu21-20020a170907299500b007ae8956ab56mr1069923ejc.719.1667945742697; Tue, 08
 Nov 2022 14:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <20221107223921.3451913-6-song@kernel.org>
 <572a1977126b54f50eb69b7b2f826e271bfd42c7.camel@intel.com>
In-Reply-To: <572a1977126b54f50eb69b7b2f826e271bfd42c7.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Nov 2022 14:15:30 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6rp01kuVXq7t4ukExPJY+W+nmHcgdVON7WSH+4_W57dg@mail.gmail.com>
Message-ID: <CAPhsuW6rp01kuVXq7t4ukExPJY+W+nmHcgdVON7WSH+4_W57dg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] x86: use register_text_tail_vm
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Lu, Aaron" <aaron.lu@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 11:04 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-11-07 at 14:39 -0800, Song Liu wrote:
> > Allocate 2MB pages up to round_up(_etext, 2MB), and register memory
> > [round_up(_etext, 4kb), round_up(_etext, 2MB)] with
> > register_text_tail_vm
> > so that we can use this part of memory for dynamic kernel text (BPF
> > programs, etc.).
> >
> > Here is an example:
> >
> > [root@eth50-1 ~]# grep _etext /proc/kallsyms
> > ffffffff82202a08 T _etext
> >
> > [root@eth50-1 ~]# grep bpf_prog_ /proc/kallsyms  | tail -n 3
> > ffffffff8220f920 t
> > bpf_prog_cc61a5364ac11d93_handle__sched_wakeup       [bpf]
> > ffffffff8220fa28 t
> > bpf_prog_cc61a5364ac11d93_handle__sched_wakeup_new   [bpf]
> > ffffffff8220fad4 t
> > bpf_prog_3bf73fa16f5e3d92_handle__sched_switch       [bpf]
> >
> > [root@eth50-1 ~]#  grep 0xffffffff82200000
> > /sys/kernel/debug/page_tables/kernel
> > 0xffffffff82200000-0xffffffff82400000     2M     ro   PSE         x
> > pmd
> >
> > ffffffff82200000-ffffffff82400000 is a 2MB page, serving kernel text,
> > and
> > bpf programs.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
>
> Please update Documentation/x86/x86_64/mm.txt and teach places that
> check if an address is text about it.

For mm.rst, I got something like:

=========================== 8< ===========================

diff --git i/Documentation/x86/x86_64/mm.rst w/Documentation/x86/x86_64/mm.rst
index 9798676bb0bf..ac041b7d3965 100644
--- i/Documentation/x86/x86_64/mm.rst
+++ w/Documentation/x86/x86_64/mm.rst
@@ -62,7 +62,7 @@ Complete virtual memory map with 4-level page tables
    ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
    ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI
region mapping space
    ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
-   ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB |
kernel text mapping, mapped to physical address 0
+   ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB |
kernel and module text mapping, mapped to physical address 0
    ffffffff80000000 |-2048    MB |                  |         |
    ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB |
module mapping space
    ffffffffff000000 |  -16    MB |                  |         |
@@ -121,7 +121,7 @@ Complete virtual memory map with 5-level page tables
    ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
    ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI
region mapping space
    ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
-   ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB |
kernel text mapping, mapped to physical address 0
+   ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB |
kernel and module text mapping, mapped to physical address 0
    ffffffff80000000 |-2048    MB |                  |         |
    ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB |
module mapping space
    ffffffffff000000 |  -16    MB |                  |         |

=========================== 8< ===========================

Is this good enough?

I added extra check in is_vmalloc_or_module_addr() (4/5). Where do we need
similar logic?

Thanks,
Song
