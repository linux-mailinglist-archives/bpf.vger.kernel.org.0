Return-Path: <bpf+bounces-22117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9285724E
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 01:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C3D1C2145D
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 00:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50C028F1;
	Fri, 16 Feb 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhQCZOJj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC78F48;
	Fri, 16 Feb 2024 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042362; cv=none; b=YLZEP8wTtNzdNPj9oMuv3344uhRguDxdKccao3b44cSjnKH1vFSh0wIdg0Ntje9kMSEEVaVOeiLdq7r6E7xazaL61zj4kSYvRwK8IxwdRjo4bjIrv+OSwzMIpO0n6nZAkBU2t+RVUKdCnZSnDuWBOvTmkovfoZ+Xh1OSvVVh/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042362; c=relaxed/simple;
	bh=UGddjqE2S7mFXXHxqwoDQ87f1ivqVapWcWQmZVP5qQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsMTxQns/Wc2UUBL3wsiih2KVBxDYSL80kG7czU14Y/gAOtqY1ZsV7A21sFLMLWE7CXory79FcyxwTHraZ2lUVcU41mmvVGmXSK5wuCMGRlg7ZvPQx0Brcq8UUG+5524PmpXDQgnlRhSy8FSehaWnvitl8WmxyIBf3PGGi7Q854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhQCZOJj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so1805129a12.1;
        Thu, 15 Feb 2024 16:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708042360; x=1708647160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bJ4kxQzmjoxNtLmSdFElnPlxkz3q42mSNgvtcU/FZI=;
        b=JhQCZOJj7KF0id9YugfcOMkO+rj3ZrB1/jOhiCInQePfMhGBQoN5vFmXBwW/2xqbfm
         Gi13Jyj/opbaVRIG6Kxk9nCWzwOtblFAWnVCt6/l9ZXaiIfhBF9mdlg9neI5wxNNc2rp
         JAvP7o1APr6R8dJYyEkrswYeEFDtzeC9z6gpiit17XD8NG1bPszf1z7TJLB5TQQBB7Wo
         wM+GYjqB1tBYfx1U4FWdx2XCgXihIltOxcgcXJNK4nzpFpSCpGjG2m8XEBOByTSySW9G
         bMLS4pGik5+cR+KHHuE2IckEnF6vhqftK+q5zKDG1310IKQxAS1VfRccw0eHTgM9fd3+
         d8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042360; x=1708647160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bJ4kxQzmjoxNtLmSdFElnPlxkz3q42mSNgvtcU/FZI=;
        b=rBm0/FVKmheKDT1P8YOaGbkPrRNqa9wcGEzoQAgMjlTXuHhypN0oPDS3rDKDo85YNe
         rhXnx2qHnlziunNFWKZ0rLObam7Iv+Q6K9dq1TSqHvePQUGA770rUOCZhw/RL4f31At2
         H+UV+oy195hbIZskYZSqk2AevjO3SViZR8amEJ5y7rn8Mrp7rGv6cMyGWGwyyC/u/jbV
         clyToy+8oK+bnMWaiQ7q08PGHr0rD/+aJ/AUxNKPSR3jMYWdIaJ44aGiMC31ue0Oq7NK
         mYbzBOHPCbu2qLAC8wbY/Du/8YMec7Uv468peq6AUWe48W3tQt6xeJRyLVpCY5Vkz0M1
         zBng==
X-Forwarded-Encrypted: i=1; AJvYcCUxCgddbJNSi+yzeoJKCEJS+aQDx/yEJVe1ujfU7l3XEAiK2cB39OYrioNGNYM2CgzF4w94KpreTuBfzKeTdnew+YKKPN6puQle0ddSH+MnuPpbk2Vc0JgCm6nIus9aiRrByPXOlcrkXTBlVOhU8rbg1mz8V15QwSwyHfacL9XWBYSPcw==
X-Gm-Message-State: AOJu0YzEpa9IUJKEDMolPXASct3dKRvH7jGXoIqGRi6qGcul9bR4wsG4
	P8nNkgDZ2ueC0xYoch0CELhhqYD7zgToEb+MQdiEt2CBqXdWoNoIPkwGXc3lD8DOqaa3Q4rzk7/
	kzkAVfWoa4ftYzxW6y4XzTIZqVH0=
X-Google-Smtp-Source: AGHT+IFumgrWEnafln15EYGSSMd0RLuS0Nk7s+Q+eE8+YcKsdx3Utc/AfITURMfW4KPvC6L6yfqHo5ASvAvKlkDIbPc=
X-Received: by 2002:a17:90b:1881:b0:299:1cce:f3c3 with SMTP id
 mn1-20020a17090b188100b002991ccef3c3mr3099226pjb.7.1708042360110; Thu, 15 Feb
 2024 16:12:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214173950.18570-1-khuey@kylehuey.com> <20240214173950.18570-3-khuey@kylehuey.com>
