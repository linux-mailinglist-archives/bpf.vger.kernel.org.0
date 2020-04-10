Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0371A4B38
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 22:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJUjR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 16:39:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44823 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJUjQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Apr 2020 16:39:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id w24so2419117qts.11
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRpjFZPOBc6KuAJIYD1VHcTVqEQxUtyQoTLidiorb2w=;
        b=UYsf00eXkVhQi931nHiotVQsLonNty1MkvjGrvLYpBC3k07WhT2uYFyx94q/ODJ64X
         /0SIvTreN93ehnoLKCh2EtYcUdQa8vzzKc1h20a7wygEHck/p3OvNh04YGHcXryrcIGq
         yhGAn0iOtq7Fy4k73zD0zfsbqVOTZAyFyisEroCmNxEOhIRmuzZHcHllshYMQLrpeFNt
         y7XRtXNDLWV8PCPqjW+euSlh0KZioKQiADmFaiFdT1Ykus1H+jvxHzy7lav1ztih1UOs
         0lsMu/xqreEq67NE0zhIoKcdc1cONvnrItUjkOuRBcPLRENzPV+yuTUWg8lTAb8Awq8M
         whlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRpjFZPOBc6KuAJIYD1VHcTVqEQxUtyQoTLidiorb2w=;
        b=Y7qiZZRMlHEJa6XWlccSygAZzliLyNOx7PUbFuT28KA340IzI5tY6pbqOnew6QeAmy
         fexQt4l0Q9a+8tz+/JCVICsNSrgC7D2Fmx0P+/Sh4aOVJkrQPWIloYmAuU2CqoEs26g8
         653Qke3knnFTFOPk4vKtfbv53a65KwA1GktHHIrDSMDNa04SiND+EJp2VjS6jvnO45JX
         A5xJhajtzmQYW3qSrExLnjy0Ekwb4BIolgStwmaQ96gB6YpnnkOsI/hhEbuogidhCpBU
         zMe+PKLdCkPbGyyfQ77L+Uoic1Ah0UQ77j/78eEXdbisFto3okf38CSlPD2wsjAaHF1/
         bM+w==
X-Gm-Message-State: AGi0PuYmL7bpblk7o+UddSavOypMeNbEAazbglPepsoW0HbuticEc7bh
        avJImQebhO7FcE2gjoiIYDJD420VeQwjJYZp9to=
X-Google-Smtp-Source: APiQypItl/3152xL3Z/qVYCu88w269EYUS8UfRNFFHvwdZ5F9yHP0zTIG4MqcsfjFNHunuR7hIpjIMWyz/gYiz1Ono8=
X-Received: by 2002:aed:3169:: with SMTP id 96mr960335qtg.141.1586551154619;
 Fri, 10 Apr 2020 13:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586547735.git.rdna@fb.com> <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
In-Reply-To: <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Apr 2020 13:39:03 -0700
Message-ID: <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
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

On Fri, Apr 10, 2020 at 12:54 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Initially BPF_CGROUP_INET_EGRESS hook didn't require specifying
> expected_attach_type at loading time, but commit
>
>   5cf1e9145630 ("bpf: cgroup inet skb programs can return 0 to 3")
>
> changed it so that expected_attach_type must be specified if program can
> return either 2 or 3 (before it was either 0 or 1) to communicate
> congestion notification to caller.
>
> At the same time loading w/o expected_attach_type is still supported for
> backward compatibility if program retval is in tnum_range(0, 1).
>
> Though libbpf currently supports guessing prog/attach/expected_attach
> types only for "old" mode (retval in [0; 1]). And if cgroup_skb egress
> program stars returning e.g. 2 (corresponds to NET_XMIT_CN), then
> guessing breaks and, e.g. bpftool can't load an object with such a
> program anymore:
>
>   # bpftool prog loadall tools/testing/selftests/bpf/test_skb.o /sys/fs/bpf/test_skb
>   libbpf: load bpf program failed: Invalid argument
>   libbpf: -- BEGIN DUMP LOG ---
>   libbpf:
>   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
>   0: (85) call pc+5
>
>    ... skip ...
>
>   from 87 to 1: R0_w=invP2 R10=fp0
>   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
>   1: (bc) w1 = w0
>   2: (b4) w0 = 1
>   3: (16) if w1 == 0x0 goto pc+1
>   4: (b4) w0 = 2
>   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
>   5: (95) exit
>   At program exit the register R0 has value (0x2; 0x0) should have been in (0x0; 0x1)
>   processed 96 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 2
>
>   libbpf: -- END LOG --
>   libbpf: failed to load program 'cgroup_skb/egress'
>   libbpf: failed to load object 'tools/testing/selftests/bpf/test_skb.o'
>   Error: failed to load object file
>
> Fix it by introducing another entry in libbpf section_defs that makes the load
> happens with expected_attach_type: cgroup_skb/egress/expected
>
> That name may not be ideal, but I don't have a better option.

That's a really bad name :) But maybe instead of having another
section_def, turn existing section def into the one that does specify
expected_attach_type? Seems like kernels accept expected_attach_type
for a while now, so it might be ok backwards compatibility-wise?
Otherwise, we can teach libbpf to retry program load without expected
attach type for cgroup_skb/egress?

>
> Strictly speaking this is not a fix but rather a missing feature, that's
> why there is no Fixes tag. But it still seems to be a good idea to merge
> it to stable tree to fix loading programs that use a feature available
> for almost a year.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ff9174282a8c..c909352f894d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6330,6 +6330,8 @@ static const struct bpf_sec_def section_defs[] = {
>         BPF_PROG_SEC("lwt_seg6local",           BPF_PROG_TYPE_LWT_SEG6LOCAL),
>         BPF_APROG_SEC("cgroup_skb/ingress",     BPF_PROG_TYPE_CGROUP_SKB,
>                                                 BPF_CGROUP_INET_INGRESS),
> +       BPF_EAPROG_SEC("cgroup_skb/egress/expected", BPF_PROG_TYPE_CGROUP_SKB,
> +                                               BPF_CGROUP_INET_EGRESS),
>         BPF_APROG_SEC("cgroup_skb/egress",      BPF_PROG_TYPE_CGROUP_SKB,
>                                                 BPF_CGROUP_INET_EGRESS),
>         BPF_APROG_COMPAT("cgroup/skb",          BPF_PROG_TYPE_CGROUP_SKB),
> --
> 2.24.1
>
