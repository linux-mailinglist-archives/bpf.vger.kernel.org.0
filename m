Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD481A5CFD
	for <lists+bpf@lfdr.de>; Sun, 12 Apr 2020 08:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDLGB2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Apr 2020 02:01:28 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44320 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgDLGB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Apr 2020 02:01:28 -0400
Received: by mail-qv1-f67.google.com with SMTP id ef12so2940713qvb.11
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2020 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ElVlbFmgfhVEHql18RVH5dSl7Kwn+fY01DrcN9XBCDc=;
        b=uLRb5a2IYZ6yViOz9TH4ZH4doIuEPJwmDCCV3TKfFgRQxEQMxCAF0pQv1fVLK81LlY
         AcRud3KASFAOFsz5OkgdhB/SQtBQmFlY8MlWKnFTCIOf7hBnLjfm67Iq7p4LV9lGkyu7
         Ul+fjexQALcl4HBgdGi3N3kNQmTj9Rg/Up5ZR1+eRt2rWfdIluCKnI8+t8z3DlwzgX1e
         dP++J+Lh7tS2X7mfldRdTL10oPxVvPv/cx8Xc1h+bR4WbmLuFHUg5s9akitLZu/odS36
         cJCL2PTyvFk60FpMI8w8iNqJh347rH3wFhC8Q7svFxTrJb/qb+RaBzSXjyBDgcwGCCdh
         MPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElVlbFmgfhVEHql18RVH5dSl7Kwn+fY01DrcN9XBCDc=;
        b=OPIzMLekbxPluLCLCZExoPa/YHHQ1MFtucFUP53FgJtGTij7gOERcVekgLl6LMbYVO
         obIhsOEhjIuODvhO2d45HqcUv3odAFLpaW8CwqPpTKr6JHZhCZ5PfSTKj2ChtjF7gs5N
         BEEcsd7ecZwjcAaSLN63uon7G0amPGXfrmBwGW9cUWrQfO7sJImEzHgsfC9Guo5ywqxC
         xoVqpGkr1Mjpxx+zRSSz/Roa5Ipokhpn5SQyw6SiiQwFsfujFnoUJN9ahNqWHX9O+wg7
         +dg4DoW3pYqLfuWfTPOd7YHORVg4UkD0g6kDn1F3xIuAB5KABB4ERUyz1IrCMFbZf/EC
         yLNw==
X-Gm-Message-State: AGi0PuaR4WmwMZIWnUB0b/HW/Stv5vx6BO3MuzhIdIE1+rzCi8TCxGGx
        kmXoinZPB5GKV0TAzN7EjreAzd4F6X71vRjHvWxUwGA9ZzY=
X-Google-Smtp-Source: APiQypLamllIGLIl0/II61izvI/5PL7zEVulYIuqzLrRz/yTPSOvdwOHOVfKWvNjnGLMy1T49Hz+XoCx6U8ks7Jx7Xs=
X-Received: by 2002:ad4:568b:: with SMTP id bc11mr11480809qvb.228.1586671287746;
 Sat, 11 Apr 2020 23:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586547735.git.rdna@fb.com> <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
 <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
 <20200410225739.GA95636@rdna-mbp.dhcp.thefacebook.com> <CAEf4BzbBiqKNu8DAqYH0+Lyv3_-nZ1PWzs42EbsC96u6zvX=sw@mail.gmail.com>
In-Reply-To: <CAEf4BzbBiqKNu8DAqYH0+Lyv3_-nZ1PWzs42EbsC96u6zvX=sw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 11 Apr 2020 23:01:16 -0700
Message-ID: <CAEf4BzawkZ_aekiFUmkaskzCqfZJmaZ5Oww97L4_ZZhku7A1xw@mail.gmail.com>
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

