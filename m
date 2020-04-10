Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398121A4BAD
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 23:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDJVwz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 17:52:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41043 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgDJVwz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Apr 2020 17:52:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id i3so2583988qtv.8
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfoS1b2uMhndW4KIeiWClYU6d8VyCO2OzxccbPH1MqM=;
        b=StrpmajKx/sYn9mlX8tbc8w19LWVdv3irqVw4VWWkhMZg+A2kuPjJEWMQ4P4050z4a
         v2ylBi2MF3p+lZrnn4NURLxueLOrNIZ30PnxYRzM+83baSRYVWXm844DPR5oJLWdOojA
         Nyz1tfAD3zZOnsiW0oCKQkWxNOn5g1djzqmt7NboRVVnjpe6wnCZQOg3u9EJirOUpslm
         Ndt+gyR3rLwNJMrqPyb7WEtLlO8eA3JbC+BfsWH9rIA6MnoDF5sPcQox0q1gAMlK17yH
         vmQvklE5jD2jhu8f3nQ7bGzO+lYJuyVfbnKSuE9uotR3ZGoErWudOqYoHL/llRNp2dFn
         qXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfoS1b2uMhndW4KIeiWClYU6d8VyCO2OzxccbPH1MqM=;
        b=WBF+brzC3dmkgmzYJ4z9J3SxuSHkjdmcBHnPqKwCy7ko9HLWtnW3nmbBMevV9o9nKK
         pLdLTvb/l3LU0nkv13A9cZkskrs6lxLsg+GjOPCbSxrxiOWlu3jiC8OdlAphH336//l+
         WuYbJplau4HYSY4zR3/GwFd22Ub10XZdlfC46+dxxqrJcnJbxdOkOVPxL2BC4oWp6hLM
         7Mr1WyjXboWMb1XNwlyd3pj+r/c7UjqMyBPHDQ0AvAuLDNgeZVHKIMLYCsM56DnHfhsD
         g2MfCGOrEwMYEdx6K1BJ7wOlMnWNJeg6nhRBJl9GbrqzEejNKBGH8U1jYP32eSKiF2Qd
         c7eQ==
X-Gm-Message-State: AGi0PuZ4rkpOO1fBHuM07jgGzbfKwG9ro5ZAuOKFUs6TqLTv7N3ugiwR
        9cdB8W+8eu+T3eSlBQlWDDkZ+lMp4dmPhAe9XsY=
X-Google-Smtp-Source: APiQypLI24iOauCoF6bBk1O1CotKoJVczRjmYaRITnvzcPqN2cKhBEdiDXg7qhhmwCrPyEBhxg7wCx/HP90S+9KOUJw=
X-Received: by 2002:aed:3169:: with SMTP id 96mr1183481qtg.141.1586555572959;
 Fri, 10 Apr 2020 14:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586547735.git.rdna@fb.com> <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
 <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com> <20200410211444.opudqya3jvbdbqte@ast-mbp>
