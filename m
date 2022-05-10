Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52E0522458
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349082AbiEJStI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 14:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349168AbiEJSrk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 14:47:40 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4265DE41
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:47:39 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i20so19525085ion.0
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vn3PZuaPlVGsuwpWE7IkTZOA5Hj/yY505d/eOF84c54=;
        b=Y29Jj5e3E2lg7N6zISfFz6cj238IaZzLCjyENryZ0FsvurUy1zjLtRKiXj7qd/AUDg
         XZRKJnMTokc2JM43qkvWZ466VujObsB7TkKr8LgSAVBemrQmVeMCb4HPOdQi8fAArM82
         kmtVg5Z4e69naeB8aMa3VD6IK24DMc/QzFuGEY02NNu2KnkJFAGSvg6oO62sPAJMWNHH
         tSGM12QbrcrV8VJVTZvfjfDZj06ONwbJSCgWuswfSGIjn5KbQQYdSfQsqv7Z9jeUhT9W
         pcLDQVISmNLfHtW1Hw7e1bDaMv9VI2Rv/3mva2Q3PvNLXbyBGkw5tfkNuLOtsWCRo8b6
         5HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vn3PZuaPlVGsuwpWE7IkTZOA5Hj/yY505d/eOF84c54=;
        b=xZBh0AupHZhI40RCSXpyErLyl2iQ1YRWB/rPh0arLFg6oqGLjr3voQqQ1e8KFKyJix
         MhmUMGwnlPlrz7IRCdppLVcKsUL3u/luLLozg20b0eTn/Xej1kfhh7IA0gXku6uRC0WP
         5CuAVtZVX5R4CnpUuMMOOXkeINPGn/QhZBeB31/XaDADo+6G7TXux7G+v/lZ6llqxLyk
         c3jQiFPacE16pdabAJKgPKLJNmOAdIqFjDPgkMangpnS+ostcd4S6DG8qwCx/qpJ351P
         TBtUQwXRQ5dvfLMtVpvVmSwJEPsNr+MwwUO06em9qN6i6C9Qcp3BbnML/RgzytOdQQ+T
         q7Sw==
X-Gm-Message-State: AOAM530OUuX251wfrUZrgL3ILGhM1OcwB7cOLSZc96wxZ+3swwjlAYzT
        X0pwRtxkFgboXB0MFJykA8VzGavFszWuBN4dx30LCHVT
X-Google-Smtp-Source: ABdhPJx8z9zGBd4R4Smc+iXhj3iZJvicu4G/0qU3i2onbNqeiYXz/oFOISyGxvXvdSzQWGUorEfnvEnLFksY4S+7/Tk=
X-Received: by 2002:a05:6638:533:b0:32a:d418:b77b with SMTP id
 j19-20020a056638053300b0032ad418b77bmr10499759jar.237.1652208459131; Tue, 10
 May 2022 11:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220509004148.1801791-1-andrii@kernel.org> <20220509004148.1801791-9-andrii@kernel.org>
 <YnqGBmOHIZhrZBFJ@dev-arch.thelio-3990X>
In-Reply-To: <YnqGBmOHIZhrZBFJ@dev-arch.thelio-3990X>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 May 2022 11:47:28 -0700
Message-ID: <CAEf4BzbnHf-tY+QAZZ=C2GuAYE4PoiLGTWarBWcrZar=3amWvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/9] libbpf: automatically fix up
 BPF_MAP_TYPE_RINGBUF size, if necessary
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 10, 2022 at 8:34 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Andrii,
>
> On Sun, May 08, 2022 at 05:41:47PM -0700, Andrii Nakryiko wrote:
> > Kernel imposes a pretty particular restriction on ringbuf map size. It
> > has to be a power-of-2 multiple of page size. While generally this isn't
> > hard for user to satisfy, sometimes it's impossible to do this
> > declaratively in BPF source code or just plain inconvenient to do at
> > runtime.
> >
> > One such example might be BPF libraries that are supposed to work on
> > different architectures, which might not agree on what the common page
> > size is.
> >
> > Let libbpf find the right size for user instead, if it turns out to not
> > satisfy kernel requirements. If user didn't set size at all, that's most
> > probably a mistake so don't upsize such zero size to one full page,
> > though. Also we need to be careful about not overflowing __u32
> > max_entries.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> <snip>
>
> > +static size_t adjust_ringbuf_sz(size_t sz)
> > +{
> > +     __u32 page_sz = sysconf(_SC_PAGE_SIZE);
> > +     __u32 i, mul;
> > +
> > +     /* if user forgot to set any size, make sure they see error */
> > +     if (sz == 0)
> > +             return 0;
> > +     /* Kernel expects BPF_MAP_TYPE_RINGBUF's max_entries to be
> > +      * a power-of-2 multiple of kernel's page size. If user diligently
> > +      * satisified these conditions, pass the size through.
> > +      */
> > +     if ((sz % page_sz) == 0 && is_pow_of_2(sz / page_sz))
> > +             return sz;
> > +
> > +     /* Otherwise find closest (page_sz * power_of_2) product bigger than
> > +      * user-set size to satisfy both user size request and kernel
> > +      * requirements and substitute correct max_entries for map creation.
> > +      */
> > +     for (i = 0, mul = 1; ; i++, mul <<= 1) {
> > +             if (mul > UINT_MAX / page_sz) /* prevent __u32 overflow */
> > +                     break;
> > +             if (mul * page_sz > sz)
> > +                     return mul * page_sz;
> > +     }
> > +
> > +     /* if it's impossible to satisfy the conditions (i.e., user size is
> > +      * very close to UINT_MAX but is not a power-of-2 multiple of
> > +      * page_size) then just return original size and let kernel reject it
> > +      */
> > +     return sz;
> > +}
>
> This patch in -next as commit 0087a681fa8c ("libbpf: Automatically fix
> up BPF_MAP_TYPE_RINGBUF size, if necessary") breaks the build with tip
> of tree LLVM due to [1] strengthening -Wunused-but-set-variable:
>
> libbpf.c:4954:8: error: variable 'i' set but not used [-Werror,-Wunused-but-set-variable]
>         __u32 i, mul;
>               ^
> 1 error generated.
>
> Should i be removed or was it intended to be used somewhere that it is
> not?

my initial implementation had some hard limit on number of iterations
which I later removed. I'll drop the i completely, thanks for pointing
out.

>
> [1]: https://github.com/llvm/llvm-project/commit/2af845a6519c9cde5c8f58db5554f8b1084ce1ed
>
> Cheers,
> Nathan
