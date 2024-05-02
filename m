Return-Path: <bpf+bounces-28460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4496F8B9EB2
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02261F224A4
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2742415E5A3;
	Thu,  2 May 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbty/mQM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138622EF0;
	Thu,  2 May 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667726; cv=none; b=cyEDEJ5RXJp9yhVpcabwmegPGPtDWV/gYuL0otyTKJDtn4cCA9qdwIU67ypAtcyUcek57ZOdp+FHhPjRfeoDP/WqzOfnj51Kw32YwngB4IUSejdCpawoimkkaJlLTAEQ/ovRw1gfdKmp653lA7YES+qDW0y+90xA6knlZd7GM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667726; c=relaxed/simple;
	bh=PBGx+QzK3V/jzaTxmAF0sxMEy41nY0esBUQXEGTg/YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvUZb3o1NLa7XwKGIw9TqnovxeNQdVhg9MRGCcjBa/hcY+rccKXAcQDszb74UfzQP8QZw5lbP2VsBXUFxEUuaxR/lNKsKyHDN/Xsle3dadZ+v4oXYqzsgl7vcBbb6y34KSehrE+qf2mpCiDAC3mc8vu9YZg717MuCUXGjGJqsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbty/mQM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so5446948a91.3;
        Thu, 02 May 2024 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714667724; x=1715272524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7qX2wsQfUaEvzSjOKIteqtXpOpMFTBitC+8nZW0h8Q=;
        b=mbty/mQMh8lT4nWu3ozWXdS36VKpBuQUCzf8PfadaxHf42EBnOuucc3w3yyLdF81yI
         fz81L8G73+Lswim6p+BVUn5UAoRnGW8HGGyvtbpMs5mKTrA22/JTx1hIXJeQ7Scvo4/v
         W11N156CIDScgQrawho0QSkgGj65tZo88DaRQm8xfmt+Gi93bUpD60mOluTRJI3LdTt4
         p4fE1MPhxZsEkwInb04as1XOTw3TOwvN+bvcnR6OpxOT3ezSH0tD4/Ktv4PQAy/0SOpm
         SRJhbZUePhIo22Qf2PRaTlnElZwdkcZvNPE9fhpB1yyRhCykFQKEhR2mGyZkTV2TClks
         8ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667724; x=1715272524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7qX2wsQfUaEvzSjOKIteqtXpOpMFTBitC+8nZW0h8Q=;
        b=IThDaOgDrwTzNmL/97fMcZxUpo1AIMNbPL9L8HE4PIw3jDY8R/M+KU5k6X2lp7Tevw
         ZLlLmTpZ4CdGQuvc+C5JU3Pqwu7eR2Ziop9cYnmrBWoGlRGHsJxQM3BVg27J0oY8MBia
         2g7wi8EYyRBOhUy/4jut792WPLTLSehiybgOY6S40nFMs7aBgU04Hz2rooXpQknv+liK
         MQqXt6KK+WtZ8mfJbAi85I7UnoT6OqpC9w7xcj5n7LRkzuVS8xACr9z/yUNkJ9BMqAxq
         sn1R9KHaoOZjSSi5nHY4/JPSO7fa1+xxjB8+8U0wMW1Ka2iBJuKKUUMkwaVBg3A7ELk4
         L66w==
X-Forwarded-Encrypted: i=1; AJvYcCXYoscNU3xJWfE8PYUNWj6p0nmW3rpfFG7aej/NCyCGqw7N+Lr4q/AYwF7eJ4pQ0G/nJ7FWQptmPgEpywe4/BU4FHHAaISmTUpedKOMy8UQtuRSFZNiSUWsSTyUqhhaPM84cWYMd+T4NwK60CzwU6c3NOX9bbSlzNXJxS5JIakzwEl0Va6NEaG3a4j7OoWXkfkDj1hLPUfWqCnzJh+z2zveMICiZ8ue3z2j1z+1+wBXmSoUmxgkxKPF9Nsx
X-Gm-Message-State: AOJu0Yyu7E+Qq1Tv8oNzw6ETA521xTDbUlDcbtE4OKI34Z5ibpxvriD9
	7UlHcjEAQJckpKXboMqgcysI5GwUlU4cUuLgv/jtpSndUsnHlGIN4uKVpKaNMp8TKj7uDLgSK64
	xCKUtr5Wv/CsSF/v7BQ39TcTnj4s=
