Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB79608154
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 00:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJUWHx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 18:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJUWHw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 18:07:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D79F2930B5
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:07:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id l22so10842388edj.5
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdMv55xYldZvCbOye9lGGfeIzO44SbJZ3bn0RFiYAII=;
        b=dt7dLI2rDnTdeBYubUgZ0SQtzOw9okTMcE+WHQYUaMOPneYUBt7GTSFhNF3vz6N4Gr
         DceDslyeOVTse6EHxmouvjBYF21/aqRlWSbkcvlhALeQbdf+SfUcioUVlpRm6Yc9zRGC
         Ng0X+yF72MCmOy9mEuwlZOk0BDEKDnOSJNJAsZSWbR7kEPcRqDC7WJKuyvvSmIB4eSJV
         Vf9NCnWT6zoV+IEz98ZhXqABlIpyATEEA+Mdpo/fKKmxQz/pOu6g/sFrCyWXluEqiYgO
         gxSpzU3Jcq5NtxV9VftAjtn6Ls/Uby5Mqfuqe6Zf8IzcqVaWYLkdhJkQz+BP/qOv9cKf
         W/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdMv55xYldZvCbOye9lGGfeIzO44SbJZ3bn0RFiYAII=;
        b=px4WTyQh8VGefGbDrf6Dq4VM/j74AbLnEi/z7ae2XHDhQOcM5w3LXzLNhRSvlQiIyI
         UU0SNclj1jKeDpyJ5HNfEyk14x4HqapLReK4HOws60CdS/c3MgTXktx55Mhbg03iRqNt
         80EBlrZMrzbArOP/3qLfc42yhqwVAlJtmwg70gJpaHbss/4yYlDIw8a0wM8OGlpOMw2B
         /jA4LsqqSiiizu/C+G8oBNqj0bb6wFl9Q37BjTZ3wagmn6Cn5b51BGRx9dUQTvsQe8DV
         3hreNJwDIUar6csGhAGWfslB8RKI2fP2vq0Ar0UBoMB13swiwwkgvDvoHC9ZSMpfUW6z
         HH2w==
X-Gm-Message-State: ACrzQf3WzEadkuxN4J0dFjGc7zLdnqYAh699bjeDp6BiAt7uMV2s31nV
        hCpzzcbWOM40dGh+APtTwciUoL8dz5TjnFGdYDc=
X-Google-Smtp-Source: AMsMyM6J6e6Yo4NUhWsM9M3Mcd+Fsp2wncCF9GrRvI0PSXVC3klPPMF17RQqAkY2tMcEmsNbqjVt60mDIy54iNzEDEI=
X-Received: by 2002:a05:6402:3641:b0:45c:4231:ddcc with SMTP id
 em1-20020a056402364100b0045c4231ddccmr19239698edb.224.1666390069602; Fri, 21
 Oct 2022 15:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221019135621.1480923-1-jolsa@kernel.org> <20221019135621.1480923-5-jolsa@kernel.org>
In-Reply-To: <20221019135621.1480923-5-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 15:07:36 -0700
Message-ID: <CAEf4BzY_u=jZ11+qZd0d-4DTzybQV7uFsov2F5+TSnxEsU2Wsw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 4/8] bpf: Take module reference on kprobe_multi link
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
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

On Wed, Oct 19, 2022 at 6:57 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently we allow to create kprobe multi link on function from kernel
> module, but we don't take the module reference to ensure it's not
> unloaded while we are tracing it.
>
> The multi kprobe link is based on fprobe/ftrace layer which takes
> different approach and releases ftrace hooks when module is unloaded
> even if there's tracer registered on top of it.
>
> Adding code that gathers all the related modules for the link and takes
> their references before it's attached. All kernel module references are
> released after link is unregistered.
>
> Note that we do it the same way already for trampoline probes
> (but for single address).
>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 92 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 17ae9e8336db..9a4a2388dff2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2452,6 +2452,8 @@ struct bpf_kprobe_multi_link {
>         unsigned long *addrs;
>         u64 *cookies;
>         u32 cnt;
> +       struct module **mods;
> +       u32 mods_cnt;

oh, and while we are at it, swap the order so two u32s are tightly packed?

>  };
>
>  struct bpf_kprobe_multi_run_ctx {
> @@ -2507,6 +2509,14 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
>         return err;
>  }

[...]
