Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A8363169B
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 22:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKTVjX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 16:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTVjW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 16:39:22 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3477927FED
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 13:39:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m22so24547486eji.10
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzuz9SRmF1vqyzZVdeMVYzpTFSn7+d7O+9mT86nYFjI=;
        b=LfjcLOrLguHJ/6ZBiHLg4bR8Oy76RDXsJfgPWDQk9DeiAqRzpjzVlCIIOedr7SEPcY
         1pbmXM0HeHJh5oeWr/88WoI5lYoY1NcNuZyQ8fVIhlSZtdWGJBGGDYSegO/Y+s1BAM0A
         FGVh0BdCbseOI2TiIuiBDpGvu/SFAMXyP0QNXRYe10yy45rFdAcrpZTSvZNNRUMBjrpW
         7VKo1bFdV5DQBhj+busdLiQ8cRlNfxAkRVE8SuCFn6mletc6nzrNBea0prmU8Ca5HvCK
         aaherlq7ZBNdObMGbXLPXsgV6CBJtclAnHpFxt8A3LpG4AKPyAI0Av1hIhzj8jGrrS6+
         nwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzuz9SRmF1vqyzZVdeMVYzpTFSn7+d7O+9mT86nYFjI=;
        b=b1jk/d0MRcVRmNC/wsBZhf49KhMAwznjiTC5790KTe3nf2QLHIJvGgYIax5x/ufWRT
         3ZYZinJxhyKaXqdcbsrPCvdIuVKFf8NLQJs8NuR+mosl2WUnV8O9XPUngPaxeOpcw+YS
         Mo7zMZFNc6rKu39Sk7SfBcdX0ajbkaCX4iWxOzDY383HvsWaJAUXA49OCf4+7aA3aO2R
         ulo53CmIsreFrp51WBSe5yOpdFtYAj4nVXE+YrlEBNjiqNxa/nNA7qpENuw4o4+Hk1Fq
         bjyOncZ3/tOjwqDBPZ6RIxcCbynkK/mEKaNvxZd97ZzaChS4/HL/2RkpyqoOGEbLaFoP
         zcPg==
X-Gm-Message-State: ANoB5pmh/b1eXf2HHfi+e1PhHBvY4xGDiUbLkqPP+Dk6ijZwb0gQA7Yn
        M8+EeEUH/MN/TWp24BV3xMw=
X-Google-Smtp-Source: AA0mqf5Tzlu1eXiJASwAcYwOjGFNe+xUBz7sCxGbD9ChHsEQtiEGz1n9jzQw9QgZASHx+08B76d6Mg==
X-Received: by 2002:a17:906:e2cb:b0:7ad:c35a:ad76 with SMTP id gr11-20020a170906e2cb00b007adc35aad76mr13236600ejb.705.1668980359132;
        Sun, 20 Nov 2022 13:39:19 -0800 (PST)
Received: from krava ([83.240.62.198])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906539100b00734bfab4d59sm4317481ejo.170.2022.11.20.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 13:39:18 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 20 Nov 2022 22:39:16 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Song Liu <songliubraving@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin Lau <kafai@meta.com>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
 and kfunc
Message-ID: <Y3qehFg38LR0Xpes@krava>
References: <20221118154028.251399-1-jolsa@kernel.org>
 <20221118154028.251399-2-jolsa@kernel.org>
 <CAADnVQLLvwpAFTEwCw+ZdZGtZTrV7nFu3pXKMRW9irRYG9WJXw@mail.gmail.com>
 <E30FFAE3-2BC8-45F5-9CBC-D7A3C7D66B74@fb.com>
 <CAADnVQK7d-=_GWT++wvrXG9tB=hOEdFgc9Ejh76y4ZLDKd5-Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK7d-=_GWT++wvrXG9tB=hOEdFgc9Ejh76y4ZLDKd5-Rg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 06:25:15PM -0800, Alexei Starovoitov wrote:
