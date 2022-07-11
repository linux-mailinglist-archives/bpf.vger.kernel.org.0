Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94A257083A
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGKQXs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 12:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiGKQXq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 12:23:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1806E1260C
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 09:23:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id os14so9713705ejb.4
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GgkQVIq8WClTJPqKg5n8VWbE8bUdwXpugjY1ZREZ7aE=;
        b=Fdq8hfc086BKGBh1RlPfs6tk2y/8DsW0+CfcD4fIxZ4ZmVM6cpT06cVa7H7xwC+B5u
         vLw3RDWpufOOyXIcoOESF1uehDK4T+LucoclOY7SA7dkzyc9wsiM+UtiYplOV0tWu5pD
         8oRvCLNed0P6JwvTruOQBpdRjQCzrLvRIuEn0hPCvDuXKRaqjR8sqkQv3xUOPS0l+GFT
         rTs2IQWDpNyZN9nerhWUQOVRys6UFhnD8jPSQlbldbEfHYGHYOZ+nhpE9yy74N8CJNUX
         H3st74qbUvHcJuD/Ar/RGCzU1AvqJKUK4E905UBtIwQQvWGnsba82IAgIVTaqj9w2zcD
         zGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GgkQVIq8WClTJPqKg5n8VWbE8bUdwXpugjY1ZREZ7aE=;
        b=PBuZcVEXzGIqLYXQH0AMMvtZKVhUoDuAbTHv3XR06YsmeC1nV044QvGNumpRCRjySs
         /0Q28LDs/Qoz8I6SiSnIA9uXYkxxQ6DN9J7Sq+VVX4ltoWWsDlfj/G7+iARwpvdMhhlw
         ACqMhDhXS/5gBM/2JzIZUGLA80lFwLrjFDkoMzeNSpU8ZJg6sY4jT4Gtx8ZmchfRaXMg
         /JpcXHJjGux5jydxBtPghlrSidnJqDeQkpbdWVYyUV8ebXEtKXw55C6fFX6h0BTUSc7w
         2isWdlGLgCjWj0VcUiNMXOsqajM/VHR11EzvJ5mzrqhA2EvGsu9hgQn4sCSmq6fopdom
         8knQ==
X-Gm-Message-State: AJIora+2/B824rG9ajFWUpswgCHkQJDFxV+rklPmVWAuFNaB3VR4ohdI
        enKhiXDYAeJD4lhJSZGuMrrMyKUh4kF6YLas5NgR0AkeDtg=
X-Google-Smtp-Source: AGRyM1sTFI5u07T2X/p4/6oP/K5e7LAWTPGfW877FefSFwr/d3bpck2UsEQdDWklYInHdOBBedupYFdcg1rD+JVoNqk=
X-Received: by 2002:a17:906:5a6c:b0:72b:561a:3458 with SMTP id
 my44-20020a1709065a6c00b0072b561a3458mr5677280ejc.114.1657556623611; Mon, 11
 Jul 2022 09:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <CAMy7=ZWo1uvN04756dbi6c8HdOO5GajYi81EMqAQ3LWney3DoA@mail.gmail.com>
 <CAEf4Bza97xALx4u6EiiQZ0gXQ90rQfEmbY7z0H5yC6AB=Q-91g@mail.gmail.com>
In-Reply-To: <CAEf4Bza97xALx4u6EiiQZ0gXQ90rQfEmbY7z0H5yC6AB=Q-91g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Jul 2022 09:23:32 -0700
Message-ID: <CAEf4Bzb2TeKJ4nSLRWpx2QrsWyXUvccWNgSxfGXpyaLxdJTEfQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/3] libbpf: add better syscall kprobing support
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 7, 2022 at 1:56 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 1:28 AM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=94=
=D7=B3, 7 =D7=91=D7=99=D7=95=D7=9C=D7=99 2022 =D7=91-3:48 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > <=E2=80=AAandrii@kernel.org=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > This RFC patch set is to gather feedback about new
> > > SEC("ksyscall") and SEC("kretsyscall") section definitions meant to s=
implify
> > > life of BPF users that want to trace Linux syscalls without having to=
 know or
