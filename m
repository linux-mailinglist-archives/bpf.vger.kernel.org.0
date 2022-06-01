Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC84753AF1B
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 00:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiFAVxQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 17:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiFAVxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 17:53:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A8F14D05
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 14:53:07 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v9so3375038lja.12
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eNuzdi12vGlm/9RiRHvmNZSgJVbOpWJIw4GS5I5Q4s=;
        b=HmTGJheseKdLgG0cvWLDEgdDaKSm6Wl5ngtjTFFez+9BFK4Yd91ToknHFEDvV7B+K9
         BWGl+VL8JMTmLUqnJ85WkPA5HDS6e7baljBQYzFRA1/7V4ymGHt3SBc7/B/YyK7t1ST4
         fXvE6ZTuXYiRy/a9kB+3UMWlind0Fcz5JA6UQ509NSW1OThsQXlx0DngqYshvFoj1kkV
         DHUgvwQugyUMM7z+vHrmRq2HdgU4l8Pjb7iiFAV+C5ScELdTbX8RDzippP58pSrhJaZb
         UYmOvDuphSn6t15tXqapw3eQn6O5WbEgaKn3WW+/9VeFp7tjKfTxuKHa0WmgIvxAqvuE
         lQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eNuzdi12vGlm/9RiRHvmNZSgJVbOpWJIw4GS5I5Q4s=;
        b=hZIvUCR0f2l5pyOJBrbrMYqNYmBLawIi0SCvnEUWSy0F+pavG76T/fhICcLvJLhraz
         zL2Ep3mH5xxbmsjJGF604R2r66ySjx3nMGH2eLe9qJg8CyuI/5Mgc3LefCTKv8+B/Xp7
         sZ/qJAxoSCOtV2ejDtdCVo/KZObm/eypUZ6iqSz+CxjMCxx5qXveQ6GoVITgU0wrk+RX
         pRvpVeZXeW6I4e6cFr+ZeDb5Amjw+30YIDJhZU9bc9/DoYIeh+ltI5h+K4i8ZUru3N/0
         3zqIFynfASTpH23MCCBzf6+dACmFkLnzOjxlexvlCUPHQehhf8nhiTJ6iRkUzn6A9U5g
         knnw==
X-Gm-Message-State: AOAM531ReRMWaDNez1e/YTlS9T9BuRrjK3lZyutXGqUerVgMgStJGCEB
        PldKZgWyLxlHnFwZsGC3LwooOO3EqL0unMfey7U=
X-Google-Smtp-Source: ABdhPJyHDVJekkoXaZVxv7megVKOtz/J7DR/xJU14EHdFoWMhD3ndpQqICQ8115gFVnqlDb3ru3OOeSa/MgE2ksQAMo=
X-Received: by 2002:a2e:1f12:0:b0:255:67ae:b655 with SMTP id
 f18-20020a2e1f12000000b0025567aeb655mr4697849ljf.303.1654120385947; Wed, 01
 Jun 2022 14:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220526185432.2545879-1-yhs@fb.com> <20220526185503.2548083-1-yhs@fb.com>
 <CAEf4BzaCiYvsfBLAqFKnciiL5QKKVqZp8enRbZTUUUekygCHUQ@mail.gmail.com> <4ddd80f8-24e1-2f6e-52e2-ed03af7760ed@fb.com>
In-Reply-To: <4ddd80f8-24e1-2f6e-52e2-ed03af7760ed@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Jun 2022 14:52:54 -0700
Message-ID: <CAEf4BzaPmJs=buVOoT+mTpuJPBRVhzsJYFZ5dEvwTwDRAbGOdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/18] libbpf: Add enum64 deduplication support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Jun 1, 2022 at 11:31 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/31/22 4:50 PM, Andrii Nakryiko wrote:
> > On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Add enum64 deduplication support. BTF_KIND_ENUM64 handling
> >> is very similar to BTF_KIND_ENUM.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/lib/bpf/btf.c | 62 +++++++++++++++++++++++++++++++++++++++++++--
> >>   tools/lib/bpf/btf.h |  5 ++++
> >>   2 files changed, 65 insertions(+), 2 deletions(-)
> >>
> >
> > [...]
> >
> >> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> >> index a41463bf9060..b22c648c69ff 100644
> >> --- a/tools/lib/bpf/btf.h
> >> +++ b/tools/lib/bpf/btf.h
> >> @@ -531,6 +531,11 @@ static inline bool btf_is_type_tag(const struct btf_type *t)
> >>          return btf_kind(t) == BTF_KIND_TYPE_TAG;
> >>   }
> >>
> >> +static inline bool btf_type_is_any_enum(const struct btf_type *t)
> >
> > btf_is_any_enum() for consistency with all other helpers?
>
> I am using btf_type_is_any_enum() since btf_type_is_* is the kernel
> code convention and btf_type_is_any_enum() is used in relo_core.c
> which is used by both kernel and libbpf.
>
> But I can change to btf_is_any_enum(). It should be okay.
>

Right, but all the btf_is_*() APIs are part of public libbpf API, so
we should prioritize keeping that consistent. When Alexei was adding
CO-RE logic from libbpf to kernel we had few more such naming
mismatches. I don't remember if he added #define or just a small
static wrapper, but we can do the same for kernel side.

So yeah, please do rename, thanks!


> >
> > The rest looks great!
> >
> >> +{
> >> +       return btf_is_enum(t) || btf_is_enum64(t);
> >> +}
> >> +
> >>   static inline __u8 btf_int_encoding(const struct btf_type *t)
> >>   {
> >>          return BTF_INT_ENCODING(*(__u32 *)(t + 1));
> >> --
> >> 2.30.2
> >>
