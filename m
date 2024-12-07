Return-Path: <bpf+bounces-46342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6FC9E7D77
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 01:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1F5283009
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 00:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A7323D;
	Sat,  7 Dec 2024 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcrkplV2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2FB322B;
	Sat,  7 Dec 2024 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733530958; cv=none; b=kNSGY4RHBuRpajFVvxv8fQrewW0+9bWxDRqUruM8o/wz3MqJVj6iILZzp0ObJce7zTyydSokGt++VYU87qgYkGwnEJcazYIF0xO8kTrfUrSx2yNHAaChcNytI3QasVFi8PNro7exmocs8KFR+Gayv0xJ8Nf8ORshfDmIr/HVEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733530958; c=relaxed/simple;
	bh=oCamSO2nPoo5PaxiCQ1q7Evs2tTIFh3H8VgUidgiJcY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkYia1JZLGtf47XTuGef7/vhM+oMbwrtvZJMph+9TUc7sZZWRVG1JA5MEoNKjgYitexayaRdGF0YuZBrdg5VLTXW6HZZTNRK5fm9h96RcIbtD7S697QiSeKnTPipuZlR/K5+B0RvOYDUNbzADLmGdccSkZWFfS8TCtJFUTeycjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcrkplV2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a95095efso22043185e9.0;
        Fri, 06 Dec 2024 16:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733530955; x=1734135755; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CudEnZpIThg7QjdJNqmCo54UctlqIGUqSNkHUmYsSQQ=;
        b=OcrkplV2fBLHklsXMrVvw4ERandr/ZIfZkfL5A1S2VF7fcejgTpxWqBAI7fC14/9ea
         FBaT9v4sDGwmzx4bSkDhLwhILPFtllxylN4bAmlANhhgW9/Els97fQJLau//ywT0PTtN
         fMJmRCaEX2cPXRMTLGGKqO8PQ53agZG9zh3ORWyk0SWQrX7fGyDDQmULX/vPiAQeT22J
         j0PUbPbzWB2Pp1x2kTKxWKLvtKy2bJhmCIBketp4toDZdrjEQcCw6qvmknqP0JIF5+U8
         Od380OJpmjwM9RhsKpWrqNKDm37CQ6m31ErxTp4e9w9TetQUErkLdD1zjdVcU5TzhkJi
         z3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733530955; x=1734135755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CudEnZpIThg7QjdJNqmCo54UctlqIGUqSNkHUmYsSQQ=;
        b=WC0LkMsGbD3gmLA0IgeDQ/pKFWbS6UdEuZO0HuXPt9MHhizSBX4ZsdBfntZy8ctYX3
         yiPX5KlivU8wFGHgPz6adgkoPHPi92XERAN5nYVGJobc2hOjQ7OdK0yVjPetTLHkW1+M
         6b2H64nSgDV8fCF+S599UWCBqO2ugJWwdUveQ5AQ7jCLiX+2Kecd9hV8G2iJa6STcy3t
         UUizFpPMFJq87e3SP4N5sQcXlUnt5TYeLSNZRuSCMbexSlln2QuCtMpm7ng6QSlb/zr1
         /G0QbGUM7sErhO9NnNYu/+eeuPpel5Ma66qfJdCjKWSbvg3fDI7QT48i+Yh0D9I/oyZJ
         pt/w==
X-Forwarded-Encrypted: i=1; AJvYcCX8V/wPKZUctln8f2y9T9bAIWzgXRl5hHu7SaW/qS13H/M3kH9rg2K0HE+D4tvHbB1oe2Cb1QAnUKM7PPAqcN2OGA==@vger.kernel.org, AJvYcCXSAc7t9QhCX8iVRzqSW+Q8q6MK96SUnC6jHUJLbB2JjMEGXmXF1kLepRdF4uhYSMqHMZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWiDgxT03fpRwSZ5QUzZ6T3dC/PH1+tbGkz37ufroli/6soiMc
	jLrUs2GwqZhSWyfR87n/5pa5bOQkm+5V6BFZIEvxm3Xm06hE9xyy
X-Gm-Gg: ASbGncvQ0viStDClttEkTcRGWxwqiXe9t+7CCh2UXwGkniY+deHT+37YqoB9gXk072E
	95FSfsDXFowyBFzjm+Ukn5UO9Smio63MnRkgwvUvUCMeOq3Jfx0jKZ9GW6+PqdVSvzb6DQFvsqn
	lc+VwuUOv1nYHz22O05uTgIJoUSKABLvrS7k7TeiknSg+Qk4MuDFsARO72MMmSU98vk61RiQsJ7
	QGNHWF5WeZakp4B0PeRYuWhgB73ftbvEnHHxZ2qFIdC0rIuvxDND5AZDXo=
X-Google-Smtp-Source: AGHT+IHbLLZBKpkPaMXXV18qBxsuYB2b0QFGz5rGst5BlltKNUgAj0Z4mwV3rHXUAtMMjCV/DQcgXw==
X-Received: by 2002:a5d:6c66:0:b0:385:e45b:92a2 with SMTP id ffacd0b85a97d-3861bb5c4eamr7139918f8f.7.1733530954881;
        Fri, 06 Dec 2024 16:22:34 -0800 (PST)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d2303sm72350065e9.3.2024.12.06.16.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 16:22:34 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 7 Dec 2024 01:22:31 +0100
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
Message-ID: <Z1OVRwKCZ-ciWlAy@krava>
References: <20241023100131.3400274-1-jolsa@kernel.org>
 <CAEf4BzbZdaPaspRAVP7=UcfpFzR4qhksJTRiEwiZ9RDQtdg0bQ@mail.gmail.com>
 <Z1Mv3wjtonrX_ptM@krava>
 <CAEf4BzZ4nzqWcn9iNPhRY4dfhNWrMp+D8Gxs7eTBqie=g55o5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ4nzqWcn9iNPhRY4dfhNWrMp+D8Gxs7eTBqie=g55o5Q@mail.gmail.com>

