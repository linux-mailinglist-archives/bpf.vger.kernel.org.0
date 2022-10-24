Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B667609C4C
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJXISN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 04:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJXIRo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 04:17:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAACC645E2
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 01:16:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v1so14851263wrt.11
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnwIb7jnvQ/s2Hn8YUmo7wA7qn6+D9ZqE00olLG1oZI=;
        b=gxmnRgdJOaWIclhqXONAObIgozhrJ5TySwG3wbVApuHm/1ut8V5W7FamnB0t4IWNl7
         q5plq8dIjvZ0+41mnkxVArmXIW1e5eX8gLVj7AM6LKyjNqwp/s1lzgsSw795+g4iReLk
         2EEeQ4p68YP7PXJjU5vPehm1loPpP0yxfR16Xvw9WuQjdg81Sz4bk9Cs9icbm6PhCSuY
         iBg/xKRC3MzTSPokLi/9q98KV9fOfVkFwfyfuDRa4wkqhDtbeVinzaCbkbIcReuFaCqQ
         lYuaKGlmaaxBEM1rbSFyZ1RJic+B06WTHDD60gJJes0q3v1OXG7WuA2S8k+WdGaUrAnE
         eoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnwIb7jnvQ/s2Hn8YUmo7wA7qn6+D9ZqE00olLG1oZI=;
        b=joQauN9ThQh77wRdEtKZd/i5TqISCQAC8UX75Rk0wB9O8PqhNVW/j/DmiLwGDkZaAV
         MgOv8FoUi5nq3AJ5mGQXbauIssbpZbbD1s+58Zr+vcUk3V96WdLRUbuwxfjJc8QG6UFe
         Z02EocV4+DoO1k2apo6s9SXA+zeVaJZZLXW4botPgPZWh3UlZtgXggSrK7H5R0TnSjol
         dstVbloQjDY+aGyyz69rDRasqBTzGnWfySJ0eQOMLtZl8+STVpGctAMrYpCjrNhdRapm
         eNdteQaJjdD3lRV6N5jrMH3k+dxWb0eCL4rV945UR1vc/RQTCSK9X0+oi01JJCB6tnHS
         wNQA==
X-Gm-Message-State: ACrzQf2glvIq/EqLFvpGVwzOxSQO1FSfs6TH990qotBDx+ccAR6ThtE1
        52TnvGuKsGQFMV+RABS7EQ814r2B9VnKcQ==
X-Google-Smtp-Source: AMsMyM7mWMWWqJs+H0s1TYFo1BfM9qMYr0PoqIal1Em4srpgUByuEL8+i+b+yP9V6WpcwrCizhdJKA==
X-Received: by 2002:a5d:6d07:0:b0:22f:81f9:9c73 with SMTP id e7-20020a5d6d07000000b0022f81f99c73mr22283179wrq.76.1666599362757;
        Mon, 24 Oct 2022 01:16:02 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d5950000000b0023677e1157fsm650820wri.56.2022.10.24.01.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 01:16:02 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 24 Oct 2022 10:16:00 +0200
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
Message-ID: <Y1ZJwOR0rLIkGzVa@krava>
References: <20221019135621.1480923-1-jolsa@kernel.org>
 <20221019135621.1480923-5-jolsa@kernel.org>
 <CAEf4Bza1p-HZtng4AdAPiV5jbBEstKckWbtAj2aJd2fNqoziZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza1p-HZtng4AdAPiV5jbBEstKckWbtAj2aJd2fNqoziZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 03:02:30PM -0700, Andrii Nakryiko wrote:

SNIP

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
> > @@ -2773,10 +2850,25 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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
> > +               kprobe_multi_put_modules(link->mods, link->mods_cnt);
> 
> I don't think bpf_link_cleanup() will free link->mods, you have to do
> it explicitly here

hum, so bpf_link_cleanup sets link->prog to NULL so bpf_link_free
won't call link->ops->release, but will call link->ops->dealloc,
so it should be fine AFAICS

jirka

> 
> >                 bpf_link_cleanup(&link_primer);
> >                 return err;
> >         }
> > --
> > 2.37.3
> >
