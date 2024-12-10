Return-Path: <bpf+bounces-46439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C999EA33F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 01:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3D28140E
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A5E70809;
	Tue, 10 Dec 2024 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLI3MXf0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E12A934;
	Tue, 10 Dec 2024 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788881; cv=none; b=pnJW7IvdhGExVbOClrnfQPfyBhSFfQGVrJI0OM8XjJufuM7vfaMpp6ajQX/DiubZmYt3EeOmF1QLlpiZzAzcS+Fie9QGJg99Y+f+th1fSyWR75Nnea/AC3nhBwhbMJksTLWr87JP4I96XdDHxryDQXB9Xp0hSz0TBJihTcC5h8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788881; c=relaxed/simple;
	bh=fikgOv12/itNT+JgbfJBQq4WyA1T+dBODFDUQT46yTQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5/CXifyu9rohHAw+4jM4DiygxtkrA+o0lR4S1rsOou0NwhAj796mtIi9F7uz0Ay2hHjVmP7C05F0YcoA2dlgTq7/j+AefFKWzwz//l1GjgZAJlYWfm20NNqIeKu7fPlWXDUYtnvBG8LU+qRX8JTR8qRsSQWvKtPZmSzXj3yS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLI3MXf0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso2495932f8f.2;
        Mon, 09 Dec 2024 16:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733788875; x=1734393675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl6Y9bi+Z4FlsZwTXynGXVyz92LB6LqQgK6m3thaUUs=;
        b=kLI3MXf0DTrhcGfDgnhY2kZ2JCftVL7I47l1TDubWYxNu1dyofPnSk3NbjDOiDTfHz
         fsUEqBjYjJrYKYxbFPEqqjV0DXt34AXkifKuvHF5wf5XUYHA0SpD8JrrGnkyy55moSD7
         fYmUufGJpC8yfBnp0rvSXFX7NgJFSih50BFzb6jO+Y3chNAHIpJTTwb99o3aQL/nh5rT
         JZmeZuk6tPKXSvwwUM2VQ7RdNQnC/Tx3Ip6V0zYASI5tGvpAHg475ZghTMykg0DiMBnk
         mUCy0/heGt6XYgH/Y4SmzdzQ5TGyMg1J2ayKtWvL4FdE1+fuYo3pQlQFkhhCusoZajFG
         9L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733788875; x=1734393675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl6Y9bi+Z4FlsZwTXynGXVyz92LB6LqQgK6m3thaUUs=;
        b=JyssHi8RHILenjne1miodYClsrSRRfqRR4JxQGKqMH+kWyKPWFQO64ZJCBX+XOwG4l
         9g7g+fs9FEbblB53dHrMkcVwza6ibDVylYKveDPJXoq+QtwpGkEiaVk1jkdJvfjQK9Au
         QKsyhn+tQJu3J3bSZTUrFUaeCCic35129MG1wH/J05MQMoeOplDZZvuXRqSMfHFn9XHF
         yFS9AqQ+TM0PWNL6h8H8OMkm0HR8mU7qeyg/AMvgmoLcTO/GikiMhji7+wet8vgKbFPP
         B0y9g92V/bR1nmifMC2O++1K4SSCpSRksNlMp7977p9mG/xIPuUF67pcNFch10SQ5MLm
         55lw==
X-Forwarded-Encrypted: i=1; AJvYcCU3RVByBt7ApNMY4VxZ4WYgRk3Js1WijyGyVKuoysRFmwyI8yszuwZ5XOFmAVBrfPu90DE=@vger.kernel.org, AJvYcCXQU2txnJ5QDqPSTLc2u33eXZxHOMFgLJTtoZRDw9qJ80lSVq/OHjyLvt/vGksR0TyVBsfwqJxTl5BpS/8PreQY2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmK3kuKE9f/bj4AUEhq3d6B/9RwZoImOx4E+x0BCvZYzKqz+Vn
	Hc5LmpR88IKlEtU1V2zJQa8QIue1lSOUF1H62atFHLvSEW0qhdWq
X-Gm-Gg: ASbGncsbAYlnUxYaahXlkRCKNLVhy6fvM9KVmkHq0FHBTQuZ3QOMklq/fbXvz7hBgX9
	ydEx0uhb+rGJiVwuocWAtVPfSAHnzsrAwHWE1ZhBRnjgFZsfN4WmT91NE7oSBXGIAL+slgRRd3k
	oDwCUQw15/7FzfqokuLQlMCZJzPtZ0e1S71rGMk9dpSdZLPWzEZtjKTOvDm+F5Kkm6bboUFM0zB
	emyHQWjRevL5yHXiCb++2hcEbPKWd4XIybZ8KSrMN54kjGLzHL41KSI9favgg0=
X-Google-Smtp-Source: AGHT+IGDlMkG0o53mq2En+j0ghTi3OaJMI4Wyqv6rJcwTLxqswpBwbH8V7lcgmj1zvGwpoS32I2fUg==
X-Received: by 2002:a05:6000:18a5:b0:385:fb34:d5a0 with SMTP id ffacd0b85a97d-386453e1d5emr2575241f8f.29.1733788875260;
        Mon, 09 Dec 2024 16:01:15 -0800 (PST)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbe15sm14289771f8f.92.2024.12.09.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:01:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Dec 2024 01:01:12 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Sean Young <sean@mess.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf,perf: Fix perf_event_detach_bpf_prog error
 handling
