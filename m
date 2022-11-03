Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA89618CD4
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 00:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiKCXdc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 19:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKCXd2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 19:33:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D441860DA
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B+WVJtSG9qilNfBnLbjB8IaNTAyS5PzrTs5MgsZSZYs=; b=P8H1AhXnqQyG/LassE8lRajXwF
        39yup/eNw16yNohyv8dcUTUv9FSTUtyvVpNQMBSiHxkY6hmzViWt0q4ujCPRqnIdlma3HTTdEu56o
        CVErC0yb+O4GENELS9Hr4Fdf6iV0NGSTHamHmBAxaaNYBLUfcqFNS49BiEZcaj2O25/0nWmJGfpby
        rYllsSN9Gm+OcF1anor+fVZLKQwVrvO7cmbKMYsp4QqekQTPv6qkL6L93B7v6g4uogW79+vw54YR2
        Og9CAdgU1ki7F7CaSyavdGzEamgXWpLevaWw4LAiO5S5sGVhYvPexYHJ5/Q9xQgwzwL4yFPBEJG9K
        kRdCzabw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqji5-001ygZ-Lx; Thu, 03 Nov 2022 23:33:21 +0000
Date:   Thu, 3 Nov 2022 16:33:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Message-ID: <Y2RPwRQj9etaokIj@bombadil.infradead.org>
References: <20221031222541.1773452-1-song@kernel.org>
 <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org>
 <Y2Pjnd3mxA9fTlox@kernel.org>
 <Y2QPpODzdP+2YSMN@bombadil.infradead.org>
 <eac58f163bd8b6829dff176e67b44c79570025f5.camel@intel.com>
 <CAPhsuW4sYOzdkzpX5=5FBs3dF2DiXyNvRQC0jHnrMQFy5-mUhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4sYOzdkzpX5=5FBs3dF2DiXyNvRQC0jHnrMQFy5-mUhg@mail.gmail.com>
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

On Thu, Nov 03, 2022 at 02:41:42PM -0700, Song Liu wrote:
> On Thu, Nov 3, 2022 at 2:19 PM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
> Besides the motivation improvement, could you please also share your
> comments on:
> 1. The logic/design of the vmalloc_exec() et. al. APIs;

I've provided the feedback that I can so far as I'm new to mm.
Best I can do is provided a better rationale so that mm folks
can understand the motivation.

> 2. The naming of these functions. Does  execmem_[alloc|free|fill|cpy]
>   (as suggested by Chritoph) sound good?

That seems sensible.

There may be other users later, secmm_alloc() too then later, for
instance. So we just gotta keep that in mind.

  Luis
