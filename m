Return-Path: <bpf+bounces-54333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB77A679E4
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 17:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A661188CA03
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CEC211466;
	Tue, 18 Mar 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFj2QDWn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646CA849C
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316147; cv=none; b=TIFgDTpsc19Ai9oneu9CbnagOQ8dy5JdUavGYlcofVJkDyabAdxJ8uwwU0F/T0GCgpkmrSZeyXPW4pVH99UsmS9Oz4KXJyt4OucJLR5IALTe34PGGmLhsu5V7pv/vSJdEYS7Oem/XPsA01/+NXO36yC/9/cQ+gOQo0ozQVbB8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316147; c=relaxed/simple;
	bh=9WwC38k93rDRFh2Ju7wuZ+j1FBli14BowyguxHdzRVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vb7yr8wpflJTwjXZVQ/UAIw3KwECQGXNKkiI2ladboWnYsNgAKTBTVKLYq44PcXR3iiWXX3fwwhByB9VB3ChRpXU/md5eXtqmlpsy05FGRlKOXPbzIFUUTnfZFBQdYdtAkz2YC+Kc3+Fwx2E8pBWVk3M94L+yuuKtPgsD9etaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFj2QDWn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-391342fc1f6so4871994f8f.1
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742316138; x=1742920938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndSorvxL/tqAvdNymYvxU419zFAY6VNMpxfWhJZO7c4=;
        b=YFj2QDWn4oqTjBNvtUFGE0Kq7b4auLLhYuiLIft0BSEPt5bOlBxZGc9rCh8CTokSih
         ditnyMXFgYRqbUT+eXm8OlYTYkXdapqM3Ucd2UI4oQCfgQJKvGIl0EJNq5sI5UavvppL
         kSVXMxTTxc1jmsX3VEivFGlYAk9cfXnP8qcaYmjjzf++qK2AINvCmHSO9nI1vAu+VqHQ
         gZAOa6QBHhGQQDCdTZakIO1HZ8HO3hiAYugaGFTGSv4CD/fPjAttHqQhrUTpKwXA9d06
         A2fsSEc6fZhQ3Jijae5Bk4XMTNEUroON/OshNSa7G6VpFfYW6J1txQMBsBDli0MlOlhK
         rpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316138; x=1742920938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndSorvxL/tqAvdNymYvxU419zFAY6VNMpxfWhJZO7c4=;
        b=mPG9mC9bjcDW+u1mO1LEOxixfOQ1d9+/RLtHrS0eMhY4HZPftFUfgXo/c7E3edP14b
         qP4I/X/FExAaJqXa6H6TaiE03MmHamO2GK9OGlkCZA/MIELyL4CCpEWBWOfe0t2J4heD
         BtnSS3sJb3OnQakmROk28CH8JmlX+MlZuMO+5XJPI/ztNktIE/SLQV7Bjm2YTMBjzxuY
         9Gi7F/Bt/9g7Mi9LTovLqsIZB+34dYeifzcghAJQABE4bMhvOoA5nW2/E7d6ZPH5JsNk
         DXE0S52H4BFXjfXtkUb3YB2XAQA+R+XPO3x+570XmZnvS4YWyZusd2+cnnhoFqPbBN1f
         985g==
X-Forwarded-Encrypted: i=1; AJvYcCXNrxiN0VlRwVMlg2N6JgFVKRKdqp3d9o5MUtwcd0Dty50dbnJURvgfqRJzAE4XAhBsoNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqXIKCkPeZUpA+yNBplb21N6VjIcovZkdLEOQHoI0vecx/0bdC
	98zijYqkKGYvbOrkL8t41FJK/nuTaYkC5T24cwa4/zrwDdnssN1y8y5VXMyTCdaVvXYZXNSqsPf
	zorpfqsEUI4IzUAkluj7Q/S07k2s=
X-Gm-Gg: ASbGncuL22qHNxZOLfq3dNuHG747PJumhNtdzj1uIWuviJ78ecj9hsrYfbyNEo2K+fq
	wzb3Siwf3WyT62FXInOCfdVpQP+gb3czgROhhVl2Bipj/fMA8wOsCqJnS5n+bkMDBjsStd4dM5j
	zce+I1JTQXMtpbFVuC6v1j6LkJYgFHq0WsqOt+XCJA0w==
