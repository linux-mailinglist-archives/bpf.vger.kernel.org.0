Return-Path: <bpf+bounces-54236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F6BA65F05
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 21:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A63B3B754E
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D61F4162;
	Mon, 17 Mar 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH162qjY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422731D934D
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242857; cv=none; b=SmoyuT65xGWPsb2HaGGBn0NpOoJe5Exk4qPev2b7NH1IIOpnT7Md96+Jth58W4h4/iuucsL4fvKXdOUfukoxPoKkMqy8B1dCYx9t/ej0H1Jjzn9OHPZ64ptmtS6KgmmvKNCtoVmE9PNyn5UQM/Ifk0EJR3A9c4aJjopZPgxCtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242857; c=relaxed/simple;
	bh=DBBYMIvBVe2dCvv5XKPSYdcSpjNGnlATXfg+lZW21ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TonL90JH6WC/Zt9AvBs5AQG8BrX03cWj6XqEzqHF3ZS7+ctHE+iLN0SEs9XWVOu4DyDAhJNFrCFpr+w1KhlQ3kXotLvWu+Fi94pKWF5u6s9QEablozIUcIUHzAO1womYwaqGZZETF/FWzwa8Cl8bNObi2fI/b+jbvghyMj1osYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH162qjY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39149bccb69so4841232f8f.2
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742242853; x=1742847653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r01ffLcrPHlu9AUL3mejKYR5OfGTYGtIRa7OrJMQCH0=;
        b=CH162qjYks5uJkRtSbv/3B912K+UURJobRG1rUOYhJQYObmDetLywpl1qHWHyB2H5c
         18vIrGEIyfEx0j2qLWjDSiKxI0PwLGgidRRdXBoLZAqY9Qw4Z5MlzyfBl74ot1ykZXqS
         EGAlVyxPfQRqSSsB9cm0FEQRDOaiJ2Snch4kMIT1z4siKG+63kFxX7QPMJc5BcgVARj9
         ZGY+BTYJ8L4ODyd8vSJmGibeuqtUv7AwmmXFViHa6ZtIaHl9nFfU6UROiFPZr6oH48jO
         byJqFcdv2G5ONXMQX4IhXnZRJIWEQdnVoL7C9cNk+Qx576v+nPm5w7aT6FH7JRFhrq9m
         RgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742242853; x=1742847653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r01ffLcrPHlu9AUL3mejKYR5OfGTYGtIRa7OrJMQCH0=;
        b=sw/qirLTnXwRLZc5ZEectJUzhgim8EwK8bOQmgiPJVCer1CMULShTJ0OFn36Q7wGpx
         QNL3WnRap1ehCLoOsLv9IrqXret8NlsWI3M8geBJsG5My1MQwITE6UfmV5PxvhjZ13LR
         DMfKE3EwiA4m/pZleYY0SVqGjJG/7sw72U5sL3Zw9yOAX2vtN4dZMm5FhMRR/PFZytLo
         /HQzcDF3voDrwhaxmB3RF2BSxmeowVr9nlQfzEe25824VAAy8+wmxNuuOrQKiekIQ6og
         GWIt2OWGrXpkA8mJNoRQv7ng03orSQObE4ys3fKlcMC8WixfB5CKcEoR0GibwJtYOy2H
         7peQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPuWymx6QBep3SeJ/CwQeeiJg5B2RQ8r4/dfnCM0KKUd57yd09Z1YiNIdfuO+YLpqdRN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8aGx/4YfYqea42hQL0v2VhUh1yXWDvvdVxTXSp6OAEP2VEnOM
	iRTiwALc/Bv679YYyV/V/XLJWyjMO9/QxvfH/QH2gaRNS5UiOxx5b41xzC1+qZ2+jvG/jurzmwd
	FIAHOO92XURXjo+wEB39FbkXM0/k=
X-Gm-Gg: ASbGncu2vmzGVCMHHK/hviER/DGM9pzhGMiv3o/S8FQhbhdHKfGW4mJVlfYNI+pyoTQ
	xFwMa6nUf1QReZjvjLuApbs6M4wJ5rLv0QQ5LSG+PYMz0rs7sh8H2uvV4sOsQM6flOiEDTSQGv5
	g1Y14KiOdkPy/uOum2HNWc8lLQASgUDt2wk+R0pMfBjw==
X-Google-Smtp-Source: AGHT+IG9p+uCxNtw/Ibq1JkvMjkwlmu2qlHrxawaubsOoeGDfCbg4NufIokI2oM/SrtK7fWRqA5D/VQ4F5asS4C++Vc=
X-Received: by 2002:a05:6000:144b:b0:390:f9d0:5df with SMTP id
 ffacd0b85a97d-3996b4a217bmr598119f8f.52.1742242853208; Mon, 17 Mar 2025
 13:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317121735.86515-1-laoar.shao@gmail.com> <20250317121735.86515-2-laoar.shao@gmail.com>
