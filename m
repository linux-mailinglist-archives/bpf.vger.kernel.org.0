Return-Path: <bpf+bounces-28528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC68BB221
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CE6282B6B
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6751586F3;
	Fri,  3 May 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2KjVBTL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE31586C3;
	Fri,  3 May 2024 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759420; cv=none; b=B4E2TAHFWrGM9wzVU+O89lnncmu44BD7WZd1JQg6V0B06c6bZQyornyh4oDL29Ll+u2s12lh/lnnPlqAeIqW7BRJDWhqc6n6Te6CrLW8SqP5zN9yE0aLi9SxE2DcJ71lXVg9F9IMl6Y3hzqPEa11W/VUrdPJDyO6XPVWvH97vlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759420; c=relaxed/simple;
	bh=ybBnohGJ7OCPoSTxetQTUQLupbXJ1oRN8/fNm62kyjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMTr/Bw4NRvCuMJMYbFW5Gr557LTWKX3VUeyHwKtwVrANHhaeTKbwwzBHQfSahyOhDh1yTn8mONM7gzS9iERzQu5RZTx9bgdjfz/sQX/x3VWcGXMkFKDnyJYrkWpgOHmqrYALcKMQ2xk07KxlGGzmxjTN6VCldZBYCkUiP+Ff8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2KjVBTL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b2bc7b37bcso3326512a91.2;
        Fri, 03 May 2024 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714759417; x=1715364217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJBP6tJNRliKd9d9ij7Yg8o1fHkwrBen/j2P4vsQ2FA=;
        b=T2KjVBTL9ReFjdG0/E40kovejNXoegh5Vk1pQPJCBcf+bqBYJ8hlaC8BF8vecNEjnE
         qPL0ocjPb4HZYwOGPtNfIrPhCNXqCbceZs2yUxFE3fiChRDKne4fhcYLnAdC/LT9FItQ
         8X24X5PZYLXA6iYybafkB9RGEaWRh+USb3VxsX2N9snE4L0cx8SScovErk50lJO9a/Lh
         mpqLf3gqYU5AR/ZayBP69rAclid7cKQ8/uExWEsnHzyzApUD2l25jqyMWQXG7dxyO+EQ
         wjIZE2X465LLuEOM4mR20ATrneGmPKOQzM1ZEsKJpLEN42kRP65zT3vuE1z33AGrH5Jk
         gLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714759417; x=1715364217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJBP6tJNRliKd9d9ij7Yg8o1fHkwrBen/j2P4vsQ2FA=;
        b=XU/578osZCzLa0VrdJd2oGmy48I3gTG2g3ypM7PBqFY4e0MJoGRtSQznWZ2vx+izuK
         9r5BQevFm3z1Ohy4simTbBRC5QDHosODN2ieafqsbYPLzYJny8Ksh95h55r6tkwvxWIN
         6Z/ySuVnVRLsJKXq+eSUTu5RDgoNhrRZMbWJ5VWRJl1dD2UCc10jf9mghTdrerBumvQu
         yFpSek+CeVD1C+ksH84rw+BWfncejWN4uwc3MHrUPD7jVymmWNk0s/YnTjq0mzyIdI8Y
         P5sjsmxXZca6dkJbzFOl20eg+DPt/yACG2BaUU3sXmclnSFVo5/+8H8TWpWFyeyb7P3W
         YhFA==
X-Forwarded-Encrypted: i=1; AJvYcCWyN46Sv/hZptaxwX1RDiQpNQgknnWo7FjNZ1qx/T6C4AYQAudVN8aL7+am6EiOmtgfeThc5fx2GaY+QzJ5HgWrBl+SiWK7n5garZ46JT/tAKzc/fF/2z56w3nAH8W0I8jriL2LStp7hX86PpyFaZDbkXNc5hx4rEQQMIyEro2WvCHPl+mdqKBkY3NQ2CndMIx57bwIu090NynqLEhIZsdODyIqtAzYKRV7enXUlH+dZC7ZVIdcz67Fx6Ge
X-Gm-Message-State: AOJu0YyCuEdR4OLYsLQF+X5wvQDf+KKlNHTnI0nNWzWvQRQ83vkykWul
	1JbVcj5IMikeP2o39exjcky1yCGc4xgxlien5ua9uLXs0ei3/TbvCmt/Zzf/G8iGckvyJ+ts0+W
	EymyAMCoH22ehecvBgjtUcBJo0+s=
X-Google-Smtp-Source: AGHT+IHGv2AfdGlWnLUJO3nFJ39n5eguagCUVgfAL/9b1Z8ZReC8l08QWuqFwk87+N9AlG6CBDQe1aHE2ylNhbCRhIw=
X-Received: by 2002:a17:90b:158:b0:2a0:9b18:daf with SMTP id
 em24-20020a17090b015800b002a09b180dafmr4011307pjb.42.1714759417151; Fri, 03
 May 2024 11:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502122313.1579719-1-jolsa@kernel.org> <CAEf4BzYxsRMx9M_AiLavTHFpndSmZqOM8QcYhDTbBviSpv1r+A@mail.gmail.com>
 <ZjPx0fncg-8brFBk@krava>
