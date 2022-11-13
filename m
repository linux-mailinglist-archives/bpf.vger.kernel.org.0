Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D54626EFF
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 11:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiKMKfO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 05:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiKMKfN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 05:35:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448F812767
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 02:35:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0D12B80B57
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 10:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31849C433C1;
        Sun, 13 Nov 2022 10:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668335709;
        bh=ufCkQX6a3GW5pk9FkMMBMqawDJUa85eoEfD8vzO4vMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjXeV1BC+cd+vWP5utBBqi51Hzk+ERy/zQ4o/9f3kKQTTxZ8p1RZOLxmxA7JRALKz
         L0t967TetfUDH04eKd7I/0nYZMkHkZ5zbpQb4umDT0bOmywxho2bmJapfhFM5aEKuv
         Qx6PIA5Lwoxfg6w2UtkN8TNskIQjYB+dDntT/jxJPiAaGb4vNI2jKcCBdIfgVoZMF+
         DETWge3vu42K7zVmOxfjsjVEPgpAfsN3k3SIE3hYO4CTh/z3QkLPIjIz6/A+B+OTH8
         Rtzy3ztHaRUSLFb+h6MnSu5tLeDNI3faBZEY9CDFyE6j7pu4CIuppR7iYZIJhPdjsc
         DsXvrGdID2xLA==
Date:   Sun, 13 Nov 2022 12:34:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3DITs3J8koEw3Hz@kernel.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org>
 <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 05:04:25PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2022-11-09 at 13:17 +0200, Mike Rapoport wrote:
> > On Tue, Nov 08, 2022 at 04:51:12PM +0000, Edgecombe, Rick P wrote:
>
> > How the caching of large pages in vmalloc can be made useful for use
> > cases like secretmem and PKS?
> 
> This part is easy I think. If we had an unmapped page allocator it
> could just feed this. 

The unmapped page allocator could be used by anything that needs
non-default permissions in the direct map and knows how to map the pages
elsewhere. E.g it would have been a oneliner to switch x86::module_alloc()
to use unmapped allocations. But ...

> Do you have any idea when you might pick up that stuff again?

... unfortunately I don't see it happening anytime soon.
 
> To answer my own question, I think a good first step would be to make
> the interface also work for non-text_poke() so it could really be cross
> arch, then use it for everything except modules. The benefit to the
> other arch's at that point is centralized handling of loading text. 

My concern is that the proposed execmem_alloc() cannot be used for
centralized handling of loading text. I'm not familiar enough with
modules/ftrace/kprobes/BPF to clearly identify the potential caveats, but
my gut feeling is that the proposed execmem_alloc() won't be an improvement
but rather a hindrance for moving to centralized handling of loading text.

It feels to me that a lot of ground work is needed to get to the point
where we can use centralized handling of loading text.

-- 
Sincerely yours,
Mike.
