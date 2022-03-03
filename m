Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4E4CC611
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 20:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiCCTiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 14:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiCCTiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 14:38:22 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12776547
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 11:37:34 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id jv12so4930564qvb.10
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 11:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLz6jo4x58h2g9mHNukYRMIkhrbbw9vzkVWIa2i7m3Q=;
        b=M2wy4Eequ/VYrHh7vqbtylJTihfO5wHVfscRBSvANAAaHg6MttPacF5n578ODHmCHi
         raE5o+IETL5qV+2giWFnOU8WvjBnPHV4oq5mmGlnOBMa79WNfGBNMbLrEthPd5htrKT0
         Jvkuhx8rCSD9MuClXK3vxXhJUNPLM2vE0sER/Li+ms27dFJHEHi1AT2ayM7SabjAiZLX
         JWv/Ll3w8nEXZNQAz5yfdD6lfeip7k8vaX2pUgqOu3L2YLgFoRdKz7wORrE1OuaBkCVB
         EulaUDUwhKUFlICPIbvoQXMTe0xcwj2fZLptvqrXiAld3zWNc+yZBfbktLlFFZ3iihFG
         Ar+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLz6jo4x58h2g9mHNukYRMIkhrbbw9vzkVWIa2i7m3Q=;
        b=pTud5ZPSse7Lbg/77wB/SfvtVlIyWzjR5Ruvmzv8b7lh+h4kqE9OkXxhPERjAjailO
         spst8TuPA0Xh6hva+34fRYdU583S/jVAmy48UR5+5hWz944yTUP/fE9Ci3isr06YTzaX
         M0YjW2rU4qQjqB/mXrIDa794/8AY/wBKK9oFCMhLlt87buPr4bqmLJNWKs4e3ruGF+UT
         2lWM5ssx5evdxDopUokKW78m+4uFM48TSDYGY1G+N4eGUnk+VwIvoW49kl7Pqg7oxmLV
         cygztk/FqefdUaG8C9I8n8jCSP+gANCGqk5XPF9NxSbzpx06eON8k3GxIzUurrxBv1cB
         608Q==
X-Gm-Message-State: AOAM5329sOiLfYDk1qZAnxCY0XKY7elvmQdNEyHEcZyaDG2o1uHd7Hcq
        6Mh0nK2TJy4xTMFsJ4E8HNTWdrhFZ3/1KEko+lRODg==
X-Google-Smtp-Source: ABdhPJzAKtHy6Tgp6w3t1ZoHaLPWIK8SWJOD/Nb+X0nKgGN6oeKpnBh5ekYZNlunAUUhtsWXA58X4YKjLdnh7G34qLg=
X-Received: by 2002:a05:6214:202f:b0:432:4810:1b34 with SMTP id
 15-20020a056214202f00b0043248101b34mr25370584qvf.35.1646336253632; Thu, 03
 Mar 2022 11:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-5-haoluo@google.com>
 <20220302194141.c4gvqz5v4mmmbwsv@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220302194141.c4gvqz5v4mmmbwsv@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Mar 2022 11:37:21 -0800
Message-ID: <CA+khW7iRP8b69usnAy_j4hrYE-U0hC4Rv65K5m4wuP5ArnWsEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 2, 2022 at 11:41 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 25, 2022 at 03:43:34PM -0800, Hao Luo wrote:
> > diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> > index e7c2276be33e..c73c7ab3680e 100644
> > --- a/include/linux/tracepoint-defs.h
> > +++ b/include/linux/tracepoint-defs.h
> > @@ -51,6 +51,7 @@ struct bpf_raw_event_map {
> >       void                    *bpf_func;
> >       u32                     num_args;
> >       u32                     writable_size;
> > +     u32                     sleepable;
>
> It increases the size for all tracepoints.
> See BPF_RAW_TP in include/asm-generic/vmlinux.lds.h
> Please switch writeable_size and sleepable to u16.

No problem.

> >
> > -static const struct bpf_func_proto *
> > -syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > +/* Syscall helpers that are also allowed in sleepable tracing prog. */
> > +const struct bpf_func_proto *
> > +tracing_prog_syscall_func_proto(enum bpf_func_id func_id,
> > +                             const struct bpf_prog *prog)
> >  {
> >       switch (func_id) {
> >       case BPF_FUNC_sys_bpf:
> >               return &bpf_sys_bpf_proto;
> > -     case BPF_FUNC_btf_find_by_name_kind:
> > -             return &bpf_btf_find_by_name_kind_proto;
> >       case BPF_FUNC_sys_close:
> >               return &bpf_sys_close_proto;
> > -     case BPF_FUNC_kallsyms_lookup_name:
> > -             return &bpf_kallsyms_lookup_name_proto;
> >       case BPF_FUNC_mkdir:
> >               return &bpf_mkdir_proto;
> >       case BPF_FUNC_rmdir:
> >               return &bpf_rmdir_proto;
> >       case BPF_FUNC_unlink:
> >               return &bpf_unlink_proto;
> > +     default:
> > +             return NULL;
> > +     }
> > +}
>
> If I read this correctly the goal is to disallow find_by_name_kind
> and lookup_name from sleepable tps. Why? What's the harm?

A couple of thoughts, please correct me if they don't make sense. I
may think too much.

1. The very first reason is, I don't know the use case of them in
tracing. So I think I can leave them right now and add them later if
the maintainers want them.

2. A related question is, do we actually want all syscall helpers to
be in sleepable tracing? Some helpers may cause re-entering the
tracepoints. For a hypothetical example, if we call mkdir while
tracing some tracepoints in vfs_mkdir. Do we have protection for this?
Another potential problem is about lookup_name in particular,
sleepable_tracing could be triggered by any user, will lookup_name
leak kernel addresses to users in some way? The filesystem helpers
have some basic perm checks, I would think it's relatively safer.
