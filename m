Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDBD3BBC7A
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 13:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhGEL6G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 07:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhGEL6F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 07:58:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F8DC061574;
        Mon,  5 Jul 2021 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pq7bP+MTawU/za6/1KcKOrsotUVcyEKhovbCd0LbYxs=; b=a+qDzygSNKqUonGPkaGwhrnB5T
        Nm56mhN/nkb4qEMQf8wo67ZcRNY40zF/g8Gq5vbUJaVK6mdWQghoQ3ItzYisV3ahD7M1pZPf0+pBq
        sMzo8GAzPGX7lfnm0nAj6EskGk523UnvjSQpgad6kBB0C5v77Q6AGNxYZr02WitwcdudQVcBcMInY
        6oJbrQKYUcJSntqCQhanhsjE6+0gv0E97fMm8JyML0mfWCAHZ27WkdgxeMsVwmZy3KG1q+3WYKGWK
        shmZK3c9fzIarX5AleY8Gzgbx+FgK67mHhpgrYKQN1XMfP4QzQkghUyF0KQ16pFGsHG6PfrECEfNe
        xihRRcrA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0NBl-00ADQL-7P; Mon, 05 Jul 2021 11:55:09 +0000
Date:   Mon, 5 Jul 2021 12:55:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, bpf@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
Message-ID: <YOLzFecogWmdZ5Hc@infradead.org>
References: <20210705103806.2339467-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705103806.2339467-1-elver@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 05, 2021 at 12:38:06PM +0200, Marco Elver wrote:
> This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.
> 
> Commit 76cd61739fd1 ("mm/error_inject: Fix allow_error_inject function
> signatures") explicitly made should_fail_alloc_page() non-static, due to
> worries of remaining compiler optimizations in the absence of function
> side-effects while being noinline.
> 
> Furthermore, kernel/bpf/verifier.c pushes should_fail_alloc_page onto
> the btf_non_sleepable_error_inject BTF IDs set, which when enabling
> CONFIG_DEBUG_INFO_BTF results in an error at the BTFIDS stage:
> 
>   FAILED unresolved symbol should_fail_alloc_page
> 
> To avoid the W=1 warning, add a function declaration right above the
> function itself, with a comment it is required in a BTF IDs set.

NAK.  We're not going to make symbols pointlessly global for broken
instrumentation coe.  Someone needs to fixthis eBPF mess as we had
the same kind of issue before already.
