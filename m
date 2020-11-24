Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC62C22AD
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 11:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgKXKTE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 05:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731789AbgKXKTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 05:19:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A4C0613D6;
        Tue, 24 Nov 2020 02:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r16HuK5E5hgNLfz84Ovb58FlHw1upwk42+G5GGobWXE=; b=i5esFKtT3bLBy1jdXIJ1bJMcfi
        78gqL1bNGaBmrAM04MHYeevs1PBmFcWMyXwOL7IPA96XpmA+dI4ni/wPbJX+J4fghTqXdlkMM9KMw
        YnI5KL7EJy+KaOCDn/fVZnvLFnlYRHz+aWokoN+Caar1xdEAy4qvUH8ke8iC9ELvHcnq6nQkenucm
        g+JICnMd2ycBTnAfkO2YlsILR4I4xCS34qO+6rI5cGDXN6J5IOuJFx28k2qyQwy/gsEhHDSe+lF8r
        AtCAsN7biCO/p53cfDuSBuOQqix5/gVYEqb1gypPIGB3GphVeI4MXrWP0ynQ19IOi+Zv/JOuRXv4n
        +O/LVe2g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khVPZ-0002ok-6J; Tue, 24 Nov 2020 10:19:01 +0000
Date:   Tue, 24 Nov 2020 10:19:01 +0000
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "luto@kernel.org" <luto@kernel.org>
Subject: Re: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Message-ID: <20201124101901.GB9682@infradead.org>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
 <20201120202426.18009-2-rick.p.edgecombe@intel.com>
 <20201123090040.GA6334@infradead.org>
 <eccaa448f82e90c924d51d52525f766340026dfe.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eccaa448f82e90c924d51d52525f766340026dfe.camel@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 08:44:12PM +0000, Edgecombe, Rick P wrote:
> Well, there were two reasons:
> 1. Non-standard naming for the PAGE_FOO flags. For example,
> PAGE_KERNEL_ROX vs PAGE_KERNEL_READ_EXEC. This could be unified. I
> think it's just riscv that breaks the conventions. Others are just
> missing some.

We need to standardize those anyway.  I've done that for a few
PAGE_* constants already but as you see there is more work to do.

> But I thought that using those pgprot flags was still sort overloading
> the meaning of pgprot. My understanding was that it is supposed to hold
> the actual bits set in the PTE. For example large pages or TLB hints
> (like PAGE_KERNEL_EXEC_CONT) could set or unset extra bits, so asking
> for PAGE_KERNEL_EXEC wouldn't necessarily mean "set these bits in all
> of the PTEs", it could mean something more like "infer what I want from
> these bits and do that".
> 
> x86's cpa will also avoid changing NX if it is not supported, so if the
> caller asked for PAGE_KERNEL->PAGE_KERNEL_EXEC in perm_change() it
> should not necessarily bother setting all of the PAGE_KERNEL_EXEC bits
> in the actual PTEs. Asking for PERM_RW->PERM_RWX on the other hand,
> would let the implementation do whatever it needs to set the memory
> executable, like set_memory_x() does. It should work either way but
> seems like the expectations would be a little clearer with the PERM_
> flags.

Ok, maybe that is an argument, and we should use the new flags more
broadly.

> Could easily wrap this one, but just to clarify, do you mean lines over
> 80 chars? There were already some over 80 in vmalloc before the move to
> 100 chars, so figured it was ok to stretch out now.

CodingStyle still says 80 characters unless you have an exception where
a longer line improves the readability.  The quoted code absolutely
does not fit the definition of an exception or improves readability.
