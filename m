Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF606DFDEA
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 20:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDLSs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDLSs4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 14:48:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1319A
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:48:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94a34c2bc67so235985866b.2
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj5jGbkRGONKyLPpTw8nOSOYnY5SuRbDn0NudWgpxnY=;
        b=E2hs9/p7NJxNNV3A4vGReucJPpq0bP3maN6mdlnQ9m2gWaP6F8FPA6GYTDEEFsdYHG
         AWUJRrxXeRTskY6c7A077z+H7HC9Nu8Po/Y/avq5j4qHUMTP7QfySvyCxzVw5gCVDb/T
         Sdg34KWcITePLQK5Rzni16o/LDTeUUqy6xxS6ewafJfglO7sOKRfmK1qrpHytRpJmGu2
         oTcC0UvloA3RSJJC1yoWr2C9iqZAPCWaNWaS8rtqZQDuK/WCDvYbTQET38XueE+eMQ5t
         i9iLTjHTcBwKaE+n359A5DO/jEJvsG3Nm1DPsffkdsdg0ggF4jYvX6H/bEFxPATXHHgO
         mMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj5jGbkRGONKyLPpTw8nOSOYnY5SuRbDn0NudWgpxnY=;
        b=azVpmXXm+C91ovazp/Ng1Hw+kiLbaePODkWAsAqrTY2sy2QTwb6IjoZk9LHGbN6O/u
         gef+Lg0wLyWkPKiHqmC1RQc9pFzTKOFwZoKlrP5gdfvV2jqeWhDIN0LV6dsH2l22thgZ
         TsDDk40qK6ybuHTbBR89UOQhgGzNNfwQCeoIfkFcdIG1/bWImQDeMCUjpqh2pNRRy2QP
         98xl0AZpdBpAYXuCyV02G6BINZd/6/OxZc/tFc3jDqBSYGJ+saSTDeDgpcSGMWcy/ije
         wy1F35IgrLOHJAk4723Iu3nt822kNyCOPJbNqtUR5U0cf1Tx8UeICinTmgAo9m9FtgrE
         kT0w==
X-Gm-Message-State: AAQBX9cxvX9iUwlgOW6mYmqzjbJezNnMFUvtEMt1zm8aHdLib8AO1j56
        Wxr/hRRaWrY+kYhnqF1DtTZYtq7VwVmr08BH/LycbrpRsoI=
X-Google-Smtp-Source: AKy350Yzo7jx6t6Wo5WEfE7jUfooxmwm+DuFEYfWNCp375c93OA11dMmZaSKU6xflALiif2fYw+rNwusczGD8WdttLo=
X-Received: by 2002:a50:8e53:0:b0:4fc:1608:68c8 with SMTP id
 19-20020a508e53000000b004fc160868c8mr3429114edx.1.1681325333698; Wed, 12 Apr
 2023 11:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQdkDvyUu2ZDDdRmb4YhDzB96hS1NPW=ju=_Y_C+6nyA6xVGw@mail.gmail.com>
 <CAEf4BzbauKucsr-e4GigvrdYy2S9XNQQ6YW0xZ3ocJVcGpR7Ow@mail.gmail.com> <CAGQdkDsBb=M+MD=B_MBCt4E0MpnP15Ls7Xja_Ow-5bvUCqe-AQ@mail.gmail.com>
In-Reply-To: <CAGQdkDsBb=M+MD=B_MBCt4E0MpnP15Ls7Xja_Ow-5bvUCqe-AQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 11:48:41 -0700
Message-ID: <CAEf4Bzbz+oziNGqNbX8MqoHqx+WZnsq9-Q7R9ESqhwjtikCk8g@mail.gmail.com>
Subject: Re: [QUESTION] usage of libbpf_probe_bpf_prog_type API
To:     andrea terzolo <andreaterzolo3@gmail.com>
Cc:     bpf@vger.kernel.org
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

