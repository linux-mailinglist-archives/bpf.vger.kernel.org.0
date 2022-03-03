Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B104CC6BB
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 21:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiCCUDV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 15:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiCCUDU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 15:03:20 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792CB13F8E
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 12:02:32 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 11so5589461qtt.9
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 12:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaScE8GyebyU6r3WCtmrMsrGmQSEIWA8j66ZS3wi93M=;
        b=ej+018mnUowGx/lkTywzhkGAlos+1Ico9tU5gHKUYkppZqTFf0jh1jSvQV7VsAnOBk
         7qS0JImypN6LJH07/0uooDW7qslSO+tifcorqA3ucIm/A8zX5U7f+Hf+sOhDRRAGp7qr
         Xvzmf/OBKE96a0gZx+TYI8IZX2hJoFZbR8lrZWaorVh+qRORi385T2LurXm9WcGxAV63
         B8pDf23gAyVADvzuI3yaQ0hWnys+9DhSxLq2DSQeC8du8ep+70QFQuiG5hDaUi9LSmMA
         V/aWeK9pLc9uHCCNwaQP2eKGOUrgIs7wklIe7FWA8qMYNNK4AjXcnWUmdzGTj6Tkd7Vr
         4ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaScE8GyebyU6r3WCtmrMsrGmQSEIWA8j66ZS3wi93M=;
        b=x9LzJUUdcVABpg1rMJyHlJllcPNtCrKqGdLP8MEntOZ5LLLObUHdLLPB+qV4kgkYJK
         paMd8jUUDFze0lggeWU+SBKxSP+9++fgM4cwCOKOQURZ4nAhTZT75HyfVCldR2pD3xD/
         R3+T1ELFeUX3pcGFUj+U/tt4b9DnsNk0hrZ4xQjtNwuwA0D1REjFDXsI3XWaKxN7jAXB
         cKO4g+TeLSStRxdQeGbmx+pDNhLM9mcGA6aNN/fO6x+OKwkecaoBF7jHV5VFtY1Bvozl
         +OuxA6TidEgkdDMoKYjMOU19qTv3twqpMDtm0Mcq4879v5PVUg6C//+eqpxwhOH2uRoh
         +GRA==
X-Gm-Message-State: AOAM533swt8NBDDU6L2AjZodLYL6y1n7goC5nQQGSZUI9t+jVfjLAPKf
        n+baV68SM1IEohmPZFeIfDISpcArylKryUUg8Vxnfw==
X-Google-Smtp-Source: ABdhPJyHxQpGbx5CYUvBHzuf9uDpy7o9cKCStiKEoT6uBEzSIyBq9PM2pDz7INHaEJmsYE0D9x4nKj1i8nVzHls4suo=
X-Received: by 2002:a05:622a:170f:b0:2de:1b24:dc1f with SMTP id
 h15-20020a05622a170f00b002de1b24dc1fmr28264061qtk.299.1646337751707; Thu, 03
 Mar 2022 12:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-9-haoluo@google.com>
 <a4a23560-8a63-90f6-ad1c-c2d5c761e7e6@fb.com>
In-Reply-To: <a4a23560-8a63-90f6-ad1c-c2d5c761e7e6@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Mar 2022 12:02:20 -0800
Message-ID: <CA+khW7iR4-D60TYJ0Ehz-XGz8S6sqf14nQa9WqyYLucCc-04iQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks Yonghong,

On Wed, Mar 2, 2022 at 2:00 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/25/22 3:43 PM, Hao Luo wrote:
> > Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
> > iter doesn't iterate a set of kernel objects. Instead, it is supposed to
> > be parameterized by a cgroup id and prints only that cgroup. So one
> > needs to specify a target cgroup id when attaching this iter.
> >
> > The target cgroup's state can be read out via a link of this iter.
> > Typically, we can monitor cgroup creation and deletion using sleepable
> > tracing and use it to create corresponding directories in bpffs and pin
> > a cgroup id parameterized link in the directory. Then we can read the
> > auto-pinned iter link to get cgroup's state. The output of the iter link
> > is determined by the program. See the selftest test_cgroup_stats.c for
> > an example.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >   include/linux/bpf.h            |   1 +
> >   include/uapi/linux/bpf.h       |   6 ++
> >   kernel/bpf/Makefile            |   2 +-
> >   kernel/bpf/cgroup_iter.c       | 141 +++++++++++++++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h |   6 ++
> >   5 files changed, 155 insertions(+), 1 deletion(-)
> >   create mode 100644 kernel/bpf/cgroup_iter.c
> >
[...]
> > +static const struct bpf_iter_seq_info cgroup_iter_seq_info = {
> > +     .seq_ops                = &cgroup_iter_seq_ops,
> > +     .init_seq_private       = cgroup_iter_seq_init,
> > +     .fini_seq_private       = cgroup_iter_seq_fini,
>
> Since cgroup_iter_seq_fini() is a nop, you can just have
>         .fini_seq_private       = NULL,
>

Sounds good. It looks weird to have .init without .fini. This may
indicate a bug somewhere. .attach and .detach the same. I see that you
pointed out a bug in a followed reply and the fix has paired attach
and detach. That explains something. :)

> > +void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
> > +                              struct seq_file *seq)
> > +{
> > +     char buf[64] = {0};
>
> Is this 64 the maximum possible cgroup path length?
> If there is a macro for that, I think it would be good to use it.
>

64 is something I made up. There is a macro for path length. Let me
use that in v2.

> > +
> > +     cgroup_path_from_kernfs_id(aux->cgroup_id, buf, sizeof(buf));
>
> cgroup_path_from_kernfs_id() might fail in which case, buf will be 0.
> and cgroup_path will be nothing. I guess this might be the expected
> result. I might be good to add a comment to clarify in the code.
>

No problem.

>
> > +     seq_printf(seq, "cgroup_id:\t%lu\n", aux->cgroup_id);
> > +     seq_printf(seq, "cgroup_path:\t%s\n", buf);
> > +}
> > +
> > +int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
> > +                                struct bpf_link_info *info)
> > +{
> > +     info->iter.cgroup.cgroup_id = aux->cgroup_id;
> > +     return 0;
> > +}
> > +
> > +DEFINE_BPF_ITER_FUNC(cgroup, struct bpf_iter_meta *meta,
> > +                  struct cgroup *cgroup)
> > +
> > +static struct bpf_iter_reg bpf_cgroup_reg_info = {
> > +     .target                 = "cgroup",
> > +     .attach_target          = bpf_iter_attach_cgroup,
> > +     .detach_target          = bpf_iter_detach_cgroup,
>
> The same ehre, since bpf_iter_detach_cgroup() is a nop,
> you can replace it with NULL in the above.
>
> > +     .show_fdinfo            = bpf_iter_cgroup_show_fdinfo,
> > +     .fill_link_info         = bpf_iter_cgroup_fill_link_info,
> > +     .ctx_arg_info_size      = 1,
> > +     .ctx_arg_info           = {
> > +             { offsetof(struct bpf_iter__cgroup, cgroup),
> > +               PTR_TO_BTF_ID },
> > +     },
> > +     .seq_info               = &cgroup_iter_seq_info,
> > +};
> > +
> > +static int __init bpf_cgroup_iter_init(void)
> > +{
> > +     bpf_cgroup_reg_info.ctx_arg_info[0].btf_id = bpf_cgroup_btf_id[0];
> > +     return bpf_iter_reg_target(&bpf_cgroup_reg_info);
> > +}
> > +
> [...]
