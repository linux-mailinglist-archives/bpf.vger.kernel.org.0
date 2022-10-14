Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B58E5FEC6E
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJNKSA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 06:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJNKR6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 06:17:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D5911A97B
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 03:17:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b4so6889966wrs.1
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zk32MWOZ/ecdRb0BfsLbRS2RZmejlycAosvIeKzwxPE=;
        b=fJW674alegQNdjPXG8k7xCqtycFiigr7Xd+ZPY1fXs12zVemEBL54fhatwFna9AldW
         pdVsTI14D3LBSv9vsmJF/lNr3D5eZEIgDugv5+Jo6ThJ+LH9wr04485ke0og4I53SAq3
         Nn02TcHPwRSjZbu4UAQWqbx8y2JQFmE1grt2WvTu6nFxbUEvigcts5dERyOQhtBst5ik
         8uL9p5dV6bNMXDxmQ664W8xhYkUjwKBaeRrxUxTUkg7rrORy29jlCC1KXykzloJ0fLmz
         YNz0VF7YZCtnnjAFG4RLc+l4asxklcYEMOcx87hxV+ESrZa7LiOSh0+Df/SXsUs60aOu
         z2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk32MWOZ/ecdRb0BfsLbRS2RZmejlycAosvIeKzwxPE=;
        b=4a/0Fdmn/3F59P/EzuSDHPs4FnujoJeWs0g+pr7mEPU9DfiWKYj4k26fzRsBB1Pobq
         Xj77YDEbCBvwbd/aXpq2OOj6SdAoAidGNPEwJRQBwFGVnGd7m2N1rQBk9UROAhVC4mK4
         Qglg9eJrnl/f5HfJbSUvmRcNNPmLlUX2njaMV5AXy603lzmhB0HB+MIeImJoSiZbhziz
         PKTHxWh/49MXz9u69fSuoZs27gIKK8qp7pkdy059+yNpQjK8oqACYy6bY/3Wu189DCtT
         tMZ6Wxg5jEBi6m1AtB8NTmuLWI9yHBDgzVuz2rA0J/3R0E4WOCyq5xPx460bwEE5G+dq
         oJfQ==
X-Gm-Message-State: ACrzQf12cTd1OXA102sxpowhxa5aryxyGpVsGJgEerQ+eqf/PVrdZPpM
        4G1ud9gQ+YozfgbSEsPDX/I=
X-Google-Smtp-Source: AMsMyM73eUesi98gD3VRit2bmsm5ZA2jt8c3/Cx3bN2+GKSFcx3iQid3TOIEz5zRBO49bR3D3A0iRw==
X-Received: by 2002:a05:6000:1ac7:b0:232:8c6c:6c4a with SMTP id i7-20020a0560001ac700b002328c6c6c4amr2835639wry.455.1665742674397;
        Fri, 14 Oct 2022 03:17:54 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d4b02000000b0022ed6ff3a96sm1596641wrq.39.2022.10.14.03.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 03:17:53 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 14 Oct 2022 12:17:51 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Message-ID: <Y0k3T+1SVkvvq4Ge@krava>
References: <20221009215926.970164-1-jolsa@kernel.org>
 <20221009215926.970164-5-jolsa@kernel.org>
 <CAEf4BzZ_obDJY32tnGSSkNOk_PdCsf9UWQX4qqCEbSYD8sR4JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ_obDJY32tnGSSkNOk_PdCsf9UWQX4qqCEbSYD8sR4JQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 11:50:54AM -0700, Andrii Nakryiko wrote:
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
> 
> nit: sizeof(addr) is shorter and will stay in sync with addr variable?

ok

> 
> > +                      bpf_kprobe_multi_addrs_cmp))
> > +               return 0;
> > +
> > +       if (args->mods) {
> > +               struct module *prev = NULL;
> > +
> > +               if (args->mods_cnt > 1)
> > +                       prev = args->mods[args->mods_cnt - 1];
> 
> doesn't args->mods != NULL imply that args->mods_cnt > 1?
> 
> > +               if (prev == mod)
> > +                       return 0;
> > +               if (args->mods_cnt == args->mods_alloc)
> 
> nit: in libbpf we consistently use the cnt and cap (capacity)
> terminology for this, "mods_alloc" reads like a bool flag or something

ok

> 
> > +                       realloc = true;
> > +       }
> > +
> > +       if (realloc) {
> > +               args->mods_alloc += 100;
> 
> agree with Song, this looks pretty arbitrary and quite large. Again,
> from libbpf experience, we do something like:
> 
> mods_alloc = max(16, mods_alloc * 3 / 2);
> 
> so grow by 50%, but start of with reasonable 16-element array. We can
> use similar approach here.

ok

> 
> > +               mods = krealloc_array(args->mods, args->mods_alloc, sizeof(*mods), GFP_KERNEL);
> > +               if (!mods)
> > +                       return -ENOMEM;
> > +               args->mods = mods;
> > +       }
> 
> Previous two blocks read pretty convoluted. Isn't it equivalent to simpler:
> 
> if (args->mods && args->mods[args->mods_cnt - 1] == mod)
>     return 0;
> 
> if (args->mods_cnt == args->mods_alloc /* but I'd use mods_cap */) {
>     /* realloc here */
> }

sure, I can chage to that

thanks,
jirka
