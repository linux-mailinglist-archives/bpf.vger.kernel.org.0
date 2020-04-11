Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676961A4CBD
	for <lists+bpf@lfdr.de>; Sat, 11 Apr 2020 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDKAJW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 20:09:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45056 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDKAJV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Apr 2020 20:09:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id m67so3810771qke.12
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 17:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ERUvjNEfeU01CuedY/Y7JmaBRbhGBVVXCcDhSke6J8=;
        b=A+7eUfrmjCawr0x343TCCuM3ByyyE6/NBnefiUjN9rGVCiIhmC2nZkYtVtjILRfTI+
         m2n4AG+M6bxLUbJotSlFYZ5VXsIRq3dqPt3Wyx6AUGfkEjXIk2I5GJBs5NFt5yDIQTXY
         s9jg2EVE5of06BhMxptDv+qp84qoD0XFpDET7rFJHXe1lSV8wu6dEbaDMdOxb23tsmhv
         gGzU8hKz2nRkyurkaQlBnKwqiSbX4VOLRnAhtTKyaosm/aXhZdCdesZY50pjc56GNsWO
         gqqg5fnh0N2OoKy/eVKDyWrWtJ7yIBsFDX5MTupd9Vi8XTklQ/oYViQ67/gbfWxUWylE
         2yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ERUvjNEfeU01CuedY/Y7JmaBRbhGBVVXCcDhSke6J8=;
        b=Rh1DzFSDlmo49GvdvVfwghgwYbk1rHxbdw+UeqkNBDXaN5GCO83bKHLIqa3DmsI/lO
         VVGVTqc5CtL9gr1iMmOfsws252cuGKF/D9afjODLyKc1z7BiLfFZzUBeKOZcD20TPHiR
         Qn7zluPvbwg9yavLq4LoT5bTrZC3x3LWEPZr9VEtT41pXDJ/mcnlXeQwF2jzzuH52aLa
         GKfO3cg1iSi0nA5HJTZT6ZT4OrM94vBK6NbbOPTcfOYVUX3231pWwVOVuCCc3/YrVXPU
         scVrZ0cP50huMoCJRvEfeL/kXEBwU+aSQ0RKY4UJmGHe60g10RDJKP/xtoJIVeO5tcNl
         3j9w==
X-Gm-Message-State: AGi0PuaiSwiyik2/Ys1B2ITRC0fYGXKy/pWFewEFS34xS2Xu/5R230dX
        PDQiiZQIAzIXVZuZdgYtVWBF+G5MefdWg+fElgoQwuaHihA=
X-Google-Smtp-Source: APiQypLeZLJzdoC/Oiw1HjkkNP5wKTpq+XXgkKTFTOIWrXW9sIw+oSoSQAgASt+t8KvcytEPSfLIoCfoRm450Y77qvg=
X-Received: by 2002:ae9:e854:: with SMTP id a81mr6509626qkg.36.1586563759088;
 Fri, 10 Apr 2020 17:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586547735.git.rdna@fb.com> <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
 <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com> <20200410225739.GA95636@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200410225739.GA95636@rdna-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Apr 2020 17:09:07 -0700
Message-ID: <CAEf4BzbBiqKNu8DAqYH0+Lyv3_-nZ1PWzs42EbsC96u6zvX=sw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix loading cgroup_skb/egress with ret in
 [2, 3]
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 10, 2020 at 3:57 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> [Fri, 2020-04-10 13:39 -0700]:
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
> > expected_attach_type?
>
> Unfortunately, unless I'm missing something, it'll break loading on
> older kernels.
>
> Specifically before commit 5e43f899b03a ("bpf: Check attach type at prog
> load time") BPF_PROG_LOAD_LAST_FIELD was prog_ifindex what means that on
> kernels before that commit all bytes in bpf_attr have to be zero at
> loading time, otherwise the check in bpf_prog_load:
>
>         if (CHECK_ATTR(BPF_PROG_LOAD))
>                 return -EINVAL;
>
> will fail. If libbpf starts loading with expected_attach_type set on
> those kernels, that load will fail.
>
> That's why I didn't converted existing BPF_APROG_SEC to BPF_EAPROG_SEC.

I understand all that :) Seems like 4.10 through 4.16 will be affected.

On the other hand, for them the easy work-around would be
bpf_program__set_expected_attach_type(prog, BPF_CGROUP_INET_INGRESS),
so not the end of the world... But a new section definition just for
this is the worst option out of three possible ones, IMO.

>
> > Seems like kernels accept expected_attach_type
> > for a while now, so it might be ok backwards compatibility-wise?
>
> Sure, that commit is from 2018, but I guess backward compatibility
> should still be maintained in this case? That's a question to
> maintainers though. If simply changing BPF_APROG_SEC to BPF_EAPROG_SEC
> is an option that works for me.
>
>
> > Otherwise, we can teach libbpf to retry program load without expected
> > attach type for cgroup_skb/egress?
>
> Looks like a lot of work compared to simply adding a new section name
> (or changing existing section if backward compatibility is not a concern
> here).
>
> But that work may work may outweigh inconvenience on user side so no
> strong preferences. If this is what you were going to do anyway, that
> may work as well.

Usability trumps extra code in libbpf :)

>
>
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
> > >         BPF_APROG_COMPAT("cgroup/skb",          BPF_PROG_TYPE_CGROUP_SKB),
> > > --
> > > 2.24.1
> > >
>
> --
> Andrey Ignatov
