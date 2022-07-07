Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806DD56AD0D
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 22:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiGGU40 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiGGU4Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 16:56:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3ED2F037
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 13:56:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h23so34429388ejj.12
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ugum4L4r/bWxvWe95ZJvtH3sf6oYBZP8BV3dcLd6G+0=;
        b=LxzfPt0wFIGk2KRa3ipNdx8ncHL2wPemHxPpPxRi/K7vdVzBeT8SAAFWuf1qctyywJ
         o1xi0hfGAVmjVJO5aP4zcFXHo3ezm/J5zY52LdM7GqNXGcnGU2SrZKBYqsj+rh/29Brm
         kbAxOsa3waaeeG9+SbyNgxeXBetfuOgsYKMKT+8KNR13QlFFPf9QBebuQFR43773Ekzr
         FceqHZAPPa7XrwQbEDXCjPVc42/ihH4NI3hrz7K8K0j+j//siJOA/Sudq/kf7TdgmdJo
         Xtdg0N6L3tiHRI3F5oGWalQoHxmURoKtE9Rxz8QeIk/1OvTgdQSIYOoDjF4C8Tnyartv
         2xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ugum4L4r/bWxvWe95ZJvtH3sf6oYBZP8BV3dcLd6G+0=;
        b=jsOIPUlQtHDIN+xp/hEaF1W4PYK7s70zDodNky5PdiqrHc6TNXOvsON3uc4V53x/x/
         /rJl8T04eOoxcL7oR+LspRVk15LtC8y6HTLT+uB5DzS6gEkYif9MdZdh8iC2WaombWtD
         xnzq7PYoFppdhdffUmWqXcMmRjfGW5HDN0kBnzqeNKBMno4dlM2GqNUk/WSa+nEiAR7P
         D85iyn3a5L1YfD/H5agDdKnOTZFg8ARB/uhMOqYFl+9fkqQOtczlP/pMRrtvt+vkMFyL
         ABDCiUI5gO0tD5czTOjxT8cWRnxLlD5hyfpHY37WHoal5BkN5wISZyntzCHNVtqEiGMq
         EtDw==
X-Gm-Message-State: AJIora9PAD+ljPClmJeQSpgJA1xuzkMXerg1jUtQL3GnBQpiqQeQE9kv
        DzXcFtKVOcH9YbQVGcBAtO3H43PWgVWUK/E1unw=
X-Google-Smtp-Source: AGRyM1uet+3D44cE5SOg3N2BQB4t+v1tYHwqbESbZ/fRUWWGDhwWrwDN4OMZAhOzb3brvL+4MJhgye+dut2LBIZW0nQ=
X-Received: by 2002:a17:907:a075:b0:72a:7508:c014 with SMTP id
 ia21-20020a170907a07500b0072a7508c014mr20061ejc.176.1657227382582; Thu, 07
 Jul 2022 13:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <CAMy7=ZWo1uvN04756dbi6c8HdOO5GajYi81EMqAQ3LWney3DoA@mail.gmail.com>
In-Reply-To: <CAMy7=ZWo1uvN04756dbi6c8HdOO5GajYi81EMqAQ3LWney3DoA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Jul 2022 13:56:10 -0700
Message-ID: <CAEf4Bza97xALx4u6EiiQZ0gXQ90rQfEmbY7z0H5yC6AB=Q-91g@mail.gmail.com>
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

On Thu, Jul 7, 2022 at 1:28 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=94=
=D7=B3, 7 =D7=91=D7=99=D7=95=D7=9C=D7=99 2022 =D7=91-3:48 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> <=E2=80=AAandrii@kernel.org=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > This RFC patch set is to gather feedback about new
> > SEC("ksyscall") and SEC("kretsyscall") section definitions meant to sim=
plify
> > life of BPF users that want to trace Linux syscalls without having to k=
now or
> > care about things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER and related arch=
-specific
> > vs arch-agnostic __<arch>_sys_xxx vs __se_sys_xxx function names, calli=
ng
> > convention woes ("nested" pt_regs), etc. All this is quite annoying to
> > remember and care about as BPF user, especially if the goal is to write
> > achitecture- and kernel version-agnostic BPF code (e.g., things like
> > libbpf-tools, etc).
> >
> > By using SEC("ksyscall/xxx")/SEC("kretsyscall/xxx") user clearly commun=
icates
> > the desire to kprobe/kretprobe kernel function that corresponds to the
> > specified syscall. Libbpf will take care of all the details of determin=
ing
> > correct function name and calling conventions.
> >
> > This patch set also improves BPF_KPROBE_SYSCALL (and renames it to
> > BPF_KSYSCALL to match SEC("ksyscall")) macro to take into account
> > CONFIG_ARCH_HAS_SYSCALL_WRAPPER instead of hard-coding whether host
> > architecture is expected to use syscall wrapper or not (which is less r=
eliable
> > and can change over time).
> >
>
> Hi Andrii,
> I would very much liked if there was such a macro, which will make
> things easier for syscall tracing,
> but I think that you can't assume that libbpf will have access to
> kconfig files all the time.
> For example, if running from a container and not mounting /boot (on
> environments where the config file is in /boot), libbpf will fail to
> load CONFIG_ARCH_HAS_SYSCALL_WRAPPER value and assume it to be not
> defined.
> Then, on any environment with a "new" kernel where the program runs
> from a container, it will return the wrong argument values.
> For this very reason we fall-back in [1] to assume
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER is defined, as in most environments it
> will be.
>
> [1] https://github.com/aquasecurity/tracee/blob/0f28a2cc14b851308ebaa380d=
503dea9eaa67271/pkg/ebpf/initialization/kconfig.go#L37
>

I see, unfortunately without relying on
CONFIG_ARCH_HAS_SYSCALL_WRAPPER on BPF side it's hard to make this
correct in all kernel versions. One way would be to keep
BPF_KPROBE_SYSCALL as is assuming syscall wrapper for x86, s390 and
arm64, and add BPF_KSYSCALL() macro as I did here, which would depend
on __kconfig, so in your situation it won't work. SEC("ksyscall") by
itself will still work, though, if you find it useful.


> > It would be great to get feedback about the overall feature, but also I=
'd
> > appreciate help with testing this, especially for non-x86_64 architectu=
res.
> >
> > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > Cc: Kenta Tada <kenta.tada@sony.com>
> > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> >
> > Andrii Nakryiko (3):
> >   libbpf: improve and rename BPF_KPROBE_SYSCALL
> >   libbpf: add ksyscall/kretsyscall sections support for syscall kprobes
> >   selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests
> >
> >  tools/lib/bpf/bpf_tracing.h                   |  44 +++++--
> >  tools/lib/bpf/libbpf.c                        | 109 ++++++++++++++++++
> >  tools/lib/bpf/libbpf.h                        |  16 +++
> >  tools/lib/bpf/libbpf.map                      |   1 +
> >  tools/lib/bpf/libbpf_internal.h               |   2 +
> >  .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
> >  .../selftests/bpf/progs/test_attach_probe.c   |   6 +-
> >  .../selftests/bpf/progs/test_probe_user.c     |  27 +----
> >  8 files changed, 172 insertions(+), 39 deletions(-)
> >
> > --
> > 2.30.2
> >
