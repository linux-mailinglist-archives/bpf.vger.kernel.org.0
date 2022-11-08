Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E94621C7A
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 19:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKHSuv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 13:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKHSuY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 13:50:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D5A6DCFC
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 10:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43F4B61750
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 18:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A751AC433D7
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667933418;
        bh=zu9PMhVfzzTPBM578gdkzAALFYMkI9GwJjbL3eyvjAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y86jQbHnVfUqG1sMkGTtdBeomtv/wb2PQODh1qzPhXx7eWj4bLqsm0za77Jf2M6Mx
         PKjkEklqRZVcq283TRIz2nZyfRjafK+1zWjj2hVzWuEbSgjviV/t+agMyoQnqp1Wgj
         UDtoaJma16bxcNNTkDDlZ2E+rwWzePTfXRms9XpFplP/eB7u9oOEOKl/Kfh7kubWhQ
         QYw9wsUSp4rssTJSlbtSCGHHyrkyiK+20JUWBbNvBxRq56rA5afe3CD7RRskeOe1Op
         3xglcKn2N0aLn6oEc+VjRGWxgKSdKjx2ey/hKmt9vep3zJVPRmF8uF6aIzQ9VGds/W
         DHKNQKmRVKsKw==
Received: by mail-ej1-f51.google.com with SMTP id kt23so40957777ejc.7
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 10:50:18 -0800 (PST)
X-Gm-Message-State: ACrzQf3l4Ohve8DJr0+NdilZXB3j7pBd0/rlOyy+4xoAUB93AbQBc0J/
        m+X6DmB4MUFn57pKA/r/+XZ+mTGAdI5npwSBAjc=
X-Google-Smtp-Source: AMsMyM56A9ld/ijomWhhxZcM0Q6GqvKYUhlV48OrAak6z2K8RXAGhJXA8FLeGzN+XDmHx5xVq2WtTK4fY+TaCd2Ejuw=
X-Received: by 2002:a17:907:b602:b0:7ad:e82c:3355 with SMTP id
 vl2-20020a170907b60200b007ade82c3355mr41175687ejc.3.1667933416863; Tue, 08
 Nov 2022 10:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
In-Reply-To: <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Nov 2022 10:50:04 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5d9nbV88-KSG3qFffKJ+cnNbsq4nEOS5FwF0q9-gQuzQ@mail.gmail.com>
Message-ID: <CAPhsuW5d9nbV88-KSG3qFffKJ+cnNbsq4nEOS5FwF0q9-gQuzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rppt@kernel.org" <rppt@kernel.org>,
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

On Tue, Nov 8, 2022 at 8:51 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2022-11-08 at 13:27 +0200, Mike Rapoport wrote:
> > > Based on our experiments [5], we measured 0.5% performance
> > > improvement
> > > from bpf_prog_pack. This patchset further boosts the improvement to
> > > 0.7%.
> > > The difference is because bpf_prog_pack uses 512x 4kB pages instead
> > > of
> > > 1x 2MB page, bpf_prog_pack as-is doesn't resolve #2 above.
> > >
> > > This patchset replaces bpf_prog_pack with a better API and makes it
> > > available for other dynamic kernel text, such as modules, ftrace,
> > > kprobe.
> >
> >
> > The proposed execmem_alloc() looks to me very much tailored for x86
> > to be
> > used as a replacement for module_alloc(). Some architectures have
> > module_alloc() that is quite different from the default or x86
> > version, so
> > I'd expect at least some explanation how modules etc can use execmem_
> > APIs
> > without breaking !x86 architectures.
>
> I think this is fair, but I think we should ask ask ourselves - how
> much should we do in one step?
>
> For non-text_poke() architectures, the way you can make it work is have
> the API look like:
> execmem_alloc()  <- Does the allocation, but necessarily usable yet
> execmem_write()  <- Loads the mapping, doesn't work after finish()
> execmem_finish() <- Makes the mapping live (loaded, executable, ready)
>
> So for text_poke():
> execmem_alloc()  <- reserves the mapping
> execmem_write()  <- text_pokes() to the mapping
> execmem_finish() <- does nothing
>
> And non-text_poke():
> execmem_alloc()  <- Allocates a regular RW vmalloc allocation
> execmem_write()  <- Writes normally to it
> execmem_finish() <- does set_memory_ro()/set_memory_x() on it

Yeah, some fallback mechanism like this is missing in current version.
It is not a problem for BPF programs, as we call it from arch code.
But we do need better APIs for modules.

Thanks,
Song
>
> Non-text_poke() only gets the benefits of centralized logic, but the
> interface works for both. This is pretty much what the perm_alloc() RFC
> did to make it work with other arch's and modules. But to fit with the
> existing modules code (which is actually spread all over) and also
> handle RO sections, it also needed some additional bells and whistles.
>
> So the question I'm trying to ask is, how much should we target for the
> next step? I first thought that this functionality was so intertwined,
> it would be too hard to do iteratively. So if we want to try
> iteratively, I'm ok if it doesn't solve everything.
>
>
