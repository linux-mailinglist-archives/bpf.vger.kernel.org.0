Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3364162CD4D
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 23:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKPWEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 17:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiKPWEC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 17:04:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DBD25E2
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 14:04:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EB9661FF1
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 22:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71950C433C1
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 22:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668636240;
        bh=bwpmxQtSrtsqOyNAPxt9ZlaY6Emk95Zlx+kQIcsOSAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e1NmVpp7FuKV5DsiIzj/9xGdNrLWtZLXaPNDRftQuojcm/WQzV2U16HsgKLY1s0rT
         NsMUdeNQkNQplFSdW137vywhwbegW5TX3es9TZ23egE5x6mevCaxfF+Yf6ei48Y8SI
         I40zVEZJW0S8j5PoiD+Leqqn9UDyb1DrKJIXytCYpPG3nqhTbqe1l1VVUG1Ko+wfX5
         PBLTy3qLZu7FAVWl9IDGaMrk7YEH8u1L2TI6FwSaY6exAhTuDxYMMEFl3Q+BDKAzyv
         0+0AkEFCDnkiCeJvbDXa3NoUV/maB+zeslDN8mq5jdfQmQ/RDhm4llusAhan0UI6Ac
         uLWruwAeI5rxA==
Received: by mail-ed1-f53.google.com with SMTP id x102so13562818ede.0
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 14:04:00 -0800 (PST)
X-Gm-Message-State: ANoB5pnfdf+zeq6Zk3iZWaIxkp4SGicXHIurMdqlXn1mgrq+A6PyUm1U
        W51EVrbLwKgE12f3jqIy6fuGEW2DEYFoQ0oiD5k=
X-Google-Smtp-Source: AA0mqf7P4Ff+/DhonOZSGTiSY7bUxCW4GolO70BxnS/8sxv6/4l1Nv+QPD+JZD28zcvmQcigaYEG6UGNFJcNCTZbAf0=
X-Received: by 2002:aa7:c6d9:0:b0:462:2c1c:8791 with SMTP id
 b25-20020aa7c6d9000000b004622c1c8791mr21150173eds.29.1668636238649; Wed, 16
 Nov 2022 14:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <c7e9bbf45b2d52253fec16525645bda0887a9cf9.camel@intel.com>
 <CAPhsuW7H95hUUCGEk9etwTT8kYRCKCtD6Lo+8WxHUyGTKSyEFA@mail.gmail.com>
 <4bf1a1377ea39f287a4fd438d81f314d261f7d7f.camel@intel.com>
 <CAPhsuW60U0n-szdD9AO214zk5GHscZ6jnxBoh7_HBcfYw6fdSQ@mail.gmail.com> <a69ceba66135b0713c29a49fe84751274fefd722.camel@intel.com>
In-Reply-To: <a69ceba66135b0713c29a49fe84751274fefd722.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 16 Nov 2022 14:03:46 -0800
X-Gmail-Original-Message-ID: <CAPhsuW52hvrHiDx2aKFEbkumD7bYCYOfv97Q0JraJT47y4D8fw@mail.gmail.com>
Message-ID: <CAPhsuW52hvrHiDx2aKFEbkumD7bYCYOfv97Q0JraJT47y4D8fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
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

On Wed, Nov 16, 2022 at 1:22 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2022-11-15 at 17:20 -0800, Song Liu wrote:
> > To clarify, are you suggesting we need this logic in this set? I
> > would
> > rather wait until we handle module code. This is because BPF JIT uses
> > module_alloc() for archs other than x86_64. So the fall back of
> > execmem_alloc() for these archs would be module_alloc() or
> > something similar. I think it is really weird to do something like
> >
> > void *execmem_alloc(size_t size)
> > {
> > #ifdef CONFIG_SUPPORT_EXECMEM_ALLOC
> >     ...
> > #else
> >     return module_alloc(size);
> > #endif
> > }
> >
> > WDYT?
>
> Hmm, that is a good point. It looks like it's plugged in backwards.
>
> Several people in the past have expressed that all the text users
> calling into *module*_alloc() also is a little wrong. So I think in
> some finished future, each architecture would have an execmem_alloc()
> arch breakout of some sort that modules could use instead of it's
> module_alloc() logic. So basically all the module_alloc() arch
> specifics details of location and PAGE_FOO would move to execmem.
>
> I guess the question is how to get there. Calling into module_alloc()
> does the job but looks wrong. There are a lot of module_alloc()s, but
> what about implementing an execmem_alloc() for each bpf jit
> architecture that doesn't match the existing default version. It
> shouldn't be too much code. I think some of them will work with just
> the  EXEC_MEM_START/END heuristic and wont need a breakout.
>
> But if this thing just works for x86 BPF JITs, I'm not sure we can say
> we have unified anything...

powerpc BPF JIT is getting bpf_prog_pack soon. [1] And we should
be able to make ftrace and BPF trampoline to use execmem_alloc
soon after this set is merged. AFAICT, we don't have to finalize the
API until we handle module text. I personally think current API is
good enough for ftrace and BPF trampoline, which already use
something similar to JIT.

Thanks,
Song

[1] https://lore.kernel.org/bpf/20221110184303.393179-1-hbathini@linux.ibm.com/
