Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F83424976
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 00:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbhJFWHM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 18:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230285AbhJFWHM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 18:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633557919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WIclh3AdLfVYAiQkIwrJSiR618YUkbU+lYFgoUPsNwE=;
        b=DGGm5ynFE5V7eFaxuE/pFDB0Wi5nDuD1uILyZDlRi6KzEeZ92lFDG4EmKJmZcq50HvoJ5j
        2MRJlksYC6P9+ZIyW7qYLB3aoOm2zTMyIe4H8c+pr2Ucp1ejoWhli8F7vG1gb1V/ZQGLdr
        fB73ePek99v2olj49TsMfr0Qt5nf+5U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-6I5pqS0FMdqlcbi20i-q6A-1; Wed, 06 Oct 2021 18:05:17 -0400
X-MC-Unique: 6I5pqS0FMdqlcbi20i-q6A-1
Received: by mail-wr1-f70.google.com with SMTP id k16-20020a5d6290000000b00160753b430fso3109781wru.11
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 15:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIclh3AdLfVYAiQkIwrJSiR618YUkbU+lYFgoUPsNwE=;
        b=F64oRoAEs9mFdmWE0Gq3v4Qs7FVNDuaX5DPpUjN4Px4aNIi+01hSMN0aAATCRTSReN
         xHtBvTzBiBD7Unr02OEkrUAEeQ6y+2mccoDNmQGi8ePRhJxDeXWXoYFOLzfMPKXT1u8c
         MtV7Bl3mw+vfKfVQnZjfac1QcnwMoiDYzel/wm5oGMixuYoYS4wBaPgTmy1uBKz7Frge
         Z3DwaSzNlcKfZoqD+l/TjIpOmbiN/pKV5+Gli7GOv3+9f7n5E2tGL/a+y07aODBa5DVG
         KV/8t9P0zVLuKKfXEgMsxREY+tWj281U7614vejmodKeVr4eHw1VDieEo61piW5JtUFc
         ZFYg==
X-Gm-Message-State: AOAM5321dbN7nDqH8Jya9nYvSkKorhH9J5wFtXK20w25G7BYXIh4pZBR
        5qoykzTBrIwXDX4BTrQzzP/6cWYyEjkbroxhRlG7GXLBScPS0aAvy3LtWxvHLa9/3e4k2Zyx2Kp
        kK4NM+A+i+jdj
X-Received: by 2002:adf:b7c1:: with SMTP id t1mr688005wre.387.1633557916632;
        Wed, 06 Oct 2021 15:05:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRTA68peCg8NEEERGtCSLZCyWO84r+k/Kvv8uWPQpdDnts+ZtGWzwc43c2i45LBMnvVeWplA==
X-Received: by 2002:adf:b7c1:: with SMTP id t1mr687965wre.387.1633557916339;
        Wed, 06 Oct 2021 15:05:16 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id i6sm12105401wrv.61.2021.10.06.15.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:05:16 -0700 (PDT)
Date:   Thu, 7 Oct 2021 00:05:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC] store function address in BTF
Message-ID: <YV4dmkXO6nkB2DeV@krava>
References: <YV1hRboJopUBLm3H@krava>
 <CAEf4BzZPH6WQTYaUTpWBw1gW=cNUtPYPnN8OySgXtbQLzZLhEQ@mail.gmail.com>
 <YV4Bx7705mgWzhTd@krava>
 <CAEf4BzbirA4F_kW-sVrS_YmfUxhAjYVDwO1BvtzTYyngqHLkiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbirA4F_kW-sVrS_YmfUxhAjYVDwO1BvtzTYyngqHLkiw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 06, 2021 at 02:22:28PM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 6, 2021 at 1:06 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Oct 06, 2021 at 09:17:39AM -0700, Andrii Nakryiko wrote:
> > > On Wed, Oct 6, 2021 at 1:42 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > hi,
> > > > I'm hitting performance issue and soft lock ups with the new version
> > > > of the patchset and the reason seems to be kallsyms lookup that we
> > > > need to do for each btf id we want to attach
> > > >
> > > > I tried to change kallsyms_lookup_name linear search into rbtree search,
> > > > but it has its own pitfalls like duplicate function names and it still
> > > > seems not to be fast enough when you want to attach like 30k functions
> > >
> > > How not fast enough is it exactly? How long does it take?
> >
> > 30k functions takes 75 seconds for me, it's loop calling bpf_check_attach_target
> >
> > getting soft lock up messages:
> >
> > krava33 login: [  168.896671] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [bpftrace:1087]
> >
> 
> That's without RB tree right? I was curious about the case of you
> converting kallsyms to RB tree and it still being slow. Can't imagine
> 30k queries against RB tree with ~160k kallsyms taking 75 seconds.

yep, that's the standard kallsyms lookup api

I need to make some adjustment for rbtree kalsyms code, I think I found
a bug in there, so the numbers are probably better as you suggest

> 
> But as I said, why not map BTF IDs into function names, sort function
> names, and then pass over kallsyms once, doing binary search into a
> sorted array of requested function names and then recording addr for
> each. Then check that you found addresses for all functions (it also
> leaves a question of what to do when we have multiple matching
> functions, but it's a problem with any approach). If everything checks
> out, you have a nice btf id -> func name -> func addr mapping. It's
> O(N log(M)), which sounds like it shouldn't be slow. Definitely not
> multiple seconds slow.

ok, now that's clear to me, thanks for these details

> 
> 
> >
> > >
> > > >
> > > > so I wonder we could 'fix this' by storing function address in BTF,
> > > > which would cut kallsyms lookup completely, because it'd be done in
> > > > compile time
> > > >
> > > > my first thought was to add extra BTF section for that, after discussion
> > > > with Arnaldo perhaps we could be able to store extra 8 bytes after
> > > > BTF_KIND_FUNC record, using one of the 'unused' bits in btf_type to
> > > > indicate that? or new BTF_KIND_FUNC2 type?
> > > >
> > > > thoughts?
> > >
> > > I'm strongly against this, because (besides the BTF bloat reason) we
> > > need similar mass attachment functionality for kprobe/kretprobe and
> > > that one won't be relying on BTF FUNCs, so I think it's better to
> > > stick to the same mechanism for figuring out the address of the
> > > function.
> >
> > ok
> >
> > >
> > > If RB tree is not feasible, we can do a linear search over unsorted
> > > kallsyms and do binary search over sorted function names (derived from
> > > BTF IDs). That would be O(Nlog(M)), where N is number of ksyms, M is
> > > number of BTF IDs/functions-to-be-attached-to. If we did have an RB
> > > tree for kallsyms (is it hard to support duplicates? why?) it could be
> > > even faster O(Mlog(N)).
> >
> > I had issues with generic kallsyms rbtree in the post some time ago,
> > I'll revisit it to check on details.. but having the tree with just
> > btf id functions might clear that.. I'll check
> 
> That's not what I'm proposing. See above. Please let me know if
> something is not clear before going all in for RB tree implementation
> :)
> 
> 
> But while we are on topic, do you think (with ftrace changes you are
> doing) it would be hard to support multi-attach for
> kprobes/kretprobes? We now have bpf_link interface for attaching
> kprobes, so API can be pretty aligned with fentry/fexit, except
> instead of btf IDs we'd need to pass array of pointers of C strings, I
> suppose.

hum, I think kprobe/kretprobe is made of perf event (kprobe/kretprobe
pmus), then you pass event fd and program fd to bpf link syscall,
and it attaches bpf program to that perf event

so perhaps the user interface would be array of perf events fds and prog fd

also I think you can have just one probe for function, so we will not need
to share kprobes for multiple users like we need for trampolines, so the
attach logic will be simple

jirka

> 
> >
> > thanks,
> > jirka
> >
> > >
> > >
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > >
> >
> 

