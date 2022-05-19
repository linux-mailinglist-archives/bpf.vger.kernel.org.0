Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1372652CD43
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 09:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiESHi7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiESHi6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 03:38:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1398A7E29;
        Thu, 19 May 2022 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2WGn3U5iWYbqhAEYerCkhKo3tyszE5fO2isMfocp72s=; b=MqRC9ZtBC0maLPeCbKteZ8lGuo
        /1I+a4DLnSkHaU6Ku3WgpUTD0sh0NOBM2nHYNQ/MoIen0wmdivi/AGROJYerl0XSwwmK0FTC9jtpM
        uR8G03NFam87OKw8l2TL+1ynj4ud3YZUQkq4rAfC5UHTYasK1fyuupcqB+c33dmSSc+/uWMeq21Mh
        mWboozwGQ5XQJvvsmomxwlk40EHk/NujNUwBefWCvBe9V9WvbMMUNJuA+Nit6VJu3yS3/wCfp1qNf
        7PzSvwWJfyYutYO/d5sAc9iYvMN6DM9WbdNd7PBRTeBnNAjB+5JLcNJbPeJ68dbQY7poPQEYLXIlv
        ypjazLKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrajr-001leT-8U; Thu, 19 May 2022 07:38:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 084EC980BF7; Thu, 19 May 2022 09:38:25 +0200 (CEST)
Date:   Thu, 19 May 2022 09:38:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Message-ID: <20220519073824.GA2578@worktop.programming.kicks-ass.net>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-3-song@kernel.org>
 <20220518170934.GG10117@worktop.programming.kicks-ass.net>
 <A4019486-85F3-4900-8073-6879608706B1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A4019486-85F3-4900-8073-6879608706B1@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 18, 2022 at 06:34:18PM +0000, Song Liu wrote:
> 
> 
> > On May 18, 2022, at 10:09 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Sun, May 15, 2022 at 10:40:48PM -0700, Song Liu wrote:
> >> Introduce a memset like API for text_poke. This will be used to fill the
> >> unused RX memory with illegal instructions.
> > 
> > FWIW, you're going to use it to set INT3 (0xCC), that's not an illegal
> > instruction. INTO (0xCE) would be an illegal instruction (in 64bit
> > mode).
> 
> Hmm… we have been using INT3 as illegal/invalid/special instructions in 
> the JIT. I guess they are equally good for this job?

INT3 is right, it's just not illegal. Terminology is everything :-)

INT3 is the breakpoint instruction, it raises #BP, an illegal
instruction would raise #UD. Different exception vectors and such.
