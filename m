Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5A3B9D6B
	for <lists+bpf@lfdr.de>; Fri,  2 Jul 2021 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhGBIT2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Jul 2021 04:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230149AbhGBIT1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 2 Jul 2021 04:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625213815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBkbuL0GAQIoWtsDWjIVFNTZu/k7IM9ZWEHLrdTuBFM=;
        b=gxFWVMuVLRQlLw85KWIoHfWUyee3/FK3kzWKcb/Jkxr0RSCWVJ0se8Fi60qhMCmgq7Lamg
        4EMUH339MOCItDEL2GWSJb2CKrs+4r08FBWP9CIyZGB1DeqNyPbgL4Ek3bzjX1m5Jan3cM
        H+RnMF+skT7ErC+Zrj29iQ0Jfl29eMk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-39SKAIxMOwiRanYKJ-ES0g-1; Fri, 02 Jul 2021 04:16:53 -0400
X-MC-Unique: 39SKAIxMOwiRanYKJ-ES0g-1
Received: by mail-ej1-f69.google.com with SMTP id d21-20020a1709063455b02904c609ed19f1so3263373ejb.11
        for <bpf@vger.kernel.org>; Fri, 02 Jul 2021 01:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zBkbuL0GAQIoWtsDWjIVFNTZu/k7IM9ZWEHLrdTuBFM=;
        b=jwf9Vihd0ycgoDOdE1tK5f6UgbOdC4QOGrOdxkJ6NYGf9ysth8AYQ0VURsL2SDlUmy
         HP5x2l11fjnFKNmHmb5qbubjSCkxQYTxUW11QTTTtVqp0bMsLxYglxqeEdAR9iBh91Lf
         5jkPgLxAbH4+P6ywjybZjVdCpoS5t1CrUAh8JSYrnfDA2/yLbrOwRj+tzDpDEWZ1s2qI
         BderxR83mhK8jJ/S4H5BzJiX5R3ysiUJ4wQ1Qh8Kc1sIobPak5nYDzAcHqU4yzZaiLga
         AVZwghc4zbPlBnL2qNnvKMfs2dB0SMAcEgeWETWomb9+ZI8HDL4awGzguMGetTTVFusP
         6Qtw==
X-Gm-Message-State: AOAM532Ebulk5a9dClvFvYLXQ1rrz8iLtEBk275XNklV+9d4pHbm67EN
        9XqcQn4Qyr2DGCaG3isDjEopda6opJ+Sq79+/xRp0T7kXamaTWIyM8j7YMk9dLg6oBS3lYB1vwm
        hvyDo6F7mm5s+
X-Received: by 2002:a17:906:940b:: with SMTP id q11mr4274039ejx.79.1625213812784;
        Fri, 02 Jul 2021 01:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzi6ZvJtE42/Z8dw3YYQEScj3zDC9d9Z8uOfAcwviCkH+zoWbYqKCjfOrDMjV851yZkNo9sw==
X-Received: by 2002:a17:906:940b:: with SMTP id q11mr4274024ejx.79.1625213812587;
        Fri, 02 Jul 2021 01:16:52 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id jz12sm738900ejc.94.2021.07.02.01.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 01:16:52 -0700 (PDT)
Date:   Fri, 2 Jul 2021 10:16:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC bpf-next 0/5] bpf, x86: Add bpf_get_func_ip helper
Message-ID: <YN7LcJu73nCz3Ips@krava>
References: <20210629192945.1071862-1-jolsa@kernel.org>
 <alpine.LRH.2.23.451.2107011819160.27594@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.23.451.2107011819160.27594@localhost>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 01, 2021 at 06:22:45PM +0100, Alan Maguire wrote:
> On Tue, 29 Jun 2021, Jiri Olsa wrote:
> 
> > hi,
> > adding bpf_get_func_ip helper that returns IP address of the
> > caller function for trampoline and krobe programs.
> > 
> > There're 2 specific implementation of the bpf_get_func_ip
> > helper, one for trampoline progs and one for kprobe/kretprobe
> > progs.
> > 
> > The trampoline helper call is replaced/inlined by verifier
> > with simple move instruction. The kprobe/kretprobe is actual
> > helper call that returns prepared caller address.
> > 
> > The trampoline extra 3 instructions for storing IP address
> > is now optional, which I'm not completely sure is necessary,
> > so I plan to do some benchmarks, if it's noticeable, hence
> > the RFC. I'm also not completely sure about the kprobe/kretprobe
> > implementation.
> > 
> > Also available at:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   bpf/get_func_ip
> > 
> > thanks,
> > jirka
> > 
> >
> 
> This is great Jiri! Feel free to add for the series:
> 
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

great, thanks for testing

> 
> BTW I also verified that if we extend bpf_program__attach_kprobe() to
> support the function+offset format in the func_name argument for kprobes, 
> the following test will pass too:
> 
> __u64 test5_result = 0;
> SEC("kprobe/bpf_fentry_test5+0x6")
> int test5(struct pt_regs *ctx)
> {
>         __u64 addr = bpf_get_func_ip(ctx);
> 
>         test5_result = (const void *) addr == (&bpf_fentry_test5 + 0x6);
>         return 0;
> }

right, I did not think of this test, I'll add it

thanks,
jirka

