Return-Path: <bpf+bounces-54252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E6A663BF
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 01:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30DF87A3451
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 00:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51221348;
	Tue, 18 Mar 2025 00:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8wV368R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BC18E25
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257800; cv=none; b=h3UdfWwMxi4TeRm3+AwNXWZ3a3Wk4dJp3QdOpsNrh3ffZEdEZY4VtCQa7xQcc3YjcF6GmKJlq6nS6lW/f9P3Ax47vHejpF2IZrlNjZOtHUOKPk+crZHpeH3B2C4Mxjb45sgVbOnMUb65RJPhCZok7QItRSShCUtokIAy/3pWEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257800; c=relaxed/simple;
	bh=12Nw42TCEU370jH3sGRybYh/L0RIzsymDRr3Lnttrdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/+LC6c844jArnbMmPr0XnYm0BQMpq17kCq1OJrk7zQKh5i+MCtxSI1xA1MhrVWplyFQrKmK39sgIgbj+mWN8vousp0umV+5lGI58Wh7fs2N6vokGvRIxqw6RuGhDbWOjUF9/Lp9mO3izG9w3+ZP1J/60Ti+WugvhEpkRFx4m/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8wV368R; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4403823f8f.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 17:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742257796; x=1742862596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAL5e3c7lwCEBM3c6ZUq9iHXfTRtCNV0zM0BTZ/DUxA=;
        b=G8wV368RXj6c6NeqaBJfsH9F+mA34znHCpWw+pN7kJSnrV9TpIBY/E5M8Dpbt412/6
         oUJhxqgvGozbhaGehRgla5+vwvusrRaZ51AnJ0xBN4a1r4c+mEbXFkkbD3YukexOpMeW
         8ztHOVdZAkXpm2f31fKryshj9wEKjhk01DbAZeFrWx8Cv+zQa/AbWul12LeyQ2L5VMcD
         FcoYK/7hkxfJbeYqfFp051bVFVskvoKgYwR0W3fQI/fLzhOYfYwetxTwo8c9yKTXmCWW
         FKbTCQWJywz8vYaG4GtV3xU56AQPNO0R9bETDFvchVJ/Mz4hbvjSRMt6bq21bw0Uobtz
         pibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742257796; x=1742862596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAL5e3c7lwCEBM3c6ZUq9iHXfTRtCNV0zM0BTZ/DUxA=;
        b=FK7Y2ncqLqsoOxlws56Xcbug28r99iDnxaRb6VwzMUrA7wbceHA3ipdEKh/pFV2UGK
         Fm20Uw7Z3QStUV+p9VUU884JmzCxwFy+KjnIP8MA5y1p0QkwFtvlK5S00Xa+ILQmPAS7
         HQHZ/wxw8GkimMyfsNY47+zXVL8otIfw358F5gP7z4Cvz9HrfIqTOhVYjzKbpgeGJMgz
         yaVzMqpweBwdWFS+OB813VLpBcaNWSrqU4mEK1Doyz0spkX4Pp2/E+/eUgSDW+ke19/k
         FotKEtFbp4ujZ/tDC+LFZKkh7LDXpSgauTMh9O9pkKwH7wwdfbhUU/+AO9zjBHLNVeBL
         1c/g==
X-Forwarded-Encrypted: i=1; AJvYcCXj9Twamy/XgHJVea6isX//ZV6pCCTsx99rimGIfi4OV3iqb+MwsnGsnt5G99ndC8TMtHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yurI7JFnJ2S392lWV67UK+NSrcmq7t0J+N9zBF2jQ9zP+Ej1
	Ri3dKhXD8U75RYvnGP/m1Hp0s9DuOeEQkW2lnidOLKPx8bdbyMLexHlyGKMX1HsBIr5oMGMBdHr
	t+Y5evGOz9V9v8/3y8cXxpFzEW+U=
X-Gm-Gg: ASbGncspLBgncxUxAiOFWAYEPTM74v8NayxKCsktkZTeO81+7lGuCjDcjKbJ2/7+Ukp
	7UFxsHcifYK/bJGaPfr4JmVLhwTU7LGF0o0OAhuAqTLabIHLPxBvGsGXgs8YnWS8SQmz2gMFYxA
	jPGt150QtsIQ3FNAhxgr9R/SbREqhPoZuSn+/5Uyd+Bw==
