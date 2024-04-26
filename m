Return-Path: <bpf+bounces-27957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7BF8B3EBA
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA331C222B4
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11016ABC6;
	Fri, 26 Apr 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWtO+qhu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A413F434;
	Fri, 26 Apr 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154178; cv=none; b=Tro+Dw16MRlNEx/Xdt8r5yjn3aTZ1r6IgkTK1GjHj6G6QOuf3Gn0wYE5ywuWQniG9+ATOcOeVDOti8NwCT1dn/KWUHkC9TjPdZP93ZBu1HgyLzIfgD+8k3LX4bWcQdCX+6EglxW9ctpdVcbuyvf3RMRt6GgxB57hAUD8ndNCLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154178; c=relaxed/simple;
	bh=FS/fPeCZqM6uYcVwbstslOcRGuG+0rgrXoBJg8OYgtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuajmcVCsxMTH4zo5UYtbN+HwdNuT9mHsITs6qqWpsSZOq68Z8tvDGPHjLRklHJr8/XjOT05iHlJp+sY/GTa24R30QLsNyNuGBXHkCpNHrdwgpTN8v6WhGywGNyIqnUx+jd7PbOWh/ypTDRSqyCTrU41iZABWOR9yNuLz5TQfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWtO+qhu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b07f6b38daso576501a91.1;
        Fri, 26 Apr 2024 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714154176; x=1714758976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4911zvgelc4SShJz6n+xWo0jMkp/ZOOV95C3XRNtoY=;
        b=HWtO+qhu1wPEiUJUYq8bUHAn74jw1id0Kos+x1fjgRvpSrB45LdWJ7WtIvC9yoqZA5
         aUC7oCE9hSOG7N+J19vOJBzRe2cJ2dBDH1lFlkVamAlkf1UqQsFgwbNR/skvYyWufoyW
         izg1IGy3Fq0r5FLBEtZ26iHsHmFeXtVHH8uCjs2lQgotxuKHNFYhqyRYfH/ynvcnCXH+
         EJL18P/xkwhJQYykz+/MCawgH2/hCrSS9eYUjW7oyc6HavVaJs1p6yiSAtW/ibUgDRbZ
         e9DHKRWttjAUXPkvi9T8fYT3NXCqZIB6O7Q6a1MJun06pCO5Ks3ZD7qL2V7s/zT0qkGq
         DgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154176; x=1714758976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4911zvgelc4SShJz6n+xWo0jMkp/ZOOV95C3XRNtoY=;
        b=m/+SP7EoDpHmoviQkK6AIFm/yoLo/f8dh0Y+U5EA2PaXVS6vnt2KxdvsH4HKfSYZ0N
         ISkbVW0SWikQdvRsX8EQ7NyGnEOc6RboDh+a2JX9CpSXplyzUorMenmaN67cBqQLIdnI
         vWqDGJAezz/QJt3UMHF3vJQwHppvZQg7m7Xdou+pEGLdmF2tI8QO5H7hKYTKPAaNalaQ
         kkPyj40sUOv41ekMeDgKwDpajUUjFJEGCHUVkeOkmH7a7qYOzwxGNz0pZ9dogVUj5OO0
         5Tmz5C/RlimCk+et8Pmrz3jMMBgMVUKiwxrkMo6NI4Z2QIk1anCnX6n+7V6YW9v22rNW
         DQaw==
X-Forwarded-Encrypted: i=1; AJvYcCWErzeZpD7wl+HNgWsHcuWH8Yh9hPuY8CBGkVl1wjIAQBcqcFbpIE6K4il69MxJWi98pSJ14MtVLIyoDUE7RGB+/4oCbk2yeoJICbx9TdNumeNNYLP5f9hgwU7PGePZKzOmfIHJScB+OTmfTcJPZA4TiEnUgrElc+zN/JevRhVpj35lbT7VdJlv8OsLBzsykYOAO6PMMb1uR2ZBjfnloYKq
X-Gm-Message-State: AOJu0YwWY4+zFKBTa8bgI8nRR15zhA89UaQcfbTRrtDCLxs0TfVjM+7p
	Q7jQOZdud8dKWxgJbA71V+F5OAvITytvXV+910IU8DluvR4iF9Al/e2BLnvZ9RlQioFdnBpBjIH
	TG/h/V+EPZeG7jJNnu/vZpnrEQ6E=
X-Google-Smtp-Source: AGHT+IGO7AVMbaD5wNTcZh/Y39bj3rcX2MgtU982+y+WYhFBV1PzIPFWXwXyxF+cGlBEPZndB3YMRpAufQesQNlnGnM=
X-Received: by 2002:a17:90a:134c:b0:2ad:9382:35be with SMTP id
 y12-20020a17090a134c00b002ad938235bemr4847590pjf.16.1714154176018; Fri, 26
 Apr 2024 10:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421194206.1010934-1-jolsa@kernel.org> <20240421194206.1010934-2-jolsa@kernel.org>
In-Reply-To: <20240421194206.1010934-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 10:56:03 -0700
Message-ID: <CAEf4BzZvp_Ka4dpzLzLpba5ks9bubnVWB=61A9qg8HpWf-GKeg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/7] uprobe: Wire up uretprobe system call
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

On Sun, Apr 21, 2024 at 12:42=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Wiring up uretprobe system call, which comes in following changes.
> We need to do the wiring before, because the uretprobe implementation
> needs the syscall number.
>
> Note at the moment uretprobe syscall is supported only for native
> 64-bit process.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  include/linux/syscalls.h               | 2 ++
>  include/uapi/asm-generic/unistd.h      | 5 ++++-
>  kernel/sys_ni.c                        | 2 ++
>  4 files changed, 9 insertions(+), 1 deletion(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index 7e8d46f4147f..af0a33ab06ee 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -383,6 +383,7 @@
>  459    common  lsm_get_self_attr       sys_lsm_get_self_attr
>  460    common  lsm_set_self_attr       sys_lsm_set_self_attr
>  461    common  lsm_list_modules        sys_lsm_list_modules
> +462    64      uretprobe               sys_uretprobe
>
>  #
>  # Due to a historical design error, certain syscalls are numbered differ=
ently
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index e619ac10cd23..5318e0e76799 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -972,6 +972,8 @@ asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *s=
ize, u32 flags);
>  /* x86 */
>  asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on=
);
>
> +asmlinkage long sys_uretprobe(void);
> +
>  /* pciconfig: alpha, arm, arm64, ia64, sparc */
>  asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
>                                 unsigned long off, unsigned long len,
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index 75f00965ab15..8a747cd1d735 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_a=
ttr)
>  #define __NR_lsm_list_modules 461
>  __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
>
> +#define __NR_uretprobe 462
> +__SYSCALL(__NR_uretprobe, sys_uretprobe)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 462
> +#define __NR_syscalls 463
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index faad00cce269..be6195e0d078 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -391,3 +391,5 @@ COND_SYSCALL(setuid16);
>
>  /* restartable sequence */
>  COND_SYSCALL(rseq);
> +
> +COND_SYSCALL(uretprobe);
> --
> 2.44.0
>

