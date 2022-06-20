Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E855521CD
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 18:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiFTQEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiFTQEn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 12:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B561FCFE;
        Mon, 20 Jun 2022 09:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD79C614B3;
        Mon, 20 Jun 2022 16:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0ACC341C5;
        Mon, 20 Jun 2022 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655741079;
        bh=eH2GAASlt54g98N+vPQt3HAgdfH+Rj39/LZHtqyPJGg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hnsu4BBCJ2zky9wcC/uFViHVphj2A2MpjRV6/EupRfzqi+8ZEPa2dsC45cK2A5psD
         vijAeGH9A1TgC8SpFuqH97VaF8bNuH+yWjuWaG85U+lum4BfEBdV2xDUadAKytV2nQ
         4QEDH/l/E4HGaOBoB6rl+1KITrBddWPF9ic+Rhk06MA10ABx5EVfoHDuWdXVRlMkOE
         S5xnGWOoLjbPhKtGt0+Tkwq/gCOGunDxj09k3ja7PBXCLQv4qfin+R3IzM8CG0xZhK
         cIgZC4in3kJjgI7U6Y0RZZDySg93f71s06R1ezjxfxaJqjwDzkgpKD0zUSrRGdEt1X
         L0ftpdSCIQQOw==
Received: by mail-yb1-f172.google.com with SMTP id i15so14918211ybp.1;
        Mon, 20 Jun 2022 09:04:38 -0700 (PDT)
X-Gm-Message-State: AJIora/ap3LOX2+NA+d9Bw7oCs409zESst2dIgbXJ+dZgDn+hGE9BP5V
        CrjkJyuRw9DAleLhiG6l9izX/ZF21UnfDPkIKsI=
X-Google-Smtp-Source: AGRyM1t3VYOwecfPvJe+k+RvYpPl8MpH2EqIn2VWJHKicFq3ni6wZ+GIiVERVN6Aa2escSloM2PYmanZEqga4+4KDuE=
X-Received: by 2002:a05:6902:114c:b0:641:87a7:da90 with SMTP id
 p12-20020a056902114c00b0064187a7da90mr27215793ybu.561.1655741078011; Mon, 20
 Jun 2022 09:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220520235758.1858153-1-song@kernel.org> <YrBV8darrlmUnrHR@ziqianlu-Dell-Optiplex7000>
In-Reply-To: <YrBV8darrlmUnrHR@ziqianlu-Dell-Optiplex7000>
From:   Song Liu <song@kernel.org>
Date:   Mon, 20 Jun 2022 09:03:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5oqJKHUr6wwbFyC8DFyawKr8djuv5Bjk7FEQ5dnKDGyw@mail.gmail.com>
Message-ID: <CAPhsuW5oqJKHUr6wwbFyC8DFyawKr8djuv5Bjk7FEQ5dnKDGyw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 0/8] bpf_prog_pack followup
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Aaron,

On Mon, Jun 20, 2022 at 4:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
>
> Hi Song,
>
> On Fri, May 20, 2022 at 04:57:50PM -0700, Song Liu wrote:
>
> ... ...
>
> > The primary goal of bpf_prog_pack is to reduce iTLB miss rate and reduce
> > direct memory mapping fragmentation. This leads to non-trivial performance
> > improvements.
> >
> > For our web service production benchmark, bpf_prog_pack on 4kB pages
> > gives 0.5% to 0.7% more throughput than not using bpf_prog_pack.
> > bpf_prog_pack on 2MB pages 0.6% to 0.9% more throughput than not using
> > bpf_prog_pack. Note that 0.5% is a huge improvement for our fleet. I
> > believe this is also significant for other companies with many thousand
> > servers.
> >
>
> I'm evaluationg performance impact due to direct memory mapping
> fragmentation and seeing the above, I wonder: is the performance improve
> mostly due to prog pack and hugepage instead of less direct mapping
> fragmentation?
>
> I can understand that when progs are packed together, iTLB miss rate will
> be reduced and thus, performance can be improved. But I don't see
> immediately how direct mapping fragmentation can impact performance since
> the bpf code are running from the module alias addresses, not the direct
> mapping addresses IIUC?

You are right that BPF code runs from module alias addresses. However, to
protect text from overwrites, we use set_memory_x() and set_memory_ro()
for the BPF code. These two functions will set permissions for all aliases
of the memory, including the direct map, and thus cause fragmentation of
the direct map. Does this make sense?

Thanks,
Song