On Fri, Dec 06, 2024 at 10:21:18AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 6, 2024 at 9:09 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Oct 23, 2024 at 09:01:02AM -0700, Andrii Nakryiko wrote:
> > > On Wed, Oct 23, 2024 at 3:01 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Peter reported that perf_event_detach_bpf_prog might skip to release
> > > > the bpf program for -ENOENT error from bpf_prog_array_copy.
> > > >
> > > > This can't happen because bpf program is stored in perf event and is
> > > > detached and released only when perf event is freed.
> > > >
> > > > Let's make it obvious and add WARN_ON_ONCE on the -ENOENT check and
> > > > make sure the bpf program is released in any case.
> > > >
> > > > Cc: Sean Young <sean@mess.org>
> > > > Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -ENOENT if exclude_prog not found")
> > > > Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy.programming.kicks-ass.net/
> > > > Reported-by: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  kernel/trace/bpf_trace.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > index 95b6b3b16bac..2c064ba7b0bd 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -2216,8 +2216,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
> > > >
> > > >         old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
> > > >         ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
> > > > -       if (ret == -ENOENT)
> > > > -               goto unlock;
> > > > +       if (WARN_ON_ONCE(ret == -ENOENT))
> > > > +               goto put;
> > > >         if (ret < 0) {
> > > >                 bpf_prog_array_delete_safe(old_array, event->prog);
> > >
> > > seeing
> > >
> > > if (ret < 0)
> > >     bpf_prog_array_delete_safe(old_array, event->prog);
> > >
> > > I think neither ret == -ENOENT nor WARN_ON_ONCE is necessary,  tbh. So
> > > now I feel like just dropping WARN_ON_ONCE() is better.
> >
> > hi,
> > there's syzbot report [1] where we could end up with following
> >
> >   - create perf event and set bpf program to it
> >   - clone process -> create inherited event
> >   - exit -> release both events
> >   - first perf_event_detach_bpf_prog call will release tp_event->prog_array
> >     and second perf_event_detach_bpf_prog will crash because
> >     tp_event->prog_array is NULL
> >
> > we can fix that quicly with change below, I guess we could add refcount
> > to bpf_prog_array_item and allow one of the parent/inherited events to
> > work while the other is gone.. but that might be too much, will check
> >
> > jirka
> >
> >
> > [1] https://lore.kernel.org/bpf/Z1MR6dCIKajNS6nU@krava/T/#m91dbf0688221ec7a7fc95e896a7ef9ff93b0b8ad
> > ---
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index fe57dfbf2a86..d4b45543ebc2 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2251,6 +2251,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
> >                 goto unlock;
> >
> >         old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
> > +       if (!old_array)
> > +               goto put;
> 
> How does this inherited event stuff work? You can have two separate
> events sharing the same prog_array? What if we attach different
> programs to each of those events, will both of them be called for
> either of two events? That sounds broken, if that's true.

so perf event with attr.inherit=1 attached on task will get inherited
by child process.. the new child event shares the parent's bpf program
and tp_event (hence prog_array) which is global for tracepoint

AFAICS when child process exits the inherited event is destroyed and it
removes related tp_event->prog_array, so the parent event won't trigger
ever again, the test below shows that

  test_tp_attach:FAIL:executed unexpected executed: actual 1 != expected 2

I'm not sure this is problem in practise, because nobody complained
about that ;-)

libbpf does not set attr.inherit=1 and creates system wide perf event,
so no problem there

jirka


---
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5a2d..2e96241b5030 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12430,8 +12430,9 @@ static int perf_event_open_tracepoint(const char *tp_category,
 	attr.type = PERF_TYPE_TRACEPOINT;
 	attr.size = attr_sz;
 	attr.config = tp_id;
+	attr.inherit = 1;
 
-	pfd = syscall(__NR_perf_event_open, &attr, -1 /* pid */, 0 /* cpu */,
+	pfd = syscall(__NR_perf_event_open, &attr, 0 /* pid */, 0 /* cpu */,
 		      -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
 	if (pfd < 0) {
 		err = -errno;
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach.c b/tools/testing/selftests/bpf/prog_tests/tp_attach.c
new file mode 100644
index 000000000000..01bbf1d1ab52
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "tp_attach.skel.h"
+
+void test_tp_attach(void)
+{
+	struct tp_attach *skel;
+	int pid;
+
+	skel = tp_attach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tp_attach__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	if (!ASSERT_OK(tp_attach__attach(skel), "tp_attach__attach"))
+		goto out;
+
+	getpid();
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+	if (pid == 0)
+		_exit(0);
+	waitpid(pid, NULL, 0);
+
+	getpid();
+
+	ASSERT_EQ(skel->bss->executed, 2, "executed");
+
+out:
+	tp_attach__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/tp_attach.c b/tools/testing/selftests/bpf/progs/tp_attach.c
new file mode 100644
index 000000000000..d9450d2eac17
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tp_attach.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid;
+int executed;
+
+SEC("tp/syscalls/sys_enter_getpid")
+int test(void *ctx)
+{
+	if (pid == (bpf_get_current_pid_tgid() >> 32))
+		executed++;
+	return 0;
+}

