Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD4639F54
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 03:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiK1CM2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 21:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK1CM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 21:12:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D031021;
        Sun, 27 Nov 2022 18:12:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id e27so22398623ejc.12;
        Sun, 27 Nov 2022 18:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0k39kPcNRyQ4Gy/xMoQ2YRMMznIAqMyVYzhZYK1cHc=;
        b=G2xLoZLw6j2wwV9HKqmKjYMBLtm6fEjRNLbEyvQ3bFYeKdhf3Vm5usPngW2c4ER9Pd
         kaXpzzzjLKX1mRCFjaxOwM7uM398zii2Qc8KqiEWLfzmxAwxFbm1aBU58+RPPFi2ZVW2
         Oy6oGDV+vmVYBN/K6TSWu6IbiGVw82Rp6SDRLwqWRrz2qrDO22CP7SYnibc05ax8jwsG
         fjvBqjfcgahHuS2/sQ0E5q0xcwCXoa/Qk9xrzHsiIOeBRj0KQmsv0hXZtU8bt10aiIVr
         DmfzGukCPHDyIMBPG2bBTfy+LwLBmHu9go3LA59d4zFMF6ScBCV8wr+UxIOwN3ETMAEq
         rJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0k39kPcNRyQ4Gy/xMoQ2YRMMznIAqMyVYzhZYK1cHc=;
        b=Oa79jBFiESHTjstdZWH7EbJ81HLJZQr3Kr1XfAlFjr5h/+tzEtTvx+/R7lwUidqjkm
         v5C/i66XokYkIX4ZsWe/1ITobouWBAnbCQr7ugjLApOJb/Vh+1eIWe4h6jS7m3JrQgPl
         HVNfDetJ1nNKCJRNdsIUmuPZskGfKA9rY0w9/tnHSwPzGfp1iWopVPb31iQa7g50dLAq
         zEIxImw4O3b13O77nGy1a2PqwGTCwKdjUbUheoWx9te2aNqO3EKXU4NIIJoQSQ81TyID
         3lEGEMgmNAa1h6yByB35F6oPRirMxkmo82MYcCOg6dG9hXIBebsgKLHBAUQ3WMAhbW4W
         Tblw==
X-Gm-Message-State: ANoB5pkyDt2Y4uEvlasvnvHlkiCTcEzkWXq9g8AYfPRoW4JKvDECVs06
        VstvLXJDIvhZ0OWBBbmY0ZbnzSc8VVtyC9hG18E=
X-Google-Smtp-Source: AA0mqf5/5db15AOLubBkFDwNub8sQSrogkPyLEd84ivmr8BuoOP/U8Te4ohx6DRs7KHKDIwUX2oHHKmeGM9DetdNI2Y=
X-Received: by 2002:a17:906:4ed9:b0:7ae:664a:a7d2 with SMTP id
 i25-20020a1709064ed900b007ae664aa7d2mr42157318ejv.676.1669601543551; Sun, 27
 Nov 2022 18:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20221125122912.54709-1-sunhao.th@gmail.com> <20221128003800.h2bmqcv5dfqmfbcf@MacBook-Pro-5.local>
 <CACkBjsY_Jy9seMfcMMPbYN-YMubcUzABpMm7VFe8wU+X6LKAUQ@mail.gmail.com>
In-Reply-To: <CACkBjsY_Jy9seMfcMMPbYN-YMubcUzABpMm7VFe8wU+X6LKAUQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 27 Nov 2022 18:12:12 -0800
Message-ID: <CAADnVQ+G5AuJgo0iRmGOzzr2sS-Ddz6Dt-_99hS+q=VXPpHH7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Add LDX/STX/ST sanitize in jited BPF progs
To:     Hao Sun <sunhao.th@gmail.com>
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

On Sun, Nov 27, 2022 at 5:41 PM Hao Sun <sunhao.th@gmail.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=B41=
1=E6=9C=8828=E6=97=A5=E5=91=A8=E4=B8=80 08:38=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Nov 25, 2022 at 08:29:09PM +0800, Hao Sun wrote:
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
> >
> > The above paragraph makes it sound that it's currently impossible to
> > use kasan with BPF. Which is confusing and incorrect statement.
> > kasan adds all the necessary instrumentation to BPF interpreter already
> > and syzbot can perform bug discovery.
> > syzbot runner should just disable JIT and run all progs via interpreter=
.
> > Adding all this logic to run JITed progs in kasan kernel is
> > just unnecessary complexity.
>
> Sorry for the confusion, I mean JITed BPF prog can't use KASAN currently,
> maybe it should be called BPF_JITED_PROG_KASAN.
>
> It's actually useful because JIT is used in most real cases for testing/f=
uzzing,
> syzbot uses WITH_JIT_ALWAYS_ON[1][2].

Just turn it off in syzbot. jit_always_on is a security feature
because of speculative execution bugs that can exploit
any in-kernel interpreter (not only bpf interpreter).

> For those tools, they may need
> to run hundred times for each generated BPF prog to find interesting bugs=
 in
> the verifier, JIT makes it much faster.

Unlikely. With all the overhead of saving a bunch of regs,
restoring them and calling functions instead of direct load/store
such JITed code is probably running at the same speed as
interpreter.
Also syzbot generated progs are tiny.
Your oob reproducer is tiny too.
The speed of execution doesn't matter in such cases.

> Also, bugs in JIT can be
> missed if they're
> disabled.

Disagree. Replacing direct load/store with calls
doesn't improve JIT test coverage.

Also think long term. Beyond kasan there are various *sans
that instrument code differently. load/store may not be
the only insns that should be instrumented.
So hacking JITs either directly or via verifier isn't going
to scale.
