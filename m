Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7567AA0B
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 06:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjAYFnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 00:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAYFnW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 00:43:22 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A15FCE;
        Tue, 24 Jan 2023 21:43:21 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mp20so44627821ejc.7;
        Tue, 24 Jan 2023 21:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oDtVOJ73kEBKahxq/hQ7f6VV771oO934JDeiC/vYduA=;
        b=hNzIJq3SQl0VPHRt76YQCyqInqi3HbWJ6LAxF/522oHKb6riVTlGLy1uu5cnGjvoNB
         CLyQF+26Ptm1obKIFdnkIc0ua76+3zAdJC5NCtbPk6OtN1+WuOlk3s3Tn5evObYf/n6h
         iqx6Z6QaQ23k7RaMzQlhUlNp8TlQi4KT35/zYUG1fsu7Ym3eRz9oe+npty9L1MtRRZaV
         C5lLRBq9Nf/EHvPX24NrTYbhy+8zETDvHAigE2XX+P2ydP6ovuqm0aPZxGih4B4g64bU
         mxgW0PWwM7Ld7Y21c+aHEgAv9on6M71bSF2qApD8Vg+b9/q7HKEVu4STFwKg054e6U5O
         XMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDtVOJ73kEBKahxq/hQ7f6VV771oO934JDeiC/vYduA=;
        b=3c2PhO6D7oZnWOnFbUPzomN4BPDnJ78vPQL650uQZY2i15D5dd7oawCooUGM1wEBI4
         9oU3DP62fSDi4BZxaBkNpf456iIiX+mx6XKq/I9X1URcimaSpuKlrOe1CqprYQR3NiCR
         WpXojie2IWiDwekDjSkOhcKtCh9dLUS4dAFbfxRukfiOojWeoFoXc7Oon+5K9XmqjkZo
         Bzb6rAjl0v11n2ERbC7qjuWCajiul6HgbG7kqm+5O3Nw7POddKyWwIgN7tXIrCQFoWPv
         nW9NP31EyQCJrVa6oJsCxBA8My8Q0DvtI5e1gb41EIwXdpLBw63Kd1+iT7No+kSzhJNy
         CDoA==
X-Gm-Message-State: AFqh2kpkdH00kRlDBQxxtA1jI9wwukndVN3Xgb/1YZseFcgA0V4kwlKv
        PHQGcxk6PviY+e0eJmGsUD6SVYA2ENu89QOQ07g=
X-Google-Smtp-Source: AMrXdXsQX6uvi6Z+NBKczoIE7gBRoqj3XNW1nuhgtKwk+JKe7YhETX1oUnPGoIGAeLpP5y+su90g9KvwsULhYjeQBKw=
X-Received: by 2002:a17:907:d043:b0:868:dca5:b73c with SMTP id
 vb3-20020a170907d04300b00868dca5b73cmr2869748ejc.1.1674625399693; Tue, 24 Jan
 2023 21:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20230120192523.3650503-1-void@manifault.com> <20230120192523.3650503-5-void@manifault.com>
 <20230125043602.gmpi54ixerelmzzx@iphone-mikan.dhcp.thefacebook.com> <Y9C/7fxsIPXiG6mr@maniforge>
In-Reply-To: <Y9C/7fxsIPXiG6mr@maniforge>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Jan 2023 21:43:08 -0800
Message-ID: <CAADnVQLi4ErtgFYvky9fh8Yecx_j+NSKBbC5NdfYOEowBAjr8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Enable cpumasks to be queried and
 used as kptrs
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 9:36 PM David Vernet <void@manifault.com> wrote:
>
> > The UX will be a bit worse, since bpf prog would need to do !=NULL check
> > but with future bpf_assert() we may get rid of !=NULL check.
> >
> > We can keep direct cpumask accessors as kfuncs:
> >
> > u32 bpf_cpumask_first(const struct cpumask *cpumask);
> > u32 bpf_cpumask_first_zero(const struct cpumask *cpumask);
> >
> > and add bpf_find_first_bit() and the rest of bit manipulations.
>
> Worth noting as well is that I think struct bpf_bitmap is going to be
> treated somewhat differently than struct bpf_cpumask and struct cpumask.
> There is no type-safety for bitmaps in the kernel. They're just
> represented as unsigned long *, so I don't we'll be able to allow
> programs to pass bitmaps allocated elsewhere in the kernel to read-only
> bitmap kfuncs like we do for struct cpumask *, as the verifier will just
> interpret them as pointers to statically sized scalars.

That's a good point. That's where run-time and verification-time
safety hurts UX too much.

> > Since all of the bpf_cpumask do run-time cpu_valid() check we're not
> > sacrificing performance.
> >
> > Feels more generic with wider applicability at the expense of little bit worse UX.
> > I haven't thought about acq/rel consequences.
>
> The TL;DR from me is that I agree that having bitmap kfuncs is a great
> idea, but I don't see the need to tie the two at the hip at the cost of
> a worse UX. I'd prefer to push the extra complexity into the BPF backend
> in favor of a simpler programming front-end for users.
>
> Thoughts?

Fair enough. Let's proceed with what you have.
