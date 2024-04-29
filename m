Return-Path: <bpf+bounces-28121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E48B5F47
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115711C217FD
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B885C76;
	Mon, 29 Apr 2024 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwtcTq69"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B31DA23;
	Mon, 29 Apr 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408928; cv=none; b=hIHeNtk0FSLUYfNqPaKm4rxb+ShUq1JCIMH+xX4WXuGKCUDj7a2gBqk/kgHSyDpDUe40AcPJkj7lvrdbmSaeXijRHt66d/KpfsdTc67Gc6bbhszIwBwEfEy9w20YLvhA1MhWT9T88BADP1BS2hNJ9gahCcvOmrY2VDGuFR7Nxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408928; c=relaxed/simple;
	bh=UhXiadpeGI3efarCSZ4ivzcXZaiIy+ZRiyi3kVtsmMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sw5nmJgIgsmxq7WvvWnYNr4tSkbbd9c0T1nYzIFJ1g53ppPH5JIaAzsnTOeBHaO9Jyw+W6wkir5Sj735ZT9dXOKQKiHGHyFRN/oEfqvJEd+/ZkX91tL/fuDZpLzbI2++p+jNHLk1PSJkjspi2PRSBtJg2Ik8WPsx4TPfTi94gZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwtcTq69; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6082fd3e96eso3332122a12.1;
        Mon, 29 Apr 2024 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714408926; x=1715013726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Jd7Oanm4nSiWiwnB9IwoLbTq10zAou5UxTuvdRgHBc=;
        b=YwtcTq69BLrnegOzbP0ZHEsAbgDVTfh1D8rmsZrBj0Y0iXaqLGRNNjE7pgbhPwxdgE
         +Xsvx3i2jAGHgdO1Ytbk+lzWIQCO/PBHTl0TOrE7zwRixbaBB7+qHBu0j5sfECjMBOhj
         QHyYJDewiagQo5rZTLQQUll7XCDZU/MoG/EgFIQny2+/OuPN8UyAdobppuVMUtUuEjwI
         zLIWFYTz/OHQmnc42rhuaasj6xE+V+rNKfgrqY3MtOyvurcXfILdexOm0Sm8tlDYT5ZA
         UYd/PbckhzF5rhaOBPD8xqjy8uuOfuFHXnshf5MufDuepSOYAXyxGBho7/UW5HZLYzV1
         OOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408926; x=1715013726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Jd7Oanm4nSiWiwnB9IwoLbTq10zAou5UxTuvdRgHBc=;
        b=X0+jBWh2+o+ZapjgZWvavk93V6Esnm6Q2d0ytRjOZ47GVUeL4f78FCVk9yRYHURrEY
         hOSIiGskWmcxJeBNUMaAjbRGdAca4jDRAENrBIAaUXkJJBsT1AS9eTF8eAborBLJYjaa
         Qo2yc/IlG1N29bgRoAHDxK2J2/yjqBZKz2yJXaBYzggah9Eq4ybP57+lZrkC/UfeEBzg
         hAPhY7nGCI8Jr4Xarn1nbwr5RYHnbKgfEO/OFkxKvBEmftPF6dnrec5oJcQjAAPZV1UB
         /WOqUsXw3NSqNqt24wvBZzzPOorfTmj9XGHSAfPejQU/lUHGI2ToFlAtFOX4936r8gMB
         iLWg==
X-Forwarded-Encrypted: i=1; AJvYcCUE9Fo8gV36+gQS1yViSYqZ7R+CFHbI266kxLc4H4YC3qa8f61kb+eumkmCPW6o23wHxgzz5Iil92D02iqZOWZc64DfFHI2mqUmn3FJS7SIuHe7FD2ESUOYMolKvY26K1DQ+kkLq4F71TfKzA9ZD5SXQS6PQFN7Iaa3jT6LocxRAHdC2QxL8t62CZk/NTGIKkv4lBOSdZnlslihkSJWPjws
X-Gm-Message-State: AOJu0YwVKi04TnE6NZzPz8cclDUaVQL7r9apxXOajrwI9x8EZAWPGDAD
	K1tzWBR+MhV1TtR7GONP8PczBl7KVq5pBO5tyOILxZJAJ9jh8hdcN3j7NAnNECi6M3vhCOJGzY9
	orBtiFroZsAq9rY2LeUvVnHEzsQs=
