Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA36E5563
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjDQXsy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjDQXsw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:48:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A972D4C
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:48:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ud9so68437419ejc.7
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681775329; x=1684367329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P9+rpv+0a5xRFyYhQQ/x5RJ2SPZ9JSm8YL6yaHLbRs=;
        b=sGzLDVXyWVTK0/2OVIO0g8eiqaVUt52EAsUDMOkw/El/T0H2hCVkVc3PkodRED88D5
         CRa/dfpGT5lHqK6DoXV+HYiNLKl5XTibA30VxfIq/ezQVLM8lZE6O1PC/aQIpx+raQqH
         X7nf0zQb8lemmPhZNIWTq5rB8r7iwy8E/IDSINSKAC2D95qnUnLIrUX5BwEJynOrK7hf
         QqBFU9/mMayld77QfQpEnRXYa6G4kX2fdXVtmLQ5LPXhai7gzGWsOzI9jLXZO+P+EhHQ
         bHgHdyJ4vTglm1vr1Atga8LkyJMR2IVQXOHljP8aFF0fiiKhuI0eZtdghYOAt8s520pp
         S3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681775329; x=1684367329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P9+rpv+0a5xRFyYhQQ/x5RJ2SPZ9JSm8YL6yaHLbRs=;
        b=LkrwGg4ZzNmHIdUNW4Vl1lFLetvz/qURM3ZYheDv2MQWyVRNphAfAFavobPdq3youN
         s1aefV/uOOjt0WGEyAElJIeIu6xULFpYQNIsaMSMDa2YiFbiJgDis18o7CJqOncwTlr/
         t3Ispbm7drH9DVndp3F4HVwdA5tC70tFZU3TXdG8vFEPa7ZyvHwO0ZMajLoEKkwRuWfm
         nxUyewhUDH6+dd4YIB1xNSe6pTcRQlIN8reOjfQ15PGrZxctawV57TT+g2cP8K2cWQJY
         4JnU4x5z0jXgauKIYcBQp8eY1jq8Mv232KXLwnP9EIV0e7oJq2oS7d909GKK2iXSs5eN
         kytQ==
X-Gm-Message-State: AAQBX9eFc4RRepsaRpwaPEWvnEHbGerlSA0RuDGsXTdPUXScxunCWSjc
        3CoVujWQKjjgnzxXLQg627+Gk4iZtL/0ta3jVgRDfl5B
X-Google-Smtp-Source: AKy350YVPQNVsVimsPNfVsylrmzCMy57Q+m9FCtTn6pmmWbsYDJzzSrFkhA4hD9WYC1S19OD3hEmx87nJ1q7NR869T4=
X-Received: by 2002:a17:906:3b88:b0:94e:c0fe:415a with SMTP id
 u8-20020a1709063b8800b0094ec0fe415amr4400431ejf.5.1681775329011; Mon, 17 Apr
 2023 16:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQdkDvyUu2ZDDdRmb4YhDzB96hS1NPW=ju=_Y_C+6nyA6xVGw@mail.gmail.com>
 <CAEf4BzbauKucsr-e4GigvrdYy2S9XNQQ6YW0xZ3ocJVcGpR7Ow@mail.gmail.com>
 <CAGQdkDsBb=M+MD=B_MBCt4E0MpnP15Ls7Xja_Ow-5bvUCqe-AQ@mail.gmail.com>
 <CAEf4Bzbz+oziNGqNbX8MqoHqx+WZnsq9-Q7R9ESqhwjtikCk8g@mail.gmail.com> <CAGQdkDvugsTbN-N6YkvZT5yb2CdicJu8tSEByVPFHnXZyO9jKw@mail.gmail.com>
