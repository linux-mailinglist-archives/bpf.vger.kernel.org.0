Return-Path: <bpf+bounces-27738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D58B15BA
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079B7B22A9E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305F158D9A;
	Wed, 24 Apr 2024 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYFAopDP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66424156F46;
	Wed, 24 Apr 2024 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996118; cv=none; b=kYy/Yt+NSq6HWMavwpfx6RH45FPWXJMJHnBLOZCH+P+tyHw3s1vfDtjSpVIcc8ELQKDaidpiKYzxTIdssI03T6EL1GhGkB0loFyjB94bwUOu6gnc+ey7CViYCm3xzl5qPqRTinCJ8PvjTKWW34EVlDMm9Zfol2+2CmAIhpHbfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996118; c=relaxed/simple;
	bh=ZG+ntgzi5PkM1bTjwukYHVngl+la9QsTQx+Dj2qKr3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTDsjluXciivHMvsZ+rO8Goc1atarYX2lhh1S1rQXjm3/X8I3hcI0X+laLDoX7db07rQWJh6Hin887/UDdIpAUHgd/QrjfsZNXrbBMFvJQHX3pk9DINNfnraJYnhGO+i76OhEHFrEWYo72UTQ/iIW3+jf9VrS1aza5qdGvRKSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYFAopDP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ad8919ba0cso400289a91.0;
        Wed, 24 Apr 2024 15:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713996117; x=1714600917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mlLExVU78P1Piha27/if7uYZprH+trWT7TZL2SvYBQ=;
        b=PYFAopDPjYrluuTHbTOngh+6lBffHPFozF+Trj+7yiNdJk3i4YXj1qP6B3T3aQ9eW2
         u4dNrxBO627H39VvogdG/ZUbwJ2Emixv6wAdgPWpUBuHAhfpJVlmvBlcmadFEqJUXujO
         0Lw0jqozs00xYFJ3R1d7AP5Hjqxfr8+gWJPtdHQWXeAJRNsRvel0kWYxG1pjVvy1EWmw
         n5zJWQuNQSMP4cbnl/ZoJmgSao4bKTmVie2kDeKbNO/ae5J2SuD/yXsjDUGiEkXwIr+d
         jmKYbN7iKXjwI+O35BpYzuzcIMtdkb0ca02/lQEbnnu1d3ArWL8uWX67l1z7BCiYFJCh
         HFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713996117; x=1714600917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mlLExVU78P1Piha27/if7uYZprH+trWT7TZL2SvYBQ=;
        b=DSIcKzY9MtTNCP9NDrhS4onodswq/I/zTNdj3PR6rIHHBeGhlDE1NolPIsYpNRldI6
         oUMy0ov95Zwns8qisy3vln7EMKCoYBlidldNvED1UHEgaVCew8Nxh7Ev8FavOWH+rqm0
         G5KYJXAFk8bWirfGt1oit6IpqZwMBil8FHSwdMgFxzrl0bHoCKJZ+gAPibF+MdF1RFzz
         rfUi1bWKQNdFpOSNqS+aT/NcwsLiem1dtoTFF1j0KMgr1pz9c28YZpKBx/P5G/OoZHt2
         TSYP6juOq9Gs4PPO0PlQlFsVZOvXehaxFDl7C2oHG8HmbZVAD2lsbN+ig+qI6AOFxaCz
         IiJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkFSF3iGJ0bk5ZzvRrtI8R8eZqIcVmLyiwiU8mUFCGxBNr9MShip57VtUvFYfVHtnZrWaVg5+gtA4nHKzoxzpVzH2V/nOA5Ibiot0A6nT1VctfpxF+c+ZlyJcQPoOP5+3f
X-Gm-Message-State: AOJu0YzrQeZ3fdUoV9ynJ+wD+q7dqSgUVnpX19IJsEsOXCfUno/B03M5
	laNdbe6V//sPLa6mpUeMYylH5LcjBN3zEfzCMkmK1AWWndhNTqgS9HBhqOOuTp4n7NJn5gvSDxw
	Awt5oyMPyZNRCrSchS1A9r26gA9Y=