X-Google-Smtp-Source: AGHT+IGMXxkuyadIcxVyMCd21idpeJjvb7sPPHlCUOcxPWYtb2JtrAOou0kCiTn1/XcDPBRZr0UBLcMV2Mn3mwdmYHs=
X-Received: by 2002:a05:6000:144d:b0:398:9e96:e798 with SMTP id
 ffacd0b85a97d-3989e96e883mr9208892f8f.13.1742257796550; Mon, 17 Mar 2025
 17:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317224932.1894918-1-vadfed@meta.com> <20250317224932.1894918-3-vadfed@meta.com>
In-Reply-To: <20250317224932.1894918-3-vadfed@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Mar 2025 17:29:43 -0700
X-Gm-Features: AQ5f1JqdV5at1o-ioXc_BLhVfv-J8HcnEjoHZ0XZyfoIV81_XcmS-1rQcGytxSM
Message-ID: <CAADnVQLYT5SV+tS2ycLteBMYOc12C=X7iHZ=RjhyVzuY=6=8Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 2/4] bpf: add bpf_cpu_time_counter_to_ns helper
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mykola Lysenko <mykolal@fb.com>, X86 ML <x86@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 3:50=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> The new helper should be used to convert deltas of values
> received by bpf_get_cpu_time_counter() into nanoseconds. It is not
> designed to do full conversion of time counter values to
> CLOCK_MONOTONIC_RAW nanoseconds and cannot guarantee monotonicity of 2
> independent values, but rather to convert the difference of 2 close
> enough values of CPU timestamp counter into nanoseconds.
>
> This function is JITted into just several instructions and adds as
> low overhead as possible and perfectly suits benchmark use-cases.
>
> When the kfunc is not JITted it returns the value provided as argument
> because the kfunc in previous patch will return values in nanoseconds.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  arch/x86/net/bpf_jit_comp.c   | 28 +++++++++++++++++++++++++++-
>  arch/x86/net/bpf_jit_comp32.c | 27 ++++++++++++++++++++++++++-
>  include/linux/bpf.h           |  1 +
>  kernel/bpf/helpers.c          |  6 ++++++
>  4 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 92cd5945d630..3e4d45defe2f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -9,6 +9,7 @@
>  #include <linux/filter.h>
>  #include <linux/if_vlan.h>
>  #include <linux/bpf.h>
> +#include <linux/clocksource.h>
>  #include <linux/memory.h>
>  #include <linux/sort.h>
>  #include <asm/extable.h>
> @@ -2289,6 +2290,30 @@ st:                      if (is_imm8(insn->off))
>                                 break;
>                         }
>
> +                       if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> +                           IS_ENABLED(CONFIG_BPF_SYSCALL) &&
> +                           imm32 =3D=3D BPF_CALL_IMM(bpf_cpu_time_counte=
r_to_ns) &&
> +                           cpu_feature_enabled(X86_FEATURE_TSC) &&
> +                           using_native_sched_clock() && sched_clock_sta=
ble()) {

And now this condition copy pasted 3 times ?!

> +                               struct cyc2ns_data data;
> +                               u32 mult, shift;
> +
> +                               cyc2ns_read_begin(&data);
> +                               mult =3D data.cyc2ns_mul;
> +                               shift =3D data.cyc2ns_shift;
> +                               cyc2ns_read_end();

This needs a big comment explaining why this math will be stable
after JIT and for the lifetime of the prog.

> +                               /* imul RAX, RDI, mult */
> +                               maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_=
0, true);
> +                               EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_=
1, BPF_REG_0),
> +                                           mult);
> +
> +                               /* shr RAX, shift (which is less than 64)=
 */
