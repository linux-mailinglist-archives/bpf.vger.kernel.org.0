Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A132552B3EF
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 09:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiERHqU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiERHqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 03:46:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E81140CF;
        Wed, 18 May 2022 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eYhDLxMmwvMOyckDiVHVyMmqmEWGbbWduzz8f6EoW7w=; b=A57xSi62gZdHfEmDFs5ABgQVlf
        877bK1lc99hRjaSFHxGasl/efP8yeorgGh6tPcDiAuvoObOU54KwdRVqTXUcFQEb9w0I+j2hH01Jt
        7i6CYX1HN+iwBMiqOQiBUpDippnTsNf1qhb3LeUsQHUGcs5jtdAsVgOqPgvB94jIN4L3/ia2wLpDv
        7JIiBGQlY6D5KpTBk0/WYIG3+MgVf+wxIuegc0L2pfXVZzjpUO7a4kKyKrjEfe11Sf+OZeH2ruc6w
        DlH+FwqvU/sNnFO37gHmjKHHJ6oEraPIqSqbhV8MIUplRjvQX8NX5qzORW5dl3RiIoGUJ+C80ZXcH
        s5jNMp1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrENY-001TvH-BW; Wed, 18 May 2022 07:45:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC46698119B; Wed, 18 May 2022 09:45:55 +0200 (CEST)
Date:   Wed, 18 May 2022 09:45:55 +0200
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
Message-ID: <20220518074555.GC10117@worktop.programming.kicks-ass.net>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-3-song@kernel.org>
 <8370EC6E-C01F-496C-8B7C-D13EF9C474C5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8370EC6E-C01F-496C-8B7C-D13EF9C474C5@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 18, 2022 at 06:58:46AM +0000, Song Liu wrote:
> Hi Peter, 
> 
> > On May 15, 2022, at 10:40 PM, Song Liu <song@kernel.org> wrote:
> > 
> > Introduce a memset like API for text_poke. This will be used to fill the
> > unused RX memory with illegal instructions.
> > 
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Song Liu <song@kernel.org>
> 
> Could you please share your comments on this? 

I wrote it; it must be good! What specifically you want to know?
