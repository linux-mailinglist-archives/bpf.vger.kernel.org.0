Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDE56DA256
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDFUKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 16:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDFUKb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 16:10:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C7C9B
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 13:10:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g18so4109190ejx.7
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680811828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r37JApaSbAXGk90moymoaBbG16PqeLkTyY+IhuquG2E=;
        b=HE+xZwSYqk46cjwwz5im+3I3ghYSjtwmmMtBBwHbaIVsBNMgB9uwtwCUTjC8TXhkwx
         P5aNBCWwC73NyhaB9oFS+I20If5vakwi3ShHLN/wtqy6OicnR+BBZcftmwnIUGdLTqOv
         HltprFPckHe9YAbfNB8ORq5J4qwS6IPQX7wrXC8KVO5t6dVph2+SgDZzeeC93dUtpzOf
         M6+HDi2mUDpr1zIdL7is56/2zy7M8MaT+Zvqf9ei1oBc+oc6D+D+bz5u1xBQ9VVCwMLK
         lmQSBpsJWfpLZtq6/a4HEqHurhkZxk1rBuH3Tg/KoqnEoAbViIwOaMzYCyHMDJrRU6PX
         QmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r37JApaSbAXGk90moymoaBbG16PqeLkTyY+IhuquG2E=;
        b=norKCtSh//aEB1E07YPHgsFEhU32oESEWgQVYlYWo/LToDyOV0vbiNjkJUBYdQVAVJ
         8CtVUQSgGUmTIVbuUFkNaKM2bBVU1miEXELDbv+qunWOBPzGhw+UpHI/tkVJz+/89jiA
         TxVUWhLLM1EIumz5MnuO5dB2ZFom2X5xoRQz7tEXfkWZ1zLJd1RNHEANHBHGlUdtEBgJ
         DMSkW/2M/syc5KK+2Lw3fhhpPBtY8/bJ+dnf/yWCuz/Q67dES89lg9C3OiUxidd022vK
         mNuIMRsAiBpAVXcKnhVMt9cANibsXV4DgqBlBUdrcEkVhbXW+QP2RprG7TGPFhYd0jbN
         aZHg==
X-Gm-Message-State: AAQBX9dh6du0WZ/I9697K0XYMRfe5xta7xbvWaXppV4rxBrLvWEED+1j
        4x8Bo08vZRupQPUhxBbomSZQmZ3C6b9ByFAVeUI=
X-Google-Smtp-Source: AKy350bgBiYHcRoDKXzkTC1bl/XCPuPYdC+1GoCjPGxqTSkrq8qsMJ0wxT/yHdJZqs93Sp+IJ5l/omzVws7h8DQm3Do=
X-Received: by 2002:a17:907:7638:b0:931:ce20:db96 with SMTP id
 jy24-20020a170907763800b00931ce20db96mr48276ejc.5.1680811827863; Thu, 06 Apr
 2023 13:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-15-andrii@kernel.org>
 <CAN+4W8hdeEVb=Rs-T+E7QtF++fKYObjb--KmCqqOFg8gL+kocQ@mail.gmail.com>
 <CAEf4Bzbv25n_d3-aCgLMNTu0ZwF2J4srp02QMj0Hs3gh-sGobA@mail.gmail.com>
 <CAN+4W8hFPwekddJ3TKxy3usdSXA-utYpFsqUVduR4ny=qQX+yg@mail.gmail.com>
 <CAEf4BzaJTCNZFx_H3GhDmhR7peWTjray+w4V9mNKNR1_L0v8BQ@mail.gmail.com> <CAADnVQLoNky_OULJgyzsB1aFY+zFPpJrYRC6gRDZxfMarzhaxw@mail.gmail.com>
In-Reply-To: <CAADnVQLoNky_OULJgyzsB1aFY+zFPpJrYRC6gRDZxfMarzhaxw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 13:10:15 -0700
Message-ID: <CAEf4BzaJFwCh_E+Vg-_fWfKg+uQkQ7qBG_gvoEovUaF+uhyk0Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 14/19] bpf: relax log_buf NULL conditions when
 log_level>0 is requested
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenz Bauer <lmb@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Timo Beckers <timo@incline.eu>, robin.goegge@isovalent.com,
        Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 12:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 6, 2023 at 11:43=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 6, 2023 at 9:15=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com>=
 wrote:
> > >
> > > On Wed, Apr 5, 2023 at 6:44=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:>
> > > > We could and I thought about this, but verifier logging is quite an
> > > > expensive operation due to all the extra formatting and reporting, =
so
> > > > it's not advised to have log_level=3D1 permanently enabled for
> > > > production BPF program loading.
> > >
> > > Any idea how expensive this is?
> > >
> >
> > It will depend on the specific program, of course. But just to
> > estimate, here's pyperf100 selftests with log_level=3D1 and log_level=
=3D4
> > (just stats, basically free).
> >
> > [vmuser@archvm bpf]$ time sudo ./veristat pyperf100.bpf.o -v >/dev/null
> >
> > real    0m1.761s
> > user    0m0.008s
> > sys     0m1.743s
> > [vmuser@archvm bpf]$ time sudo ./veristat pyperf100.bpf.o >/dev/null
> >
> > real    0m0.869s
> > user    0m0.009s
> > sys     0m0.846s
> >
> > 2x difference. So I'd definitely not recommend running with
> > log_level=3D1 by default.
> >
> > > > Note that even if log_buf=3D=3DNULL when log_level>0 we'd be
> > > > doing printf()-ing everything, which is the expensive part. So do y=
ou
> > > > really want to add all this extra overhead *constantly* to all
> > > > production BPF programs?
> > >
> > > No, I'm just going off of what UAPI I would like to use. Keeping
> > > semantics as they are is fine if it's too slow. We could always use a
> > > small-ish buffer for the first retry and hope things fit.
> >
> > It's easy for me to implement it either way, Alexei and Daniel, any
> > thoughts on this?
>
> I like this part of the idea:
>
> > Is it possible to change it so that log_buf =3D=3D NULL && log_size =3D=
=3D 0
> > && log_level > 0 only fills in log_size_actual and doesn't return
> > ENOSPC? Otherwise we can't do oneshot loading.
> >  if PROG_LOAD(buf=3DNULL, size=3D0, level=3D1) >=3D 0:
> >    return fd
> >  else
> >    retry PROG_LOAD(buf!=3DNULL, size=3Dlog_size_actual, level=3D1)
>
> libbpf shouldn't be doing it by default, since load time matters,
> but it could be useful in other scenarios.
> Like central bpf loading daemon can use (buf=3DNULL, size=3D0, level=3D(1=
 | 4))
> every 100th prog_load as part of stats collection.
> veristat can do it by default.

makes sense, then no -ENOSPC for log_buf=3D=3DNULL, will do in next version

>
> log_true_size should more or less align with verified_insns uapi number,
> but still interesting to see and track over time.
