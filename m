Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE83AD89E
	for <lists+bpf@lfdr.de>; Sat, 19 Jun 2021 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhFSIfq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Jun 2021 04:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231697AbhFSIfq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 19 Jun 2021 04:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624091614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSWaHmjcp3JjxK94n6pmHTP8ePUjln67mAvdDntLzng=;
        b=eS8viaWLBcGIo/Bs9sd2VI4GstFR3N+niX46t9Vc9zZe2fr7T6JT4+dAPlb3ml+fLL5/hH
        /ckom5tkqoLmXt8VyMa8z+QbD4dRiK5LdlEVYkcTODB8i1KvtzFjGPgQWe6sFBFWX65HPL
        m8PEZuYABYvZfNVjj4ttRXKh0bV8ljc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-Ck9VBCKIM3GU7JzNYzhXsA-1; Sat, 19 Jun 2021 04:33:33 -0400
X-MC-Unique: Ck9VBCKIM3GU7JzNYzhXsA-1
Received: by mail-wr1-f72.google.com with SMTP id d5-20020a0560001865b0290119bba6e1c7so5632536wri.20
        for <bpf@vger.kernel.org>; Sat, 19 Jun 2021 01:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oSWaHmjcp3JjxK94n6pmHTP8ePUjln67mAvdDntLzng=;
        b=l6jkD7OVXyKYnsXXlzR5EvK3SEBLV8YKEUuSZ8N2RTzHWWFQKS0WbzmEBW4BFU5y0W
         t8FrYcIf/HzPRtW1uUnOXI0UCctOtPd3mLrA1C1KpWYjFVIXuNLhzB92K0vz/W5wLR+P
         hQK7R5VHvL07noWVHArftyYSBbGeSSeiYnuspEWpUnS4cXPC9YW38P+WfSUoovrlAu8Q
         fRlfEaOJl/atZfJCAQMf+4uJRVKBUqUgfF8L0S70QoSyA2GUhLumdbiDwR8MsZE0eEAX
         SG/+ro1yxJlq9lvQ17NXNHz5iXpKJdevmsZzNN3vh1QgJcg8QA4/JbU1SfOkV43UG4CK
         7lFA==
X-Gm-Message-State: AOAM533EAycIcQwy7FfYvhcfS1nnJAlsthuWphWR+kdnX9aDV0yHvnXw
        HvooD8voz8j/VdQAjZUmehEaY062Q3DQTIvglT1Lk9onnW/02pUehUuf6LukDAoMRwcEAx/YbSZ
        fvSw7UqX3g1dD
X-Received: by 2002:adf:d0ca:: with SMTP id z10mr4918958wrh.376.1624091612365;
        Sat, 19 Jun 2021 01:33:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE/PAasI/rL+i4tFE3f8uMhkjI0lO5R7Ygj6CiY0p7XNtDkW4atg6ry+rSsC4whSfQ7adB0w==
X-Received: by 2002:adf:d0ca:: with SMTP id z10mr4918936wrh.376.1624091612145;
        Sat, 19 Jun 2021 01:33:32 -0700 (PDT)
Received: from krava ([37.162.12.159])
        by smtp.gmail.com with ESMTPSA id h6sm1326772wmc.40.2021.06.19.01.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 01:33:31 -0700 (PDT)
Date:   Sat, 19 Jun 2021 10:33:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [RFCv3 00/19] x86/ftrace/bpf: Add batch support for
 direct/tracing attach
Message-ID: <YM2r139rHuXialVG@krava>
References: <20210605111034.1810858-1-jolsa@kernel.org>
 <CAEf4BzaK+t7zom6JHWf6XSPGDxjwhG4Wj3+CHKVshdmP3=FgnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaK+t7zom6JHWf6XSPGDxjwhG4Wj3+CHKVshdmP3=FgnA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 01:29:45PM -0700, Andrii Nakryiko wrote:
