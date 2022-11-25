Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB541638375
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 06:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKYF0R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 00:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKYF0Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 00:26:16 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DDF2B626;
        Thu, 24 Nov 2022 21:26:15 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3691e040abaso31856027b3.9;
        Thu, 24 Nov 2022 21:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAx1cvmtc4nVwbJwrP79H8Bhm1VjWl8oW+0nxFm9f3o=;
        b=NKr5+ClvwUbc2fChqztMCNSDsHQav4EdKsyiO369cH66wommmaPJ5kkEMwgPLoSky0
         VsyzIXoZHouoPcaraGF2SIOKJdpBcTxtrB53KqM8lzJOIZ2j/tiODHu35+s9bPRgXa1w
         Md56fWXwQZ9mP/CylZbYDff+z9Yv33EMdywsD8BXTBlfnukjlrJGrkjEKvtbXMa+eEG8
         1Gg7qxnb9AAGxkcByUl0pA0UH/EuuvJPM+A9EFlVPsVixpQ+POfDKXGv0iG9CsVBoOQi
         fx+bpWw9LKYbZeYRQuS6/ZUB6FWiQ52HRdqOZ5U1zVXc/o6HY3xXPXgcfVeY68drszgm
         LwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAx1cvmtc4nVwbJwrP79H8Bhm1VjWl8oW+0nxFm9f3o=;
        b=cAOIHK/EgmL/LJPxTs9riDxIcOlHdhPBr+5JFIDjJ21SPdQWqA4Dc9K3IXwliiabmG
         TjlPJnEoEYOsyDf3BETO9MQEQYOeFBtujUgi8cBPKONidgJOJofU/CXWb18F5KkaZHD+
         EJL6uP+MB60RDsb8LjEfTZIm/xshfyfmdMe5O+RqB+cuZRYTa2Ls1+Mp9Pvd1cFqCkV7
         cpqOWSUhkrPTK8lsRzx11SpdL5WlvSnvhdHhtEAQXAwcMMQRmnzPxZOXX3217tpZBRSe
         WIkuKSV0JcoJolfqtsVKp3YCwZvTaDquVK3355jmIL4wdrN5IGu2bzPgpy74EW9z8MOg
         HVeQ==
X-Gm-Message-State: ANoB5pn8qccVNO26u8uO9ec6UiKQrLVEpNBcAO4n1T2CMd0VXS+h4KKY
        z+O9rlns1MTgS6HkHCvfSQxeH+WPGDDAxOlE9FqyzXs=
X-Google-Smtp-Source: AA0mqf4dtExGAGSO5LT+Db7fPvqlz03GOTzXkQxOzi+tkr/04JgpKvBWtbvpDdM+9uv/KQS421sRyykKa9VLm/3q+ig=
X-Received: by 2002:a81:9b83:0:b0:381:2226:74ff with SMTP id
 s125-20020a819b83000000b00381222674ffmr34609484ywg.102.1669353974811; Thu, 24
 Nov 2022 21:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20221123141546.238297-1-sunhao.th@gmail.com> <bf22362b-0a7c-1cb3-1f22-28144bdf4380@iogearbox.net>
 <CACkBjsa37aOMgFsW-JOK-kL6k3TRKvpiTLxyHdJT_hhicEQYuw@mail.gmail.com>
In-Reply-To: <CACkBjsa37aOMgFsW-JOK-kL6k3TRKvpiTLxyHdJT_hhicEQYuw@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 25 Nov 2022 13:26:03 +0800
Message-ID: <CACkBjsYRCruhRH+ZAQ_p2q58F9p3bo3wwJMdRnQZTDiR9-DNqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: Add LDX/STX/ST sanitize in jited BPF progs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
        URIBL_DBL_ABUSE_REDIR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hao Sun <sunhao.th@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=9B=9B 11:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Daniel Borkmann <daniel@iogearbox.net> =E4=BA=8E2022=E5=B9=B411=E6=9C=882=