In-Reply-To: <20250317121735.86515-2-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Mar 2025 13:20:42 -0700
X-Gm-Features: AQ5f1Jqr3TolhjaQWJ33Zr8zUP2axz0rswKEceNhLVgiqD3P-Ofn1VQEF0FZEXs
Message-ID: <CAADnVQK=TBLUNrUUa0Yhi=M1-MfNVkKYKKca+jmTysJypign+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Reject attaching fexit/fmod_ret to
 __noreturn functions
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 5:18=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> If we attach fexit/fmod_ret to __noreturn functions, it will cause an
> issue that the bpf trampoline image will be left over even if the bpf
> link has been destroyed. Take attaching do_exit() with fexit for example.
> The fexit works as follows,
>
>   bpf_trampoline
>   + __bpf_tramp_enter
>     + percpu_ref_get(&tr->pcref);
>
>   + call do_exit()
>
>   + __bpf_tramp_exit
>     + percpu_ref_put(&tr->pcref);
>
> Since do_exit() never returns, the refcnt of the trampoline image is
> never decremented, preventing it from being freed. That can be verified
> with as follows,
>
>   $ bpftool link show                                   <<<< nothing outp=
ut
>   $ grep "bpf_trampoline_[0-9]" /proc/kallsyms
>   ffffffffc04cb000 t bpf_trampoline_6442526459    [bpf] <<<< leftover
>
> In this patch, all functions annotated with __noreturn are rejected, exce=
pt
> for the following cases:
> - Functions that result in a system reboot, such as panic,
>   machine_real_restart and rust_begin_unwind
> - Functions that are never executed by tasks, such as rest_init and
>   cpu_startup_entry
> - Functions implemented in assembly, such as rewind_stack_and_make_dead a=
nd
>   xen_cpu_bringup_again, lack an associated BTF ID.
>
> With this change, attaching fexit probes to functions like do_exit() will
> be rejected.
>
> $ ./fexit
> libbpf: prog 'fexit': BPF program load failed: -EINVAL
> libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
> Attaching fexit/fmod_ret to __noreturn functions is rejected.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/verifier.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5..b7d7d5c4989f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22841,6 +22841,49 @@ BTF_ID(func, __rcu_read_unlock)
>  #endif
>  BTF_SET_END(btf_id_deny)
>
> +/* fexit and fmod_ret can't be used to attach to __noreturn functions.
> + * Currently, we must manually list all __noreturn functions here. Once =
a more
> + * robust solution is implemented, this workaround can be removed.
> + */
> +BTF_SET_START(noreturn_deny)
> +#define NORETURN(fn) BTF_ID(func, fn)

no need for extra macro. Just use BTF_ID(...) below.

> +#ifdef CONFIG_IA32_EMULATION
> +NORETURN(__ia32_sys_exit)
> +NORETURN(__ia32_sys_exit_group)
> +#endif
> +#ifdef CONFIG_KUNIT
> +NORETURN(__kunit_abort)
> +NORETURN(kunit_try_catch_throw)
> +#endif
> +#ifdef CONFIG_MODULES
> +NORETURN(__module_put_and_kthread_exit)
> +#endif
> +#ifdef CONFIG_X86_64
> +NORETURN(__x64_sys_exit)
> +NORETURN(__x64_sys_exit_group)
> +#endif
> +#ifdef CONFIG_XEN_PV_SMP
> +NORETURN(cpu_bringup_and_idle)
> +#endif

it's called during bringup. bpf doesn't exist at that time.
Drop it.

> +NORETURN(do_exit)
> +NORETURN(do_group_exit)
> +#if defined(CONFIG_X86) && defined(CONFIG_SMP)
> +NORETURN(hlt_play_dead)
> +#endif

This one is similar to panic.
Drop it.

> +#ifdef CONFIG_HYPERV
> +NORETURN(hv_ghcb_terminate)
> +#endif

Also does 'hlt'.
Drop it.

> +NORETURN(kthread_complete_and_exit)
> +NORETURN(kthread_exit)
> +NORETURN(make_task_dead)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +NORETURN(sev_es_terminate)
> +NORETURN(snp_abort)

drop both for the same reason as above.

> +#endif
> +NORETURN(stop_this_cpu)

and this one as well.

Pls make sure to resend as series of 2 patches
otherwise bpf CI will complain.

pw-bot: cr

