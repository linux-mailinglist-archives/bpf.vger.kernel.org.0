Return-Path: <bpf+bounces-1941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC672499C
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08AB1C20ACB
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193651ED2F;
	Tue,  6 Jun 2023 16:57:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C1C19915
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 16:57:34 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0988610F7;
	Tue,  6 Jun 2023 09:57:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so9707525a12.1;
        Tue, 06 Jun 2023 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686070646; x=1688662646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azHlI+5GippCBf+WKiWbax8dCCkxyDQeSHE9lPulApk=;
        b=cAdIexgYX7eMxZwDXRGZe6tFBNMeVXsn0iXgO7qEVBR31xLVNNXiUzs+rU1ujxr8+l
         xc2Siv7O0EeBu6KrkLJKiO75GANZYLZ0rdsS9Hsq2CSTR7TT6A9skn20Q/E1uz6smdur
         g8oZYkLJKo+2f4lFyEW4vkdj49eWdnMwCHaw93vVTXKLVwtJ9aeF/NmBdaIoPhPheFWG
         +1cj1hCTogVby16q+SKIJrWJiLwZBOJ0G6So/rsCSj0Ua8D4r806OgKG83NUqfq2hS8F
         u0uMiEAjb533nPaOswu5r7Bn5Fu7GaKAgXiNezXmlwz9OJpYKzORIGvMH6rXFT6kYJv9
         S8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686070646; x=1688662646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azHlI+5GippCBf+WKiWbax8dCCkxyDQeSHE9lPulApk=;
        b=XLOiHfsm4YJt8d30oFv6lEy3GOjMu7KLr3KnSU2lUJ6nuQ/63vmIf/P0tXeUajxg1d
         XUHkYvK4fpYZGgWThRu+VvgOuMWrvT9xGSr4sls+kW3nyi16oCeq6v+SzwSWyNv+/h26
         OKdYuhXdNnNlDA94UQKSuT1T2q22Z23om2ZkllJPHP4GVIGj8J/X1FcovWYUe6KSdgF0
         DOShNVeRQHzN5iZ7PkzQPO/XqRVo4ROLga43fuFcsov1KdtE3DIa0T/Os55vr3n5kesF
         AwEGVFxX0TOYc8izkSDa/lQCs91uI1ldhVuyqTtP46xhfZFKTExtlHxZ5edw4XJrcdZy
         NNXg==
X-Gm-Message-State: AC+VfDwCnyw1vQ0vL5y8bAYth0qGtueV0L12ykhJTgGystErR0AIBG/s
	pOJ5Nmlv6GUGVQBvzdr0Ao9mYTO2XcBOSDC+N+A=
X-Google-Smtp-Source: ACHHUZ64KAAOfaapxB1O5y4diCyCaL/i6oJvY6ppizyMVQcI2dZbltNucxts1w4q7XRdRBeu3lz6OS6aANGrLihG8Lo=
X-Received: by 2002:a05:6402:1647:b0:510:b636:4073 with SMTP id
 s7-20020a056402164700b00510b6364073mr2293592edx.3.1686070646336; Tue, 06 Jun
 2023 09:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <20230606225741.a9d8003a22451db96545b5a8@kernel.org>
In-Reply-To: <20230606225741.a9d8003a22451db96545b5a8@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Jun 2023 09:57:14 -0700
Message-ID: <CAEf4BzbhvBTQ2c1ENk2pVXdQ=SrXwTFXVjpopTANZsdn1EEeMA@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 6:57=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> Hi,
>
> On Tue, 16 May 2023 17:36:28 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > BPF progs have three ways to access kernel tracepoints:
> > 1. traditional tracepoint
>
> This is the trace_events, which is used by ftrace, right?
>
> > 2. raw tracepoint
> > 3. raw tracepoint with BTF
> >
> > 1 was added first and now rarely used (only by old tools), since it's s=
low.
> > 2 was added later to address performance concerns.
> > 3 was added after BTF was introduced to provide accurate types.
> >
> > 3 is the only one that bpf community recommends and is the one that is =
used most often.
> >
> > As far as I know trace_events were never connected to bpf.
> > Unless somebody sneaked the code in without us seeing it.
>
> With this design, I understand that you may not want to connect BPF
> directly to user_events. It needs a different model.
>
> >
> > I think you're trying to model user_events+bpf as 1.
> > Which means that you'll be repeating the same mistakes.
>
> The user_events is completely different from the traceppoint and
> must have no BTF with it.
> Also, all information must be sent in the user-written data packet.
> (No data structure, event if there is a structure, it must be fully
> contained in the packet.)
>
> For the tracepoint, there is a function call with some values or
> pointers of data structure. So it is meaningful to skip using the
> traceevent (which converts all pointers to actual field values of
> the data structure and store it to ftrace buffer) because most of
> the values can be ignored in the BPF prog.
>
> However, for the user_events, the data is just passed from the
> user as a data packet, and BPF prog can access to the data packet
> (to avoid accessing malicious data, data validator can not be
> skipped). So this seems like 1. but actually you can access to
> the validated data on perf buffer. Maybe we can allow BPF to
> hook the write syscall and access user-space data, but it may
> not safe. I think this is the safest way to do that.

I'm trying to understand why we need a new kernel concept for all
this. It looks like we are just creating a poor man's
publisher/subscriber solution in the kernel, but mostly intend to use
it from user-space? Why not just use Unix domain sockets for this,
though? Use SOCK_SEQPACKET, put "event data" into a single packet
that's guaranteed to not be broken up. Expose this to other processes
through named pipes, if necessary.

Sorry if it's naive questions, but it's not clear what problem
user_events are solving and why we need a new thing and can't use
existing kernel primitives?


>
> Thank you,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

