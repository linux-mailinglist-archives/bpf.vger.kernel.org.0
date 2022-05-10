Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B05227B6
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 01:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbiEJXiQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 19:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiEJXiQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 19:38:16 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65CB4A3F1
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 16:38:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id s23so381499iog.13
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8dRTwZ5g0KrSvWxsn+HcX3dHvHDALTMeqV1i97WGWw=;
        b=ND6d3+G3dVnPBap90wsWPq3X40+bU6zZxtAqTnumMDerKLkQ0eGoMuoMJF0lBPtICe
         DICQU+QskNQ/wFGZzqSf4KCjBLsQ+C9Kiw1ugxfqTizTGJ2n3a2tMpl4/DYS6fIvwnzE
         VkFraLdxNFtcSsFaY/c+CWFJ5536ZheL1Xh/KsQALvNQvIV6TnFU3I13xmkw3HR6Hba2
         hqMA0CTtBM7i8JIbmOyvfNL42Y5/UKEnzciGc7ppvsw9V9ckXnKQSQ04943UXBh8O0x2
         PWesqB8/QD6wVUESAJLTHhvA6az7QXB9PCpHoukqxAmrmAXXOrQBZCJHFiMsaacal04V
         dN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8dRTwZ5g0KrSvWxsn+HcX3dHvHDALTMeqV1i97WGWw=;
        b=LR+meUWbW1PyJe3Wx+767MIxa9iu/V+M5wRgSYzjJkp+yrmtwcMT6DLqNwQma5iLx/
         QSDSMLNpmDVf69bhQXw1o8RNRQQw0X/aQ+9z0xAGfL7k2zkZpPl8g0w1p+Xl7sYNoth0
         S2mOVHoBupw5MnR2InsVJGLltsJeXgj2Q4QHZr0DpybBtw6/pj3IhteLfHyAfY3iNLdg
         l2+E8x/PagPSX4DS1Nw2MDQgcQkRnxzHAnrBoEi9ssHgrA6XeroEs1lRr6FEkQTwYjhI
         9d1+1NU/V1tN1py3jbdbKvhQv0HiPhoWte9Zn+/uFqxALadrM3e+7ZanIsrghzFaSSMA
         AUwg==
X-Gm-Message-State: AOAM5307zgjJB9lp+yHMDhQxE7jJDgZuPvFYxyUBU7kyCZs54xP2EM72
        YwXQBnU6mKiMzNX+EA/re1AzipFBMzSWs5kZwi0=
X-Google-Smtp-Source: ABdhPJxoS6lf6p6h+6mVbpyYlGArEU0c2cQOv4qOAEvRxTIzLfF4i1D36qI+Bw0giWh5KprmUXGPu2crytyGq5ElEZc=
X-Received: by 2002:a05:6638:16d6:b0:32b:a283:a822 with SMTP id
 g22-20020a05663816d600b0032ba283a822mr11237386jat.145.1652225894276; Tue, 10
 May 2022 16:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190023.2578209-1-yhs@fb.com>
 <CAEf4BzbXuN4YOYqm_ojgTuJMo4a+J_M6WPF=MUX1B9BK8DdmMQ@mail.gmail.com> <f9fa3310-0f63-18af-5424-b82df11c4a70@fb.com>
In-Reply-To: <f9fa3310-0f63-18af-5424-b82df11c4a70@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 May 2022 16:38:03 -0700
Message-ID: <CAEf4BzZg2e5XvE-E7mz9Vss-YJfP8SbuqogpN0837UjshBg8EA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 10, 2022 at 3:40 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/9/22 4:25 PM, Andrii Nakryiko wrote:
> > On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Add BTF_KIND_ENUM64 support. Deprecated btf__add_enum() and
> >> btf__add_enum_value() and introduced the following new APIs
> >>    btf__add_enum32()
> >>    btf__add_enum32_value()
> >>    btf__add_enum64()
> >>    btf__add_enum64_value()
> >> due to new kind and introduction of kflag.
> >>
> >> To support old kernel with enum64, the sanitization is
> >> added to replace BTF_KIND_ENUM64 with a bunch of
> >> pointer-to-void types.
> >>
> >> The enum64 value relocation is also supported. The enum64
> >> forward resolution, with enum type as forward declaration
> >> and enum64 as the actual definition, is also supported.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/lib/bpf/btf.c                           | 226 +++++++++++++++++-
> >>   tools/lib/bpf/btf.h                           |  21 ++
> >>   tools/lib/bpf/btf_dump.c                      |  94 ++++++--
> >>   tools/lib/bpf/libbpf.c                        |  64 ++++-
> >>   tools/lib/bpf/libbpf.map                      |   4 +
> >>   tools/lib/bpf/libbpf_internal.h               |   2 +
> >>   tools/lib/bpf/linker.c                        |   2 +
> >>   tools/lib/bpf/relo_core.c                     |  93 ++++---
> >>   .../selftests/bpf/prog_tests/btf_dump.c       |  10 +-
> >>   .../selftests/bpf/prog_tests/btf_write.c      |   6 +-
> >>   10 files changed, 450 insertions(+), 72 deletions(-)
> >>
> >

