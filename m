Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EB8492891
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 15:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbiAROjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 09:39:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343535AbiAROig (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Jan 2022 09:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642516715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L/3xiTwKonxDCzPOwDPfLLah1H5jM3BzmJPk13Up2Bg=;
        b=b+ISggn0TjKed6vxo/9ZdfioD6H256LGfSsx8mGpCb0gB4M0Gfw4TnRdzpXuWoKCQjsurm
        aRVD6t5RJrdqfUOVhgkfA5/3uBhBjUrHiDsn6Kjtx9hi3pZRRN4bpWbju5EZNc9F9R5p/u
        Ds36tzpidk+pcKT1FWu6VEzyULYSkzY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-0C9xNngmPcuXYKpfKtk6HA-1; Tue, 18 Jan 2022 09:38:33 -0500
X-MC-Unique: 0C9xNngmPcuXYKpfKtk6HA-1
Received: by mail-ed1-f69.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso17237080ede.12
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 06:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/3xiTwKonxDCzPOwDPfLLah1H5jM3BzmJPk13Up2Bg=;
        b=dl37nXntR0QgJtdKMROCmMxyRVw05hNe4rmGd9W9H6utloNA7OTbUBqT+p6sOk6fd7
         +iE3wbacI4qnZZcHrpn1diCUfkWu6APS/3yCEHhmjEkXT9uZq7sgcQZ9U+mEhAEC81d1
         BinSQ2syKKBq3rh06xxPyy0uxLuI2C5/XSTP44NwkNCMJjSBfIo1nKojlF0QK+xA8TBv
         VEg1KnXAfZ3LXz+ud9LDKGJSaUL9RGkcKrCo1Tv2NeDR5C5MSeJLQR/lLeaj98RaK0ve
         l2OvmeDH/WJVX/q+3qiN2i/NytjNQKEbC5Ftz7oylowMyW5rSBTispTCnM9r2ak1XiOV
         JUrg==
X-Gm-Message-State: AOAM531OobzLG3n3hVnLSVLaxgW0koxv/ekBuFpc9JwfxLU5cOPzO+pp
        PLjVMYrjWQHDbTGSoGztdf7Xjfze4/qXkep0LM4cLx/6YONggEhzkGpNSsrfrxajNWD8BDmyLgf
        IAR8Hrk/tOTwV
X-Received: by 2002:a05:6402:22d2:: with SMTP id dm18mr25313849edb.410.1642516712350;
        Tue, 18 Jan 2022 06:38:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypqPN9DQm94a1olWK3nqTc3tmoyxpKtTknk1gpNMzhugw4gQ/v2cnrt8sk2LTdvU5KY9yY4Q==
X-Received: by 2002:a05:6402:22d2:: with SMTP id dm18mr25313829edb.410.1642516712165;
        Tue, 18 Jan 2022 06:38:32 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id q14sm7065206edv.79.2022.01.18.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 06:38:31 -0800 (PST)
Date:   Tue, 18 Jan 2022 15:38:28 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
Message-ID: <YebQ5E0dEvbFqxL3@krava>
References: <164199616622.1247129.783024987490980883.stgit@devnote2>
 <CAEf4BzY9qmzemZ=3JSto+eWq9k-kX7hZKgugJRO9zZ61-pasqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY9qmzemZ=3JSto+eWq9k-kX7hZKgugJRO9zZ61-pasqg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 14, 2022 at 05:08:32PM -0800, Andrii Nakryiko wrote:
> On Wed, Jan 12, 2022 at 6:02 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Jiri and Alexei,
> >
> > Here is the 2nd version of fprobe. This version uses the
> > ftrace_set_filter_ips() for reducing the registering overhead.
> > Note that this also drops per-probe point private data, which
> > is not used anyway.
> 
> This per-probe private data is necessary for the feature called BPF
> cookie, in which each attachment has a unique user-provided u64 value
> associated to it, accessible at runtime through
> bpf_get_attach_cookie() helper. One way or another we'll need to
> support this to make these multi-attach BPF programs really useful for
> generic tracing applications.
> 
> Jiri,
> 
> We've discussed with Alexei this week how cookies can be supported for
> multi-attach fentry (where it seems even more challenging than in
> kprobe case), and agreed on rather simple solution, which roughly goes
> like this. When multi-attaching either fentry/fexit program, save
> sorted array of IP addresses and then sorted in the same order as IPs
> list of u64 cookies. At runtime, bpf_get_attach_cookie() helper should
> somehow get access to these two arrays and functions IP (that we
> already have with bpf_get_func_ip()), perform binary search and locate
> necessary cookie. This offloads the overhead of finding this cookie to
> actual call site of bpf_get_attach_cookie() (and it's a log(N), so not
> bad at all, especially if BPF program can be optimized to call this
> helper just once).
> 
> I think something like that should be doable for Masami's fprobe-based
> multi-attach kprobes, right? That would allow to have super-fast
> attachment, but still support BPF cookie per each individual IP/kernel
> function attachment. I haven't looked at code thoroughly, though,
> please let me know if I'm missing something fundamental.

ok, that seems doable, we should be able to get the link struct
in bpf_get_attach_cookie_trace and reach both ips and cookies

jirka

> 
> >
> > This introduces the fprobe, the function entry/exit probe with
> > multiple probe point support. This also introduces the rethook
> > for hooking function return as same as kretprobe does. This
> > abstraction will help us to generalize the fgraph tracer,
> > because we can just switch it from rethook in fprobe, depending
> > on the kernel configuration.
> >
> > The patch [1/8] and [7/8] are from your series[1]. Other libbpf
> > patches will not be affected by this change.
> >
> > [1] https://lore.kernel.org/all/20220104080943.113249-1-jolsa@kernel.org/T/#u
> >
> > I also added an out-of-tree (just for testing) patch at the
> > end of this series ([8/8]) for adding a wildcard support to
> > the sample program. With that patch, it shows how long the
> > registration will take;
> >
> > # time insmod fprobe_example.ko symbol='btrfs_*'
> > [   36.130947] fprobe_init: 1028 symbols found
> > [   36.177901] fprobe_init: Planted fprobe at btrfs_*
> > real    0m 0.08s
> > user    0m 0.00s
> > sys     0m 0.07s
> >
> > Thank you,
> >
> > ---
> >
> > Jiri Olsa (2):
> >       ftrace: Add ftrace_set_filter_ips function
> >       bpf: Add kprobe link for attaching raw kprobes
> >
> > Masami Hiramatsu (6):
> >       fprobe: Add ftrace based probe APIs
> >       rethook: Add a generic return hook
> >       rethook: x86: Add rethook x86 implementation
> >       fprobe: Add exit_handler support
> >       fprobe: Add sample program for fprobe
> >       [DO NOT MERGE] Out-of-tree: Support wildcard symbol option to sample
> >
> >
> >  arch/x86/Kconfig                |    1
> >  arch/x86/kernel/Makefile        |    1
> >  arch/x86/kernel/rethook.c       |  115 ++++++++++++++++++++
> >  include/linux/bpf_types.h       |    1
> >  include/linux/fprobe.h          |   57 ++++++++++
> >  include/linux/ftrace.h          |    3 +
> >  include/linux/rethook.h         |   74 +++++++++++++
> >  include/linux/sched.h           |    3 +
> >  include/uapi/linux/bpf.h        |   12 ++
> >  kernel/bpf/syscall.c            |  195 +++++++++++++++++++++++++++++++++-
> >  kernel/exit.c                   |    2
> >  kernel/fork.c                   |    3 +
> >  kernel/kallsyms.c               |    1
> >  kernel/trace/Kconfig            |   22 ++++
> >  kernel/trace/Makefile           |    2
> >  kernel/trace/fprobe.c           |  168 +++++++++++++++++++++++++++++
> >  kernel/trace/ftrace.c           |   54 ++++++++-
> >  kernel/trace/rethook.c          |  226 +++++++++++++++++++++++++++++++++++++++
> >  samples/Kconfig                 |    7 +
> >  samples/Makefile                |    1
> >  samples/fprobe/Makefile         |    3 +
> >  samples/fprobe/fprobe_example.c |  154 +++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h  |   12 ++
> >  23 files changed, 1103 insertions(+), 14 deletions(-)
> >  create mode 100644 arch/x86/kernel/rethook.c
> >  create mode 100644 include/linux/fprobe.h
> >  create mode 100644 include/linux/rethook.h
> >  create mode 100644 kernel/trace/fprobe.c
> >  create mode 100644 kernel/trace/rethook.c
> >  create mode 100644 samples/fprobe/Makefile
> >  create mode 100644 samples/fprobe/fprobe_example.c
> >
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 

