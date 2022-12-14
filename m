Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0964C60D
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 10:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiLNJdv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 04:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbiLNJdt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 04:33:49 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58CE1DB
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 01:33:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so43084063ejc.4
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDierwy0Xe1mtWiRc/Zv/sKz+ZHq5ibElZhWZZxYkx8=;
        b=GpKoVf9hFgCFFQrvCENuGvGRCAWFcYU+CTPeKaG6g7VExdE+xE1Ys+1ouZRVN/6v3m
         AfxSPOSCOwLpIOmpMwM1RsxLqzg/hk9KYhmE0NdrNAkmmBBIO8Iofe+lH4zMuXXNBF9U
         Puumo7mt+5iEG0GRZUleoCAS0xVAp1y3ULdi5bPqlxwkLd3PXnWkHApmsy/xJBrJowRk
         msQQ5Uk3MlDnAFWwUeNtsxmLxNsaIP8njjYjfy8+YxFeH1UBg2TDmoH0FveUjFoAt2ZV
         /vyiyuhvvCBP4VPRJzmcHzObWfJGAO/rUWb+qRr9cQCq3q9IiYeqGFJB08AsVNHPF3tX
         5Klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDierwy0Xe1mtWiRc/Zv/sKz+ZHq5ibElZhWZZxYkx8=;
        b=ll6ppCPDQ3x2LnE4g7Jj4FgjX1xcwxEntNfe0XaN+dR0S3GeSnbLudLGlpaGDuWqTZ
         RHSh0TuDp0FtJN4DDq1zTBIYAT7/HlEFpRPUPqzNBR5zKFXh72rdPcTb9HYQsjPn7RVD
         uUJY6PS/NnthnlkAr++3TURiXGDK9rCsRZK9lMdJsJjmiZiNZ4TMCI+AfUuiXujsqG5U
         JMdF2jHLuWE9uceAEWp3Pd+0aAn9feJkQ5ghJelY4XdRgnNwWzxaN+l5tPbGU/QwZTBM
         +HJwQrK5RHdNrmQ6IQpG0Y8gO2H43uhVza7zEQJ2TrKS8ZJHP4iNx7L4Xt1pdfqTBZM+
         4Ibw==
X-Gm-Message-State: ANoB5pm6h/vNyzb1gR6ZRs8bZYAAfFAqo4jenzE0lM5Ks8WyO4CzQ+8a
        s/1GsGqPe07Ti4+9Ys0LbVQ=
X-Google-Smtp-Source: AA0mqf7wui/mkMq7REb2znP4FZVG6TLVVUeRFxSG6MqDTsDfFaj5mRZ0rtTQcob5TST7rkWY63sy0g==
X-Received: by 2002:a17:906:2284:b0:7c0:4030:ae20 with SMTP id p4-20020a170906228400b007c04030ae20mr20793048eja.24.1671010427096;
        Wed, 14 Dec 2022 01:33:47 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z14-20020a170906074e00b007838e332d78sm5471593ejb.128.2022.12.14.01.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 01:33:46 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 14 Dec 2022 10:33:44 +0100
To:     Yonghong Song <yhs@meta.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <Y5mYeCwZPgUcBbUA@krava>
References: <20221213140843.803293-1-jolsa@kernel.org>
 <CAPhsuW5sQaspOhurLWm0igDUJk+V9ihmt0WnjaKsq1gJ66F6Gw@mail.gmail.com>
 <Y5j0XYQyiDP1Uu68@krava>
 <aef233ff-095d-0f51-735e-8054fafcb4bf@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef233ff-095d-0f51-735e-8054fafcb4bf@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 03:52:38PM -0800, Yonghong Song wrote:
