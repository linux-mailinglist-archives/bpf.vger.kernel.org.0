Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C3F630ACE
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 03:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiKSClP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 21:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiKSCkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 21:40:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DF7D53BD
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 18:25:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z18so9497551edb.9
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 18:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MaAL9Vz+VBCFLmezpU+vdzF9c5PS6FN7swPL8nbCxXg=;
        b=hGibiMwef8LlV+wsNNaKZUd8zyWwbXmCIMwmGO/O7RtdnA2Kws3uZmdgWJAQRBWenF
         aY8SJ+WrvQrge0bQa89cvp11f06+JVd1SOAih0zZDHO0kfv/tRX2pLsTvcK/dx99yHqJ
         h3z+9JVYoZc6UF0ePFwekznvo7iAkvnimuuKJ17JAIBwQM5l1aLFNcxUHDXhuHF4iaIN
         UAp6VjafMlDlVcrNEw83wxCI/tNBWc9WTaxWNmzBbzvuJo3fcuSqlcyxWKdzvzvcT7Rk
         icB37klesijN3LNFQZzEvGsohTNbF9iTTPeaHaZbj+sra0Hsy3vdN6Xx4PmCFBHtubOn
         4C4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaAL9Vz+VBCFLmezpU+vdzF9c5PS6FN7swPL8nbCxXg=;
        b=xxjpfPrXLoOb8V489B9mvSkXu83U2nJpI7ByGXoiQp4NHrSL8KbO0nrDkVpMOwNfIQ
         Kqd6d3wAkdKtcP0o+H1sOnefg5JHhmgCZlESX1UFW7Li5Udwex5X1M4WWrmIEAA0Ort4
         qM253h+0ricxn8Pk79jPZ+ZFWJnezegtBdc+usCjHoZd3zUeXee4hF0u98ykCRh+6Jkq
         YdIPoX36/37a2JEXobeDRy+B0FBvPoNfdNHPj2yS/oMi2r2acrT5z9s/nDSk9XirqaAS
         GC1CvwSpJEBvWWTexpIvTDSG59toJk96HRN/4VkKQkIUGMVYXvmsGkYy8r4M293fxUI1
         drVA==
X-Gm-Message-State: ANoB5pmpbxFCcAwF6hG+5HCOYAYu1Fa5g8x/0qTP8kCd4yUMUSatl7Yj
        JsEOXkE4pzYSvpU6UEGbnd+jyOeL4o9t5KkybvsbPvG0KjQ=
X-Google-Smtp-Source: AA0mqf7HhrIg8IAUMn898jmkLEdT1Rjtfqy4h48FZKp9cl5aGajrMEgTi3TfBG4wcLzDrjU15vDlaLaVH7aPMT7lpGM=
X-Received: by 2002:a05:6402:2409:b0:45c:935b:ae15 with SMTP id
 t9-20020a056402240900b0045c935bae15mr8196041eda.357.1668824726846; Fri, 18
 Nov 2022 18:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20221118154028.251399-1-jolsa@kernel.org> <20221118154028.251399-2-jolsa@kernel.org>
 <CAADnVQLLvwpAFTEwCw+ZdZGtZTrV7nFu3pXKMRW9irRYG9WJXw@mail.gmail.com> <E30FFAE3-2BC8-45F5-9CBC-D7A3C7D66B74@fb.com>
In-Reply-To: <E30FFAE3-2BC8-45F5-9CBC-D7A3C7D66B74@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 18 Nov 2022 18:25:15 -0800
Message-ID: <CAADnVQK7d-=_GWT++wvrXG9tB=hOEdFgc9Ejh76y4ZLDKd5-Rg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
 and kfunc
To:     Song Liu <songliubraving@meta.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin Lau <kafai@meta.com>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
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

