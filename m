Return-Path: <bpf+bounces-55353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8C3A7C4FD
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 22:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8A63B1B90
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 20:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993A621E0B2;
	Fri,  4 Apr 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzYH5ewG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7421D599;
	Fri,  4 Apr 2025 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798809; cv=none; b=g+gPbvsBTUvqkg+5KG5kyai/wWN0ZoFm69tmttlV2UBdRv08tvJY8+pjfVLaHSVof+P2KF57QKOdCqzRESMRbAISjQIKpTrXXaAzeIpWEQIKCd8vTvmu0sL3CjVRof9QnMeQuv9BCamE6S3M+X5YbF+pLBk16A+G3g6OoOi+P04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798809; c=relaxed/simple;
	bh=jFvO2bJuTG4Ts4CMNjPFuPu6FgOmvIgksnPLagCcOxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cv5XJ+9/wvT+WEgqmEb/YZpS4qefHg62UTt9z/NIBi8OSbsPOxlv2hCIkXqKeh+fucMTjy6EdUIDBZmzpyrJkfRa38eW88cLwzxVCemc7H55ryzLvll5Hm9ZwUOk8cZ6EJzZFP7OalrluUHgrtmAw60isfELKe0PglAvBsfS7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzYH5ewG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so3902327a12.3;
        Fri, 04 Apr 2025 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743798805; x=1744403605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4jie8VsL5jEq4w1LylrEHNeeWtiZI/nPv4l0uBUSy8=;
        b=lzYH5ewG8AH6jVIVrzTApf5a3BdfwXqDOpThJ9EE5oY8IjwpqiHtBxCwMNZdo98d9b
         yNVx/M6Q8+JM7H+/XANYLpFL875dXJoGgWTNu16M1TLhhl2Cp7r1zw3pH5kDdWWnvye2
         oAboifuHjQnoW8wSKX/Gvltk0Y0gfmvHfN95DSFZvv0Na9HCK9DOZKU1wI7dF+xtKzlK
         wl7QdbkqFSqT1kJBsKGjWF9x8UqlbYeQkYWgG3TdQdMRjPcnyMw7vLHiU5Do+7/R1he3
         5tQsIKMX3BEQN+UVMB28b9x3ovA7QryVsJ31tRyD7GnsGQvtZVl9mX+FAh296znWsTLF
         KUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743798805; x=1744403605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4jie8VsL5jEq4w1LylrEHNeeWtiZI/nPv4l0uBUSy8=;
        b=I8PADt1OFg3/xKYw6HFBVzzGcJf7b71gSc0u31OV2rMjChHF6wJNqD/YEmg+Wl+GnR
         W9N5gdkCEyP7NyyrsJlewCmU25HuqnuyNkOfQMrD9LNT9fOoYeNWKANSZb3TxJvJX3JO
         tpRiFRET1uXemxn2bDoYtrzX3XieXa6s38PyRfQN3T5ovWHtCbPjGRoHs3KJxFPi+fLD
         76MSRtc2J2B9VLLdLtlx8Msp4YZjbY8L+cEtPdA3298dv9bf7/zx+NGojYj3xBan/L9r
         BCA0EX+SwzBqMfRdhF7CSdkkYAj7CLqmS4TU0810kxBrbqXkdguoTtXPG7kOzN+qki3T
         khKw==
X-Forwarded-Encrypted: i=1; AJvYcCUc2BsuQ/uKJhs4Hhop24toqN8pNTvn0SiuoLbQeDkEh7XiAUETlWTbCog0aA18w0aC1d3DSuY/B9YYcLTdlhddNbSR@vger.kernel.org, AJvYcCWcW2dquioWK6qXKpIc3WdXd+M6zezl8o3WsTEQq7NvOqqUlPe9ytavhu+JJ6g1imlVaqs=@vger.kernel.org, AJvYcCXziZcOCGviQCsDW1kzzRgEYmp73GCVKM1mmZsyoGzolXsM7wQ8UsrtIrXIQ90ORrD6XEpv9Yrbi48hYdFb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzceag8i/tCKPKk7wmwEzOTxJvOxJkwPMuDD+6/aQsejfUJiP6I
	8adad8FuKFbJuuXLJ5UjP/1h6YxK8X7ulDVR1VFo+5FdRShqY1jFo4CKWU9ch52z92CaIBlGgVr
	NteozBNMWkZVTR6zaaAu7gJtsk9g=
