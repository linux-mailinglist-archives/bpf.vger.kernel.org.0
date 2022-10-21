Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB32260814C
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 00:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJUWCt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 18:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUWCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 18:02:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A02A9371
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:02:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g27so10774962edf.11
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn/80B2vpOI2VOZoSz6cl+J1RGV5/vgkL3CUwbKlXi8=;
        b=YoHqN4L0giPiBVCtOupl4D68lUE8brbUQDy9giXsIyl7b/QlqDVkvmTieQpfKlA54/
         L+onjyp84jC214H9rx79V6sjTsXsiV0XUBpdX+swA6bV7KTE6Q4ggfDTm/8URmWSGnmr
         6a1YR4i6bwshNH8A7woTOynwVaYPnVDhX4CCGm+o4akXc0nH0jdZ70PMPTG+GEtwF5XD
         1FsDmOmyQwFClUaUI56JLZCOO6HYBEcWBZBvz1UgBWhYNC2NYeBzeJF/tWuJZUpImG8t
         eW2BP2hdsSZQShWQOrBO9/AwAcl+KeM1D8/UZzX2lWaSC9uangI5NKYSkq5+M8fL8GKX
         7QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xn/80B2vpOI2VOZoSz6cl+J1RGV5/vgkL3CUwbKlXi8=;
        b=ASrW5ZP+r+JNULzvvyirzNNxMsWOLEkRRAN25wdnvIsZ48Lfpg1x+NwtJU2iZq/7OT
         6UoJOx2z43F1SuuHIHxkHxBG7fj7fbIy8XTk3m+MgoJdQzlvXDWTVmeji+Et5IxVSvgC
         c2PmM8Pla0QCBF2sUn1WK6uIXXlVH6QnyOTm+f4eF6DmeI6QdvzvTmrullhJaZlhPcQJ
         mOVvNWR1WqU85N8wZM9ZE/uxilcGV50A4LQxnzjImfcaHV955qYTp4VzjXckFgOWKxE0
         P5vRH6B48WaZUzqLxDxm1iZMJCcr/boKH2IKQPP+8fRI4PPydWweBSkmAIlRiSd1D3ZJ
         9Gww==
X-Gm-Message-State: ACrzQf1+2NL+19+zJwltIKc8wYp416jN2hahx9UQmOCP4XzpI1O2Lxqj
        QNhG2sDBB9/On6PBCev2OLR6drXua4gLampxju0=
X-Google-Smtp-Source: AMsMyM6Bh3wEJDm2vaBvaR+VZC9fHYElvWGZPfBcqFr0pLTuovoRiGN5ot/RmB3zpFEJ72dcwqkYGnQ7R+I/oduLTYI=
X-Received: by 2002:a17:907:984:b0:77f:4d95:9e2f with SMTP id
 bf4-20020a170907098400b0077f4d959e2fmr17721724ejc.176.1666389762997; Fri, 21
 Oct 2022 15:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221019135621.1480923-1-jolsa@kernel.org> <20221019135621.1480923-5-jolsa@kernel.org>
In-Reply-To: <20221019135621.1480923-5-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 15:02:30 -0700
Message-ID: <CAEf4Bza1p-HZtng4AdAPiV5jbBEstKckWbtAj2aJd2fNqoziZQ@mail.gmail.com>
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
>  };
>
>  struct bpf_kprobe_multi_run_ctx {
> @@ -2507,6 +2509,14 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
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
> @@ -2519,6 +2529,7 @@ static void bpf_kprobe_multi_link_release(struct bpf_link *link)
>
>         kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
>         unregister_fprobe(&kmulti_link->fp);
> +       kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt);
>  }
>
>  static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
> @@ -2528,6 +2539,7 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
>         kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
>         kvfree(kmulti_link->addrs);
>         kvfree(kmulti_link->cookies);
> +       kfree(kmulti_link->mods);
>         kfree(kmulti_link);
>  }
>
> @@ -2663,6 +2675,71 @@ static void symbols_swap_r(void *a, void *b, int size, const void *priv)
>         }
>  }
>
> +struct module_addr_args {
> +       unsigned long *addrs;
> +       u32 addrs_cnt;
> +       struct module **mods;
> +       int mods_cnt;
> +       int mods_cap;
> +};
> +
> +static int module_callback(void *data, const char *name,
> +                          struct module *mod, unsigned long addr)
> +{
> +       struct module_addr_args *args = data;
> +       struct module **mods;
> +
> +       /* We iterate all modules symbols and for each we:
> +        * - search for it in provided addresses array
> +        * - if found we check if we already have the module pointer stored
> +        *   (we iterate modules sequentially, so we can check just the last
> +        *   module pointer)
> +        * - take module reference and store it
> +        */
> +       if (!bsearch(&addr, args->addrs, args->addrs_cnt, sizeof(addr),
> +                      bpf_kprobe_multi_addrs_cmp))
> +               return 0;
> +
> +       if (args->mods && args->mods[args->mods_cnt - 1] == mod)
> +               return 0;
> +
> +       if (args->mods_cnt == args->mods_cap) {
> +               args->mods_cap = max(16, args->mods_cap * 3 / 2);
> +               mods = krealloc_array(args->mods, args->mods_cap, sizeof(*mods), GFP_KERNEL);
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
> @@ -2773,10 +2850,25 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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
> +               kprobe_multi_put_modules(link->mods, link->mods_cnt);

I don't think bpf_link_cleanup() will free link->mods, you have to do
it explicitly here

>                 bpf_link_cleanup(&link_primer);
>                 return err;
>         }
> --
> 2.37.3
>
