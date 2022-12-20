Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06886528C5
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 23:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiLTWLo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 17:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLTWLn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 17:11:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC3B1EC;
        Tue, 20 Dec 2022 14:11:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m19so19517993edj.8;
        Tue, 20 Dec 2022 14:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/2atre4fqcaQWMoy90Y5c5y8r7zl/7TlfkEDDKjaPc=;
        b=XcL2vSQOhOS8sMQoxX+9NInFqIHnIBx83y5aUKny/mrm9vhhZ5p6KDDT5A9GB40o8c
         HAJ+O+ZfQFNLfb3tGHVEK4ROaUvSsgjvThmFyE6aQtROVkiSrmR1CCEdsEltJ+hRp66x
         M/b2OA1JggnbVJQKzlrdSUdrsJmXHHHqj3CLvKJQR4ZY3xu6rBSSvdB+Ij5izOkZebgd
         QW8knvlVtKsh/lDsGO4l1Y2gGoQHbAefTmEOdGa7eJOtYdPMpLX1JvCCJy7wpZ7C/UFK
         zCgZXtZg4+0aLv15j1aW5OoLOrysGeGPqj1PEgccDuAEmCEEDY5cWN99+GUL7iXkgVEQ
         1fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/2atre4fqcaQWMoy90Y5c5y8r7zl/7TlfkEDDKjaPc=;
        b=Dw/9E6P19/VPCrFo3QdRtWyh/CUL2txldFEiNSP3fLlKEa3fxWuVqv1nPZMg+iBzhj
         ebqcbxo65wnoMndTR5OzS6S/Glo/zV38GW1k9s1E52un2mUiyhZqjP8vDAav94qahtam
         ApuH/NLItxyGKydl27mPKlfUQBjqQCPRv0QCZ9zvgdMOfPXV3+f6Wi+pqWG7hEspznql
         IgxVIQA0FZN0iJUixAJGvXozcpSFVZLZSJaGh2sOn7BJMDj6fILxA1aj9Q5zi/jj2ZhQ
         SY5YZL1duWGZUkIhpFPJtGLWL4uyc5mai8qSEs5Yaa3lcqL+mdGVSH3nDjdudP10Rq1Y
         l1yA==
X-Gm-Message-State: ANoB5pn9mak/Vc8Iodqxp6QGFHOnyynd0fzbl5KkL+SXgZUmOTeMwiV8
        MUd1NZlI0vs7hyUEQysC8KRzPVNU/PGOJ8gZ1MQ=
X-Google-Smtp-Source: AA0mqf7UVFbJnkjONnKYPvSbXdCh3YuMhG3ja1r1HUzIWRe7Q0T22Q2cY9hfkKfMZdhkNp/68jILn9lPlVsXh+Egu8U=
X-Received: by 2002:a05:6402:2421:b0:461:524f:a8f4 with SMTP id
 t33-20020a056402242100b00461524fa8f4mr89321779eda.260.1671574301228; Tue, 20
 Dec 2022 14:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20221215005315.186787-1-connoro@google.com> <0fc1e9bd-e70b-28a2-bc09-629414a619b0@meta.com>
In-Reply-To: <0fc1e9bd-e70b-28a2-bc09-629414a619b0@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 14:11:28 -0800
Message-ID: <CAEf4Bzbw4acHiWie=jgqHY63JEZosN4t_KBcQfzS=012GgGBTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: btf: limit logging of ignored BTF mismatches
To:     Yonghong Song <yhs@meta.com>
Cc:     "Connor O'Brien" <connoro@google.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
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

On Thu, Dec 15, 2022 at 9:06 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 12/14/22 4:53 PM, Connor O'Brien wrote:
> > Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
> > mismatches are expected and module loading should proceed
> > anyway. Logging with pr_warn() on every one of these "benign"
> > mismatches creates unnecessary noise when many such modules are
> > loaded. Instead, handle this case with a single log warning that BTF
> > info may be unavailable.
> >
> > Mismatches also result in calls to __btf_verifier_log() via
> > __btf_verifier_log_type() or btf_verifier_log_member(), adding several
> > additional lines of logging per mismatched module. Add checks to these
> > paths to skip logging for module BTF mismatches in the "allow
> > mismatch" case.
> >
> > All existing logging behavior is preserved in the default
> > CONFIG_MODULE_ALLOW_BTF_MISMATCH=n case.
> >
> > Signed-off-by: Connor O'Brien <connoro@google.com>
>
> Ack with a few nits below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> > v2:
> > - Use pr_warn_once instead of skipping logging entirely
> > - Also skip btf verifier logs for ignored mismatches
> >
> > v1: https://lore.kernel.org/bpf/20221109024155.2810410-1-connoro@google.com/
> > ---
> >   kernel/bpf/btf.c | 24 +++++++++++++++++++++---
> >   1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index f7dd8af06413..16b959b49595 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -1404,6 +1404,13 @@ __printf(4, 5) static void __btf_verifier_log_type(struct btf_verifier_env *env,
> >       if (log->level == BPF_LOG_KERNEL && !fmt)
> >               return;
> >
> > +     /*
> > +      * Skip logging when loading module BTF with mismatches permitted
> > +      */
>
> Just use one line for the above comment.
>
> > +     if (env->btf->base_btf && env->btf->kernel_btf &&
> > +         IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
> > +             return;
>
> I believe env->btf->base_btf alone is enough to test it should be a
> module btf. If env->btf->base_btf is true, env->btf->kernel_btf should
> also be true. The other way is not true, env->btf->kernel_btf is true,
> the btf could be vmlinux (env->btf->base_btf == NULL) or be a module.
>

Seems like we are also using log->level == BPF_LOG_KERNEL check for
when working with kernel BTFs, so let's stick to the same pattern?


> > +
> >       __btf_verifier_log(log, "[%u] %s %s%s",
> >                          env->log_type_id,
> >                          btf_type_str(t),
> > @@ -1443,6 +1450,14 @@ static void btf_verifier_log_member(struct btf_verifier_env *env,
> >
> >       if (log->level == BPF_LOG_KERNEL && !fmt)
> >               return;
> > +
> > +     /*
> > +      * Skip logging when loading module BTF with mismatches permitted
> > +      */
>
> Same, just use one line for the above comments.
>
> > +     if (env->btf->base_btf && env->btf->kernel_btf &&
> > +         IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
> > +             return;
> > +
> >       /* The CHECK_META phase already did a btf dump.
> >        *
> >        * If member is logged again, it must hit an error in
> > @@ -7260,11 +7275,14 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
> >               }
> >               btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
> >               if (IS_ERR(btf)) {
> > -                     pr_warn("failed to validate module [%s] BTF: %ld\n",
> > -                             mod->name, PTR_ERR(btf));
> >                       kfree(btf_mod);
> > -                     if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
> > +                     if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
> > +                             pr_warn("failed to validate module [%s] BTF: %ld\n",
> > +                                     mod->name, PTR_ERR(btf));
> >                               err = PTR_ERR(btf);
> > +                     } else {
> > +                             pr_warn_once("Kernel module BTF mismatch detected, BTF debug info may be unavailable for some modules\n");
> > +                     }
> >                       goto out;
> >               }
> >               err = btf_alloc_id(btf);
