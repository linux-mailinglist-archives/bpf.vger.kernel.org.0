Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE744AD45A
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 10:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352993AbiBHJIn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 04:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349138AbiBHJIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 04:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42AF7C03FEC0
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 01:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644311320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQUC+1hSWX9c74JSGFIRouvl2dTObm6AQTxbt8zkabA=;
        b=igrmkX4TN6tWe8zRzOo7L4dY1bXXWIODHaPqy0Inmoo1jD9rwnR/W0RTmjZdMjOICvN8Ig
        +Y6Rt1dsKOUVROhAjjGZTM5WWY892HUqOMuE6R3TFAb/wcm6xbovZn4RHtGeVgbFB5rZMk
        ofiBzHOVkfCzu4KsnVumDzr5RECEbHI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-YYXm7ElpPCyFy1wT23neOg-1; Tue, 08 Feb 2022 04:08:38 -0500
X-MC-Unique: YYXm7ElpPCyFy1wT23neOg-1
Received: by mail-ed1-f70.google.com with SMTP id w15-20020a056402268f00b00408234dc1dfso9333153edd.16
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 01:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aQUC+1hSWX9c74JSGFIRouvl2dTObm6AQTxbt8zkabA=;
        b=8Od9eD/xcXls/7a12mYQH5RZYeJysmx/nm4cgjRjrVfw1KqldRK4qkOVPH0JD4u7jW
         V7FTt0TKnSAvGpV8css/ZUpPg5Xl7VMHkkn1C/avdDcWgZzr/HTR5S2T+hqDD4iBYKOX
         RMjjAUB0388iHRoKefILYQHX3lyAxLoRccUQKs/TenhwdHiPttRbGBqS3n+zbTaW1G3a
         iFGMTxhFNwWddahZ4viMNxjAhA/yDEXhpT4zEbslg0doyqj0J4FfY+1dhDCFL32hmgjb
         Z8puMIZlsgxX0VqKWe4d2Mz4CbjNOx9Shbfd3rG35ZaBZ3e+V50Im5IvJED6ZmypNlj5
         xGLA==
X-Gm-Message-State: AOAM5303MMP5d++jCgCrruKpQvibUHeXOjrvcBQkf6XoQ6D/SfkUGxSM
        6vrxvSxjHu9Oz3KCpTTNeLmGIrvI/dmjf2Kz/Vo5qS4IYJ5r4U2RyaURUrEBZG2be/rviHHA70E
        X2mj4y+duvEjz
X-Received: by 2002:a17:907:72c6:: with SMTP id du6mr2862967ejc.220.1644311317655;
        Tue, 08 Feb 2022 01:08:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLf2Pa4fGfKUOhyzVr4fXCs9bdLQ7+9bNMMvxFrCXYkGvHAq+Wi24K2P+aoyiWC3hAqhyoGQ==
X-Received: by 2002:a17:907:72c6:: with SMTP id du6mr2862960ejc.220.1644311317471;
        Tue, 08 Feb 2022 01:08:37 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k13sm1871112ejz.167.2022.02.08.01.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:08:36 -0800 (PST)
Date:   Tue, 8 Feb 2022 10:08:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH 4/8] libbpf: Add libbpf__kallsyms_parse function
Message-ID: <YgIzEsqr4pQIIynj@krava>
References: <20220202135333.190761-1-jolsa@kernel.org>
 <20220202135333.190761-5-jolsa@kernel.org>
 <CAEf4Bzaj3x8K6VA5FgkYbbAWz2vtBwyepbpe-np30pYD1m22gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzaj3x8K6VA5FgkYbbAWz2vtBwyepbpe-np30pYD1m22gQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 07, 2022 at 10:59:24AM -0800, Andrii Nakryiko wrote:
> On Wed, Feb 2, 2022 at 5:54 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Move the kallsyms parsing in internal libbpf__kallsyms_parse
> > function, so it can be used from other places.
> >
> > It will be used in following changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c          | 62 ++++++++++++++++++++-------------
> >  tools/lib/bpf/libbpf_internal.h |  5 +++
> >  2 files changed, 43 insertions(+), 24 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 1b0936b016d9..7d595cfd03bc 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -7165,12 +7165,10 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
> >         return 0;
> >  }
> >
> > -static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
> > +int libbpf__kallsyms_parse(void *arg, kallsyms_cb_t cb)
> 
> please call it libbpf_kallsyms_parse(), internal APIs don't use
> "object oriented" double underscore separator
> 
> also this "arg" is normally called "ctx" in similar APIs in libbpf and
> is passed the last, can you please adjust all that for consistency?

ok, thanks

jirka

> 
> >  {
> >         char sym_type, sym_name[500];
> >         unsigned long long sym_addr;
> > -       const struct btf_type *t;
> > -       struct extern_desc *ext;
> >         int ret, err = 0;
> >         FILE *f;
> >
> 
> [...]
> 

