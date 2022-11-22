Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EBA633398
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiKVC4N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiKVC4M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:56:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434CF17A8A
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:56:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F29DFB81603
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B4BC433D6
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669085768;
        bh=Xg4CfovBwHPfcEYY/0bJg7qhGA+G8rcFhnJbVLO6f7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KzHwEXKmiRTZh57vql2GBr79b6ZnyVHtr0KV62S+gLWBJbg9ymaSOP1F/+DI3ypb3
         11eYxbwYcwBmHhHqJtV7fSDHKCaBiv6Md2eOk7l4agvx3b+9yh0xX6bKy1kL+wTMSX
         FHtRu1ISW47RLb8IeLbbrf+MxD28jfi3TM83jsvKnm2EIIPIC46m0yrXgXxz2iYJ7A
         vpjOsYzeowpjgZc5RfwHq5DeHjLI4V21FDXs5DpAvXujuaCo6eIQLVYI9wqu6f7WuM
         lFWaCaEkVHX1Hiwc5+UVZR8lZwwmB7ZQxxlp8yv1ESZxUazfttMEOo+gn654h5UcmQ
         AvmGgvCHBAEHw==
Received: by mail-ed1-f52.google.com with SMTP id y24so13792767edi.10
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:56:08 -0800 (PST)
X-Gm-Message-State: ANoB5plGheMPSqJbF5Sov+tPC/OXbEXghhr6skDHC9ln5yzU8TpC1V9B
        r2pGgs7xYV2VnnAbfivzcvd/FpGWbijs0NxojBs=
X-Google-Smtp-Source: AA0mqf4VFAdDOsQZGrBWiCDJ0Nmkm2LY51fkwE9aqWr9IiYlKOYmhWGHCWcgFuOHJKxCkoJ4QKHQYruWhnaWQM3/ayE=
X-Received: by 2002:aa7:d653:0:b0:469:afb9:d14c with SMTP id
 v19-20020aa7d653000000b00469afb9d14cmr4537784edr.387.1669085766996; Mon, 21
 Nov 2022 18:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20221117202322.944661-1-song@kernel.org> <20221117202322.944661-2-song@kernel.org>
 <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net> <20221121155542.GA27879@lst.de>
 <CAPhsuW7M3rAa=d4G5kzBCPofgSvKz8+Zcxg7u3+2MLMs2FTX+w@mail.gmail.com> <Y3vXorejgjSCXtt3@bombadil.infradead.org>
In-Reply-To: <Y3vXorejgjSCXtt3@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Nov 2022 19:55:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7crSUpjRbWMT6KDTXDEbJRA8YMm2akOKF6QBHP8vt5VA@mail.gmail.com>
Message-ID: <CAPhsuW7crSUpjRbWMT6KDTXDEbJRA8YMm2akOKF6QBHP8vt5VA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 12:55 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Nov 21, 2022 at 09:29:20AM -0700, Song Liu wrote:
> > On Mon, Nov 21, 2022 at 8:55 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Mon, Nov 21, 2022 at 04:52:24PM +0100, Daniel Borkmann wrote:
> > > >> +void *execmem_fill(void *dst, void *src, size_t len)
> > > >> +{
> > > >> +    return ERR_PTR(-EOPNOTSUPP);
> > > >> +}
> > > >
> > > > Don't they need EXPORT_SYMBOL_GPL, too?
> > >
> > > None of these should be exported.  Modular code has absolutely no
> > > business creating executable mappings.
> >
> > I added these exports for test_vmalloc.ko. Is there a way to only export
> > them to test_vmalloc.ko but nothing else?
>
> See EXPORT_SYMBOL_NS_GPL()

Thanks! I will take a look at this later (vacation this week).

Song
