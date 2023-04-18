Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC636E6C5A
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 20:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjDRSqH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRSqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 14:46:06 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA802694
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 11:46:05 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fe3cd445aso164785417b3.5
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681843564; x=1684435564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5DwDcMLo0kfrF6PYlvResFE41Vi4fcHn5w37kdon8U=;
        b=NV0gBrk4yCk6tfQ7IEsStcfJAuEhl8MQ45nVbDBaVbgDgSigjD0bK8cCrJSMG2hTNu
         fzh13sB+/O7hOVcVd2490CsnjYGGZ4xbd2mo6q9x9fKdGQtk25q2AXh7p6+skHraU00+
         /6yrU0NCza8IM+bvUk6doWhRKx5JWQoa6dZ7f82JoxP+9Ta8x7+dy4yoA0Z04yuspTUA
         8x4ukQlNeMxwrKCGW12WvGxDVJzlqoKcf/G/R+Q6kAwDZd3OopZGi30yPlHAIDuM4Dfo
         52x2p/YKtNaoK7KAPguBux6fzl0+USAj2qBsf+mCoSCNJZje7lmd6xgKMnjPoedy5NGY
         kpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681843564; x=1684435564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5DwDcMLo0kfrF6PYlvResFE41Vi4fcHn5w37kdon8U=;
        b=LqTuQiYSnKYkykk68G+JR5QzP3mj3Ba6FKK6pc1nziPoRmZUOp4djTcj8F5YQitEdX
         ppTzogNSWsGZRJZRKQiMm+/WqXBBCU6gAgFABI4Iw6vB+mnF7sjD1FJ79nPtRCKewtym
         6h99pzVOYWD+OMjuLYwX1MkjGYCCsVA5zd5o9cqmfmCyeDcHUElYu4Da4X0Dx975xZOH
         N9iTbe0teM59kEWfTp7O5OzmbuUWaCZBocd4hlwKVHhGekofXhXwApHP4HiIyu3tZOT4
         CjAcTPVsNlYyCpaXi4bifIgochGdNPjgpjLrK6lvZp8mR2v6kesetu0Bt4rHtt1wqp6a
         XDEQ==
X-Gm-Message-State: AAQBX9djv6lxKs+ysSHanba0j6dv0DQOhDdW5IDj7U1jZtX6nE7uCeOZ
        JBuH9ungdXlDHXdBZJabauuMPsP9+RCnVL7Gcns=
X-Google-Smtp-Source: AKy350aiIIRdG42LZtX+GGVgeeXp3SECyx6C3nBvkLILarAGpWYWaHllIP//AYJvsRZVg9l3mXbxSd10MMCRSilKqso=
X-Received: by 2002:a0d:cc81:0:b0:54e:e136:9f6b with SMTP id
 o123-20020a0dcc81000000b0054ee1369f6bmr756700ywd.46.1681843564407; Tue, 18
 Apr 2023 11:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230418002148.3255690-1-andrii@kernel.org> <20230418002148.3255690-4-andrii@kernel.org>
 <CAADnVQK-JjutrU-TMCh6f9qfcY_9T2mr59+Lzcw5us8KwDEmug@mail.gmail.com>
 <CAEf4BzaGEhszZ-VxB=0YdF989LQNZA-rnuZasEF_BB-Qy_hdNQ@mail.gmail.com> <CAADnVQ+xJ0sFR1E2rqPDVMd3Cf8MxJTHk+q3_65BEYG5_5BZ+w@mail.gmail.com>
In-Reply-To: <CAADnVQ+xJ0sFR1E2rqPDVMd3Cf8MxJTHk+q3_65BEYG5_5BZ+w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Apr 2023 11:45:49 -0700
Message-ID: <CAEf4BzZXhqr3g8FS=w9EEibzfsLYXwYjcGJLtpx=BQFJ-+HfvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] libbpf: improve handling of unresolved kfuncs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
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

On Tue, Apr 18, 2023 at 11:14=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 18, 2023 at 11:10=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Apr 17, 2023 at 6:10=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Apr 17, 2023 at 5:22=E2=80=AFPM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> > > >                                 insn[0].imm =3D ext->ksym.kernel_bt=
f_id;
> > > >                                 insn[0].off =3D ext->ksym.btf_fd_id=
x;
> > > > -                       } else { /* unresolved weak kfunc */
> > > > -                               insn[0].imm =3D 0;
> > > > -                               insn[0].off =3D 0;
> > > > +                       } else { /* unresolved weak kfunc call */
> > > > +                               poison_kfunc_call(prog, i, relo->in=
sn_idx, insn,
> > > > +                                                 relo->ext_idx, ex=
t);
> > >
> > > With that done should we remove:
> > >     /* skip for now, but return error when we find this in fixup_kfun=
c_call */
> > >     if (!insn->imm)
> > >           return 0;
> > > in check_kfunc_call()...
> > >
> > > and  if (!func_id && !offset) in add_kfunc_call() ?
> > >
> > > That was added in commit a5d827275241 ("bpf: Be conservative while
> > > processing invalid kfunc calls")
> >
> > I guess?.. I don't know if there was any other situation that this fix
> > was handling, but if it's only due to unresolved kfuncs by libbpf,
> > then yep.
>
> It was specifically to support weak kfunc with imm=3D=3D0 off=3D=3D0.
> With libbpf doing poisoning and converting call kfunc into call
> unknown helper that code is no longer needed.
> The question is whether we should try to support new kernel plus old
> libbpf combination.

Let's drop this kernel-side kludge. I don't believe anyone is actively
using __weak kfuncs yet, so it doesn't seem like it will hurt anyone.
But let's do it in a follow up if the series is good to go as is.
