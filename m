Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BC4567D74
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 06:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiGFEpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 00:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGFEpE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 00:45:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46311C928;
        Tue,  5 Jul 2022 21:45:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d2so25043935ejy.1;
        Tue, 05 Jul 2022 21:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+3Zr8k1922i3O6gpDRuS+/CsUrozZFblBDXFwK0h2o=;
        b=neuZBp92anYoq8JgFxCu1AD1UkCpJblWVpTtY410vZzN+8p9doNHGswfyZzBk070/H
         WFNiNno/5apIJQVPgpZ0yeIWIU74wxPrLQUCh7A573r/h/42QcpONZzN9dPR06Nm+DF/
         aSNpUKsQeJb1saUJFkdvj+yP5G9reQokiios9LnrvXymBStKfWuBgqWi10T6kViKkAOq
         1Ezu0cZSGcmwaGro5wSGnupmW3v/X3BbwEBcuOkS9MATWTrOfYkOBKEADWLN8REUzQVR
         WdJHfShRDDnLdes4hhmgnEU712AIYDmXLizIPj1fNM+NS7apSzeRe2ZZOR7jiKCZletW
         BVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+3Zr8k1922i3O6gpDRuS+/CsUrozZFblBDXFwK0h2o=;
        b=sC0mULuxvXASfqHBaQBFDy3NcCRj+9CtcXS/Ul8SYyve6WlNPaCNvAr4F531ckMFiT
         Qh9k0HAsYX5iFJTLOJDKjuiC19sSWUuzNR1h+l+/3EuGGsesWjRvh+CqxHzLlfyfb6qu
         Svos/s+dN3q8tYquMzd4rb6ODaQKsqaAi/hLsHEhTGWvDfvoVLg2SYYgCXJEyhV0tdSa
         8+2HbBMGRptY0fiqVqszIBsRzdbs1rgwfG6kAIqtIXD17Y5oLqwX9C4lHXX3XjHvhkPZ
         2zVqEpEfpqYiKD13ICT9ByQ6tYMbvFxDsZ8HCovQVjQAarONTBdwXB5BQxvSne5YEZnE
         Xt+g==
X-Gm-Message-State: AJIora9UPCyIL0ZZUgZHVs6tL7kpvmVUIWjnQButBKNXnE3AtlTddGcs
        QYcT2gFC+bbNyrSz8X8x/xkux6UteIoqT0OLy94=
X-Google-Smtp-Source: AGRyM1v/TZha7uOzcKNrXSwWjEEZTRPVbZY0p13lNIz6kG9qRFWe5holmXcrurBDaxtaKEIFDm/YT2fe9uSDU5MK6Yw=
X-Received: by 2002:a17:906:a3ca:b0:726:2bd2:87bc with SMTP id
 ca10-20020a170906a3ca00b007262bd287bcmr37227352ejb.226.1657082701401; Tue, 05
 Jul 2022 21:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <1656667620-18718-1-git-send-email-alan.maguire@oracle.com>
 <1656667620-18718-2-git-send-email-alan.maguire@oracle.com> <92434e1c-62f5-021f-294d-fdb3d0d4fd90@fb.com>
