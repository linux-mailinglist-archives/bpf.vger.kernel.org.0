Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D96689C4
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 03:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjAMCxw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 21:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbjAMCxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 21:53:51 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BC4621B8;
        Thu, 12 Jan 2023 18:53:44 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-4c24993965eso260475977b3.12;
        Thu, 12 Jan 2023 18:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n4UdFo28uMYLyCAO4nmLiFZ02apirYGxi6nCHRL8URg=;
        b=otO1HRCGZMKipld93GoTIiElDh5MVKSxfZQqQmvNvqZ9ZgzuTS7V5eiRNfFVDITFSj
         8p1JLntEK0mbfyL0IxzRmDrsDRsRMIJqaF7eehP3wgpA9h5ulpNRxtAIjuyfZWouvwFZ
         KyE3xv3G0NFdsWcyKPZrOgqA/F/DHnH4RYmW510feSkwiRBhM0cOEjHPz4ZES0hFGRd7
         efhQEJcRf7Jc0L6RnKGdsCgOIA7+wyNylBfa2popkqwT9eCGYpdUVNpq+vWbReCt6gd0
         vVnAqGi00LE4Exk4Hcyg41ErIeF0WGQrRj02Hhrxe/bjY+sF2TwZZ/2xwTyDbdoKLGDk
         4gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4UdFo28uMYLyCAO4nmLiFZ02apirYGxi6nCHRL8URg=;
        b=CXazotm7iaUSyTHte6HqG3tedxhLj7OijjCFMJC/2BQipu5V2Nb0nk0cSWsGSmx/DG
         xpnm89GlizxEeY39NeOK5vv7691Qg5H0mDvdi3s9SRLIu1tqugGxS4y51mzS430Jw59E
         8KAzm5nO3n4cx8zObxWbQSWDCDbkggsxrDFuacz/2Bml/MkXJa1GZ4/PdLzVTtuK9O14
         nZu2+WK423S5eTYqYYkKledUj6iRn1oI+fTa5temiPxv4WvsQ40OozNXn6VPGuI3TDd3
         GilBLRGNMpcozg3rw6sq1jr1C9hgWPTdjuGfFMhJ1N6HzZyuaELmvaiIaQhRlGPH3fYW
         /fDQ==
X-Gm-Message-State: AFqh2krdlw1VapMUchada3H7va0HLiKbpKovPTKS2SyOlHAVn8vY5b9I
        yg8FOXCz+k+LFcbnx4LfPGY0B5gz/V6YcHMgS9UJHUR0UYt0hQ==
X-Google-Smtp-Source: AMrXdXv21UYLiIMxXMDA63maXZwC/cVF7JepaP28tI33Nq7xbnQLiNKcE0OuQvojGaCG/OjhbVriW3eyTA3lVm4Vjoc=
X-Received: by 2002:a81:528d:0:b0:4d2:b5c6:c9c with SMTP id
 g135-20020a81528d000000b004d2b5c60c9cmr1454432ywb.118.1673578423687; Thu, 12
 Jan 2023 18:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com> <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com> <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
In-Reply-To: <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 13 Jan 2023 10:53:32 +0800
Message-ID: <CADxym3avw2SQZyeO_CZoUUwkDefGK8zqNRc=1Yganb2ADwpRZA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: resolve kernel function name optimization for kprobe
To:     Alan Maguire <alan.maguire@oracle.com>
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

