Return-Path: <bpf+bounces-5141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C633756D87
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 21:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17694281439
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9ABC2C5;
	Mon, 17 Jul 2023 19:40:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA652F52
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 19:40:35 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22726D3
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:40:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso7857384e87.1
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622832; x=1692214832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7eOklhMaymDvLIGNavYiHgOgEsMeMgMxa7z1tuyOuYg=;
        b=JetMg2Ioi508CT9V13xHT90BgAF+F+aVgcDn47GC2ZXHdtJh3gxnCM3iw+/cbA5QxB
         On4HKNf/hiUR98K57HLxkLlYfnGVyfsDb2JOvwPK1DmTE+hSkjmxXIGwAzWHeIa+hhbF
         yhYqeFHeat11wR9R+JaMeIYVV24dbikLYXSqkNVnOH9qUyOMTVObR7qN1hk4U8C4AKkX
         29dIv0GTLt4HueEbD9FdDcg5pCo0raYQqLU1NH9CPFxDYYK47hjCpprCbPHZXSBTYrgG
         EWoVjqRfhIIG3vl+lJyNocAf12ouacRCFiOAAN5OuUenkegWtxWSSpYiMikvOmchclgz
         +8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622832; x=1692214832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eOklhMaymDvLIGNavYiHgOgEsMeMgMxa7z1tuyOuYg=;
        b=V7z/6IMNcIjv0/JCTnkZXEvSnchDeQjel9hJiHcBrk2xrenxYYiIAoLoGsrxJjoOkd
         V07tIURPhSTV22uSWfcaSVqPEQWRlcViMD20JSF32vsvcof0ROUVdx5Ysnbe1ZrQv169
         s8FPyN/2Bjhf7XH9x7zxRUfnlR6E1xwLFTjQVw3rdToYWU3u60jlExKn2jE6e/0mowDz
         bfhnI+CZWaSfq5YOnUcQIn2yFNPyOzfltRT8pMV73EcGH3MqJ941FQdzgB4pNu7tT42S
         9QhiNgLMxIbb3fhBvnWM2GCw5INOJad8ZGFBkcUC+OgszMOBxA3O3uVC9b10esc2j/LX
         73mw==
X-Gm-Message-State: ABy/qLaZFqOSLa4AEz7O+aTgAganUutdp+lghD+CFJ69IlQL/kCmQYTj
	lFawq8glDEQLnCJF7n+T4dECQUKNzrz7aVucyr0w/9OCRmDYdQ==
X-Google-Smtp-Source: APBJJlGXMX+7T8tunxJzv7NZiqn58ViJ1x0I+mLxwl3C45sqQN13acxcW3NZ4r7war8h2N9+BZKqpMri8j7ukQttNEM=
X-Received: by 2002:a19:6703:0:b0:4f8:7781:9875 with SMTP id
 b3-20020a196703000000b004f877819875mr10867994lfc.60.1689622832142; Mon, 17
 Jul 2023 12:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <vjicfsbmp62pxqpmiyd55sh32ddovr2cosjux3ecsyekpx6ncs@36y7tfs56h3p>
In-Reply-To: <vjicfsbmp62pxqpmiyd55sh32ddovr2cosjux3ecsyekpx6ncs@36y7tfs56h3p>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 18 Jul 2023 01:09:51 +0530
Message-ID: <CAP01T77m9ArXiKLgKW-uttFikirC97VXP=hmXFkS8JrSDXRYJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/10] Exceptions - 1/2
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 17 Jul 2023 at 23:46, Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Thu, Jul 13, 2023 at 08:02:22AM +0530, Kumar Kartikeya Dwivedi wrote:
> > This series implements the _first_ part of the runtime and verifier
> > support needed to enable BPF exceptions. Exceptions thrown from programs
> > are processed as an immediate exit from the program, which unwinds all
> > the active stack frames until the main stack frame, and returns to the
> > BPF program's caller. The ability to perform this unwinding safely
> > allows the program to test conditions that are always true at runtime
> > but which the verifier has no visibility into.
> >
> > Thus, it also reduces verification effort by safely terminating
> > redundant paths that can be taken within a program.
> >
> > The patches to perform runtime resource cleanup during the
> > frame-by-frame unwinding will be posted as a follow-up to this set.
> >
> > It must be noted that exceptions are not an error handling mechanism for
> > unlikely runtime conditions, but a way to safely terminate the execution
> > of a program in presence of conditions that should never occur at
> > runtime. They are meant to serve higher-level primitives such as program
> > assertions.
>
> Sure, that makes sense.
>
> >
> > As such, a program can only install an exception handler once for the
> > lifetime of a BPF program, and this handler cannot be changed at
> > runtime. The purpose of the handler is to simply interpret the cookie
> > value supplied by the bpf_throw call, and execute user-defined logic
> > corresponding to it. The primary purpose of allowing a handler is to
> > control the return value of the program. The default handler returns 0
> > when from the program when an exception is thrown.
> >
> > Fixing the handler for the lifetime of the program eliminates tricky and
> > expensive handling in case of runtime changes of the handler callback
> > when programs begin to nest, where it becomes more complex to save and
> > restore the active handler at runtime.
> >
> > The following kfuncs are introduced:
> >
> > // Throw a BPF exception, terminating the execution of the program.
> > //
> > // @cookie: The cookie that is passed to the exception callback. Without
> > //          an exception callback set by the user, the programs returns
> > //          0 when an exception is thrown.
> > void bpf_throw(u64 cookie);
>
> If developers are only supposed to use higher level primitives, then why
> expose a kfunc for it? The above description makes it sound like this
> should be an implementation detail.
>

I can rephrase, but what I meant to say is that it's not an error
handling mechanism.
But you _can_ directly call bpf_throw as well when failing a condition
that you know is always true.
It's not necessary to always use the assert macros. That may not be
possible as it requires a lvalue, rvalue pair.

If the condition is complicated, e.g. the one below, is totally
acceptable, if you know it's always going to be true, but the verifier
doesn't:

if (data + offset > data_end)
    bpf_throw(XDP_DROP);

This can be from a deeply nested callchain, and it eliminates the need
to handle this condition all the way back to the main prog.

The primary requirement was for implementing assertions within a
program, which when untrue still ensure that the program terminates
safely. Typically this would require the user to handle the other
case, freeing any resources, and returning from a possibly deep
callchain back to the kernel. Testing a condition can be used to
update the verifier's knowledge about a particular register. By
throwing from the other path where the condition is untrue, it's a way
to increase the knowledge of the verifier during its symbolic
execution while at the same time preserving the safety guarantees.