[...]

> >
> >
> >> +       t->size = tsize;
> >> +
> >> +       return btf_commit_type(btf, sz);
> >> +}
> >> +
> >> +/*
> >> + * Append new BTF_KIND_ENUM type with:
> >> + *   - *name* - name of the enum, can be NULL or empty for anonymous enums;
> >> + *   - *is_unsigned* - whether the enum values are unsigned or not;
> >> + *
> >> + * Enum initially has no enum values in it (and corresponds to enum forward
> >> + * declaration). Enumerator values can be added by btf__add_enum64_value()
> >> + * immediately after btf__add_enum() succeeds.
> >> + *
> >> + * Returns:
> >> + *   - >0, type ID of newly added BTF type;
> >> + *   - <0, on error.
> >> + */
> >> +int btf__add_enum32(struct btf *btf, const char *name, bool is_unsigned)
> >
> > given it's still BTF_KIND_ENUM in UAPI, let's keep 32-bit ones as just
> > btf__add_enum()/btf__add_enum_value() and not deprecate anything.
> > ENUM64 can be thought about as more of a special case, so I think it's
> > ok.
>
> The current btf__add_enum api:
> LIBBPF_API int btf__add_enum(struct btf *btf, const char *name, __u32
> bytes_sz);
>
> The issue is it doesn't have signedness parameter. if the user input
> is
>     enum { A = -1, B = 0, C = 1 };
> the actual printout btf format will be
>     enum { A 4294967295, B = 0, C = 1}
> does not match the original source.

Oh, I didn't realize that's the reason. I still like btf__add_enum()
name much better, can you please do the same macro trick that I did
for bpf_prog_load() based on the number of arguments? We'll be able to
preserve good API name and add extra argument. Once this lands we'll
need to update pahole to added signedness bit, but otherwise I don't
think there are many other users of these APIs currently (I might be
wrong, but macro magic gives us backwards compat anyway).

>
> >
> >> +{
> >> +       return btf_add_enum_common(btf, name, is_unsigned, BTF_KIND_ENUM, 4);
> >> +}
> >> +
> >
> > [...]
> >
> >>   /*

[...]

> >> @@ -764,8 +792,13 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
> >>                  if (!spec)
> >>                          return -EUCLEAN; /* request instruction poisoning */
> >>                  t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
> >> -               e = btf_enum(t) + spec->spec[0].idx;
> >> -               *val = e->val;
> >> +               if (btf_is_enum(t)) {
> >> +                       e = btf_enum(t) + spec->spec[0].idx;
> >> +                       *val = e->val;
> >> +               } else {
> >> +                       e64 = btf_enum64(t) + spec->spec[0].idx;
> >> +                       *val = btf_enum64_value(e64);
> >> +               }
> >
> > I think with sign bit we now have further complication: for 32-bit
> > enums we need to sign extend 32-bit values to s64 and then cast as
> > u64, no? Seems like a helper to abstract that is good to have here.
> > Otherwise relocating enum ABC { D = -1 } will produce invalid ldimm64
> > instruction, right?
>
> We should be fine here. For enum32, we have
> struct btf_enum {
>          __u32   name_off;
>          __s32   val;
> };
> So above *val = e->val will first sign extend from __s32 to __s64
> and then the __u64. Let me have a helper with additional comments
> to make it clear.
>

Ok, great! Let's just shorten this as I suggested below?

> >
> > Also keep in mind that you can use btf_enum()/btf_enum64() as an
> > array, so above you can write just as
> >
> > *val = btf_is_enum(t)
> >      ? btf_enum(t)[spec->spec[0].idx]
> >      : btf_enum64(t)[spec->spec[0].idx];
> >
> > But we need sign check and extension, so better to have a separate helper.
> >
> >>                  break;
> >>          default:
> >>                  return -EOPNOTSUPP;
> >> @@ -1034,7 +1067,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
> >>                  }
> >>
> >>                  insn[0].imm = new_val;
> >> -               insn[1].imm = 0; /* currently only 32-bit values are supported */
> >> +               insn[1].imm = new_val >> 32;
> >
> > for 32-bit instructions (ALU/ALU32, etc) we need to make sure that
> > new_val fits in 32 bits. And we need to be careful about
> > signed/unsigned, because for signed case all-zero or all-one upper 32
> > bits are ok (sign extension). Can we know the expected signed/unsigned
> > operation from bpf_insn itself? We should be, right?
>
> The core relocation insn for constant is
>    move r1, <32bit value>
> or
>    ldimm_64 r1, <64bit value>
> and there are no signedness information.
> So the 64bit value (except sign extension) can only from
> ldimm_64. We should be okay here, but I can double check.

not sure how full 64-bit -1 should be loaded into register then. Does
compiler generate extra sign-extending bit shifts or embedded constant
is considered to be a signed constant always?

>
> >
> >>                  pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
> >>                           prog_name, relo_idx, insn_idx,
> >>                           (unsigned long long)imm, new_val);
> >> @@ -1056,6 +1089,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
> >>    */

[...]