In-Reply-To: <20200410211444.opudqya3jvbdbqte@ast-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Apr 2020 14:52:42 -0700
Message-ID: <CAEf4Bzab+3-gFPnrmc_2f3NogXvckox=QpGWVZiCNxTGQK9v7A@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix loading cgroup_skb/egress with ret in
 [2, 3]
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrey Ignatov <rdna@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 10, 2020 at 2:14 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 10, 2020 at 01:39:03PM -0700, Andrii Nakryiko wrote:
> > On Fri, Apr 10, 2020 at 12:54 PM Andrey Ignatov <rdna@fb.com> wrote:
> > >
> > > Initially BPF_CGROUP_INET_EGRESS hook didn't require specifying
> > > expected_attach_type at loading time, but commit
> > >
> > >   5cf1e9145630 ("bpf: cgroup inet skb programs can return 0 to 3")
> > >
> > > changed it so that expected_attach_type must be specified if program can
> > > return either 2 or 3 (before it was either 0 or 1) to communicate
> > > congestion notification to caller.
> > >
> > > At the same time loading w/o expected_attach_type is still supported for
> > > backward compatibility if program retval is in tnum_range(0, 1).
> > >
> > > Though libbpf currently supports guessing prog/attach/expected_attach
> > > types only for "old" mode (retval in [0; 1]). And if cgroup_skb egress
> > > program stars returning e.g. 2 (corresponds to NET_XMIT_CN), then
> > > guessing breaks and, e.g. bpftool can't load an object with such a
> > > program anymore:
> > >
> > >   # bpftool prog loadall tools/testing/selftests/bpf/test_skb.o /sys/fs/bpf/test_skb
> > >   libbpf: load bpf program failed: Invalid argument
> > >   libbpf: -- BEGIN DUMP LOG ---
> > >   libbpf:
> > >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> > >   0: (85) call pc+5
> > >
> > >    ... skip ...
> > >
> > >   from 87 to 1: R0_w=invP2 R10=fp0
> > >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> > >   1: (bc) w1 = w0
> > >   2: (b4) w0 = 1
> > >   3: (16) if w1 == 0x0 goto pc+1
> > >   4: (b4) w0 = 2
> > >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> > >   5: (95) exit
> > >   At program exit the register R0 has value (0x2; 0x0) should have been in (0x0; 0x1)
> > >   processed 96 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 2
> > >
> > >   libbpf: -- END LOG --
> > >   libbpf: failed to load program 'cgroup_skb/egress'
> > >   libbpf: failed to load object 'tools/testing/selftests/bpf/test_skb.o'
> > >   Error: failed to load object file
> > >
> > > Fix it by introducing another entry in libbpf section_defs that makes the load
> > > happens with expected_attach_type: cgroup_skb/egress/expected
> > >
> > > That name may not be ideal, but I don't have a better option.
> >
> > That's a really bad name :) But maybe instead of having another
> > section_def, turn existing section def into the one that does specify
> > expected_attach_type? Seems like kernels accept expected_attach_type
> > for a while now, so it might be ok backwards compatibility-wise?
> > Otherwise, we can teach libbpf to retry program load without expected
> > attach type for cgroup_skb/egress?
> >
> > >
> > > Strictly speaking this is not a fix but rather a missing feature, that's
> > > why there is no Fixes tag. But it still seems to be a good idea to merge
> > > it to stable tree to fix loading programs that use a feature available
> > > for almost a year.
> > >
> > > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index ff9174282a8c..c909352f894d 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -6330,6 +6330,8 @@ static const struct bpf_sec_def section_defs[] = {
> > >         BPF_PROG_SEC("lwt_seg6local",           BPF_PROG_TYPE_LWT_SEG6LOCAL),
> > >         BPF_APROG_SEC("cgroup_skb/ingress",     BPF_PROG_TYPE_CGROUP_SKB,
> > >                                                 BPF_CGROUP_INET_INGRESS),
> > > +       BPF_EAPROG_SEC("cgroup_skb/egress/expected", BPF_PROG_TYPE_CGROUP_SKB,
> > > +                                               BPF_CGROUP_INET_EGRESS),
> > >         BPF_APROG_SEC("cgroup_skb/egress",      BPF_PROG_TYPE_CGROUP_SKB,
> > >                                                 BPF_CGROUP_INET_EGRESS),
>
> are you saying that when bpf prog has SEC("cgroup_skb/egress",.. libbpf actually
> _not_ passing BPF_CGROUP_INET_EGRESS as expected_attach to the kernel?

Yes, that seems to be the difference between BPF_EAPROG_SEC and BPF_APROG_SEC.

> I think it's a libbpf bug and not something to workaround with retries.

This predates me, but I assume it's a backwards-compatibility move.
Because older kernels might know about expected_attach_type, but still
allow ingress/egress programs to be attached. I'm fine with dropping
that (I actually had to work around this problem in
bpf_program__attach_cgroup), but if anyone is feeling strongly about
tiny chance of breaking something, we'll have to teach libbpf to retry
load without expected_attach_type, if that one fails (which fails in
its own way, so I'd rather not do it).