In-Reply-To: <92434e1c-62f5-021f-294d-fdb3d0d4fd90@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Jul 2022 21:44:50 -0700
Message-ID: <CAEf4BzbQfmrBGousq13E9S5yNB-V1m_uMYQ1R-EJGuf2OLTymw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: add a ksym BPF iterator
To:     Yonghong Song <yhs@fb.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Vernet <void@manifault.com>, swboyd@chromium.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Kenny Yu <kennyyu@fb.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Fri, Jul 1, 2022 at 10:58 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/1/22 2:26 AM, Alan Maguire wrote:
> > add a "ksym" iterator which provides access to a "struct kallsym_iter"
> > for each symbol.  Intent is to support more flexible symbol parsing
> > as discussed in [1].
> >
> > [1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
> >
> > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >   kernel/kallsyms.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 89 insertions(+)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index fbdf8d3..8b662da 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -30,6 +30,7 @@
> >   #include <linux/module.h>
> >   #include <linux/kernel.h>
> >   #include <linux/bsearch.h>
> > +#include <linux/btf_ids.h>
> >
> >   /*
> >    * These will be re-linked against their real values
> > @@ -799,6 +800,91 @@ static int s_show(struct seq_file *m, void *p)
> >       .show = s_show
> >   };
> >
> > +#ifdef CONFIG_BPF_SYSCALL
> > +
> > +struct bpf_iter__ksym {
> > +     __bpf_md_ptr(struct bpf_iter_meta *, meta);
> > +     __bpf_md_ptr(struct kallsym_iter *, ksym);
> > +};
> > +
> > +static int ksym_prog_seq_show(struct seq_file *m, bool in_stop)
> > +{
> > +     struct bpf_iter__ksym ctx;
> > +     struct bpf_iter_meta meta;
> > +     struct bpf_prog *prog;
> > +
> > +     meta.seq = m;
> > +     prog = bpf_iter_get_info(&meta, in_stop);
> > +     if (!prog)
> > +             return 0;
> > +
> > +     ctx.meta = &meta;
> > +     ctx.ksym = m ? m->private : NULL;
> > +     return bpf_iter_run_prog(prog, &ctx);
> > +}
> > +
> > +static int bpf_iter_ksym_seq_show(struct seq_file *m, void *p)
> > +{
> > +     return ksym_prog_seq_show(m, false);
> > +}
> > +
> > +static void bpf_iter_ksym_seq_stop(struct seq_file *m, void *p)
> > +{
> > +     if (!p)
> > +             (void) ksym_prog_seq_show(m, true);
> > +     else
> > +             s_stop(m, p);
> > +}
> > +
> > +static const struct seq_operations bpf_iter_ksym_ops = {
> > +     .start = s_start,
> > +     .next = s_next,
> > +     .stop = bpf_iter_ksym_seq_stop,
> > +     .show = bpf_iter_ksym_seq_show,
> > +};
> > +
> > +static int bpf_iter_ksym_init(void *priv_data, struct bpf_iter_aux_info *aux)
> > +{
> > +     struct kallsym_iter *iter = priv_data;
> > +
> > +     reset_iter(iter, 0);
> > +
> > +     iter->show_value = true;
>
> I think instead of always having show_value = true, we should have
>     iter->show_value = kallsyms_show_value(...);
>
> this is consistent with what `cat /proc/kallsyms` is doing, and
> also consistent with bpf_dump_raw_ok() used when dumping various
> kernel info in syscall.c.
>
> We don't have a file here, so credential can be from the current
> process with current_cred().

This seems wrong to use current_cred(). show_value is used to not
"leak" pointer values to unprivileged user-space, right? In our case
BPF iterator is privileged, so there is no need to hide (or mangle,
didn't check) values.

If it happens that a privileged process loads iter/ksym program and
then passes prog FD to unprivileged one to read iterator output,
iter/ksym should still get correct symbol values.

I think the initial approach with show_value = true is the right one
-- give all the information as it is to BPF iterator.


>
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_BPF_ITER_FUNC(ksym, struct bpf_iter_meta *meta, struct kallsym_iter *ksym)
> > +
> > +static const struct bpf_iter_seq_info ksym_iter_seq_info = {
> > +     .seq_ops                = &bpf_iter_ksym_ops,
> > +     .init_seq_private       = bpf_iter_ksym_init,
> > +     .fini_seq_private       = NULL,
> > +     .seq_priv_size          = sizeof(struct kallsym_iter),
> > +};
> > +
> > +static struct bpf_iter_reg ksym_iter_reg_info = {
> > +     .target                 = "ksym",
> > +     .ctx_arg_info_size      = 1,
> > +     .ctx_arg_info           = {
> > +             { offsetof(struct bpf_iter__ksym, ksym),
> > +               PTR_TO_BTF_ID_OR_NULL },
> > +     },
> > +     .seq_info               = &ksym_iter_seq_info,
> > +};
> > +
> > +BTF_ID_LIST(btf_ksym_iter_id)
> > +BTF_ID(struct, kallsym_iter)
> > +
> > +static void __init bpf_ksym_iter_register(void)
> > +{
> > +     ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
> > +     if (bpf_iter_reg_target(&ksym_iter_reg_info))
> > +             pr_warn("Warning: could not register bpf ksym iterator\n");
> > +}
> > +
> > +#endif /* CONFIG_BPF_SYSCALL */
> > +
> >   static inline int kallsyms_for_perf(void)
> >   {
> >   #ifdef CONFIG_PERF_EVENTS
> > @@ -885,6 +971,9 @@ const char *kdb_walk_kallsyms(loff_t *pos)
> >   static int __init kallsyms_init(void)
> >   {
> >       proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> > +#if defined(CONFIG_BPF_SYSCALL)
> > +     bpf_ksym_iter_register();
>
> You can inline this function here and if bpf_iter_reg_target(...)
> failed, just return the error code.
>
> > +#endif
> >       return 0;
> >   }
> >   device_initcall(kallsyms_init);
