Return-Path: <bpf+bounces-28062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96158B5265
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 09:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8026A281DCD
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB414A98;
	Mon, 29 Apr 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYkQM4bK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E9EED4;
	Mon, 29 Apr 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376004; cv=none; b=GPdPlT3YOS44/f67sWmCqNoGaAk0EHUPvFrat26uiOnyESkpP9qugT4q+unYNna5EHuP3fmGzp98soDei5avXtdkL6IWwTM1/Z02JdxqNbrHAB8iai9V9CfML8cVJLqmy5sYjj+GFEJEja7+CDn1+eEFHQHc5z8AhxUQqyUqIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376004; c=relaxed/simple;
	bh=xCAsyKsm0O2P5yVQziSDwhD1A5O80jRdVMDkGgybmbE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQQW485q0b0MNh3nbe5NuIScGNTKYkJBC0pzZcwAXms+aXZv5APnyoZdlqRRN0qSPblN1iZpbFcrtI9CA+J+r3vVv2TgUVcuhn4F0+Ch/DoBpYlgyJzi2sStDpwlcQR8SdV8b8rpb5xza5VInuLfhPXCbL/p55gux4eU5wg/+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYkQM4bK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a52223e004dso432997166b.2;
        Mon, 29 Apr 2024 00:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714376001; x=1714980801; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aP2AX+lZetOMlju+FKo5C17Zuw89jaRcaprqSG8AZqE=;
        b=TYkQM4bKL04oKQXRb+jPZPWaY7FLsgEg8l8JaSEbHeF34gt/zthTHhRXZN1qiM3f97
         j4Zd8V/8a/jXgYnKCOlvupsrgRU0DhGyz8zqGBs0ZTPn0pzWf8qi4Ps1N3jaNL7b8hiO
         Q3L0fLcydElOsmzKA5FqzlpwP/bcfDoSObUTpvXz3cJo78li0w3H72F/TWjzk2zHJz9b
         4/u2iHxWdLj83EZ3sRz40x4sHtRtylIhFeoQ/m7pLxG2amo+Nqjlozb2dIwgTvT5xX6p
         FBbj3W06QWQuPuCLPzY17KWjVYTcwycMnMrLzHAhiLLtb2Fply1nwcXuAJubEyWNNRsq
         Wp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714376001; x=1714980801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aP2AX+lZetOMlju+FKo5C17Zuw89jaRcaprqSG8AZqE=;
        b=EUGpHkLGXPM2xoZQ9ssHfinRQSDCFYSA58/L+hkESQ91rcHmsSlMXHvcN0yQWVTxmN
         wTi2yF805zDdpPpCkGXHBCoTdWoSyNinB9HexqKaE79a4anGE1vG4Gnt0/NB9ew6IVHo
         Dz0EflDYSxn6VkHLokiGgef5UiRiv355QJ/lMrBeP8sZ1/LfgQEbFvCjpSKEhe+zYXEc
         mY49XGyaT/vcpGER4eccVUhBnwvJgwFh6YeC/54h/LPENOvTdtFr+7xQ79fmwtq+wR95
         lj7MkUjLNBDWW7zrm+JsVIvEmGcBaR9yifmQyGDtOPA/+EhWkNTCjYCrA0Zv6/Dq+kqJ
         imKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo1whroiDru7xHWDAeAak+VuLm92hlKmf+IJeXx02nFTtglZhYm+WXji2cwNi7U3STNk5hfxhAKp6/op/CJVcQzPTNG6VbpCQuUigkYBbfIleeoeSQW3BzUW95aTmO3C5ZBMH1q5ILyW8GT2PxooXZV6bZo84JVUVIr3Tl7GxNGt97+3G2TXBW97MXq8kpxfYKs+G+G6uS5zNBbkPE+FRS
X-Gm-Message-State: AOJu0Yyistrf1R7HIVIAhSVqdIFCQuXttoBdR6pEtuTrl2fHl2RbZq3S
	7lhWGsaPxNZ8cA+sTgyk16HJL5p/U4MCf9vGOBfRq+l3BUZU1TNa
X-Google-Smtp-Source: AGHT+IGqylCf/ldo7kntYAX4/5eM2LWZUh5alQVvgKY0qk6DcwG4GzloggwFhM2IkqtpPIozmLqwoQ==
X-Received: by 2002:a17:906:38c8:b0:a58:9707:685b with SMTP id r8-20020a17090638c800b00a589707685bmr8036509ejd.16.1714376000620;
        Mon, 29 Apr 2024 00:33:20 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id er1-20020a170907738100b00a58bf5ebc68sm4416505ejc.146.2024.04.29.00.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:33:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 Apr 2024 09:33:17 +0200
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
Subject: Re: [PATCHv3 bpf-next 5/7] selftests/bpf: Add uretprobe syscall call
 from user space test
Message-ID: <Zi9NPfII8I7nWz6O@krava>
References: <20240421194206.1010934-1-jolsa@kernel.org>
 <20240421194206.1010934-6-jolsa@kernel.org>
 <CAEf4BzbWr9s2HiWU=7=okwH7PR8LHGFj2marmaOxKW61BWKHGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbWr9s2HiWU=7=okwH7PR8LHGFj2marmaOxKW61BWKHGg@mail.gmail.com>

On Fri, Apr 26, 2024 at 11:03:29AM -0700, Andrii Nakryiko wrote:
> On Sun, Apr 21, 2024 at 12:43 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test to verify that when called from outside of the
> > trampoline provided by kernel, the uretprobe syscall will cause
> > calling process to receive SIGILL signal and the attached bpf
> > program is no executed.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 92 +++++++++++++++++++
> >  .../selftests/bpf/progs/uprobe_syscall_call.c | 15 +++
> >  2 files changed, 107 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
> >
> 
> See nits below, but overall LGTM
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]
> 
> > @@ -219,6 +301,11 @@ static void test_uretprobe_regs_change(void)
> >  {
> >         test__skip();
> >  }
> > +
> > +static void test_uretprobe_syscall_call(void)
> > +{
> > +       test__skip();
> > +}
> >  #endif
> >
> >  void test_uprobe_syscall(void)
> > @@ -228,3 +315,8 @@ void test_uprobe_syscall(void)
> >         if (test__start_subtest("uretprobe_regs_change"))
> >                 test_uretprobe_regs_change();
> >  }
> > +
> > +void serial_test_uprobe_syscall_call(void)
> 
> does it need to be serial? non-serial are still run sequentially
> within a process (there is no multi-threading), it's more about some
> global effects on system.

plz see below

> 
> > +{
> > +       test_uretprobe_syscall_call();
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
> > new file mode 100644
> > index 000000000000..5ea03bb47198
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <string.h>
> > +
> > +struct pt_regs regs;
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +SEC("uretprobe//proc/self/exe:uretprobe_syscall_call")
> > +int uretprobe(struct pt_regs *regs)
> > +{
> > +       bpf_printk("uretprobe called");
> 
> debugging leftover? we probably don't want to pollute trace_pipe from test

the reason for this is to make sure the bpf program was not executed,

the test makes sure the child gets killed with SIGILL and also that
the bpf program was not executed by checking the trace_pipe and
making sure nothing was received

the trace_pipe reading is also why it's serial

jirka

> 
> > +       return 0;
> > +}
> > --
> > 2.44.0
> >

