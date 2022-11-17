Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE762D38C
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 07:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiKQGlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 01:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiKQGly (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 01:41:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E256B641E
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 22:41:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F03620C0
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 06:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77C6C433D7
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668667312;
        bh=SnM1FtaUeYJRRujlQeq7IpO09wMHia8NIW6nScFy+Yk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lR2uSQSLMbkLlDIdci5fHU2CqkE26dSgsm53aDbD6ZSbeOtrue123LXuBXxywnpc6
         306ifrECApgVXR37NGfiJEwbSjk1ZVja+hMoE46LdSDjyH+ZknYaCG0deIDh+d59hm
         FMXbIz+uDcshbuqKqNr4gP1Zar05W62lkVooSnYdUi1ZeTcSg5s6WNtJJBqWPX/g2J
         8DVtOoCGsr9grXAEBeO+7lxRJC0lbdHqLkvmT7JS1k1ce4Eink4c0ofypAzbyRCHnS
         Q+rV/PL8VdMRPD+7gLhh/XiX3/ZRvLNZEX6iyA26i+e8Yd+qHaz09MQXRIgJRcFAzp
         MvwIN7cSQrvxw==
Received: by mail-ej1-f46.google.com with SMTP id i10so2706488ejg.6
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 22:41:52 -0800 (PST)
X-Gm-Message-State: ANoB5pkzoTCcoSQO2RYN2tWNRWyDS8s341sAwXGcYzkJKeF0QHm80DaX
        TZBUhyk29CUJvQ1xqY07hENcpzWVvdUPAOZmkHo=
X-Google-Smtp-Source: AA0mqf4bYESblYKqNvg1KhBn6PnowkzN8+8DYXrdRYkkDaK7WC+mrWvXPaKn/zyhLM+LsjdcuzoQ2HrORRyBF/zrMQk=
X-Received: by 2002:a17:906:348b:b0:78d:9e04:d8c2 with SMTP id
 g11-20020a170906348b00b0078d9e04d8c2mr928422ejb.614.1668667311120; Wed, 16
 Nov 2022 22:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20221117010621.1891711-1-song@kernel.org> <20221117010621.1891711-4-song@kernel.org>
 <Y3WTIdYY7Vsc5QXH@bombadil.infradead.org>
In-Reply-To: <Y3WTIdYY7Vsc5QXH@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 16 Nov 2022 22:41:39 -0800
X-Gmail-Original-Message-ID: <CAPhsuW43EXLV4bopzgZa=wFeDqy8GD0P7e=18w30D_X4fLw=fQ@mail.gmail.com>
Message-ID: <CAPhsuW43EXLV4bopzgZa=wFeDqy8GD0P7e=18w30D_X4fLw=fQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] selftests/vm: extend test_vmalloc to test
 execmem_* APIs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 5:49 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 05:06:18PM -0800, Song Liu wrote:
> > Add logic to test execmem_[alloc|fill|free] in test_vmalloc.c.
> > No need to change tools/testing/selftests/vm/test_vmalloc.sh.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  lib/test_vmalloc.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> > index cf7780572f5b..6591c4932c3c 100644
> > --- a/lib/test_vmalloc.c
> > +++ b/lib/test_vmalloc.c
> > @@ -50,6 +50,7 @@ __param(int, run_test_mask, INT_MAX,
> >               "\t\tid: 128,  name: pcpu_alloc_test\n"
> >               "\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
> >               "\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
> > +             "\t\tid: 1024, name: execmem_alloc_test\n"
> >               /* Add a new test case description here. */
> >  );
> >
> > @@ -352,6 +353,34 @@ kvfree_rcu_2_arg_vmalloc_test(void)
> >       return 0;
> >  }
> >
> > +static int
> > +execmem_alloc_test(void)
> > +{
> > +     void *p, *tmp;
> > +     int i;
> > +
> > +     for (i = 0; i < test_loop_count; i++) {
> > +             /* allocate variable size, up to 64kB */
> > +             size_t size = (i % 1024 + 1) * 64;
> > +
> > +             p = execmem_alloc(size, 64);
> > +             if (!p)
> > +                     return -1;
> > +
> > +             tmp = execmem_fill(p, "a", 1);
> > +             if (tmp != p)
> > +                     return -1;
> > +
> > +             tmp = execmem_fill(p + size - 1, "b", 1);
> > +             if (tmp != p + size - 1)
> > +                     return -1;
> > +
> > +             execmem_free(p);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
> This is a basic test and it is useful.
>
> But given all those WARN_ON() and WARN_ON_ONCE() I think the real value
> test here would be to race 1000 threads doing this at the same time.

test_vmalloc supports parallel tests. We can do something like

  tools/testing/selftests/vm/test_vmalloc.sh nr_threads=XXX run_test_mask=1024

Thanks,
Song
