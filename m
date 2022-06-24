Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8C55A3E7
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiFXVtN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiFXVtM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:49:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC887B56
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:49:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u15so7229867ejc.10
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qqx0RMBZSdlQBKpW/t8crlFDF62ahALd4/gcP9HgZMw=;
        b=cyyrujMJpvm6EyicEIIMi4XQtqQhygRTvtlYrucZlXjMON2rlypIaGOmxaNREqDuIF
         zhjhiF+YUAJMHxPoB5eO4JpDyXzYg7lI1rha5skAxYE/AsveibIkzIcT2lcmPodLkO6S
         UwSiLDD7TjHXXVaDEVwjl2nxax4rOiOJp0IdoSWmp4cP2+LAXLVWc/UCQDdDv2UoEQ3E
         AACZoKmNSFyplob0kXeDzwLpoLuYW9m7q9PxJ1ZGPdFZJ43RMVPriNYORPR+XG9GDH5f
         pB3Oo+k/cAmDSzjEq3aV45AkANeQTSvPBZT844i3EYAteUKCb917k78StpsIZv31yAzk
         S9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qqx0RMBZSdlQBKpW/t8crlFDF62ahALd4/gcP9HgZMw=;
        b=kouve7jUeeSfqwulX/yebIkFrJPUwvqdt/cgOjN2IgFuFPINSg5IjMeMgkkW7ucDus
         f4P5qllsulYLGoiix/c/xPxnZn60z4gyPrZDLiQxfoFclHRQPvgUaQtKgKzWkuO9raMn
         q4EmgJTJDHtlxUbSGpzzwRufMu3T6fJW+EZc3k/ppUFE4SDF0w5qtV8IoU+pC6shlZI5
         MYSC2vMdGICk/qD0LKg1Fhv+S2DgApm5T0E5dMpba8m55JgEXidy+OUJjPAuQa5io+m6
         bhZv0q77FDbCxMEj4SGX7mpv1TEj3qViOy/wMyaGNZqtGYsVJDlR9S8+W86Ct5QXM5fW
         48bg==
X-Gm-Message-State: AJIora/f35REBwbqmn+dH0w16cfW9asf0+XaofffXPO/16+QefBVCXnr
        m1UxmPXgNZZrM7g/Jb/eT7iesdaj0mGUtcNo8ZM=
X-Google-Smtp-Source: AGRyM1tq8LoJdR2U+bHoZuov2eYQegYp1XOgBSxYKFu2lT+dUooKvbZsuXnWT6bNaZ/cl0cz2wFxVycmASQKo3OJoyM=
X-Received: by 2002:a17:906:6a16:b0:725:279b:3f1a with SMTP id
 qw22-20020a1709066a1600b00725279b3f1amr1066346ejc.115.1656107349469; Fri, 24
 Jun 2022 14:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <1655982614-13571-1-git-send-email-alan.maguire@oracle.com>
 <CAEf4BzbbME=oZbp26=OMVpMSfrH-6Bp38ELcY6oNYSCAsnobQw@mail.gmail.com> <5876210d-1541-2248-6e2a-43bac281a741@oracle.com>
In-Reply-To: <5876210d-1541-2248-6e2a-43bac281a741@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 14:48:57 -0700
Message-ID: <CAEf4BzZBS6VMg9PE3GfbLwLjhRmFivrLWoWcdLz3jzQR5xAy-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: support building selftests when CONFIG_NF_CONNTRACK=m
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 2:46 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 23/06/2022 18:56, Andrii Nakryiko wrote:
> > On Thu, Jun 23, 2022 at 4:10 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>
> >> when CONFIG_NF_CONNTRACK=m, vmlinux BTF does not contain
> >> BPF_F_CURRENT_NETNS or bpf_ct_opts; they are both found in nf_conntrack
> >> BTF; for example:
> >>
> >> bpftool btf dump file /sys/kernel/btf/nf_conntrack|grep ct_opts
> >> [114754] STRUCT 'bpf_ct_opts' size=12 vlen=5
> >>
> >> This causes compilation errors as follows:
> >>
> >>   CLNG-BPF [test_maps] xdp_synproxy_kern.o
> >> progs/xdp_synproxy_kern.c:83:14: error: declaration of 'struct bpf_ct_opts' will not be visible outside of this function [-Werror,-Wvisibility]
> >>                                          struct bpf_ct_opts *opts,
> >>                                                 ^
> >> progs/xdp_synproxy_kern.c:89:14: error: declaration of 'struct bpf_ct_opts' will not be visible outside of this function [-Werror,-Wvisibility]
> >>                                          struct bpf_ct_opts *opts,
> >>                                                 ^
> >> progs/xdp_synproxy_kern.c:397:15: error: use of undeclared identifier 'BPF_F_CURRENT_NETNS'; did you mean 'BPF_F_CURRENT_CPU'?
> >>                 .netns_id = BPF_F_CURRENT_NETNS,
> >>                             ^~~~~~~~~~~~~~~~~~~
> >>                             BPF_F_CURRENT_CPU
> >> tools/testing/selftests/bpf/tools/include/vmlinux.h:43115:2: note: 'BPF_F_CURRENT_CPU' declared here
> >>         BPF_F_CURRENT_CPU = 4294967295,
> >>
> >> While tools/testing/selftests/bpf/config does specify
> >> CONFIG_NF_CONNTRACK=y, it would be good to use this case to show
> >> how we can generate a module header file via split BTF.
> >>
> >> In the selftests Makefile, we define NF_CONNTRACK BTF via VMLINUX_BTF
> >> (thus gaining the path determination logic it uses).  If the nf_conntrack
> >> BTF file exists (which means it is built as a module), we run
> >> "bpftool btf dump" to generate module BTF, and if not we simply copy
> >> vmlinux.h to nf_conntrack.h; this allows us to avoid having to pass
> >> a #define or deal with CONFIG variables in the program.
> >>
> >> With these changes the test builds and passes:
> >>
> >> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >
> > Why not just define expected types locally (doesn't have to be a full
> > definition)? Adding extra rule and generating header for each
> > potential module seems like a huge overkill.
> >
>
> True. I also forgot that if we use vmlinux in the kernel tree as the
> source for vmlinux BTF, this approach won't work since it assumes it
> will find nf_conntrack in the same directory. I'll figure out a simpler
> approach. Thanks for taking a look!

Just define local minimal local definitions of relevant types with
___local suffix, e.g.:

struct nf_conn___local {
    long unsigned int status;
    /* and whatever else we are using */
};

Keep in mind that with CO-RE triple underscore suffix is ignored,
which can be used to avoid type conflicts

>
> Alan