X-Google-Smtp-Source: AGHT+IEdNBIr6s0k+e+9FSw22lW5bPtuXLdqy0U1qtFah3J7xULTLiYy6X2fkMU5DQU11XcsR4h+CBU1jGrOkSCyI/I=
X-Received: by 2002:adf:b511:0:b0:391:139f:61af with SMTP id
 ffacd0b85a97d-3971e0bdc82mr12667407f8f.32.1742316138245; Tue, 18 Mar 2025
 09:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317224932.1894918-1-vadfed@meta.com> <20250317224932.1894918-3-vadfed@meta.com>
 <CAADnVQLYT5SV+tS2ycLteBMYOc12C=X7iHZ=RjhyVzuY=6=8Uw@mail.gmail.com> <ce3747ba-e363-4fca-97fc-af539b86d723@linux.dev>
In-Reply-To: <ce3747ba-e363-4fca-97fc-af539b86d723@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Mar 2025 09:42:07 -0700
X-Gm-Features: AQ5f1JraGoDo_vZS_Bxw5bl7lFk5LBuNeDEh1Kh5n3WW5uxbZX-GmEs3oyx9KfU
Message-ID: <CAADnVQ+aeSguyqCLau93yQuHWB9P2gveojdJshBa_7xOPqV4kQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 2/4] bpf: add bpf_cpu_time_counter_to_ns helper
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>, X86 ML <x86@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 1:44=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 18/03/2025 00:29, Alexei Starovoitov wrote:
> > On Mon, Mar 17, 2025 at 3:50=E2=80=AFPM Vadim Fedorenko <vadfed@meta.co=
m> wrote:
> >>
> >> The new helper should be used to convert deltas of values
> >> received by bpf_get_cpu_time_counter() into nanoseconds. It is not
> >> designed to do full conversion of time counter values to
> >> CLOCK_MONOTONIC_RAW nanoseconds and cannot guarantee monotonicity of 2
> >> independent values, but rather to convert the difference of 2 close
> >> enough values of CPU timestamp counter into nanoseconds.
> >>
> >> This function is JITted into just several instructions and adds as
> >> low overhead as possible and perfectly suits benchmark use-cases.
> >>
> >> When the kfunc is not JITted it returns the value provided as argument
> >> because the kfunc in previous patch will return values in nanoseconds.
> >>
> >> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> >> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >> ---
> >>   arch/x86/net/bpf_jit_comp.c   | 28 +++++++++++++++++++++++++++-
> >>   arch/x86/net/bpf_jit_comp32.c | 27 ++++++++++++++++++++++++++-
> >>   include/linux/bpf.h           |  1 +
> >>   kernel/bpf/helpers.c          |  6 ++++++
> >>   4 files changed, 60 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index 92cd5945d630..3e4d45defe2f 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -9,6 +9,7 @@
> >>   #include <linux/filter.h>
> >>   #include <linux/if_vlan.h>
> >>   #include <linux/bpf.h>
> >> +#include <linux/clocksource.h>
> >>   #include <linux/memory.h>
> >>   #include <linux/sort.h>
> >>   #include <asm/extable.h>
> >> @@ -2289,6 +2290,30 @@ st:                      if (is_imm8(insn->off)=
)
> >>                                  break;
> >>                          }
> >>
> >> +                       if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL=
 &&
