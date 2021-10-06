Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4EF4247AE
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbhJFUI3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 16:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229922AbhJFUI3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 16:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633550796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2ttL2wsHNTzIDiRf0sFY/aSVawhGAljPZTNvBv2akE=;
        b=Pvm0EcOdlqQzvlCWh68S2hY0rWpNZ5wDFGygo9wo31eb7zmJ0u8sbAfF9T221Ku08MyVsK
        So4sfn6vIEHaPGlfoGQyX1ZKUHkmiCtG7Qg6G3dPYO5rvwuHm3Qv+EaomhSaa4enR6vTMA
        +wJRKAwcNHk11LUuXA+FBt0+PN+VgKQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-EBw6ZYFDOeeipZNYPyM8Mw-1; Wed, 06 Oct 2021 16:06:35 -0400
X-MC-Unique: EBw6ZYFDOeeipZNYPyM8Mw-1
Received: by mail-wr1-f70.google.com with SMTP id a10-20020a5d508a000000b00160723ce588so2905133wrt.23
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 13:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H2ttL2wsHNTzIDiRf0sFY/aSVawhGAljPZTNvBv2akE=;
        b=eYIpmt7tehz41h3t2PvdKy6GtGd9fqKxSkxpgL0SQHiLyImZ1sG0kAenPtFlY0FcpT
         fqGRYx0ozxVWkjg3N4hPkfySNkCot2TE1EpG6G3pgtKDiCuEdffgcgjrrSs8dmHwDrlv
         AFiVyPLHxmUtgGk+jUQPKI5xpyN9x/hqF5wFQgCBPT4opRpYuEPgAZeqoMs4/wcZQQtY
         RQJ4xNXHardF0JBWcTDklF4X8cbvUhzruiaeUFgW21sCJPrIbF5LojN4lRl0Lqui0xtc
         3J5DUfNg5oPvWw1f/EolwckX35PRd8BGSwIhz/OO09xpeFUjyy0rX+ze3l4vpA5HYPkP
         NiPw==
X-Gm-Message-State: AOAM5326C+I+CbLcV7ubTDOmf5DW1mPWOWeu9In9POoAySc4TOu0EqGG
        qK6gPO/s7SIJ9ugMgS4hEMdZIKz4/kGVxtAf6Ke11f2nPVWoUWkQf8CogQ0MixCFd4ofOP0zCqY
        wha6s+lrsbxtL
X-Received: by 2002:adf:aa88:: with SMTP id h8mr169101wrc.112.1633550793889;
        Wed, 06 Oct 2021 13:06:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaBzAX1XEF3eNoh5fxPitke7eOI5RekMSabjqvBN0KP/uEOkdKstjWIlWa60PpD7G9dqx+rA==
X-Received: by 2002:adf:aa88:: with SMTP id h8mr169070wrc.112.1633550793655;
        Wed, 06 Oct 2021 13:06:33 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id o8sm6848515wme.38.2021.10.06.13.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:06:33 -0700 (PDT)
Date:   Wed, 6 Oct 2021 22:06:31 +0200
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
Message-ID: <YV4Bx7705mgWzhTd@krava>
References: <YV1hRboJopUBLm3H@krava>
 <CAEf4BzZPH6WQTYaUTpWBw1gW=cNUtPYPnN8OySgXtbQLzZLhEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZPH6WQTYaUTpWBw1gW=cNUtPYPnN8OySgXtbQLzZLhEQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 06, 2021 at 09:17:39AM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 6, 2021 at 1:42 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > hi,
> > I'm hitting performance issue and soft lock ups with the new version
> > of the patchset and the reason seems to be kallsyms lookup that we
> > need to do for each btf id we want to attach
> >
> > I tried to change kallsyms_lookup_name linear search into rbtree search,
> > but it has its own pitfalls like duplicate function names and it still
> > seems not to be fast enough when you want to attach like 30k functions
> 
> How not fast enough is it exactly? How long does it take?

30k functions takes 75 seconds for me, it's loop calling bpf_check_attach_target

getting soft lock up messages:

krava33 login: [  168.896671] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [bpftrace:1087]


> 
> >
> > so I wonder we could 'fix this' by storing function address in BTF,
> > which would cut kallsyms lookup completely, because it'd be done in
> > compile time
> >
> > my first thought was to add extra BTF section for that, after discussion
> > with Arnaldo perhaps we could be able to store extra 8 bytes after
> > BTF_KIND_FUNC record, using one of the 'unused' bits in btf_type to
> > indicate that? or new BTF_KIND_FUNC2 type?
> >
> > thoughts?
> 
> I'm strongly against this, because (besides the BTF bloat reason) we
> need similar mass attachment functionality for kprobe/kretprobe and
> that one won't be relying on BTF FUNCs, so I think it's better to
> stick to the same mechanism for figuring out the address of the
> function.

ok

> 
> If RB tree is not feasible, we can do a linear search over unsorted
> kallsyms and do binary search over sorted function names (derived from
> BTF IDs). That would be O(Nlog(M)), where N is number of ksyms, M is
> number of BTF IDs/functions-to-be-attached-to. If we did have an RB
> tree for kallsyms (is it hard to support duplicates? why?) it could be
> even faster O(Mlog(N)).

I had issues with generic kallsyms rbtree in the post some time ago,
I'll revisit it to check on details.. but having the tree with just
btf id functions might clear that.. I'll check

thanks,
jirka

> 
> 
> >
> > thanks,
> > jirka
> >
> 

