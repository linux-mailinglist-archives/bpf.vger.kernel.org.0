Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A78634269
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 18:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiKVRZf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 12:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKVRZe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 12:25:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F27AF7A
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 09:25:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA03F617FB
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D5CC43141
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669137933;
        bh=VM9i9Sod3WvClpx7R7d+pIh0KgJHYrQCQolQpWbO6wY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jiH5WHaXdwt+bcX8DvZqltEievfFJ/q9fJflcGNJcsyRN4kd8u/Xo8amsxs8vJygV
         jPa/K3ffFnHuDBQsDDTp4STiXyEDTwlYz2rWdLcAM84dbvoH0Y8S7HQoJY7lg5ymgg
         TZi3SpF55QRSkTanVE32bI5Jss8c35IZ2EvSp+/wpq+OV8VAYtq4vo64RT8G809fI6
         UXbiaWbKqpFHh9IE0uZa/Is/LgIFHLtYAqCk5zKjwnLdhb4xJE+z749pf8JthpurRJ
         Kxbh+UD+xfc0S8OiUiphkc2dqN8mLXhbj0kzVIobQ9S2mzL8JD/yj5N7k27Dqx38MG
         TQsy0NSMHmc9A==
Received: by mail-ed1-f51.google.com with SMTP id z18so21572309edb.9
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 09:25:32 -0800 (PST)
X-Gm-Message-State: ANoB5pna/pS53HpQRKc5Ma1KMwIQopfavlGnQW3RUWcwRgFj54I/i/W2
        idaufTSnpZIYvKQVDAYOBQQ0QNSpnpnmtg/c0AA=
X-Google-Smtp-Source: AA0mqf5U4VZ/cBhf7Y1g/KApCfEeUxJUOaXhC6k8PmqXpJvzm9Po3V+AtvIIc2RVxVmMpQADCGVXwgAE/y0fjLOk4UQ=
X-Received: by 2002:a50:ff08:0:b0:461:dbcc:5176 with SMTP id
 a8-20020a50ff08000000b00461dbcc5176mr9778489edu.53.1669137931301; Tue, 22 Nov
 2022 09:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20221117202322.944661-1-song@kernel.org> <20221117202322.944661-2-song@kernel.org>
 <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net> <20221121155542.GA27879@lst.de>
 <CAPhsuW7M3rAa=d4G5kzBCPofgSvKz8+Zcxg7u3+2MLMs2FTX+w@mail.gmail.com>
 <Y3vXorejgjSCXtt3@bombadil.infradead.org> <20221122061323.GA14204@lst.de>
In-Reply-To: <20221122061323.GA14204@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 22 Nov 2022 10:25:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7AcBtLKd8hpBdsroGtfZ1UbbUE=xsE6WDZD-ZFHK4idQ@mail.gmail.com>
Message-ID: <CAPhsuW7AcBtLKd8hpBdsroGtfZ1UbbUE=xsE6WDZD-ZFHK4idQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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

On Mon, Nov 21, 2022 at 11:13 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 21, 2022 at 11:55:14AM -0800, Luis Chamberlain wrote:
> > > I added these exports for test_vmalloc.ko. Is there a way to only export
> > > them to test_vmalloc.ko but nothing else?
> >
> > See EXPORT_SYMBOL_NS_GPL()
>
> No, that is in no way limiting who uses it, it just makes them go
> through extra hoops.
>
> The funtionality to allocate exectuable memory is highly dangerous
> and absolutely must be limited to built-in code.
>
> So the tests should just be forced to be built-in here as well.

I guess we can use some debug macro similar to
DEBUG_AUGMENT_LOWEST_MATCH_CHECK to gate
test_vmalloc.ko?

Otherwise, we can just drop the changes to test_vmalloc.c.

Thanks,
Song
