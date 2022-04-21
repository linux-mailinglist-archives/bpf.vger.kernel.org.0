Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D350972F
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 08:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353216AbiDUGMe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 02:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384690AbiDUGMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 02:12:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03BB13CDB
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 23:09:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g18so7801537ejc.10
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVUWs35f4WE+aWC7FcpSq4pfrFchzLzCfgbNdTOWfy8=;
        b=VBqyRxaQG527a7fx7AgAznM8UUHxBASgzvSF4gmMRD4VYJdHUiSNVoPhgu42LoOYtS
         y6gPAHVOwwUd483vHIRxh7hbgdA8HsUg/bgP6y7Dqxs90ng2yo25hED4GNEKdgjsdXXY
         mUFQ/gnQ78Lay0jv9vKeHJr4kI/tgiaSFRcic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVUWs35f4WE+aWC7FcpSq4pfrFchzLzCfgbNdTOWfy8=;
        b=Qg0PtfF5aL/ZuaMdBQu7873mE1G171zMKvZxC05g5sZC3bpVzTu7T1+HSN7jVKGEXZ
         Yr9hANDB5DRW9urJpQx5gdbr1RHK4/XccL93mu55I3gMgg8GkWzIfO9YUI9e+3qa/fLq
         KYFj1KbOUkLaFQKkUAX6Ppa1E1z/8SRo7CgvbQyah2RvnDYH89R32lGlYJJIFZXHELt3
         8MuwvaowMuLTfujKEfEPgfMaD9YIXpIxcdJSdX1KkTgDihtqhlJM2uz5QVugJy0QNaIR
         uApX789auu6+GULby97wT+/SfnUQoI5W4XhtyCEyia0md/XRmhHOL0aR5MsNV1soNUFR
         GAbA==
X-Gm-Message-State: AOAM532Y3RkJH6KvUMiMj+j+25GzGVjiFdxdlxsknXeVdAVuEiWC0tMQ
        QWZa6ppYwvHluB7t6pnc7yM7Roa/tkvwCLomS7A=
X-Google-Smtp-Source: ABdhPJwGhPKlH3PeL8MJAvJtLbMBYJFyUuKDBQwjNayFgvh810Rl0M2KV6GVDuDkgcE25L4h+m34kA==
X-Received: by 2002:a17:907:8a14:b0:6e8:9691:62f7 with SMTP id sc20-20020a1709078a1400b006e8969162f7mr21921710ejc.497.1650521382972;
        Wed, 20 Apr 2022 23:09:42 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402231100b0041d98ed7ad8sm11074669eda.46.2022.04.20.23.09.42
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 23:09:42 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id y20so7821214eju.7
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 23:09:42 -0700 (PDT)
X-Received: by 2002:a2e:91d9:0:b0:24d:c221:4941 with SMTP id
 u25-20020a2e91d9000000b0024dc2214941mr9547564ljg.164.1650520984267; Wed, 20
 Apr 2022 23:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
 <1650511496.iys9nxdueb.astroid@bobo.none> <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Apr 2022 23:02:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYabTPnKiHgVzeKCaRkQaGVunwPbS+QeVb09Bm=YUEow@mail.gmail.com>
Message-ID: <CAHk-=wjYabTPnKiHgVzeKCaRkQaGVunwPbS+QeVb09Bm=YUEow@mail.gmail.com>
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

On Wed, Apr 20, 2022 at 10:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The lagepage thing needs to be opt-in, and needs a lot more care.

Side note: part of the opt-in really should be about the performance impact.

It clearly can be quite noticeable, as outlined by that powerpc case
in commit 8abddd968a30 ("powerpc/64s/radix: Enable huge vmalloc
mappings"), but it presumably is some _particular_ case that actually
matters.

But it's equalyl clearly not the module code/data case, since
__module_alloc() explicitly disables largepages on powerpc.

At a guess, it's one or more of the large hash-table allocations.

And it would actually be interesting to hear *which*one*. From the
'git diff' workload, I'd expect it to be the dentry lookup hash table
- I can't think of anything else that would be vmalloc'ed that would
be remotely interesting - but who knows.

So I think the whole "opt in" isn't _purely_ about the "oh, random
cases are broken for odd reasons, so let's not enable it by default".

I think it would actually be good to literally mark the cases that
matter (and have the performance numbers for those cases).

               Linus
