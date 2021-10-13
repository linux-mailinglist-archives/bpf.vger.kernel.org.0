Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4361542BFE1
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 14:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhJMM1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 08:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232807AbhJMM1h (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 08:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634127933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8YOBHg2cxN8ogGYoOT/g9xYB/0smdgUNl3MS2jFXUKQ=;
        b=arcQbXP5MMyFOIeDVtKF8mykTyXOvfwQC81PByttSs+C3gVMWNsjiu15Z3YKWsapa9gmOO
        xVpY27GydLaIfZfiEZhoay7tl9qPwfR++qEO6glE7hSYRwVP7myFIpMshTJG5zdaER4QB9
        0xScJS45K3uF81kycEV/HCp8YoPdTkY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-Gr6ZLDG2NnW3W7w5TRDnUw-1; Wed, 13 Oct 2021 08:25:32 -0400
X-MC-Unique: Gr6ZLDG2NnW3W7w5TRDnUw-1
Received: by mail-wr1-f69.google.com with SMTP id y12-20020a056000168c00b00160da4de2c7so1849497wrd.5
        for <bpf@vger.kernel.org>; Wed, 13 Oct 2021 05:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YOBHg2cxN8ogGYoOT/g9xYB/0smdgUNl3MS2jFXUKQ=;
        b=MUh7fBCvXj5MicRI2TZf6zaodUE3Zvn6oDnXKeotvPpPIa7poMIY2FyjGyLzbMoAVy
         UDXBTqUqfe0nPhYOjAL1lTXwP2tnuTpkeFE5xG/8ftb1lWiA7o05iM3kXdTyu4RGKmG7
         LHG/NWUpDqhj49sS39AZ9ziL9fyjdK5OKVSrcqyDPH0upwN5KT1oqhBtbwyg+C5pjaD3
         cttpz6Bz+3m2XOQAD6D1kGmLgq0snD4JgSnmWpZshBtXQ+NN6on+e4s2WbHhB0UxC5/X
         GqUQBTipY60FN6J8LPqbe/tRU8o5t+iotcaN47D6ef9OJDEKdQq5aeqDmJc9hNYUgeLL
         Wuag==
X-Gm-Message-State: AOAM532Aj/Oj+JULC+2j/MzrzSF2ONB92Q8P2pb/KB3pBAmKtiDzaHAY
        iUM//WvflYi8BjiqqE7ASZNvIwEfa+gOk5KCU0ljDMYr3fxegMbXvvj0tbz7rxHMmhsdAT9Gbae
        7oN+WpcwtnbT+
X-Received: by 2002:a05:600c:b5a:: with SMTP id k26mr12480610wmr.172.1634127931587;
        Wed, 13 Oct 2021 05:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Fm6ZpRgEuTdDHvgL6ziG2Yey+Xu8fBe+Ruq1ZnFYz4uNmvgF6gyg91uSbPPP/dPPTadUjQ==
X-Received: by 2002:a05:600c:b5a:: with SMTP id k26mr12480583wmr.172.1634127931404;
        Wed, 13 Oct 2021 05:25:31 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id m4sm5367957wrz.45.2021.10.13.05.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:25:31 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:25:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCHv2 0/8] x86/ftrace: Add direct batch interface
Message-ID: <YWbQObW70Vuju9hY@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
 <YWagbqm4wtYqpBt/@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWagbqm4wtYqpBt/@osiris>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 13, 2021 at 11:01:34AM +0200, Heiko Carstens wrote:
> On Fri, Oct 08, 2021 at 11:13:28AM +0200, Jiri Olsa wrote:
> > hi,
> > adding interface to maintain multiple direct functions
> > within single calls. It's a base for follow up bpf batch
> > attach functionality.
> ...
> > ---
> > Jiri Olsa (6):
> >       x86/ftrace: Remove extra orig rax move
> >       tracing: Add trampoline/graph selftest
> >       ftrace: Add ftrace_add_rec_direct function
> >       ftrace: Add multi direct register/unregister interface
> >       ftrace: Add multi direct modify interface
> >       ftrace/samples: Add multi direct interface test module
> > 
> > Steven Rostedt (VMware) (2):
> >       x86/ftrace: Remove fault protection code in prepare_ftrace_return
> >       x86/ftrace: Make function graph use ftrace directly
> > 
> >  arch/x86/include/asm/ftrace.h        |   9 +++-
> >  arch/x86/kernel/ftrace.c             |  71 +++++++++++++++---------------
> >  arch/x86/kernel/ftrace_64.S          |  30 +------------
> >  include/linux/ftrace.h               |  26 +++++++++++
> >  kernel/trace/fgraph.c                |   6 ++-
> >  kernel/trace/ftrace.c                | 268 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
> >  kernel/trace/trace_selftest.c        |  54 ++++++++++++++++++++++-
> >  samples/ftrace/Makefile              |   1 +
> >  samples/ftrace/ftrace-direct-multi.c |  52 ++++++++++++++++++++++
> >  9 files changed, 420 insertions(+), 97 deletions(-)
> >  create mode 100644 samples/ftrace/ftrace-direct-multi.c
> 
> FWIW, Steven pointed me to this thread since I posted
> DYNAMIC_FTRACE_WITH_DIRECT_CALL support for s390 here:
> https://lore.kernel.org/all/20211012133802.2460757-1-hca@linux.ibm.com/
> 
> Since Jiri asked for it: please feel free to add
> Tested-by: Heiko Carstens <hca@linux.ibm.com>
> to all non-x86 patches.
> 

thanks,
jirka

