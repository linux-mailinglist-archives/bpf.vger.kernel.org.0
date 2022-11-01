Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AF0614879
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 12:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKAL0s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 07:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAL0r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 07:26:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107617E21
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 04:26:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EB276732D; Tue,  1 Nov 2022 12:26:43 +0100 (CET)
Date:   Tue, 1 Nov 2022 12:26:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, dave.hansen@intel.com,
        mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v1 RESEND 0/5] vmalloc_exec for modules and
 BPF programs
Message-ID: <20221101112642.GB14379@lst.de>
References: <20221031222541.1773452-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031222541.1773452-1-song@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 31, 2022 at 03:25:36PM -0700, Song Liu wrote:
> This set enables bpf programs and bpf dispatchers to share huge pages with
> new API:
>   vmalloc_exec()
>   vfree_exec()
>   vcopy_exec()

Maybe it's just me, but I don't like the names very much.  They imply
a slight extension to the vmalloc API, but while they use the vmalloc
mechanisms internally, the API is actually quite different.

So why not something like:

   execmem_alloc
   execmem_free
   execmem_fill or execmem_set or copy_to_execmem

?

