Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D51D596B
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2019 03:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfJNByg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Oct 2019 21:54:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38477 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfJNByg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Oct 2019 21:54:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id m16so12492219oic.5
        for <bpf@vger.kernel.org>; Sun, 13 Oct 2019 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6X+DcjsMjHwOB6JkPbeUc/ALXoDOCE2zEMdjHf4FHXw=;
        b=XIUzDc2uX54JyOkNq/Q3w+p/rU489BTXCurHKtE62SPHEw8PG3aQcYfopuA+XbRPHG
         e1jJ+eb+fDZVeC1A8f6k1mwpvOxtb528maByh/ujYOMRbzH8RPyWcGT1NnjTyttzqH2O
         sMlZuUIbo6NT7SeTU4anenz+Q4l6MotAvHKSZJ7Rdi5Z0Rap7qAyA9xEDNMFkZyojb/E
         2mRWiS1ZuahOrvU7QsVZXNVYysgyAtmVK/TxteMjr31HJ6Y0ROWA4KYqWl4DrqL0F3rN
         jyMh6ohJyg8ZKjTi3ks49z7t+xbCk2ev82thc+EPPrxdEWGhVXxfhZZ4Y/MrimX7AL4H
         hAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6X+DcjsMjHwOB6JkPbeUc/ALXoDOCE2zEMdjHf4FHXw=;
        b=kk1+jDyOdy8LyxO+aQ8GTO7ls9o++FsIWOCEn7AibkV5RkgMH294leYOlUQKvKhv/9
         TUs8qdKjfpYGGDazbWn989+zL9PRUicSLDJnmJzI4BZKVlNpUjCNQY8hKGNrO7oDgAdh
         9eaKzTu9vohdH2zQUDqBOD1x+L8FRNXoMXR2In3wk88D0tF0Q8fqeOs2gq3IAOjuKvhS
         y2soKng8BeERgg3RKYKgiyb7snJA4kYSIJmN59uoN3sci2yuvSP4vJOzVz1CGo3Iy5H+
         24QIcJ4uqybV9ESZGWw3NBjQaRbF3kSJTYdcMgAEgLXSNqQO85MJ4ROOOQpOxnYjtOTp
         XoSA==
X-Gm-Message-State: APjAAAUmMb/wGG+4EuvAFF1dOhdeoaS34P1GMO3okSTEDHZb4wteXJDt
        cZfsUPJ5jb0k1zZ1IKbtbl0=
X-Google-Smtp-Source: APXvYqx4l1vYgjhaF18ymoDvmARPlkpbH/Q3+b6tAeVvK0Mii2s4svfW0l3kghrLMeeRLMgWbOO5ew==
X-Received: by 2002:aca:d402:: with SMTP id l2mr22745948oig.127.1571018074913;
        Sun, 13 Oct 2019 18:54:34 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 11sm5574669otg.62.2019.10.13.18.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Oct 2019 18:54:34 -0700 (PDT)
Date:   Sun, 13 Oct 2019 18:54:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        kbuild@01.org, Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [ast:btf_vmlinux 1/7] net/mac80211/./trace.h:253:1: warning:
 redefinition of typedef 'btf_trace_local_only_evt' is a C11 feature
Message-ID: <20191014015432.GA54176@ubuntu-m2-xlarge-x86>
References: <201910032202.OVnkgkNP%lkp@intel.com>
 <20191011200059.GA30072@ubuntu-m2-xlarge-x86>
 <CAADnVQJA7otF=us0usjZ9x0pqpX--9UVLZhwZe-+8pVf-PMkpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJA7otF=us0usjZ9x0pqpX--9UVLZhwZe-+8pVf-PMkpQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 13, 2019 at 06:42:20PM -0700, Alexei Starovoitov wrote:
> On Fri, Oct 11, 2019 at 1:01 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Thu, Oct 03, 2019 at 10:48:31PM +0800, kbuild test robot wrote:
> > > CC: kbuild-all@01.org
> > > TO: Alexei Starovoitov <ast@kernel.org>
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git btf_vmlinux
> > > head:   cc9b0a180111f856b93a805fdfc2fb288c41fab2
> > > commit: 82b70116b6ba453e1dda06c7126e100d594b8e0a [1/7] bpf: add typecast to help vmlinux BTF generation
> > > config: x86_64-rhel-7.6 (attached as .config)
> > > compiler: clang version 10.0.0 (git://gitmirror/llvm_project 38ac6bdb83a9bb76c109901960c20d1714339891)
> > > reproduce:
> > >         git checkout 82b70116b6ba453e1dda06c7126e100d594b8e0a
> > >         # save the attached .config to linux build tree
> > >         make ARCH=x86_64
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    In file included from net/mac80211/trace.c:11:
> > >    In file included from net/mac80211/./trace.h:2717:
> > >    In file included from include/trace/define_trace.h:104:
> > >    In file included from include/trace/bpf_probe.h:110:
> > > >> net/mac80211/./trace.h:253:1: warning: redefinition of typedef 'btf_trace_local_only_evt' is a C11 feature [-Wtypedef-redefinition]
> > >    DEFINE_EVENT(local_only_evt, drv_start,
> > >    ^
> > >    include/trace/bpf_probe.h:104:2: note: expanded from macro 'DEFINE_EVENT'
> > >            __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
> > >            ^
> > >    include/trace/bpf_probe.h:77:16: note: expanded from macro '__DEFINE_EVENT'
> > >    typedef void (*btf_trace_##template)(void *__data, proto);              \
> >
> > Hi Alexei,
> >
> > The 0day team has been running clang builds for us for a little bit and
> > this one popped up. It looks like there are certain tracepoints that use
> > the same template so clang warns because there are two identical
> > typedefs. Is there any way to improve this so we don't get noisey
> > builds? This still occurs as of your latest btf_vmlinux branch even
> > though this report is from a week ago.
> 
> Thanks for headsup. That was indeed a valid bug in my branch.
> Interestingly gcc didn't complain.
> I knew that 0day bot is testing my development tree, but
> I didn't know it's doing it with clang.
> And for some reason I didn't receive any reports
> about this breakage.
> More so I got 'build success' email from 0day for my branch.
> Something to improve in the bot, I guess.
> 
> If you're curious the fix was:
> -typedef void (*btf_trace_##template)(void *__data, proto);             \
> +typedef void (*btf_trace_##call)(void *__data, proto);                 \
> 
> I forced pushed my btf_vmlinux branch.
> Please let me know if you still see this issue.
> 
> Thanks!

Yes, right now, the 0day build reports for clang are only getting sent
to our mailing list (clang-built-linux@googlegroups.com) because there
is a lot of overlap with GCC. We have been manually triaging the build
warnings and forwarding them along. I think the 0day maintainers
eventually intend to make these emails more public (maybe have an opt in
system when maintainers want to see clang build results, with the
understanding there might be duplicates?). Unfortunately, I cannot speak
for them.

I brought down your branch and built the net/ subdirectory with the
config that produced this warning and I do not see any warnings. Thanks
for the quick response!

Nathan