4=E6=97=A5=E5=91=A8=E5=9B=9B 07:41=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 11/23/22 3:15 PM, Hao Sun wrote:
> > > The verifier sometimes makes mistakes[1][2] that may be exploited to
> > > achieve arbitrary read/write. Currently, syzbot is continuously testi=
ng
> > > bpf, and can find memory issues in bpf syscalls, but it can hardly fi=
nd
> > > mischecking/bugs in the verifier. We need runtime checks like KASAN i=
n
> > > BPF programs for this. This patch series implements address sanitize
> > > in jited BPF progs for testing purpose, so that tools like syzbot can
> > > find interesting bugs in the verifier automatically by, if possible,
> > > generating and executing BPF programs that bypass the verifier but ha=
ve
> > > memory issues, then triggering this sanitizing.
> > >
> > > The idea is to dispatch read/write addr of a BPF program to the kerne=
l
> > > functions that are instrumented by KASAN, to achieve indirect checkin=
g.
> > > Indirect checking is adopted because this is much simple, instrument
> > > direct checking like compilers makes the jit much more complex. The
> > > main step is: back up R0&R1 and store addr in R1, and then insert the
> > > checking function before load/store insns, during bpf_misc_fixup(), a=
nd
> > > finally in the jit stage, backup R1~R5 to make sure the checking func=
s
> > > won't corrupt regs states. An extra Kconfig option is used to enable
> > > this, so normal use case won't be impacted at all.
> >
> > Thanks for looking into this! It's a bit unfortunate that this will nee=
d
> > changes in every BPF JIT. Have you thought about a generic solution whi=
ch
> > would not require changes in JITs? Given this is for debugging and find=
ing
> > mischecking/bugs in the verifier, can't we reuse interpreter for this a=
nd
> > only implement it there? I would be curious if we could achieve the sam=
e
> > result from [3] with such approach.
> >
>
> Hi Daniel,
>
> Thanks for taking a look. The reason I choose to do this in jited progs i=
s
> because JIT is used in most real cases, so does testing/fuzzing, e.g.,
> syzbot test BPF with JIT_ALWAYS_ON=3Dy. Also, a BPF program generated
> by fuzzers or other tools is likely need to be run hundred times with ran=
dom
> inputs to trigger potential issues in it and be captured by sanitize, so =
JIT
> makes this much faster.
>
> We don't need changes in every BPF JIT I believe, supporting X86_64
> and Arm64 would be enough, and the only thing need to be done there
> is to backup regs on stack before calling checking functions.
> Also, I'm wondering if anyone knows how to better make sure the checking
> function won't corrupt scratch regs' states, e.g., a flag to force compil=
er to
> push scratch regs before using them, during gen code for those funcs.
> If this is feasible, the changes to JIT can be completely removed, and
> fixup in the verifier would be enough.
>

I think we can extend BPF prog's stack size in this mode, then backup all
the scratch regs to those free space. This way, everything just happens
in BPF insn level, we don't need to change JIT at all.

I will send patch v2 for this.

> Regards
> Hao
>
> > > Also, not all ldx/stx/st are instrumented. Insns rewrote by other fix=
up
> > > or conversion passes that use BPF_REG_AX are skipped, because that
> > > conflicts with us; insns whose access addr is specified by R10 are al=
so
> > > skipped because they are trivial to verify.
> > >
> > > Patch1 sanitizes st/stx insns, and Patch2 sanitizes ldx insns, Patch3=
 adds
> > > selftests for instrumentation in each possible case, and all new/exis=
ting
> > > selftests for the verifier can pass. Also, a BPF prog that also explo=
its
> > > CVE-2022-23222 to achieve OOB read is provided[3], this can be perfer=
tly
> > > captured with this patch series.
> > >
> > > I haven't found a better way to back up the regs before executing the
> > > checking functions, and have to store them on the stack. Comments and
> > > advice are surely welcome.
> > >
> > > [1] http://bit.do/CVE-2021-3490
> > > [2] http://bit.do/CVE-2022-23222
> > > [3] OOB-read: https://pastebin.com/raw/Ee1Cw492
> > >
> > > Hao Sun (3):
> > >    bpf: Sanitize STX/ST in jited BPF progs with KASAN
> > >    bpf: Sanitize LDX in jited BPF progs with KASAN
> > >    selftests/bpf: Add tests for LDX/STX/ST sanitize
> > >
> > >   arch/x86/net/bpf_jit_comp.c                   |  34 ++
> > >   include/linux/bpf.h                           |  14 +
> > >   kernel/bpf/Kconfig                            |  14 +
> > >   kernel/bpf/verifier.c                         | 190 +++++++++++
> > >   .../selftests/bpf/verifier/sanitize_st_ldx.c  | 323 +++++++++++++++=
+++
> > >   5 files changed, 575 insertions(+)
> > >   create mode 100644 tools/testing/selftests/bpf/verifier/sanitize_st=
_ldx.c
> > >
> > >
> > > base-commit: 8a2162a9227dda936a21fe72014a9931a3853a7b
> > >
> >
> > Thanks,
> > Daniel