X-Google-Smtp-Source: AGHT+IGBt6/cXnnlWIm2WuIW72gihVu448YDBwXpNTuksNUq5ldhuf6uEU4n70occoDe0KbcmZTgdV2ODP/auyiKPyc=
X-Received: by 2002:a17:90b:4a83:b0:2af:6ce2:bbc8 with SMTP id
 lp3-20020a17090b4a8300b002af6ce2bbc8mr2360066pjb.6.1713996116560; Wed, 24 Apr
 2024 15:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424173550.16359-1-puranjay@kernel.org> <20240424173550.16359-3-puranjay@kernel.org>
In-Reply-To: <20240424173550.16359-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Apr 2024 15:01:43 -0700
Message-ID: <CAEf4BzZOFye13KdBUKA7E=41NVNy5fOzF3bxFzaeZAzkq0kh-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, arm64: inline bpf_get_smp_processor_id()
 helper
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Florent Revest <revest@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:36=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> As ARM64 JIT now implements BPF_MOV64_PERCPU_REG instruction, inline
> bpf_get_smp_processor_id().
>
> ARM64 uses the per-cpu variable cpu_number to store the cpu id.
>
> Here is how the BPF and ARM64 JITed assembly changes after this commit:
>
>                                          BPF
>                                         =3D=3D=3D=3D=3D
>               BEFORE                                       AFTER
>              --------                                     -------
>
> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_smp=
_processor_id();
> (85) call bpf_get_smp_processor_id#229032       (18) r0 =3D 0xffff8000820=
72008
>                                                 (bf) r0 =3D r0

nit: hmm, you are probably using a bit outdated bpftool, it should be
emitted as:

(bf) r0 =3D &(void __percpu *)(r0)

>                                                 (61) r0 =3D *(u32 *)(r0 +=
0)
>
>                                       ARM64 JIT
>                                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>               BEFORE                                       AFTER
>              --------                                     -------
>
> int cpu =3D bpf_get_smp_processor_id();      int cpu =3D bpf_get_smp_proc=
essor_id();
> mov     x10, #0xfffffffffffff4d0           mov     x7, #0xffff8000fffffff=
f
> movk    x10, #0x802b, lsl #16              movk    x7, #0x8207, lsl #16
> movk    x10, #0x8000, lsl #32              movk    x7, #0x2008
> blr     x10                                mrs     x10, tpidr_el1
> add     x7, x0, #0x0                       add     x7, x7, x10
>                                            ldr     w7, [x7]
>
> Performance improvement using benchmark[1]
>
>              BEFORE                                       AFTER
>             --------                                     -------
>
> glob-arr-inc   :   23.817 =C2=B1 0.019M/s      glob-arr-inc   :   24.631 =
=C2=B1 0.027M/s
> arr-inc        :   23.253 =C2=B1 0.019M/s      arr-inc        :   23.742 =
=C2=B1 0.023M/s
> hash-inc       :   12.258 =C2=B1 0.010M/s      hash-inc       :   12.625 =
=C2=B1 0.004M/s
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

Besides the nits, lgtm.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9715c88cc025..3373be261889 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20205,7 +20205,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                         goto next_insn;
>                 }
>
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)

I think you can drop this, we are protected by
bpf_jit_supports_percpu_insn() check and newly added inner #if/#elif
checks?

>                 /* Implement bpf_get_smp_processor_id() inline. */
>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
>                     prog->jit_requested && bpf_jit_supports_percpu_insn()=
) {
> @@ -20214,11 +20214,20 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                          * changed in some incompatible and hard to suppo=
rt
>                          * way, it's fine to back out this inlining logic
>                          */
> +#if defined(CONFIG_X86_64)
>                         insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(un=
signed long)&pcpu_hot.cpu_number);
>                         insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
>                         insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
>                         cnt =3D 3;
> +#elif defined(CONFIG_ARM64)
> +                       struct bpf_insn cpu_number_addr[2] =3D { BPF_LD_I=
MM64(BPF_REG_0, (u64)&cpu_number) };
>

this &cpu_number offset is not guaranteed to be within 4GB on arm64?

> +                       insn_buf[0] =3D cpu_number_addr[0];
> +                       insn_buf[1] =3D cpu_number_addr[1];
> +                       insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> +                       insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
> +                       cnt =3D 4;
> +#endif
>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
>                         if (!new_prog)
>                                 return -ENOMEM;
> --
> 2.40.1
>

