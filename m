Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0644952C0DB
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbiERRKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 13:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbiERRKA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 13:10:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6D11BF19A;
        Wed, 18 May 2022 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X4cQhgsNH4NMM2gDMe6qhYgR1Uuo0IffIvWkryvfqfA=; b=gxYr0KWCY0yOaJHClLCtZS+DOS
        HcbT78QpS1dxcVsUI0zMSTSYWi3JDk6/qHIJhef/D+3ZhBl/jNprF8Y4KocA1xkzvW1cD/pqALThT
        odMSJEQm0EHRRzhuYx4zpM4hTEfgqO3qAn6GCU4xjPDv/GHxVUA9B3NAo7aX8373g7jX9Ov7t21u6
        kR6nzQKA8YK8Ur7qacr6v2c940Q6eZb2iFRXDkUWA9Xhk+KFRw5ki75RTrZi9f7DGfRkU9IFeGnzC
        nWWcFsLwIVSK0jFiaMKy/H+NUjy0mYORO2aI3b+brUWMbdOF/s6htUbfS+1s+4g04bPZpXxhFAnIO
        cI8gPicw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrNB2-00ByS7-QC; Wed, 18 May 2022 17:09:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC833980E1C; Wed, 18 May 2022 19:09:34 +0200 (CEST)
Date:   Wed, 18 May 2022 19:09:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, mcgrof@kernel.org,
        torvalds@linux-foundation.org, rick.p.edgecombe@intel.com,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Message-ID: <20220518170934.GG10117@worktop.programming.kicks-ass.net>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-3-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516054051.114490-3-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 15, 2022 at 10:40:48PM -0700, Song Liu wrote:
> Introduce a memset like API for text_poke. This will be used to fill the
> unused RX memory with illegal instructions.

FWIW, you're going to use it to set INT3 (0xCC), that's not an illegal
instruction. INTO (0xCE) would be an illegal instruction (in 64bit
mode).


> +	return addr;
> +}
> +
> +/**
> + * text_poke_set - memset into (an unused part of) RX memory
> + * @addr: address to modify
> + * @c: the byte to fill the area with
> + * @len: length to copy, could be more than 2x PAGE_SIZE
> + *
> + * Not safe against concurrent execution; useful for JITs to dump
> + * new code blocks into unused regions of RX memory. Can be used in
> + * conjunction with synchronize_rcu_tasks() to wait for existing
> + * execution to quiesce after having made sure no existing functions
> + * pointers are live.

That comment suffers from copy-pasta and needs an update because it
clearly isn't correct.

> + */

Other than that, seems fine.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