> On Sat, Jun 5, 2021 at 4:12 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > saga continues.. ;-) previous post is in here [1]
> >
> > After another discussion with Steven, he mentioned that if we fix
> > the ftrace graph problem with direct functions, he'd be open to
> > add batch interface for direct ftrace functions.
> >
> > He already had prove of concept fix for that, which I took and broke
> > up into several changes. I added the ftrace direct batch interface
> > and bpf new interface on top of that.
> >
> > It's not so many patches after all, so I thought having them all
> > together will help the review, because they are all connected.
> > However I can break this up into separate patchsets if necessary.
> >
> > This patchset contains:
> >
> >   1) patches (1-4) that fix the ftrace graph tracing over the function
> >      with direct trampolines attached
> >   2) patches (5-8) that add batch interface for ftrace direct function
> >      register/unregister/modify
> >   3) patches (9-19) that add support to attach BPF program to multiple
> >      functions
> >
> > In nutshell:
> >
> > Ad 1) moves the graph tracing setup before the direct trampoline
> > prepares the stack, so they don't clash
> >
> > Ad 2) uses ftrace_ops interface to register direct function with
> > all functions in ftrace_ops filter.
> >
> > Ad 3) creates special program and trampoline type to allow attachment
> > of multiple functions to single program.
> >
> > There're more detailed desriptions in related changelogs.
> >
> > I have working bpftrace multi attachment code on top this. I briefly
> > checked retsnoop and I think it could use the new API as well.
> 
> Ok, so I had a bit of time and enthusiasm to try that with retsnoop.
> The ugly code is at [0] if you'd like to see what kind of changes I
> needed to make to use this (it won't work if you check it out because
> it needs your libbpf changes synced into submodule, which I only did
> locally). But here are some learnings from that experiment both to
> emphasize how important it is to make this work and how restrictive
> are some of the current limitations.
> 
> First, good news. Using this mass-attach API to attach to almost 1000
> kernel functions goes from
> 
> Plain fentry/fexit:
> ===================
> real    0m27.321s
> user    0m0.352s
> sys     0m20.919s
> 
> to
> 
> Mass-attach fentry/fexit:
> =========================
> real    0m2.728s
> user    0m0.329s
> sys     0m2.380s

I did not meassured the bpftrace speedup, because the new code
attached instantly ;-)

> 
> It's a 10x speed up. And a good chunk of those 2.7 seconds is in some
> preparatory steps not related to fentry/fexit stuff.
> 
> It's not exactly apples-to-apples, though, because the limitations you
> have right now prevents attaching both fentry and fexit programs to
> the same set of kernel functions. This makes it pretty useless for a

hum, you could do link_update with fexit program on the link fd,
like in the selftest, right?

> lot of cases, in particular for retsnoop. So I haven't really tested
> retsnoop end-to-end, I only verified that I do see fentries triggered,
> but can't have matching fexits. So the speed-up might be smaller due
> to additional fexit mass-attach (once that is allowed), but it's still
> a massive difference. So we absolutely need to get this optimization
> in.
> 
> Few more thoughts, if you'd like to plan some more work ahead ;)
> 
> 1. We need similar mass-attach functionality for kprobe/kretprobe, as
> there are use cases where kprobe are more useful than fentry (e.g., >6
> args funcs, or funcs with input arguments that are not supported by
> BPF verifier, like struct-by-value). It's not clear how to best
> represent this, given currently we attach kprobe through perf_event,
> but we'll need to think about this for sure.

I'm fighting with the '2 trampolines concept' at the moment, but the
mass attach for kprobes seems interesting ;-) will check

> 
> 2. To make mass-attach fentry/fexit useful for practical purposes, it
> would be really great to have an ability to fetch traced function's
> IP. I.e., if we fentry/fexit func kern_func_abc, bpf_get_func_ip()
> would return IP of that functions that matches the one in
> /proc/kallsyms. Right now I do very brittle hacks to do that.

so I hoped that we could store ip always in ctx-8 and have
the bpf_get_func_ip helper to access that, but the BPF_PROG
macro does not pass ctx value to the program, just args

we could perhaps somehow store the ctx in BPF_PROG before calling
the bpf program, but I did not get to try that yet

> 
> So all-in-all, super excited about this, but I hope all those issues
> are addressed to make retsnoop possible and fast.
> 
>   [0] https://github.com/anakryiko/retsnoop/commit/8a07bc4d8c47d025f755c108f92f0583e3fda6d8

thanks for checking on this,
jirka