On Fri, Nov 18, 2022 at 5:06 PM Song Liu <songliubraving@meta.com> wrote:
>
>
>
> > On Nov 18, 2022, at 3:45 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 18, 2022 at 7:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >>
> >> Adding bpf_vma_build_id_parse function to retrieve build id from
> >> passed vma object and making it available as bpf kfunc.
> >>
> >> We can't use build_id_parse directly as kfunc, because we would
> >> not have control over the build id buffer size provided by user.
> >>
> >> Instead we are adding new bpf_vma_build_id_parse function with
> >> 'build_id__sz' argument that instructs verifier to check for the
> >> available space in build_id buffer.
> >>
> >> This way  we check that there's  always available memory space
> >> behind build_id pointer. We also check that the build_id__sz is
> >> at least BUILD_ID_SIZE_MAX so we can place any buildid in.
> >>
> >> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >> ---
> >> include/linux/bpf.h      |  4 ++++
> >> kernel/bpf/verifier.c    | 26 ++++++++++++++++++++++++++
> >> kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
> >> 3 files changed, 61 insertions(+)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 8b32376ce746..7648188faa2c 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -2805,4 +2805,8 @@ static inline bool type_is_alloc(u32 type)
> >>        return type & MEM_ALLOC;
> >> }
> >>
> >> +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> >> +                          unsigned char *build_id,
> >> +                          size_t build_id__sz);
> >> +
> >> #endif /* _LINUX_BPF_H */
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 195d24316750..e20bad754a3a 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -8746,6 +8746,29 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >>        return 0;
> >> }
> >>
> >> +BTF_ID_LIST_SINGLE(bpf_vma_build_id_parse_id, func, bpf_vma_build_id_parse)
> >> +
> >> +static int check_kfunc_caller(struct bpf_verifier_env *env, u32 func_id)
> >> +{
> >> +       struct bpf_func_state *cur;
> >> +       struct bpf_insn *insn;
> >> +
> >> +       /* Allow bpf_vma_build_id_parse only from bpf_find_vma callback */
> >> +       if (func_id == bpf_vma_build_id_parse_id[0]) {
> >> +               cur = env->cur_state->frame[env->cur_state->curframe];
> >> +               if (cur->callsite != BPF_MAIN_FUNC) {
> >> +                       insn = &env->prog->insnsi[cur->callsite];
> >> +                       if (insn->imm == BPF_FUNC_find_vma)
> >> +                               return 0;
> >> +               }
> >> +               verbose(env, "calling bpf_vma_build_id_parse outside bpf_find_vma "
> >> +                       "callback is not allowed\n");
> >> +               return -1;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >
> > I understand that calling bpf_vma_build_id_parse from find_vma
> > is your only use case, but put yourself in the maintainer's shoes.
> > We just did an arbitrary restriction and helped a single user.
> > How are we going to explain this to other users?
> > Let's figure out a more generic way where this call is safe.
> > Have you looked at PTR_TRUSTED approach that David is doing
> > for task_struct ? Can something like this be used here?
>
> I guess that won't work, as the vma is not refcounted. :( This is
> why we have to hold mmap_lock when calling task_vma programs.
>
> OTOH, I would image bpf_vma_build_id_parse being quite useful for
> task_vma programs.

Of course we cannot increment non-existing refcnt in vma :)
I meant that PTR_TRUSTED part of the concept. The kfunc
bpf_vma_build_id_parse(struct vm_area_struct *vma, ...)
should have KF_TRUSTED_ARGS flag
and it will be the job of the verifier to pass a trusted vma pointer.
Meaning that the verifier needs to guarantee that
the pointer is safe to operate on.
That's what I was explaining to Kumar and David earlier
about KF_TRUSTED_ARGS semantics.

PTR_TRUSTED doesn't mean that the pointer is refcnted.
It means that it won't disappear and we can safely pass it
to kfunc or helpers.
For bpf_find_vma we can mark vma pointer PTR_TRUSTED on entry
into callback bpf prog and the prog will be able to pass it
to bpf_vma_build_id_parse() kfunc as long as the prog doesn't
add any offset to it.
The implementation of bpf_find_vma() guarantees that vma ptr
passed into callback_fn is valid.
So it's exactly PTR_TRUSTED.

Similarly task_vma programs will be receiving PTR_TRUSTED pointers too
and will be able to call bpf_vma_build_id_parse() kfunc as well.
Any place where we can guarantee the safety of the pointer
we should be marking it as PTR_TRUSTED.

David's series start with marking all tp_btf arguments as PTR_TRUSTED.
Doing this for iterators, bpf_find_vma callback
will be a continuation of PTR_TRUSTED logic.
