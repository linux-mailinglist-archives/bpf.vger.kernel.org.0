Return-Path: <bpf+bounces-52581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9AA44F8E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C3F3ADBFF
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057421322B;
	Tue, 25 Feb 2025 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqMWQqOs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B215198B;
	Tue, 25 Feb 2025 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521474; cv=none; b=Pa7ybx82r05CYpbYaiSpV4QL/p0X63mYICrSy9Tv6fkSSIFdaAWU0DdsALi8IpJ7vQwNd0TlLTjlWoO2F7/+qpSKW7EuhE8cIRg6WLsi2dfnpy3j2P0D3lmuRtE553HFUVJAi1woXQzQ6WZ0XueLSlgXgyrXHC3PZrCO+1CysCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521474; c=relaxed/simple;
	bh=37Ko1SNCa7V3a4wD3ug9FmTKdFC7UMkAsjvXmxDkgqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttc0yECXcn1+7wCgHYLaI/bDn7J2lTf8Lkbflu1S/VzXnkvIcD5Arx2M8tgZtXX23Jkpv25RPb7giJPfl+c2lawRCJ/CynnvH2OXiAuSYIqrdTp381I7Vnj5kcOf+Evn4dBQHFcJI57Tsi7IA9OyF9odReOCqESM5JUKV4ToIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqMWQqOs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso12324264a91.3;
        Tue, 25 Feb 2025 14:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740521472; x=1741126272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAI/91W4mgIneZXqGJLoDY9N+72avalSOaf3OdNXKIw=;
        b=eqMWQqOsPJzTfdTzVVc4TjkevCH9uUF85G69AsFkRAsdg2XLET7TcMMNsQa5a5b7C3
         qZRoIzQvNWh7S7PyTkkQhBa6yPPtP+ozepT9uVAhSus5WhTKUCbeIkHm6ChkvwJNrMKk
         xJM/wu0bWBZM5vCAZp4l097oy9GiW6pjuFDyC8SI7usJkkBPU6EUD2LgatpRHh3K/Cuv
         rJDAjACKAtw0B80gGb8FMrS7kYZ6QBGmZSkbrUqw3BJhx0G785BzbF3dOznDuXQqksaC
         5guCrr2P4McAzsshzTBPXoK/+q2QdCrvP4wowGQwvfiy/qKGot8k/nmx3rEHzzCWRBkY
         y9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521472; x=1741126272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAI/91W4mgIneZXqGJLoDY9N+72avalSOaf3OdNXKIw=;
        b=r+BdDGeVIJFlxrH0txy5u3Eg5MqyRg7aO+XS4UlhW5cu9dWZMwuGJYDNa+rP9DkLmd
         vvqCAy+gUq1aKcseRVJRN50XSmAW+gS1S85RDhndBIcJw8zDH3WUiqCTT3GY+QFCv8Dp
         GCSJhOBrxgVqGGeoYl2xQ3Ox9PBepf6vCsxZvZNrIynSzj0NNGmMftoKLfqZMSymWd6t
         erIFSAWlSWbyY9pFENmXXaOgaCICdyP86blJpcfX0k9pzEK8n0BFY2Zf5dWMr8Wg1sPn
         GCLpIWZS3I9VOycjq2MHalm6MOMxdckypl5EPWQMDRHW27l6acIc2AeuxYfmZWsB6iYL
         RpKA==
X-Forwarded-Encrypted: i=1; AJvYcCVXWCf1qm3JzS57ZSb/ky8xJT9R1bmWNbblfAuiLE+kteQDgY4oJLwIdZjdStMlRdIoTMRPjR6yJbl4kqeY/riWiOsj@vger.kernel.org, AJvYcCX0EpqYwQyYETrDveWxZkom74p6alInCqA/lIx+wFsQIbKZ7JoryftJuDBBZ130Z79kMi0=@vger.kernel.org, AJvYcCXV/XxMuh+zwHCrVtGkcTYjuW5AlNYGhLpE4wDbzn3K+/npvjQj0oDZvPtm80HlIetEk3OclIb0jcmorNvn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9qso7xOTQdVvDAW4epthUU8ZHxoH5F80uxamZCnly5N48omq
	mm/0JJC+eHeVpuBmCJjIwPJ1VIzEO3i4aWiEAu2b+Llc3fN6CZ+oPW5WiLEJ2bey++jxcz9LmI+
	0BhRUoA7zpzoQs2lsr8sL7teHj4Gc199V
X-Gm-Gg: ASbGncvvBpoHavkH8D458qlrrytURe7wIgyWTYCaiDpRnwWuQDUuPpP3SgqlfdCepQH
	zqgFAkRDGig0SCMHuVp0umZTNR4aGIBn547ai49v/L2NLZPTxA/xbjTLsxUOctioN3qASsKtsW4
	ZNfLHUd3Qese8SwBgNdnXTXnE=