On Sat, Apr 8, 2023 at 6:34=E2=80=AFAM andrea terzolo <andreaterzolo3@gmail=
.com> wrote:
>
> Il giorno mer 5 apr 2023 alle ore 00:32 Andrii Nakryiko
> <andrii.nakryiko@gmail.com> ha scritto:
> >
> > On Thu, Mar 30, 2023 at 10:21=E2=80=AFAM andrea terzolo
> > <andreaterzolo3@gmail.com> wrote:
> > >
> > > Hi all!
> > >
> > > If I can I would like to ask one question about the
> > > `libbpf_probe_bpf_prog_type` API. The idea is to use `fentry/fexit`
> > > bpf progs only if they are available and fall back to simple `kprobes=
`
> > > when they are not. Is there a way to probe `BPF_TRACE_FENTRY` support
> > > with `libbpf` APIs? I was looking at `libbpf_probe_bpf_prog_type` API
> > > but it seems to check the `prog_type` rather than the `attach_type`,
> > > when I call it `libbpf_probe_bpf_prog_type(BPF_PROG_TYPE_TRACING,
> > > NULL);` it returns `1` even if `fentry/fexit` progs are not supported
> > > on my machine. Is there a way to probe this feature with other
> > > `libbpf` APIs?
> > >
> >
> > looking at libbpf probing code, for BPF_PROG_TYPE_TRACING we choose
> > BPF_TRACE_FENTRY attach type automatically (because it doesn't really
> > matter whether its BPF_TRACE_FEXIT or BPF_MODIFY_RETURN, they all are
> > either supported or none is). We then expect that verifier will
> > complain with "attach_btf_id 1 is not a function" error. If we do see
> > that error, we know that verifier supports fentry/fexit programs *in
> > principle*, which is what we are checking with
> > libbpf_probe_bpf_prog_type().
>
> Ok got it, thank you. My issue is that in my project I need to use
> BPF_TRACE_RAW_TP programs that AFAIK don't require the support for bpf
> trampoline, so they could be supported even if
> BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are not supported. This is what
> happens on arm64 kernels where we have BPF_TRACE_RAW_TP but
> BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are still not supported... Right
> now I'm using libbpf_probe_bpf_prog_type() to check the support for
> BPF_TRACE_RAW_TP but this is just an approximation, probably the best
> way to do that is to inject a small
> BPF_TRACE_RAW_TP prog and check that it is correctly loaded. It seems
> that libbpf doesn't provide APIs to do that, is it right?

BPF_TRACE_RAW_TP is not a program type, so not sure what you are checking.

fentry/fexit is BPF_PROG_TYPE_TRACING, while raw tracepoint is
BPF_PROG_TYPE_RAW_TRACEPOINT, there shouldn't be any problem for you.

>
> > If kernel doesn't support fentry/fexit attachment for some specific
> > function you'd like to attach to, that's a different matter. This
> > would be equivalent to BPF_PROG_TYPE_KPROBE check -- we check if
> > kprobes in general are supported, but not whether kprobing specific
> > kernel function works.
> >
> > I assume by "not supported on my machine" you mean that you can't
> > attach fentry/fexit to some function? If not, let me know, and we'd
> > have to debug this further.
>
> Sorry, probably I was not so clear, with this statement I mean that
> libbpf_probe_bpf_prog_type() returns 1 even if BPF_TRACE_FENTRY progs
> cannot be attached into the kernel. [0] is an example of what I'm
> doing.
> 1. Check fentry support with libbpf_probe_bpf_prog_type
> 2. Check fentry support with an approach similar to libbpf-tools (as
> you suggested)
> 3. Try to inject my real BPF programs.
>
> (2) (libbpf-tool check) is correctly able to detect that
> BPF_TRACE_FENTRY progs are not supported, when we call
> `bpf_raw_tracepoint_open` to attach the fentry prog, `524` is returned
> so we understand that this program is not supported. On the other
> side, (1) is not able to detect that programs are not supported, the
> API returns `1` as if they were supported. Now I have to highlight
> that this API is called libbpf_probe_bpf_prog_type and not
> libbpf_probe_bpf_attach_type, so 1 could be the right return value
> since BPF_PROG_TYPE_TRACING progs are effectively supported, for
> example, attach_type  BPF_TRACE_RAW_TP is supported, but some other
> attach types like BPF_TRACE_FENTRY/BPF_MODIFY_RETURN  are not. If this
> API just checks for BPF_PROG_TYPE_TRACING support, probably the best
> way I have to check if a specific attach type is supported is to
> directly inject a small prog of this type, as libbpf-tool does. WDYT?

Could it be that you are mixing up enum bpf_prog_type with enum
bpf_attach_type when calling libbpf_probe_bpf_prog_type()?

>
> [0]: https://github.com/Andreagit97/BPF-perf-tests/blob/main/templates/fe=
ntry_attach.c
>
> > If you want to know if some function can be traced with fentry/fexit,
> > check below helper function from libbpf-tools ([0])
> >
> > bool fentry_can_attach(const char *name, const char *mod)
> >
> >
> >   [0] https://github.com/iovisor/bcc/blob/master/libbpf-tools/trace_hel=
pers.c#LL1043-L1043C58
> >
> Thank you for the pointer!
> >
> > > Thank you in advance for your time,
> > > Andrea
