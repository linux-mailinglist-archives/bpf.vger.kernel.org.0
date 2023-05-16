Return-Path: <bpf+bounces-662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778257054F6
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 19:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7492B1C20EC7
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 17:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF77107A1;
	Tue, 16 May 2023 17:26:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9734CD4
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:26:15 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097A2D5F;
	Tue, 16 May 2023 10:26:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so555151a12.3;
        Tue, 16 May 2023 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684257966; x=1686849966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CajPWX15YfbF+U+szOCdALlUKi2+EjRVghXnoZQOl5s=;
        b=IIxV5lb1YdI6lx773oJ84NC4Jygm4U+Dsj9yNslkM/mcIt+w4+gjHGkJOdWxOUG6B5
         B5J3hfKnsvytCiyDT2o+Efhu3KH7i3y/ZlrT0XPsCeT9UOJVMtRCqIYKRfVtiLS/0YD1
         8XCI/vx+w93ygZ2WnabFnXWLm452/L/yrXurE5CAgvujmVVtLGZlgOD5tC0sqZA0EPY3
         YF5Dsr1lugIrFZa9EzBsFwI7brsEkcxVFNacIaZIGDhBiuCHbCE/TZuQvwMYknjC2Hwq
         Cj6lPcAQs4HHlHICik2fORyhX/bcgheSX3H88fAxpwHfVwvxyAIiLNC5Dxj6QO3v4yH+
         FJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684257966; x=1686849966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CajPWX15YfbF+U+szOCdALlUKi2+EjRVghXnoZQOl5s=;
        b=FkOK1K0qGFUczacVBlMpeyxO74cM5lEoL9Zx4sNEyPFSN/vzoHPI90U1D+xcdBIleo
         /LYQ/I7B6KINDGj5sBFbbRTD9eN1csEsovziCSC34dFt6Yb3oz7wyDXbsNE9g9rgXsZi
         U2OFO7qFjrLFGERqZJkbPe+zXkFJ50kZpgzxbxZlU8nlg14M0Dgbmj3of53YB0QMb4yp
         jaXu+p5JhT96I9Y43X7ZNlDMG5Bcei47lsCVzmjvJ1IZv1Dgu/NtIrvrzXweWYPSvpLW
         EMq1INWtGMu5Bt8ySgBkLJzj/Cec6hyJ3Y7jEnUCGhTE1FpLnaRgLGQ4/7Og+w3aBfZI
         cEvQ==
X-Gm-Message-State: AC+VfDy83yzrUiJ36ICW6nefVZY9CfRADP//lV8j5XFBtEgHi/6MzfvH
	pPHf1meDMAK9dBpC63Zhwvmy5/kv1dTSsVQeM6U=
X-Google-Smtp-Source: ACHHUZ6zAYnYYoON7ioYM7oL3prrWcxhB46Veg2MoLoZQMHX+pngcwdy9MfULm7Y6GDTypYY7Nlbf3o/VVm6mvdjfkQ=
X-Received: by 2002:a17:907:3686:b0:94a:56ec:7f12 with SMTP id
 bi6-20020a170907368600b0094a56ec7f12mr36432217ejc.30.1684257965724; Tue, 16
 May 2023 10:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230501200410.3973453-1-indu.bhagat@oracle.com>
 <20230501200410.3973453-6-indu.bhagat@oracle.com> <20230502105353.GO1597476@hirez.programming.kicks-ass.net>
 <20230502112720.0c0d011b@gandalf.local.home>
In-Reply-To: <20230502112720.0c0d011b@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 10:25:52 -0700
Message-ID: <CAEf4BzY498TqDDBYFWoUHi9RG3fdhfDmJPo0Nm-793N7A_eTLQ@mail.gmail.com>
Subject: Re: [POC 5/5] x86_64: invoke SFrame based stack tracer for user space
To: Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	linux-toolchains@vger.kernel.org, daandemeyer@meta.com, andrii@kernel.org, 
	kris.van.hees@oracle.com, elena.zannoni@oracle.com, nick.alcock@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

adding bpf@

On Tue, May 2, 2023 at 8:27=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 2 May 2023 12:53:53 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > >     while (entry->nr < entry->max_stack) {
> > >             if (!valid_user_frame(fp, sizeof(frame)))
> > >                     break;
> >
> > This is broken, the sframe stuff is not NMI safe. First you need to
> > change perf to emit a forward reference to a 'next' user trace and then
> > emit the user trace on return-to-user.
> >
> > As is, perf does everything in-place from NMI context.
>
> Exactly. What I would like to see with the new sframe infrastructure is
> just a way to tell it "I want a user stack trace before going back to use=
r
> space". Then all the work can be done in the ptrace path, where it's safe
> to memory map in the sframe section. It's not like the user space stack
> frame will change before going back to user space.
>
> This will allow for asking for the user space stack trace at any context,
> because the work will not be done until later. Of course, this may also
> require user space tooling to be updated to handle this case. Perf may
> already do that.
>
> It would also mean that even if you take multiple profiling hits in one
> system call, you will only get one user space stack trace. But that's a
> good thing. As the stack trace doesn't change, and you don't waste ring
> buffer space with unneeded duplicate stacks.

As discussed in the halls of LSF/MM2023, such lazily mapped .sframe in
approach won't work with BPF's bpf_get_stack() approach, which expects
stack trace to be grabbed and returned synchronously from NMI context.
But we can probably retrofit it into bpf_get_stackid()+STACK_TRACE BPF
map API.

Indu, please cc bpf@vger.kernel.org for future revisions so we can
track and plan accordingly. Thank you!

>
> -- Steve

