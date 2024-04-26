Return-Path: <bpf+bounces-27962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FDA8B3EE1
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97741B2311E
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D33816DEA7;
	Fri, 26 Apr 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edsnHn+t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA93A16C84C;
	Fri, 26 Apr 2024 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154832; cv=none; b=VY9zHtonQZOv4phXMGt9LatVol8B5su/BFlEzUWKA5CCysusBUbIfA1xihe+oHRefcdcyd3J41cqZ0HVuwct06qEmz7imNotRW8kDyjTTN6c5f7GyZWQvGIMuX0M/tQtb44hv2ez79U2f2pE3d1ZAaBeJ5EYMaBUDnYIKOZajCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154832; c=relaxed/simple;
	bh=rim/qOPhMLdWIVLqD7A9/Tid24QAvswR2GR40lKc3PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syGVTbSMOjF3NUiTOl+XVxG86L/shS/dz21zCaUKQaYWGQjsbM0WVfTsoJGyZQy7IpLWEgOZOcB7ycKy17sfDfWj24Ifp5twlit/NYY8hAVe8L2lnV4/xrQmm3zbUP8FhheSV0fK2fS9omikHsTxhLPpZpY/0vBEeFcDDSVvyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edsnHn+t; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572229f196bso3076707a12.0;
        Fri, 26 Apr 2024 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714154828; x=1714759628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lceweZHRSnryQgkDij4ZGM28IB4VOVtw3Nwgqfzff9E=;
        b=edsnHn+tz70ngC2iFuHe1ZNGvD8B8SRCdKu7Y7YNduyEXhuyBX3NnaKzUGlD+j0ZpY
         pgMhAtu4VsHBUmS4BmXUJDJ3wYanjWbKewVLDwpo83NPguTLDIiHrFLokpAOioGwWTQG
         FljuSFr3Oe9qGNyzkTR4BGyOrABDgYVpu8mrEyWoR4UqFEWHSywutVMl3MglOnZBhl53
         KBxPLBOwBgGg/avTm1L/T3/tbFLn1XuUtTqk86c6xLnqoCrZnRdjxLhiRh4Ama+yCYLh
         qi7fJKAW8PXmSqjPywIRgGWRIRhfaQeBql6pqIBRaPfzcgaxppzM8nv4/BiINgPRMF1Q
         AWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154828; x=1714759628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lceweZHRSnryQgkDij4ZGM28IB4VOVtw3Nwgqfzff9E=;
        b=s5ZCqVdTOctsHNfkZ/gA6NcVkIJO/u8ELgFn5JZFpwQcrCHKO6HEAZ7nveL+zdp7vg
         g6PInJBkhlhMQGyipkp799Uk/MA8Nf7pljEU7WDKmOpnLaXrDS9684q7eAAxcTjo8/8M
         DNqEzbzY4oJ+kYkIDwC5ti/HnCFo+dck/8rL/VF+4HtXH13TxCOlzvDuFyClxBFc6lAR
         EXfp1jzTDsSGOr7Wf3SJw5oFp0X9K2cEl0gJBMJB+eWS9G6YNK6sHKVlAetjzMThamMq
         pbvscuPEcQJ5nghoewwUMcgcC9A9hkvV094tN4jrnVtW8YvO8JPqQ+0EtOHLdU5WFkKs
         YUhw==
X-Forwarded-Encrypted: i=1; AJvYcCVQv6qulUl19Co49ZDLjPD9VWN5kF2UzZ0Fxe6AoVk9qAYlfvNb794MiXOXK2CPwVzdMJPklQxHnJyc3A7OEfFcLd/KTQ4GT3ieckv8NMO0oSD36lL/fgD0CbM9aEK3qYUpWInFTMDM1HaGvaNqmAWj7vMGRhxgL5REsKZCs7OBSdWzGc5Nadr6mg5+Ml8PMHMVTXA5ey0yeuTCpwYcyE6/
X-Gm-Message-State: AOJu0YxcHQU52mPwY4Hk4QusyjKU5xsfXgdwpaUPpUSZ0pSj4itYJ17m
	MeBChYFxiiZWshwizpvEQyEaO7SwVHt8iZVKxmJVydKH8dlqcDjZNlIZiN+g9fWDWK/mhMxJxcr
	Jt4QVGMNjDDEFF9n6TAE+nRIrXPE=
X-Google-Smtp-Source: AGHT+IFnCgu+gwo+KcuYKTJajtvi0VGhGt5z0L892Y6ykLe+z9IJxoGdXEXt5JX/9knoxs2RzyLAP/kdMrtAql5LBNs=
X-Received: by 2002:a17:906:1594:b0:a58:7940:69de with SMTP id
 k20-20020a170906159400b00a58794069demr2551641ejd.39.1714154828047; Fri, 26
 Apr 2024 11:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421194206.1010934-1-jolsa@kernel.org> <20240421194206.1010934-7-jolsa@kernel.org>