Message-ID: <Z1eEyEWLiUx0jC0v@krava>
References: <20241023100131.3400274-1-jolsa@kernel.org>
 <CAEf4BzbZdaPaspRAVP7=UcfpFzR4qhksJTRiEwiZ9RDQtdg0bQ@mail.gmail.com>
 <Z1Mv3wjtonrX_ptM@krava>
 <CAEf4BzZ4nzqWcn9iNPhRY4dfhNWrMp+D8Gxs7eTBqie=g55o5Q@mail.gmail.com>
 <Z1OVRwKCZ-ciWlAy@krava>
 <CAEf4BzbGnAAihFg8FYB-yKVLn4D6iHoL98r+PhiBEeJHRYT3sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbGnAAihFg8FYB-yKVLn4D6iHoL98r+PhiBEeJHRYT3sg@mail.gmail.com>

On Mon, Dec 09, 2024 at 09:49:01AM -0800, Andrii Nakryiko wrote:

SNIP

> > > > ---
> > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > index fe57dfbf2a86..d4b45543ebc2 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -2251,6 +2251,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
> > > >                 goto unlock;
> > > >
> > > >         old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
> > > > +       if (!old_array)
> > > > +               goto put;
> > >
> > > How does this inherited event stuff work? You can have two separate
> > > events sharing the same prog_array? What if we attach different
> > > programs to each of those events, will both of them be called for
> > > either of two events? That sounds broken, if that's true.
> >
> > so perf event with attr.inherit=1 attached on task will get inherited
> > by child process.. the new child event shares the parent's bpf program
> > and tp_event (hence prog_array) which is global for tracepoint
> >
> > AFAICS when child process exits the inherited event is destroyed and it
> > removes related tp_event->prog_array, so the parent event won't trigger
> > ever again, the test below shows that
> >
> 
> Doesn't this sound broken? Either event inheritance has to copy
> prog_array and make them completely independent. Or inherited event
> shouldn't remove the parent's program. Or something else, but the way
> it is right now seems wrong, no?
> 
> I'm not sure what's the most appropriate behavior that would match
> overall perf_event inheritance, but we should probably think about
> this and fix it, instead of patching up the symptom with that NULL
> check, no?
> 
> >   test_tp_attach:FAIL:executed unexpected executed: actual 1 != expected 2
> >
> > I'm not sure this is problem in practise, because nobody complained
> > about that ;-)
> 
> That's... not really a distinction of what is a problem or not ;)
> 
> >
> > libbpf does not set attr.inherit=1 and creates system wide perf event,
> > so no problem there
> 
> you can use all this outside of libbpf and lead to wrong behavior, so
> worth thinking about this and fixing, IMO

sure, let's fix that.. I like the solution where we let only the parent
to remove the program from prog_array looks good to me and is probably
simple enough.. but need to check what happens when parent dies first

I'll check on that, but perhaps we could go with the simple fix first
to fix the crash (it was the prior behaviour) and I'll send the fix on
top of that

jirka

> 
> >
> > jirka
> >
> >
> > ---
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 66173ddb5a2d..2e96241b5030 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -12430,8 +12430,9 @@ static int perf_event_open_tracepoint(const char *tp_category,
> >         attr.type = PERF_TYPE_TRACEPOINT;
> >         attr.size = attr_sz;
> >         attr.config = tp_id;
> > +       attr.inherit = 1;
> >
> > -       pfd = syscall(__NR_perf_event_open, &attr, -1 /* pid */, 0 /* cpu */,
> > +       pfd = syscall(__NR_perf_event_open, &attr, 0 /* pid */, 0 /* cpu */,
> >                       -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
> >         if (pfd < 0) {
> >                 err = -errno;
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach.c b/tools/testing/selftests/bpf/prog_tests/tp_attach.c
> > new file mode 100644
> > index 000000000000..01bbf1d1ab52
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach.c
> > @@ -0,0 +1,35 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "tp_attach.skel.h"
> > +
> > +void test_tp_attach(void)
> > +{
> > +       struct tp_attach *skel;
> > +       int pid;
> > +
> > +       skel = tp_attach__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "tp_attach__open_and_load"))
> > +               return;
> > +
> > +       skel->bss->pid = getpid();
> > +
> > +       if (!ASSERT_OK(tp_attach__attach(skel), "tp_attach__attach"))
> > +               goto out;
> > +
> > +       getpid();
> > +
> > +       pid = fork();
> > +       if (!ASSERT_GE(pid, 0, "fork"))
> > +               goto out;
> > +       if (pid == 0)
> > +               _exit(0);
> > +       waitpid(pid, NULL, 0);
> > +
> > +       getpid();
> > +
> > +       ASSERT_EQ(skel->bss->executed, 2, "executed");
> > +
> > +out:
> > +       tp_attach__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/tp_attach.c b/tools/testing/selftests/bpf/progs/tp_attach.c
> > new file mode 100644
> > index 000000000000..d9450d2eac17
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tp_attach.c
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +int pid;
> > +int executed;
> > +
> > +SEC("tp/syscalls/sys_enter_getpid")
> > +int test(void *ctx)
> > +{
> > +       if (pid == (bpf_get_current_pid_tgid() >> 32))
> > +               executed++;
> > +       return 0;
> > +}

