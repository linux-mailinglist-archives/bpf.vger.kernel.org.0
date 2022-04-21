Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4161F509704
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 07:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbiDUFvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 01:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355430AbiDUFva (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 01:51:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322412754
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 22:48:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p10so6733599lfa.12
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9b5jBflzggfzAqpilsQ3cgeetEBu+zmZUTEStBQLTg=;
        b=aJVQF93EoxUgAr6y80PEHphqgGX/lXqnHarYrsjx2H1pDtSf32ATDs9IspUDQm7j9b
         mW2JllHJRcsWjDZyLKdMEiYWo0UOYgul/fPhHOyGjZuz4YXgf1s6cxBXngG6CTkZyfar
         5p8zDSWMN7hmx4Z8y61hjflCRv3P8+r05YOQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9b5jBflzggfzAqpilsQ3cgeetEBu+zmZUTEStBQLTg=;
        b=OGWoSn54YDaPIEh4A7AVxoOt/995TsUWVFJIOJqZdoGRQKgg+WfJsLhesgXxSW8KOi
         GvbJXtSIwtDEzEmYBbKGpFGNH4IH/Tww+DCxEXKcMwqnEVIfcXIUo4O3P48DdgRJuHij
         Ndb8Sg2aUy2EYX9g+DERPkH1Fv8uXxUziNxgEkeux5BpIdRNJhs5dydtVZLlzVX/5vXR
         5kO6WExwncIcraaJ413LlJD0e3sstpAOhyZQiqQgP6NLo3X4UVdiUlMSqHyZrS1YI+DS
         uqoPNvV1htGtJefNWgLsfBfeQgwr4ycVWOngtvtvTWX7O3qL0waM+ZC20/aCwU/CYIz3
         teJw==
X-Gm-Message-State: AOAM531rPW82LeqniNSYPcPXAMZ8hRawBdFc46QqaqxtZRG60E7oZWjP
        7xo+4FhshtDehQB+NsKMUhQy/8FTo1RE2lXoH1s=
X-Google-Smtp-Source: ABdhPJyhOF+9RIV87NB106Y4zfQ7COVnsYKca46XLMJtAMZ4tBJB7RqLJbZTYx1u0aG+4mM2p4hntA==
X-Received: by 2002:a05:6512:31d6:b0:471:be25:422d with SMTP id j22-20020a05651231d600b00471be25422dmr4239350lfe.583.1650520119636;
        Wed, 20 Apr 2022 22:48:39 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q24-20020a2e9698000000b0024dc3ec14eesm809990lji.63.2022.04.20.22.48.37
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 22:48:37 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id c15so4430406ljr.9
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 22:48:37 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr14909260ljh.152.1650520116613; Wed, 20
 Apr 2022 22:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com> <1650511496.iys9nxdueb.astroid@bobo.none>
In-Reply-To: <1650511496.iys9nxdueb.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Apr 2022 22:48:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
Message-ID: <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "song@kernel.org" <song@kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 20, 2022 at 8:25 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Why not just revert fac54e2bfb5b ?

That would be stupid, with no sane way forward.

The fact is, HUGE_VMALLOC was badly misdesigned, and enabling it on
x86 only ended up showing the problems.

It wasn't fac54e2bfb5b that was the fundamental issue. It was the
whole "oh, we should never have done it that way to begin with".

The whole initial notion that HAVE_ARCH_HUGE_VMALLOC means that there
must be no PAGE_SIZE pte assumptions was simply broken. There were
actual real cases that had those assumptions, and the whole "let's
just change vmalloc behavior by default and then people who don't like
it can opt out" was just fundamentally a really bad idea.

Power had that random "oh, we don't want to do this for module_alloc",
which you had a comment about "more testing" for.

And s390 had a case of hardware limitations where it didn't work for some cases.

And then enabling it on x86 turned up more issues.

So yes, commit fac54e2bfb5b _exposed_ things to a much larger
audience. But all it just made clear was that your original notion of
"let's change behavior and randomly disable it as things turn up" was
just broken.

Including "small" details like the fact that apparently
VM_FLUSH_RESET_PERMS didn't work correctly any more for this, which
caused issues for bpf, and that [PATCH 4/4]. And yes, there was a
half-arsed comment ("may require extra work") to that effect in the
powerpc __module_alloc() function, but it had been left to others to
notice separately.

So no. We're not going back to that completely broken model. The
lagepage thing needs to be opt-in, and needs a lot more care.

               Linus
