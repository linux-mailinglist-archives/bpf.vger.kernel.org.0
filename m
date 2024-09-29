Return-Path: <bpf+bounces-40509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFED989674
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98861B20AC6
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840317E44A;
	Sun, 29 Sep 2024 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRVF95kB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F617DFF2;
	Sun, 29 Sep 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629825; cv=none; b=V0HNVjsZoXDMe65+i0WxvgT7OWHgxZEj0eCv+Zeg7UDRKPAkVGo/D1rSDGJBUFdMOO0ETFlD7hmxIV8LlU24lrcx7j3bVzXH1y/ndUXZtkK9lxhlhnr2oitHbr62yR+WdvmcByvuafQpWvWtkyO/v/K4PKFsK3Ff2WUVW9GlJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629825; c=relaxed/simple;
	bh=RupHcF2YMDtc5B0PvtdrFVxi7O2rIkLjnzwiVQ+8+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPd651u7kZOBADL3HZwh9izL0pCaIbUsYQvEpwRhaonQoyrLkfLB1jIKBh+LNQ6w2G8ZhkVXUAk6ZpNnH/WYZQ/Bj4t56HaVuHdjTHSSOwvHvzdJvDCOONX5k6cky18D0QaTn+apKsOuRCBLgb//gdAYdu4tZbdXkn1eLNcXuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRVF95kB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cdb6ebc1cso995746f8f.1;
        Sun, 29 Sep 2024 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727629822; x=1728234622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPGuySNzaGQqh50PPbKO6DCxB7qiiEF+rpBWLfkBod0=;
        b=eRVF95kBimxF+OJbN9d5xCfcMbyRVnKfwrvrndaTYbo7VQKls+vMBDHVbVMMN/qOPl
         28M6OVQ4ZiZ344c6o6pICPCMcbw7Fo413j15Jmm5VmmoJvR/fDTlJG9NpwBDenGEHcYP
         DYPbzFNhGGflAg0/txYG8wzqnV0NETZy9MjYWOJPFmMn56Bcb9MZCNMSUfWZY+SxK7Zl
         Z5U+RCYSdUTxrOtduUvfULIFYGcvPl9SRZI9Igzqupk/T4tLsxpO+WhkSGZ3dQjoEgbc
         EWEUoBuGerVZuTlO6aHBj2VqgcMoYDARR5EbkTDlT+0SC8beExMM8TxvEmsat3PCQeua
         slfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727629822; x=1728234622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPGuySNzaGQqh50PPbKO6DCxB7qiiEF+rpBWLfkBod0=;
        b=Rhj97mZwl6p0MPO0GOzLCcCcuXiYDGu3a6BvL9pVt9lYDUv7ChZ2O0F+TJJcDY/YgC
         MiKlOeyxploxiMuj4FSTVgQGauxKeXjOa35eCY5/tn4PshTDQ5AGA+uUNEWaibQYBFi7
         XY9cenU+ITGWtFdAGcgJYjuPPsDVzOvNTMeGQVVZ9n8tDv3ryC/2dhp1VEEc3gzixF9p
         9lt06/r3vnwrBC6nVNialFv/E9W37HE/vL5KT79MZr/7i7tQ2r0lul+L+0hjhSVo8x1P
         B+l1EBAMOne7jpOCpnLjrvYq0oTp2IFEROgBU+OtGQTVP2997Rvj2rnk1QjsT8fANyyK
         YzEA==
X-Forwarded-Encrypted: i=1; AJvYcCVOz81NZ+3FhMSCH0OKIQWP+0MbKW3mzpmSKvSKmlXtFmBy4cyhvtoa6XaPy/0XHP1bKkpSs/ctUcGerd0q@vger.kernel.org, AJvYcCVTAOdqfH235R7txLO5A75VG1iDU8Wp/2k0jGGhBr+HmnfEw0zWliLqsXmMZk8kSRoYrs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzennq37RjpLlcBT+X/NBWpUR0dKSg19RsvrzqLdqNUJyixDOSQ
	TrgKYeZbr/bthgjFIJkd3FMloX/s3Rhw8sZ9q5Pz4sogiMTw+pHFF93SX8I8Z98TtmnRX84nFDx
	2ada58Hk4d8AAPY/kSMAwQAbYSbU=