In-Reply-To: <20240421194206.1010934-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 11:06:53 -0700
Message-ID: <CAEf4BzYU-y+vptqXpuALYecJJgPt+CTcbo+=Q9QXnu4vNwem+g@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 6/7] selftests/bpf: Add uretprobe compat test
To: Jiri Olsa <jolsa@kernel.org>
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

On Sun, Apr 21, 2024 at 12:43=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding test that adds return uprobe inside 32 bit task
> and verify the return uprobe and attached bpf programs
> get properly executed.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/.gitignore        |  1 +
>  tools/testing/selftests/bpf/Makefile          |  6 ++-
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 40 +++++++++++++++++++
>  .../bpf/progs/uprobe_syscall_compat.c         | 13 ++++++
>  4 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_comp=
at.c
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index f1aebabfb017..69d71223c0dd 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -45,6 +45,7 @@ test_cpp
>  /veristat
>  /sign-file
>  /uprobe_multi
> +/uprobe_compat
>  *.ko
>  *.tmp
>  xskxceiver
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index edc73f8f5aef..d170b63eca62 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -134,7 +134,7 @@ TEST_GEN_PROGS_EXTENDED =3D test_sock_addr test_skb_c=
group_id_user \
>         xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metada=
ta \
>         xdp_features bpf_test_no_cfi.ko
>
> -TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mul=
ti
> +TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mul=
ti uprobe_compat

you need to add uprobe_compat to TRUNNER_EXTRA_FILES as well, no?

>
>  # Emit succinct information message describing current building step
>  # $1 - generic step name (e.g., CC, LINK, etc);
> @@ -761,6 +761,10 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
>
> +$(OUTPUT)/uprobe_compat:
> +       $(call msg,BINARY,,$@)
> +       $(Q)echo "int main() { return 0; }" | $(CC) $(CFLAGS) -xc -m32 -O=
0 - -o $@
> +
>  EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)                     =
 \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
>         feature bpftool                                                 \
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 9233210a4c33..3770254d893b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -11,6 +11,7 @@
>  #include <sys/wait.h>
>  #include "uprobe_syscall.skel.h"
>  #include "uprobe_syscall_call.skel.h"
> +#include "uprobe_syscall_compat.skel.h"
>
>  __naked unsigned long uretprobe_regs_trigger(void)
>  {
> @@ -291,6 +292,35 @@ static void test_uretprobe_syscall_call(void)
>                  "read_trace_pipe_iter");
>         ASSERT_EQ(found, 0, "found");
>  }
> +
> +static void trace_pipe_compat_cb(const char *str, void *data)
> +{
> +       if (strstr(str, "uretprobe compat") !=3D NULL)
> +               (*(int *)data)++;
> +}
> +
> +static void test_uretprobe_compat(void)
> +{
> +       struct uprobe_syscall_compat *skel =3D NULL;
> +       int err, found =3D 0;
> +
> +       skel =3D uprobe_syscall_compat__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_syscall_compat__open_and_load"))
> +               goto cleanup;
> +
> +       err =3D uprobe_syscall_compat__attach(skel);
> +       if (!ASSERT_OK(err, "uprobe_syscall_compat__attach"))
> +               goto cleanup;
> +
> +       system("./uprobe_compat");
> +
> +       ASSERT_OK(read_trace_pipe_iter(trace_pipe_compat_cb, &found, 1000=
),
> +                "read_trace_pipe_iter");

why so complicated? can't you just set global variable that it was called

> +       ASSERT_EQ(found, 1, "found");
> +
> +cleanup:
> +       uprobe_syscall_compat__destroy(skel);
> +}
>  #else
>  static void test_uretprobe_regs_equal(void)
>  {
> @@ -306,6 +336,11 @@ static void test_uretprobe_syscall_call(void)
>  {
>         test__skip();
>  }
> +
> +static void test_uretprobe_compat(void)
> +{
> +       test__skip();
> +}
>  #endif
>
>  void test_uprobe_syscall(void)
> @@ -320,3 +355,8 @@ void serial_test_uprobe_syscall_call(void)
>  {
>         test_uretprobe_syscall_call();
>  }
> +
> +void serial_test_uprobe_syscall_compat(void)

and then no need for serial_test?

> +{
> +       test_uretprobe_compat();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c b/=
tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
> new file mode 100644
> index 000000000000..f8adde7f08e2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("uretprobe.multi/./uprobe_compat:main")
> +int uretprobe_compat(struct pt_regs *ctx)
> +{
> +       bpf_printk("uretprobe compat\n");
> +       return 0;
> +}
> --
> 2.44.0
>

