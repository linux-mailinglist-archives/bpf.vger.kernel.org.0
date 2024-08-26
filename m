Return-Path: <bpf+bounces-38108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF46995FC6F
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E252839DB
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B919CD0F;
	Mon, 26 Aug 2024 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFkSB2nq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978AC129E93;
	Mon, 26 Aug 2024 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710127; cv=none; b=kLm7mqZrnlRatanJTGqCcWNXkGRtUAKKmFs4IR6q6+Rd6cFile7WTeI2A6aOSp5OnTfCHL+VqSGu3/9hvOORN3SxjFRNaKYB6i/KZLZFgzc2EEAaGLRkUDVBMmx/1fb+2rKa+4EwF/G/YvIuOx7IAL7i5ZJx55lsCzAxP8xmpX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710127; c=relaxed/simple;
	bh=m5OIaP97S8xj4i0VnZmS0fTiFyYZ0ZkBCQFOZJ/vxUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THd02bPeH/8UPip5SypgRVwiSrH+rcNKOgkvpd25QAoSj7efFy/lP97niInonN2xxjzPJG8hujxmQ/4CRO32/IiQ5AtinqcYM+EtpgY9Tg1u5B3HPXQLraX1xwGuTaF7IOM9VVSpHA1du0ixZx/kmhBqNg0NZcCg1RxOecnqwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFkSB2nq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7b8884631c4so1945966a12.2;
        Mon, 26 Aug 2024 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724710125; x=1725314925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScuNCjKoDYGrkyZc/bupGKnrLb5fB+UoZ7ScEF+QbCQ=;
        b=MFkSB2nqfL6EtqxgrONvC3I4ciNCHGGlRWE5NRiEtSins5RnJqW/QxcXL9KqbE7vVv
         W5kELC/EbFrwyd6kIfwfBpqYuGeyQ+8kOwcnvZiauG9M8M99cvgwbsEsNuJTLjxG0JUg
         BB6SjMvoYKrNYXBqfu+GEH9SQDESOS76MC4m93HonEYuymKw7YodhnbdMJkDuYeEAJAQ
         rlnTgjjZ4tWgU8hw83pA3sBmKfaRG2+xD4eJ3yhsZJUg7UPrGyzfIDmos7KCK/dpjlrB
         J8kRdbrBvPizL/fymyZNSaOnFd80Ud2rhftprYQSQaUFR5Eb0ZEdpM/dS9+o7OVVRGgF
         mR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724710125; x=1725314925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScuNCjKoDYGrkyZc/bupGKnrLb5fB+UoZ7ScEF+QbCQ=;
        b=INEbF/B2E4Jt91P55mXBSNuR5/dT2npMwZ6o1O7SBUe8xFr1Joz68+oXptucgarFSM
         T4jDrAcbtKPprcRDXQYh1oY1Egh+Swcs97xC3ELzejQlcusUrMJlYHdrnXQg2vTKbVtb
         yKNAiDXGPSlfxprI8s6EiL3GYUzECv3s8VGnhtTUA6e/KMyHuFYNtR4rlli+y3UIAQKY
         5ubvcVpXPVk24Q1ybrGCAXgdEeeT/Ps/vcVZb58ls0b4q7i4MWHedS/jeVtS72Frgxnv
         NMObeR3uQ7QTQtzZAQh9j0jW+3VLpyUXugi5rYoveo+fFBen8pYaRMac7pATw36b1vF2
         PAAw==
X-Forwarded-Encrypted: i=1; AJvYcCUat3WRk4iGi8Td7zC906D8jJygfytHGDlKsOEcj76TP/WdjR9MNFYsCE/+sSeZmbynvzz3/bRH9Zgn7n1H4fSwFuZV@vger.kernel.org, AJvYcCX2dR/nArJu6+Y38QYz8PQwQYSmalawY6xVOe4tLTVg8rjFJEbrpBcbnWEfEAAR8ZETL+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmgBk4nhwUaQWEytzANR4b8oaCPPxRlfssWe/4TnnOalb4rRAY
	1pbVcjbrsJIeDn9Ph+pGKtCwgTdVuX/kSNp4+bfn/4LyZabj0f58iYQFqPfH3Jni22ulXDy/QPL
	4l0caJqeAZPMJtF44msnDOeRIjks=
