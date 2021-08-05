Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79F3E1A5E
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 19:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhHER3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 13:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237413AbhHER3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 13:29:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 977C361154
        for <bpf@vger.kernel.org>; Thu,  5 Aug 2021 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628184530;
        bh=bDrXNOnKmFB77bwNSKrK4TLiuTn7KP8q3S4dAtpWJ/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NYk/rDc86MCsWO356d7Zw0WIA9DfGMbXWl62EcygylZoloOa0P5NdryBCWEhpB4rR
         dE0hNqBhMYfCJs8AGrLUvvsI8rZRAqb1iWXemxPvCE563dcGleQrDo3EzmJLrB5ffy
         Oy4qxpeT7myJB6CiKdeVM24MgsF2+hweDDSoKRmgsHBs83aOcDJOXTIgaPzF3+oS9h
         I3hGboipy0TQLamOIx4TPRsW3qQ7mm51IRR2/pmfVQn4NWzqNWBW8aHg6kic5S5VfX
         ptAFY+ghT0hKBlGwJWo0w/3xtSKWpyiChiBVIl4VO8vz+vjdGnh6K1G1xDJkft7hoS
         NqlPkjSFcID1g==
Received: by mail-ej1-f41.google.com with SMTP id yk17so10796535ejb.11
        for <bpf@vger.kernel.org>; Thu, 05 Aug 2021 10:28:50 -0700 (PDT)
X-Gm-Message-State: AOAM531P95A1Paj64zWSB2ibTsOzKwuyu/eVkBCn1YgeQ4Pa0GWvU9WK
        7Ppxsd38BlEluiWYAkmTL1zBdxJiV0oK/UR/j3te5g==
X-Google-Smtp-Source: ABdhPJxy+BXKymy3aTEx+egOkXkV7hzYj8alPCmvT+RYbLK9UTa/JOd5o1SrsX/d9WYpXXOeSk2ZxjzccQG/nHEsBqo=
X-Received: by 2002:a17:906:22db:: with SMTP id q27mr6108012eja.185.1628184529072;
 Thu, 05 Aug 2021 10:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210727132532.2473636-1-hengqi.chen@gmail.com>
 <20210727132532.2473636-3-hengqi.chen@gmail.com> <ff963256-ea65-b8ba-05d0-fba3b03843d0@iogearbox.net>
 <CAEf4BzZqvVVTRjoe2h9LyrYKwH=JwbEnzOWzBqnNCVLJfbeuYA@mail.gmail.com> <3d5ff184-da35-2d1a-df1d-f4b274655c5f@gmail.com>
In-Reply-To: <3d5ff184-da35-2d1a-df1d-f4b274655c5f@gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 5 Aug 2021 19:28:38 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5nJMH-BJsEQf96izrNd9KhpALr=QEzProir2uB=iyvBw@mail.gmail.com>
Message-ID: <CACYkzJ5nJMH-BJsEQf96izrNd9KhpALr=QEzProir2uB=iyvBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: expose bpf_d_path helper to vfs_*
 and security_* functions
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yaniv Agman <yanivagman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 5, 2021 at 4:27 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2021/8/5 6:44 AM, Andrii Nakryiko wrote:
> > On Wed, Aug 4, 2021 at 3:35 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>
> >> On 7/27/21 3:25 PM, Hengqi Chen wrote:
> >>> Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
> >>> bpf_d_path helper to extract full file path from these functions' arguments.
> >>> This will help tools like BCC's filetop[1]/filelife to get full file path.
> >>>
> >>> [1] https://github.com/iovisor/bcc/issues/3527
> >>>
> >>> Acked-by: Yonghong Song <yhs@fb.com>
> >>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >>> ---
> >>>   kernel/trace/bpf_trace.c | 60 +++++++++++++++++++++++++++++++++++++---
> >>>   1 file changed, 56 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >>> index c5e0b6a64091..e7b24abcf3bf 100644
> >>> --- a/kernel/trace/bpf_trace.c
> >>> +++ b/kernel/trace/bpf_trace.c
> >>> @@ -849,18 +849,70 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
> >>>
> >>>   BTF_SET_START(btf_allowlist_d_path)
> >>>   #ifdef CONFIG_SECURITY
> >>> +BTF_ID(func, security_bprm_check)
> >>> +BTF_ID(func, security_bprm_committed_creds)
> >>> +BTF_ID(func, security_bprm_committing_creds)
> >>> +BTF_ID(func, security_bprm_creds_for_exec)
> >>> +BTF_ID(func, security_bprm_creds_from_file)
> >>> +BTF_ID(func, security_file_alloc)

You can also look at the set of LSM hooks that are allow listed for bpf_d_path:

https://elixir.bootlin.com/linux/latest/source/kernel/bpf/bpf_lsm.c

you could refactor this set so that it also adds the corresponding security_*
functions for tracing programs.

> >>
> >> Did you actually try these out, e.g. attaching BPF progs invoking bpf_d_path() to all
> >> these, then generate some workload like kernel build for testing?
> >>
> >> I presume not, since something like security_file_alloc() would crash the kernel. Right
> >> before it's called in __alloc_file() we fetch a struct file from kmemcache, and only
> >> populate f->f_cred there. Most LSMs, for example, only populate their secblob through the
> >> callback. If you call bpf_d_path(&file->f_path, ...) with it, you'll crash in d_path()
> >> when path->dentry->d_op is checked.. given f->f_path is all zeroed structure at that
> >> point.
> >>
> >> Please do your due diligence and invest each of them manually, maybe the best way is
> >> to hack up small selftests for each enabled function that our CI can test run? Bit of a
> >> one-time effort, but at least it ensures that those additions are sane & checked.
> >
> > I think it's actually a pretty fun exercise and a good selftest to
> > have. We can have a selftest which will attach a simple BPF program
> > just to grab a contents of btf_allowlist_d_path (with typeless ksyms,
> > for instance). Then for each BTF ID in there, as a subtest, attach
> > another BPF object with fentry BPF program doing something with
> > d_path.

+1 Good idea!

> >
> > Hengqi, you'd need to have few variants for each possible position of
> > file or path struct (e.g., file as first arg; as second arg; etc, same
> > for hooks working with path directly), but I don't think that's going
> > to be a lot of them.
> >
> > So as Daniel said, a bit of a work, but we'll have a much better
> > confidence that we are not accidentally opening a big kernel crashing
> > loophole.
> >
>
> Thanks for the review and suggestions.
>

[...]

> >>