> >> +                           IS_ENABLED(CONFIG_BPF_SYSCALL) &&
> >> +                           imm32 =3D=3D BPF_CALL_IMM(bpf_cpu_time_cou=
nter_to_ns) &&
> >> +                           cpu_feature_enabled(X86_FEATURE_TSC) &&
> >> +                           using_native_sched_clock() && sched_clock_=
stable()) {
> >
> > And now this condition copy pasted 3 times ?!
>
> Yeah, I'll factor it out
>
> >> +                               struct cyc2ns_data data;
> >> +                               u32 mult, shift;
> >> +
> >> +                               cyc2ns_read_begin(&data);
> >> +                               mult =3D data.cyc2ns_mul;
> >> +                               shift =3D data.cyc2ns_shift;
> >> +                               cyc2ns_read_end();
> >
> > This needs a big comment explaining why this math will be stable
> > after JIT and for the lifetime of the prog.
>
> It's more or less the same comment as for the JIT of
> bpf_get_cpu_time_counter(). I'll add it.
>
>
> >> +                               /* imul RAX, RDI, mult */
> >> +                               maybe_emit_mod(&prog, BPF_REG_1, BPF_R=
EG_0, true);
> >> +                               EMIT2_off32(0x69, add_2reg(0xC0, BPF_R=
EG_1, BPF_REG_0),
> >> +                                           mult);
> >> +
> >> +                               /* shr RAX, shift (which is less than =
64) */
> >> +                               maybe_emit_1mod(&prog, BPF_REG_0, true=
);
> >> +                               EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0),=
 shift);
> >> +
> >> +                               break;
> >> +                       }
> >> +
> >>                          func =3D (u8 *) __bpf_call_base + imm32;
> >>                          if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_ca=
ll_reachable) {
> >>                                  LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> >> @@ -3906,7 +3931,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
> >>   {
> >>          if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
> >>                  return false;
> >> -       if (imm =3D=3D BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
> >> +       if ((imm =3D=3D BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
> >> +           imm =3D=3D BPF_CALL_IMM(bpf_cpu_time_counter_to_ns)) &&
> >>              cpu_feature_enabled(X86_FEATURE_TSC) &&
> >>              using_native_sched_clock() && sched_clock_stable())
> >>                  return true;
> >> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp=
32.c
> >> index 7f13509c66db..9791a3fb9d69 100644
> >> --- a/arch/x86/net/bpf_jit_comp32.c
> >> +++ b/arch/x86/net/bpf_jit_comp32.c
> >> @@ -12,6 +12,7 @@
> >>   #include <linux/netdevice.h>
> >>   #include <linux/filter.h>
> >>   #include <linux/if_vlan.h>
> >> +#include <linux/clocksource.h>
> >>   #include <asm/cacheflush.h>
> >>   #include <asm/set_memory.h>
> >>   #include <asm/nospec-branch.h>
> >> @@ -2115,6 +2116,29 @@ static int do_jit(struct bpf_prog *bpf_prog, in=
t *addrs, u8 *image,
> >>                                          EMIT2(0x0F, 0x31);
> >>                                          break;
> >>                                  }
> >> +                               if (IS_ENABLED(CONFIG_BPF_SYSCALL) &&
> >> +                                   imm32 =3D=3D BPF_CALL_IMM(bpf_cpu_=
time_counter_to_ns) &&
> >> +                                   cpu_feature_enabled(X86_FEATURE_TS=
C) &&
> >> +                                   using_native_sched_clock() && sche=
d_clock_stable()) {
> >> +                                       struct cyc2ns_data data;
> >> +                                       u32 mult, shift;
> >> +
> >> +                                       cyc2ns_read_begin(&data);
> >> +                                       mult =3D data.cyc2ns_mul;
> >> +                                       shift =3D data.cyc2ns_shift;
> >> +                                       cyc2ns_read_end();
> >
> > same here.
> >
> >> +
> >> +                                       /* move parameter to BPF_REG_0=
 */
> >> +                                       emit_ia32_mov_r64(true, bpf2ia=
32[BPF_REG_0],
> >> +                                                         bpf2ia32[BPF=
_REG_1], true, true,
> >> +                                                         &prog, bpf_p=
rog->aux);
> >> +                                       /* multiply parameter by mut *=
/
> >> +                                       emit_ia32_mul_i64(bpf2ia32[BPF=
_REG_0],
> >> +                                                         mult, true, =
&prog);
> >
> > How did you test this?
> > It's far from obvious that this will match what mul_u64_u32_shr() does.
> > And on a quick look I really doubt.
>
> Well, I can re-write it op-by-op from mul_u64_u32_shr(), but it's more
> or less the same given that mult and shift are not too big, which is
> common for TSC coefficients.
>
> >
> > The trouble of adding support for 32-bit JIT doesn't seem worth it.
>
> Do you mean it's better to drop this JIT implementation?

yes.
The additional complexity doesn't look justified.

