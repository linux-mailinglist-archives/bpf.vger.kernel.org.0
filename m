Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D684E5FE21F
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 20:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJMSyJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 14:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiJMSxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 14:53:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F1192B92
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 11:51:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a13so3943245edj.0
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e6XB8/Ynx2Q57wwCyJDlDfjWI4dKBheD89elBLO+YWI=;
        b=bIdldpwq/2KIw59sIRIj5auTW2pHyLF1Fpm6o5dPjlvkkTwjejY8cRCpFdoIpM9zRW
         f6WjnZ7577zfiD3jwfXs69Zckx8Dj4d/J2MGcAcRlnCEpJ/xkH3bitbW9LwTNbDVoovV
         T2nqtd1ZV/wgjPpcx1HSlWTgomRhbF9VlX+VqkWavImzld0KTmSsc5qG9+tMnQvx8cSr
         OriY/LIY8g6NZGETrFna2EdQw6YmtXB6M1RD9u53Mzd4aaR/aKVNXpgyGTMGc2ViGOwN
         D56KIdWwGVHhKnOA3q/M1ijo7pSSHzBGsAzD3LH4hRhlomuacFcIz0Ev6zuX6lFjy74d
         0U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6XB8/Ynx2Q57wwCyJDlDfjWI4dKBheD89elBLO+YWI=;
        b=eSrj8xEVGwIdbrNREErk0iQMQ+XVVT80MXb28dci55KDXSUcrAvk15SiAf0i+LTOHb
         8QJzQhc+/kuuP5Lc2kIDkRCWN/lnTlgBajpKupBhI1gWwee0QJVN0Z7gPwjOEwxSBJ64
         zTok0NoqnE/StK+i9m/0tmWVPkPRLYLHyg8oVXHbTRfZ4Vqd1qAhT+Ov3cqns1bIvF2Y
         212HUxMTmGtIrSbbXfgjDiFs4dn3FQMTm/oRfhJhaUTdFP2AeMovkyAqFILvyn8EIhEV
         xJWoDEldvEYMmz7V27uIprMuMe5bhMYbcCwnIaKQRJPX8k3qWw4ovNjaCR26N2pMJEe7
         BHYQ==
X-Gm-Message-State: ACrzQf1nrE3St8EoHaCK8OZt3AO1GwpGhk+A3ADLXRHW8cyrunD924h+
        4lAjX+29d7edfjavF4nmqR7sPxz2pE0IjoNlBs4=
X-Google-Smtp-Source: AMsMyM4Ip37b3alvVqKTGZTP9yuSYdrjpSgVLe9jtHo/9KyieaeKNp53s/kLoI8bDZ61mGPdF0j1yaOJX/m5rPn7Q9w=
X-Received: by 2002:a05:6402:22ed:b0:458:bcd1:69cf with SMTP id
 dn13-20020a05640222ed00b00458bcd169cfmr1051721edb.260.1665687066620; Thu, 13
 Oct 2022 11:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-5-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-5-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 Oct 2022 11:50:54 -0700
Message-ID: <CAEf4BzZ_obDJY32tnGSSkNOk_PdCsf9UWQX4qqCEbSYD8sR4JQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

nit: sizeof(addr) is shorter and will stay in sync with addr variable?

> +                      bpf_kprobe_multi_addrs_cmp))
> +               return 0;
> +
> +       if (args->mods) {
> +               struct module *prev = NULL;
> +
> +               if (args->mods_cnt > 1)
> +                       prev = args->mods[args->mods_cnt - 1];

doesn't args->mods != NULL imply that args->mods_cnt > 1?

> +               if (prev == mod)
> +                       return 0;
> +               if (args->mods_cnt == args->mods_alloc)

nit: in libbpf we consistently use the cnt and cap (capacity)
terminology for this, "mods_alloc" reads like a bool flag or something

> +                       realloc = true;
> +       }
> +
> +       if (realloc) {
> +               args->mods_alloc += 100;

agree with Song, this looks pretty arbitrary and quite large. Again,
from libbpf experience, we do something like:

mods_alloc = max(16, mods_alloc * 3 / 2);

so grow by 50%, but start of with reasonable 16-element array. We can
use similar approach here.

> +               mods = krealloc_array(args->mods, args->mods_alloc, sizeof(*mods), GFP_KERNEL);
> +               if (!mods)
> +                       return -ENOMEM;
> +               args->mods = mods;
> +       }

Previous two blocks read pretty convoluted. Isn't it equivalent to simpler:

if (args->mods && args->mods[args->mods_cnt - 1] == mod)
    return 0;

if (args->mods_cnt == args->mods_alloc /* but I'd use mods_cap */) {
    /* realloc here */
}

> +
> +       if (!try_module_get(mod))
> +               return -EINVAL;
> +
> +       args->mods[args->mods_cnt] = mod;
> +       args->mods_cnt++;
> +       return 0;
> +}
> +

[...]
