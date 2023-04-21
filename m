Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF926EAF36
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjDUQek (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjDUQej (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:34:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC54126
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:34:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-504eccc8fc8so2689396a12.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094876; x=1684686876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCkGPXypsbt8ntcTWt9EMcR27AUSN+LfBpyMiRUTUs8=;
        b=Dc4oprkOzMRqibOQzVl18bBVLcceJD5AaFaTCTGgoAqcOHd8Pol6E0K77o3Ow4oJWK
         J9FlGNUCtW+M5nf6MEhcXCywgskcOkcf9tL0O3QDa8MrW8zBiBL9YDyHMrWtgSr2Vlex
         5JmleiODulrdEIRtUR0XBcFGLOgy/n+82VXi88TpzKm9yGLvOM128uGJnX7wHQQq9XW4
         NWJB0E4pdY+c8KiL98dV2XQCJBdz+2WOBfHyxRhGCd1hYoRK94wfI60P5uf+XeNJkIFE
         O7vincBY8ru+snefBaMjvmsPnCPd3oABmoAoAbMGdq4f7s8YOq/TJMIeID5AO5s7KAg3
         U06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094876; x=1684686876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCkGPXypsbt8ntcTWt9EMcR27AUSN+LfBpyMiRUTUs8=;
        b=OrcHuto7ek2JV4PotsEwMkOfQnNLGrq21kPmwtN4Vnpdb00+iUHesNy6WcQeRB+iLW
         XZMkuczP2cZghoY8h69pL/do2d2ZVLTh0s/OPxAZpDtT699nSqy5dfvlJd9BoAVtGPwq
         sqZBKNOvQN33UvaCagATvaKifWitVsbwvfTxJOX/X8UlCaBI4OINjEOy+/UjJPpwYtf2
         W4ndPtCRuLo8GScWXEW20K/yTHYUrb2NFWzC56p7B6AwAh5L9GXeyEptFiZUuSkBqr/U
         mccpWTvw3hUIpljDrlzDol3q3y0kFhiBCf1veORhvx4PuoBY5U9s5UWXuBy9K5frelsK
         PBXg==
X-Gm-Message-State: AAQBX9eHK9l/kp02nOSVDIt1yQWKbIgrPGuEhqCDNHnVdv1VdGh4MqEl
        FrHWr7SJds0ki+/R2iZHqXixFqU4OTcholc/yl3hquybJys=
X-Google-Smtp-Source: AKy350b7HE03ChmVDTqd4RfgaGnOHARLN1W2RuTV+qLQXdyhgGIXvIaB0hHXV2ADFRpzyzOyk6P4MS8pXiZOCB5nwC4=
X-Received: by 2002:a05:6402:1849:b0:506:7d34:51d1 with SMTP id
 v9-20020a056402184900b005067d3451d1mr5763359edy.29.1682094876175; Fri, 21 Apr
 2023 09:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQdkDvyUu2ZDDdRmb4YhDzB96hS1NPW=ju=_Y_C+6nyA6xVGw@mail.gmail.com>
 <CAEf4BzbauKucsr-e4GigvrdYy2S9XNQQ6YW0xZ3ocJVcGpR7Ow@mail.gmail.com>
 <CAGQdkDsBb=M+MD=B_MBCt4E0MpnP15Ls7Xja_Ow-5bvUCqe-AQ@mail.gmail.com>
 <CAEf4Bzbz+oziNGqNbX8MqoHqx+WZnsq9-Q7R9ESqhwjtikCk8g@mail.gmail.com>
 <CAGQdkDvugsTbN-N6YkvZT5yb2CdicJu8tSEByVPFHnXZyO9jKw@mail.gmail.com> <CAEf4BzaYowLwQs1UkcprUJy8W1Bt8ducOKEjt5K4EUwsNqeOtA@mail.gmail.com>
In-Reply-To: <CAEf4BzaYowLwQs1UkcprUJy8W1Bt8ducOKEjt5K4EUwsNqeOtA@mail.gmail.com>
From:   andrea terzolo <andreaterzolo3@gmail.com>
Date:   Fri, 21 Apr 2023 18:34:24 +0200
Message-ID: <CAGQdkDsEqG9Lz+R33QgxHCdXVQ6Fu8in=5gKOjooQiPJsKcNBw@mail.gmail.com>
Subject: Re: [QUESTION] usage of libbpf_probe_bpf_prog_type API
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 18 Apr 2023 at 01:48, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Thu, Apr 13, 2023 at 2:37=E2=80=AFPM andrea terzolo <andreaterzolo3@gm=
ail.com> wrote:
> >
> > On Wed, 12 Apr 2023 at 20:48, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
> > >
> > > On Sat, Apr 8, 2023 at 6:34=E2=80=AFAM andrea terzolo <andreaterzolo3=
@gmail.com> wrote:
> > > >
> > > > Il giorno mer 5 apr 2023 alle ore 00:32 Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> ha scritto:
> > > > >
> > > > > On Thu, Mar 30, 2023 at 10:21=E2=80=AFAM andrea terzolo
> > > > > <andreaterzolo3@gmail.com> wrote:
> > > > > >
> > > > > > Hi all!
> > > > > >
> > > > > > If I can I would like to ask one question about the
> > > > > > `libbpf_probe_bpf_prog_type` API. The idea is to use `fentry/fe=
xit`
> > > > > > bpf progs only if they are available and fall back to simple `k=
probes`
> > > > > > when they are not. Is there a way to probe `BPF_TRACE_FENTRY` s=
upport
> > > > > > with `libbpf` APIs? I was looking at `libbpf_probe_bpf_prog_typ=
e` API
> > > > > > but it seems to check the `prog_type` rather than the `attach_t=
ype`,
> > > > > > when I call it `libbpf_probe_bpf_prog_type(BPF_PROG_TYPE_TRACIN=
G,
> > > > > > NULL);` it returns `1` even if `fentry/fexit` progs are not sup=
ported
> > > > > > on my machine. Is there a way to probe this feature with other
> > > > > > `libbpf` APIs?
> > > > > >
> > > > >
> > > > > looking at libbpf probing code, for BPF_PROG_TYPE_TRACING we choo=
se
> > > > > BPF_TRACE_FENTRY attach type automatically (because it doesn't re=
ally
> > > > > matter whether its BPF_TRACE_FEXIT or BPF_MODIFY_RETURN, they all=
 are
> > > > > either supported or none is). We then expect that verifier will
> > > > > complain with "attach_btf_id 1 is not a function" error. If we do=
 see
> > > > > that error, we know that verifier supports fentry/fexit programs =
*in
> > > > > principle*, which is what we are checking with
> > > > > libbpf_probe_bpf_prog_type().
> > > >
> > > > Ok got it, thank you. My issue is that in my project I need to use
> > > > BPF_TRACE_RAW_TP programs that AFAIK don't require the support for =
bpf
> > > > trampoline, so they could be supported even if
> > > > BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are not supported. This is what
> > > > happens on arm64 kernels where we have BPF_TRACE_RAW_TP but
> > > > BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are still not supported... Right
> > > > now I'm using libbpf_probe_bpf_prog_type() to check the support for
> > > > BPF_TRACE_RAW_TP but this is just an approximation, probably the be=
st
> > > > way to do that is to inject a small
> > > > BPF_TRACE_RAW_TP prog and check that it is correctly loaded. It see=
ms
> > > > that libbpf doesn't provide APIs to do that, is it right?
> > >
> > > BPF_TRACE_RAW_TP is not a program type, so not sure what you are chec=
king.
> > >
> > > fentry/fexit is BPF_PROG_TYPE_TRACING, while raw tracepoint is
> > > BPF_PROG_TYPE_RAW_TRACEPOINT, there shouldn't be any problem for you.
> >
> > If I understood correctly BPF_PROG_TYPE_TRACING has several attach type=
s:
> > * BPF_MODIFY_RETURN
> > * BPF_TRACE_FENTRY
> > * BPF_TRACE_FEXIT
> > * BPF_TRACE_ITER
> > * BPF_TRACE_RAW_TP
> >
> > I'm using the last one so BPF_TRACE_RAW_TP ('tp_btf' elf section
>
> ah, so we were talking about BTF-aware raw tracepoint, sorry, I missed
> that. Was thinking about plain raw tracepoint all along the way.
>
> > name). libbpf_probe_bpf_prog_type API allows checking the support for
> > a specific prog_type like BPF_PROG_TYPE_TRACING but indeed I need a
> > check on the attach_type support. BPF_TRACE_FENTRY/FEXIT have
> > different requirements with respect to BPF_TRACE_RAW_TP so I would
> > like to know if libbpf provides out-of-the-box an API to check the
> > attach_type support. libbpf_probe_bpf_prog_type doesn't tell if
> > BPF_TRACE_FENTRY/FEXIT are effectively supported it just tells if
> > BPF_PROG_TYPE_TRACING is supported, so I was just asking what is the
> > best way to probe the support for a specific attach_type
>
> ok, this sounds like a perfect use case to use that opts argument and
> allow programs to optionally specify expected_attach_type. see
> LIBBPF_OPTS, OPTS_GET and other cases of using `struct xxx_opts` in
> libbpf code base.
>
> Would you be interested in contributing such a patch?

Right now I'm pretty busy but if there is no rush I can try to
implement it when I have time! BTW thank you for the suggestion, I
will take a look at `LIBBPF_OPTS, OPTS_GET` constructs!
> >
> > >
> > > >
> > > > > If kernel doesn't support fentry/fexit attachment for some specif=
ic
> > > > > function you'd like to attach to, that's a different matter. This
> > > > > would be equivalent to BPF_PROG_TYPE_KPROBE check -- we check if
> > > > > kprobes in general are supported, but not whether kprobing specif=
ic
> > > > > kernel function works.
> > > > >
> > > > > I assume by "not supported on my machine" you mean that you can't
> > > > > attach fentry/fexit to some function? If not, let me know, and we=
'd
> > > > > have to debug this further.
> > > >
> > > > Sorry, probably I was not so clear, with this statement I mean that
> > > > libbpf_probe_bpf_prog_type() returns 1 even if BPF_TRACE_FENTRY pro=
gs
> > > > cannot be attached into the kernel. [0] is an example of what I'm
> > > > doing.
> > > > 1. Check fentry support with libbpf_probe_bpf_prog_type
> > > > 2. Check fentry support with an approach similar to libbpf-tools (a=
s
> > > > you suggested)
> > > > 3. Try to inject my real BPF programs.
> > > >
> > > > (2) (libbpf-tool check) is correctly able to detect that
> > > > BPF_TRACE_FENTRY progs are not supported, when we call
> > > > `bpf_raw_tracepoint_open` to attach the fentry prog, `524` is retur=
ned
> > > > so we understand that this program is not supported. On the other
> > > > side, (1) is not able to detect that programs are not supported, th=
e
> > > > API returns `1` as if they were supported. Now I have to highlight
> > > > that this API is called libbpf_probe_bpf_prog_type and not
> > > > libbpf_probe_bpf_attach_type, so 1 could be the right return value
> > > > since BPF_PROG_TYPE_TRACING progs are effectively supported, for
> > > > example, attach_type  BPF_TRACE_RAW_TP is supported, but some other
> > > > attach types like BPF_TRACE_FENTRY/BPF_MODIFY_RETURN  are not. If t=
his
> > > > API just checks for BPF_PROG_TYPE_TRACING support, probably the bes=
t
> > > > way I have to check if a specific attach type is supported is to
> > > > directly inject a small prog of this type, as libbpf-tool does. WDY=
T?
> > >
> > > Could it be that you are mixing up enum bpf_prog_type with enum
> > > bpf_attach_type when calling libbpf_probe_bpf_prog_type()?
> > >
> > > >
> > > > [0]: https://github.com/Andreagit97/BPF-perf-tests/blob/main/templa=
tes/fentry_attach.c
> > > >
> > > > > If you want to know if some function can be traced with fentry/fe=
xit,
> > > > > check below helper function from libbpf-tools ([0])
> > > > >
> > > > > bool fentry_can_attach(const char *name, const char *mod)
> > > > >
> > > > >
> > > > >   [0] https://github.com/iovisor/bcc/blob/master/libbpf-tools/tra=
ce_helpers.c#LL1043-L1043C58
> > > > >
> > > > Thank you for the pointer!
> > > > >
> > > > > > Thank you in advance for your time,
> > > > > > Andrea