X-Google-Smtp-Source: AGHT+IE4IxzjkZnZxeSMThIyMWUmuVBhMxbEPOeKEToWqcmhE/J9jTcxCoAmje/rhqZ2jx6YJT0zAmHXpRs/eYj05/A=
X-Received: by 2002:a17:90a:df02:b0:2ad:fa29:3989 with SMTP id
 gp2-20020a17090adf0200b002adfa293989mr9166083pjb.19.1714408926072; Mon, 29
 Apr 2024 09:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421194206.1010934-1-jolsa@kernel.org> <20240421194206.1010934-6-jolsa@kernel.org>
 <CAEf4BzbWr9s2HiWU=7=okwH7PR8LHGFj2marmaOxKW61BWKHGg@mail.gmail.com> <Zi9NPfII8I7nWz6O@krava>
In-Reply-To: <Zi9NPfII8I7nWz6O@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 09:41:53 -0700
Message-ID: <CAEf4BzY8K6GXtdRkmo3b=ZnW=6jQZnDMtBbGOQpP8m7boTJRpg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 5/7] selftests/bpf: Add uretprobe syscall call
 from user space test
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

On Mon, Apr 29, 2024 at 12:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Fri, Apr 26, 2024 at 11:03:29AM -0700, Andrii Nakryiko wrote:
> > On Sun, Apr 21, 2024 at 12:43=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> w=
rote:
> > >
> > > Adding test to verify that when called from outside of the
> > > trampoline provided by kernel, the uretprobe syscall will cause
> > > calling process to receive SIGILL signal and the attached bpf
> > > program is no executed.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 92 +++++++++++++++++=
++
> > >  .../selftests/bpf/progs/uprobe_syscall_call.c | 15 +++
> > >  2 files changed, 107 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_=
call.c
> > >
> >
> > See nits below, but overall LGTM
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > [...]
> >
> > > @@ -219,6 +301,11 @@ static void test_uretprobe_regs_change(void)
> > >  {
> > >         test__skip();
> > >  }
> > > +
> > > +static void test_uretprobe_syscall_call(void)
> > > +{
> > > +       test__skip();
> > > +}
> > >  #endif
> > >
> > >  void test_uprobe_syscall(void)
> > > @@ -228,3 +315,8 @@ void test_uprobe_syscall(void)
> > >         if (test__start_subtest("uretprobe_regs_change"))
> > >                 test_uretprobe_regs_change();
> > >  }
> > > +
> > > +void serial_test_uprobe_syscall_call(void)
> >
> > does it need to be serial? non-serial are still run sequentially
> > within a process (there is no multi-threading), it's more about some
> > global effects on system.
>
> plz see below
>
> >
> > > +{
> > > +       test_uretprobe_syscall_call();
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c =
b/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
> > > new file mode 100644
> > > index 000000000000..5ea03bb47198
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
> > > @@ -0,0 +1,15 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include "vmlinux.h"
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <string.h>
> > > +
> > > +struct pt_regs regs;
> > > +
> > > +char _license[] SEC("license") =3D "GPL";
> > > +
> > > +SEC("uretprobe//proc/self/exe:uretprobe_syscall_call")
> > > +int uretprobe(struct pt_regs *regs)
> > > +{
> > > +       bpf_printk("uretprobe called");
> >
> > debugging leftover? we probably don't want to pollute trace_pipe from t=
est
>
> the reason for this is to make sure the bpf program was not executed,
>
> the test makes sure the child gets killed with SIGILL and also that
> the bpf program was not executed by checking the trace_pipe and
> making sure nothing was received
>
> the trace_pipe reading is also why it's serial

you could have attached BPF program from parent process and use a
global variable (and thus eliminate all the trace_pipe system-wide
dependency), but ok, it's fine by me the way this is done

>
> jirka
>
> >
> > > +       return 0;
> > > +}
> > > --
> > > 2.44.0
> > >

