Return-Path: <bpf+bounces-76622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553ACBF41C
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 18:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EF23015A9D
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D50130AACF;
	Mon, 15 Dec 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJqcFHTy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87523E342
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820183; cv=none; b=GSgNzuuo+viiKw9uwwN4lfXRVjaQTUbRdhtaLizf6xvxeeiCCgvlqkODHaAGm2/mxLHAO9NVjyKLJ0fhI/jltbwc+M79kENZnGw6lzoB8+QI7F7sJNNbgocP4594vFq5ANITylkzlaRjRzVVk4buIcBaNkYtgc4hF0Da/enmLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820183; c=relaxed/simple;
	bh=vsdYktsjNgFAp1JUs1oA8+72Al59PRALq5W22WynjIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QikMTcY9/GITNw/mSxIys1nRTenzdgSb04osN7toQ/ltr1pk+jh3jpAMttT1PZZEkFok3axJQ4v90EFuuX6+hzXacS4IXilbFZjDj1/hXCrsSLUToRBmtNbiNqua98A5Tzef+ogAdahzqVJXi8xWvMt3uaEoKRfe+oVKoT1Zs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJqcFHTy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso23521815ad.1
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765820181; x=1766424981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLRG6s4CiMaRDvwPZVRW9ocDiBkHQzba4/tGEALm8Xg=;
        b=PJqcFHTySOwidcmfKhM2Z4F8IhYRufSxlArg+pkz2fB/4s9sUx2en51GWVDnrH4nYh
         a9dZA7zrx14tRgDndDEWFkk8dHRygGWBvzsN1TH1tG1xZ747+dqzIvpfOoVTYLSb16TP
         /K5ckOukYLDUepWcFyCKedU3IdTHMYhyg2rqH6Zd4dTX3mUePeUkw/dExW8fV1k6A/Hr
         ql0FL4DScHJSWBR+uX1DX1H9dssdEHV6NENqmx/5txS4WROVI3tZldpa47qjAxAYIXCR
         qlk4g1or5GmGVAEixbzAmp+zWEHkV1W0P1YTtcu5ZGU+K6R7osZHLAMlqnaUPld1q1I6
         P4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765820181; x=1766424981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLRG6s4CiMaRDvwPZVRW9ocDiBkHQzba4/tGEALm8Xg=;
        b=WdczKTZ139GQgY8F16FtE/HRo2IaDyYgV4FqG+CNcH0pnJT6ZVeTe9OzETMPCazxhv
         NCN8a5/nCVLu1DlLPD3vp+Zde5vn5iyui1eRRTcH1kG8Gc1RcVXCoPeEqIGl9MVw9wtD
         479878hKpfAN7rczekKx6AS6zZHsStgncteiDVp3cMpa0FaQNm4b9fipaXCLlOyCRIst
         blScYa8M9zLGzjq2yxwMGzSsm4BQ8TzyArVH7jl1WP+t2MVgIf0yDYTsmpLva+HtvHjH
         1LUjos/kJfhcYwZ718DmS8YV8J0gEqULbyTQ6duVh9USJUf482K1beUhthBiA2mv8B/T
         aAow==
X-Forwarded-Encrypted: i=1; AJvYcCXeozFzqYdIqiIxL88Gy4cvhezLNKJOBqrp4U2gYL32Dt5+qBFb+6aZolzTtAZ41r181M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+NCdSSG9rrZZ1FeQLtK6Jdlal/gDY7uv1TS1Ze+r4ENe9Cznt
	8Hzmdr0pcNo4c2TM5LpI8uJCxeZPUenJkhTNp4eqxM6UO1/W2V2oLozU6YDHsGFoR2/F6febc7y
	/papZ73i3oqUxdSlL7DT4LjWhySGWHCQ=
X-Gm-Gg: AY/fxX6tQIL1Ky/N/0vdutjZcfwFo1oQPl6817KHBwJ3VK3tsqfC9hJ9KwVBmpLApZJ
	dqaJTURTfzMA8CmcMuOOWXKn/NenB4iEcbHVAZQNUVx8QYdTPWU5ocPyPA+ts3CEqjM3Humruk1
	+JoLk/f+dfApN3u785vgTP7cKD+T1JKzwxk3hSDvZtW1V4gCOKrU7xbZ8cq608e7UFIQrgWoSYL
	uCD55dNOaIp0RgfTVF3cwvS9Pu5cih+C/wFo1PAwzP0yyUiNuCnu8VVdnNz+vph6+juLm5sSvFG
	uYrrJ8V1A1E=
X-Google-Smtp-Source: AGHT+IG6dSNYEI0zQ+r/ppKfXYQBvSg8Qy+OUpAXxK2fA6ZpfV7MOGorDu6bMFVVoNv38cdGwTtkSi/jwVxKy8o80HY=
X-Received: by 2002:a17:902:f544:b0:2a0:e532:242e with SMTP id
 d9443c01a7336-2a0e5322636mr42045075ad.11.1765820180665; Mon, 15 Dec 2025
 09:36:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Dec 2025 09:36:07 -0800
