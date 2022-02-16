Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790AF4B9034
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 19:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiBPSaL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 13:30:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiBPSaK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 13:30:10 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BB128D3B0
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 10:29:57 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id l8so2641793pls.7
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 10:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4cZ/7PS0kfyMUM7VoHaon64Yw9JeoQxHvW5uWuKTudU=;
        b=ETAd6bnhlrE0oAv0PkgwBAJfe4zRnf+xTaq1BvWoqcsIUO/IiIBW9my++iH2eTLl84
         XEM0j/AO7KTTPwfODrQG6p5TB/wbd7w3al+J3k/qf6DPU5lBKQ9B0bJFOVfdGEel5KGj
         M+7eHt6ooJAkI++opb1xdV4jpK+l7BDNMqPs6SPV1v/JpPqvmdt/PwXEgB8asBaGO7kY
         eypDv0f9vkB0t8vXAGnrIS5v0xSLFEXNHRgtmYafae9/rm0mwCj5sm0wllmS+oohEE5X
         TW3PJ+Sf7jt1zlAuF8hp1WrYAdzERxR5ChQHSeACDwNkG+V5HEifdx7aAelKxGwiUToU
         IkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4cZ/7PS0kfyMUM7VoHaon64Yw9JeoQxHvW5uWuKTudU=;
        b=xEYCsivnWBt+szExDufmcCWnNAlNrbkrWjPMa0oJJ45vSjvSBYt7S3ep/ZMxBRuJKZ
         i+G8+fe2/e1Hs+W71MohkTn/fJLLpyPvwVVTrIFrEjrNzXlOhXmomO4Cq2+ERji8FUFK
         HVSzp4WSMmk/BhSkExV/9BIVLTvte2FArTtW0NzHj0TJtu8d3KEXtIwjfA/9AqaRa5ts
         zxiiNNuOi9dpFapGyHQXCFH7lLgRhP3qzV3fX2TAxN/1Nj8xUsXmtaSaXrsJUGxsU2aj
         JKCuFBANghKG+GDD37QSV9buNrLU/kNNhG3wjseIkGnvHTPC9ipa+GD7KG4Ag2DgLUHf
         VIqA==
X-Gm-Message-State: AOAM533B9nW6xgLmBfZZsv2OpShc7to6/dlNC3L2obEs6Q2+tp9JLfBS
        S4KIvtv2WOCukROmyM5TpBY=
X-Google-Smtp-Source: ABdhPJzCcuYKoT3xDjliQWfIDtQIf2MHRKdds4XBHkJbmvawWQNVPEIYnueJDJp+6s+/IltVDMvIQw==
X-Received: by 2002:a17:90b:1bcf:b0:1b9:b03f:c34c with SMTP id oa15-20020a17090b1bcf00b001b9b03fc34cmr3199837pjb.141.1645036197256;
        Wed, 16 Feb 2022 10:29:57 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id z1sm44772337pfh.137.2022.02.16.10.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 10:29:56 -0800 (PST)
Date:   Wed, 16 Feb 2022 23:59:54 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Fix crash due to OOB access when reg->type >
 __BPF_REG_TYPE_MAX
Message-ID: <20220216182954.jwzrum5ivekxca72@apollo.legion>
References: <20220216091323.513596-1-memxor@gmail.com>
 <CAADnVQLnurHLFZY3tL+SL9MgnJj63JKx8KjTwSS0mzsNN6JJTw@mail.gmail.com>
 <20220216173348.luidfddtou6yfxed@apollo.legion>
 <CAADnVQJ-wMjyBQUYELYCjDTST8M5+TKRw2fi7nfrv79319fwog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ-wMjyBQUYELYCjDTST8M5+TKRw2fi7nfrv79319fwog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 16, 2022 at 11:49:54PM IST, Alexei Starovoitov wrote:
