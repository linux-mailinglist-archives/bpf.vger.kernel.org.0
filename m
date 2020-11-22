Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C561F2BC380
	for <lists+bpf@lfdr.de>; Sun, 22 Nov 2020 05:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgKVEKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Nov 2020 23:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbgKVEKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Nov 2020 23:10:34 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA26C20BED
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2020 04:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606018234;
        bh=aIUERRo+D3LJ1e3a38WHT/KcLgeR55ggVW4a+W2H/ac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UTKsWK7ethrWz7p0NHZy89h4gnmhgVI2C90fJNI0jdlbjs5z3qajIvn6aiKnXsrJc
         lnBI/f7hVxaiTdGRpdHKjcrhQGDwruka4Izo0iV4TsJ1d1v6T7aNGtqQ087nqJEz4n
         oSkozLL22iz8ovbkfihb/19OmioGteZ57smJ0w1Y=
Received: by mail-wm1-f48.google.com with SMTP id s13so14108793wmh.4
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2020 20:10:33 -0800 (PST)
X-Gm-Message-State: AOAM5309PfE1ldZLnpTzFIYSdstDUdASF6zbphdnp9qGMcbnGQvUCkkr
        aPa+oV7QOwR5C0ZMsMyJ1nowEPZ7zni/ESVY766zsA==
X-Google-Smtp-Source: ABdhPJxlpOwzJoFxMqFLKTm7fhwah9wqGhXLGX+C0bhrFGpecaO68yaNmHMgKiHI+MdXGy44VW9EWOMmwf6PnTdgv+w=
X-Received: by 2002:a1c:2781:: with SMTP id n123mr427726wmn.49.1606018232467;
 Sat, 21 Nov 2020 20:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com> <20201120202426.18009-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20201120202426.18009-2-rick.p.edgecombe@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 21 Nov 2020 20:10:16 -0800
X-Gmail-Original-Message-ID: <CALCETrUjpdSGg0T8vehkXszDJKx5AS0BHP9qFRsakPABzPM2GA@mail.gmail.com>
Message-ID: <CALCETrUjpdSGg0T8vehkXszDJKx5AS0BHP9qFRsakPABzPM2GA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Weiny Ira <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 20, 2020 at 12:30 PM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> In order to allow for future arch specific optimizations for vmalloc
> permissions, first add an implementation of a new interface that will
> work cross arch by using the existing set_memory_() functions.
>
> When allocating some memory that will be RO, for example it should be used
> like:
>
> /* Reserve va */
> struct perm_allocation *alloc = perm_alloc(vstart, vend, page_cnt, PERM_R);

I'm sure I could reverse-engineer this from the code, but:

Where do vstart and vend come from?  Does perm_alloc() allocate memory
or just virtual addresses?  Is the caller expected to call vmalloc()?
How does one free this thing?

> unsigned long ro = (unsigned long)perm_alloc_address(alloc);
>
> /* Write to writable address */
> strcpy((char *)perm_writable_addr(alloc, ro), "Some data to be RO");
> /* Signal that writing is done and mapping should be live */
> perm_writable_finish(alloc);
> /* Print from RO address */
> printk("Read only data is: %s\n", (char *)ro);
>