X-Gm-Features: AQt7F2oXtgalz-dRMrrReVDH1fOb1ThoWdC3rtPt-jNvEFUXrQAvBuoLtdlRWvA
Message-ID: <CAEf4BzZQ_OJehh=5jJgVBUjJBNAkWh2o8Yd9UTa9nFrRO4oAFg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bpf: Disable -Wsuggest-attribute=format
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 5:12=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The printing functions in BPF code are using printf() type of format,
> and compiler is not happy about them as is:
>
> kernel/bpf/helpers.c:1069:9: error: function =E2=80=98____bpf_snprintf=E2=
=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribu=
te [-Werror=3Dsuggest-attribute=3Dformat]
>  1069 |         err =3D bstr_printf(str, str_size, fmt, data.bin_args);
>       |         ^~~
>
> kernel/bpf/stream.c:241:9: error: function =E2=80=98bpf_stream_vprintk_im=
pl=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format at=
tribute [-Werror=3Dsuggest-attribute=3Dformat]
>   241 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, =
data.bin_args);
>       |         ^~~
>
> kernel/trace/bpf_trace.c:377:9: error: function =E2=80=98____bpf_trace_pr=
intk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format =
attribute [-Werror=3Dsuggest-attribute=3Dformat]
>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.=
bin_args);
>       |         ^~~
>
> kernel/trace/bpf_trace.c:433:9: error: function =E2=80=98____bpf_trace_vp=
rintk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format=
 attribute [-Werror=3Dsuggest-attribute=3Dformat]
>   433 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.=
bin_args);
>       |         ^~~
>
> kernel/trace/bpf_trace.c:475:9: error: function =E2=80=98____bpf_seq_prin=
tf=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format at=
tribute [-Werror=3Dsuggest-attribute=3Dformat]
>   475 |         seq_bprintf(m, fmt, data.bin_args);
>       |         ^~~~~~~~~~~
>

I just want to point out that the compiler suggestion is wrong here
and these functions do not follow printf semantics. Yes, they have
printf format string argument, but arguments themselves are passed
using a special convention that the compiler won't know how to verify
properly. So now, these are not candidates for gnu_printf, and it
would be nice to have some way to shut up GCC for individual function
instead of blanket -Wno-suggest-attribute for the entire file.

Similarly, I see you marked bstr_printf() with __printf() earlier.
That also seems wrong, so you might want to fix that mistake as well,
while at it.

Maybe the pragma push/pop approach would be a bit better and more
explicit in the code?

> Fix the compilation errors by disabling that warning since the code is
> generated and warning is not so useful in this case =E2=80=94 it can't ch=
eck
> the parameters for now.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512061425.x0qTt9ww-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512081321.2h9ThWTg-lkp@i=
ntel.com/
> Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
> Fixes: 10aceb629e19 ("bpf: Add bpf_trace_vprintk helper")
> Fixes: 7b15523a989b ("bpf: Add a bpf_snprintf helper")
> Fixes: 492e639f0c22 ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")
> Fixes: f3694e001238 ("bpf: add BPF_CALL_x macros for declaring helpers")
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/bpf/Makefile   | 11 +++++++++--
>  kernel/trace/Makefile |  6 ++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 232cbc97434d..cf7e8a972f98 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,14 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fno=
-gcse
>  endif
>  CFLAGS_core.o +=3D -Wno-override-init $(cflags-nogcse-yy)
>
> -obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o token.o liveness.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o tnum.o log.o=
 token.o liveness.o
> +
> +obj-$(CONFIG_BPF_SYSCALL) +=3D helpers.o stream.o
> +# The ____bpf_snprintf() uses the format string that triggers a compiler=
 warning.
> +CFLAGS_helpers.o +=3D -Wno-suggest-attribute=3Dformat
> +# The bpf_stream_vprintk_impl() uses the format string that triggers a c=
ompiler warning.
> +CFLAGS_stream.o +=3D -Wno-suggest-attribute=3Dformat
> +
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_it=
er.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o bpf_insn_array.o
> @@ -14,7 +21,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_local_storage.o bpf_=
task_storage.o
>  obj-${CONFIG_BPF_LSM}    +=3D bpf_inode_storage.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D disasm.o mprog.o
>  obj-$(CONFIG_BPF_JIT) +=3D trampoline.o
> -obj-$(CONFIG_BPF_SYSCALL) +=3D btf.o memalloc.o rqspinlock.o stream.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D btf.o memalloc.o rqspinlock.o
>  ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
>  obj-$(CONFIG_BPF_SYSCALL) +=3D arena.o range_tree.o
>  endif
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index fc5dcc888e13..1673b395c14c 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -104,7 +104,13 @@ obj-$(CONFIG_TRACE_EVENT_INJECT) +=3D trace_events_i=
nject.o
>  obj-$(CONFIG_SYNTH_EVENTS) +=3D trace_events_synth.o
>  obj-$(CONFIG_HIST_TRIGGERS) +=3D trace_events_hist.o
>  obj-$(CONFIG_USER_EVENTS) +=3D trace_events_user.o
> +
>  obj-$(CONFIG_BPF_EVENTS) +=3D bpf_trace.o
> +# The BPF printing functions use the format string that triggers a compi=
ler warning.
> +# Since the code is generated and warning is not so useful in this case =
(it can't
> +# check the parameters for now) disable the warning.
> +CFLAGS_bpf_trace.o +=3D -Wno-suggest-attribute=3Dformat
> +
>  obj-$(CONFIG_KPROBE_EVENTS) +=3D trace_kprobe.o
>  obj-$(CONFIG_TRACEPOINTS) +=3D error_report-traces.o
>  obj-$(CONFIG_TRACEPOINTS) +=3D power-traces.o
> --
> 2.50.1
>

