Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753386DBB32
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjDHNeU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDHNeT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 09:34:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3DD53E
        for <bpf@vger.kernel.org>; Sat,  8 Apr 2023 06:34:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sb12so2564419ejc.11
        for <bpf@vger.kernel.org>; Sat, 08 Apr 2023 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680960856; x=1683552856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO++ZBpcZxlp6v1ZbzNsWvaLPYErAkpFnwutuBeJz7U=;
        b=Fcp1cRMintcUm2vG2CFFMqVc6mOLUMnsInCB228okkTD0GC3gLiOHsGhsRZbSzJdRD
         Tlx58x77GFmYrrmCgxhYT8YIPndLyPP1XQ2gWump0UG7W3K20xgWovB2iPY8LmXgcrZq
         VwxBf1Lq6BnBnsOu+6ZGCGvQsAvSYLIXWUau/XnJCy/NffQTHkPgwDPLPLmT1w1UCSD7
         fJ3gwW67mUomTBMvVQXPiDHy7q1kSpjBgFL4XAyW4KQ0r57vW7Yud/uzCnR2qM60qPQ4
         aWjCXGjYASOoUAjeUTwWz/EfFRFLN3NxnVrwQaJVxNWfR+GiNfuyFo8U8SGDuLNkolQ3
         FibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680960856; x=1683552856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oO++ZBpcZxlp6v1ZbzNsWvaLPYErAkpFnwutuBeJz7U=;
        b=05yz4WEA75Soi/KDoCC/NdnNAp2ZXaG33TLqXVuv940XDQIPTwXw9cflaC0Bl84RQq
         8cPQHz41Aop553X1UKMZZGbYqFgFLPIDlKCdhby1YzQ8bdAuPw1yK/k7Ax/EEYy7YzIh
         1bV6KTRgzp5gz/hmEfoonB9iMfrYoKC9cNXBZvcV9hB3urMCvC1ipl3Sji0C0hclGVoX
         RuUXj/UeuXH8Vgfqz6iqFF7pPG9U66W6qDgcVDaT2TwxJC8kgsh1Im//K93YOUmRcNWg
         SYuA3OysU9fEHbBEyeueNiE0auggjiHwqxxUC/Wv+GZ7eu/bPc6usZShdTjhmHDKuA6K
         y4zw==
X-Gm-Message-State: AAQBX9e1xmLMnBxTdmodQPfDV/41KU8UIrnPsgsiyYwe3GBh9ptl/op1
        pCEYD+4EnjFjf1ytmbUsdG5Mdw5CuwAwceUObsHVLecYiSg=
X-Google-Smtp-Source: AKy350YdWGDzkynJlwbD/1Qea6mUlPSETQHfxsrwzOtamtCuBpEj7SRn37smB0htpV7F07Avw1mDbE48sfseUh3kjsU=
X-Received: by 2002:a17:906:264c:b0:94a:469e:3558 with SMTP id
 i12-20020a170906264c00b0094a469e3558mr392066ejc.13.1680960855671; Sat, 08 Apr
 2023 06:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQdkDvyUu2ZDDdRmb4YhDzB96hS1NPW=ju=_Y_C+6nyA6xVGw@mail.gmail.com>
 <CAEf4BzbauKucsr-e4GigvrdYy2S9XNQQ6YW0xZ3ocJVcGpR7Ow@mail.gmail.com>
