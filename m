Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CFF630810
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 01:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbiKSAnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 19:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiKSAmT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 19:42:19 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C774ECB969
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 15:45:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kt23so16638251ejc.7
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 15:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eBFL9wq2nZkW7X0Q2zdG9W86tLX7y7ySVfYRMnkhs48=;
        b=qg1W6BJbQ7TfjJsSAw5toek8vhksnMJ1jgG6vej7bL8BOOH83oGzase0uv0laRqmZe
         +Fvj+kRLZVkQdtCDoJeDn72AKhHlUeEpwU7JOnO6y2liSx7lqiifPr0labUnLvLnGuh0
         /pZCurDFYnbez6EqZtyN1s7xe3tDRBjgS7rUhdId6SewHji2w7cQp4j/Wm4POnU+gHKu
         3bWkbQjI8KrMJUA01apV8WjH36IsJBYt/ROrVcci0b0R18IfoUDI/6ng4JptAoHzRq0A
         Bz9HpI+QHchljOfwOygiDE396/mWeYvRQBOYGmMSAk0bIam9oqjDVbpg/GsDPP2lD/lD
         nSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBFL9wq2nZkW7X0Q2zdG9W86tLX7y7ySVfYRMnkhs48=;
        b=8I5Gkhnx1XKTzjFkW2CMLHVHQX92Y8qqTAUly1BNtz88Gj8VZRt5pAOq0Q7JNlJVvL
         J3wf7Paw5RMv6WC74sQ8wfWRpU3/5owHUB5dlYuYQ2w/qmqzS8UZW/N0igDCPC1MhCBH
         g6L7ovTPx6WaGuBJdg2Sg7opECz6GvGcUCEo+Is3enOJH/cuEIn1qf3cT8S9YN9T8F0X
         sfh6VxVNrZziTEk64YOHNB6ly2SbvT4IM3SPWfdu+gQUtYur04RgpDrz1NVdVVhx+sRB
         3Q+W0c7ryofIY+3ArL0v1Nldq0dIpwomKI3vo7dtFmlLc0UYfuDZvP6KEZVeDbwRjOT4
         Cu5w==
X-Gm-Message-State: ANoB5pmVQ8tubzPRA1KwYKb5v2Rr5Lz9nnvrQ0Un1ml8Lm1qQqyTKah0
        hSaC9kAhUSyesh60XCGbznHi+Z51kdWofcRYY0Q=
X-Google-Smtp-Source: AA0mqf5oB9sCs8lqmwqPH0QvpAVN7xoAbcVAZCFWi2/xyL1zCPdhnZHc9Xx46R8Zzz2l0G5ZukEgyibraaSjIlgcqBA=
X-Received: by 2002:a17:906:4ed9:b0:7ae:664a:a7d2 with SMTP id
 i25-20020a1709064ed900b007ae664aa7d2mr7945943ejv.676.1668815112113; Fri, 18
 Nov 2022 15:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20221118154028.251399-1-jolsa@kernel.org> <20221118154028.251399-2-jolsa@kernel.org>
In-Reply-To: <20221118154028.251399-2-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 18 Nov 2022 15:45:00 -0800
Message-ID: <CAADnVQLLvwpAFTEwCw+ZdZGtZTrV7nFu3pXKMRW9irRYG9WJXw@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
 and kfunc
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Fri, Nov 18, 2022 at 7:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding bpf_vma_build_id_parse function to retrieve build id from
> passed vma object and making it available as bpf kfunc.
>
> We can't use build_id_parse directly as kfunc, because we would
> not have control over the build id buffer size provided by user.
>
> Instead we are adding new bpf_vma_build_id_parse function with
> 'build_id__sz' argument that instructs verifier to check for the
> available space in build_id buffer.
>
> This way  we check that there's  always available memory space
> behind build_id pointer. We also check that the build_id__sz is
> at least BUILD_ID_SIZE_MAX so we can place any buildid in.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h      |  4 ++++
>  kernel/bpf/verifier.c    | 26 ++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8b32376ce746..7648188faa2c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2805,4 +2805,8 @@ static inline bool type_is_alloc(u32 type)
>         return type & MEM_ALLOC;
>  }
>
> +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> +                          unsigned char *build_id,
> +                          size_t build_id__sz);
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 195d24316750..e20bad754a3a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8746,6 +8746,29 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>         return 0;
>  }
>
> +BTF_ID_LIST_SINGLE(bpf_vma_build_id_parse_id, func, bpf_vma_build_id_parse)
> +
> +static int check_kfunc_caller(struct bpf_verifier_env *env, u32 func_id)
> +{
> +       struct bpf_func_state *cur;
> +       struct bpf_insn *insn;
> +
> +       /* Allow bpf_vma_build_id_parse only from bpf_find_vma callback */
> +       if (func_id == bpf_vma_build_id_parse_id[0]) {
> +               cur = env->cur_state->frame[env->cur_state->curframe];
> +               if (cur->callsite != BPF_MAIN_FUNC) {
> +                       insn = &env->prog->insnsi[cur->callsite];
> +                       if (insn->imm == BPF_FUNC_find_vma)
> +                               return 0;
> +               }
> +               verbose(env, "calling bpf_vma_build_id_parse outside bpf_find_vma "
> +                       "callback is not allowed\n");
> +               return -1;
> +       }
> +
> +       return 0;
> +}

I understand that calling bpf_vma_build_id_parse from find_vma
is your only use case, but put yourself in the maintainer's shoes.
We just did an arbitrary restriction and helped a single user.
How are we going to explain this to other users?
Let's figure out a more generic way where this call is safe.
Have you looked at PTR_TRUSTED approach that David is doing
for task_struct ? Can something like this be used here?
