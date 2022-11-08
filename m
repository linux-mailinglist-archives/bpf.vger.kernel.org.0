Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D301D621BC5
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 19:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiKHSVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 13:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiKHSUt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 13:20:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE670572
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 10:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2843D61710
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 18:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C807C4347C
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931621;
        bh=rtPus4wZ9whzU+oiAjc7m/B0JaN/87L/+adLBYQJFzc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MSNlWyZbp7qsniT41Li6RF7wO7rjH/pZ0XuUHMv7eX7Fs3tHz8xmhzCrBdOa1x7UB
         jIhRzsNSLeImmwOnjWMTxf1FR6RCfDTGD517gU/fXZa8pjYWHUikcy17JdSLb7TLM9
         4m0SQhEyYbo/aHz/xpvalBAZqbseBvheOErOljdP6ndsW96zJ0KrgdkF+ICjk1j+q/
         BgBPgYZdUQ3nEFXcJtBqWSmdWoBTZ31OJB+Q3wQ5uEMn3M9SV8yNqME7nz+/ReznJ2
         KeZByYmQXgv84pzXbD3giU7QfP/8Or9i/JHWyvzews4L79iUiCcDWldtyYaRcCd1vA
         bAmTPUrwgta7g==
Received: by mail-ed1-f50.google.com with SMTP id 21so23818058edv.3
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 10:20:21 -0800 (PST)
X-Gm-Message-State: ACrzQf3X1GrSBsygSjucJq+9ZW3+Wh/Sldhyx6uXOXK/SAXw2ANeVnHC
        UIw9vzF75Nqos45vpbXpreOuyGav8XAitcdtOt8=
X-Google-Smtp-Source: AMsMyM6iYjvdzGHCCoS4kLmmT6doFp9ubw6Wxyr+Bo5rqVVt66t7zkg/hWKq7Dw75jbx3Y0yoVrYIUeNbxyKYF9Ql4s=
X-Received: by 2002:aa7:d710:0:b0:463:bd7b:2b44 with SMTP id
 t16-20020aa7d710000000b00463bd7b2b44mr40946450edq.385.1667931619739; Tue, 08
 Nov 2022 10:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2mM3eElIBmAyLko@bombadil.infradead.org>
 <CAPhsuW4fyx+Doy8gWG1x20v7FHtQ0OeMT_XOHrneAS8aXdrjuw@mail.gmail.com>
 <Y2mXI1WHuhRW7Jt+@bombadil.infradead.org> <dc47953aa9296d1955e41f02d4ddef06036d855c.camel@intel.com>
In-Reply-To: <dc47953aa9296d1955e41f02d4ddef06036d855c.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Nov 2022 10:20:07 -0800
X-Gmail-Original-Message-ID: <CAPhsuW55Rb+=7SawWUOM9OEcdjHfSAkT2CkknBgWj+5HPhAE0A@mail.gmail.com>
Message-ID: <CAPhsuW55Rb+=7SawWUOM9OEcdjHfSAkT2CkknBgWj+5HPhAE0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 7, 2022 at 4:13 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-11-07 at 15:39 -0800, Luis Chamberlain wrote:
> > On Mon, Nov 07, 2022 at 03:13:59PM -0800, Song Liu wrote:
> > > The benchmark used here is identical on our web service, which runs
> > > on
> > > many many servers, so it represents the workload that we care a
> > > lot.
> > > Unfortunately, it is not possible to run it out of our data
> > > centers.
> >
> > I am not asking for that, I am asking for you to pick any similar
> > benchark which can run in paralellel which may yield similar results.
> >
> > > We can build some artificial workloads and probably get much higher
> > > performance improvements. But these workload may not represent real
> > > world use cases.
> >
> > You can very likely use some existing benchmark.
> >
> > The direct map fragmentation stuff doesn't require much effort, as
> > was demonstrated by Aaron, you can easily do that or more by
> > running all selftests or just the test_bpf. This I buy.
> >
> > I'm not buying the iTLB gains as I can't even reproduce them myself
> > for
> > eBPF JIT, but I tested against iTLB when using eBPF JIT, perhaps you
> > mean iTLB gains for other memory intensive applications running in
> > tandem?
>
> Song, didn't you find that there wasn't (or in the noise) iTLB gains?
> What is this about visible performance drop from iTLB misses?
>
> IIRC there was a test done where progpack mapped things at 4k, but in
> 2MB chunks, so it would re-use pages like the 2MB mapped version. And
> it didn't see much improvement over the 2MB mapped version. Did I
> remember that wrong?

There is still a small gain (~0.2%) for this benchmark.

Thanks,
Song
>
> >
> > And none of your patches mentions the gains of this effort helping
> > with the long term advantage of centralizing the semantics for
> > permissions on memory.
>
> Another good point. Although this brings up that this interface
> "execmem" does just handle one type of permission.
