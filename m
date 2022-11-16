Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F46262CDBC
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 23:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiKPWeS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 17:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiKPWeR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 17:34:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76804D5F3
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 14:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TSs/h9541uqf1HTxWzDvsef/ZgrLLRZbCCbFUZGOXH0=; b=Q3lO0FlYjsfHxxN9OkYNI6ATLL
        Oho2D0cTvZvi7wpxPauyY0zeEq/2JdJ/I3dMCjlnoV5bpZIb/mQAZs3SQDPxR9/qytodi2tKqtjLp
        fd/83AyWv4ynrD/YvHYfnGvIycxb+bGyWFQG/thfITBYO+k5OV0F5edz1J3IEnjd14m/eSUrReoPf
        MW7RSDy7yC/J4O5xDNOX5IQmXFNyhqbZLFl8hNXqC6AnyA7fCN/fy9usFD5VRCgT6DGx0kDVMGUOU
        Yh65IKEryi9JvDX7Qim84wetOYUV9rRnN6Twd9haqVhNUV0oEVvj4stzOmhuFffNOXlmzHhFn9PUP
        A05/D+Eg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovQyz-008PRr-PD; Wed, 16 Nov 2022 22:34:13 +0000
Date:   Wed, 16 Nov 2022 14:34:13 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "song@kernel.org" <song@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3VlZVZRrFbsTIIq@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org>
 <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
 <Y3DITs3J8koEw3Hz@kernel.org>
 <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
 <Y3QCNCNW31lB37El@bombadil.infradead.org>
 <a0bea8c90acc70bc67210eb890447d51fb7315de.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0bea8c90acc70bc67210eb890447d51fb7315de.camel@intel.com>
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

On Tue, Nov 15, 2022 at 09:39:08PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-11-15 at 13:18 -0800, Luis Chamberlain wrote:
> > The main hurdles for modules are:
> > 
> >   * x86 needs support for CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> >     to use this properly
> >   * in light of lack of support for
> > CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> >     we need a fallback
> >   * today module_alloc() follows special hanky panky open coded
> > semantics for
> >     special page permissions, a unified way to handle this would be
> >     ideal instead of expecting everyone to get it right.
> 
> How were you thinking non-text_poke() architectures load their text
> into the text region without the fallback method?

Fallbacks are needed for sure. I think you spelled out well what would
be needed.

  Luis
