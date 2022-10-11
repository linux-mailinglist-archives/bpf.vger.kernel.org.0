Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8585FAD49
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 09:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiJKHQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 03:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJKHQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 03:16:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACA844E8
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5D6BB810B2
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EEAC4347C
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665472596;
        bh=0kXvjI2JsXJuKalOTwR2NbqyemIWl7hJ/iZDXgjOGyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pScFTSl/NoeRGiIvN1la3L9u6s6rg0+/AKhQAQ6v/WO/pLnj2g3WoOrfz0uqBCRnl
         LrzJAa4eQCCKaU2Wz0EjheIHLAzy+l+gRHHUzMeawLX+bjaAw1U3i+oOBFnatlLOqa
         MZ8Z7FNxEr8s/o7+VXkXfX14QFOjGQ9FRxikutsFofyCuCqN5A0lCC7Do+PthNaWot
         XFQ3QmHyCQBtTnYMMzmSirYtg+QxtGaiDMfw2m1vlrw6LwTWQIr71Fxb1Vcj5jVjYw
         WMBf0h3yGI1U7Y+XaT+e8FBPy5kgckwGAT6mB0yNnaq6f54eQwZsUmmB5pQEw4Nkej
         3TAfhNHQbq3KQ==
Received: by mail-ej1-f43.google.com with SMTP id bj12so29318984ejb.13
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:16:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf03GJ1bm8JdBXxZyv5M7Y7EnQPX1kvriZw16z92DhKGqq/8erRL
        UlgmePm3qztSTPDJZuCyX0VrYzfNCr36axQLlUE=
X-Google-Smtp-Source: AMsMyM784VdkR8GdO5vHfp6rzdQURiVueV9iMKsd8H+Zaw9JY5Y56TRdkjBvS+7jioUe6Ft1Mty52PMCF/s8lLHBNRA=
X-Received: by 2002:a17:907:60c7:b0:78c:e54b:9021 with SMTP id
 hv7-20020a17090760c700b0078ce54b9021mr17934979ejc.101.1665472594502; Tue, 11
 Oct 2022 00:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-5-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-5-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 11 Oct 2022 00:16:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7u5UO5b7qYLHqKAR_2QGbkxR1YquHCSMuRzm-8kVpV5A@mail.gmail.com>
Message-ID: <CAPhsuW7u5UO5b7qYLHqKAR_2QGbkxR1YquHCSMuRzm-8kVpV5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf: Take module reference on kprobe_multi link
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
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
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

[...]

> +       }
> +
> +       if (realloc) {
> +               args->mods_alloc += 100;

100 seems arbitrary and too big to me.

Other than this, LGTM

Acked-by: Song Liu <song@kernel.org>

> +               mods = krealloc_array(args->mods, args->mods_alloc, sizeof(*mods), GFP_KERNEL);
> +               if (!mods)
> +                       return -ENOMEM;
> +               args->mods = mods;
> +       }
> +
> +       if (!try_module_get(mod))
> +               return -EINVAL;
> +
> +       args->mods[args->mods_cnt] = mod;
> +       args->mods_cnt++;
> +       return 0;
> +}