X-Google-Smtp-Source: AGHT+IG4Gm0i1UKy3HOxBNiZHuaEQz/Ocw5YTH/JSaYPZ9RO+Z2kf0Gj/JRl8WUdGd7sAevYvNoCL2ilQrEq/2lAIxY=
X-Received: by 2002:a17:90b:46c7:b0:2b2:ce88:c68c with SMTP id
 jx7-20020a17090b46c700b002b2ce88c68cmr284889pjb.19.1714667723617; Thu, 02 May
 2024 09:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502122313.1579719-1-jolsa@kernel.org> <20240502122313.1579719-7-jolsa@kernel.org>
In-Reply-To: <20240502122313.1579719-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 May 2024 09:35:11 -0700
Message-ID: <CAEf4Bza5P7BVpvE4SyJsyGSZAp3bU+2qX9KCxFLQ7rrRPmDxSg@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 6/7] selftests/bpf: Add uretprobe compat test
To: Jiri Olsa <jolsa@kernel.org>
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

On Thu, May 2, 2024 at 5:24=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that adds return uprobe inside 32-bit task
> and verify the return uprobe and attached bpf programs
> get properly executed.
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/.gitignore        |  1 +
>  tools/testing/selftests/bpf/Makefile          |  7 ++-
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 60 +++++++++++++++++++
>  3 files changed, 67 insertions(+), 1 deletion(-)
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
> index 82247aeef857..a94352162290 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -133,7 +133,7 @@ TEST_GEN_PROGS_EXTENDED =3D test_sock_addr test_skb_c=
group_id_user \
>         xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metada=
ta \
>         xdp_features bpf_test_no_cfi.ko
>
> -TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mul=
ti
> +TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mul=
ti uprobe_compat
>
>  ifneq ($(V),1)
>  submake_extras :=3D feature_display=3D0
> @@ -631,6 +631,7 @@ TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read $(OUT=
PUT)/bpf_testmod.ko      \
>                        $(OUTPUT)/xdp_synproxy                           \
>                        $(OUTPUT)/sign-file                              \
>                        $(OUTPUT)/uprobe_multi                           \
> +                      $(OUTPUT)/uprobe_compat                          \
>                        ima_setup.sh                                     \
>                        verify_sig_setup.sh                              \
>                        $(wildcard progs/btf_dump_test_case_*.c)         \
> @@ -752,6 +753,10 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
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
> index c6fdb8c59ea3..bfea9a0368a4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -5,6 +5,7 @@
>  #ifdef __x86_64__
>
>  #include <unistd.h>
> +#include <stdlib.h>
>  #include <asm/ptrace.h>
>  #include <linux/compiler.h>
>  #include <linux/stringify.h>
> @@ -297,6 +298,58 @@ static void test_uretprobe_syscall_call(void)
>         close(go[1]);
>         close(go[0]);
>  }
> +
> +static void test_uretprobe_compat(void)
> +{
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
> +               .retprobe =3D true,
> +       );
> +       struct uprobe_syscall_executed *skel;
> +       int err, go[2], pid, c, status;
> +
> +       if (pipe(go))
> +               return;

ASSERT_OK() missing, like in the previous patch

Thanks for switching to pipe() + global variable instead of using trace_pip=
e.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +
> +       skel =3D uprobe_syscall_executed__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"=
))
> +               goto cleanup;
> +

[...]

