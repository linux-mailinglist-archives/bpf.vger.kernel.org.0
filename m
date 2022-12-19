Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8460B6512A7
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 20:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLSTSQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 14:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiLSTRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 14:17:52 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D413F95
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:17:43 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-12c8312131fso12761508fac.4
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W6bsj/cr3pR+wiyaO2GU7w8hWIDZEuKelXudPCWyq9s=;
        b=kHXRnpZoHeCyzDAMj2OSrZNgzQ1/1g6JVdBjlI7m4IahTaRD692Yh+O0J9gGBzzHfL
         LkvJMwO39YU8/3o/MzmvW0mqc7YyErU24pSKOPQCyqlqqeAoFNIoWuqQY2t4d+HGb+N5
         wgFMTSbozycAOvOWh1AZ07kn+7audR++qRIEMll7r43nh9uwAZqM8Kinq6YdCR0LsdUU
         5QpqGfYfX0jxGs7b8//Y3U4LX6sYn6ijK+0I3yU7omiTE7RJbJceV2lpm8VZMqDW2kth
         FNdUmGRetOrcQSN3cgxsaQzKZmVeUEbJr4JU3d2RsokyxkODJGuGlJU73YiBBFRc4PQt
         0G3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6bsj/cr3pR+wiyaO2GU7w8hWIDZEuKelXudPCWyq9s=;
        b=e5YbKRxotJ5pRKo3pnVKkkDFI6Zy39X5+X7+ivfQ0kESgceg1Ru06kQIH0c1p+5vjW
         ohGulkV5Ioy5DjzeXdtV8RZ+luA7hx2Ki3gW87EPhFEph2pmo8rS8b4Gj7K6v62aE0oT
         DtThvPz64sbIuYxz+ROUXEo0OBYv69ck8WekrL7QWYjDd726PkkDp1WLk9JI/KwfGGEx
         j9EdHsorFjmxVpGFLGBixxmHHeLqOCfrrRM21IP3IVcuM9/gH3D56ZBY/l+DIkl3MA2q
         Z6Y5h7pI2fqtg1NkMh55Xno5y09Xma0bhb5Dgaq0L3kQhll3kLxpQvfYd8EM9tuDLp6W
         YOCg==
X-Gm-Message-State: AFqh2kpncvMf+Ee8zdjIntzBMNLKNfwQPzCJoiVoU3LT72GEZrDmnDeX
        aR4CJFI3FCVXKPD+qV0W7aqFwxge6oqdbpj1bgI=
X-Google-Smtp-Source: AMrXdXuHbGyWqnTkAOwSfPlvCWmk+WQ5SXVRDJ6Ts8LVzOGCJOBtNm6XpmGeiE8/aKYeZwM18+yfo6uu/uTvA2Yq5Xo=
X-Received: by 2002:a05:6870:98b1:b0:13b:1e05:a73d with SMTP id
 eg49-20020a05687098b100b0013b1e05a73dmr1130162oab.55.1671477462331; Mon, 19
 Dec 2022 11:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20221205025039.149139-1-raj.khem@gmail.com> <CAEf4BzYtGwponVcfMEK4wWgA=+jAHXzwy-gQmmvYx68MYLaQ9g@mail.gmail.com>
In-Reply-To: <CAEf4BzYtGwponVcfMEK4wWgA=+jAHXzwy-gQmmvYx68MYLaQ9g@mail.gmail.com>
From:   Khem Raj <raj.khem@gmail.com>
Date:   Mon, 19 Dec 2022 11:17:16 -0800
Message-ID: <CAMKF1soaBzj133D1MrxUsiqv5_zsTpDJ+WCnape2kJQL8qL95Q@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix build warning on ref_ctr_off
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Tue, Dec 6, 2022 at 4:14 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Dec 4, 2022 at 7:01 PM Khem Raj <raj.khem@gmail.com> wrote:
> >
> > Clang warns on 32-bit ARM on this comparision
> >
> > libbpf.c:10497:18: error: result of comparison of constant 4294967296 with expression of type 'size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
> >         if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
> >             ~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Check for platform long int to be larger than 32-bits before enabling
> > this check, it false on 32bit anyways.
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 91b7106a4a73..65cb70cdc22b 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9837,7 +9837,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
> >         char errmsg[STRERR_BUFSIZE];
> >         int type, pfd;
> >
> > -       if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
> > +       if (BITS_PER_LONG > 32 && ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
>
> Where is BITS_PER_LONG defined? Is it a compiler-provided macro? A bit
> hesitant about taking dependency on such a macro. Also quick googling
> suggests user-space programs should use __BITS_PER_LONG?

BITS_PER_LONG is in include/asm-generic/bitsperlong.h, I have sent v2
which implements your suggestion

>
> Can you try if just casting ref_ctr_off to __u64 would make this
> warning go away?
>
> >                 return -EINVAL;
> >
> >         memset(&attr, 0, attr_sz);
> > --
> > 2.38.1
> >
