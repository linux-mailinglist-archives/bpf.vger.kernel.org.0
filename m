Return-Path: <bpf+bounces-28063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332A18B527B
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 09:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29EC1F21A8F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A614AB7;
	Mon, 29 Apr 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGr7PBjU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFEFF9C3;
	Mon, 29 Apr 2024 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376392; cv=none; b=Am4xWMzoLqJhuSuBs4UdmuP6tkBFfTF3EdyERxZ6EO3Ui2LlE81PNEfKGfkn3lHjoBN2YWkGBdhmFzvNQBhVVFvEv4ByVD5sR+DXm+m1Zk95PBBIY/j0DX6iIgJG7GFccnoffsXlt33/nYmyAHWGkTXT5pA9PgQUK8BatkC1pgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376392; c=relaxed/simple;
	bh=UphalLt9XY0n2jI2YjP5Yut1haELAieKBS8EabKM3wM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvkPMh8jMFTA10Ju283GpSp7o/L62eyhxQenevVUnjlKJi0hkCAMPQabckHsQCHjdwWObfLKMcJl47w/8E2lF6d5hmXWs1pERvE20qSVASbT+TjeSBskflSfaUaMUhFqalkkRs4iFXkT14wFgM+/hsF0UA2z+XW7MOZ7y2jTlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGr7PBjU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a58fc650f8fso78196866b.1;
        Mon, 29 Apr 2024 00:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714376388; x=1714981188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n4Xjp3YBgOOmdabmdq2j2HuYSlJlL8M+66Vr2XUSO3E=;
        b=IGr7PBjUlf7rpFRjNM336aDYyBamyUJuWoEp42ixge9HbmEvKJO5PJLjz5OD0dF0/f
         FsuSSwPC+hdKFQMgHhKsH5sscyxJdQkdER0u75aecJb41EF6TiexRU/uOcA6Tr9VxxN5
         YwcK8ipjD0L6bP3dOx2WFcJe54hm7HB3tY+djl8cov/q828RPYaXqr2zaTVrEHqhNwcH
         r7JZUjez6qk0S/ADjWwybSz8lJ/6BdkqdHsAsn5+sJax0TvwfzhuLmZ6u11qEg10nh2+
         XqZZnpMb/XYr0r3yqTDAdqfzRh0TTlrL9CyPQxjAJLW547vDVVg0Nkfjafc5lVqBsFRL
         IFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714376388; x=1714981188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4Xjp3YBgOOmdabmdq2j2HuYSlJlL8M+66Vr2XUSO3E=;
        b=iQiFDPuPIraSEsUMODwv/TSwdFgbFsa3Wpk9DiTgaMt7WEPHnsRwg/4FGIFemYMQ/a
         WmwQyBJRKN+xNAYUuj9862uFudUIjNeFU9cuc+PFnuSTOIPK9NUiQT31DQTvGqIdws6v
         T2IyuLnQ5DpgY6q/6+gXbix4QR9+eWe4ljrlTUWtZwlUShnYuutIs87uYrFg0gRGGcFt
         PKhPEn28Lqk2kQDLET/bN4kYqckcU6ebJOmgTN0Oarvc658YCBDaqyYWuGxdwKwqBOej
         kj6xpOpCEo0Obn7CWHEi6cQNKAP0S0uXqKu0XGeeKOR1QKmid+fJmQJXbLd2RMcO9Fg/
         caxw==
X-Forwarded-Encrypted: i=1; AJvYcCU4JOACjNII6X94kKp6ff1/+zCkU6eTV/yMXJZhvEhxMa92y9E3AODYIbGt3HW2lTj7zcA/as6CTHWWd+yHBNwjh7syZ3yfPiDTW2idMqfbpG0VKGGxRmp56OcUN5qU22DZhrvnF751KpJHvflT9iqps2+L4gSj8B2ilSTaDdn/9vWnH0WAbAmVqulakZqnWa2IA0oFIxsZnj74ACcH+kOv
X-Gm-Message-State: AOJu0YzZ914A9On5vZxU34EPvD8VcDYCnd/ZNK3ATQ/pzVH+br9Wurd2
	IS23cIGn44KHgtzqlH+/QyfXM89l8W6SoFyBHYjFQ9jUyGQNTAzh
X-Google-Smtp-Source: AGHT+IEqa9yRIrp06/04PheOKBHYtCM/9AiTrchW8jE3vbnQfjoFvAGyutkxxq/zdb66waj1MFjGgg==
X-Received: by 2002:a17:906:a192:b0:a55:b11d:ccbb with SMTP id s18-20020a170906a19200b00a55b11dccbbmr5847170ejy.74.1714376388241;
        Mon, 29 Apr 2024 00:39:48 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id lu10-20020a170906faca00b00a52299d8eecsm13440610ejb.135.2024.04.29.00.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:39:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 Apr 2024 09:39:44 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv3 bpf-next 6/7] selftests/bpf: Add uretprobe compat test
