Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018C86637BD
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 04:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjAJDLn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 22:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjAJDLm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 22:11:42 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B89315F04;
        Mon,  9 Jan 2023 19:11:41 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-476e643d1d5so138801307b3.1;
        Mon, 09 Jan 2023 19:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VqPkyqucvhXXbhtXozLAL9TWcFvcuJMd55Kn4s4jUEU=;
        b=SuvWW3/Tj6tpFJDCHUwFFEQdZQeMsha5c3vK4PcZQH4s9E3EdveKZwfAm2RzY9h61x
         Qva/qdSZgC9LmtlhWd5gSrTZK4d7vAAVceeewN3Y2w72lbyl2X/5EGuVKm8axq57xe4I
         GRVDtC9OX2qaTUack6Y/I3bXrJvqLnfJpGNgbLsi6VCe6PZH/WQb4SIETGvG/Zjk0KBu
         wpD4GKXAlrMGDSqf8OGWTpl4MxzSQX/Ii7xeZJgZuadbCnKMHgD2O+2OuLp584YnB17K
         6eQr8PrbH9SoL1fLzUbbPK52X0bWxFRuMD1AyyP5g5TzV5t46BkCWkrm899B3dVRE+vX
         hw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqPkyqucvhXXbhtXozLAL9TWcFvcuJMd55Kn4s4jUEU=;
        b=TDEZgzG2LfTo9iI+we+8Us++LRqUVt+O5emxTfqQrdrWNEAwIYfEssueKIgLLrKAhx
         ngMNcPIDGHklc/murCWt8EwJG0X4ZFP12IlwZNPfZy2SPKEfE5mVS+6eB7Zl0NMEluMa
         Yowx3f0CVoiha8qISz7SMVfh1ThtXiHswYWH4Mj+8yvwUtUPowfZ3xkgO8eNuBeBcP00
         lwyGYKVow2jAhwTbOv3F97oIygzEO/G+UD2HvdvHuETkdrKbhQngAmJ6LF4MFIItl/JW
         ymVJUWZHIzySe/kfJbe4pXW1Gkn6N1JFIJp0TPU4wMSXYbEVhag8sTLwVZSKoWHNSoXM
         8TxQ==
X-Gm-Message-State: AFqh2kqQlP2lBKbMbBJSASgxlCqq32/+NFMCcJd6zpqFqN+VyWnFnaYy
        EMIfK6UZ6cuiSG8kEMMP8X1+NxERxsT7jhAPyog=
X-Google-Smtp-Source: AMrXdXvFP+Ml0IK5QECA0ExhOQCC0HxWT5A1AUQi56wTx9Rt7OUyeH1iYnVw4kjhkNtavutLxJShI1pxjj069Y8SUuo=
X-Received: by 2002:a81:ac8:0:b0:4bb:7237:abf9 with SMTP id
 191-20020a810ac8000000b004bb7237abf9mr2482201ywk.74.1673320300390; Mon, 09
 Jan 2023 19:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20230109094247.1464856-1-imagedong@tencent.com> <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
In-Reply-To: <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 10 Jan 2023 11:11:29 +0800
Message-ID: <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: resolve kernel function name optimization for kprobe
To:     Yonghong Song <yhs@meta.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
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

On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > The function name in kernel may be changed by the compiler. For example,
> > the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
> >
> > This kind optimization can happen in any kernel function. Therefor, we
> > should conside this case.
> >
> > If we failed to attach kprobe with a '-ENOENT', then we can lookup the
> > kallsyms and check if there is a similar function end with '.xxx', and
> > retry.
>
> This might produce incorrect result, so this approach won't work
> for all .isra.0 cases. When a function name is changed from
> <func> to <func>.isra.<num>, it is possible that compiler may have
> make some changes to the arguments, e.g., removing one argument,
> chaning a semantics of argument, etc. if bpf program still
> uses the original function signature, the bpf program may
> produce unexpected result.

Oops, I wasn't aware of this part. Can we make this function disabled
by default and offer an option to users to enable it? Such as:

    bpf_object_adapt_sym(struct bpf_object *obj)

In my case, kernel function rename is common, and I have to
check all functions and do such adaptation before attaching
my kprobe programs, which makes me can't use auto-attach.

What's more, I haven't seen the arguments change so far, and
maybe it's not a common case?

(Please just ignore this reply if it doesn't work :/ )

Thanks!
Menglong Dong
>
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a5c67a3c93c5..fdfb1ca34ced 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10375,12 +10375,30 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >       return libbpf_err_ptr(err);
> >   }
> >
> > +struct kprobe_resolve {
> > +     char pattern[128];
> > +     char name[128];
> > +};
> > +
> > +static int kprobe_kallsyms_cb(unsigned long long sym_addr, char sym_type,
> > +                           const char *sym_name, void *ctx)
> > +{
> > +     struct kprobe_resolve *res = ctx;
> > +
> > +     if (!glob_match(sym_name, res->pattern))
> > +             return 0;
> > +     strcpy(res->name, sym_name);
> > +     return 1;
> > +}
> > +
> >   static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> >   {
> >       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
> > +     struct kprobe_resolve res = {};
> >       unsigned long offset = 0;
> >       const char *func_name;
> >       char *func;
> > +     int err;
> >       int n;
> >
> >       *link = NULL;
> > @@ -10408,8 +10426,25 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
> >
> >       opts.offset = offset;
> >       *link = bpf_program__attach_kprobe_opts(prog, func, &opts);
> > +     err = libbpf_get_error(*link);
> > +
> > +     if (!err || err != -ENOENT)
> > +             goto out;
> > +
> > +     sprintf(res.pattern, "%s.*", func);
> > +     if (!libbpf_kallsyms_parse(kprobe_kallsyms_cb, &res))
> > +             goto out;
> > +
> > +     pr_warn("prog '%s': trying to create %s '%s+0x%zx' perf event instead\n",
> > +             prog->name, opts.retprobe ? "kretprobe" : "kprobe",
> > +             res.name, offset);
> > +
> > +     *link = bpf_program__attach_kprobe_opts(prog, res.name, &opts);
> > +     err = libbpf_get_error(*link);
> > +
> > +out:
> >       free(func);
> > -     return libbpf_get_error(*link);
> > +     return err;
> >   }
> >
> >   static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link)
