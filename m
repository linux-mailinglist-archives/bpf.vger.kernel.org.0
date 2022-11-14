Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2539B628A72
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 21:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiKNUbF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 15:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiKNUbE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 15:31:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB50102
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:31:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBC56145C
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 20:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C101BC433C1
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 20:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668457862;
        bh=zgQp4XhE91vIyGmXpMyVsZiJPfANBzqEOoaMA7ygUl0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XkzIyf1Zp85kbVY6WLYUJWf3jjYhTfIAZw7sml4tSceIA7UHw+MCgFm0nwU/TREn8
         f/dBOio7J7O/5sa4SdhyIJmP7dRPbzTJECSF+2e3OovFIc/hGdSrPnmlJQag43A9b3
         vSvGhp0thsgu9cv1o+NLfxprN/mpOd9oMmq4AlFE+GYW+85uHmFiwPAEn7dTWjQG7p
         ONmFFzfE1m6BuWtLR4bu/xS4xDUEzxUqaNXbotxzLCcJL0PiVLpJEq5ytFotfySTMG
         jjip8zwZacUZOUIAoAbN40K2QpvA3xz70z2L7PbV7eZ630pSto3c/aio3wOLpiaSN1
         mzc7xOfxUwRCQ==
Received: by mail-ed1-f42.google.com with SMTP id z18so18986451edb.9
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:31:02 -0800 (PST)
X-Gm-Message-State: ANoB5pkWI2/xnlrXyzN6ZOaHOGlr3EXE60nGtCBXUBh/+xME6XJH6i7t
        59jG48KMEF9WhC3+slszCrchg6aEQfpE2CzGOK8=
X-Google-Smtp-Source: AA0mqf6FbNrkfPGlxAnsH2TFSgi5UFu/qy0uRw1hliM5lNSCQG4sS57dgxaoVyPr4JrPCvPFa1HA33yrBcnbXJC92Hc=
X-Received: by 2002:a50:fe13:0:b0:461:565e:8779 with SMTP id
 f19-20020a50fe13000000b00461565e8779mr12733916edt.387.1668457861058; Mon, 14
 Nov 2022 12:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org> <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
 <Y3DITs3J8koEw3Hz@kernel.org>
In-Reply-To: <Y3DITs3J8koEw3Hz@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 14 Nov 2022 12:30:49 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
Message-ID: <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
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

On Sun, Nov 13, 2022 at 2:35 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Wed, Nov 09, 2022 at 05:04:25PM +0000, Edgecombe, Rick P wrote:
> > On Wed, 2022-11-09 at 13:17 +0200, Mike Rapoport wrote:
> > > On Tue, Nov 08, 2022 at 04:51:12PM +0000, Edgecombe, Rick P wrote:
> >
> > > How the caching of large pages in vmalloc can be made useful for use
> > > cases like secretmem and PKS?
> >
> > This part is easy I think. If we had an unmapped page allocator it
> > could just feed this.
>
> The unmapped page allocator could be used by anything that needs
> non-default permissions in the direct map and knows how to map the pages
> elsewhere. E.g it would have been a oneliner to switch x86::module_alloc()
> to use unmapped allocations. But ...
>
> > Do you have any idea when you might pick up that stuff again?
>
> ... unfortunately I don't see it happening anytime soon.
>
> > To answer my own question, I think a good first step would be to make
> > the interface also work for non-text_poke() so it could really be cross
> > arch, then use it for everything except modules. The benefit to the
> > other arch's at that point is centralized handling of loading text.
>
> My concern is that the proposed execmem_alloc() cannot be used for
> centralized handling of loading text. I'm not familiar enough with
> modules/ftrace/kprobes/BPF to clearly identify the potential caveats, but
> my gut feeling is that the proposed execmem_alloc() won't be an improvement
> but rather a hindrance for moving to centralized handling of loading text.

I don't follow why this could ever be a hindrance. Luis is very excited about
this, and I am very sure it works for ftrace, kprobe, and BPF.

If there is a better API, it shouldn't be too hard to do the migration. See the
example in 3/5 of the set, where we move x86 BPF jit AND BPF dispatcher
from bpf_prog_pack to execmem_alloc():

  5 files changed, 21 insertions(+), 201 deletions(-)

It is not a one liner, but it is definitely very easy.

>
> It feels to me that a lot of ground work is needed to get to the point
> where we can use centralized handling of loading text.

Could you please be more specific on what is needed?

Thanks,
Song
