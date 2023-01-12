Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4755366684C
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 02:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjALBLc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 20:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjALBLb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 20:11:31 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC151EED6;
        Wed, 11 Jan 2023 17:11:29 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u19so41105861ejm.8;
        Wed, 11 Jan 2023 17:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+gYyemxct/NzbTgoCTlFkgwzOoas/DR4UvIn6tW4Kck=;
        b=ZBP9ujloBdzWXhICQF4IdBNB1BPOxCybuMOlIUYfDLq+Gy5mqa/fz5BE7yFQtGB+/K
         IRU12stfL7jd2LzKWw9JqgU2xK/p75i2uGgnuSHsraxOOBLGA+BTk4bKIeNiqjxiOUE+
         g97yeVp+0jYb0fHeNTz1o1wNsM5EerfK9G/j/m/5Rxcrmni/42QurT1jg0j5Sl41SmFv
         hJCGoY7v+rpteCdoBVIqYIc4M0dNdJIYH0AmCbSQsmI7/8YPk2A9LCF2NNTu6qR0sZIL
         FWI4bPAOeFgwsLUVKw1d4W5NQKAAAVhOev519MbIwW4GISHxiY735MPBIbpLxyAJ2GR1
         58tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gYyemxct/NzbTgoCTlFkgwzOoas/DR4UvIn6tW4Kck=;
        b=nwBMGPp/+T9udEtATKxyvQXa3fyenIjkw2ijw/Bh9EC9dRgu9LWBBzQOtn9TBO4MjW
         pPVzIsRBE8y9RcCSVaI8CrajWituz4RIWue6grbdFPvVPMXb1jDW+9dlB1/lz6qczr54
         yzL/mq1UTFh8JvZJit+scrlSFnLZ/tIJQ1qO+eTAA/Uzxgu5EuodOg6dr8HxbivoXccY
         IYzXVZ2DiZLzQKAJjMkvzwRcJzG8keT0rRrXEmr+ZTSH4cPVGy0oy2YkWU0rtVM/+F8k
         7e4xPLGgqW2fSNxK1UQ4N+JopBe/M1BTWoGecjKoEyq1aw0WW866LJIa3N0zecprL4QB
         Bivw==
X-Gm-Message-State: AFqh2kqvB9DvolZ0tUQGSqYja2y7VguYOFbUCL3RdOlZr6a8GE7rmnVY
        SQvyrAwUpTSP/KkEZ4AYI5+6bmCmRR+cy1bdc9U=
X-Google-Smtp-Source: AMrXdXsLiRR0/kBgToywxBQKxaD7MDW9gWFKY+IBnSQ4aJrU36lK1veM2MqUifVR/DKx+iZFPiBExByZ1Q1BqPjk3UA=
X-Received: by 2002:a17:906:75a:b0:855:d6ed:60d8 with SMTP id
 z26-20020a170906075a00b00855d6ed60d8mr606212ejb.302.1673485887821; Wed, 11
 Jan 2023 17:11:27 -0800 (PST)
MIME-Version: 1.0
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com> <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
In-Reply-To: <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Jan 2023 17:11:15 -0800
Message-ID: <CAEf4Bzb7iK8z-gGV_snM0LuSPEJXXDUZgvg1WeXu_TXu7ZHEMg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: resolve kernel function name optimization for kprobe
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
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

On Mon, Jan 9, 2023 at 7:11 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
> >
> >
> >
> > On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
> > > From: Menglong Dong <imagedong@tencent.com>
> > >
> > > The function name in kernel may be changed by the compiler. For example,
> > > the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
> > >
> > > This kind optimization can happen in any kernel function. Therefor, we
> > > should conside this case.
> > >
> > > If we failed to attach kprobe with a '-ENOENT', then we can lookup the
> > > kallsyms and check if there is a similar function end with '.xxx', and
> > > retry.
> >
> > This might produce incorrect result, so this approach won't work
> > for all .isra.0 cases. When a function name is changed from
> > <func> to <func>.isra.<num>, it is possible that compiler may have
> > make some changes to the arguments, e.g., removing one argument,
> > chaning a semantics of argument, etc. if bpf program still
> > uses the original function signature, the bpf program may
> > produce unexpected result.
>
> Oops, I wasn't aware of this part. Can we make this function disabled
> by default and offer an option to users to enable it? Such as:
>
>     bpf_object_adapt_sym(struct bpf_object *obj)
>
> In my case, kernel function rename is common, and I have to
> check all functions and do such adaptation before attaching
> my kprobe programs, which makes me can't use auto-attach.
>
> What's more, I haven't seen the arguments change so far, and
> maybe it's not a common case?
>
> (Please just ignore this reply if it doesn't work :/ )
>

libbpf can't just assume that in SEC("kprobe/abc") abc is meant to be
a prefix. We'd need some more explicit marker to turn this search in
kallsyms by prefix on. But also, at that point it becomes a
multi-kprobe, really, because abc* pattern can match multiple
functions.

So it's not clear how to even integrate that into a singular kprobe
program cleanly.

Can you use kprobe.multi, which already supports what you want?

> Thanks!
> Menglong Dong
> >
> > >
> > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > ---
> > >   tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 36 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index a5c67a3c93c5..fdfb1ca34ced 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -10375,12 +10375,30 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> > >       return libbpf_err_ptr(err);
> > >   }
> > >
> > > +struct kprobe_resolve {
> > > +     char pattern[128];
> > > +     char name[128];
> > > +};
> > > +
> > > +static int kprobe_kallsyms_cb(unsigned long long sym_addr, char sym_type,
> > > +                           const char *sym_name, void *ctx)
> > > +{
> > > +     struct kprobe_resolve *res = ctx;
> > > +
> > > +     if (!glob_match(sym_name, res->pattern))
> > > +             return 0;
> > > +     strcpy(res->name, sym_name);
> > > +     return 1;
> > > +}
> > > +
> > >   static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> > >   {
> > >       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
> > > +     struct kprobe_resolve res = {};
> > >       unsigned long offset = 0;
> > >       const char *func_name;
> > >       char *func;
> > > +     int err;
> > >       int n;
> > >
> > >       *link = NULL;
> > > @@ -10408,8 +10426,25 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
> > >
> > >       opts.offset = offset;
> > >       *link = bpf_program__attach_kprobe_opts(prog, func, &opts);
> > > +     err = libbpf_get_error(*link);
> > > +
> > > +     if (!err || err != -ENOENT)
> > > +             goto out;
> > > +
> > > +     sprintf(res.pattern, "%s.*", func);
> > > +     if (!libbpf_kallsyms_parse(kprobe_kallsyms_cb, &res))
> > > +             goto out;
> > > +
> > > +     pr_warn("prog '%s': trying to create %s '%s+0x%zx' perf event instead\n",
> > > +             prog->name, opts.retprobe ? "kretprobe" : "kprobe",
> > > +             res.name, offset);
> > > +
> > > +     *link = bpf_program__attach_kprobe_opts(prog, res.name, &opts);
> > > +     err = libbpf_get_error(*link);
> > > +
> > > +out:
> > >       free(func);
> > > -     return libbpf_get_error(*link);
> > > +     return err;
> > >   }
> > >
> > >   static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link)
