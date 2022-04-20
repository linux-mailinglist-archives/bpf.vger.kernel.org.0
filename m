Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8598A507EBD
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 04:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358914AbiDTCV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 22:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358910AbiDTCVz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 22:21:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A660A30F54
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 19:19:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x33so407649lfu.1
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 19:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzcM0Fy8zoXIYtzw0zgKr6w3uu0pvrZ7K2myKeDxUvc=;
        b=XlMHlA1yW/3psqu/gqNph/O3AA7PrGeW5068j/3DUXbJp9LCr/qQwXvvlCgRY66YZs
         bfbo2buBJiwcJj5XorkSa+q8/5Dd97EEFrzXKMkVvKZ2Q6hHadvYR+AeJLYW8cad9NkT
         BkTcdQwom8v7pt4NN84cQ97G02o6Ks7iPjqGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzcM0Fy8zoXIYtzw0zgKr6w3uu0pvrZ7K2myKeDxUvc=;
        b=PYjT7+pHlMP0j3QxKW0jxRguc3PAqyZYdZUYgwPONTzVnuSa+/J3LXbqm8rhd8vJYp
         IEcRHT3cN0yNWdf2MF/ilNcV3wH0HH3D3hLQbeesm/EO17Dna+WtvWQihFSP3edN/mWz
         BHGrtdW4xXGsNB54A9h47zJw5zaveDjZsmVk+JqCJXPpGFRbr0HfupbdYuD2K/vA6SO5
         ndZbufFZeRgAlsGshcGKP/+sZ2U/ns5T4CA8y/UKnCi/gWC57tSFayROMK2SkDd417Nw
         GrebULqDh5A9Utqn+VW/Ex2h/HhCbJXCq4f/bX6JSrokjmG1qkmBobSWA+0g0ZwgcLcm
         R1Cg==
X-Gm-Message-State: AOAM531WaIsf1gZ142iweGg1vXiFfjSogsoD3rwBPy27ZlXysO8gjsQx
        XgJ3upD+4riwTupR2fOWI+t1yEz4XQVTbq4rR20=
X-Google-Smtp-Source: ABdhPJwX9o8gcLCO7/NKX32rLGDb6UbNgdwKhuqVZW8/IvMz019RPrhPg40XLb7fglbkCqprF/jZTA==
X-Received: by 2002:a05:6512:2308:b0:471:b4e8:6a4c with SMTP id o8-20020a056512230800b00471b4e86a4cmr1846151lfu.517.1650421148776;
        Tue, 19 Apr 2022 19:19:08 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id a4-20020a19ca04000000b0044a97178a1esm1668599lfg.201.2022.04.19.19.19.06
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 19:19:07 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id c15so248352ljr.9
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 19:19:06 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr12387816ljg.291.1650421146776; Tue, 19
 Apr 2022 19:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com> <20220420020311.6ojfhcooumflnbbk@MacBook-Pro.local.dhcp.thefacebook.com>
In-Reply-To: <20220420020311.6ojfhcooumflnbbk@MacBook-Pro.local.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Apr 2022 19:18:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com>
Message-ID: <CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
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

On Tue, Apr 19, 2022 at 7:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Here is the quote from Song's cover letter for bpf_prog_pack series:

I care about performance as much as the next person, but I care about
correctness too.

That large-page code was a disaster, and was buggy and broken.

And even with those four patches, it's still broken.

End result: there's no way that thigh gets re-enabled without the
correctness being in place.

At a minimum, to re-enable it, it needs (a) that zeroing and (b)
actual numbers on real loads. (not some artificial benchmark).

Because without (a) there's no way in hell I'll enable it.

And without (b), "performance" isn't actually an argument.

                  Linus
