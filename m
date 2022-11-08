Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0689A621B9D
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 19:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiKHSMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 13:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiKHSMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 13:12:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49796239F
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 10:12:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E83961732
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 18:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15EEC433D6
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 18:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931144;
        bh=RY6hGdhVKMNk7mDrbqyxiAAoWgh9KyJyl8n0r6C49LU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bixEZzSSm4AcYx09sDU5IC1kqbvjXjtrGeNgJHw+Epx/em+EVFxzQKfRpDVyRzZQB
         +FannY1ekT/eRua91MbSvW8D8uc5spXAvQnr/D1JNsD66wQaech4REjJNCyWLFNtoC
         JACtwPzQhbIZQ0pCDj56I0OK5nXOu57Twp4ujstAjFRZK4b9s5p+l48ax/XwVPiaVC
         AYNIaDQaAsnK3i++UlXHcVoyyhtAwBbL5OX4+pQiphKu1WizYt36NJl3PjUahiIPem
         fk3+tdZtlkMfZDebmY27Q4imGtQrp06HEPMRCHDQbymvus4Y/v6z49+Pfudm4F0RV3
         CTpOfafBCmEmA==
Received: by mail-ej1-f50.google.com with SMTP id m22so3546340eji.10
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 10:12:24 -0800 (PST)
X-Gm-Message-State: ACrzQf23M0mI5mbgANM9J6pYLeDn0i423V8n6k/i0/UrTA/hN1xpM8R1
        X9cOC+/Zo6nk9ASzE3+lMtwsKYozSV/Uk5i7IgY=
X-Google-Smtp-Source: AMsMyM5Xl2ZB5j2NfQzFD7QQyI0HLvMB8vt6/gVoY4xLLwotSQYoWyaLuJW9by6/deVC3FqW5cgTyaBgZ6DF2BtsM6c=
X-Received: by 2002:a17:907:b602:b0:7ad:e82c:3355 with SMTP id
 vl2-20020a170907b60200b007ade82c3355mr41055656ejc.3.1667931142987; Tue, 08
 Nov 2022 10:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2mM3eElIBmAyLko@bombadil.infradead.org>
 <CAPhsuW4fyx+Doy8gWG1x20v7FHtQ0OeMT_XOHrneAS8aXdrjuw@mail.gmail.com> <Y2mXI1WHuhRW7Jt+@bombadil.infradead.org>
In-Reply-To: <Y2mXI1WHuhRW7Jt+@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Nov 2022 10:12:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7PdQwxysTj=i9C4aOnV3PJ1DAM=Duzbke501Yc5T5Q4g@mail.gmail.com>
Message-ID: <CAPhsuW7PdQwxysTj=i9C4aOnV3PJ1DAM=Duzbke501Yc5T5Q4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        dave@stgolabs.net, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 7, 2022 at 3:39 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Nov 07, 2022 at 03:13:59PM -0800, Song Liu wrote:
> > The benchmark used here is identical on our web service, which runs on
> > many many servers, so it represents the workload that we care a lot.
> > Unfortunately, it is not possible to run it out of our data centers.
>
> I am not asking for that, I am asking for you to pick any similar
> benchark which can run in paralellel which may yield similar results.
>
> > We can build some artificial workloads and probably get much higher
> > performance improvements. But these workload may not represent real
> > world use cases.
>
> You can very likely use some existing benchmark.
>
> The direct map fragmentation stuff doesn't require much effort, as
> was demonstrated by Aaron, you can easily do that or more by
> running all selftests or just the test_bpf. This I buy.
>
> I'm not buying the iTLB gains as I can't even reproduce them myself for
> eBPF JIT, but I tested against iTLB when using eBPF JIT, perhaps you
> mean iTLB gains for other memory intensive applications running in
> tandem?

Right. In most of the cases, BPF programs are not the main workload.
The main workloads are user space services with big .text sections.
We measure performance in terms of main service throughput under
some latency requirements. For benchmarks with small .text sections,
the benefit from iTLB gains is not significant.

>
> And none of your patches mentions the gains of this effort helping
> with the long term advantage of centralizing the semantics for
> permissions on memory.

Right.. I will add that.

Thanks,
Song
