Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EED6DA1D5
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 21:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjDFTqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbjDFTql (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 15:46:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF234E50
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 12:46:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-93071b2952bso136758166b.3
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680810397; x=1683402397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+F24XRZzkKtOQHseq0iSpJ/p5a/ykKR8Abh8+MT2Jow=;
        b=Fd3O3g9HIrTy2VPzvO9R76FL04NwxlB2AFbP+CZzai6XGWIJh8dlngcpyyTkqQ8YHp
         hL0NjjKvoCFOi81MWlTJXz/r/pWL4Tyx+ie261aCR30EZoxzOaPQzk0uGoArTkl/5MSV
         /YEpEAOcqiaLnNaNxOyJQgxIt4t6J9Jp/CYoJh87FVbCJSAd8L26PrE4dt1BwW8+Y4P8
         j2Zco+TXdy1dlY2eZif16vqMhMd4h3mcp20wB/PxzUfzaoB5KI48/R2awoWKghTP9gP1
         Ah+znmKsAX4Xxitfje0S2TQk5SddqK+B28j5XzEQ4IVxJkJZt4KTzHuGt+V+hKmF+hLY
         17cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680810397; x=1683402397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+F24XRZzkKtOQHseq0iSpJ/p5a/ykKR8Abh8+MT2Jow=;
        b=00Z0631m+exbeHuYZQP+yfCcNzYbugnLyax3T0XBLYUBZ7xFdt89QruRQq74RHhn9b
         atfDEdCKyS6mZ3vf4JSIqTJy/wZQj2+A0Eni4O8HhPKVSSQhX6Yu7+orinZlqedI1TcW
         jhB3Yvn9UJKaWMbdqi0pS1WMW+W/CSxTn+AKQNhIJc0go3vQhugLvSWd3oiRj3cDnmBP
         SVnBYVn3+6Z5q1zLCumFu6UMVPAQR5OMLD+Ve+e631aXbo+pJZjrzu2nvkrKrQ2Sj/Xu
         XSfU4HUwNSzcZTxvxAdOB3hIWC7BpjpbHHoQhbIO8KN+23ClvIzlt6Ff1Su68JDrcTBZ
         h+2w==
X-Gm-Message-State: AAQBX9e4mGCZ+PU08zmOqIlU6xSaLsOsEISsQDrvx601l45pZs36sIbd
        105gablxNzbZOAK/bk7hEoidM+GSfezic+pIYp8=
X-Google-Smtp-Source: AKy350YqeCcOdxvhcDNk/mQt65uClGPsZSKTo6dDhC6+WAzIMkU5n/pbML6OqiVROlWeHixDVN8r/ry1ICYHldbtWq0=
X-Received: by 2002:a50:d6da:0:b0:502:148d:9e1e with SMTP id
 l26-20020a50d6da000000b00502148d9e1emr346414edj.3.1680810396724; Thu, 06 Apr
 2023 12:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-15-andrii@kernel.org>
 <CAN+4W8hdeEVb=Rs-T+E7QtF++fKYObjb--KmCqqOFg8gL+kocQ@mail.gmail.com>
 <CAEf4Bzbv25n_d3-aCgLMNTu0ZwF2J4srp02QMj0Hs3gh-sGobA@mail.gmail.com>
 <CAN+4W8hFPwekddJ3TKxy3usdSXA-utYpFsqUVduR4ny=qQX+yg@mail.gmail.com> <CAEf4BzaJTCNZFx_H3GhDmhR7peWTjray+w4V9mNKNR1_L0v8BQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaJTCNZFx_H3GhDmhR7peWTjray+w4V9mNKNR1_L0v8BQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Apr 2023 12:46:25 -0700
Message-ID: <CAADnVQLoNky_OULJgyzsB1aFY+zFPpJrYRC6gRDZxfMarzhaxw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 14/19] bpf: relax log_buf NULL conditions when
 log_level>0 is requested
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Thu, Apr 6, 2023 at 11:43=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 6, 2023 at 9:15=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> w=
rote:
> >
> > On Wed, Apr 5, 2023 at 6:44=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:>
> > > We could and I thought about this, but verifier logging is quite an
> > > expensive operation due to all the extra formatting and reporting, so
> > > it's not advised to have log_level=3D1 permanently enabled for
> > > production BPF program loading.
> >
> > Any idea how expensive this is?
> >
>
> It will depend on the specific program, of course. But just to
> estimate, here's pyperf100 selftests with log_level=3D1 and log_level=3D4
> (just stats, basically free).
>
> [vmuser@archvm bpf]$ time sudo ./veristat pyperf100.bpf.o -v >/dev/null
>
> real    0m1.761s
> user    0m0.008s
> sys     0m1.743s
> [vmuser@archvm bpf]$ time sudo ./veristat pyperf100.bpf.o >/dev/null
>
> real    0m0.869s
> user    0m0.009s
> sys     0m0.846s
>
> 2x difference. So I'd definitely not recommend running with
> log_level=3D1 by default.
>
> > > Note that even if log_buf=3D=3DNULL when log_level>0 we'd be
> > > doing printf()-ing everything, which is the expensive part. So do you
> > > really want to add all this extra overhead *constantly* to all
> > > production BPF programs?
> >
> > No, I'm just going off of what UAPI I would like to use. Keeping
> > semantics as they are is fine if it's too slow. We could always use a
> > small-ish buffer for the first retry and hope things fit.
>
> It's easy for me to implement it either way, Alexei and Daniel, any
> thoughts on this?

I like this part of the idea:

> Is it possible to change it so that log_buf =3D=3D NULL && log_size =3D=
=3D 0
> && log_level > 0 only fills in log_size_actual and doesn't return
> ENOSPC? Otherwise we can't do oneshot loading.
>  if PROG_LOAD(buf=3DNULL, size=3D0, level=3D1) >=3D 0:
>    return fd
>  else
>    retry PROG_LOAD(buf!=3DNULL, size=3Dlog_size_actual, level=3D1)

libbpf shouldn't be doing it by default, since load time matters,
but it could be useful in other scenarios.
Like central bpf loading daemon can use (buf=3DNULL, size=3D0, level=3D(1 |=
 4))
every 100th prog_load as part of stats collection.
veristat can do it by default.

log_true_size should more or less align with verified_insns uapi number,
but still interesting to see and track over time.
