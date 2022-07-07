Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381B569D6C
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiGGI2Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 04:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiGGI2R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 04:28:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A10B4D4D4
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 01:28:16 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g4so17206671pgc.1
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7zlVFrp+V7xu1TNM2OmhfUhgGauXrS/ms4OomcA+YtU=;
        b=B3a0Y8fmKPsAFetlteTBvl+gqpKVNzhWO0C3sTCfubu0qgZ6tdEQmFZ3COgKv7Ii5a
         Rd9QfaEncjZ3AuD22a2nOPo29I2SdsD50tsnpdDNlVTJcXNO7hGpDCsRburfJwtKoF8s
         wwPwUcYXeWpQIVM9+Wfbh2OD2Qr8S0peN2CIltKW4OQxr5wT7zNBCGv+PEqC2UgPIRph
         uAhVrZchxKorOWxaQPyfCIHFMnBZ84rT6SOU1qDui5Q6NkyFggO0kyZ8b3ku9YPuqOnT
         Nrct6zBK0sgLKpIrSJpR46aj1M4CVWzqK5K6FDHsc7Lo+mlH2BtPlr5q657cka4WLNmv
         qCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7zlVFrp+V7xu1TNM2OmhfUhgGauXrS/ms4OomcA+YtU=;
        b=q33wxPZkzxNkeK4OXYaNH0DBjAZSgMEz1I2I4Q5EClsYltQnkFANvDTTenppXlWayF
         zj7O6MJ9YX8C3Z3w+nLotq7tUge5iV6qr/Cqb+GweC1gogMnlb/GaXYN6Abn+Rtun7Qk
         qffDw6kkGMD8bLzy5qiy2gYhoHoVk/9YLEthSZLFdlVaQkeK0ZORA9w1Dm5D1JFzIQPi
         gCO+Br6CGeG686IteEl2HKGOfLU/MU+np9qQOh49wOrBHzSS06jreB0IbRmALCbSzJR5
         yx2bcA8tm7Bs7Ij7Nav4ufo5RrOXSUjLB90SYZ2itBNmE0P4oydLYB5PFVbT22N9oRCh
         FtFg==
X-Gm-Message-State: AJIora+CCu88CTt6fwMGyTa0eMxG755+F714cwBCqcFFmBDqL/aQFJKK
        aTDVidep3llOzG7ZdlQntJOzUBmtDxcMsEi92EA=
X-Google-Smtp-Source: AGRyM1umEeLqsjpc9WCwwnmQX86abFNqQB6Sa+UeY8ny+P+bNQCswqDZrfnJCnUMdWqhFeWDIDnEq9hoqg7GZ5b46xI=
X-Received: by 2002:a17:902:cec4:b0:16a:16d6:f67f with SMTP id
 d4-20020a170902cec400b0016a16d6f67fmr49618395plg.139.1657182495450; Thu, 07
 Jul 2022 01:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org>
In-Reply-To: <20220707004118.298323-1-andrii@kernel.org>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Thu, 7 Jul 2022 11:28:04 +0300
Message-ID: <CAMy7=ZWo1uvN04756dbi6c8HdOO5GajYi81EMqAQ3LWney3DoA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/3] libbpf: add better syscall kprobing support
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
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

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=94=D7=
=B3, 7 =D7=91=D7=99=D7=95=D7=9C=D7=99 2022 =D7=91-3:48 =D7=9E=D7=90=D7=AA =
=E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii@kernel.org=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> This RFC patch set is to gather feedback about new
> SEC("ksyscall") and SEC("kretsyscall") section definitions meant to simpl=
ify
> life of BPF users that want to trace Linux syscalls without having to kno=
w or
> care about things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER and related arch-s=
pecific
> vs arch-agnostic __<arch>_sys_xxx vs __se_sys_xxx function names, calling
> convention woes ("nested" pt_regs), etc. All this is quite annoying to
> remember and care about as BPF user, especially if the goal is to write
> achitecture- and kernel version-agnostic BPF code (e.g., things like
> libbpf-tools, etc).
>
> By using SEC("ksyscall/xxx")/SEC("kretsyscall/xxx") user clearly communic=
ates
> the desire to kprobe/kretprobe kernel function that corresponds to the
> specified syscall. Libbpf will take care of all the details of determinin=
g
> correct function name and calling conventions.
>
> This patch set also improves BPF_KPROBE_SYSCALL (and renames it to
> BPF_KSYSCALL to match SEC("ksyscall")) macro to take into account
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER instead of hard-coding whether host
> architecture is expected to use syscall wrapper or not (which is less rel=
iable
> and can change over time).
>

Hi Andrii,
I would very much liked if there was such a macro, which will make
things easier for syscall tracing,
but I think that you can't assume that libbpf will have access to
kconfig files all the time.
For example, if running from a container and not mounting /boot (on
environments where the config file is in /boot), libbpf will fail to
load CONFIG_ARCH_HAS_SYSCALL_WRAPPER value and assume it to be not
defined.
Then, on any environment with a "new" kernel where the program runs
from a container, it will return the wrong argument values.
For this very reason we fall-back in [1] to assume
CONFIG_ARCH_HAS_SYSCALL_WRAPPER is defined, as in most environments it
will be.

[1] https://github.com/aquasecurity/tracee/blob/0f28a2cc14b851308ebaa380d50=
3dea9eaa67271/pkg/ebpf/initialization/kconfig.go#L37

> It would be great to get feedback about the overall feature, but also I'd
> appreciate help with testing this, especially for non-x86_64 architecture=
s.
>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Kenta Tada <kenta.tada@sony.com>
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
>
> Andrii Nakryiko (3):
>   libbpf: improve and rename BPF_KPROBE_SYSCALL
>   libbpf: add ksyscall/kretsyscall sections support for syscall kprobes
>   selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests
>
>  tools/lib/bpf/bpf_tracing.h                   |  44 +++++--
>  tools/lib/bpf/libbpf.c                        | 109 ++++++++++++++++++
>  tools/lib/bpf/libbpf.h                        |  16 +++
>  tools/lib/bpf/libbpf.map                      |   1 +
>  tools/lib/bpf/libbpf_internal.h               |   2 +
>  .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
>  .../selftests/bpf/progs/test_attach_probe.c   |   6 +-
>  .../selftests/bpf/progs/test_probe_user.c     |  27 +----
>  8 files changed, 172 insertions(+), 39 deletions(-)
>
> --
> 2.30.2
>
