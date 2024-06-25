Return-Path: <bpf+bounces-32982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D81915BA8
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0EAB21669
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370701759F;
	Tue, 25 Jun 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nblkFVbG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF814005
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278828; cv=none; b=HpbfYSeCBv3hjKlSM0EMbBVB9sYWQFR4usEtTWDZ5w20KvmXlxpiIMBhEkvZ3dMRsOEgowfR6hw5HUIF35DlH3NwGGrJYbtp2bXvoUjWgD3H7xLSpjE5FAq6Re0APhFynRoDe/Xia10liCuv4Vpw8okjCfR6xZL6OEiJC7Ylg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278828; c=relaxed/simple;
	bh=xhFMXpx672/Yf82msc/9VMdE4i/LkN2llTMdJR+K0gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUtl3DAEdD26lSzBAXJ8sggt4i2ILDcTPU6yUcZd15J0aTBOgvlZJpOgrRAiNts78nlzyQhYLmGelhnECUwlq5nnTzH/a2UV7RBK2+DSppe3s0VWRbm1Gh4DpcI6w+Wfo/ogqDY9kL/8ogGGO1KhgO9pXxsP175thE2tJiNPxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nblkFVbG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3629c517da9so4996435f8f.2
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 18:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719278825; x=1719883625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQdLVcyLKFQo4dXfY9wTekIgp7IjPhewBEzlEewYNAk=;
        b=nblkFVbGDLSzbIBuNgxNmD92eMj4eWgHkQ7RVkUTLdc87GGvHU/mdCDGGXEoh4MsTa
         I8xCSWYn8KhJ7mqNFr534qiCFOq557WaTfqMhXw6JVWyOzotCn6PfAPDI5Y1ecJClkoD
         1GceIGnpA5gRxB5CpmxgpBJnwRvec4sF31wSAH5b5PUQyrZ6dLdsucPOnHTA1DbgUxbN
         R05qQG13yXDg16s98zx3oBr3gRginD97FrbEBOAXtrbcGk2G0yXw4Gc8cUMi/Jfjlh/o
         nXWnlHwwWWC6F6elVKVfUlJyKSWkq0bLlYqP3c9TC1+luYd4z6tsBMq/KS2qYjuFUuxr
         NeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719278825; x=1719883625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQdLVcyLKFQo4dXfY9wTekIgp7IjPhewBEzlEewYNAk=;
        b=qEWm7MvwmH//UuhGLX0WK8tNXftT2OTal69NIwSseGS6h4jbrQji8g0Qwuk5vrXQlu
         +RADdN1CF7DasmheMK5ZCwFZC/q+Vi95fkMxtxo9spF3kpS8VN9qohHwznXMFcP48VZo
         onIbhVUNYeNDt4NwxTMqQWbxTJcM/DJp4Xeh6w9aB6ZkpQTrlcFvf/2m/PUXS+wkfSjv
         NUXT/cLSDgusbVCCbtvRblxk0cHVOpCy4P6iMNIgiDkwASgFwaYDu1BF5YpbazUWqmsX
         6vnyHZuGo8sj6yWcWEqW9GTTNNp2mW/ReMOoTKO1P9u9Re7Sa6fpjSG9wh6Qw2GXmsxo
         Crlw==
X-Gm-Message-State: AOJu0YzrSN8Pk2cR3+SUO1M9XzBkT7CtXXoPKDx6iWWiOoKUQE677Hjt
	fmTQqnxm+ble6vPp8DTvGM7OiSbBP+cbSxp52pi58743O1c6uXmtWmTL8EH7h8ebAm79rqrzDDa
	BWwzYrSjiUVo6WY9QGOYgfIaHGR0=
X-Google-Smtp-Source: AGHT+IEzlIypGuq/+vFqTgbZvKFNGRtfw82uYqmU/GwPjOnRNFIhBDo5RwkZMXQELi23PpzkJ93LlnEHII9tkuEavjQ=
X-Received: by 2002:a05:6000:1863:b0:366:ec30:adcd with SMTP id
 ffacd0b85a97d-366ec30ae93mr5656927f8f.7.1719278825163; Mon, 24 Jun 2024
 18:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619092216.1780946-1-memxor@gmail.com> <20240619092216.1780946-2-memxor@gmail.com>
In-Reply-To: <20240619092216.1780946-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Jun 2024 18:26:53 -0700
Message-ID: <CAADnVQJzt3+jWAa9LNeU-n+eKfebdpqDWzb6ceg0aOEH5V9LQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] x86: Perform BPF exception fixup in do_user_addr_fault
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andy Lutomirski <luto@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Rishabh Iyer <rishabh.iyer@berkeley.edu>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 2:22=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Currently, on x86, when SMAP is enabled, and a page fault occurs in
> kernel mode for accessing a user address, the kernel will rightly panic
> as no valid kernel code can cause such a page fault (unless buggy).
> There is no valid correct kernel code that can generate such a fault,
> therefore this behavior would be correct.
>
> BPF programs that currently encounter user addresses when doing
> PROBE_MEM loads (load instructions which are allowed to read any kernel
> address, only available for root users) avoid a page fault by performing
> bounds checking on the address.  This requires the JIT to emit a jump
> over each PROBE_MEM load instruction to avoid hitting page faults.
>
> We would prefer avoiding these jump instructions to improve performance
> of programs which use PROBE_MEM loads pervasively. For correct behavior,
> programs already rely on the kernel addresses being valid when they are
> executing, but BPF's safety properties must still ensure kernel safety
> in presence of invalid addresses. Therefore, for correct programs, the
> bounds checking is an added cost meant to ensure kernel safety. If the
> do_user_addr_fault handler could perform fixups for the BPF program in
> such a case, the bounds checking could be eliminated, the load
> instruction could be emitted directly without any checking.
>
> Thus, in case SMAP is enabled (which would mean the kernel traps on
> accessing a user address), and the instruction pointer belongs to a BPF
> program, perform fixup for the access by searching exception tables.
> All BPF programs already execute with SMAP protection. When SMAP is not
> enabled, the BPF JIT will continue to emit bounds checking instructions.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  arch/x86/mm/fault.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index e6c469b323cc..189e93d88bd4 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -21,6 +21,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/mm.h>                  /* find_and_lock_vma() */
>  #include <linux/vmalloc.h>
> +#include <linux/filter.h>              /* is_bpf_text_address()        *=
/
>
>  #include <asm/cpufeature.h>            /* boot_cpu_has, ...            *=
/
>  #include <asm/traps.h>                 /* dotraplinkage, ...           *=
/
> @@ -1257,6 +1258,16 @@ void do_user_addr_fault(struct pt_regs *regs,
>         if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
>                      !(error_code & X86_PF_USER) &&
>                      !(regs->flags & X86_EFLAGS_AC))) {
> +               /*
> +                * If the kernel access happened to an invalid user point=
er
> +                * under SMAP by a BPF program, we will have an extable e=
ntry
> +                * here, and need to perform the fixup.
> +                */
> +               if (is_bpf_text_address(regs->ip)) {
> +                       kernelmode_fixup_or_oops(regs, error_code, addres=
s,
> +                                                0, 0, ARCH_DEFAULT_PKEY)=
;
> +                       return;
> +               }

I see no harm doing this check here. Looks correct.

Andy,
we've talked about this idea in the past.
Any objections to this optimization?

