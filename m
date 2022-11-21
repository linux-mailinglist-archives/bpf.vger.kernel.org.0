Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE627632745
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiKUPEa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKUPEK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:04:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460C52EF61
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 06:52:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D5D0B81088
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 14:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4EEC43144
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669042346;
        bh=1NpqYHTbeVShPEPEVlR21hf3+Bgbo/clIJ92F4nCKL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tCwz64VxR1lUvhF/F4n7wwsQ+zPTHvMegsUftKJ13YNRHii7kvt5M1fDeH+JTRJmY
         L9oqNWQ/R3dfZlFy0/iWtwlfrQOCZg/M4cCkvqUCJNvca7SmoIWrBNx89tdarwOOKG
         sSrhGEOB3nYGVwBUzks2oGS8u9MUTBRNUBlsi4/V0OoGWGOMsggYEJr6h9+64xwZlu
         PL146feXLfWY7J1mTf0uVlTZ0VUz7hFtpE36DHUP81DnnywmvQSR6EoCoSpRY9PP0i
         eXqQEnifDXIEcPtSiYbS/S2ydO9knCmLX9Al8+C1duaL3cyzX2eJIp9BY6K885l11z
         YfYN2FZmhIyvw==
Received: by mail-ej1-f49.google.com with SMTP id ft34so29014526ejc.12
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 06:52:25 -0800 (PST)
X-Gm-Message-State: ANoB5pkhWg7tNUpZnnZdEFr7O5z3iER2SoAkpzvHFAd5AAWSM2VOU0Kg
        7gIovdL8wjRXUeC0uzvDmxVsMKZRTZW+kOk7bK8=
X-Google-Smtp-Source: AA0mqf4/CR5tEsPR5HXixifxoixQz3KKsUdB0XZlZbEJMncSS2DbWUVu0lSGcgANJX/qAKQ1DQI7mPQKMjJqWr1jNNI=
X-Received: by 2002:a17:906:fa06:b0:7ae:72ae:264b with SMTP id
 lo6-20020a170906fa0600b007ae72ae264bmr15607931ejb.301.1669042344250; Mon, 21
 Nov 2022 06:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org> <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
 <Y3DITs3J8koEw3Hz@kernel.org> <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
 <Y3X1uHNTLQJxmJnm@kernel.org> <CAPhsuW51j8P+DNXvFh4uf5Mem7=egHyYMVK7-Zq2qeFoArYREQ@mail.gmail.com>
 <Y3oEXP3UqHd1L6Z9@kernel.org>
In-Reply-To: <Y3oEXP3UqHd1L6Z9@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Nov 2022 07:52:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4ZBShuBf39TLmich0ts07zWGFuHvfAB0Jbg_bG-fjjWw@mail.gmail.com>
Message-ID: <CAPhsuW4ZBShuBf39TLmich0ts07zWGFuHvfAB0Jbg_bG-fjjWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
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

On Sun, Nov 20, 2022 at 3:41 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Thu, Nov 17, 2022 at 10:36:43AM -0800, Song Liu wrote:
> > On Thu, Nov 17, 2022 at 12:50 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Mon, Nov 14, 2022 at 12:30:49PM -0800, Song Liu wrote:
> > > > On Sun, Nov 13, 2022 at 2:35 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > >
> > > > > My concern is that the proposed execmem_alloc() cannot be used for
> > > > > centralized handling of loading text. I'm not familiar enough with
> > > > > modules/ftrace/kprobes/BPF to clearly identify the potential caveats, but
> > > > > my gut feeling is that the proposed execmem_alloc() won't be an improvement
> > > > > but rather a hindrance for moving to centralized handling of loading text.
> > > >
> > > > I don't follow why this could ever be a hindrance. Luis is very excited about
> > > > this, and I am very sure it works for ftrace, kprobe, and BPF.
> > >
> > > Again, it's a gut feeling. But for execmem_alloc() to be a unified place of
> > > code allocation, it has to work for all architectures. If architectures
> > > have to override it, then where is the unification?
> > >
> > > The implementation you propose if great for x86, but to see it as unified
> > > solution it should be good at least for the major architectures.
> >
> > As I mentioned earlier, folks are working on using bpf_prog_pack for BPF
> > JIT on powerpc. We will also work on something similar for ARM.
>
> Does "something similar" mean that it won't use execmem_alloc() as is?

"Something similar" means it will use execmem_alloc as is. We still need
changes to the ARM JIT code, just like we need it for powerpc and x86.

>
> > I guess these are good enough for major architectures?
>
> Sorry if I wasn't clear, I referred for unified solution for all code
> allocations, not only BPF, so that execmem_alloc() will eventually replace
> module_alloc(). And that means it has to be able to deal with with
> architecture specific requirements at least on ARM and powerpc, probably
> others as well.
>
> > > > > It feels to me that a lot of ground work is needed to get to the point
> > > > > where we can use centralized handling of loading text.
> > > >
> > > > Could you please be more specific on what is needed?
> > >
> > > The most obvious one to implement Peter's suggestion with VM_TOPDOWN_VMAP
> > > so that execmem_alloc() can be actually used by modules.
> >
> > Current implementation is an alternative to VM_TOPDOWN_VMAP. I am
> > very sure it works for modules just like VM_TOPDOWN_VMAP solution.
>
> It might, but it still does not. And until they do I consider these
> patches as an optimization for BFP rather than unification of code
> allocations.

We haven't got module to use execmem_alloc yet, that's true. But
this has nothing to do with VM_TOPDOWN_VMAP at all.

Thanks,
Song
