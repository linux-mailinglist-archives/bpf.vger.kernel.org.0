Return-Path: <bpf+bounces-38928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980C296C82B
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 22:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF3FB2206D
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096191E7678;
	Wed,  4 Sep 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esiHTpoQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258651E6DFE;
	Wed,  4 Sep 2024 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480426; cv=none; b=iSeAFsNaiL9PqWnk0X5xhHgVSoGoZC3MEy3IXV55wRhhP5Hx3nIhjwXkdVmeEIJv2shZioTAh8XwLUX5zjEJiwQXWUpZYr+zLpM/HIjPSVSCFM+wWbG4qVybqxmn0gj/QVSUP+WqDAnp2Fgbz36u8aCApFvMaynGJI1KgHjLuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480426; c=relaxed/simple;
	bh=mSJMIPpxf/aZZjXfGdWtxZJ8a+BvEArfhwscDhs6+0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kthIEChcCye6loEPjomjIda5+EVak74SHQLefJMNY2D64VPSY/M1RNOTvTu/0XSl1y6I7CLijDARIb3HXhTSZI4osHKta9PleCDpqS5LPSZHsOWJm5hzEeTeH988Cu6KCjO47DCratk9jpALSuwvh0AGFNwzgck7IIqmZV9vios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esiHTpoQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so473634a91.1;
        Wed, 04 Sep 2024 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725480424; x=1726085224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PL5zY783QL6X5SPFrBarOo4DnXUeqnKK/ReHZ/2FTPE=;
        b=esiHTpoQW5fbVwa1+8igY2eB2jZVcESmEvlP6i2ui9oLi+nRHCuluurj/1AlgNeMVy
         54OgxcjQUboVaFmLNRLDLMHFL2foifwmXyVxnJ/7lUYdNj3YjgKvzsP04BS6fUDFp4xB
         poT4/8ZjihdFszYLRXM3JmoGEv//bqOIDv+eKhv1gcMtGBs4ZtyKHzCrYhkOxqN49q/j
         ATNu6U7WCbnH+nFkVt3Gad44KP36W6WEETj02UReip5hGFI/kMvZ9OlMVRBtmmU3Hoic
         wP435rfFeIhjl4OiedcXKk9FCWRffF3xgVJGe4RmUHveLsToXaWw+NiSP0S+I2orRZ1N
         bKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725480424; x=1726085224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PL5zY783QL6X5SPFrBarOo4DnXUeqnKK/ReHZ/2FTPE=;
        b=Ln+aaBev3S+p/ErGJ9pJsl4/HzAscXBNHpui696JEWJOk2pXRqkRrintOyAzJXy6Tm
         NnD0jHxi4eu0ftPlgw4cLIg1wR5nvDdrHy6j8q+zOBJb0W5584qrFnwfOXbupeHR9bsX
         bUh/NzaOSeNFR6tb7oQtZeFtIciUVK8Cz9Mus8hlAk5zwA3l1ACjox5668OzndkFhSQ3
         9BL96rPnpHZebcjRA+mF4+KgjjRjPr6QLFZbGXKGBtqbHpmTacvnPtknzFSQ4sojTqv7
         qfuJnfVWPPajv01dOl2MiRrUDIYGW2SRcuo6/uIVNiPcETvOGhfcFgfmloRWYeD+rpZs
         Ygbg==
X-Forwarded-Encrypted: i=1; AJvYcCWN+UVrmjjenRtEiKe8+eLnxND0QDCNU1K8HDtuTmA69qQ48EKa/SiN5i/9DrzP2G166ZA=@vger.kernel.org, AJvYcCXa7PAAqwApxz9YPVa6UHWIGTXHy8jXTn7y3a01QPCvqPGvN9thDpPyATCTVlFdOOvI0oF6Yy3Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvyqPe26QRRbocbLn02hDzM2lqsiHH7G9hcdbiNd8uYKYMLl5
	3FyvJkV5VCWMqtnXPbeig6pL4BFg6VP0Ez70EuQyijJAbcVhh4Ulwinoag75NUUotw2HEnqF4S+
	Pqa479BehiIFLGGpEb1b/PukGk9XSTo0h
X-Google-Smtp-Source: AGHT+IHtKAjwXpinnH/tZqcUVI5V2F9+JpSGQtocw+PFEoWrofm1Hdvs5NukodR/4HCKVW1RwKcnqKJY07uQSatTYXY=
X-Received: by 2002:a17:90a:df0f:b0:2d8:8681:44ba with SMTP id
 98e67ed59e1d1-2da62fdd953mr7557029a91.15.1725480424326; Wed, 04 Sep 2024
 13:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831041934.1629216-1-pulehui@huaweicloud.com>
 <20240831041934.1629216-3-pulehui@huaweicloud.com> <2379c139-6457-49dc-84fa-0d60ce226f2a@huaweicloud.com>
 <79b30c83-ee5e-453d-981e-61f826cf82d7@huaweicloud.com>
