Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628C752277F
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 01:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiEJXUH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 19:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbiEJXUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 19:20:03 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D531289BDB
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 16:19:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j12so307996ila.12
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6FmjKIwcCgjrTVNoBlmFquHutE6K153srrhtK/CB1k=;
        b=bIyvDlqkMNc01lw6uJpNaL+CE7fQWFkWQSZMVXEwax5uutRbU4WxmjgbwsRlgzpBzm
         1y+h9JjKydf+N6P5oiaMn1nmUbIAMYPZCM25YmqYfH0tRpJnv2Lun80PF4y8lCTNAE6C
         S6k4ET63z5unqf5KeWlfTA9rTNGcz/EgaUNw3xsdHfPONl6XIY+xNJzYPc+noaqrWcwR
         vj8hB6DTeyg0Q+ULnvr0o+v9bWVhg88Bg/iSQl0+dZ8Bc94+jfEiO4NB97TWXMD0Q++r
         aG+2DzGPddSvd1B2x9MOJTI8tLjs1bn97dRkQ02Pq/749Bju3zUTB89Z2aVExuC/o3sa
         aAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6FmjKIwcCgjrTVNoBlmFquHutE6K153srrhtK/CB1k=;
        b=oHUstEzCqzHjrwrep1Wbu3b/iJIuPhrH6/p/xlEIRd0ze1FAuSf8tNE5cx8H3yYYlm
         dpOHLrczaZlYfcEECDlDGIutY0ezUU0ce1AyGAQ4KcZNMS8RS2ix431QKWmfRaTiMxBK
         ff+DFDsAS/c5GEQU1LxLNdCSIncTF4hseXqLWQPpJ13UDeVcR4YXs3yRq7i9B7PrDMG2
         Pc9ftvuzmYGNYqmqJkuKaz88ZICDBE6p0mZGJ3v0E/iq7+3ppCJEcPFsbKMsyXHLWjX7
         FlymabSMLONARK1BNEbkc7QwUMJ1/3KCvGkV96LfXtSeiyGl8e6qdNE4ikdhhPPfSISL
         bHEA==
X-Gm-Message-State: AOAM533FZGrqBi05uozs/1KJDFYFG53Oi2aFqxoYoVBb5ROEQ0B7vedk
        9rqgumxcWgD74m/6qpVeSVRaVyBgeTEYyQrka/rTpbh2
X-Google-Smtp-Source: ABdhPJztIryNZJ2O0WH7mtV1SEXah96A1fkRzheTltPcchp0KoCJqmxTDZzywp+a9szN/jjPidg0G9yNOo0NQokVJhQ=
X-Received: by 2002:a05:6e02:11a3:b0:2cf:90f9:30e0 with SMTP id
 3-20020a056e0211a300b002cf90f930e0mr6808874ilj.252.1652224792933; Tue, 10 May
 2022 16:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190012.2577087-1-yhs@fb.com>
 <CAEf4BzYyUUjVYEcDJ75DWyg4HoOm4YbFSy84OY01WgENdWrh8A@mail.gmail.com> <7246362c-8eca-027e-d43d-8d4955ad5bdd@fb.com>
In-Reply-To: <7246362c-8eca-027e-d43d-8d4955ad5bdd@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 May 2022 16:19:42 -0700
Message-ID: <CAEf4BzZuLHc=LFV8Gpp7KQ8dGB8gi4TjOBznqo2b9mLq4QENPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/12] libbpf: Permit 64bit relocation value
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

On Tue, May 10, 2022 at 3:14 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/9/22 3:37 PM, Andrii Nakryiko wrote:
> > On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Currently, the libbpf limits the relocation value to be 32bit
> >> since all current relocations have such a limit. But with
> >> BTF_KIND_ENUM64 support, the enum value could be 64bit.
> >> So let us permit 64bit relocation value in libbpf.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/lib/bpf/relo_core.c | 24 ++++++++++++------------
> >>   tools/lib/bpf/relo_core.h |  4 ++--
> >>   2 files changed, 14 insertions(+), 14 deletions(-)
> >>
> >
> > [...]
> >
> >> @@ -929,7 +929,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
> >>                          int insn_idx, const struct bpf_core_relo *relo,
> >>                          int relo_idx, const struct bpf_core_relo_res *res)
> >>   {
> >> -       __u32 orig_val, new_val;
> >> +       __u64 orig_val, new_val;
> >>          __u8 class;
> >>
> >>          class = BPF_CLASS(insn->code);
> >> @@ -954,14 +954,14 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
> >>                  if (BPF_SRC(insn->code) != BPF_K)
> >>                          return -EINVAL;
> >>                  if (res->validate && insn->imm != orig_val) {
> >> -                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %u, exp %u -> %u\n",
> >> +                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %u, exp %llu -> %llu\n",
> >>                                  prog_name, relo_idx,
> >>                                  insn_idx, insn->imm, orig_val, new_val);
> >
> > %llu is not valid formatter for __u64 on all architectures, please add
> > explicit (unsigned long long) cast
>
> Okay, will do.
>
> >
> > but also in general for non-ldimm64 instructions we need to check that
> > new value fits in 32 bits
>
> The real 64-bit value can only be retrieved for ldimm64 insn, so I
> suppose it should be fine here. But let me double check.

So, technically (I don't think that happens in practice, though), you
can have ALU operation with a local 32-bit enum with some reasonable
value, which in the kernel is actually ENUM64 with huge value.

>
> >
> > [...]
> >
> >> @@ -1026,7 +1026,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
> >>
> >>                  imm = insn[0].imm + ((__u64)insn[1].imm << 32);
> >>                  if (res->validate && imm != orig_val) {
> >> -                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %u -> %u\n",
> >> +                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
> >>                                  prog_name, relo_idx,
> >>                                  insn_idx, (unsigned long long)imm,
> >>                                  orig_val, new_val);
> >> @@ -1035,7 +1035,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
> >>
> >>                  insn[0].imm = new_val;
> >>                  insn[1].imm = 0; /* currently only 32-bit values are supported */
> >
> > as Dave mentioned, not anymore, so this should take higher 32-bit of new_val
>
> Will do.
>
> >
> >
> >> -               pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %u\n",
> >> +               pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
> >>                           prog_name, relo_idx, insn_idx,
> >>                           (unsigned long long)imm, new_val);
> >>                  break;
> >> @@ -1261,7 +1261,7 @@ int bpf_core_calc_relo_insn(const char *prog_name,
> >>                           * decision and value, otherwise it's dangerous to
> >>                           * proceed due to ambiguity
> >>                           */
> >> -                       pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %u != %s %u\n",
> >> +                       pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %llu != %s %llu\n",
> >>                                  prog_name, relo_idx,
> >>                                  cand_res.poison ? "failure" : "success", cand_res.new_val,
> >>                                  targ_res->poison ? "failure" : "success", targ_res->new_val);
> [...]
