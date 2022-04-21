Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4350A496
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbiDUPr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390351AbiDUPrs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 11:47:48 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDAE13E90
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 08:44:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w5so6276953lji.4
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSC/5Oarouj/IhL754LRTmrVdMvDDrWtXfrr59Z4nhk=;
        b=PUkYGIZ7ik5E9H8lnQqVXvgb0eGPjMYQ3O+Z1xj74HOz3+1ncR35ixTv8UGZI5JWZA
         cs+cNoP3Yrf91evx+8ZuL6EnE7+dJ2Ia89gpjl/iQcdVzIiw7H6duMF7mHEZaWT4lWgt
         UrVcdYkaY9nTaKfvi4Xzp9b+c1qMCNNWfAVHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSC/5Oarouj/IhL754LRTmrVdMvDDrWtXfrr59Z4nhk=;
        b=cuhHKwoo9ay9B5XswcR0YZD9PVHz6CwIfC1ZEKgGh2jr/kbmVuZDmMzHX2Dh9z1lqz
         WKbhCvuRrYU6NfOkSYja7848HGKr9bq1ge3QoI9pxLgfFgSYYsxNY3IsT/bcCXvdqQ+x
         YyzzpklWlTFDWY7m0qPrBICSKBnVF7kbReG+w7Xk17qA0odISRFTP0kIl96kueN0gGw7
         3eIRAkGFD1F+g9FRRdWQeFxsyPiOliCNVk2JuGU7VlzULYJcDyv/pNO4CJ9lCcbyxH/M
         5iAc0BxWHL9V1df/NOdYAuz5+TVhzCFR4a94tJlIpT8Llm1BAmMubvh+jWK4Gc7q2JZv
         zNFA==
X-Gm-Message-State: AOAM5312p0D7umSRO+ixov3TJtQixbrlPznEQsxBvavjh52BxMOX5+RV
        rfHH3N4EigINJ3RHgCPk7RlWWF/H8VVRS1v8FpY=
X-Google-Smtp-Source: ABdhPJzuc4WcAU//LB0U/391NyROK/QUXx7FXsS3rEbA83b9YO+K2iFAMWhM9h4ZgyZ63dXUhFbxPQ==
X-Received: by 2002:a2e:bf1d:0:b0:247:dea7:f657 with SMTP id c29-20020a2ebf1d000000b00247dea7f657mr198647ljr.454.1650555896407;
        Thu, 21 Apr 2022 08:44:56 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n3-20020a056512310300b00471d362f8d1sm96473lfb.241.2022.04.21.08.44.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 08:44:51 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x17so9419048lfa.10
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 08:44:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr77831lfv.27.1650555890298; Thu, 21 Apr
 2022 08:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
 <1650511496.iys9nxdueb.astroid@bobo.none> <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
 <1650530694.evuxjgtju7.astroid@bobo.none>
In-Reply-To: <1650530694.evuxjgtju7.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 08:44:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_D0o7YLYDpW-m3HgD7HeHR45L7UYxWi2iYdc5n99P3A@mail.gmail.com>
Message-ID: <CAHk-=wi_D0o7YLYDpW-m3HgD7HeHR45L7UYxWi2iYdc5n99P3A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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
        Mike Rapoport <rppt@kernel.org>,
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

On Thu, Apr 21, 2022 at 1:57 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Those were (AFAIKS) all in arch code though.

No Nick, they really weren't.

The bpf issue with VM_FLUSH_RESET_PERMS means that all your arguments
are invalid, because this affected non-architecture code.

So the bpf case had two independent issues: one was just bpf doing a
really bad job at making sure the executable mapping was sanely
initialized.

But the other was an actual bug in that hugepage case for vmalloc.

And that bug was an issue on power too.

So your "this is purely an x86 issue" argument is simply wrong.
Because I'm very much looking at that power code that says "oh,
__module_alloc() needs more work".

Notice?

Can these be fixed? Yes. But they can't be fixed by saying "oh, let's
disable it on x86".

Although it's probably true that at that point, some of the issues
would no longer be nearly as noticeable.

                  Linus