> > > care about things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER and related ar=
ch-specific
> > > vs arch-agnostic __<arch>_sys_xxx vs __se_sys_xxx function names, cal=
ling
> > > convention woes ("nested" pt_regs), etc. All this is quite annoying t=
o
> > > remember and care about as BPF user, especially if the goal is to wri=
te
> > > achitecture- and kernel version-agnostic BPF code (e.g., things like
> > > libbpf-tools, etc).
> > >
> > > By using SEC("ksyscall/xxx")/SEC("kretsyscall/xxx") user clearly comm=
unicates
> > > the desire to kprobe/kretprobe kernel function that corresponds to th=
e
> > > specified syscall. Libbpf will take care of all the details of determ=
ining
> > > correct function name and calling conventions.
> > >
> > > This patch set also improves BPF_KPROBE_SYSCALL (and renames it to
> > > BPF_KSYSCALL to match SEC("ksyscall")) macro to take into account
> > > CONFIG_ARCH_HAS_SYSCALL_WRAPPER instead of hard-coding whether host
> > > architecture is expected to use syscall wrapper or not (which is less=
 reliable
> > > and can change over time).
> > >
> >
> > Hi Andrii,
> > I would very much liked if there was such a macro, which will make
> > things easier for syscall tracing,
> > but I think that you can't assume that libbpf will have access to
> > kconfig files all the time.
> > For example, if running from a container and not mounting /boot (on
> > environments where the config file is in /boot), libbpf will fail to
> > load CONFIG_ARCH_HAS_SYSCALL_WRAPPER value and assume it to be not
> > defined.
> > Then, on any environment with a "new" kernel where the program runs
> > from a container, it will return the wrong argument values.
> > For this very reason we fall-back in [1] to assume
> > CONFIG_ARCH_HAS_SYSCALL_WRAPPER is defined, as in most environments it
> > will be.
> >
> > [1] https://github.com/aquasecurity/tracee/blob/0f28a2cc14b851308ebaa38=
0d503dea9eaa67271/pkg/ebpf/initialization/kconfig.go#L37
> >
>
> I see, unfortunately without relying on
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER on BPF side it's hard to make this
> correct in all kernel versions. One way would be to keep
> BPF_KPROBE_SYSCALL as is assuming syscall wrapper for x86, s390 and
> arm64, and add BPF_KSYSCALL() macro as I did here, which would depend
> on __kconfig, so in your situation it won't work. SEC("ksyscall") by
> itself will still work, though, if you find it useful.
>

I thought some more about this. This is the second such problem (first
being USDT detecting availability of BPF cookie support) where libbpf
on user-space side performs feature detection and BPF-side code has to
use slightly different feature detection for the same feature.

To solve both problems a bit more generically, I'm thinking to add few
fake __kconfig variable, just like libbpf does with
LINUX_VERSION_CODE. I'll carve out some "namespace" for
libbpf-provided feature detection (e.g., LINUX_HAS_BPF_COOKIE and
LINUX_HAS_SYSCALL_WRAPPER, or something along those lines), and libbpf
will fill them in just like we do with LINUX_VERSION_CODE. Without
actually requiring /proc/config.gz. Thoughts?

>
> > > It would be great to get feedback about the overall feature, but also=
 I'd
> > > appreciate help with testing this, especially for non-x86_64 architec=
tures.
> > >
> > > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > > Cc: Kenta Tada <kenta.tada@sony.com>
> > > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > >
> > > Andrii Nakryiko (3):
> > >   libbpf: improve and rename BPF_KPROBE_SYSCALL
> > >   libbpf: add ksyscall/kretsyscall sections support for syscall kprob=
es
> > >   selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests
> > >
> > >  tools/lib/bpf/bpf_tracing.h                   |  44 +++++--
> > >  tools/lib/bpf/libbpf.c                        | 109 ++++++++++++++++=
++
> > >  tools/lib/bpf/libbpf.h                        |  16 +++
> > >  tools/lib/bpf/libbpf.map                      |   1 +
> > >  tools/lib/bpf/libbpf_internal.h               |   2 +
> > >  .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
> > >  .../selftests/bpf/progs/test_attach_probe.c   |   6 +-
> > >  .../selftests/bpf/progs/test_probe_user.c     |  27 +----
> > >  8 files changed, 172 insertions(+), 39 deletions(-)
> > >
> > > --
> > > 2.30.2
> > >