X-Google-Smtp-Source: AGHT+IE71jalNcYCe9JkRHNkl+Yu72w6VOsAwtk1UKTuiSzkxtFzH0GmxCfEPUgvq5E6fy8k7JUsmPqLwFXNB4//0Uc=
X-Received: by 2002:adf:fd52:0:b0:37c:d0f9:58c with SMTP id
 ffacd0b85a97d-37cd5af2de1mr5588923f8f.35.1727629821884; Sun, 29 Sep 2024
 10:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202409261116.risxWG3M-lkp@intel.com> <20240926072755.2007-1-eric.yan@oppo.com>
In-Reply-To: <20240926072755.2007-1-eric.yan@oppo.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:10:10 -0700
Message-ID: <CAADnVQJ5xCsBg057gKOQOYA1+9pD-X86bjYJVrTbpRNstvW=DQ@mail.gmail.com>
Subject: Re: [PATCH v2] Add BPF Kernel Function bpf_ptrace_vprintk
To: Eric Yan <eric.yan@oppo.com>
Cc: kbuild test robot <lkp@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, oe-kbuild-all@lists.linux.dev, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 12:28=E2=80=AFAM Eric Yan <eric.yan@oppo.com> wrote=
:
>
> add a kfunc 'bpf_ptrace_vprintk' printing bpf msg with trace_marker
> format requirement so that these msgs can be retrieved by android
> perfetto by default and well represented in perfetto UI.
>
> [testing prog]
> const volatile bool ptrace_enabled =3D true;
> extern int bpf_ptrace_vprintk(char *fmt, u32 fmt_size, const void *args, =
u32 args__sz) __ksym;
>
> ({                                    \
>     if (!ptrace_enabled) { \
>         bpf_printk(fmt, __VA_ARGS__);     \
>     } else {                              \
>         char __fmt[] =3D fmt;               \
>         _Pragma("GCC diagnostic push")    \
>         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")  \
>         u64 __params[] =3D { __VA_ARGS__ }; \
>         _Pragma("GCC diagnostic pop")     \
>         bpf_ptrace_vprintk(__fmt, sizeof(__fmt), __params, sizeof(__param=
s)); \
>     }                                  \
> })
>
> SEC("perf_event")
> int do_sample(struct bpf_perf_event_data *ctx)
> {
>         u64 ip =3D PT_REGS_IP(&ctx->regs);
>         u64 id =3D bpf_get_current_pid_tgid();
>         s32 pid =3D id >> 32;
>         s32 tid =3D id;
>         debug_printk("N|%d|BPRF-%d|BPRF:%llx", pid, tid, ip);
>         return 0;
> }
>
> [output]:
>        app-3151    [000] d.h1.  6059.904239: tracing_mark_write: N|2491|B=
PRF-3151|BPRF:58750d0eec
>
> Signed-off-by: Eric Yan <eric.yan@oppo.com>
> ---
>  kernel/bpf/helpers.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1a43d06eab28..1e37dae74ca6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2521,6 +2521,39 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(=
s32 pid)
>         return p;
>  }
>
> +static noinline void tracing_mark_write(char *buf)
> +{
> +       trace_printk(buf);
> +}
> +
> +/* same as bpf_trace_vprintk, only with a trace_marker format requiremen=
t
> + * @fmt: Format string, e.g. <B|E|C|N>|<%d:pid>|<%s:TAG>...
> + */
> +__bpf_kfunc int bpf_ptrace_vprintk(char *fmt, u32 fmt_size, const void *=
args, u32 args__sz)
> +{
> +       struct bpf_bprintf_data data =3D {
> +               .get_bin_args   =3D true,
> +               .get_buf        =3D true,
> +       };
> +       int ret, num_args;
> +
> +       if (args__sz & 7 || args__sz > MAX_BPRINTF_VARARGS * 8 || (args__=
sz && !args))
> +               return -EINVAL;
> +       num_args =3D args__sz / 8;
> +
> +       ret =3D bpf_bprintf_prepare(fmt, fmt_size, args, num_args, &data)=
;
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args=
);
> +
> +       tracing_mark_write(data.buf);
> +
> +       bpf_bprintf_cleanup(&data);
> +
> +       return ret;
> +}
> +
>  /**
>   * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
>   * @p: The dynptr whose data slice to retrieve
> @@ -3090,6 +3123,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_ptrace_vprintk)
>  BTF_KFUNCS_END(common_btf_ids)

Why new kfunc?
Use bpf_snprintf() and follow with bpf_trace_printk() ?