On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
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
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 100 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9be1a2b6b53b..f3d7565fee79 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2447,6 +2447,8 @@ struct bpf_kprobe_multi_link {
>         unsigned long *addrs;
>         u64 *cookies;
>         u32 cnt;
> +       struct module **mods;
> +       u32 mods_cnt;
>  };
>
>  struct bpf_kprobe_multi_run_ctx {
> @@ -2502,6 +2504,14 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
>         return err;
>  }
>
> +static void kprobe_multi_put_modules(struct module **mods, u32 cnt)
> +{
> +       u32 i;
> +
> +       for (i = 0; i < cnt; i++)
> +               module_put(mods[i]);
> +}
> +
>  static void free_user_syms(struct user_syms *us)
>  {
>         kvfree(us->syms);
> @@ -2514,6 +2524,7 @@ static void bpf_kprobe_multi_link_release(struct bpf_link *link)
>
>         kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
>         unregister_fprobe(&kmulti_link->fp);
> +       kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt);
>  }
>
>  static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
> @@ -2523,6 +2534,7 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
>         kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
>         kvfree(kmulti_link->addrs);
>         kvfree(kmulti_link->cookies);
> +       kfree(kmulti_link->mods);
>         kfree(kmulti_link);
>  }
>
> @@ -2658,6 +2670,80 @@ static void symbols_swap_r(void *a, void *b, int size, const void *priv)
>         }
>  }
>
> +struct module_addr_args {
> +       unsigned long *addrs;
> +       u32 addrs_cnt;
> +       struct module **mods;
> +       int mods_cnt;
> +       int mods_alloc;
> +};
> +
> +static int module_callback(void *data, const char *name,
> +                          struct module *mod, unsigned long addr)
> +{
> +       struct module_addr_args *args = data;
> +       bool realloc = !args->mods;
> +       struct module **mods;
> +
> +       /* We iterate all modules symbols and for each we:
> +        * - search for it in provided addresses array
> +        * - if found we check if we already have the module pointer stored
> +        *   (we iterate modules sequentially, so we can check just the last
> +        *   module pointer)
> +        * - take module reference and store it
> +        */
> +       if (!bsearch(&addr, args->addrs, args->addrs_cnt, sizeof(unsigned long),
> +                      bpf_kprobe_multi_addrs_cmp))
> +               return 0;
> +
> +       if (args->mods) {
> +               struct module *prev = NULL;
> +
> +               if (args->mods_cnt > 1)
> +                       prev = args->mods[args->mods_cnt - 1];
> +               if (prev == mod)
> +                       return 0;
> +               if (args->mods_cnt == args->mods_alloc)
> +                       realloc = true;
> +       }
> +
> +       if (realloc) {
> +               args->mods_alloc += 100;
> +               mods = krealloc_array(args->mods, args->mods_alloc, sizeof(*mods), GFP_KERNEL);
> +               if (!mods)
> +                       return -ENOMEM;
> +               args->mods = mods;
> +       }
> +
> +       if (!try_module_get(mod))
> +               return -EINVAL;
> +
> +       args->mods[args->mods_cnt] = mod;
> +       args->mods_cnt++;
> +       return 0;
> +}
> +
> +static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u32 addrs_cnt)
> +{
> +       struct module_addr_args args = {
> +               .addrs     = addrs,
> +               .addrs_cnt = addrs_cnt,
> +       };
> +       int err;
> +
> +       /* We return either err < 0 in case of error, ... */
> +       err = module_kallsyms_on_each_symbol(module_callback, &args);
> +       if (err) {
> +               kprobe_multi_put_modules(args.mods, args.mods_cnt);
> +               kfree(args.mods);
> +               return err;
> +       }
> +
> +       /* or number of modules found if everything is ok. */
> +       *mods = args.mods;
> +       return args.mods_cnt;
> +}
> +
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  {
>         struct bpf_kprobe_multi_link *link = NULL;
> @@ -2768,7 +2854,21 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>                        bpf_kprobe_multi_cookie_cmp,
>                        bpf_kprobe_multi_cookie_swap,
>                        link);
> +       } else {
> +               /*
> +                * We need to sort addrs array even if there are no cookies
> +                * provided, to allow bsearch in get_modules_for_addrs.
> +                */
> +               sort(addrs, cnt, sizeof(*addrs),
> +                      bpf_kprobe_multi_addrs_cmp, NULL);
> +       }
> +
> +       err = get_modules_for_addrs(&link->mods, addrs, cnt);
> +       if (err < 0) {
> +               bpf_link_cleanup(&link_primer);
> +               return err;
>         }
> +       link->mods_cnt = err;
>
>         err = register_fprobe_ips(&link->fp, addrs, cnt);
>         if (err) {
> --
> 2.37.3
>
