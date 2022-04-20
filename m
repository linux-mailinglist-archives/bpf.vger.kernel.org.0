Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04432508308
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376565AbiDTIA6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357036AbiDTIA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 04:00:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EDA625E;
        Wed, 20 Apr 2022 00:58:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D1A721112;
        Wed, 20 Apr 2022 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650441490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zh1+qCZ/MYXJ0sRvzfY4sa1n6TDnYaGX5/J1ORSZtfg=;
        b=fK/qA+XzGW35/9w2tvE+4x0zKayfY5S1REDI0Hj+Wv7kazxwNLOX5GtAsN3xI2vwpGp0Li
        UpZRRdnfs3qfCIlF00lXuhhreXhdDvkhiNqTs6bgNrdBkgTBQwAOGtZqJv0+LppY79rot2
        KuWaR/55MHeREPMSv9wljkh6Kuxns1w=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9C31F2C142;
        Wed, 20 Apr 2022 07:58:09 +0000 (UTC)
Date:   Wed, 20 Apr 2022 09:58:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <Yl+9ETR8qc1sRKy3@alley>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
 <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
 <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <Yl8olpqvZxY8KoNf@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl8olpqvZxY8KoNf@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue 2022-04-19 14:24:38, Luis Chamberlain wrote:
> On Tue, Apr 19, 2022 at 01:56:03AM +0000, Edgecombe, Rick P wrote:
> > Yea, that was my understanding. X86 modules have to be linked within
> > 2GB of the kernel text, also eBPF x86 JIT generates code that expects
> > to be within 2GB of the kernel text.
> 
> And kprobes / live patching / ftrace.
> 
> Another architectural fun fact, powerpc book3s/32 requires executability
> to be set per 256 Mbytes segments. Some architectures like this one
> will want to also optimize how they use the module alloc area.
> 
> Even though today the use cases might be limited, we don't exactly know
> how much memory a target device has a well, and so treating memory
> failures for "special memory" request as regular memory failures seems
> a bit odd, and users could get confused. For instance slapping on
> extra memory on a system won't resolve any issues if the limit for a
> special type of memory is already hit. Very likely not a problem at all today,
> given how small modules / eBPF jit programs are / etc, but conceptually it
> would seem wrong to just say -ENOMEM when in fact it's a special type of
> required memory which cannot be allocated and the issue cannot possibly be
> fixed. I don't think we have an option but to use -ENOMEM but at least
> hinting of the special failure would have seem desirable.

I am not mm expert but I think that this is common problem. There are
many types of "special memory". And mm provides many details via procfs, e.g.
/proc/meminfo, /proc/slabinfo, /proc/vmstat.

Best Regards,
Petr
