Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4063155F371
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 04:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiF2CgI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 22:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiF2CgG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 22:36:06 -0400
X-Greylist: delayed 94694 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 19:36:01 PDT
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB942DD59
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 19:36:01 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 62EECB00443; Wed, 29 Jun 2022 04:35:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1656470158; bh=GIQsKenNZfcUeNZ7+iW3EIqnppyItHUTeM8wuuHIaV8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=zH+NSQ0cLQCLe+mJTbezokxi6pn+fHgtTjFPSJNVXd7cV7TMVVpVTgaSngcN9qaYB
         80/CdQ2xfpBo1tavkh81pjfi3eCXsm9l4HJ3KCsvkcw/Zr0O3sraLXilTwymH6p5Xc
         kgEW+1suqD4eDCpsACbkZpjWHsqD/9Eqt0qEFDvPXdWWJGQsSr60jiVcjZHbOsvdVy
         DsTIawCa16cn/0jrfSFKCXIxNrrcJdmiuOThqDbMboM3czumLMz6bJ+JfE2EyM+oL4
         8of6ufxW172jrUFMiOR3YT7m/E5u0irlaV+Qcs/Iaq9UxpIP7aGt8xLhAR/EzRDhth
         otzyMctnLGCcQ==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 5FFC5B00068;
        Wed, 29 Jun 2022 04:35:58 +0200 (CEST)
Date:   Wed, 29 Jun 2022 04:35:58 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
In-Reply-To: <20220628170343.ng46xfwi32vefiyp@MacBook-Pro-3.local>
Message-ID: <alpine.DEB.2.22.394.2206290431540.371188@gentwo.de>
References: <YrlWLLDdvDlH0C6J@infradead.org> <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de> <CAADnVQKfLE6mwh8BrijgJeLL60DNaGgVy9b133vZ6edZmugong@mail.gmail.com> <alpine.DEB.2.22.394.2206281550210.328950@gentwo.de>
 <20220628170343.ng46xfwi32vefiyp@MacBook-Pro-3.local>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 28 Jun 2022, Alexei Starovoitov wrote:

> > That is a relatively new feature due to RT logic support. without RT this
> > would be a simple irq disable.
>
> Not just RT.
> It's a slow path:
>         if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
>             unlikely(!object || !slab || !node_match(slab, node))) {
>               local_unlock_irqrestore(&s->cpu_slab->lock,...);
> and that's not the only lock in there.
> new_slab->allocate_slab... alloc_pages grabbing more locks.


Its not a lock for !RT.

The fastpath is lockless if hardware allows that but then we go into more
and more serialiation needs as the allocation gets more into the page
allocator logic.

> > allocation functions in the BPF logic like bpf_mem_alloc? How do you stop
> > that from happening?
>
> here is the comment in the patch:
> /* notrace is necessary here and in other functions to make sure
>  * bpf programs cannot attach to them and cause llist corruptions.
>  */

"notrace".... Ok Hmmm...
