Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1864F62D575
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 09:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKQIuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 03:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiKQIuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 03:50:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB41C7B
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 00:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B8EEFCE1D76
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9D1C433D7;
        Thu, 17 Nov 2022 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668675015;
        bh=0cv6ecQvsQeiZ/g/IAt6E+nml0CMo7hBuCz/4hvUNd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXHQWEGDEbSgK4prgoQE6YqukkFtBwSq/vS1PL2LU3UceSDWQodBS44dapBqpLpAm
         kBqqoXoz4HzSKO/aT9/AV1yzgxWIbH6MMxUxWqgi38fK09mTMHcHMQAteYsF5FmSxn
         sXnTU1ALae71TKe2L3hCQoQii4JI5TtcViwdnVMf/QS27P/G2kpNMEaQ3KgKNrwVjy
         14P8+Coq1OTwErtpqMY+mUk5VldjE+g3fdrawl7+g5OE9MghnnO0dFkA3gZiRRTAAh
         2nLqkv5v1hNMWQ/SCrkQ2144oFm9jpOUc6hiYbWnZo+jgAl3FpOiANqhtA4l3vyvso
         lCBAoYREfiODQ==
Date:   Thu, 17 Nov 2022 10:50:00 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3X1uHNTLQJxmJnm@kernel.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org>
 <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
 <Y3DITs3J8koEw3Hz@kernel.org>
 <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 12:30:49PM -0800, Song Liu wrote:
> On Sun, Nov 13, 2022 at 2:35 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > My concern is that the proposed execmem_alloc() cannot be used for
> > centralized handling of loading text. I'm not familiar enough with
> > modules/ftrace/kprobes/BPF to clearly identify the potential caveats, but
> > my gut feeling is that the proposed execmem_alloc() won't be an improvement
> > but rather a hindrance for moving to centralized handling of loading text.
> 
> I don't follow why this could ever be a hindrance. Luis is very excited about
> this, and I am very sure it works for ftrace, kprobe, and BPF.

Again, it's a gut feeling. But for execmem_alloc() to be a unified place of
code allocation, it has to work for all architectures. If architectures
have to override it, then where is the unification?

The implementation you propose if great for x86, but to see it as unified
solution it should be good at least for the major architectures.

> > It feels to me that a lot of ground work is needed to get to the point
> > where we can use centralized handling of loading text.
> 
> Could you please be more specific on what is needed?

The most obvious one to implement Peter's suggestion with VM_TOPDOWN_VMAP
so that execmem_alloc() can be actually used by modules.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