> 
> 
> On 12/13/22 1:53 PM, Jiri Olsa wrote:
> > On Tue, Dec 13, 2022 at 10:48:43AM -0800, Song Liu wrote:
> > > On Tue, Dec 13, 2022 at 6:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > 
> > > > Both bpf_trace_printk and bpf_trace_vprintk helpers use static buffer
> > > > guarded with trace_printk_lock spin lock.
> > > > 
> > > > The spin lock contention causes issues with bpf programs attached to
> > > > contention_begin tracepoint [1] [2].
> > > > 
> > > > Andrii suggested we could get rid of the contention by using trylock,
> > > > but we could actually get rid of the spinlock completely by using
> > > > percpu buffers the same way as for bin_args in bpf_bprintf_prepare
> > > > function.
> > > > 
> > > > Adding 4 per cpu buffers (1k each) which should be enough for all
> > > > possible nesting contexts (normal, softirq, irq, nmi) or possible
> > > > (yet unlikely) probe within the printk helpers.
> > > > 
> > > > In very unlikely case we'd run out of the nesting levels the printk
> > > > will be omitted.
> > > > 
> > > > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > > > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> > > > 
> > > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Maybe change to subject to 'Remove trace_printk_lock' instead
> of 'Remove trace_printk_lock lock'? The 'trace_printk_lock'
> should already imply 'lock'?

ok

> 
> > > > ---
> > > >   kernel/trace/bpf_trace.c | 61 +++++++++++++++++++++++++++++++---------
> > > >   1 file changed, 47 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > index 3bbd3f0c810c..b9287b3a5540 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -369,33 +369,62 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
> > > >          return &bpf_probe_write_user_proto;
> > > >   }
> > > > 
> > > > -static DEFINE_RAW_SPINLOCK(trace_printk_lock);
> > > > -
> > > >   #define MAX_TRACE_PRINTK_VARARGS       3
> > > >   #define BPF_TRACE_PRINTK_SIZE          1024
> > > > +#define BPF_TRACE_PRINTK_LEVELS                4
> > > > +
> > > > +struct trace_printk_buf {
> > > > +       char data[BPF_TRACE_PRINTK_LEVELS][BPF_TRACE_PRINTK_SIZE];
> > > > +       int level;
> > > > +};
> > > > +static DEFINE_PER_CPU(struct trace_printk_buf, printk_buf);
> > > > +
> > > > +static void put_printk_buf(struct trace_printk_buf __percpu *buf)
> > > > +{
> > > > +       if (WARN_ON_ONCE(this_cpu_read(buf->level) == 0))
> > > > +               return;
> > > > +       this_cpu_dec(buf->level);
> > > > +       preempt_enable();
> > > > +}
> > > > +
> > > > +static bool get_printk_buf(struct trace_printk_buf __percpu *buf, char **data)
> > > > +{
> > > > +       int level;
> > > > +
> > > > +       preempt_disable();
> > > 
> > > Can we use migrate_disable() instead?
> > 
> > I think that should work.. while checking on that I found
> > comment in in include/linux/preempt.h (though dated):
> 
> I am not sure about whether migrate_disable() will work. For example,
>   . task1 takes over level=0 buffer, level = 1
>   . task1 yields to task2 with preemption in the same cpu
>   . task2 takes over level=1 buffer, level = 2
>   . task2 yields to task1 in the same cpu
>   . task1 releases the buffer, level = 1
>   . task1 yields to task3 in the same cpu
>   . task3 takes over level=1 buffer, level = 2
>     <=== we have an issue here, both task2 and task3 use level=1 buffer.

hum, did not think of that.. will keep the preempt_disable then

thanks,
jirka

> 
> > 
> >    The end goal must be to get rid of migrate_disable
> > 
> > but looks like both should work here and there are trade offs
> > for using each of them
> > 
> > > 
> > > > +       level = this_cpu_inc_return(buf->level);
> > > > +       if (level > BPF_TRACE_PRINTK_LEVELS) {
> > > 
> > > Maybe add WARN_ON_ONCE() here?
> > 
> > ok, will add
> > 
> > thanks,
> > jirka