> +                               maybe_emit_1mod(&prog, BPF_REG_0, true);
> +                               EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), sh=
ift);
> +
> +                               break;
> +                       }
> +
>                         func =3D (u8 *) __bpf_call_base + imm32;
>                         if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_r=
eachable) {
>                                 LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> @@ -3906,7 +3931,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
>  {
>         if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
>                 return false;
> -       if (imm =3D=3D BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
> +       if ((imm =3D=3D BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
> +           imm =3D=3D BPF_CALL_IMM(bpf_cpu_time_counter_to_ns)) &&
>             cpu_feature_enabled(X86_FEATURE_TSC) &&
>             using_native_sched_clock() && sched_clock_stable())
>                 return true;
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.=
c
> index 7f13509c66db..9791a3fb9d69 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -12,6 +12,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/filter.h>
>  #include <linux/if_vlan.h>
> +#include <linux/clocksource.h>
>  #include <asm/cacheflush.h>
>  #include <asm/set_memory.h>
>  #include <asm/nospec-branch.h>
> @@ -2115,6 +2116,29 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image,
>                                         EMIT2(0x0F, 0x31);
>                                         break;
>                                 }
> +                               if (IS_ENABLED(CONFIG_BPF_SYSCALL) &&
> +                                   imm32 =3D=3D BPF_CALL_IMM(bpf_cpu_tim=
e_counter_to_ns) &&
> +                                   cpu_feature_enabled(X86_FEATURE_TSC) =
&&
> +                                   using_native_sched_clock() && sched_c=
lock_stable()) {
> +                                       struct cyc2ns_data data;
> +                                       u32 mult, shift;
> +
> +                                       cyc2ns_read_begin(&data);
> +                                       mult =3D data.cyc2ns_mul;
> +                                       shift =3D data.cyc2ns_shift;
> +                                       cyc2ns_read_end();

same here.

> +
> +                                       /* move parameter to BPF_REG_0 */
> +                                       emit_ia32_mov_r64(true, bpf2ia32[=
BPF_REG_0],
> +                                                         bpf2ia32[BPF_RE=
G_1], true, true,
> +                                                         &prog, bpf_prog=
->aux);
> +                                       /* multiply parameter by mut */
> +                                       emit_ia32_mul_i64(bpf2ia32[BPF_RE=
G_0],
> +                                                         mult, true, &pr=
og);

How did you test this?
It's far from obvious that this will match what mul_u64_u32_shr() does.
And on a quick look I really doubt.

The trouble of adding support for 32-bit JIT doesn't seem worth it.

> +                                       /* shift parameter by shift which=
 is less than 64 */
> +                                       emit_ia32_rsh_i64(bpf2ia32[BPF_RE=
G_0],
> +                                                         shift, true, &p=
rog);
> +                               }
>
>                                 err =3D emit_kfunc_call(bpf_prog,
>                                                       image + addrs[i],
> @@ -2648,7 +2672,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
>  {
>         if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
>                 return false;
> -       if (imm =3D=3D BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
> +       if ((imm =3D=3D BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
> +           imm =3D=3D BPF_CALL_IMM(bpf_cpu_time_counter_to_ns)) &&
>             cpu_feature_enabled(X86_FEATURE_TSC) &&
>             using_native_sched_clock() && sched_clock_stable())
>                 return true;
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a5e9b592d3e8..f45a704f06e3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3389,6 +3389,7 @@ u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 =
r4, u64 r5);
>
>  /* Inlined kfuncs */
>  u64 bpf_get_cpu_time_counter(void);
> +u64 bpf_cpu_time_counter_to_ns(u64 counter);
>
>  #if defined(CONFIG_NET)
>  bool bpf_sock_common_is_valid_access(int off, int size,
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 43bf35a15f78..e5ed5ba4b4aa 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3198,6 +3198,11 @@ __bpf_kfunc u64 bpf_get_cpu_time_counter(void)
>         return ktime_get_raw_fast_ns();
>  }
>
> +__bpf_kfunc u64 bpf_cpu_time_counter_to_ns(u64 counter)
> +{
> +       return counter;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3299,6 +3304,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_=
ITER_DESTROY | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_local_irq_save)
>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
>  BTF_ID_FLAGS(func, bpf_get_cpu_time_counter, KF_FASTCALL)
> +BTF_ID_FLAGS(func, bpf_cpu_time_counter_to_ns, KF_FASTCALL)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> --
> 2.47.1
>