X-Google-Smtp-Source: AGHT+IGVPchl8nQVkCu8Y2fyxNYSquPz9oRFJPSVaCay2tpCkfnM0kCTB6K48ir4IK94zJTZeu8kkvIW1bjdNJy57nE=
X-Received: by 2002:a17:90b:4a09:b0:2c9:321:1bf1 with SMTP id
 98e67ed59e1d1-2d8259ee98fmr1084183a91.39.1724710124781; Mon, 26 Aug 2024
 15:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com> <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava> <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava> <20240826212552.GB30765@redhat.com> <Zsz7SPp71jPlH4MS@krava>
In-Reply-To: <Zsz7SPp71jPlH4MS@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Aug 2024 15:08:32 -0700
Message-ID: <CAEf4BzYz4SEK6G=MNP8vqBBRoUqCqW6wm=nJvS37frWmAH61ww@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Tianyi Liu <i.pear@outlook.com>, mhiramat@kernel.org, 
	ajor@meta.com, albancrequy@linux.microsoft.com, bpf@vger.kernel.org, 
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org, 
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 3:01=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Aug 26, 2024 at 11:25:53PM +0200, Oleg Nesterov wrote:
> > This is offtopic, sorry for the spam, but...
> >
> > On 08/26, Jiri Olsa wrote:
> > >
> > > On Mon, Aug 26, 2024 at 01:57:52PM +0200, Oleg Nesterov wrote:
> > > >
> > > > Does bpftrace use bpf_uprobe_multi_link_attach/etc ? I guess not...
> > > > Then which userspace tool uses this code? ;)
> > >
> > > yes, it will trigger if you attach to multiple uprobes, like with you=
r
> > > test example with:
> > >
> > >   # bpftrace -p xxx -e 'uprobe:./ex:func* { printf("%d\n", pid); }'
> >
> > Hmm. I reserved the testing machine with fedora 40 to play with bpftrac=
e.
> >
> > dummy.c:
> >
> >       #include <unistd.h>
> >
> >       void func1(void) {}
> >       void func2(void) {}
> >
> >       int main(void) { for (;;) pause(); }
> >
> > If I do
> >
> >       # ./dummy &
> >       # bpftrace -p $! -e 'uprobe:./dummy:func* { printf("%d\n", pid); =
}'
> >
> > and run
> >
> >       # bpftrace -e 'kprobe:__uprobe_register { printf("%s\n", kstack);=
 }'
>
> did you just bpftrace-ed bpftrace? ;-) on my setup I'm getting:
>
> [root@qemu ex]# ../bpftrace/build/src/bpftrace -e 'kprobe:uprobe_register=
 { printf("%s\n", kstack); }'
> Attaching 1 probe...
>
>         uprobe_register+1
>         bpf_uprobe_multi_link_attach+685
>         __sys_bpf+9395
>         __x64_sys_bpf+26
>         do_syscall_64+128
>         entry_SYSCALL_64_after_hwframe+118
>
>
> I'm not sure what's bpftrace version in fedora 40, I'm using upstream bui=
ld:
>
> [root@qemu ex]# ../bpftrace/build/src/bpftrace --info 2>&1 | grep uprobe_=
multi
>   uprobe_multi: yes
> [root@qemu ex]# ../bpftrace/build/src/bpftrace --version
> bpftrace v0.20.0
>
>

So what's the conclusion for the original issue? Do we have a path
forward with the fix?

> jirka
>
> >
> > on another console I get
> >
> >       Attaching 1 probe...
> >
> >         __uprobe_register+1
> >         probe_event_enable+399
> >         perf_trace_event_init+440
> >         perf_uprobe_init+152
> >         perf_uprobe_event_init+74
> >         perf_try_init_event+71
> >         perf_event_alloc+1681
> >         __do_sys_perf_event_open+447
> >         do_syscall_64+130
> >         entry_SYSCALL_64_after_hwframe+118
> >
> >         __uprobe_register+1
> >         probe_event_enable+399
> >         perf_trace_event_init+440
> >         perf_uprobe_init+152
> >         perf_uprobe_event_init+74
> >         perf_try_init_event+71
> >         perf_event_alloc+1681
> >         __do_sys_perf_event_open+447
> >         do_syscall_64+130
> >         entry_SYSCALL_64_after_hwframe+118
> >
> > so it seems that bpftrace doesn't use bpf_uprobe_multi_link_attach()
> > (called by sys_bpf(BPF_LINK_CREATE) ?) in this case.
> >
> > But again, this is offtopic, please forget.
> >
> > Oleg.
> >

