Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B93573DD0
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiGMU10 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 16:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMU1Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 16:27:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65602D1E8;
        Wed, 13 Jul 2022 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aMwCqCZv7KMm7FPwRBaOPDqNH5Xzn53rKrd3wy7Qd0w=; b=dbi9CHnMFf07cd9TO0b63y6NJ/
        EFhxQwRZ5INwn4lK+g3Xz52wZ1Ufh6bit0UjcgJ+ztc/Ic7AFmYpzlaC1rFNuplCSZ9FyeIc3FSXv
        /4HhcZz6vPKRNDsfkskAQk73c0dCn9m2f/szsziEdotI2rgMKhqvCwQ/hFO26QJf0Tb9M6Ah7mZES
        S7RHI2AGYAb+v8ebY/6QeatcDMl0i1Hz8UWulpNU0uTHHyrSMTmGxAIwQ7OmYz7F0OvLHwpwU7HHT
        Gf6+HN8T0OGeF6o9/M5cjr/Ou6QOdPGH6eOvtD2YaVjxbDS2H6SKg+TKN7P75ztpBqrfbWyfIqC1f
        dAVn1iXg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBiwR-003er4-6q; Wed, 13 Jul 2022 20:26:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50F5D980082; Wed, 13 Jul 2022 22:26:37 +0200 (CEST)
Date:   Wed, 13 Jul 2022 22:26:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Message-ID: <Ys8qfRwkTbUYwmKM@worktop.programming.kicks-ass.net>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
 <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
 <7C927986-3665-4BD6-A339-D3FE4A71E3D4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7C927986-3665-4BD6-A339-D3FE4A71E3D4@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 03:48:35PM +0000, Song Liu wrote:

> > So how about instead we separate them? Then much of the problem goes
> > away, you don't need to track these 2M chunks at all.
> 
> If we manage the memory in < 2MiB granularity, either 4kB or smaller, 
> we still need some way to track which parts are being used, no? I mean
> the bitmap.  

I was thinking the vmalloc vmap_area tree could help out there.
