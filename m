Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B2D1A4B84
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 23:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJVOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 17:14:48 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35510 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJVOs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Apr 2020 17:14:48 -0400
Received: by mail-pj1-f68.google.com with SMTP id mn19so1183923pjb.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DI5AkjC6zQ25hEM2Imd3gagbyNh7ffmjC9Y/suXyFjc=;
        b=MsKdwWqoVN+8n0nAIAuhat1GJ2PWHaGmupw9MVrcyv0jKP6gjmJI5N3bpUjHVgtYrR
         XAUXr+de1jwMXs4oy/5Cdlf39uiNxrde2CFwmX60mEul8Yz0nU670sPWQlxUyhOK1CTz
         QDzLOqlo5uYtax9JtV+YNtRrGdib6NhmHMn2zzDMxSivaS07Svu+JQk8rr/TAx90EPMt
         2LDcHZkaeZp6/HnYdV+Q+nzPvHfgIWziMDrXW+87nlamMB88tqTXR3hwyStoDkUvu0w7
         En5X6ZvzEy9/VSGTRFYlzHzSvKKnESkEJWQhcIffrM4jWhhiT7jsASwumS6xEj3zs0Y2
         jZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DI5AkjC6zQ25hEM2Imd3gagbyNh7ffmjC9Y/suXyFjc=;
        b=BDrbdLycM5yi8AJw/OQ5BBh5yjbqE2gOBWMK0cxDccJxvUaywKX/aLMAtGwBqr/ga3
         lrBdbhxWmXdXO6J+VG5is45x1sXuGnbsx1D5PmBsg+K5vt4oOAN/s6wxaBlApTAQIV7q
         dIkM7blrOGbMOYGV3EJlJY6eGeumoI3G9FjJWGJrLu0lF/zmPrwupssgjP9aroreBcAr
         GcwoSNKcjIMXWgij2OU9Iw1vs+5x4qp98L6LIxTnOK2gIyDdaSpMwyk+3D9xyyCO4kAF
         6YjimeSoWyowoA4pmM6e2HP8ATbgPt/FddRyS0KcMIdun7dgeWvFNfuTjN9jUNzNXYG9
         Bi3A==
X-Gm-Message-State: AGi0PubJpnWl8nxyyWT0YtRzl+lvIlDYVEoPNx9jgytFKMT41RhvcycI
        qRsEYwkA464rluK+xBj/m0k=
X-Google-Smtp-Source: APiQypLDIuJVHBiGZ93kJQ3KEZiP9U+yLSRKt3bf7x05/FWDAFnqtMQ8B2O9c58LTDUGucFsT/raag==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr6490244plt.288.1586553287432;
        Fri, 10 Apr 2020 14:14:47 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:5315])
        by smtp.gmail.com with ESMTPSA id i8sm2287309pgd.80.2020.04.10.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 14:14:46 -0700 (PDT)
Date:   Fri, 10 Apr 2020 14:14:44 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrey Ignatov <rdna@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix loading cgroup_skb/egress with ret
 in [2, 3]
Message-ID: <20200410211444.opudqya3jvbdbqte@ast-mbp>
References: <cover.1586547735.git.rdna@fb.com>
 <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
 <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 10, 2020 at 01:39:03PM -0700, Andrii Nakryiko wrote:
> On Fri, Apr 10, 2020 at 12:54 PM Andrey Ignatov <rdna@fb.com> wrote:
> >
> > Initially BPF_CGROUP_INET_EGRESS hook didn't require specifying
> > expected_attach_type at loading time, but commit
> >
> >   5cf1e9145630 ("bpf: cgroup inet skb programs can return 0 to 3")
> >
> > changed it so that expected_attach_type must be specified if program can
> > return either 2 or 3 (before it was either 0 or 1) to communicate
> > congestion notification to caller.
> >
> > At the same time loading w/o expected_attach_type is still supported for
> > backward compatibility if program retval is in tnum_range(0, 1).
> >
> > Though libbpf currently supports guessing prog/attach/expected_attach
> > types only for "old" mode (retval in [0; 1]). And if cgroup_skb egress
> > program stars returning e.g. 2 (corresponds to NET_XMIT_CN), then
> > guessing breaks and, e.g. bpftool can't load an object with such a
> > program anymore:
> >
> >   # bpftool prog loadall tools/testing/selftests/bpf/test_skb.o /sys/fs/bpf/test_skb
> >   libbpf: load bpf program failed: Invalid argument
> >   libbpf: -- BEGIN DUMP LOG ---
> >   libbpf:
> >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> >   0: (85) call pc+5
> >
> >    ... skip ...
> >
> >   from 87 to 1: R0_w=invP2 R10=fp0
> >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> >   1: (bc) w1 = w0
> >   2: (b4) w0 = 1
> >   3: (16) if w1 == 0x0 goto pc+1
> >   4: (b4) w0 = 2
> >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> >   5: (95) exit
> >   At program exit the register R0 has value (0x2; 0x0) should have been in (0x0; 0x1)
> >   processed 96 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 2
> >
> >   libbpf: -- END LOG --
> >   libbpf: failed to load program 'cgroup_skb/egress'
> >   libbpf: failed to load object 'tools/testing/selftests/bpf/test_skb.o'
> >   Error: failed to load object file
> >
> > Fix it by introducing another entry in libbpf section_defs that makes the load
> > happens with expected_attach_type: cgroup_skb/egress/expected
> >
> > That name may not be ideal, but I don't have a better option.
> 
> That's a really bad name :) But maybe instead of having another
> section_def, turn existing section def into the one that does specify
> expected_attach_type? Seems like kernels accept expected_attach_type
> for a while now, so it might be ok backwards compatibility-wise?
> Otherwise, we can teach libbpf to retry program load without expected
> attach type for cgroup_skb/egress?
> 
> >
> > Strictly speaking this is not a fix but rather a missing feature, that's
> > why there is no Fixes tag. But it still seems to be a good idea to merge
> > it to stable tree to fix loading programs that use a feature available
> > for almost a year.
> >
> > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ff9174282a8c..c909352f894d 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -6330,6 +6330,8 @@ static const struct bpf_sec_def section_defs[] = {
> >         BPF_PROG_SEC("lwt_seg6local",           BPF_PROG_TYPE_LWT_SEG6LOCAL),
> >         BPF_APROG_SEC("cgroup_skb/ingress",     BPF_PROG_TYPE_CGROUP_SKB,
> >                                                 BPF_CGROUP_INET_INGRESS),
> > +       BPF_EAPROG_SEC("cgroup_skb/egress/expected", BPF_PROG_TYPE_CGROUP_SKB,
> > +                                               BPF_CGROUP_INET_EGRESS),
> >         BPF_APROG_SEC("cgroup_skb/egress",      BPF_PROG_TYPE_CGROUP_SKB,
> >                                                 BPF_CGROUP_INET_EGRESS),

are you saying that when bpf prog has SEC("cgroup_skb/egress",.. libbpf actually
_not_ passing BPF_CGROUP_INET_EGRESS as expected_attach to the kernel?
I think it's a libbpf bug and not something to workaround with retries.