Message-ID: <Zi9OwCwluxTo-Azd@krava>
References: <20240421194206.1010934-1-jolsa@kernel.org>
 <20240421194206.1010934-7-jolsa@kernel.org>
 <CAEf4BzYU-y+vptqXpuALYecJJgPt+CTcbo+=Q9QXnu4vNwem+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYU-y+vptqXpuALYecJJgPt+CTcbo+=Q9QXnu4vNwem+g@mail.gmail.com>

On Fri, Apr 26, 2024 at 11:06:53AM -0700, Andrii Nakryiko wrote:
> On Sun, Apr 21, 2024 at 12:43 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test that adds return uprobe inside 32 bit task
> > and verify the return uprobe and attached bpf programs
> > get properly executed.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/.gitignore        |  1 +
> >  tools/testing/selftests/bpf/Makefile          |  6 ++-
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 40 +++++++++++++++++++
> >  .../bpf/progs/uprobe_syscall_compat.c         | 13 ++++++
> >  4 files changed, 59 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
> >
> > diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> > index f1aebabfb017..69d71223c0dd 100644
> > --- a/tools/testing/selftests/bpf/.gitignore
> > +++ b/tools/testing/selftests/bpf/.gitignore
> > @@ -45,6 +45,7 @@ test_cpp
> >  /veristat
> >  /sign-file
> >  /uprobe_multi
> > +/uprobe_compat
> >  *.ko
> >  *.tmp
> >  xskxceiver
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index edc73f8f5aef..d170b63eca62 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -134,7 +134,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
> >         xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
> >         xdp_features bpf_test_no_cfi.ko
> >
> > -TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
> > +TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi uprobe_compat
> 
> you need to add uprobe_compat to TRUNNER_EXTRA_FILES as well, no?

ah right

> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 9233210a4c33..3770254d893b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -11,6 +11,7 @@
> >  #include <sys/wait.h>
> >  #include "uprobe_syscall.skel.h"
> >  #include "uprobe_syscall_call.skel.h"
> > +#include "uprobe_syscall_compat.skel.h"
> >
> >  __naked unsigned long uretprobe_regs_trigger(void)
> >  {
> > @@ -291,6 +292,35 @@ static void test_uretprobe_syscall_call(void)
> >                  "read_trace_pipe_iter");
> >         ASSERT_EQ(found, 0, "found");
> >  }
> > +
> > +static void trace_pipe_compat_cb(const char *str, void *data)
> > +{
> > +       if (strstr(str, "uretprobe compat") != NULL)
> > +               (*(int *)data)++;
> > +}
> > +
> > +static void test_uretprobe_compat(void)
> > +{
> > +       struct uprobe_syscall_compat *skel = NULL;
> > +       int err, found = 0;
> > +
> > +       skel = uprobe_syscall_compat__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "uprobe_syscall_compat__open_and_load"))
> > +               goto cleanup;
> > +
> > +       err = uprobe_syscall_compat__attach(skel);
> > +       if (!ASSERT_OK(err, "uprobe_syscall_compat__attach"))
> > +               goto cleanup;
> > +
> > +       system("./uprobe_compat");
> > +
> > +       ASSERT_OK(read_trace_pipe_iter(trace_pipe_compat_cb, &found, 1000),
> > +                "read_trace_pipe_iter");
> 
> why so complicated? can't you just set global variable that it was called

hm, we execute separate uprobe_compat (32bit) process that triggers the bpf
program, so we can't use global variable.. using the trace_pipe was the only
thing that was easy to do

jirka

> 
> > +       ASSERT_EQ(found, 1, "found");
> > +
> > +cleanup:
> > +       uprobe_syscall_compat__destroy(skel);
> > +}
> >  #else
> >  static void test_uretprobe_regs_equal(void)
> >  {
> > @@ -306,6 +336,11 @@ static void test_uretprobe_syscall_call(void)
> >  {
> >         test__skip();
> >  }
> > +
> > +static void test_uretprobe_compat(void)
> > +{
> > +       test__skip();
> > +}
> >  #endif
> >
> >  void test_uprobe_syscall(void)
> > @@ -320,3 +355,8 @@ void serial_test_uprobe_syscall_call(void)
> >  {
> >         test_uretprobe_syscall_call();
> >  }
> > +
> > +void serial_test_uprobe_syscall_compat(void)
> 
> and then no need for serial_test?
> 
> > +{
> > +       test_uretprobe_compat();
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
> > new file mode 100644
> > index 000000000000..f8adde7f08e2
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +SEC("uretprobe.multi/./uprobe_compat:main")
> > +int uretprobe_compat(struct pt_regs *ctx)
> > +{
> > +       bpf_printk("uretprobe compat\n");
> > +       return 0;
> > +}
> > --
> > 2.44.0
> >