> On Wed, Feb 16, 2022 at 9:33 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed, Feb 16, 2022 at 09:15:47PM IST, Alexei Starovoitov wrote:
> > > On Wed, Feb 16, 2022 at 1:13 AM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > When commit e6ac2450d6de ("bpf: Support bpf program calling kernel
> > > > function") added kfunc support, it defined reg2btf_ids as a cheap way to
> > > > translate the verifier reg type to the appropriate btf_vmlinux BTF ID,
> > > > however commit c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with
> > > > PTR_TO_XXX | PTR_MAYBE_NULL") moved the __BPF_REG_TYPE_MAX from the last
> > > > member of bpf_reg_type enum to after the base register types, and
> > > > defined other variants using type flag composition. However, now, the
> > > > direct usage of reg->type to index into reg2btf_ids may no longer fall
> > > > into __BPF_REG_TYPE_MAX range, and hence lead to out of bounds access
> > > > and kernel crash on dereference of bad pointer.
> > > ...
> > > > [   20.488393] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000524156
> > > > [   20.489045] RBP: ffffffffa398c6d4 R08: ffffffffa14dd991 R09: 0000000000000000
> > > > [   20.489696] R10: fffffbfff484f31c R11: 0000000000000001 R12: ffff888007bf8600
> > > > [   20.490377] R13: ffff88800c2f6078 R14: 0000000000000000 R15: 0000000000000001
> > > > [   20.491065] FS:  00007fe06ae70740(0000) GS:ffff88808cc00000(0000) knlGS:0000000000000000
> > > > [   20.491782] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   20.492272] CR2: 0000000000524156 CR3: 000000000902a004 CR4: 0000000000770ef0
> > > > [   20.492925] PKRU: 55555554
> > >
> > > Please do not include a full kernel dump in the commit log.
> > > It provides no value.
> > > The first paragraph was enough.
> > >
> >
> > Ok, won't include next time.
> >
> > > > Cc: Martin KaFai Lau <kafai@fb.com>
> > > > Cc: Hao Luo <haoluo@google.com>
> > > > Fixes: c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL")
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  kernel/bpf/btf.c | 22 +++++++++++++++-------
> > > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index e16dafeb2450..416345798e0a 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -5568,13 +5568,21 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
> > > >         return btf_check_func_type_match(log, btf1, t1, btf2, t2);
> > > >  }
> > > >
> > > > -static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
> > > > +static u32 *reg2btf_ids(enum bpf_reg_type type)
> > > > +{
> > > > +       switch (type) {
> > > >  #ifdef CONFIG_NET
> > > > -       [PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> > > > -       [PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> > > > -       [PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
> > > > +       case PTR_TO_SOCKET:
> > > > +               return &btf_sock_ids[BTF_SOCK_TYPE_SOCK];
> > > > +       case PTR_TO_SOCK_COMMON:
> > > > +               return &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON];
> > > > +       case PTR_TO_TCP_SOCK:
> > > > +               return &btf_sock_ids[BTF_SOCK_TYPE_TCP];
> > > >  #endif
> > > > -};
> > > > +       default:
> > > > +               return NULL;
> > > > +       }
> > > > +}
> > > >
> > > >  /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
> > > >  static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
> > > > @@ -5688,7 +5696,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >                         }
> > > >                         if (check_ptr_off_reg(env, reg, regno))
> > > >                                 return -EINVAL;
> > > > -               } else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids[reg->type])) {
> > > > +               } else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids(reg->type))) {
> > >
> > > Just use reg2btf_ids[base_type(reg->type)] instead?
> >
> > That would be incorrect I think, then we'd allow e.g. PTR_TO_TCP_SOCK_OR_NULL
> > and treat it as PTR_TO_TCP_SOCK, while current code only wants to permit
> > non-NULL variants for these three.
>
> add && !type_flag(reg->type) ?
>

Ok, we can do that. WRT Hao's suggestion, we do allow NULL for ptr_to_mem_ok
case, so doing it for all of check_func_arg_match won't work.

> But, first, please describe how you found it.
> Tried to pass PTR_TO_BTF_ID_OR_NULL into kfunc?
> Do you have some other changes in the verifier?

Yes, was working on [0], tried to come up with a test case where verifier
printed bad register type being passed (one marked with a new flag), but noticed
that it would fall out of __BPF_REG_TYPE_MAX limit during kfunc check. Also, it
seems on non-KASAN build it actually doesn't crash sometimes, depends on what
the value at that offset is.

  [0]: https://github.com/kkdwivedi/linux/commits/btf-ptr-in-map

I was planning to send a verifier test exercising this but it seems
fixup_kfunc_btf_id support for test_verifier.c is not in bpf tree yet, so when
it is merged I will provide a small test case, it is basically this on bpf-next:

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 829be2b9e08e..5f26007ceef1 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1,3 +1,22 @@
+{
+       "calls: trigger reg->type > __BPF_REG_TYPE_MAX",
+       .insns = {
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+       BPF_EXIT_INSN(),
+       },
+       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
+       .result = REJECT,
+       .errstr = "XXX,
+       .fixup_kfunc_btf_id = {
+               { "bpf_kfunc_call_test_acquire", 3 },
+               { "bpf_kfunc_call_test_release", 5 },
+       },
+},
 {

Sending it rn I think may lead to flaky CI, so we can wait.

If all of this makes sense, should I respin?

--
Kartikeya
