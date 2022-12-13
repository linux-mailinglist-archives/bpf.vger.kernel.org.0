Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2163664BEDF
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 22:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiLMVz6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 16:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbiLMVza (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:30 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243C27B0B
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 13:53:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qk9so40116945ejc.3
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 13:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LcacrTE8HkreBakA8jKYNi9TyXv8/pkWWQhEdwdmBps=;
        b=NDjxmTpoCKS9pEGaxALYbbeizB3ZLIn0eAzmXiGiTzjSsxYeRPuFHDApo+GQOSvNvg
         MKLl69KxAfPBFZsd4ho9EvRPjSinPNevJSEXRokPMA52/sTjwEdfPS2qCOoKOy2kCHmz
         sOJoC//gOKDHC0TIEWA2VTF4R1TDxDKpJ+nC0edPfpZ1LexH1Tig+xFGHIggJO42+1Na
         hdr+YxiLrWqbf3HarPiuwOKgKN5CS0QnNeihQrF7YsMIGu7bHR/1gpY5PxE+5cgp+RUb
         VGzP1nAMDDQlT6i4DCNsjwkmOYOj8ePDC4fUGIc48BksUOvEOx3v8RRSnjtNpRDzRWyy
         dcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcacrTE8HkreBakA8jKYNi9TyXv8/pkWWQhEdwdmBps=;
        b=xecojyPK6B/cDQMgZUp+2679vHjfDGL3FdeopCZnBn/d6yrf6ysqUwqxNz9Wm46uet
         06F6MJ900hC2W0eBTPnvJApPBtY8xCUE4r3b8osBm8oC8AqdcziVN5zCHGuLdgDVWrUl
         a8DxrEIuDMtZBM70VFUbHjw1WMAyygyM45SNt1Z7c85m820aLIQZrN48ReLaxrZGnfzB
         yZhsa4FPii1knbgUfH4g5Gi5+162I0qFsP3JWvPH7srpf8XD0wE+B2GrSkngJL96VuRl
         CRuVwgluAEq5AWa+nwgoaXMzm56ERGXl2SI+S6NxWeC1AVJeyKzZK/ojgMXMkOr1vmJH
         ijpg==
X-Gm-Message-State: ANoB5pkd729xY1qf+6WLkao7cSgjqoXCapsM2fGbc+v9K3Em+2i4dAwo
        KU7lx8CzsaCZQRnXFXIL26k=
X-Google-Smtp-Source: AA0mqf4rTJ6hk69tmnipvclRTtMCiphW+b3F3EtBEesBHxdY3xQZMuuDScvfMQJmj/0UqqBhtPcvug==
X-Received: by 2002:a17:906:3a59:b0:7be:e831:2b4b with SMTP id a25-20020a1709063a5900b007bee8312b4bmr17332242ejf.23.1670968415713;
        Tue, 13 Dec 2022 13:53:35 -0800 (PST)
Received: from krava ([83.240.63.35])
        by smtp.gmail.com with ESMTPSA id s7-20020a056402520700b0046ac017b007sm5488828edd.18.2022.12.13.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 13:53:35 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 13 Dec 2022 22:53:33 +0100
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] bpf: Remove trace_printk_lock lock
Message-ID: <Y5j0XYQyiDP1Uu68@krava>
References: <20221213140843.803293-1-jolsa@kernel.org>
 <CAPhsuW5sQaspOhurLWm0igDUJk+V9ihmt0WnjaKsq1gJ66F6Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5sQaspOhurLWm0igDUJk+V9ihmt0WnjaKsq1gJ66F6Gw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 10:48:43AM -0800, Song Liu wrote:
> On Tue, Dec 13, 2022 at 6:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Both bpf_trace_printk and bpf_trace_vprintk helpers use static buffer
> > guarded with trace_printk_lock spin lock.
> >
> > The spin lock contention causes issues with bpf programs attached to
> > contention_begin tracepoint [1] [2].
> >
> > Andrii suggested we could get rid of the contention by using trylock,
> > but we could actually get rid of the spinlock completely by using
> > percpu buffers the same way as for bin_args in bpf_bprintf_prepare
> > function.
> >
> > Adding 4 per cpu buffers (1k each) which should be enough for all
> > possible nesting contexts (normal, softirq, irq, nmi) or possible
> > (yet unlikely) probe within the printk helpers.
> >
> > In very unlikely case we'd run out of the nesting levels the printk
> > will be omitted.
> >
> > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> >
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 61 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 47 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 3bbd3f0c810c..b9287b3a5540 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -369,33 +369,62 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
> >         return &bpf_probe_write_user_proto;
> >  }
> >
> > -static DEFINE_RAW_SPINLOCK(trace_printk_lock);
> > -
> >  #define MAX_TRACE_PRINTK_VARARGS       3
> >  #define BPF_TRACE_PRINTK_SIZE          1024
> > +#define BPF_TRACE_PRINTK_LEVELS                4
> > +
> > +struct trace_printk_buf {
> > +       char data[BPF_TRACE_PRINTK_LEVELS][BPF_TRACE_PRINTK_SIZE];
> > +       int level;
> > +};
> > +static DEFINE_PER_CPU(struct trace_printk_buf, printk_buf);
> > +
> > +static void put_printk_buf(struct trace_printk_buf __percpu *buf)
> > +{
> > +       if (WARN_ON_ONCE(this_cpu_read(buf->level) == 0))
> > +               return;
> > +       this_cpu_dec(buf->level);
> > +       preempt_enable();
> > +}
> > +
> > +static bool get_printk_buf(struct trace_printk_buf __percpu *buf, char **data)
> > +{
> > +       int level;
> > +
> > +       preempt_disable();
> 
> Can we use migrate_disable() instead?

I think that should work.. while checking on that I found
comment in in include/linux/preempt.h (though dated):

  The end goal must be to get rid of migrate_disable

but looks like both should work here and there are trade offs
for using each of them

> 
> > +       level = this_cpu_inc_return(buf->level);
> > +       if (level > BPF_TRACE_PRINTK_LEVELS) {
> 
> Maybe add WARN_ON_ONCE() here?

ok, will add

thanks,
jirka