In-Reply-To: <CAGQdkDvugsTbN-N6YkvZT5yb2CdicJu8tSEByVPFHnXZyO9jKw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 16:48:37 -0700
Message-ID: <CAEf4BzaYowLwQs1UkcprUJy8W1Bt8ducOKEjt5K4EUwsNqeOtA@mail.gmail.com>
Subject: Re: [QUESTION] usage of libbpf_probe_bpf_prog_type API
To:     andrea terzolo <andreaterzolo3@gmail.com>
Cc:     bpf@vger.kernel.org
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

On Thu, Apr 13, 2023 at 2:37=E2=80=AFPM andrea terzolo <andreaterzolo3@gmai=
l.com> wrote:
>
> On Wed, 12 Apr 2023 at 20:48, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Sat, Apr 8, 2023 at 6:34=E2=80=AFAM andrea terzolo <andreaterzolo3@g=
mail.com> wrote:
> > >
> > > Il giorno mer 5 apr 2023 alle ore 00:32 Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> ha scritto:
> > > >
> > > > On Thu, Mar 30, 2023 at 10:21=E2=80=AFAM andrea terzolo
> > > > <andreaterzolo3@gmail.com> wrote:
> > > > >
> > > > > Hi all!
> > > > >
> > > > > If I can I would like to ask one question about the
> > > > > `libbpf_probe_bpf_prog_type` API. The idea is to use `fentry/fexi=
t`
> > > > > bpf progs only if they are available and fall back to simple `kpr=
obes`
> > > > > when they are not. Is there a way to probe `BPF_TRACE_FENTRY` sup=
port
> > > > > with `libbpf` APIs? I was looking at `libbpf_probe_bpf_prog_type`=
 API
> > > > > but it seems to check the `prog_type` rather than the `attach_typ=
e`,
> > > > > when I call it `libbpf_probe_bpf_prog_type(BPF_PROG_TYPE_TRACING,
> > > > > NULL);` it returns `1` even if `fentry/fexit` progs are not suppo=
rted
> > > > > on my machine. Is there a way to probe this feature with other
> > > > > `libbpf` APIs?
> > > > >
> > > >
> > > > looking at libbpf probing code, for BPF_PROG_TYPE_TRACING we choose
> > > > BPF_TRACE_FENTRY attach type automatically (because it doesn't real=
ly
> > > > matter whether its BPF_TRACE_FEXIT or BPF_MODIFY_RETURN, they all a=
re
> > > > either supported or none is). We then expect that verifier will
> > > > complain with "attach_btf_id 1 is not a function" error. If we do s=
ee
> > > > that error, we know that verifier supports fentry/fexit programs *i=
n
> > > > principle*, which is what we are checking with
> > > > libbpf_probe_bpf_prog_type().
> > >
> > > Ok got it, thank you. My issue is that in my project I need to use
> > > BPF_TRACE_RAW_TP programs that AFAIK don't require the support for bp=
f
> > > trampoline, so they could be supported even if
> > > BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are not supported. This is what
> > > happens on arm64 kernels where we have BPF_TRACE_RAW_TP but
> > > BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are still not supported... Right
> > > now I'm using libbpf_probe_bpf_prog_type() to check the support for
> > > BPF_TRACE_RAW_TP but this is just an approximation, probably the best
> > > way to do that is to inject a small
> > > BPF_TRACE_RAW_TP prog and check that it is correctly loaded. It seems
> > > that libbpf doesn't provide APIs to do that, is it right?
> >
> > BPF_TRACE_RAW_TP is not a program type, so not sure what you are checki=
ng.
> >
> > fentry/fexit is BPF_PROG_TYPE_TRACING, while raw tracepoint is
> > BPF_PROG_TYPE_RAW_TRACEPOINT, there shouldn't be any problem for you.
>
> If I understood correctly BPF_PROG_TYPE_TRACING has several attach types:
> * BPF_MODIFY_RETURN
> * BPF_TRACE_FENTRY
> * BPF_TRACE_FEXIT
> * BPF_TRACE_ITER
> * BPF_TRACE_RAW_TP
>
> I'm using the last one so BPF_TRACE_RAW_TP ('tp_btf' elf section

