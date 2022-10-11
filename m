Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB7F5FB02F
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJKKJv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJKKJl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 06:09:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C548C468
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 03:09:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w18so20820332wro.7
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmEiVQsQjdrPjeVLQ4+WJzxwSpgLpf6n/HgfBqkCoNU=;
        b=JTJj6+l48G0Xw686bvjkem3Ey8pI4Ln2hQEv/BX+jFQZWSXU2jzOPBY2zHKw1DMaoC
         Sty1LrwvuYV7JoC/Nc20GeDsqieNxuvrFt9+8RmkaRI2iBvMC1SRYXDZC8Ba1RKQLwkj
         pTsKr7dXPy6ydVyRPuii3Hc9yZoWXOQp/7TjBu0F1vFbqR7nUaDy+0LyG2p60u7P2Xzl
         KiygUkixd+kZaf/Cp5mPH++4n/dYeG5K/jILvzO0mrkJqWCl8IEEtel9swl4S06R5cND
         njx06xg9nCALuEiJikXmaI4ILFH2BIHv8CaBN9pem0VrXKme+rAZyT59fHssKsxBgd6n
         bW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmEiVQsQjdrPjeVLQ4+WJzxwSpgLpf6n/HgfBqkCoNU=;
        b=SN0WhVgSf0dvr0SQCGNeFk6zK3mllbj7LutLC7tkuSikcFcCnV2ts9BMhsQvf7cCgI
         HVE4xfzmOB8FD+L71f/HTce04Cc9BvYAtrNwl9fHkRzUvAyqP51WUvlAfd6iVXzvtWVM
         s3DboTxt8X3M7p3kTezJyhD5EYZnyeKaiJz9jCjmltBMeR715POemZeKKo0RWm+UI8tM
         YvYHHUWjOjj7IDBdPXqPl0hJH5+KTGh9ZxmZhYaBL9N/f4VQzuAhMZVWTE2GjFwC5Vcv
         3CuOwt5ktu0C1KrA/hC9Uv3sch4xlDSuI1xe3nfDADP7i2jMIQlXMW6WkSCZJ473Uves
         oDRg==
X-Gm-Message-State: ACrzQf0d+AEwPOPBMwBEuPHA6AXhsXLbi1DwJ9jSs1pAv+S0c2/jlxdJ
        e3ebfC3AX2QMwDaWLlIpE1I=
X-Google-Smtp-Source: AMsMyM6UYurSw2HXd/SlITPzBhBiui+wLSsIpAB+xcdPkkaCKnaBKj5VKIQMSqcYflc2F8lkk3kRgw==
X-Received: by 2002:adf:efce:0:b0:22e:38b8:fe41 with SMTP id i14-20020adfefce000000b0022e38b8fe41mr14667334wrp.391.1665482966734;
        Tue, 11 Oct 2022 03:09:26 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b003b4c979e6bcsm19220253wmq.10.2022.10.11.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:09:26 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 11 Oct 2022 12:09:24 +0200
To:     Song Liu <song@kernel.org>
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
Subject: Re: [PATCH bpf-next 4/8] bpf: Take module reference on kprobe_multi
 link
Message-ID: <Y0VA1Flbz85s2eER@krava>
References: <20221009215926.970164-1-jolsa@kernel.org>
 <20221009215926.970164-5-jolsa@kernel.org>
 <CAPhsuW7u5UO5b7qYLHqKAR_2QGbkxR1YquHCSMuRzm-8kVpV5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7u5UO5b7qYLHqKAR_2QGbkxR1YquHCSMuRzm-8kVpV5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 12:16:22AM -0700, Song Liu wrote:
