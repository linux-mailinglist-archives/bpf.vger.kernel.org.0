Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A500503833
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiDPUdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiDPUdo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 16:33:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31B59A43
        for <bpf@vger.kernel.org>; Sat, 16 Apr 2022 13:31:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bj36so6981793ljb.13
        for <bpf@vger.kernel.org>; Sat, 16 Apr 2022 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLjXXGPCeZFoo0LSeAoNTeYQmnNJj43S9GqF3x/ym20=;
        b=SrSlzeiaQpCm4wc0MQ0m37QHAqoK9FT8MbEl9SPGH8rdWqMQedT7lTTS7GcsoBzJnC
         mwh/ajg/m0eG9+H3NUwn9OLJNGOLmtA5Tot2AAfRENjeYsH57sN9QT0cCZ6etY+bAiY8
         POMTsc8VPFSI9b1QmVcOmHGCjJIie+BnfYtvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLjXXGPCeZFoo0LSeAoNTeYQmnNJj43S9GqF3x/ym20=;
        b=B6Nvay+QGc/908iMYD/c/3/BhTWmgAmEF5V5xXUHAsp2Vbxe1GmsJerCtLrfZahs9S
         tRJoZF+5zoyvt6oC6AeCqLmIR9QzkZd0dGr540cPPaCy77W7kZBNtYLXXc9iu5cAmbZQ
         8nRV/AnrUdrk6nsBTAu8ovBdFRFgja1g3iI/U5NmY2Nf41JDD66T6T49wd4BFgTOHC3c
         bbcIbWJ8BBR4qCy/lkcdSj11ncsRndroeswBK85QK7gC2YXbxXbbytmGExxz72xayuWw
         ZALkexUs0lmwBaD7/ysgrKnsaFAJ2AhrVfFbMRxGStsuc4Iom3r5GYVJTqdFYEawTpbk
         mleQ==
X-Gm-Message-State: AOAM531inMqjWidHzhIYX+iG5mSmzU9kK3d0eV9w3ERBWnai4IunPAyK
        Terdrb2SxumNb8hsT9GuzsmgcYrM4SGcypRhieo=
X-Google-Smtp-Source: ABdhPJwqwVkS3mRio7eFNTnTeJ1tG1uYwEd7dZMp/EJ0mRANufc2bdRNe3E3TjPeCziJ5bjdWbe80w==
X-Received: by 2002:a2e:a903:0:b0:24a:f39a:88e9 with SMTP id j3-20020a2ea903000000b0024af39a88e9mr2888686ljq.394.1650141066969;
        Sat, 16 Apr 2022 13:31:06 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u3-20020a197903000000b00464f4c76ebbsm762085lfc.94.2022.04.16.13.31.03
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 13:31:04 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id x17so18856656lfa.10
        for <bpf@vger.kernel.org>; Sat, 16 Apr 2022 13:31:03 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr3175652lfh.687.1650141063333; Sat, 16
 Apr 2022 13:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
In-Reply-To: <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Apr 2022 13:30:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
Message-ID: <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Song Liu <songliubraving@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 16, 2022 at 12:55 PM Song Liu <songliubraving@fb.com> wrote:
>
> Based on this analysis, I think we should either
>   1) ship the whole set with 5.18; or
>   2) ship 1/4, 3/4, and 4/4 with 5.18, and 2/4 with 5.19.

Honestly, I think the proper thing to do is

 - apply #1, because yes, that "use huge pages" should be an opt-in.

 - but just disable hugepages for now.

I think those games with set_memory_nx() and friends just show how
rough this all is right now.

In fact, I personally think that the whole bpf 'prog_pack' stuff
should probably be disabled. It looks incredible broken to me right
now.

Unless I mis-read it, it does a "module_alloc()" to allocate the vmap
area, and then just marks it executable without having even
initialized the pages. Am I missing something? So now we have random
kernel memory that is marked executable.

Sure, it's also marked RO, but who cares? It's random data that is now
executable.

Maybe I am missing something, but I really don't think this is ready
for prime-time. We should effectively disable it all, and have people
think through it a lot more.

                   Linus