On Thu, Jan 12, 2023 at 6:20 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 12/01/2023 07:23, Yonghong Song wrote:
> >
> >
> > On 1/9/23 7:11 PM, Menglong Dong wrote:
> >> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
> >>>
> >>>
> >>>
> >>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
> >>>> From: Menglong Dong <imagedong@tencent.com>
> >>>>
> >>>> The function name in kernel may be changed by the compiler. For example,
> >>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
> >>>>
> >>>> This kind optimization can happen in any kernel function. Therefor, we
> >>>> should conside this case.
> >>>>
> >>>> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
> >>>> kallsyms and check if there is a similar function end with '.xxx', and
> >>>> retry.
> >>>
> >>> This might produce incorrect result, so this approach won't work
> >>> for all .isra.0 cases. When a function name is changed from
> >>> <func> to <func>.isra.<num>, it is possible that compiler may have
> >>> make some changes to the arguments, e.g., removing one argument,
> >>> chaning a semantics of argument, etc. if bpf program still
> >>> uses the original function signature, the bpf program may
> >>> produce unexpected result.
> >>
> >> Oops, I wasn't aware of this part. Can we make this function disabled
> >> by default and offer an option to users to enable it? Such as:
> >>
> >>      bpf_object_adapt_sym(struct bpf_object *obj)
> >>
> >> In my case, kernel function rename is common, and I have to
> >> check all functions and do such adaptation before attaching
> >> my kprobe programs, which makes me can't use auto-attach.
> >>
> >> What's more, I haven't seen the arguments change so far, and
> >> maybe it's not a common case?
> >
> > I don't have statistics, but it happens. In general, if you
> > want to attach to a function like <foo>, but it has a variant
> > <foo>.isra.<num>, you probably should check assembly code
> > to ensure the parameter semantics not changed, and then
> > you can attach to kprobe function <foo>.isra.<num>, which
> > I assume current libbpf infrastructure should support it.
> > After you investigate all these <foo>.isra.<num> functions
> > and confirm their argument semantics won't change, you
> > could use kprobe multi to do attachment.
> >
>
> I crunched some numbers on this, and discovered out of ~1600
> .isra/.constprop functions, 76 had a missing argument. The patch series
> at [1] is a rough attempt to get pahole to spot these, and add
> BTF entries for each, where the BTF representation reflects
> reality by skipping optimized-out arguments. So for a function
> like
>
> static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
>                                const struct in6_addr *gw_addr, u32 tbid,
>                                int flags, struct fib6_result *res);
>
> Examining the BTF representation using pahole from [1], we see
>
> int ip6_nh_lookup_table.isra.0(struct net *net, struct fib6_config *cfg, struct in6_addr *gw_addr, u32 tbid, int flags);
>
> Comparing to the definition, we see the last parameter is missing,
> i.e. the "struct fib6_result *" argument is missing. The calling pattern -
> where the callers have a struct fib6_result on the stack and pass a pointer -
> is reflected in late DWARF info which shows the argument is not actually
> passed as a register, but can be expressed as an offset relative to the current
> function stack (DW_OP_fbreg).
>
> This approach howvever introduces the problem that currently the kernel
> doesn't  allow a "." in a function name. We can fix that, but any BTF encoding
> that introduced optimized functions containing a  "." would have to be opt-in
> via a pahole option, so we do not generate invalid vmlinux BTF for kernels
> without that change.
>
> An alternative approach would be to simply encode .isra functions
> in BTF without the .isra suffix (i.e. using "function_name" not
> "function_name.isra"), only doing the BTF encoding if no arguments were
> optimized out - i.e. if the function signature matches expectations.
> The 76 functions with optimized-out parameters could simply be skipped.
> To me that feels like the simpler approach - it avoids issues
> with function name BTF encoding, and with that sort of model a
> loose-matching kallsyms approach - like that described here - could be used
> for kprobes and fentry/fexit. It also fits with the DWARF representation -
> the .isra suffixes are not present in DWARF representations of the function,
> only in the symbol table and kallsyms, so perhaps BTF should follow suit
> and not add the suffixes. What do you think?

This idea sounds great to me too, which makes the kernel function
consistent to users. As for the functions with optimized-out parameters,
I think that skipping them is acceptable, as they might produce incorrect
results to users.

Thanks!
Menglong Dong

>
> Alan
>
> [1] https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:optimized
> >>
> >> (Please just ignore this reply if it doesn't work :/ )
> >>
> >> Thanks!
> >> Menglong Dong
> >>>
> >>>>
> >>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> >>>> ---
> >>>>    tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++++++++++++++++++++-
> >>>>    1 file changed, 36 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >>>> index a5c67a3c93c5..fdfb1ca34ced 100644
> >>>> --- a/tools/lib/bpf/libbpf.c
> >>>> +++ b/tools/lib/bpf/libbpf.c
> >>>> @@ -10375,12 +10375,30 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >>>>        return libbpf_err_ptr(err);
> >>>>    }
> >>>>
> >>>> +struct kprobe_resolve {
> >>>> +     char pattern[128];
> >>>> +     char name[128];
> >>>> +};
> >>>> +
> >>>> +static int kprobe_kallsyms_cb(unsigned long long sym_addr, char sym_type,
> >>>> +                           const char *sym_name, void *ctx)
> >>>> +{
> >>>> +     struct kprobe_resolve *res = ctx;
> >>>> +
> >>>> +     if (!glob_match(sym_name, res->pattern))
> >>>> +             return 0;
> >>>> +     strcpy(res->name, sym_name);
> >>>> +     return 1;
> >>>> +}
> >>>> +
> >>>>    static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> >>>>    {
> >>>>        DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
> >>>> +     struct kprobe_resolve res = {};
> >>>>        unsigned long offset = 0;
> >>>>        const char *func_name;
> >>>>        char *func;
> >>>> +     int err;
> >>>>        int n;
> >>>>
> >>>>        *link = NULL;
> >>>> @@ -10408,8 +10426,25 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
> >>>>
> >>>>        opts.offset = offset;
> >>>>        *link = bpf_program__attach_kprobe_opts(prog, func, &opts);
> >>>> +     err = libbpf_get_error(*link);
> >>>> +
> >>>> +     if (!err || err != -ENOENT)
> >>>> +             goto out;
> >>>> +
> >>>> +     sprintf(res.pattern, "%s.*", func);
> >>>> +     if (!libbpf_kallsyms_parse(kprobe_kallsyms_cb, &res))
> >>>> +             goto out;
> >>>> +
> >>>> +     pr_warn("prog '%s': trying to create %s '%s+0x%zx' perf event instead\n",
> >>>> +             prog->name, opts.retprobe ? "kretprobe" : "kprobe",
> >>>> +             res.name, offset);
> >>>> +
> >>>> +     *link = bpf_program__attach_kprobe_opts(prog, res.name, &opts);
> >>>> +     err = libbpf_get_error(*link);
> >>>> +
> >>>> +out:
> >>>>        free(func);
> >>>> -     return libbpf_get_error(*link);
> >>>> +     return err;
> >>>>    }
> >>>>
> >>>>    static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link)