In-Reply-To: <CAEf4BzbauKucsr-e4GigvrdYy2S9XNQQ6YW0xZ3ocJVcGpR7Ow@mail.gmail.com>
From:   andrea terzolo <andreaterzolo3@gmail.com>
Date:   Sat, 8 Apr 2023 15:34:04 +0200
Message-ID: <CAGQdkDsBb=M+MD=B_MBCt4E0MpnP15Ls7Xja_Ow-5bvUCqe-AQ@mail.gmail.com>
Subject: Re: [QUESTION] usage of libbpf_probe_bpf_prog_type API
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Il giorno mer 5 apr 2023 alle ore 00:32 Andrii Nakryiko
<andrii.nakryiko@gmail.com> ha scritto:
>
> On Thu, Mar 30, 2023 at 10:21=E2=80=AFAM andrea terzolo
> <andreaterzolo3@gmail.com> wrote:
> >
> > Hi all!
> >
> > If I can I would like to ask one question about the
> > `libbpf_probe_bpf_prog_type` API. The idea is to use `fentry/fexit`
> > bpf progs only if they are available and fall back to simple `kprobes`
> > when they are not. Is there a way to probe `BPF_TRACE_FENTRY` support
> > with `libbpf` APIs? I was looking at `libbpf_probe_bpf_prog_type` API
> > but it seems to check the `prog_type` rather than the `attach_type`,
> > when I call it `libbpf_probe_bpf_prog_type(BPF_PROG_TYPE_TRACING,
> > NULL);` it returns `1` even if `fentry/fexit` progs are not supported
> > on my machine. Is there a way to probe this feature with other
> > `libbpf` APIs?
> >
>
> looking at libbpf probing code, for BPF_PROG_TYPE_TRACING we choose
> BPF_TRACE_FENTRY attach type automatically (because it doesn't really
> matter whether its BPF_TRACE_FEXIT or BPF_MODIFY_RETURN, they all are
> either supported or none is). We then expect that verifier will
> complain with "attach_btf_id 1 is not a function" error. If we do see
> that error, we know that verifier supports fentry/fexit programs *in
> principle*, which is what we are checking with
> libbpf_probe_bpf_prog_type().

Ok got it, thank you. My issue is that in my project I need to use
BPF_TRACE_RAW_TP programs that AFAIK don't require the support for bpf
trampoline, so they could be supported even if
BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are not supported. This is what
happens on arm64 kernels where we have BPF_TRACE_RAW_TP but
BPF_TRACE_FENTRY/BPF_MODIFY_RETURN are still not supported... Right
now I'm using libbpf_probe_bpf_prog_type() to check the support for
BPF_TRACE_RAW_TP but this is just an approximation, probably the best
way to do that is to inject a small
BPF_TRACE_RAW_TP prog and check that it is correctly loaded. It seems
that libbpf doesn't provide APIs to do that, is it right?

> If kernel doesn't support fentry/fexit attachment for some specific
> function you'd like to attach to, that's a different matter. This
> would be equivalent to BPF_PROG_TYPE_KPROBE check -- we check if
> kprobes in general are supported, but not whether kprobing specific
> kernel function works.
>
> I assume by "not supported on my machine" you mean that you can't
> attach fentry/fexit to some function? If not, let me know, and we'd
> have to debug this further.

Sorry, probably I was not so clear, with this statement I mean that
libbpf_probe_bpf_prog_type() returns 1 even if BPF_TRACE_FENTRY progs
cannot be attached into the kernel. [0] is an example of what I'm
doing.
1. Check fentry support with libbpf_probe_bpf_prog_type
2. Check fentry support with an approach similar to libbpf-tools (as
you suggested)
3. Try to inject my real BPF programs.

(2) (libbpf-tool check) is correctly able to detect that
BPF_TRACE_FENTRY progs are not supported, when we call
`bpf_raw_tracepoint_open` to attach the fentry prog, `524` is returned
so we understand that this program is not supported. On the other
side, (1) is not able to detect that programs are not supported, the
API returns `1` as if they were supported. Now I have to highlight
that this API is called libbpf_probe_bpf_prog_type and not
libbpf_probe_bpf_attach_type, so 1 could be the right return value
since BPF_PROG_TYPE_TRACING progs are effectively supported, for
example, attach_type  BPF_TRACE_RAW_TP is supported, but some other
attach types like BPF_TRACE_FENTRY/BPF_MODIFY_RETURN  are not. If this
API just checks for BPF_PROG_TYPE_TRACING support, probably the best
way I have to check if a specific attach type is supported is to
directly inject a small prog of this type, as libbpf-tool does. WDYT?

[0]: https://github.com/Andreagit97/BPF-perf-tests/blob/main/templates/fent=
ry_attach.c

> If you want to know if some function can be traced with fentry/fexit,
> check below helper function from libbpf-tools ([0])
>
> bool fentry_can_attach(const char *name, const char *mod)
>
>
>   [0] https://github.com/iovisor/bcc/blob/master/libbpf-tools/trace_helpe=
rs.c#LL1043-L1043C58
>
Thank you for the pointer!
>
> > Thank you in advance for your time,
> > Andrea