In-Reply-To: <ZjPx0fncg-8brFBk@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 May 2024 11:03:24 -0700
Message-ID: <CAEf4Bzb-dM+464JvW96KuxwOTfRQA1pxZRWM+pA7AfSWtWwqZw@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 0/7] uprobe: uretprobe speed up
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 1:04=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, May 02, 2024 at 09:43:02AM -0700, Andrii Nakryiko wrote:
> > On Thu, May 2, 2024 at 5:23=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > hi,
> > > as part of the effort on speeding up the uprobes [0] coming with
> > > return uprobe optimization by using syscall instead of the trap
> > > on the uretprobe trampoline.
> > >
> > > The speed up depends on instruction type that uprobe is installed
> > > and depends on specific HW type, please check patch 1 for details.
> > >
> > > Patches 1-6 are based on bpf-next/master, but path 1 and 2 are
> > > apply-able on linux-trace.git tree probes/for-next branch.
> > > Patch 7 is based on man-pages master.
> > >
> > > v4 changes:
> > >   - added acks [Oleg,Andrii,Masami]
> > >   - reworded the man page and adding more info to NOTE section [Masam=
i]
> > >   - rewrote bpf tests not to use trace_pipe [Andrii]
> > >   - cc-ed linux-man list
> > >
> > > Also available at:
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   uretprobe_syscall
> > >
> >
> > It looks great to me, thanks! Unfortunately BPF CI build is broken,
> > probably due to some of the Makefile additions, please investigate and
> > fix (or we'll need to fix something on BPF CI side), but it looks like
> > you'll need another revision, unfortunately.
> >
> > pw-bot: cr
> >
> >   [0] https://github.com/kernel-patches/bpf/actions/runs/8923849088/job=
/24509002194
>
> yes, I think it's missing the 32-bit libc for uprobe_compat binary,
> probably it needs to be added to github.com:libbpf/ci.git setup-build-env=
/action.yml ?
> hm but I'm not sure how to test it, need to check

You can create a custom PR directly against Github repo
(kernel-patches/bpf) and BPF CI will run all the tests on your custom
code. This way you can iterate without spamming the mailing list.

But I'm just wondering if it's worth complicating setup just for
testing this x32 compat mode. So maybe just dropping one of those
patches would be better?

>
> >
> >
> >
> > But while we are at it.
> >
> > Masami, Oleg,
> >
> > What should be the logistics of landing this? Can/should we route this
> > through the bpf-next tree, given there are lots of BPF-based
> > selftests? Or you want to take this through
> > linux-trace/probes/for-next? In the latter case, it's probably better
> > to apply only the first two patches to probes/for-next and the rest
> > should still go through the bpf-next tree (otherwise we are running
>
> I think this was the plan, previously mentioned in here:
> https://lore.kernel.org/bpf/20240423000943.478ccf1e735a63c6c1b4c66b@kerne=
l.org/
>

Ok, then we'll have to land this patch set as two separate ones. It's
fine, let's figure out if you need to do anything for shadow stacks
and try to land it soon.

> > into conflicts in BPF selftests). Previously we were handling such
> > cross-tree dependencies by creating a named branch or tag, and merging
> > it into bpf-next (so that all SHAs are preserved). It's a bunch of
> > extra work for everyone involved, so the simplest way would be to just
> > land through bpf-next, of course. But let me know your preferences.
> >
> > Thanks!
> >
> > > thanks,
> > > jirka
> > >
> > >
> > > Notes to check list items in Documentation/process/adding-syscalls.rs=
t:
> > >
> > > - System Call Alternatives
> > >   New syscall seems like the best way in here, becase we need
> >
> > typo (thanks, Gmail): because
>
> ok
>
> >
> > >   just to quickly enter kernel with no extra arguments processing,
> > >   which we'd need to do if we decided to use another syscall.
> > >
> > > - Designing the API: Planning for Extension
> > >   The uretprobe syscall is very specific and most likely won't be
> > >   extended in the future.
> > >
> > >   At the moment it does not take any arguments and even if it does
> > >   in future, it's allowed to be called only from trampoline prepared
> > >   by kernel, so there'll be no broken user.
> > >
> > > - Designing the API: Other Considerations
> > >   N/A because uretprobe syscall does not return reference to kernel
> > >   object.
> > >
> > > - Proposing the API
> > >   Wiring up of the uretprobe system call si in separate change,
> >
> > typo: is
>
> ok, thanks
>
> jirka