X-Gm-Gg: ASbGncucHADSoY9ebpHN2o351dFFPdR/XQA4DfsTG9Ody9qaHEvLDvolonQWbpPrd/6
	mKJLf3iJDBJH/ADyBx0tWCoSrhr1brAf535yM0OWWW5Egv0gusmXzXzBAy7N1xFOcyC2AFlylo5
	Q1yRZy9ER74oPw7B+8xgdWnP15JDDdo5gk0LwxTqPP31N71+Ijn3h0
X-Google-Smtp-Source: AGHT+IGeJqwUH8uBu4TLo/R6q3donYu47Xzk7fav2vZe9wavylS2grYPXEdbSi+E8TweeLGwkDzhWU2CqNxTaG1C3F8=
X-Received: by 2002:a17:906:7955:b0:ac3:3fe4:3378 with SMTP id
 a640c23a62f3a-ac7d181d95cmr515448666b.12.1743798805262; Fri, 04 Apr 2025
 13:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320114200.14377-1-jolsa@kernel.org> <20250320114200.14377-9-jolsa@kernel.org>
In-Reply-To: <20250320114200.14377-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 13:33:07 -0700
X-Gm-Features: ATxdqUHwd-OF88zMZHqc_3Ajvt9DS6mGBtT8fgVDUF8Sb0ZrwKrrJtTbymCwPD4
Message-ID: <CAEf4Bza=xexa6jixoz7dDY7WSoX3k5Tub231o_6nO_89LB_BjA@mail.gmail.com>
Subject: Re: [PATCH RFCv3 08/23] uprobes/x86: Add uprobe syscall to speed up uprobe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:43=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new uprobe syscall that calls uprobe handlers for given
> 'breakpoint' address.
>
> The idea is that the 'breakpoint' address calls the user space
> trampoline which executes the uprobe syscall.
>
> The syscall handler reads the return address of the initial call
> to retrieve the original 'breakpoint' address. With this address
> we find the related uprobe object and call its consumers.
>
> Adding the arch_uprobe_trampoline_mapping function that provides
> uprobe trampoline mapping. This mapping is backed with one global
> page initialized at __init time and shared by the all the mapping
> instances.
>
> We do not allow to execute uprobe syscall if the caller is not
> from uprobe trampoline mapping.
>
> The uprobe syscall ensures the consumer (bpf program) sees registers
> values in the state before the trampoline was called.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  arch/x86/kernel/uprobes.c              | 134 +++++++++++++++++++++++++
>  include/linux/syscalls.h               |   2 +
>  include/linux/uprobes.h                |   1 +
>  kernel/events/uprobes.c                |  22 ++++
>  kernel/sys_ni.c                        |   1 +
>  6 files changed, 161 insertions(+)
>

[...]

> +void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
> +{
> +       struct uprobe *uprobe;
> +       int is_swbp;
> +
> +       rcu_read_lock_trace();
> +       uprobe =3D find_active_uprobe_rcu(bp_vaddr, &is_swbp);
> +       if (!uprobe)
> +               goto unlock;
> +
> +       if (!get_utask())
> +               goto unlock;
> +
> +       if (arch_uprobe_ignore(&uprobe->arch, regs))
> +               goto unlock;
> +
> +       handler_chain(uprobe, regs);
> +
> + unlock:
> +       rcu_read_unlock_trace();

we now have `guard(rcu_tasks_trace)();`, let's use that in this
function, seems like a good fit?


> +}
> +
>  /*
>   * Perform required fix-ups and disable singlestep.
>   * Allow pending signals to take effect.
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index c00a86931f8c..bf5d05c635ff 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -392,3 +392,4 @@ COND_SYSCALL(setuid16);
>  COND_SYSCALL(rseq);
>
>  COND_SYSCALL(uretprobe);
> +COND_SYSCALL(uprobe);
> --
> 2.49.0
>

