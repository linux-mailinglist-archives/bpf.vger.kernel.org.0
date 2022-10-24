Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D065B609C52
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJXIVI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJXIUh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 04:20:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43365016
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 01:18:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so6408383wms.1
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymsrZRGM/ZJLo4W+q5MQzcab1lYbKfAcdkUqsBlIor0=;
        b=RAM/Jdhbj7tbCkEVU8+V0q8Tb3FZDr89ylaixBAdGDUVqAx0lk9qeMS0er1gwMI//u
         MMNiIcoQAaLfGlUU0Z2Wwh8G5zyaYbCMMi32MWguqE6P2T5t3Bc2lUTsp3iAa7unZU3t
         fqBuLm+UBj3J3vEBJjoswfctDGupg8t3nq+oJN4bdbD0Njg0ytrkNvitifJO2YpExpz2
         YUFgrRIcSD0q22pQAkLe/5FHaokhnt6bRx0h+9BkYCUc/r5BpnV3AC394L/e3sXo1p7L
         gdFWDSIZb3XTIsGJhhkOU4KILQFSTmu3wW4AhJ1KAbyNQ8YWL4RSsR9h0zH0wf00D6cI
         GndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymsrZRGM/ZJLo4W+q5MQzcab1lYbKfAcdkUqsBlIor0=;
        b=qvh8Qf0mgyNzv0XK6by2ED4XMfy9P/aStjiq9nIi5ZqnwN/oS/vy9D+czg3wfLgViH
         X5Qg3dq2Vj2Nsvko8ia101UjGh/w3y45bzeDN5NI3c/HoPniCVU4q4aUu6QPC987hf35
         xNhaO3PL6mNlba3aoU9tOhLb2Jwzc4Mj/GGbJAljt50PF+f39fORa8DTpmeo3Yf7sKeL
         t6GFlYvnV3/1dFjrapEf+3EQblGf0kMEmitZiEI2z30ZeXKdwhgy9Q4DmBTE5qustwaW
         XcQXp7h44i9GGM74AbSBdzyBGhHGkv9ouPsjZZsOgpFjzkGK1HeMPzRe5k/dUlISfprk
         bldQ==
X-Gm-Message-State: ACrzQf2GQNQMfwVamynNu2qE5F9ttOs6Ivcv+kTOD0FEEHz0jcwBN8QS
        gKiQycw/O6MwMZCJo0dWQdo=
X-Google-Smtp-Source: AMsMyM7mnByysCDVAXPmf+WEfz+mPGn4ORDbdJAslofLaC+1b1fgbhZro7XwA/3iLus0uh3LGmkPtQ==
X-Received: by 2002:a05:600c:5024:b0:3c6:e25f:64be with SMTP id n36-20020a05600c502400b003c6e25f64bemr37840615wmr.55.1666599442406;
        Mon, 24 Oct 2022 01:17:22 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d66cc000000b002366a624bd4sm3751676wrw.28.2022.10.24.01.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 01:17:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 24 Oct 2022 10:17:20 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCHv2 bpf-next 4/8] bpf: Take module reference on
 kprobe_multi link
Message-ID: <Y1ZKEAAXkfc+NoKp@krava>
References: <20221019135621.1480923-1-jolsa@kernel.org>
 <20221019135621.1480923-5-jolsa@kernel.org>
 <CAEf4BzY_u=jZ11+qZd0d-4DTzybQV7uFsov2F5+TSnxEsU2Wsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY_u=jZ11+qZd0d-4DTzybQV7uFsov2F5+TSnxEsU2Wsw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 03:07:36PM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 19, 2022 at 6:57 AM Jiri Olsa <jolsa@kernel.org> wrote:
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
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 92 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 17ae9e8336db..9a4a2388dff2 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2452,6 +2452,8 @@ struct bpf_kprobe_multi_link {
> >         unsigned long *addrs;
> >         u64 *cookies;
> >         u32 cnt;
> > +       struct module **mods;
> > +       u32 mods_cnt;
> 
> oh, and while we are at it, swap the order so two u32s are tightly packed?

will change

thanks,
jirka

> 
> >  };
> >
> >  struct bpf_kprobe_multi_run_ctx {
> > @@ -2507,6 +2509,14 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
> >         return err;
> >  }
> 
> [...]
