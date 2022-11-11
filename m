Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4D625D70
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 15:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiKKOqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 09:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiKKOpr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 09:45:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61861E0E2;
        Fri, 11 Nov 2022 06:45:46 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id i10so4377964ejg.6;
        Fri, 11 Nov 2022 06:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqu57zoF/psAQB3zkG+KCRnbst4n8c4x2+PRCb87ZFw=;
        b=WWU6AvO7f1Ljtyy2Y6LiHGg4IvwIJ3GDTps31Fi2Q6P4xlrG96E6qPgZD/j+IrmxhM
         Q+pKLjvCihFlZB4pJU7feVo9Z0RCRaNYjQ9G5ZRAscSAPENAG8Cev7STPICSarXNVXnS
         FUMofNY3nYb/zoF9BAUj43otzq+Qlc9o/fmeaEyIzEW/51WMvOKEjqej7N6a96BOjjw7
         wW8GvzU5Z/0bG6PQc2BIWDu94D6eKrt30AsnLw/arRO+cKQqeYZnxcQNcejqxXgTeX67
         otvMZS9hkO4gJz8a1uZ4V2nysQlOJRwGANxjDF3PWeAuITE1WmX4LWSno/qbYirHsj09
         2f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqu57zoF/psAQB3zkG+KCRnbst4n8c4x2+PRCb87ZFw=;
        b=IHNkqOSfNLGoyJWM92Cww8roR85Q8gjsUaWjjRqZ9Mm6eLnPx2LBaqS/2/mElMKibz
         6hEpU5R4jYnz+GJKr4suCRm8YaIihMYqXv2oniy+RsFo+bavRl01qqYYvssqbZf9mX0s
         6gTu1IMm06//PKRhwINYrjbJ7UGYiB3NqehotSxxMD/FAtgtwC2R4szxCenbhCShkOuq
         jmO9e7Umd5jAvfrueHFr13BPr6HXVSfASBV6s9E7HO8r+fNIahfnDQkAd5NJthquS3LF
         6X07SLlfjSMOPLo7XXdk5IviaGW8DiiDiFDIB2mhwgwxrUOKjQk5/Gru2xf7zJScL2Eu
         J3Bw==
X-Gm-Message-State: ANoB5ple2CQ5JSYn7DZL6nzhPvscdLerdWAGbznq+oa31CjYBCj/DaWY
        rsTjk2HLJshhAX8+LZ+8GTo=
X-Google-Smtp-Source: AA0mqf4Ex9avT3Y51DfYT0NJHIbmMtSTsKgvwDqZsh/sm98euVJhW1RuN5NtW5sX8TLPvEJcEYK41Q==
X-Received: by 2002:a17:906:2f11:b0:78d:cc87:b1d7 with SMTP id v17-20020a1709062f1100b0078dcc87b1d7mr2093872eji.543.1668177944775;
        Fri, 11 Nov 2022 06:45:44 -0800 (PST)
Received: from krava ([83.240.62.198])
        by smtp.gmail.com with ESMTPSA id up22-20020a170907cc9600b007acbac07f07sm962943ejc.51.2022.11.11.06.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:45:44 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 11 Nov 2022 15:45:41 +0100
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: WARNING in bpf_bprintf_prepare
Message-ID: <Y25gFdliV7XqdUnN@krava>
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
 <Y1pqWPRmP0M+hcXf@krava>
 <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava>
 <Y2j6ivTwFmA0FtvY@krava>
 <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
 <Y2uv/GjnSdr/ujOj@krava>
 <CAADnVQJp0ZrodRu8ZtvvtXk6KAbjxmwqD-nXgFAxNpNxN6JM=g@mail.gmail.com>
 <Y2w9bNhVlAs/PcNV@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2w9bNhVlAs/PcNV@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 10, 2022 at 12:53:16AM +0100, Jiri Olsa wrote:

SNIP

> > > > > ---
> > > > > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > > > > index 6a13220d2d27..5a354ae096e5 100644
> > > > > --- a/include/trace/bpf_probe.h
> > > > > +++ b/include/trace/bpf_probe.h
> > > > > @@ -78,11 +78,15 @@
> > > > >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> > > > >
> > > > >  #define __BPF_DECLARE_TRACE(call, proto, args)                         \
> > > > > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);              \
> > > > >  static notrace void                                                    \
> > > > >  __bpf_trace_##call(void *__data, proto)                                        \
> > > > >  {                                                                      \
> > > > >         struct bpf_prog *prog = __data;                                 \
> > > > > -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > > > +                                                                       \
> > > > > +       if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) == 1))             \
> > > > > +               CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > > > +       this_cpu_dec(__bpf_trace_tp_active_##call);                                     \
> > > > >  }
> > > >
> > > > This approach will hurt real use cases where
> > > > multiple and different raw_tp progs run on the same cpu.
> > >
> > > would the 2 levels of nesting help in here?
> > >
> > > I can imagine the change above would break use case where we want to
> > > trigger tracepoints in irq context that interrupted task that's already
> > > in the same tracepoint
> > >
> > > with 2 levels of nesting we would trigger that tracepoint from irq and
> > > would still be safe with bpf_bprintf_prepare buffer
> > 
> > How would these 2 levels work?
> 
> just using the active counter like below, but I haven't tested it yet
> 
> jirka

seems to be working
Hao Sun, could you please test this patch?

thanks,
jirka
> 
> 
> ---
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 6a13220d2d27..ca5dd34478b7 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -78,11 +78,15 @@
>  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
>  
>  #define __BPF_DECLARE_TRACE(call, proto, args)				\
> +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);		\
>  static notrace void							\
>  __bpf_trace_##call(void *__data, proto)					\
>  {									\
>  	struct bpf_prog *prog = __data;					\
> -	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
> +									\
> +	if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) < 3))		\
> +		CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
> +	this_cpu_dec(__bpf_trace_tp_active_##call);					\
>  }
>  
>  #undef DECLARE_EVENT_CLASS