X-Google-Smtp-Source: AGHT+IHQ2K37qTX1fEZF7ko7UiCt4pMglg8mPgIXzfrl9jd5UAh59OuT84s2Q4gOj2QoGC++CbghiX5E3jCLwNHXK24=
X-Received: by 2002:a17:90b:5686:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-2fe7e30045emr1918582a91.14.1740521472147; Tue, 25 Feb 2025
 14:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024044159.3156646-1-andrii@kernel.org> <20241024044159.3156646-3-andrii@kernel.org>
 <20250224-impressive-onyx-boa-36e85d@leitao> <CAEf4BzbupJe10k0MROG5iZq6cYu6PRoN3sHhNK=L7eDLOULvNQ@mail.gmail.com>
 <20250225-transparent-bronze-cobra-bafff4@leitao>
In-Reply-To: <20250225-transparent-bronze-cobra-bafff4@leitao>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 14:10:59 -0800
X-Gm-Features: AWEUYZniwBXSm-CS6dZMKJf5vIXpusGil3DJP8z2uRSMzGzi_NI3zZnx4fLHvtE
Message-ID: <CAEf4Bzae9ngTyKjt1O2PO6Udk7cC5M9VGLrvjCyTv2fbRRFy_Q@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
To: Breno Leitao <leitao@debian.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mingo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 3:46=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Andrii,
>
> On Mon, Feb 24, 2025 at 02:23:51PM -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 24, 2025 at 4:23=E2=80=AFAM Breno Leitao <leitao@debian.org=
> wrote:
> > >
> > > Hello Andrii,
> > >
> > > On Wed, Oct 23, 2024 at 09:41:59PM -0700, Andrii Nakryiko wrote:
> > > >
> > > > +static struct uprobe* hprobe_expire(struct hprobe *hprobe, bool ge=
t)
> > > > +{
> > > > +     enum hprobe_state hstate;
> > > > +
> > > > +     /*
> > > > +      * return_instance's hprobe is protected by RCU.
> > > > +      * Underlying uprobe is itself protected from reuse by SRCU.
> > > > +      */
> > > > +     lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&u=
retprobes_srcu));
> > >
> > > I am hitting this warning in d082ecbc71e9e ("Linux 6.14-rc4") on
> > > aarch64. I suppose this might happen on x86 as well, but I haven't
> > > tested.
> > >
> > >         WARNING: CPU: 28 PID: 158906 at kernel/events/uprobes.c:768 h=
probe_expire (kernel/events/uprobes.c:825)
> > >
> > >         Call trace:
> > >         hprobe_expire (kernel/events/uprobes.c:825) (P)
> > >         uprobe_copy_process (kernel/events/uprobes.c:691 kernel/event=
s/uprobes.c:2103 kernel/events/uprobes.c:2142)
> > >         copy_process (kernel/fork.c:2636)
> > >         kernel_clone (kernel/fork.c:2815)
> > >         __arm64_sys_clone (kernel/fork.c:? kernel/fork.c:2926 kernel/=
fork.c:2926)
> > >         invoke_syscall (arch/arm64/kernel/syscall.c:35 arch/arm64/ker=
nel/syscall.c:49)
> > >         do_el0_svc (arch/arm64/kernel/syscall.c:139 arch/arm64/kernel=
/syscall.c:151)
> > >         el0_svc (arch/arm64/kernel/entry-common.c:165 arch/arm64/kern=
el/entry-common.c:178 arch/arm64/kernel/entry-common.c:745)
> > >         el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:797)
> > >         el0t_64_sync (arch/arm64/kernel/entry.S:600)
> > >
> > > I broke down that warning, and the problem is on related to
> > > rcu_read_lock_held(), since RCU read lock does not seem to be held in
> > > this path.
> > >
> > > Reading this code, RCU read lock seems to protect old hprobe, which
> > > doesn't seem so.
> > >
> > > I am wondering if we need to protect it properly, something as:
> > >
> > >         @@ -2089,7 +2092,9 @@ static int dup_utask(struct task_struct=
 *t, struct uprobe_task *o_utask)
> > >                                 return -ENOMEM;
> > >
> > >                         /* if uprobe is non-NULL, we'll have an extra=
 refcount for uprobe */
> > >         +               rcu_read_lock();
> > >                         uprobe =3D hprobe_expire(&o->hprobe, true);
> > >         +               rcu_write_lock();
> > >
> >
> > I think this is not good enough. rcu_read_lock/unlock should be around
> > the entire for loop, because, technically, that return_instance can be
> > freed before we even get to hprobe_expire.
>
> re you suggesting that we should use an RCU read lock to protect the
> "traversal" of return_instances? In other words, is it currently being
> traversed unsafely, given that return_instance can be freed at any time?

Yes, that's what I was suggesting initially.

But reading through all this again and paging in all the context I had
when I was implementing this, I think this
lockdep_assert(rcu_read_lock_held()) is a false positive.

For timer thread, yes, we need to keep rcu_read_lock(), because timer
thread doesn't own return_instance, so it has to guarantee that memory
won't go away.

But dup_utask() is called for current thread's return_instances, so
they can't go anywhere and RCU read lock is not necessary here.

So I'm going to send a patch removing part of this lockdep_assert()
and will expand the comment with the actual lifetime rules.

>
> > So, just like we have guard(srcu)(&uretprobes_srcu); we should have
> > guard(rcu)();
> >
> > Except, there is that kmemdup() hidden inside dup_return_instance(),
> > so we can't really do that.
>
> Right. kmemdup() is using GFP_KERNEL, which might sleep, so, it cannot
> be called using rcu read lock.
>
> Thanks
> --breno

