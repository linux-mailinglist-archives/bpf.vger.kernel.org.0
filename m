Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376B46E1686
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 23:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDMVh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 17:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDMVh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 17:37:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF0D9C
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 14:37:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dm2so40965642ejc.8
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681421875; x=1684013875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj3dld3r3J9JW4SBKyI0aq1bjTtjvtJi6goyMW70aA8=;
        b=EfwgITZYKm6hzHpIqQWmWDpST5s/7AIJ3bI8jmWyflMc/eWgrYNzptFhHglEjC8sfS
         t8FJHTru6hWJzcW0KIuBw7h1bYIIbEyytTI65ZLsqU6SZ8pHHC/XApojFL63fHTir0k2
         prJR8TfMBDQ9NaiyLvlAc63ONNgFDDOaO5OBVHU3A8uDEr6qj09o8AdPPWeK8NehRld/
         rKQW4xfnqWSpecS69s1wZcumOklJhKOD0x5uuMZToGd9R69oXiypVs/ttTxZC/zTvprN
         DCTlCQiLJ76iNwKdK0f91uFgjB7RddRdGGHsKeNiqWTBFGWVc1Xp2RMDXhNDZbxuPofv
         Xn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681421875; x=1684013875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj3dld3r3J9JW4SBKyI0aq1bjTtjvtJi6goyMW70aA8=;
        b=IIDQGl079v/iIvFy90aKnCEsHUfCeBX9SYx8GUqbVskItZKrOM5PyHqdYTs+OI1Vif
         78iPkOhc1OlGllfWTLlTFMKt5iXYOu9lyEWWdEM8t+UPAcMn7UySNwX7PkzUulfkiCSV
         4jv754dxXN2oNCZmm/Ag4/V8GtXwFCYjtNx+zctwiHmERw3NGueZjnrSn69AHedRqt3L
         Zsd278+OIC0xabGevxWC2Ma0jf2wSw1QHRM4NpAvEzkUYQbPe+AKo5bi/CXlecFXXDRG
         HSGGyYZKKdPQ4vYkmIzqsQKd239x1PEpGw2iobkVS0ZRnQJm0F0USmDCiDnb4Jjc7EEf
         mshg==
X-Gm-Message-State: AAQBX9cXeTD5bFIXRWB2kUtlcAu9+pqpwvL/ka0Mg/3DCbYhqrrXjoFk
        jD0bvbAEs5xPxrHQzvLjcybz9oT8cvQUL6YJrromCiEmzeI=
X-Google-Smtp-Source: AKy350ZVJziUWb43rO/0zMi3wxhdxcp+8HKNBTbuZKcxF1hpx1CWcpcCeHORPl1Xk0MU57alU+e35mqtkTCSdFHoJ5Y=
X-Received: by 2002:a17:906:8597:b0:94e:d1d9:a59c with SMTP id
 v23-20020a170906859700b0094ed1d9a59cmr545884ejx.13.1681421874985; Thu, 13 Apr
 2023 14:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQdkDvyUu2ZDDdRmb4YhDzB96hS1NPW=ju=_Y_C+6nyA6xVGw@mail.gmail.com>
 <CAEf4BzbauKucsr-e4GigvrdYy2S9XNQQ6YW0xZ3ocJVcGpR7Ow@mail.gmail.com>
 <CAGQdkDsBb=M+MD=B_MBCt4E0MpnP15Ls7Xja_Ow-5bvUCqe-AQ@mail.gmail.com> <CAEf4Bzbz+oziNGqNbX8MqoHqx+WZnsq9-Q7R9ESqhwjtikCk8g@mail.gmail.com>
In-Reply-To: <CAEf4Bzbz+oziNGqNbX8MqoHqx+WZnsq9-Q7R9ESqhwjtikCk8g@mail.gmail.com>
From:   andrea terzolo <andreaterzolo3@gmail.com>
Date:   Thu, 13 Apr 2023 23:37:43 +0200
Message-ID: <CAGQdkDvugsTbN-N6YkvZT5yb2CdicJu8tSEByVPFHnXZyO9jKw@mail.gmail.com>
Subject: Re: [QUESTION] usage of libbpf_probe_bpf_prog_type API
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 12 Apr 2023 at 20:48, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Sat, Apr 8, 2023 at 6:34=E2=80=AFAM andrea terzolo <andreaterzolo3@gma=
il.com> wrote:
> >
> > Il giorno mer 5 apr 2023 alle ore 00:32 Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> ha scritto:
> > >
> > > On Thu, Mar 30, 2023 at 10:21=E2=80=AFAM andrea terzolo
> > > <andreaterzolo3@gmail.com> wrote:
> > > >
> > > > Hi all!
> > > >
> > > > If I can I would like to ask one question about the
> > > > `libbpf_probe_bpf_prog_type` API. The idea is to use `fentry/fexit`
> > > > bpf progs only if they are available and fall back to simple `kprob=
es`
> > > > when they are not. Is there a way to probe `BPF_TRACE_FENTRY` suppo=
rt
> > > > with `libbpf` APIs? I was looking at `libbpf_probe_bpf_prog_type` A=
PI
> > > > but it seems to check the `prog_type` rather than the `attach_type`=
,
> > > > when I call it `libbpf_probe_bpf_prog_type(BPF_PROG_TYPE_TRACING,
> > > > NULL);` it returns `1` even if `fentry/fexit` progs are not support=
ed
> > > > on my machine. Is there a way to probe this feature with other
> > > > `libbpf` APIs?
> > > >
> > >
> > > looking at libbpf probing code, for BPF_PROG_TYPE_TRACING we choose
> > > BPF_TRACE_FENTRY attach type automatically (because it doesn't really
> > > matter whether its BPF_TRACE_FEXIT or BPF_MODIFY_RETURN, they all are
> > > either supported or none is). We then expect that verifier will
> > > complain with "attach_btf_id 1 is not a function" error. If we do see
> > > that error, we know that verifier supports fentry/fexit programs *in
> > > principle*, which is what we are checking with
> > > libbpf_probe_bpf_prog_type().
> >
> > Ok got it, thank you. My issue is that in my project I need to use
> > BPF_TRACE_RAW_TP programs that AFAIK don't require the support for bpf
> > trampoline, so they could be supported even if
> > BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are not supported. This is what
> > happens on arm64 kernels where we have BPF_TRACE_RAW_TP but
> > BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are still not supported... Right
> > now I'm using libbpf_probe_bpf_prog_type() to check the support for
> > BPF_TRACE_RAW_TP but this is just an approximation, probably the best
> > way to do that is to inject a small
> > BPF_TRACE_RAW_TP prog and check that it is correctly loaded. It seems
> > that libbpf doesn't provide APIs to do that, is it right?
>
> BPF_TRACE_RAW_TP is not a program type, so not sure what you are checking=
.
>
> fentry/fexit is BPF_PROG_TYPE_TRACING, while raw tracepoint is
> BPF_PROG_TYPE_RAW_TRACEPOINT, there shouldn't be any problem for you.

