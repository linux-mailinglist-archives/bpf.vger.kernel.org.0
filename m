Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43CE1D3E28
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 21:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgENT5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 15:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727117AbgENT5m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 15:57:42 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E221C061A0C
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 12:57:41 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so3695097lff.9
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GT107zmb6LScirGxpjcgGDglMfuaggGQO02FCZ3vJ+c=;
        b=gwDMgDQmd+22wZAfLR0Ef1R+CgntMh+I4A5c91LNwerqdIGTIllyBn/PqW6K1SDaTL
         IN5quujamfq7Py/YfmZk//x9hYReJCpd4thSTLvlgLeLFqxpmFV4IPIc29TgGLqvJrAc
         FEhoIqFlYmfDSWJm4hSJq6k/c5cw8JFS4YXv8YzAh1xwh6+y6p9gYp0+Tz1V7w1PuvXv
         V7UxhdgFEtJ4aqRQGbAtwfScgv9wsH2ikY0INHB+4n/znNxg7FSv9c47BlhnbnsAySPM
         331NA0sVxY4ouG8+pi7XS9OpL8PvvVFxPBu0ZgAChEUax2tAe2gvEKAP+4ez2PoKpAeR
         a5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GT107zmb6LScirGxpjcgGDglMfuaggGQO02FCZ3vJ+c=;
        b=Xus5yzvJzzxmw3rAWTU/n5Nm34/qn/gEO1C+STH8F6XZewSpDbPUAr5WmHJSscvrAm
         Qg1xWX9PGXe0vsNtOtS7GVc7BilrA8bdMjuSTHmNOWltqIyzX1zoljnz4tqEPCOjIZ+E
         ldwLIFsXiTxhyCoV/OkBdIIRorvvvvmhTIwtwTOWLEK4xybnsSspDNjPvC/RCbk1Bwiz
         IvDvtonl4vbVNwYuONYicYdw9e9TGXFkemap/RawIRyDVYj4JzD+lC7QAh2tctXN8QzS
         w/ctn8tGjI7A2ymdBRLceZM6QJqGCs7tgbkDOI1JN0EVPlu0O8kb4aVOkQKeGe9H3fhY
         TFwg==
X-Gm-Message-State: AOAM533VmwEk/6SdprVZbU7C3fMUhvpNeu5a6v0/7L227UxbTN73NDHV
        rFlfgtO5JrurZzhpsOpJSZv+ttqPonodbApX4DPx7g==
X-Google-Smtp-Source: ABdhPJz/cCjP5CgixkowWBXknDKgmnBD9dbSKboqzqvNMK/9H5N1qEmhByEiqjx1ZSaPYTbeYh9d7Jb2Q2AasX+JLhk=
X-Received: by 2002:ac2:58d7:: with SMTP id u23mr4210285lfo.119.1589486260021;
 Thu, 14 May 2020 12:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200514053205.1298315-1-yhs@fb.com> <20200514053206.1298415-1-yhs@fb.com>
 <CAEf4Bzbks=ti1OuXg3d_Nc0Vm5cvv-ceLB+Dq8OZgHdBT+SA1Q@mail.gmail.com> <f2fcdf89-41d6-04c0-cb6c-1702aff48ad8@fb.com>
In-Reply-To: <f2fcdf89-41d6-04c0-cb6c-1702aff48ad8@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 May 2020 12:57:28 -0700
Message-ID: <CAADnVQLH_NNX41cCnHC1JYiYpitHey0DJeMF_5RW96XdUi1oXw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: enforce returning 0 for fentry/fexit progs
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 14, 2020 at 8:01 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/13/20 11:14 PM, Andrii Nakryiko wrote:
> > On Wed, May 13, 2020 at 10:32 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Currently, tracing/fentry and tracing/fexit prog
> >> return values are not enforced. In trampoline codes,
> >> the fentry/fexit prog return values are ignored.
> >> Let us enforce it to be 0 to avoid confusion and
> >> allows potential future extension.
> >>
> >> This patch also explicitly added return value
> >> checking for tracing/raw_tp, tracing/fmod_ret,
> >> and freplace programs such that these program
> >> return values can be anything. The purpose are
> >> two folds:
> >>   1. to make it explicit about return value expectations
> >>      for these programs in verifier.
> >>   2. for tracing prog_type, if a future attach type
> >>      is added, the default is -ENOTSUPP which will
> >>      enforce to specify return value ranges explicitly.
> >>
> >> Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >
> > Looks good, except a nit below.
> >
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> >
> > [...]
> >
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index fa1d8245b925..2d80cce0a28a 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -7059,6 +7059,24 @@ static int check_return_code(struct bpf_verifier_env *env)
> >>                          return 0;
> >>                  range = tnum_const(0);
> >>                  break;
> >> +       case BPF_PROG_TYPE_TRACING:
> >> +               switch ((env->prog->expected_attach_type)) {
> >
> > nit: extra pair of ()?
>
> Sorry about this. Not sure whether it is worthwhile to send another
> revision. Please let me know if another revision is needed.

Applied to bpf tree with that typo fixed. Thanks
