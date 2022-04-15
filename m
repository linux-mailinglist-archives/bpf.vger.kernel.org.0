Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC0502EF0
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347897AbiDOTIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347893AbiDOTIL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 15:08:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C93A5F5;
        Fri, 15 Apr 2022 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i8u5wA5pkuMd57YgDKyeRMaeVXySpdGvOCw8eFs9SSc=; b=OBYuj+louCSRCKwtc30JWm58TX
        pboqz1LXgwQTy6xrbf50VjTba3IocmZv3tNmG4HJYvOu5A0KHOBDQiUiRUYcn/l9yodDX6DycXbdC
        lBGu2YoYjclbhy5rDDdTXJdq1MLrSGtYrnm/D0hYtkWYxCiogicB96P7HA0AR8ozszUhdtcoIS7rh
        FbzLjBQ09yGZkdk6Xh3pvDIWmX/mopTEAD+pptDXcG9HYeQgy3SuWELim3D0jiU8abMuHo6QHfT58
        z6Gi2tT79cxIqilUN80sNleD3ekeqjCrY3JjbnAo+Lmjvwq6lS/NLzRxsQUWtbBLBaR58iywF3Bs1
        +XkwRtJQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfRGI-00B9lw-E2; Fri, 15 Apr 2022 19:05:42 +0000
Date:   Fri, 15 Apr 2022 12:05:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
References: <20220415164413.2727220-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415164413.2727220-1-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 09:44:09AM -0700, Song Liu wrote:
> Changes v3 => v4:
> 1. Fix __weak module_alloc_huge; remove unused vmalloc_huge; rename
>    __vmalloc_huge => vmalloc_huge. (Christoph Hellwig)
> 2. Use vzalloc (as it was before vmalloc_no_huge) and clean up comments in
>    kvm_s390_pv_alloc_vm.
> 
> Changes v2 => v3:
> 1. Use __vmalloc_huge in alloc_large_system_hash.
> 2. Use EXPORT_SYMBOL_GPL for new functions. (Christoph Hellwig)
> 3. Add more description about the issues and changes.(Christoph Hellwig,
>    Rick Edgecombe).
> 
> Changes v1 => v2:
> 1. Add vmalloc_huge(). (Christoph Hellwig)
> 2. Add module_alloc_huge(). (Christoph Hellwig)
> 3. Add Fixes tag and Link tag. (Thorsten Leemhuis)
> 
> Enabling HAVE_ARCH_HUGE_VMALLOC on x86_64 and use it for bpf_prog_pack has
> caused some issues [1], as many users of vmalloc are not yet ready to
> handle huge pages. To enable a more smooth transition to use huge page
> backed vmalloc memory, this set replaces VM_NO_HUGE_VMAP flag with an new
> opt-in flag, VM_ALLOW_HUGE_VMAP. More discussions about this topic can be
> found at [2].
> 
> Patch 1 removes VM_NO_HUGE_VMAP and adds VM_ALLOW_HUGE_VMAP.
> Patch 2 uses VM_ALLOW_HUGE_VMAP in bpf_prog_pack.
> 
> [1] https://lore.kernel.org/lkml/20220204185742.271030-1-song@kernel.org/
> [2] https://lore.kernel.org/linux-mm/20220330225642.1163897-1-song@kernel.org/

Looks good except for that I think this should just wait for v5.19. The
fixes are so large I can't see why this needs to be rushed in other than
the first assumptions of the optimizations had some flaws addressed here.

If this goes through v5.19 expect conflicts on modules unless you use
modules-testing.

  Luis
