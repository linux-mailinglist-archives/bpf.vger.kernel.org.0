Return-Path: <bpf+bounces-3193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D7473AB2A
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 23:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9670281A82
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D625122557;
	Thu, 22 Jun 2023 21:06:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71C20690
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:06:01 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112874483
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 14:05:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f90b4ac529so182295e9.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467873; x=1690059873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDbVsTManhHVsI9mtLf6Vkc2Lh4qyxu+YtSadeFerp0=;
        b=RNI8pmSvM7BMm0KFuxA/fpBM8RoolshzkUCd1c6rGS29HEGucZAhm+PMtd6wI0RPay
         lFFMcMpVzavGL4zR+ESCArPGO54fn4yHGUyLKWEpfV5h6DdC5zVbeY7xRooNGrDz9ozu
         8G5yghptVtP4JDoG7omT79YyAvmz6C95tWQFGJchbnw04UHQg/hClPGvc6ZNTUZrRQCn
         rEt3wqBX7JUFkiKMOnuti8uLqCejJmLGUvTFMIerHE27MYnqy9AAT1F8rb/yZYfh6DkH
         PZpt9FtgA56Raiemv3lR+K4L2mekHDukDyddycGXicQCkWPyeAUEJ+j6tmMuW7bEup9X
         6xGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467873; x=1690059873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDbVsTManhHVsI9mtLf6Vkc2Lh4qyxu+YtSadeFerp0=;
        b=iZF4vxMziK4pFHAaELMyDP5/WsEdFdT5SyB9a+ZxmgoAjCCWxZWFpyUonZdaOY9bbM
         zMdXsGsq8xbqQHRkSjrOBKhh+bkFm8oDaHmuEtjuqKh4F6nLdLILCWQF5WTpp+q0DTMN
         DwzxbYmCWIptaPNTp0XeoOmq5G0nrddmNXq2OMDTnn8lXLJoCXDRDnlkHDXRuhZosxI1
         LFKzJmX6CJ8ZGZ4I8lr/g8ulrYWLEkSVfzQcTF14pyOfzaCIna7E1jRht10KP5aFbpJI
         35UqvK2tUpOQEjg0MWigeILo9rEJDPcJZxJW+tUqT2Xv46C15r/ojEwRdVnVCBcuUdLA
         2u7g==
X-Gm-Message-State: AC+VfDwBp0no4XE1spK7ZfODKKHhCgcKeNk2z5clWUNhlhRoew4iTKzr
	I0+Ac+kLPv6l+v9clWLgpfVZF+z2haVZIR2CtdCl6cWjsQc=
X-Google-Smtp-Source: ACHHUZ6NXi7eh+amG+l4JAaPfIxJ5cRJrLwkhjFfIykRKWG2ntXqd8jN4/uZTXTr8CnJen3qtDEd10FG/Omla17wVfo=
X-Received: by 2002:a7b:cb99:0:b0:3f9:c986:a2ca with SMTP id
 m25-20020a7bcb99000000b003f9c986a2camr3547871wmi.24.1687467873262; Thu, 22
 Jun 2023 14:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd173bf2-dea6-3e0e-4176-4a9256a9a056@google.com>
 <CAADnVQKbNjKJgYODUS0zO3dR8dxEcFpgY3GkhEEmwT462HW+wA@mail.gmail.com> <9642870b-3876-6b99-cf62-45ca11cfe80e@google.com>
In-Reply-To: <9642870b-3876-6b99-cf62-45ca11cfe80e@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 14:04:20 -0700
Message-ID: <CAEf4BzbgKVBiVwmfhZ6=umYF_V21pzoAzFhnjxhv0Lz02iWGmg@mail.gmail.com>
Subject: Re: Calling functions while holding a spinlock
To: Barret Rhoden <brho@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 3:41=E2=80=AFAM Barret Rhoden <brho@google.com> wro=
te:
>
> On 6/15/23 12:17, Alexei Starovoitov wrote:
> > On Wed, Jun 14, 2023 at 1:32=E2=80=AFPM Barret Rhoden <brho@google.com>=
 wrote:
> >>
> >> Hi -
> >>
> >> Would it be possible to add logic to the verifier to handle calling
> >> functions within my program (subprograms?) while holding a bpf_spin_lo=
ck?
> >>
> >> Some of my functions are large enough that the compiler won't inline
> >> them, so I'll get a BPF_CALL to PC + offset (relative call within my
> >> program).  Whenever this pops up, I force the compiler to inline the
> >> function, but that's brittle.  I'd rather just have the ability to cal=
l
> >> a function.
> >
> > always_inline works as a workaround, right?
> > And it's guaranteed to work, no?
> > I'm not sure why you're saying it's brittle.
>
> yeah, it works.  the brittleness comes when i don't mark a function
> always_inline, but i don't notice since the compiler was inlining it
> anyways.  but eventually i make a change and the compiler decides to
> not-inline it.  e.g. i call the same function again somewhere else in my
> program, and now it's worth it to make it a separate function.
>
> it's not super urgent - and i've been hit by it enough times that i can
> usually find the problem if it pops up.
>
> > It probably generates less performant code,
> > so it would be good to add such support.
> > It wasn't done earlier, because spin_lock-ed section
> > supposed to be short. So the restriction was kinda forcing
> > program authors to minimize the lock time.
> > Could you please share the example code where you want to use it?
>
> stuff like this:
>
> https://github.com/google/ghost-userspace/blob/main/third_party/bpf/biff_=
flux.bpf.c#L115
>
> similar to that one, i have an "AVL tree insert" function that the
> compiler didn't want to inline - especially if i called it twice.  (the
> AVL code hasn't hit our opensource ghost repo yet).
>
> > Just to make sure we're talking about calling bpf subprograms only
> > and you're not requesting to call arbitrary helpers and kfuncs
> > while holding the lock.
> > Some of the kfuncs can be allowed under lock if there is a real need.
>
> i was talking about bpf subprogs.  though one helper that would be nice
> to call while holding a lock is bpf_loop.  i've got some loops that i'd
> turn into bpf-loops, but can't due to the spinlock.

try open-coded iterators instead of bpf_loop(), if you can afford to
depend on a slightly newer kernel. See bpf_for() macro in
bpf_helpers.h in libbpf

>
> thanks,
>
> barret
>
>
>

