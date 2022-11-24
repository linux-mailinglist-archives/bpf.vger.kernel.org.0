Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B085E6370BE
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 04:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKXDGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 22:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXDGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 22:06:01 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A3CC8CA1;
        Wed, 23 Nov 2022 19:05:59 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 1so416548ybl.7;
        Wed, 23 Nov 2022 19:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e//KtfJIfmoME9Z9ZpeOBV4irZrDSjBo2Wb+F6tY1jQ=;
        b=lXMphSgzKlo1fahwcPgAociTUK6KLdTthg6iA1Lr2wZhkFMMAK+LQ4MWOpCpIp189F
         TLn4+QD28uBTHBq8SRxjjEyyiMJafnpbDUTMx7rw85+gflZkezTZelWf+if3C1lvTxTO
         0igXOBD+xX1QB+H+lr0E3PDllPdtL3BQQngvGs9ezvNpdvYuouWupgoa/bcv2nYuyqjT
         sktPrSYNje8P0/I7qKG8W2Hr/+D9A3m1fbK8/2EYDQdNnOB1mkhszfbYAND0TJ8LKo5V
         eFHaKhm8PQFtqMg4cMVpgkXpMNsA8kvZvsJrJJSbN8iT5rIFIWs20bxqptiE3LJucusQ
         NRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e//KtfJIfmoME9Z9ZpeOBV4irZrDSjBo2Wb+F6tY1jQ=;
        b=ARVDivEWd5TMubXhlNaPA7Q8pPwepSwWv/daa1ROwEFY4hfnCcxZ6ZJglI/M+aY9wv
         gzQEKicd5dWF3NqOf5Us0JGKp9KAnHUnXNtHhtfQMou0w3sjVSCbSVsSNovMhMJhGYiQ
         g7wibibaFlyamaKB35hc2Ix7QYwfvLHhD/nii5X+RHxTr+gX7vD+wGkuY4iT2gisgMNT
         kO5z1ucLMdibOa86z4P3OFgBrxiT4VVUOxnBR0H+kdLHFe+87bmN3VJwZuquXzuMKMBu
         QcoDh5QC2VcHTjpGxrb4jtoEf2dYECKbrKk/+dWIu1LI6w7a8Ub628b/19+lrBff2ryz
         eFrg==
X-Gm-Message-State: ANoB5pl2HveBTQ18twYSSZsWEPLtRyu9AAZZ7c7KQu35i+nCr/jIgs0A
        PLZod82aNWXcaxLlRScmnbg4Lsx94ha2hb5QMKQui/ML4FJ8
X-Google-Smtp-Source: AA0mqf4NgmY5ltdxd4gu0Jd5ORYfRbpGz6Eob/nkuuBw+FHiAEogkYSyCaOZwvt4s15eLwgUs3kXZSWlWS0BYtwyd7I=
X-Received: by 2002:a25:ad87:0:b0:6cb:3fe2:5164 with SMTP id
 z7-20020a25ad87000000b006cb3fe25164mr12473126ybi.59.1669259158903; Wed, 23
 Nov 2022 19:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20221123141546.238297-1-sunhao.th@gmail.com> <bf22362b-0a7c-1cb3-1f22-28144bdf4380@iogearbox.net>
In-Reply-To: <bf22362b-0a7c-1cb3-1f22-28144bdf4380@iogearbox.net>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 24 Nov 2022 11:05:47 +0800
Message-ID: <CACkBjsa37aOMgFsW-JOK-kL6k3TRKvpiTLxyHdJT_hhicEQYuw@mail.gmail.com>
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

