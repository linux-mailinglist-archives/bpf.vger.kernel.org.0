Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4347E53369D
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 08:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbiEYGB7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 May 2022 02:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiEYGB6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 May 2022 02:01:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943F2C674;
        Tue, 24 May 2022 23:01:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70C24227EE6; Wed, 25 May 2022 08:01:43 +0200 (CEST)
Date:   Wed, 25 May 2022 08:01:42 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "hch@lst.de" <hch@lst.de>, "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Message-ID: <20220525060142.GB10762@lst.de>
References: <20220520031548.338934-1-song@kernel.org> <20220520031548.338934-6-song@kernel.org> <Yog5yXqAQZAmpgCD@bombadil.infradead.org> <17c6110273d59e3fdeea3338abefac03951ff404.camel@intel.com> <YolGU5JGE9NVrrrc@bombadil.infradead.org> <a634037bb023973b8263a65b93fa73a7a5c0dc52.camel@intel.com> <Yo1XTN441qbNTLGR@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo1XTN441qbNTLGR@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 24, 2022 at 03:08:12PM -0700, Luis Chamberlain wrote:
> > A rename seems good to me. Module space is really just dynamically
> > allocated text space now. There used to be a vmalloc_exec() that
> > allocated text in vmalloc space, 
> 
> Yes I saw that but it was generic and it did not do the arch-specific
> override, and so that is why Christoph ripped it out and open coded
> it on the only user, on module_alloc().

It it also because random code does not have any business allocating
executable memory.  Executable memory in kernel is basically for
modules and module-like code like eBPF, and no one else has any business
allocating pages with the execute bit set (or the NX bit not set).