In-Reply-To: <79b30c83-ee5e-453d-981e-61f826cf82d7@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 13:06:51 -0700
Message-ID: <CAEf4BzZ4M5GK6_hopdL-8k+=-g975LoY71r6_YKdj-PxXthaMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] libbpf: Access first syscall argument
 with CO-RE direct read on arm64
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 12:57=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> On 8/31/2024 3:26 PM, Xu Kuohai wrote:
> > On 8/31/2024 12:19 PM, Pu Lehui wrote:
> >> From: Pu Lehui <pulehui@huawei.com>
> >>
> >> Currently PT_REGS_PARM1 SYSCALL(x) is consistent with PT_REGS_PARM1_CO=
RE
> >> SYSCALL(x), which will introduce the overhead of BPF_CORE_READ(), taki=
ng
> >> into account the read pt_regs comes directly from the context, let's u=
se
> >> CO-RE direct read to access the first system call argument.
> >>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> >> ---
> >>   tools/lib/bpf/bpf_tracing.h | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> >> index e7d9382efeb3..051c408e6aed 100644
> >> --- a/tools/lib/bpf/bpf_tracing.h
> >> +++ b/tools/lib/bpf/bpf_tracing.h
> >> @@ -222,7 +222,7 @@ struct pt_regs___s390 {
> >>   struct pt_regs___arm64 {
> >>       unsigned long orig_x0;
> >> -};
> >> +} __attribute__((preserve_access_index));
> >>   /* arm64 provides struct user_pt_regs instead of struct pt_regs to u=
serspace */
> >>   #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
> >> @@ -241,7 +241,7 @@ struct pt_regs___arm64 {
> >>   #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
> >>   #define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
> >>   #define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
> >> -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
> >> +#define PT_REGS_PARM1_SYSCALL(x) (((const struct pt_regs___arm64 *)(x=
))->orig_x0)
> >>   #define PT_REGS_PARM1_CORE_SYSCALL(x) \
> >>       BPF_CORE_READ((const struct pt_regs___arm64 *)(x), __PT_PARM1_SY=
SCALL_REG)
> >
> > Cool!
> >
> > Acked-by: Xu Kuohai <xukuohai@huawei.com>
> >
> >
>
> Wait, it breaks the following test:
>

You mean, *if you change the existing test like below*, it will break,
right? And that's expected, because arm64 has
ARCH_HAS_SYSCALL_WRAPPER, which means syscall pt_regs are actually not
the kprobe's ctx, so you can't directly access it. Which is why we
have PT_REGS_PARM1_CORE_SYSCALL() variants.

See how BPF_KSYSCALL macro is implemented, there are two cases:
___bpf_syswap_args(), which uses BPF_CORE_READ()-based macros to fetch
arguments, and ___bpf_syscall_args() which uses direct ctx reads.


> --- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> @@ -43,7 +43,7 @@ int BPF_KPROBE(handle_sys_prctl)
>
>          /* test for PT_REGS_PARM */
>
> -       bpf_probe_read_kernel(&tmp, sizeof(tmp), &PT_REGS_PARM1_SYSCALL(r=
eal_regs));
> +       tmp =3D PT_REGS_PARM1_SYSCALL(real_regs);
>          arg1 =3D tmp;
>          bpf_probe_read_kernel(&arg2, sizeof(arg2), &PT_REGS_PARM2_SYSCAL=
L(real_regs));
>          bpf_probe_read_kernel(&arg3, sizeof(arg3), &PT_REGS_PARM3_SYSCAL=
L(real_regs));
>
> Failed with verifier rejection:
>
> 0: R1=3Dctx() R10=3Dfp0
> ; int BPF_KPROBE(handle_sys_prctl) @ bpf_syscall_macro.c:33
> 0: (bf) r6 =3D r1                       ; R1=3Dctx() R6_w=3Dctx()
> ; pid_t pid =3D bpf_get_current_pid_tgid() >> 32; @ bpf_syscall_macro.c:3=
6
> 1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
> ; if (pid !=3D filter_pid) @ bpf_syscall_macro.c:39
> 2: (18) r1 =3D 0xffff800082e0e000       ; R1_w=3Dmap_value(map=3Dbpf_sysc=
.rodata,ks=3D4,vs=3D4)
> 4: (61) r1 =3D *(u32 *)(r1 +0)          ; R1_w=3D607
> ; pid_t pid =3D bpf_get_current_pid_tgid() >> 32; @ bpf_syscall_macro.c:3=
6
> 5: (77) r0 >>=3D 32                     ; R0_w=3Dscalar(smin=3D0,smax=3Du=
max=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
> ; if (pid !=3D filter_pid) @ bpf_syscall_macro.c:39
> 6: (5e) if w1 !=3D w0 goto pc+98        ; R0_w=3D607 R1_w=3D607
> ; real_regs =3D PT_REGS_SYSCALL_REGS(ctx); @ bpf_syscall_macro.c:42
> 7: (79) r8 =3D *(u64 *)(r6 +0)          ; R6_w=3Dctx() R8_w=3Dscalar()
> ; tmp =3D PT_REGS_PARM1_SYSCALL(real_regs); @ bpf_syscall_macro.c:46
> 8: (79) r1 =3D *(u64 *)(r8 +272)
> R8 invalid mem access 'scalar'
> processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
>

