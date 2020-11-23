Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49352C01D9
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 10:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgKWJA5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 04:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgKWJA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 04:00:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED8CC0613CF;
        Mon, 23 Nov 2020 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=flYiZOk1DDOO3edQvf6Tz2+/+AB101STTfYO1lfvvJ8=; b=N/3WgXhoIf3l9jopQDWfhTq6NU
        C/ZOAgGe/B4ARIcIcrVx8uQBhyS06iJkU9B3vaUTvKcXd3FqgM81DY/5Qf0yGeJsCBXaKC15BodUR
        zqqZ4TdqPAZcbVC0++BJmUB6050njxfsfd8mJUe30ymCfPgR3wb0YK46pfpjY0Mb4rAVkEgCxSWDY
        jXHBOuJZ2tNQ5t9DbEudZ6UFHjaKKawfkSYTkD7sV6PW/qQruEHlAdAkfJBWEVz+fTKQhJBABwSh/
        JRAq0qRv1OjED/a1D+8Y0TUsaP+8HzkeP9nqnmmPWztjcfHEV6f7W+qJg3Kz2WimkJvFOhNG73B2y
        Ypx0g3lw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kh7iC-0002pP-JH; Mon, 23 Nov 2020 09:00:40 +0000
Date:   Mon, 23 Nov 2020 09:00:40 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, elena.reshetova@intel.com,
        ira.weiny@intel.com
Subject: Re: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Message-ID: <20201123090040.GA6334@infradead.org>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
 <20201120202426.18009-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120202426.18009-2-rick.p.edgecombe@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First thanks for doing this, having a vmalloc variant that starts out
with proper permissions has been on my todo list for a while.


> +#define PERM_R	1
> +#define PERM_W	2
> +#define PERM_X	4
> +#define PERM_RWX	(PERM_R | PERM_W | PERM_X)
> +#define PERM_RW		(PERM_R | PERM_W)
> +#define PERM_RX		(PERM_R | PERM_X)

Why can't this use the normal pgprot flags?

> +typedef u8 virtual_perm;

This would need __bitwise annotations to allow sparse to typecheck the
flags.

> +/*
> + * Allocate a special permission kva region. The region may not be mapped
> + * until a call to perm_writable_finish(). A writable region will be mapped
> + * immediately at the address returned by perm_writable_addr(). The allocation
> + * will be made between the start and end virtual addresses.
> + */
> +struct perm_allocation *perm_alloc(unsigned long vstart, unsigned long vend, unsigned long page_cnt,
> +				   virtual_perm perms);

Please avoid totally pointless overly long line (all over the series)

Also I find the unsigned long for kernel virtual address interface
strange, but I'll take a look at the callers later.
