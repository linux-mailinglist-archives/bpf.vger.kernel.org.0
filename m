Return-Path: <bpf+bounces-28122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21488B5F53
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28BC1C218E0
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B668612E;
	Mon, 29 Apr 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC2j9zaz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EF84D15;
	Mon, 29 Apr 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409103; cv=none; b=hiGXx6WFcUTQ+l2uaJ0oTrPe+jYp03n06j/X9xnGZ7iDaS8K/LYjgLoEyujNi9/ghtfOuBqtNHGZJhp3F1wU8xbQAL/UQBPTvjOBVYJxNFvMowBe2nBJKhcxPThsCzwOHaANDKmz4AYlZc/TxPmI9RpxxnZhZqCUUqawX7stK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409103; c=relaxed/simple;
	bh=zI0dXaWwW2H477UXrfRvW/LEn5xqCYL9yuMn0epTlnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6wX9n40Q34byiPLn3qbf4feYLQt7aOGvGl9PmlWKm4xBVRwngK6wNda1rn0thYrENHko9UFNpKJV/2cYfQJBVtxhAIqnr5xh6BBAIuFi2Tx1bFDSafIw1enisdhAAMFIAZ4S6VyGrfUeTepsJZICCtPQjC5Lmw9DlorAKN4Svw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC2j9zaz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3145793a12.3;
        Mon, 29 Apr 2024 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714409102; x=1715013902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+KuYncKCMIQks9fs4VyYRoQJJHDbH+WTIrj3yfpnG4=;
        b=bC2j9zazdkM2QJZxDgAkKgtMBRn3WT/p5QUOMG/IAoQAkjCmNBrGJoxwy48ELUyz+N
         +aZqi0n2Y5xfnIvgkZ6RR6ZOYF7vxBD6lADP65/9ZCf/vehFbWHRwv00ntPxJM1PtVbQ
         7T5gAOXDKWZXCsWa1ppmV0aBP34AlB3LWd01BSzYmpQRYZmZPXJ/6kLkaQUZvjUyevjs
         QMekB4kPY1gniiLvzOi6XIWdXk1Wc2k3H/w/EVqIJI/KXRdu+jDiLCYYAkSOF6TwBK0r
         D3qSItEJk6RVuhkurXham9anF+hX7lech3TSFpzAqcYFpz5vl6CHhzbU2kxqgLV9IRLY
         GOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714409102; x=1715013902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+KuYncKCMIQks9fs4VyYRoQJJHDbH+WTIrj3yfpnG4=;
        b=pEGt0Djr6B7NYC6hAuOCGQwRjyMm9KEQ6TvM2NNABgMVo6O7pg6GexGwC+dhA1z13y
         MuMuSi39EoZYpzR/NCC6ff/2Ac+XHyIMN6o/ujCImwDkOhMQqQKthcEZJqGGWHkS+rlU
         9uIO41TrVZyuoi5LjSGKBfCCc83+B3kDOYYs1jVfEbXRuUo7lYwFoOiE4k8KtAQBkW4E
         Dc4/WYpCA5Nk4LAeiUjarg8WtQO3cLI6l0soBLsgONSHstG0Qx5Tz60Ew7DXLCmJ0CFi
         Lk+lPl3mZR4YLzYncvrljP36Iv9wL2fRLVl3JuzufyxviMtZBFQUVi5a3/RAYUkAiUZQ
         ybmg==
X-Forwarded-Encrypted: i=1; AJvYcCUh3dQbbudMM1klOfgmLTWGdgpUhxYRRnKoLHd2UT6zvTjrjuns+F5Fxl8/2x5OshNCptpPERN0FjiS7YXvd26o0i5jM5++ePPXkdUrwDVbCsU9J/kN1LWaTZoYQ9ljP93CyLQHA8MY+GZSXb9qZ7aK/IlMLJQvJM4BcJpMbSBmqGB1CQyvRKK4oNghYSHiGbR1AfL5jdKXeQT9lBwW4d46
X-Gm-Message-State: AOJu0YzzaZOKr3xVVpufanHcMMeLwn9/s6H3ORhYoaIcsQf67XgK/fgb
	/p2V5s27iAO+/GJhcXWo/kkDbhiMbb3/eT7+Tw0ruudk1kDPV2a9nHqm0JoAKxNP6BpvAQpk4Yh
	25Gc0WAeGwfqHezhysddd3/Ask5s=
X-Google-Smtp-Source: AGHT+IFEBjjOgIZI69S9O+DPbxRJS29XWyaWX2RRt0TM1E47XRESlvdqoITxR7rPoljfCms3ptvnuElmViiIbq0BAf0=
X-Received: by 2002:a17:90b:3e89:b0:2b0:d163:3131 with SMTP id
 rj9-20020a17090b3e8900b002b0d1633131mr6513981pjb.17.1714409101691; Mon, 29
 Apr 2024 09:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421194206.1010934-1-jolsa@kernel.org> <20240421194206.1010934-7-jolsa@kernel.org>
 <CAEf4BzYU-y+vptqXpuALYecJJgPt+CTcbo+=Q9QXnu4vNwem+g@mail.gmail.com> <Zi9OwCwluxTo-Azd@krava>
