Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0B552986
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 04:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiFUCvl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 22:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiFUCvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 22:51:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8C1DA68;
        Mon, 20 Jun 2022 19:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD318B811BD;
        Tue, 21 Jun 2022 02:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D80CC385A2;
        Tue, 21 Jun 2022 02:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655779895;
        bh=irQwJk9q3lj6Mb5+MUo1cwVgd5N9WsMo25ESc2zJ6J0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u9DRq3KoIUNrONpYTo1qOYf+0isutq+d5XZWuib5HhoWZ/ihZ99wcxCi7oWYJN3io
         isOYv+aPiOknPA+T6J5of/banzXpnT+DUA0R+te1QsGV431NTk9fEOliNr9WwZ0Oaq
         BeI3JLdUZHhHAWnaEdCNNbROimEc0V+J9i1OKGjvpIjeZ2cPY12ZGTjhUDD5y1zpl8
         TxwbfpliGoYEc17Y9PkG5LK7Nh2aJPy7a2jLouLvCAlL12UuojjnvVvPBToyzx47PX
         LWupqkzWE01Cu2zAsshPpkQN+kFAQckBkHgMXTVSJGdSwk50Aa30j4KNwUPmpSP+Xa
         n90pycj5G7oAg==
Received: by mail-yb1-f172.google.com with SMTP id i7so4525199ybe.11;
        Mon, 20 Jun 2022 19:51:35 -0700 (PDT)
X-Gm-Message-State: AJIora8Q9l5hXp6WOfZYftACKy4tUDuplzx+0SNK1bEvLZYRnH5Ks7cm
        MSZEh7LLrrqBT6+Lqy8dgK6ZZ/i65n38WQbutik=
X-Google-Smtp-Source: AGRyM1tXaEkWud44fl8OhCVPrRToQwsjs7ndHVzk7shodMzOvpkTKmiKcC4qpJLkG3P+e8gCuTh7QgATXlGGDBChqOE=
X-Received: by 2002:a05:6902:b:b0:668:e2a0:5c2 with SMTP id
 l11-20020a056902000b00b00668e2a005c2mr13741839ybh.389.1655779894668; Mon, 20
 Jun 2022 19:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220520235758.1858153-1-song@kernel.org> <YrBV8darrlmUnrHR@ziqianlu-Dell-Optiplex7000>
 <CAPhsuW5oqJKHUr6wwbFyC8DFyawKr8djuv5Bjk7FEQ5dnKDGyw@mail.gmail.com> <YrEfghUwr+IO2MM1@ziqianlu-Dell-Optiplex7000>
In-Reply-To: <YrEfghUwr+IO2MM1@ziqianlu-Dell-Optiplex7000>
From:   Song Liu <song@kernel.org>
Date:   Mon, 20 Jun 2022 19:51:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4eAm9QrAxhZMJu-bmvHnjWjuw86gFZzTHRaMEaeFhAxw@mail.gmail.com>
Message-ID: <CAPhsuW4eAm9QrAxhZMJu-bmvHnjWjuw86gFZzTHRaMEaeFhAxw@mail.gmail.com>
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

On Mon, Jun 20, 2022 at 6:32 PM Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Mon, Jun 20, 2022 at 09:03:52AM -0700, Song Liu wrote:
> > Hi Aaron,
> >
> > On Mon, Jun 20, 2022 at 4:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> > >
> > > Hi Song,
> > >
> > > On Fri, May 20, 2022 at 04:57:50PM -0700, Song Liu wrote:
> > >
> > > ... ...
> > >
> > > > The primary goal of bpf_prog_pack is to reduce iTLB miss rate and reduce
> > > > direct memory mapping fragmentation. This leads to non-trivial performance
> > > > improvements.
> > > >
> > > > For our web service production benchmark, bpf_prog_pack on 4kB pages
> > > > gives 0.5% to 0.7% more throughput than not using bpf_prog_pack.
> > > > bpf_prog_pack on 2MB pages 0.6% to 0.9% more throughput than not using
> > > > bpf_prog_pack. Note that 0.5% is a huge improvement for our fleet. I
> > > > believe this is also significant for other companies with many thousand
> > > > servers.
> > > >
> > >
> > > I'm evaluationg performance impact due to direct memory mapping
> > > fragmentation and seeing the above, I wonder: is the performance improve
> > > mostly due to prog pack and hugepage instead of less direct mapping
> > > fragmentation?
> > >
> > > I can understand that when progs are packed together, iTLB miss rate will
> > > be reduced and thus, performance can be improved. But I don't see
> > > immediately how direct mapping fragmentation can impact performance since
> > > the bpf code are running from the module alias addresses, not the direct
> > > mapping addresses IIUC?
> >
> > You are right that BPF code runs from module alias addresses. However, to
> > protect text from overwrites, we use set_memory_x() and set_memory_ro()
> > for the BPF code. These two functions will set permissions for all aliases
> > of the memory, including the direct map, and thus cause fragmentation of
> > the direct map. Does this make sense?
>
> Guess I didn't make it clear.
>
> I understand that set_memory_XXX() will cause direct mapping split and
> thus, fragmented. What is not clear to me is, how much impact does
> direct mapping fragmentation have on performance, in your case and in
> general?
>
> In your case, I guess the performance gain is due to code gets packed
> together and iTLB gets reduced. When code are a lot, packing them
> together as a hugepage is a further gain. In the meantime, direct
> mapping split (or not) seems to be a side effect of this packing, but it
> doesn't have a direct impact on performance.
>
> One thing I can imagine is, when an area of direct mapping gets splited
> due to permission reason, when that reason is gone(like module unload
> or bpf code unload), those areas will remain fragmented and that can
> cause later operations that touch these same areas using more dTLBs
> and that can be bad for performance, but it's hard to say how much
> impact this can cause though.

Yes, we have data showing the direct mapping remaining fragmented
can cause non-trivial performance degradation. For our web workload,
the difference is in the order of 1%.

Thanks,
Song