ah, so we were talking about BTF-aware raw tracepoint, sorry, I missed
that. Was thinking about plain raw tracepoint all along the way.

> name). libbpf_probe_bpf_prog_type API allows checking the support for
> a specific prog_type like BPF_PROG_TYPE_TRACING but indeed I need a
> check on the attach_type support. BPF_TRACE_FENTRY/FEXIT have
> different requirements with respect to BPF_TRACE_RAW_TP so I would
> like to know if libbpf provides out-of-the-box an API to check the
> attach_type support. libbpf_probe_bpf_prog_type doesn't tell if
> BPF_TRACE_FENTRY/FEXIT are effectively supported it just tells if
> BPF_PROG_TYPE_TRACING is supported, so I was just asking what is the
> best way to probe the support for a specific attach_type

ok, this sounds like a perfect use case to use that opts argument and
allow programs to optionally specify expected_attach_type. see
LIBBPF_OPTS, OPTS_GET and other cases of using `struct xxx_opts` in
libbpf code base.

Would you be interested in contributing such a patch?

>
> >
> > >
> > > > If kernel doesn't support fentry/fexit attachment for some specific
> > > > function you'd like to attach to, that's a different matter. This
> > > > would be equivalent to BPF_PROG_TYPE_KPROBE check -- we check if
> > > > kprobes in general are supported, but not whether kprobing specific
> > > > kernel function works.
> > > >
> > > > I assume by "not supported on my machine" you mean that you can't
> > > > attach fentry/fexit to some function? If not, let me know, and we'd
> > > > have to debug this further.
> > >
> > > Sorry, probably I was not so clear, with this statement I mean that
> > > libbpf_probe_bpf_prog_type() returns 1 even if BPF_TRACE_FENTRY progs
> > > cannot be attached into the kernel. [0] is an example of what I'm
> > > doing.
> > > 1. Check fentry support with libbpf_probe_bpf_prog_type
> > > 2. Check fentry support with an approach similar to libbpf-tools (as
> > > you suggested)
> > > 3. Try to inject my real BPF programs.
> > >
> > > (2) (libbpf-tool check) is correctly able to detect that
> > > BPF_TRACE_FENTRY progs are not supported, when we call
> > > `bpf_raw_tracepoint_open` to attach the fentry prog, `524` is returne=
d
> > > so we understand that this program is not supported. On the other
> > > side, (1) is not able to detect that programs are not supported, the
> > > API returns `1` as if they were supported. Now I have to highlight
> > > that this API is called libbpf_probe_bpf_prog_type and not
> > > libbpf_probe_bpf_attach_type, so 1 could be the right return value
> > > since BPF_PROG_TYPE_TRACING progs are effectively supported, for
> > > example, attach_type  BPF_TRACE_RAW_TP is supported, but some other
> > > attach types like BPF_TRACE_FENTRY/BPF_MODIFY_RETURN  are not. If thi=
s
> > > API just checks for BPF_PROG_TYPE_TRACING support, probably the best
> > > way I have to check if a specific attach type is supported is to
> > > directly inject a small prog of this type, as libbpf-tool does. WDYT?
> >
> > Could it be that you are mixing up enum bpf_prog_type with enum
> > bpf_attach_type when calling libbpf_probe_bpf_prog_type()?
> >
> > >
> > > [0]: https://github.com/Andreagit97/BPF-perf-tests/blob/main/template=
s/fentry_attach.c
> > >
> > > > If you want to know if some function can be traced with fentry/fexi=
t,
> > > > check below helper function from libbpf-tools ([0])
> > > >
> > > > bool fentry_can_attach(const char *name, const char *mod)
> > > >
> > > >
> > > >   [0] https://github.com/iovisor/bcc/blob/master/libbpf-tools/trace=
_helpers.c#LL1043-L1043C58
> > > >
> > > Thank you for the pointer!
> > > >
> > > > > Thank you in advance for your time,
> > > > > Andrea
