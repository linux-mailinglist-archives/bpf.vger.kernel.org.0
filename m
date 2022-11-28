Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C576639FD6
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 03:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK1C6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 21:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1C6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 21:58:32 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3546278;
        Sun, 27 Nov 2022 18:58:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w79so9189447pfc.2;
        Sun, 27 Nov 2022 18:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3rQp1kF0dgXtLApz/AwEyR6PIFhkqJV5eD9Ad4OipQ=;
        b=KvY6WhsHiyILCM+W4BxlTNvIzU0YUPAiiXzzA7JSUxrdq8eHx1CFPRui9L4rRwT0Yx
         OyiCitdXOMegojZdtKZqJlnZx0tVteZd32zNyJuDXQqrl4zOfR7wbTfsnDnJHTlXNJ78
         Ln5HMzmEpviyJUXLk687csUpTrbQKoFJxswOEJI77yFO0x+ExXjAU/1DWSDbTx88lZQ8
         rwRYbgjI4IfDeLRh5O+zi1XFxXFVit7LdIEFPQa2krnSmr6sUwPsNHuhgqKZQ5N01SDl
         y8oz6Efh7dDrbfWOuFgge4f0Bs6NAiSdvLrMlQAweRJGEIqHeVDvM+b1bw2sBpt7ulTX
         ZgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3rQp1kF0dgXtLApz/AwEyR6PIFhkqJV5eD9Ad4OipQ=;
        b=mQgrPsjiD2UwTj4Efg71ziDctwzpWnYc8/FFGsC2yT0u6QVkpmDOprp7c+8+20+nZC
         GwvP12JnfHOPrA1LA27B4cQUKZNOjXkIREtivcaFtG7nGTuZaHORWCYxSi1iav9pw2QK
         vVQUKBQ+6/CdRpI7vYltyl04iBiLBmmY9P7w/Uup4yuJiUuPKjk6C1u/ZqLeI1PtEgjs
         OcSlTL7peR/MytI2MFz/q2k7AfFOF4gsWq4M6wY8/MlGOEWbN8L+q8Znbb8mUjAFGWSz
         4Dzr6tbgu1xoy3UhrL+APCgzkLCpoxbMYo7CFiD1LnkmVV+23rdELhbb/UAurAUw6bcP
         vjvw==
X-Gm-Message-State: ANoB5pkdchExjIsOAJ9HnLHDsQHT8xmeWWWbLy/gIIthBLq/P3/XKSpy
        MyX+ua4ilHkDBVM2aLzi1cPiUxhwzbbrh5K40g==
X-Google-Smtp-Source: AA0mqf5mN01nGtfwW+2jMhmhEfarm5DtRSR6/oMdRJZvgVY0zelufhnzu/Z5yY+cqlDUMykmuS18S+vGhrzpg2nnDOk=
X-Received: by 2002:a05:6a00:1a4c:b0:574:97d4:c10f with SMTP id
 h12-20020a056a001a4c00b0057497d4c10fmr18058844pfv.81.1669604310796; Sun, 27
 Nov 2022 18:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20221125122912.54709-1-sunhao.th@gmail.com> <20221128003800.h2bmqcv5dfqmfbcf@MacBook-Pro-5.local>
 <CACkBjsY_Jy9seMfcMMPbYN-YMubcUzABpMm7VFe8wU+X6LKAUQ@mail.gmail.com> <CAADnVQ+G5AuJgo0iRmGOzzr2sS-Ddz6Dt-_99hS+q=VXPpHH7Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+G5AuJgo0iRmGOzzr2sS-Ddz6Dt-_99hS+q=VXPpHH7Q@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 28 Nov 2022 10:58:19 +0800
Message-ID: <CACkBjsadebY1RZ0guYeja4bAG-kKWhz30FmOhf5ARhC8Edf1yA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Add LDX/STX/ST sanitize in jited BPF progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=B411=
=E6=9C=8828=E6=97=A5=E5=91=A8=E4=B8=80 10:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 27, 2022 at 5:41 PM Hao Sun <sunhao.th@gmail.com> wrote:
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=
=B411=E6=9C=8828=E6=97=A5=E5=91=A8=E4=B8=80 08:38=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Fri, Nov 25, 2022 at 08:29:09PM +0800, Hao Sun wrote:
> > > > The verifier sometimes makes mistakes[1][2] that may be exploited t=
o
> > > > achieve arbitrary read/write. Currently, syzbot is continuously tes=
ting
> > > > bpf, and can find memory issues in bpf syscalls, but it can hardly =
find
> > > > mischecking/bugs in the verifier. We need runtime checks like KASAN=
 in
> > > > BPF programs for this. This patch series implements address sanitiz=
e
> > > > in jited BPF progs for testing purpose, so that tools like syzbot c=
an
> > > > find interesting bugs in the verifier automatically by, if possible=
,
> > > > generating and executing BPF programs that bypass the verifier but =
have
> > > > memory issues, then triggering this sanitizing.
> > >
> > > The above paragraph makes it sound that it's currently impossible to
> > > use kasan with BPF. Which is confusing and incorrect statement.
> > > kasan adds all the necessary instrumentation to BPF interpreter alrea=
dy
> > > and syzbot can perform bug discovery.
> > > syzbot runner should just disable JIT and run all progs via interpret=
er.
> > > Adding all this logic to run JITed progs in kasan kernel is
> > > just unnecessary complexity.
> >
> > Sorry for the confusion, I mean JITed BPF prog can't use KASAN currentl=
y,
> > maybe it should be called BPF_JITED_PROG_KASAN.
> >
> > It's actually useful because JIT is used in most real cases for testing=
/fuzzing,
> > syzbot uses WITH_JIT_ALWAYS_ON[1][2].
>
> Just turn it off in syzbot. jit_always_on is a security feature
> because of speculative execution bugs that can exploit
> any in-kernel interpreter (not only bpf interpreter).
>

Will do that, thanks for the information.

> > For those tools, they may need
> > to run hundred times for each generated BPF prog to find interesting bu=
gs in
> > the verifier, JIT makes it much faster.
>
> Unlikely. With all the overhead of saving a bunch of regs,
> restoring them and calling functions instead of direct load/store
> such JITed code is probably running at the same speed as
> interpreter.
> Also syzbot generated progs are tiny.
> Your oob reproducer is tiny too.
> The speed of execution doesn't matter in such cases.
>

Hard to tell which one is faster, since each execution of insn in the
interpreter requires a jmp.
But you're right, did not think about this, I guess randomly generated
progs that can pass the verifier are normally tiny, so the speed indeed
may not be an issue here.

> > Also, bugs in JIT can be
> > missed if they're
> > disabled.
>
> Disagree. Replacing direct load/store with calls
> doesn't improve JIT test coverage.
>
> Also think long term. Beyond kasan there are various *sans
> that instrument code differently. load/store may not be
> the only insns that should be instrumented.
> So hacking JITs either directly or via verifier isn't going
> to scale.

Right, just let those *sans instrument the interpreter is more scalable.

Thanks
Hao