If I understood correctly BPF_PROG_TYPE_TRACING has several attach types:
* BPF_MODIFY_RETURN
* BPF_TRACE_FENTRY
* BPF_TRACE_FEXIT
* BPF_TRACE_ITER
* BPF_TRACE_RAW_TP

I'm using the last one so BPF_TRACE_RAW_TP ('tp_btf' elf section
name). libbpf_probe_bpf_prog_type API allows checking the support for
a specific prog_type like BPF_PROG_TYPE_TRACING but indeed I need a
check on the attach_type support. BPF_TRACE_FENTRY/FEXIT have
different requirements with respect to BPF_TRACE_RAW_TP so I would
like to know if libbpf provides out-of-the-box an API to check the
attach_type support. libbpf_probe_bpf_prog_type doesn't tell if
BPF_TRACE_FENTRY/FEXIT are effectively supported it just tells if
BPF_PROG_TYPE_TRACING is supported, so I was just asking what is the
best way to probe the support for a specific attach_type

>
> >
> > > If kernel doesn't support fentry/fexit attachment for some specific
> > > function you'd like to attach to, that's a different matter. This
> > > would be equivalent to BPF_PROG_TYPE_KPROBE check -- we check if
> > > kprobes in general are supported, but not whether kprobing specific
> > > kernel function works.
> > >
> > > I assume by "not supported on my machine" you mean that you can't
> > > attach fentry/fexit to some function? If not, let me know, and we'd
> > > have to debug this further.
> >
> > Sorry, probably I was not so clear, with this statement I mean that
> > libbpf_probe_bpf_prog_type() returns 1 even if BPF_TRACE_FENTRY progs
> > cannot be attached into the kernel. [0] is an example of what I'm
> > doing.
> > 1. Check fentry support with libbpf_probe_bpf_prog_type
> > 2. Check fentry support with an approach similar to libbpf-tools (as
> > you suggested)
> > 3. Try to inject my real BPF programs.
> >
> > (2) (libbpf-tool check) is correctly able to detect that
> > BPF_TRACE_FENTRY progs are not supported, when we call
> > `bpf_raw_tracepoint_open` to attach the fentry prog, `524` is returned
> > so we understand that this program is not supported. On the other
> > side, (1) is not able to detect that programs are not supported, the
> > API returns `1` as if they were supported. Now I have to highlight
> > that this API is called libbpf_probe_bpf_prog_type and not
> > libbpf_probe_bpf_attach_type, so 1 could be the right return value
> > since BPF_PROG_TYPE_TRACING progs are effectively supported, for
> > example, attach_type  BPF_TRACE_RAW_TP is supported, but some other
> > attach types like BPF_TRACE_FENTRY/BPF_MODIFY_RETURN  are not. If this
> > API just checks for BPF_PROG_TYPE_TRACING support, probably the best
> > way I have to check if a specific attach type is supported is to
> > directly inject a small prog of this type, as libbpf-tool does. WDYT?
>
> Could it be that you are mixing up enum bpf_prog_type with enum
> bpf_attach_type when calling libbpf_probe_bpf_prog_type()?
>
> >
> > [0]: https://github.com/Andreagit97/BPF-perf-tests/blob/main/templates/=
fentry_attach.c
> >
> > > If you want to know if some function can be traced with fentry/fexit,
> > > check below helper function from libbpf-tools ([0])
> > >
> > > bool fentry_can_attach(const char *name, const char *mod)
> > >
> > >
> > >   [0] https://github.com/iovisor/bcc/blob/master/libbpf-tools/trace_h=
elpers.c#LL1043-L1043C58
> > >
> > Thank you for the pointer!
> > >
> > > > Thank you in advance for your time,
> > > > Andrea