On Fri, Apr 10, 2020 at 5:09 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 10, 2020 at 3:57 PM Andrey Ignatov <rdna@fb.com> wrote:
> >
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> [Fri, 2020-04-10 13:39 -0700]:
> > > On Fri, Apr 10, 2020 at 12:54 PM Andrey Ignatov <rdna@fb.com> wrote:
> > > >
> > > > Initially BPF_CGROUP_INET_EGRESS hook didn't require specifying
> > > > expected_attach_type at loading time, but commit
> > > >
> > > >   5cf1e9145630 ("bpf: cgroup inet skb programs can return 0 to 3")
> > > >
> > > > changed it so that expected_attach_type must be specified if program can
> > > > return either 2 or 3 (before it was either 0 or 1) to communicate
> > > > congestion notification to caller.
> > > >
> > > > At the same time loading w/o expected_attach_type is still supported for
> > > > backward compatibility if program retval is in tnum_range(0, 1).
> > > >
> > > > Though libbpf currently supports guessing prog/attach/expected_attach
> > > > types only for "old" mode (retval in [0; 1]). And if cgroup_skb egress
> > > > program stars returning e.g. 2 (corresponds to NET_XMIT_CN), then
> > > > guessing breaks and, e.g. bpftool can't load an object with such a
> > > > program anymore:
> > > >
> > > >   # bpftool prog loadall tools/testing/selftests/bpf/test_skb.o /sys/fs/bpf/test_skb
> > > >   libbpf: load bpf program failed: Invalid argument
> > > >   libbpf: -- BEGIN DUMP LOG ---
> > > >   libbpf:
> > > >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> > > >   0: (85) call pc+5
> > > >
> > > >    ... skip ...
> > > >
> > > >   from 87 to 1: R0_w=invP2 R10=fp0
> > > >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> > > >   1: (bc) w1 = w0
> > > >   2: (b4) w0 = 1
> > > >   3: (16) if w1 == 0x0 goto pc+1
> > > >   4: (b4) w0 = 2
> > > >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> > > >   5: (95) exit
> > > >   At program exit the register R0 has value (0x2; 0x0) should have been in (0x0; 0x1)
> > > >   processed 96 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 2
> > > >
> > > >   libbpf: -- END LOG --
> > > >   libbpf: failed to load program 'cgroup_skb/egress'
> > > >   libbpf: failed to load object 'tools/testing/selftests/bpf/test_skb.o'
> > > >   Error: failed to load object file
> > > >
> > > > Fix it by introducing another entry in libbpf section_defs that makes the load
> > > > happens with expected_attach_type: cgroup_skb/egress/expected
> > > >
> > > > That name may not be ideal, but I don't have a better option.
> > >
> > > That's a really bad name :) But maybe instead of having another
> > > section_def, turn existing section def into the one that does specify
> > > expected_attach_type?
> >
> > Unfortunately, unless I'm missing something, it'll break loading on
> > older kernels.
> >
> > Specifically before commit 5e43f899b03a ("bpf: Check attach type at prog
> > load time") BPF_PROG_LOAD_LAST_FIELD was prog_ifindex what means that on
> > kernels before that commit all bytes in bpf_attr have to be zero at
> > loading time, otherwise the check in bpf_prog_load:
> >
> >         if (CHECK_ATTR(BPF_PROG_LOAD))
> >                 return -EINVAL;
> >
> > will fail. If libbpf starts loading with expected_attach_type set on
> > those kernels, that load will fail.
> >
> > That's why I didn't converted existing BPF_APROG_SEC to BPF_EAPROG_SEC.
>
> I understand all that :) Seems like 4.10 through 4.16 will be affected.
>
> On the other hand, for them the easy work-around would be
> bpf_program__set_expected_attach_type(prog, BPF_CGROUP_INET_INGRESS),
> so not the end of the world... But a new section definition just for
> this is the worst option out of three possible ones, IMO.
>
> >
> > > Seems like kernels accept expected_attach_type
> > > for a while now, so it might be ok backwards compatibility-wise?
> >
> > Sure, that commit is from 2018, but I guess backward compatibility
> > should still be maintained in this case? That's a question to
> > maintainers though. If simply changing BPF_APROG_SEC to BPF_EAPROG_SEC
> > is an option that works for me.
> >
> >
> > > Otherwise, we can teach libbpf to retry program load without expected
> > > attach type for cgroup_skb/egress?
> >
> > Looks like a lot of work compared to simply adding a new section name
> > (or changing existing section if backward compatibility is not a concern
> > here).
> >
> > But that work may work may outweigh inconvenience on user side so no
> > strong preferences. If this is what you were going to do anyway, that
> > may work as well.
>
> Usability trumps extra code in libbpf :)

[0] should fix this issue without requiring unnecessary new section
definitions. Please take a look and let me know if that won't work for
some reason.

  [0] https://patchwork.ozlabs.org/patch/1269400/


>
> >
> >
> > > > Strictly speaking this is not a fix but rather a missing feature, that's
> > > > why there is no Fixes tag. But it still seems to be a good idea to merge
> > > > it to stable tree to fix loading programs that use a feature available
> > > > for almost a year.
> > > >
> > > > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index ff9174282a8c..c909352f894d 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -6330,6 +6330,8 @@ static const struct bpf_sec_def section_defs[] = {
> > > >         BPF_PROG_SEC("lwt_seg6local",           BPF_PROG_TYPE_LWT_SEG6LOCAL),
> > > >         BPF_APROG_SEC("cgroup_skb/ingress",     BPF_PROG_TYPE_CGROUP_SKB,
> > > >                                                 BPF_CGROUP_INET_INGRESS),
> > > > +       BPF_EAPROG_SEC("cgroup_skb/egress/expected", BPF_PROG_TYPE_CGROUP_SKB,
> > > > +                                               BPF_CGROUP_INET_EGRESS),
> > > >         BPF_APROG_SEC("cgroup_skb/egress",      BPF_PROG_TYPE_CGROUP_SKB,
> > > >                                                 BPF_CGROUP_INET_EGRESS),
> > > >         BPF_APROG_COMPAT("cgroup/skb",          BPF_PROG_TYPE_CGROUP_SKB),
> > > > --
> > > > 2.24.1
> > > >
> >
> > --
> > Andrey Ignatov