In-Reply-To: <Zi9OwCwluxTo-Azd@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 09:44:49 -0700
Message-ID: <CAEf4Bzb6M=8x6=WMZq8GDB3gS4kejsB9QaVSNEc1MwWbX_vvUQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 6/7] selftests/bpf: Add uretprobe compat test
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:39=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Fri, Apr 26, 2024 at 11:06:53AM -0700, Andrii Nakryiko wrote:
> > On Sun, Apr 21, 2024 at 12:43=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> w=
rote:
> > >
> > > Adding test that adds return uprobe inside 32 bit task
> > > and verify the return uprobe and attached bpf programs
> > > get properly executed.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/.gitignore        |  1 +
> > >  tools/testing/selftests/bpf/Makefile          |  6 ++-
> > >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 40 +++++++++++++++++=
++
> > >  .../bpf/progs/uprobe_syscall_compat.c         | 13 ++++++
> > >  4 files changed, 59 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_=
compat.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/s=
elftests/bpf/.gitignore
> > > index f1aebabfb017..69d71223c0dd 100644
> > > --- a/tools/testing/selftests/bpf/.gitignore
> > > +++ b/tools/testing/selftests/bpf/.gitignore
> > > @@ -45,6 +45,7 @@ test_cpp
> > >  /veristat
> > >  /sign-file
> > >  /uprobe_multi
> > > +/uprobe_compat
> > >  *.ko
> > >  *.tmp
> > >  xskxceiver
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/sel=
ftests/bpf/Makefile
> > > index edc73f8f5aef..d170b63eca62 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -134,7 +134,7 @@ TEST_GEN_PROGS_EXTENDED =3D test_sock_addr test_s=
kb_cgroup_id_user \
> > >         xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_me=
tadata \
> > >         xdp_features bpf_test_no_cfi.ko
> > >
> > > -TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe=
_multi
> > > +TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe=
_multi uprobe_compat
> >
> > you need to add uprobe_compat to TRUNNER_EXTRA_FILES as well, no?
>
> ah right
>
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c =
b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > index 9233210a4c33..3770254d893b 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > @@ -11,6 +11,7 @@
> > >  #include <sys/wait.h>
> > >  #include "uprobe_syscall.skel.h"
> > >  #include "uprobe_syscall_call.skel.h"
> > > +#include "uprobe_syscall_compat.skel.h"
> > >
> > >  __naked unsigned long uretprobe_regs_trigger(void)
> > >  {
> > > @@ -291,6 +292,35 @@ static void test_uretprobe_syscall_call(void)
> > >                  "read_trace_pipe_iter");
> > >         ASSERT_EQ(found, 0, "found");
> > >  }
> > > +
> > > +static void trace_pipe_compat_cb(const char *str, void *data)
> > > +{
> > > +       if (strstr(str, "uretprobe compat") !=3D NULL)
> > > +               (*(int *)data)++;
> > > +}
> > > +
> > > +static void test_uretprobe_compat(void)
> > > +{
> > > +       struct uprobe_syscall_compat *skel =3D NULL;
> > > +       int err, found =3D 0;
> > > +
> > > +       skel =3D uprobe_syscall_compat__open_and_load();
> > > +       if (!ASSERT_OK_PTR(skel, "uprobe_syscall_compat__open_and_loa=
d"))
> > > +               goto cleanup;
> > > +
> > > +       err =3D uprobe_syscall_compat__attach(skel);
> > > +       if (!ASSERT_OK(err, "uprobe_syscall_compat__attach"))
> > > +               goto cleanup;
> > > +
> > > +       system("./uprobe_compat");
> > > +
> > > +       ASSERT_OK(read_trace_pipe_iter(trace_pipe_compat_cb, &found, =
1000),
> > > +                "read_trace_pipe_iter");
> >
> > why so complicated? can't you just set global variable that it was call=
ed
>
> hm, we execute separate uprobe_compat (32bit) process that triggers the b=
pf
> program, so we can't use global variable.. using the trace_pipe was the o=
nly
> thing that was easy to do

you need child process to trigger uprobe, but you could have installed
BPF program from parent process (you'd need to make child wait for
parent to be ready, with normal pipe() like we do in other places).

I think generally the less work forked child process does, the better.
All those ASSERT() failures won't produce any output in child process,
unless you run tests in verbose mode, because we haven't implemented
some form of sending all the logs back to the parent process and so
they are completely lost. But that's a separate topic.

Either way, consider using pipe() to coordinate waiting from child on
parent being ready, but otherwise do all the BPF-related heavy lifting
from parent (you can attach BPF programs to specific PID using
bpf_program__attach_uprobe() easily, it's not declarative, but simple
enough).

>
> jirka
>
> >
> > > +       ASSERT_EQ(found, 1, "found");
> > > +
> > > +cleanup:
> > > +       uprobe_syscall_compat__destroy(skel);
> > > +}
> > >  #else
> > >  static void test_uretprobe_regs_equal(void)
> > >  {
> > > @@ -306,6 +336,11 @@ static void test_uretprobe_syscall_call(void)
> > >  {
> > >         test__skip();
> > >  }
> > > +
> > > +static void test_uretprobe_compat(void)
> > > +{
> > > +       test__skip();
> > > +}
> > >  #endif
> > >
> > >  void test_uprobe_syscall(void)
> > > @@ -320,3 +355,8 @@ void serial_test_uprobe_syscall_call(void)
> > >  {
> > >         test_uretprobe_syscall_call();
> > >  }
> > > +
> > > +void serial_test_uprobe_syscall_compat(void)
> >
> > and then no need for serial_test?
> >
> > > +{
> > > +       test_uretprobe_compat();
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.=
c b/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
> > > new file mode 100644
> > > index 000000000000..f8adde7f08e2
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
> > > @@ -0,0 +1,13 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <linux/bpf.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +
> > > +char _license[] SEC("license") =3D "GPL";
> > > +
> > > +SEC("uretprobe.multi/./uprobe_compat:main")
> > > +int uretprobe_compat(struct pt_regs *ctx)
> > > +{
> > > +       bpf_printk("uretprobe compat\n");
> > > +       return 0;
> > > +}
> > > --
> > > 2.44.0
> > >