> On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently we allow to create kprobe multi link on function from kernel
> > module, but we don't take the module reference to ensure it's not
> > unloaded while we are tracing it.
> >
> > The multi kprobe link is based on fprobe/ftrace layer which takes
> > different approach and releases ftrace hooks when module is unloaded
> > even if there's tracer registered on top of it.
> >
> > Adding code that gathers all the related modules for the link and takes
> > their references before it's attached. All kernel module references are
> > released after link is unregistered.
> >
> > Note that we do it the same way already for trampoline probes
> > (but for single address).
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]
> 
> > +       }
> > +
> > +       if (realloc) {
> > +               args->mods_alloc += 100;
> 
> 100 seems arbitrary and too big to me.

[jolsa@krava linux-qemu]$ lsmod | wc -l
192

I'll check if we can get actuall modules count and base the
allocation on that

jirka

> 
> Other than this, LGTM
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> > +               mods = krealloc_array(args->mods, args->mods_alloc, sizeof(*mods), GFP_KERNEL);
> > +               if (!mods)
> > +                       return -ENOMEM;
> > +               args->mods = mods;
> > +       }
> > +
> > +       if (!try_module_get(mod))
> > +               return -EINVAL;
> > +
> > +       args->mods[args->mods_cnt] = mod;
> > +       args->mods_cnt++;
> > +       return 0;
> > +}
> 
> On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently we allow to create kprobe multi link on function from kernel
> > module, but we don't take the module reference to ensure it's not
> > unloaded while we are tracing it.
> >
> > The multi kprobe link is based on fprobe/ftrace layer which takes
> > different approach and releases ftrace hooks when module is unloaded
> > even if there's tracer registered on top of it.
> >
> > Adding code that gathers all the related modules for the link and takes
> > their references before it's attached. All kernel module references are
> > released after link is unregistered.
> >
> > Note that we do it the same way already for trampoline probes
> > (but for single address).
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 100 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 9be1a2b6b53b..f3d7565fee79 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2447,6 +2447,8 @@ struct bpf_kprobe_multi_link {
> >         unsigned long *addrs;
> >         u64 *cookies;
> >         u32 cnt;
> > +       struct module **mods;
> > +       u32 mods_cnt;
> >  };
> >
> >  struct bpf_kprobe_multi_run_ctx {
> > @@ -2502,6 +2504,14 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
> >         return err;
> >  }
> >
> > +static void kprobe_multi_put_modules(struct module **mods, u32 cnt)
> > +{
> > +       u32 i;
> > +
> > +       for (i = 0; i < cnt; i++)
> > +               module_put(mods[i]);
> > +}
> > +
> >  static void free_user_syms(struct user_syms *us)
> >  {
> >         kvfree(us->syms);
> > @@ -2514,6 +2524,7 @@ static void bpf_kprobe_multi_link_release(struct bpf_link *link)
> >
> >         kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> >         unregister_fprobe(&kmulti_link->fp);
> > +       kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt);
> >  }
> >
> >  static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
> > @@ -2523,6 +2534,7 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
> >         kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> >         kvfree(kmulti_link->addrs);
> >         kvfree(kmulti_link->cookies);
> > +       kfree(kmulti_link->mods);
> >         kfree(kmulti_link);
> >  }
> >
> > @@ -2658,6 +2670,80 @@ static void symbols_swap_r(void *a, void *b, int size, const void *priv)
> >         }
> >  }
> >
> > +struct module_addr_args {
> > +       unsigned long *addrs;
> > +       u32 addrs_cnt;
> > +       struct module **mods;
> > +       int mods_cnt;
> > +       int mods_alloc;
> > +};
> > +
> > +static int module_callback(void *data, const char *name,
> > +                          struct module *mod, unsigned long addr)
> > +{
> > +       struct module_addr_args *args = data;
> > +       bool realloc = !args->mods;
> > +       struct module **mods;
> > +
> > +       /* We iterate all modules symbols and for each we:
> > +        * - search for it in provided addresses array
> > +        * - if found we check if we already have the module pointer stored
> > +        *   (we iterate modules sequentially, so we can check just the last
> > +        *   module pointer)
> > +        * - take module reference and store it
> > +        */
> > +       if (!bsearch(&addr, args->addrs, args->addrs_cnt, sizeof(unsigned long),
> > +                      bpf_kprobe_multi_addrs_cmp))
> > +               return 0;
> > +
> > +       if (args->mods) {
> > +               struct module *prev = NULL;
> > +
> > +               if (args->mods_cnt > 1)
> > +                       prev = args->mods[args->mods_cnt - 1];
> > +               if (prev == mod)
> > +                       return 0;
> > +               if (args->mods_cnt == args->mods_alloc)
> > +                       realloc = true;
> > +       }
> > +
> > +       if (realloc) {
> > +               args->mods_alloc += 100;
> > +               mods = krealloc_array(args->mods, args->mods_alloc, sizeof(*mods), GFP_KERNEL);
> > +               if (!mods)
> > +                       return -ENOMEM;
> > +               args->mods = mods;
> > +       }
> > +
> > +       if (!try_module_get(mod))
> > +               return -EINVAL;
> > +
> > +       args->mods[args->mods_cnt] = mod;
> > +       args->mods_cnt++;
> > +       return 0;
> > +}
> > +
> > +static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u32 addrs_cnt)
> > +{
> > +       struct module_addr_args args = {
> > +               .addrs     = addrs,
> > +               .addrs_cnt = addrs_cnt,
> > +       };
> > +       int err;
> > +
> > +       /* We return either err < 0 in case of error, ... */
> > +       err = module_kallsyms_on_each_symbol(module_callback, &args);
> > +       if (err) {
> > +               kprobe_multi_put_modules(args.mods, args.mods_cnt);
> > +               kfree(args.mods);
> > +               return err;
> > +       }
> > +
> > +       /* or number of modules found if everything is ok. */
> > +       *mods = args.mods;
> > +       return args.mods_cnt;
> > +}
> > +
> >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >  {
> >         struct bpf_kprobe_multi_link *link = NULL;
> > @@ -2768,7 +2854,21 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >                        bpf_kprobe_multi_cookie_cmp,
> >                        bpf_kprobe_multi_cookie_swap,
> >                        link);
> > +       } else {
> > +               /*
> > +                * We need to sort addrs array even if there are no cookies
> > +                * provided, to allow bsearch in get_modules_for_addrs.
> > +                */
> > +               sort(addrs, cnt, sizeof(*addrs),
> > +                      bpf_kprobe_multi_addrs_cmp, NULL);
> > +       }
> > +
> > +       err = get_modules_for_addrs(&link->mods, addrs, cnt);
> > +       if (err < 0) {
> > +               bpf_link_cleanup(&link_primer);
> > +               return err;
> >         }
> > +       link->mods_cnt = err;
> >
> >         err = register_fprobe_ips(&link->fp, addrs, cnt);
> >         if (err) {
> > --
> > 2.37.3
> >