In-Reply-To: <20240214173950.18570-3-khuey@kylehuey.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Feb 2024 16:12:28 -0800
Message-ID: <CAEf4BzZM6gDH4_X86p0WhiLHY-m89c_8Km-a=dYGGc+7fUCrMg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 2/4] perf/bpf: Remove unneeded uses_default_overflow_handler.
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Will Deacon <will@kernel.org>, Song Liu <song@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:40=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> Now that struct perf_event's orig_overflow_handler is gone, there's no ne=
ed
> for the functions and macros to support looking past overflow_handler to
> orig_overflow_handler.
>
> This patch is solely a refactoring and results in no behavior change.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Acked-by: Will Deacon <will@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---

oh, never mind what I said in the first patch about this :)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
>  arch/arm64/kernel/hw_breakpoint.c |  4 ++--
>  include/linux/perf_event.h        | 16 ++--------------
>  3 files changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpo=
int.c
> index dc0fb7a81371..054e9199f30d 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>         hw->address &=3D ~alignment_mask;
>         hw->ctrl.len <<=3D offset;
>
> -       if (uses_default_overflow_handler(bp)) {
> +       if (is_default_overflow_handler(bp)) {
>                 /*
>                  * Mismatch breakpoints are required for single-stepping
>                  * breakpoints.
> @@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, un=
signed int fsr,
>                  * Otherwise, insert a temporary mismatch breakpoint so t=
hat
>                  * we can single-step over the watchpoint trigger.
>                  */
> -               if (!uses_default_overflow_handler(wp))
> +               if (!is_default_overflow_handler(wp))
>                         continue;
>  step:
>                 enable_single_step(wp, instruction_pointer(regs));
> @@ -811,7 +811,7 @@ static void watchpoint_handler(unsigned long addr, un=
signed int fsr,
>                 info->trigger =3D addr;
>                 pr_debug("watchpoint fired: address =3D 0x%x\n", info->tr=
igger);
>                 perf_bp_event(wp, regs);
> -               if (uses_default_overflow_handler(wp))
> +               if (is_default_overflow_handler(wp))
>                         enable_single_step(wp, instruction_pointer(regs))=
;
>         }
>
> @@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown,=
 struct pt_regs *regs)
>                         info->trigger =3D addr;
>                         pr_debug("breakpoint fired: address =3D 0x%x\n", =
addr);
>                         perf_bp_event(bp, regs);
> -                       if (uses_default_overflow_handler(bp))
> +                       if (is_default_overflow_handler(bp))
>                                 enable_single_step(bp, addr);
>                         goto unlock;
>                 }
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_bre=
akpoint.c
> index 35225632d70a..db2a1861bb97 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -654,7 +654,7 @@ static int breakpoint_handler(unsigned long unused, u=
nsigned long esr,
>                 perf_bp_event(bp, regs);
>
>                 /* Do we need to handle the stepping? */
> -               if (uses_default_overflow_handler(bp))
> +               if (is_default_overflow_handler(bp))
>                         step =3D 1;
>  unlock:
>                 rcu_read_unlock();
> @@ -733,7 +733,7 @@ static u64 get_distance_from_watchpoint(unsigned long=
 addr, u64 val,
>  static int watchpoint_report(struct perf_event *wp, unsigned long addr,
>                              struct pt_regs *regs)
>  {
> -       int step =3D uses_default_overflow_handler(wp);
> +       int step =3D is_default_overflow_handler(wp);
>         struct arch_hw_breakpoint *info =3D counter_arch_bp(wp);
>
>         info->trigger =3D addr;
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index c7f54fd74d89..c8bd5bb6610c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1341,8 +1341,9 @@ extern int perf_event_output(struct perf_event *eve=
nt,
>                              struct pt_regs *regs);
>
>  static inline bool
> -__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
> +is_default_overflow_handler(struct perf_event *event)
>  {
> +       perf_overflow_handler_t overflow_handler =3D event->overflow_hand=
ler;
>         if (likely(overflow_handler =3D=3D perf_event_output_forward))
>                 return true;
>         if (unlikely(overflow_handler =3D=3D perf_event_output_backward))
> @@ -1350,19 +1351,6 @@ __is_default_overflow_handler(perf_overflow_handle=
r_t overflow_handler)
>         return false;
>  }
>
> -#define is_default_overflow_handler(event) \
> -       __is_default_overflow_handler((event)->overflow_handler)
> -
> -#ifdef CONFIG_BPF_SYSCALL
> -static inline bool uses_default_overflow_handler(struct perf_event *even=
t)
> -{
> -       return is_default_overflow_handler(event);
> -}
> -#else
> -#define uses_default_overflow_handler(event) \
> -       is_default_overflow_handler(event)
> -#endif
> -
>  extern void
>  perf_event_header__init_id(struct perf_event_header *header,
>                            struct perf_sample_data *data,
> --
> 2.34.1
>

