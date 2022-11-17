Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705E062E598
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 21:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbiKQUEq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 15:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbiKQUEo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 15:04:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1747A34E
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sO4Nog/bmEZybH4emg+O8TQHyWHaCEr7UrYdQK0Zg2I=; b=PqWopkTilfYrrsHB9/FZXh1wZ5
        +bJUygVL+Yi75SFwEc+L/NNWFZUKUQ8amoefe9A5OrFQuY+3d6WRmB0qi+TM8S0uPQSG2b0dFa4ja
        lUkoRF5WgZGKt7zVPh+lQzymqEHpmlJayOWGUuJNZ1KmzPBmN+dR/SA+0aCDAkAmLapTnZoxUccRV
        H6wMJMTmDwqwSLQ7Tsls+qwwzstfvfUMdRUUr4Ol0ZcS+YlB/wFhyi7eYFo+a03lh999O7AHvuYPa
        HArpGc5JKKShw/RvVHTiU58YUb2hKrsiQ796NEvzT3q5zvZBjJMbPL2Qt+xGQye3X6tm5hFJEjZjU
        rGgMeJvA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovl7q-00H5Ma-4m; Thu, 17 Nov 2022 20:04:42 +0000
Date:   Thu, 17 Nov 2022 12:04:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v3 3/6] selftests/vm: extend test_vmalloc to
 test execmem_* APIs
Message-ID: <Y3aT2i1iuFAcOFzj@bombadil.infradead.org>
References: <20221117010621.1891711-1-song@kernel.org>
 <20221117010621.1891711-4-song@kernel.org>
 <Y3WTIdYY7Vsc5QXH@bombadil.infradead.org>
 <CAPhsuW43EXLV4bopzgZa=wFeDqy8GD0P7e=18w30D_X4fLw=fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW43EXLV4bopzgZa=wFeDqy8GD0P7e=18w30D_X4fLw=fQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 10:41:39PM -0800, Song Liu wrote:
> On Wed, Nov 16, 2022 at 5:49 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Nov 16, 2022 at 05:06:18PM -0800, Song Liu wrote:
> > > Add logic to test execmem_[alloc|fill|free] in test_vmalloc.c.
> > > No need to change tools/testing/selftests/vm/test_vmalloc.sh.
> > >
> > > Signed-off-by: Song Liu <song@kernel.org>
> > > ---
> > >  lib/test_vmalloc.c | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >
> > > diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> > > index cf7780572f5b..6591c4932c3c 100644
> > > --- a/lib/test_vmalloc.c
> > > +++ b/lib/test_vmalloc.c
> > > @@ -50,6 +50,7 @@ __param(int, run_test_mask, INT_MAX,
> > >               "\t\tid: 128,  name: pcpu_alloc_test\n"
> > >               "\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
> > >               "\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
> > > +             "\t\tid: 1024, name: execmem_alloc_test\n"
> > >               /* Add a new test case description here. */
> > >  );
> > >
> > > @@ -352,6 +353,34 @@ kvfree_rcu_2_arg_vmalloc_test(void)
> > >       return 0;
> > >  }
> > >
> > > +static int
> > > +execmem_alloc_test(void)
> > > +{
> > > +     void *p, *tmp;
> > > +     int i;
> > > +
> > > +     for (i = 0; i < test_loop_count; i++) {
> > > +             /* allocate variable size, up to 64kB */
> > > +             size_t size = (i % 1024 + 1) * 64;
> > > +
> > > +             p = execmem_alloc(size, 64);
> > > +             if (!p)
> > > +                     return -1;
> > > +
> > > +             tmp = execmem_fill(p, "a", 1);
> > > +             if (tmp != p)
> > > +                     return -1;
> > > +
> > > +             tmp = execmem_fill(p + size - 1, "b", 1);
> > > +             if (tmp != p + size - 1)
> > > +                     return -1;
> > > +
> > > +             execmem_free(p);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> >
> > This is a basic test and it is useful.
> >
> > But given all those WARN_ON() and WARN_ON_ONCE() I think the real value
> > test here would be to race 1000 threads doing this at the same time.
> 
> test_vmalloc supports parallel tests. We can do something like
> 
>   tools/testing/selftests/vm/test_vmalloc.sh nr_threads=XXX run_test_mask=1024

Nice, if that is not run by default we won't capture issues which may
arise on selftests on 0day.

  Luis
