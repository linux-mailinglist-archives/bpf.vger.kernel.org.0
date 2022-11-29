Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A0963BDE6
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 11:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiK2KYC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 05:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiK2KXl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 05:23:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4FC64DA
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 02:23:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669717397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=znPXvxz3kz6ID7zX6kCLMH9Eop2P9SgAGV/kZSx6/e0=;
        b=V027JSBo5uFP6TX3Lf8rRrU22Mn2Pjay+3rXWjG0eexUWUDu2eAXFntcSOGMPMkLdmp54q
        C+NoyFUyKQ3fOjwmodIrCXckYziK7RMeuI20yHuygajK8VPtuMiAEaW4H5abRBP13IrZZl
        uCWwuNmJqBCB3v+T29EteeyL+yes0sj14iOiQQu0LQjSIlhMdFJAEbXBADoBbwS3masNmh
        m5lnuqb5YA+wk2iGi2SjpIiF+YnD5oAZoiXoT7zJzgtmKYKQakscZ5LkzSdVYKhQqTeYxK
        Iu9ictSeTcQ3gCd/QgSXJrSVjtMrCXEMGDyD+1H2lWvVSf/6AqzyrjT23u5qzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669717397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=znPXvxz3kz6ID7zX6kCLMH9Eop2P9SgAGV/kZSx6/e0=;
        b=01fI197c3emeb97I5YstKIxQJ1dj0jh1u5z0sZBrc2ZfJ/vrmxeSbjCXlHzikUdSdDznoC
        vteyR0edggT5pUAw==
To:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org, akpm@linux-foundation.org
Cc:     x86@kernel.org, hch@lst.de, rick.p.edgecombe@intel.com,
        aaron.lu@intel.com, rppt@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
References: <20221107223921.3451913-1-song@kernel.org>
 <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
Date:   Tue, 29 Nov 2022 11:23:15 +0100
Message-ID: <87lenuukj0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14 2022 at 17:30, Song Liu wrote:
> On Mon, Nov 7, 2022 at 2:41 PM Song Liu <song@kernel.org> wrote:
> Currently, I have got the following action items for v3:
> 1. Add unify API to allocate text memory to motivation;
> 2. Update Documentation/x86/x86_64/mm.rst;
> 3. Allow none PMD_SIZE allocation for powerpc.
>
> 1 and 2 are relatively simple. We can probably do 3 in a follow up patch
> (as I don't have powerpc environments for testing). Did I miss anything?
>
> Besides these, does this set look reasonable? Andrew and Peter, could
> you please share your comments on this?

This is a step into the right direction, but is it a solution which has
a broader benefit? I don't think so.

While you are so concerned about (i)TLB usage for BPF, I'm way more
concerned about modules. Just from a random server class workstation:

Total module memory:	12.4609 MB
Number of 4k PTEs:         3190

The above would nicely fit into 7 or 8 2M mappings.

Guess how much memory is occupied by BPF on that machine and how much
BPF contributes to iTLB pressure? In comparison to the above very close
to zero.

Modules have exactly the same problem as BPF, just an order of magnitude
larger.

So we don't need a "works" for BPF solution which comes with the
handwaving assumption that it could be used for modules too. We need
something which demonstrates that it solves the entire problem class.

Modules are the obvious starting point. Once that is solved pretty much
everything else falls into place including BPF.

Without modules support this whole exercise is pointless and not going
anywhere near x86.

Thanks,

        tglx