Daniel Borkmann <daniel@iogearbox.net> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=
=E6=97=A5=E5=91=A8=E5=9B=9B 07:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11/23/22 3:15 PM, Hao Sun wrote:
> > The verifier sometimes makes mistakes[1][2] that may be exploited to
> > achieve arbitrary read/write. Currently, syzbot is continuously testing
> > bpf, and can find memory issues in bpf syscalls, but it can hardly find
> > mischecking/bugs in the verifier. We need runtime checks like KASAN in
> > BPF programs for this. This patch series implements address sanitize
> > in jited BPF progs for testing purpose, so that tools like syzbot can
> > find interesting bugs in the verifier automatically by, if possible,
> > generating and executing BPF programs that bypass the verifier but have
> > memory issues, then triggering this sanitizing.
> >
> > The idea is to dispatch read/write addr of a BPF program to the kernel
> > functions that are instrumented by KASAN, to achieve indirect checking.
> > Indirect checking is adopted because this is much simple, instrument
> > direct checking like compilers makes the jit much more complex. The
> > main step is: back up R0&R1 and store addr in R1, and then insert the
> > checking function before load/store insns, during bpf_misc_fixup(), and
> > finally in the jit stage, backup R1~R5 to make sure the checking funcs
> > won't corrupt regs states. An extra Kconfig option is used to enable
> > this, so normal use case won't be impacted at all.
>
> Thanks for looking into this! It's a bit unfortunate that this will need
> changes in every BPF JIT. Have you thought about a generic solution which
> would not require changes in JITs? Given this is for debugging and findin=
g
> mischecking/bugs in the verifier, can't we reuse interpreter for this and
> only implement it there? I would be curious if we could achieve the same
> result from [3] with such approach.
>

Hi Daniel,

Thanks for taking a look. The reason I choose to do this in jited progs is
because JIT is used in most real cases, so does testing/fuzzing, e.g.,
syzbot test BPF with JIT_ALWAYS_ON=3Dy. Also, a BPF program generated
by fuzzers or other tools is likely need to be run hundred times with rando=
m
inputs to trigger potential issues in it and be captured by sanitize, so JI=
T
makes this much faster.

We don't need changes in every BPF JIT I believe, supporting X86_64
and Arm64 would be enough, and the only thing need to be done there
is to backup regs on stack before calling checking functions.
Also, I'm wondering if anyone knows how to better make sure the checking
function won't corrupt scratch regs' states, e.g., a flag to force compiler=
 to
push scratch regs before using them, during gen code for those funcs.
If this is feasible, the changes to JIT can be completely removed, and
fixup in the verifier would be enough.

Regards
Hao

> > Also, not all ldx/stx/st are instrumented. Insns rewrote by other fixup
> > or conversion passes that use BPF_REG_AX are skipped, because that
> > conflicts with us; insns whose access addr is specified by R10 are also
> > skipped because they are trivial to verify.
> >
> > Patch1 sanitizes st/stx insns, and Patch2 sanitizes ldx insns, Patch3 a=
dds
> > selftests for instrumentation in each possible case, and all new/existi=
ng
> > selftests for the verifier can pass. Also, a BPF prog that also exploit=
s
> > CVE-2022-23222 to achieve OOB read is provided[3], this can be perfertl=
y
> > captured with this patch series.
> >
> > I haven't found a better way to back up the regs before executing the
> > checking functions, and have to store them on the stack. Comments and
> > advice are surely welcome.
> >
> > [1] http://bit.do/CVE-2021-3490
> > [2] http://bit.do/CVE-2022-23222
> > [3] OOB-read: https://pastebin.com/raw/Ee1Cw492
> >
> > Hao Sun (3):
> >    bpf: Sanitize STX/ST in jited BPF progs with KASAN
> >    bpf: Sanitize LDX in jited BPF progs with KASAN
> >    selftests/bpf: Add tests for LDX/STX/ST sanitize
> >
> >   arch/x86/net/bpf_jit_comp.c                   |  34 ++
> >   include/linux/bpf.h                           |  14 +
> >   kernel/bpf/Kconfig                            |  14 +
> >   kernel/bpf/verifier.c                         | 190 +++++++++++
> >   .../selftests/bpf/verifier/sanitize_st_ldx.c  | 323 +++++++++++++++++=
+
> >   5 files changed, 575 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/verifier/sanitize_st_l=
dx.c
> >
> >
> > base-commit: 8a2162a9227dda936a21fe72014a9931a3853a7b
> >
>
> Thanks,
> Daniel
