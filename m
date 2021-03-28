Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75D434BD70
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhC1RHV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 13:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229538AbhC1RG5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Mar 2021 13:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616951214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAFFIJF5EE+ljst+wWAnw99+NJhhKLg2AX6qjsqxfOc=;
        b=cS7mdOkwk3vzSYT/xHxk81tjzpZaTd0cKZg0tZjXA3Et5hFnepE/hWUYbCLsRFy6HtfUqc
        GW21+kiLVyBdm+MpKbXCY/CDmrEZSVraeptyqIsAR9O3TEH8ODLE8n4tnMiHW0ezyqZwDY
        Qa7qahmy8yNvxVEzwxPmVfA+Q0eFulo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-rkrcNWbSMB6btyEVZLjzfA-1; Sun, 28 Mar 2021 13:06:51 -0400
X-MC-Unique: rkrcNWbSMB6btyEVZLjzfA-1
Received: by mail-wr1-f69.google.com with SMTP id v13so7377321wrs.21
        for <bpf@vger.kernel.org>; Sun, 28 Mar 2021 10:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAFFIJF5EE+ljst+wWAnw99+NJhhKLg2AX6qjsqxfOc=;
        b=lKbbGpdsku9Q52vQMCFpph9ad89SKSvNNbKZbnHD1RrZY8HIKe3moU5U2FajIYWNxh
         2gReuWrCa7DiEzN7ZesHrbCYSAc97F+rZm//Oqdtm5sGgeAIXmd7Y7xOUSIK6b3vtyzh
         H2TM3FwgET2JB30YyLP/P/eX8QtEQhvXyAFYUOkEl+vOTDRcSjsjklYGXbCTMoGuhPkI
         OatINVHT4PDbR52k0jnNZWXKxADDYkJMRx1f6suMX0AHBglVvaXg1bWVX7CfDhfGiGwl
         fiiiyE0q+dpgPhAIu72E+RvkfvXiH0bzhWlzJDcu/zK0A6E/Pvjc6Ew8OyY/FNMWEHK0
         /6JQ==
X-Gm-Message-State: AOAM532BmY95QXy6+s9uiHWKXiBCgp6q2c9tZbFCOUWP/1/1FFEr+SGJ
        2MDVvQiw3lYcH1g7J7g9RRpbSn17MYpPyRRrkj1Usf3lvor2QeMf7nb7+BPhhmuelXoSquUfoON
        CsHB11huZxJn98W6B8YULiUCL3rTy
X-Received: by 2002:a05:600c:acf:: with SMTP id c15mr21729342wmr.124.1616951210144;
        Sun, 28 Mar 2021 10:06:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2EJHLeazCXRH3PS8eXIsqplhnRI1jmBi6fTonX3qqMv7pDtPETErkq7ys8bkIeYy6AMPd0g+BUX7pR8tT7YI=
X-Received: by 2002:a05:600c:acf:: with SMTP id c15mr21729332wmr.124.1616951209991;
 Sun, 28 Mar 2021 10:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122407.211174-1-yauheni.kaliuta@redhat.com> <CAEf4BzY_=Fj4+TetwHatiid=XM7rtjuZwfCA3fe9n7mhEhmwcg@mail.gmail.com>
In-Reply-To: <CAEf4BzY_=Fj4+TetwHatiid=XM7rtjuZwfCA3fe9n7mhEhmwcg@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Sun, 28 Mar 2021 20:06:34 +0300
Message-ID: <CANoWswn7f+Byx=yCZRP+bhL7RjsLZF+puL4OgVudPB9QMPW1nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] bpf/selftests: page size fixes
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii,

On Sun, Mar 28, 2021 at 8:05 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 26, 2021 at 5:24 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > A set of fixes for selftests to make them working on systems with PAGE_SIZE > 4K
> >
> > 2 questions left:
> >
> > - about `nit: if (!ASSERT_OK(err, "setsockopt_attach"))`. I left
> >   CHECK() for now since otherwise it has too many negations. But
> >   should I anyway use ASSERT?
>
> CHECK itself is a negation as much more confusing, IMO. if
> (!ASSERT_OK(err)) is pretty clear, as for me.
>
> >
> > - https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/mmap.c#L41
> >   and below -- it works now as is, but should be switched also to page_size?
>
> replied on another patch, it is possible to set all that at runtime
> with bpf_map__set_max_entries().

For both mmap and ringbuf or only for mmap?

But the question is about the mmap userspace part. In the test for
some reason both hardcoded 4096 and runtime page_size are used. I'm a
bit confused, should I replace that 4096 with page size.

>
>
> Overall, please specify the [PATCH bpf-next] prefix to denote that it
> targets bpf-next.

thanks for the review, I'll prepare v3 then.

>
>
> >
> > --
> > v1->v2:
> >
> > - add missed 'selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton'
> >
> > Yauheni Kaliuta (4):
> >
> >   selftests/bpf: test_progs/sockopt_sk: pass page size from userspace
> >   bpf: selftests: test_progs/sockopt_sk: remove version
> >   selftests/bpf: ringbuf, mmap: bump up page size to 64K
> >
> >  .../selftests/bpf/prog_tests/ringbuf.c        |  9 ++-
> >  .../selftests/bpf/prog_tests/sockopt_sk.c     | 68 ++++++-------------
> >  .../selftests/bpf/progs/map_ptr_kern.c        |  9 ++-
> >  .../testing/selftests/bpf/progs/sockopt_sk.c  | 11 ++-
> >  tools/testing/selftests/bpf/progs/test_mmap.c | 10 ++-
> >  .../selftests/bpf/progs/test_ringbuf.c        |  8 ++-
> >  .../selftests/bpf/progs/test_ringbuf_multi.c  |  7 +-
> >  7 files changed, 61 insertions(+), 61 deletions(-)
> >
> > --
> > 2.29.2
> >
>


-- 
WBR, Yauheni

