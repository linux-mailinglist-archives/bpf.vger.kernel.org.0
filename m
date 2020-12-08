Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECDF2D3108
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 18:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgLHR2P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 12:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgLHR2P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 12:28:15 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE1CC06179C
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 09:27:28 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id jx16so25672841ejb.10
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 09:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Sw45E94f6bWYHfaoTxJHDqPOotXZzGeB8fmv0qtq6V0=;
        b=gA+GQCNJXRoAfRN879RAl4Jrzvvb2LXlgDT2f1X+32OjsNLhJ+Kvaqh3bJrcqiiHhg
         X4Xj/eaar9XKQRiHT+RbEFC8KJc3oR3An7o/FfWd0swvP5eoSredwp5PedaRuLwQtn4v
         7+TQHKQPSEdk3+MEIu82giUEmijJuWwVUiIrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Sw45E94f6bWYHfaoTxJHDqPOotXZzGeB8fmv0qtq6V0=;
        b=gX1CWOFTXsR6+MF8esd6YB1yZgSYOGYZRQKky0hdc4wchD66qSP9YTC1kD07nQI8F7
         +84mFEv9pGgT+V6VcacnqNBrxcrsAw2HZZSN7WbEXUUaq/9SjO726tys6xD1CAVSY7Rj
         OvgM+aJCit4G5/81emi5szDrUT4J0jzfJKrcyKND6VreubQWQoKOqQMKQv9vz9qqJZce
         k6/2L9iutCDXN5CxsR0a09y9bj0SGPj3ASFto2R2dd5RVqdvi9hhPdLR19sV/jmX8902
         z6EBEmxhUzh2ZeDOXG24RNqf91iLEoSAukjaqRBV5rYAYkI/rdQ0Z6Iu8PLNOpt21+mp
         kh0Q==
X-Gm-Message-State: AOAM532hnPohyY9qdB6m2anYrfXG892wvm8Pv5zifsmBfJGSH/7U8gCz
        6a46zrq3HvEAbhFAw/sa+lYkVA==
X-Google-Smtp-Source: ABdhPJw2LcySVIaLOpAQPEgkBS2otenSBfxIGClQbE+UoPY1pt0XT9dUp7wHlH7ffJBv0vuOkSRHiA==
X-Received: by 2002:a17:906:7fcd:: with SMTP id r13mr24554164ejs.242.1607448447399;
        Tue, 08 Dec 2020 09:27:27 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id qu21sm16197447ejb.95.2020.12.08.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 09:27:26 -0800 (PST)
Message-ID: <889510dcd76082a63f218b8187b1d11004fb1849.camel@chromium.org>
Subject: Re: [PATCH bpf-next v2] bpf: Only call sock_from_file with
 CONFIG_NET
From:   Florent Revest <revest@chromium.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org, rdunlap@infradead.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Dec 2020 18:27:25 +0100
In-Reply-To: <20201207213300.fy6xevnoidh2vk37@kafai-mbp.dhcp.thefacebook.com>
References: <20201207200605.650192-1-revest@chromium.org>
         <20201207213300.fy6xevnoidh2vk37@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2020-12-07 at 13:33 -0800, Martin KaFai Lau wrote:
> On Mon, Dec 07, 2020 at 09:06:05PM +0100, Florent Revest wrote:
> > This avoids
> >   ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
> >   bpf_trace.c:(.text+0xe23): undefined reference to
> > `sock_from_file'
> > When compiling a kernel with BPF and without NET.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  kernel/trace/bpf_trace.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 0cf0a6331482..29ec2b3b1cc4 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1272,7 +1272,11 @@ const struct bpf_func_proto
> > bpf_snprintf_btf_proto = {
> >  
> >  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
> >  {
> > +#ifdef CONFIG_NET
> >  	return (unsigned long) sock_from_file(file);
> > +#else
> > +	return 0;
> > +#endif
> >  }
> Should bpf_sock_from_file_proto belong to
> tracing_prog_func_proto() instead of bpf_tracing_func_proto()?
> bpf_skc_to_*_proto is also in tracing_prog_func_proto()
> where there is an existing "#ifdef CONFIG_NET".

I'm happy to move bpf_sock_from_file to tracing_prog_func_proto if
you'd prefer that. I'm actually unsure what the difference would be,
those function names are confusing, but this works for our use-case. :)

However, by itself, that wouldn't address the problem reported by Randy
since the helper definition would still be compiled and have an
undefined reference to sock_from_file. The existing socket helpers (for
example skc_to_tcp_sock) can get away without a patch like mine because
they are defined in net/core/filter.c which only gets compiled with
CONFIG_NET.

I will send a v3 where I move the sock_from_file helper definition to
net/core/filter.c and also move the usage of the helper to
tracing_prog_func_proto under CONFIG_NET and then you can feel free to
merge v2 or v3 depending on which approach you prefer (or a followup
version if I mess up again... :D)