> On Fri, Nov 18, 2022 at 5:06 PM Song Liu <songliubraving@meta.com> wrote:
> >
> >
> >
> > > On Nov 18, 2022, at 3:45 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Nov 18, 2022 at 7:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >>
> > >> Adding bpf_vma_build_id_parse function to retrieve build id from
> > >> passed vma object and making it available as bpf kfunc.
> > >>
> > >> We can't use build_id_parse directly as kfunc, because we would
> > >> not have control over the build id buffer size provided by user.
> > >>
> > >> Instead we are adding new bpf_vma_build_id_parse function with
> > >> 'build_id__sz' argument that instructs verifier to check for the
> > >> available space in build_id buffer.
> > >>
> > >> This way  we check that there's  always available memory space
> > >> behind build_id pointer. We also check that the build_id__sz is
> > >> at least BUILD_ID_SIZE_MAX so we can place any buildid in.
> > >>
> > >> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > >> ---
> > >> include/linux/bpf.h      |  4 ++++
> > >> kernel/bpf/verifier.c    | 26 ++++++++++++++++++++++++++
> > >> kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
> > >> 3 files changed, 61 insertions(+)
> > >>
> > >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > >> index 8b32376ce746..7648188faa2c 100644
> > >> --- a/include/linux/bpf.h
> > >> +++ b/include/linux/bpf.h
> > >> @@ -2805,4 +2805,8 @@ static inline bool type_is_alloc(u32 type)
> > >>        return type & MEM_ALLOC;
> > >> }
> > >>
> > >> +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> > >> +                          unsigned char *build_id,
> > >> +                          size_t build_id__sz);
> > >> +
> > >> #endif /* _LINUX_BPF_H */
> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >> index 195d24316750..e20bad754a3a 100644
> > >> --- a/kernel/bpf/verifier.c
> > >> +++ b/kernel/bpf/verifier.c
> > >> @@ -8746,6 +8746,29 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> > >>        return 0;
> > >> }
> > >>
> > >> +BTF_ID_LIST_SINGLE(bpf_vma_build_id_parse_id, func, bpf_vma_build_id_parse)
> > >> +
> > >> +static int check_kfunc_caller(struct bpf_verifier_env *env, u32 func_id)
> > >> +{
> > >> +       struct bpf_func_state *cur;
> > >> +       struct bpf_insn *insn;
> > >> +
> > >> +       /* Allow bpf_vma_build_id_parse only from bpf_find_vma callback */
> > >> +       if (func_id == bpf_vma_build_id_parse_id[0]) {
> > >> +               cur = env->cur_state->frame[env->cur_state->curframe];
> > >> +               if (cur->callsite != BPF_MAIN_FUNC) {
> > >> +                       insn = &env->prog->insnsi[cur->callsite];
> > >> +                       if (insn->imm == BPF_FUNC_find_vma)
> > >> +                               return 0;
> > >> +               }
> > >> +               verbose(env, "calling bpf_vma_build_id_parse outside bpf_find_vma "
> > >> +                       "callback is not allowed\n");
> > >> +               return -1;
> > >> +       }
> > >> +
> > >> +       return 0;
> > >> +}
> > >
> > > I understand that calling bpf_vma_build_id_parse from find_vma
> > > is your only use case, but put yourself in the maintainer's shoes.
> > > We just did an arbitrary restriction and helped a single user.
> > > How are we going to explain this to other users?
> > > Let's figure out a more generic way where this call is safe.
> > > Have you looked at PTR_TRUSTED approach that David is doing
> > > for task_struct ? Can something like this be used here?
> >
> > I guess that won't work, as the vma is not refcounted. :( This is
> > why we have to hold mmap_lock when calling task_vma programs.
> >
> > OTOH, I would image bpf_vma_build_id_parse being quite useful for
> > task_vma programs.
> 
> Of course we cannot increment non-existing refcnt in vma :)
> I meant that PTR_TRUSTED part of the concept. The kfunc
> bpf_vma_build_id_parse(struct vm_area_struct *vma, ...)
> should have KF_TRUSTED_ARGS flag
> and it will be the job of the verifier to pass a trusted vma pointer.
> Meaning that the verifier needs to guarantee that
> the pointer is safe to operate on.
> That's what I was explaining to Kumar and David earlier
> about KF_TRUSTED_ARGS semantics.
> 
> PTR_TRUSTED doesn't mean that the pointer is refcnted.
> It means that it won't disappear and we can safely pass it
> to kfunc or helpers.
> For bpf_find_vma we can mark vma pointer PTR_TRUSTED on entry
> into callback bpf prog and the prog will be able to pass it
> to bpf_vma_build_id_parse() kfunc as long as the prog doesn't
> add any offset to it.
> The implementation of bpf_find_vma() guarantees that vma ptr
> passed into callback_fn is valid.
> So it's exactly PTR_TRUSTED.
> 
> Similarly task_vma programs will be receiving PTR_TRUSTED pointers too
> and will be able to call bpf_vma_build_id_parse() kfunc as well.
> Any place where we can guarantee the safety of the pointer
> we should be marking it as PTR_TRUSTED.
> 
> David's series start with marking all tp_btf arguments as PTR_TRUSTED.
> Doing this for iterators, bpf_find_vma callback
> will be a continuation of PTR_TRUSTED logic.

ok, sounds much better.. generic solution for both bpf_find_vma
and task_vma iterator

thanks,
jirka
