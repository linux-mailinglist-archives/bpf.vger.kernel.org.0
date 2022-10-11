Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA345FB022
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 12:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJKKHe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 06:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKKHd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 06:07:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7596745F
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 03:07:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j16so20805900wrh.5
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xghDtnJJO4tys306nkfqSyJR3ujKWegxQ25bZXewEeI=;
        b=iu5Gv79bQ9QKdSorZpYOnaOs19I4HMtcZBwisP+TvNNAlfuNghT2F0IrKYBckQQMmT
         x+nEhzA7xlCifbQvJbS50/SSiD2NG8l3XyCrZ9CmM7prqwY/1+dOIMF2vrRS2efAonJv
         SkBiphdIjkPBcSYlwVZST7jC2uw3tksUwgnB9Q5RWiE+1RbobhxhO+Pb13Z5eEDoia12
         DQhuUojuYzHxbPQxBgUX887VXvDbRFhXWZ33TZ9YdKoAepXNK+Wm47k87WoF+iXdxFhH
         kwKUvVGCaWS3EOcQUmKTBTo3M8N2uDnVqhOOUu+e4YRkme/nWC62rC+ciVKMqbF5hdH+
         M2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xghDtnJJO4tys306nkfqSyJR3ujKWegxQ25bZXewEeI=;
        b=WVmkyp86A+8rXelnUo4EAVLM2ljTCUVxJo5rAOeyZHIKEFfGPe2sxDKv02+Ps+KtUh
         dvEkYgmDDhY6sO9ndo6hgbksCEyYQMvuZQzRnuTEisB0xe88rMsKymUtR7isrvETGtQG
         KMjKSFSYTXIU0ImYv6Uv/BhRfbmw5HacAGnNVY7sKcpDw+CIFQozQamcriTJcfMxxg6x
         TJMyUOjCACkxRWWfp13fz+wsWdMhY6HjGln8uR03JFZef8ZPzOwfJi8TFgmE75fvAj+D
         W/bnrc8QfSpiF1ikcs6iRy7owGgbenZX/7OlE7EpDbfp39JWmQvMzIT+yfbFxJMFgcHC
         r93g==
X-Gm-Message-State: ACrzQf2+O3LE2YQudZLPepelFiaOpDEcNRlCzppxakJNgITBpm0zaqCs
        1vb0X80gXlVPg7CvDF1IYH4=
X-Google-Smtp-Source: AMsMyM4UXxJvCpBNZh8fTytGseeKVuPT3Uprd6C58WA4T2y6zxw8YS4I/5W8A2/oy2FDDIkkTO1lVw==
X-Received: by 2002:adf:d842:0:b0:22e:33e2:f379 with SMTP id k2-20020adfd842000000b0022e33e2f379mr14284658wrl.23.1665482851074;
        Tue, 11 Oct 2022 03:07:31 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003c1a7ea3736sm14257452wmq.11.2022.10.11.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:07:30 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 11 Oct 2022 12:07:28 +0200
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 2/8] ftrace: Add support to resolve module
 symbols in ftrace_lookup_symbols
Message-ID: <Y0VAYM57Bi1vqPkr@krava>
References: <20221009215926.970164-1-jolsa@kernel.org>
 <20221009215926.970164-3-jolsa@kernel.org>
 <CAPhsuW5nBf2gL_ohyfkEbX3aWH2ETEGuamq2D6JaHvaCznw_2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5nBf2gL_ohyfkEbX3aWH2ETEGuamq2D6JaHvaCznw_2w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 12:05:47AM -0700, Song Liu wrote:
> On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently ftrace_lookup_symbols iterates only over core symbols,
> > adding module_kallsyms_on_each_symbol call to check on modules
> > symbols as well.
> >
> > Also removing 'args.found == args.cnt' condition, because it's
> > already checked in kallsyms_callback function.
> >
> > Also removing 'err < 0' check, because both *kallsyms_on_each_symbol
> > functions do not return error.
> >
> > Reported-by: Martynas Pumputis <m@lambda.lt>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> > ---
> >  kernel/trace/ftrace.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 447d2e2a8549..6efdba4666f4 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -8292,17 +8292,18 @@ static int kallsyms_callback(void *data, const char *name,
> >  int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
> >  {
> >         struct kallsyms_data args;
> > -       int err;
> > +       int found_all;
> >
> >         memset(addrs, 0, sizeof(*addrs) * cnt);
> >         args.addrs = addrs;
> >         args.syms = sorted_syms;
> >         args.cnt = cnt;
> >         args.found = 0;
> > -       err = kallsyms_on_each_symbol(kallsyms_callback, &args);
> > -       if (err < 0)
> > -               return err;
> > -       return args.found == args.cnt ? 0 : -ESRCH;
> > +       found_all = kallsyms_on_each_symbol(kallsyms_callback, &args);
> > +       if (found_all)
> > +               return 0;
> > +       found_all = module_kallsyms_on_each_symbol(kallsyms_callback, &args);
> > +       return found_all ? 0 : -ESRCH;
> 
> We probably need some comments about kallsym_callback and
> ftrace_lookup_symbols. It took me a while to confirm the logic for
> found_all.

ok, I wrote some info in the changelog, but I'll put it
as comment in the code as well

jirka

> 
> >  }
> >
> >  #ifdef CONFIG_SYSCTL
> > --
> > 2.37.3
> >
