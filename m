Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6948D7E6
	for <lists+bpf@lfdr.de>; Thu, 13 Jan 2022 13:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiAMM1l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 07:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230253AbiAMM1j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 07:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642076859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ViQVHhS9TeU1GADrKolwOU4MxQRPJUjTMiV4znToNZg=;
        b=S61E3PMcSiNkDJkvPVCzceJ9qfyhEJ3C2wN/Xz/GedDMNaGaHDfquIyBgQXMkdL0rs8cFq
        2qb53tWtXcxZuBkuXe5+9VTWyycoRiAvJ6p07PdHpIXvFjLyr4iGGfbMkAMet3UBZCnVXl
        a2gOjpm0nItJ+3FeJZ19ngUvXNuCu+A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-WPArihFvO2eCGibPN-helQ-1; Thu, 13 Jan 2022 07:27:37 -0500
X-MC-Unique: WPArihFvO2eCGibPN-helQ-1
Received: by mail-ed1-f71.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so5178433edd.15
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 04:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ViQVHhS9TeU1GADrKolwOU4MxQRPJUjTMiV4znToNZg=;
        b=JwIiMmleTb0/3KAcsJ4VMzl164dQwbekVxBGjMiSISa7FT4vs1pM7UT0dDkY9ewgYh
         CGsknG3Euw3BgowQzRlpoUiosrBMN9UYnqnOi9+Z2Qd2lqRp3V/p7t68VcnFWM4ybhTK
         i/9Ep4yMli9we6aU7LkbUw7ylyz4IqsQK3ww/bumyBXdFgAz3fefCu123VZmIjYdr68R
         xvDHYyntDL4l8XL1SjhGRtSjuK6ujYuh6roYz06wg73Gz4yoClDniy3+9Zl3ynHLim4D
         uw/vFclnSJRRo8tgQ6oFfzNEh3yCtMS0X3EqUhwvoyeYnADTDwWZqJUgO3b48qm/dnbw
         WcTw==
X-Gm-Message-State: AOAM530zXprP/hsuk7UZIcDcOQJ6B8ymu4JINCJR8SrmlFQ3KXlLLWoK
        u6uY6jvswE3x9+FJw/UWvbsfjgucIY6fdFt6KOODEvlf+gIk3B2sb28ax/Gx9cCRE4iL9bfHmkg
        LyEWCmb8wMtJq
X-Received: by 2002:a17:906:da1b:: with SMTP id fi27mr3480781ejb.68.1642076856776;
        Thu, 13 Jan 2022 04:27:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzq8hitOmNz+ym3vvwJSFT3GdzZkSBYpwA288q5gf8tRuG+8tKBO7yzTkkVxcdxI0Vag+s+w==
X-Received: by 2002:a17:906:da1b:: with SMTP id fi27mr3480767ejb.68.1642076856599;
        Thu, 13 Jan 2022 04:27:36 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id qa35sm836380ejc.67.2022.01.13.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 04:27:36 -0800 (PST)
Date:   Thu, 13 Jan 2022 13:27:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH v2 0/8] fprobe: Introduce fprobe function entry/exit
 probe
Message-ID: <YeAatqQTKsrxmUkS@krava>
References: <164199616622.1247129.783024987490980883.stgit@devnote2>
 <Yd77SYWgtrkhFIYz@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd77SYWgtrkhFIYz@krava>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 12, 2022 at 05:01:15PM +0100, Jiri Olsa wrote:
> On Wed, Jan 12, 2022 at 11:02:46PM +0900, Masami Hiramatsu wrote:
> > Hi Jiri and Alexei,
> > 
> > Here is the 2nd version of fprobe. This version uses the
> > ftrace_set_filter_ips() for reducing the registering overhead.
> > Note that this also drops per-probe point private data, which
> > is not used anyway.
> > 
> > This introduces the fprobe, the function entry/exit probe with
> > multiple probe point support. This also introduces the rethook
> > for hooking function return as same as kretprobe does. This
> 
> nice, I was going through the multi-user-graph support 
> and was wondering that this might be a better way
> 
> > abstraction will help us to generalize the fgraph tracer,
> > because we can just switch it from rethook in fprobe, depending
> > on the kernel configuration.
> > 
> > The patch [1/8] and [7/8] are from your series[1]. Other libbpf
> > patches will not be affected by this change.
> 
> I'll try the bpf selftests on top of this

I'm getting crash and stall when running bpf selftests,
the fprobe sample module works fine, I'll check on that

jirka

