Return-Path: <bpf+bounces-74485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA348C5C332
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6B7A4EF118
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78D3016F3;
	Fri, 14 Nov 2025 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDNAzr8k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD92222C4
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111455; cv=none; b=GUfT/C1G5wNUCYdhN1zhzfm/z4GiY9ioojPqsHotd9YPegfoxiUQMFAboND/WwbpnDEw4XlA6DI87pOIIFsdpD3G0w2CIuerWsERt5F9YlLxLBPJcFZegKNyrjOxuWbpw0++ETDXTa3/pMHVlfysih3p3u89meHY28GOl5/QWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111455; c=relaxed/simple;
	bh=Ms/SfMWuBCtQi21G533jex8/GiyaNJTb6vUj7oApzmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlpR9XutZABv5qAwjhk4jv88ulU8TUyGTzxMQvCDADnZqHMQYdcVHwW/djeXCqUVee+2vYXRzP/Yg1awRhlStnpiGtdklcc3DXzTFIlNvDC0Q7NJP3ytfBPIRnwSn3LFCNOwqWONUU3+/XN8+NPjDPk9TaUds227TEd96peW7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDNAzr8k; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso2945462a12.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111452; x=1763716252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1WY4KV4VQJH6YUB4BYCyh7D75ZeFou5KLEbTS6qDAs=;
        b=mDNAzr8k7zOj2E6VV1POPiBSDWwyToaOMfd4LAt7NLACWRS1wETDgapQLg3pCvZbFm
         BxU+hSGUkyf/zsZj88q0EPAcSOgXYYc51V2VxtY6F6PRGfkS44YS24+d2tU7r58SXY1r
         FMpTxwsZbYoXWAndIa2VRmP2/ZFy/HuAJoPU+16EL4xWfGjEtdCGXC7xSPMyC+mVmRxh
         YmEGFzBLbr/bNLZb6roPR8ymhkeJ9s+yftomV+79Pjn3mAS6vXRU/7kzyiyZeNbLdt7j
         4ImbSH/4oB/SXbfCHJbcUEJiSQouQTwoZWR7s7psZaMrlyRtXi6sVS5SYbI+6SgQOor9
         5R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111452; x=1763716252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1WY4KV4VQJH6YUB4BYCyh7D75ZeFou5KLEbTS6qDAs=;
        b=hN8ivKS3MQW0XsFwBxWQJ4L4oe8yT6TttP4mMKNcZn0ouwgiqcz/HfodbybyglxdX4
         l/ijT8YKDBA9FhBuxdb5oMvarWy+B8nhe12iTU//ZgcZ5v7/1ZTbe5rubWte0KyI+RSN
         1wVJGEMPeE4UCu09mPduGrnAtaqgLMF6CQPnG3AD8dkwEqJa1caa2N6T1MyV6gcLnLWL
         HCuaiBJNEvI3yG3QJUBw42p5L80JDdqtYEG1bUnSg4ivEhhDHaGqrnyAQBwgAM9Nbul/
         6yA5ldkwGCCSmT+Y2elfCQHxRAI0o2teBCAQjDW6ICrZgBIUcebSz6Y/cf/L+dnmHh8/
         kmsg==
X-Gm-Message-State: AOJu0YyRqe3uPZn0OJIMkpF5ozqNcCB1BdjBlzcxOUnGHZsvhcznVVLw
	9+BZnDSTLeYJFru84gl2Oo5FzOyVM4kt6Uhyijxh9kl+BInqY5kztHuc6vwHSRf4oxDIuyzwepT
	6B71J4u1wQTqx9EvjMs+va77EFqwUJaFcxGhLhw==
X-Gm-Gg: ASbGncvgZX1RnsjodVSzJIkHzdZNtdaqDkXrs8m4vzEYGPLqORTuTyJF2YahIdpo1PQ
	ZnRD482lnuxiVJdaZ7kVwZXN0/XTWJ/pR/10fsYSHLi1TP91/oq9OrBDmp4byFBQhS9sNk6+P/b
	v1vhc1asZlD7AZ8erkmNWsi1FqOVZTO2DAQLzT5z1b/a3FqBZA+FAhkaa1hl9iz16rT1+vwuI/c
	oHwy9ncIG0QzHndS1JAbbIX5efX/0iJwAB8gUneNb0DjXblxUC/IIYEKUHDJHDSXfXLue9+BZdf
	JZj7Uf26MK9HXA==
X-Google-Smtp-Source: AGHT+IFL5hh9QWPEwoI+1N4Nsk20ZlAEZqMnBb0RUWYGxHGkUwN4du2mxqK5lhlxxQlv2xTZrnHwKpHFkO4/qsEzVb0=
X-Received: by 2002:a05:6402:44d7:b0:640:9611:99d3 with SMTP id
 4fb4d7f45d1cf-64334f0ef96mr4211045a12.18.1763111452172; Fri, 14 Nov 2025
 01:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Fri, 14 Nov 2025 10:10:40 +0100
X-Gm-Features: AWmQ_bmwvzZwnV2YHptuPkC5845LsF0803AWn7DxPeNcm8mgPKcDf7zL1YtygtE
Message-ID: <CACkBjsa+J9iW+HoBfWh5V1P6raQGeoL2Ax6=V1HKA-kmWP54+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Recognize special arithmetic shift in
 the verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 4:10=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]

> The conditional branch in dsr_set_ipip6() and its return values
> are optimized into BPF_ARSH plus BPF_AND:
>
> 227: (85) call bpf_skb_store_bytes#9
> 228: (bc) w2 =3D w0
> 229: (c4) w2 s>>=3D 31   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,=
smin32=3D-1,smax32=3D0,var_off=3D(0x0; 0xffffffff))
> 230: (54) w2 &=3D -134   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3Dumax32=3D0x=
ffffff7a,smax32=3D0x7fffff7a,var_off=3D(0x0; 0xffffff7a))
>
> after insn 230 the register w2 can only be 0 or -134,
> but the verifier approximates it, since there is no way to
> represent two scalars in bpf_reg_state.
> After fallthough at insn 232 the w2 can only be -134,
> hence the branch at insn
> 239: (56) if w2 !=3D -136 goto pc+210
> should be always taken, and trapping insn 258 should never execute.
> LLVM generated correct code, but the verifier follows impossible
> path and rejects valid program. To fix this issue recognize this
> special LLVM optimization and fork the verifier state.
> So after insn 229: (c4) w2 s>>=3D 31
> the verifier has two states to explore:
> one with w2 =3D 0 and another with w2 =3D 0xffffffff
> which makes the verifier accept bpf_wiregard.bpf.c
>

Tested on my local setup, it solves the Cilium cases as expected.

However, this feels ad hoc: spitting states on very specific ranges.
For 1588 false rejections collected here[1], after this patch, 1561/1588
are still rejected. One can confirm this with the `load_progs.py` in my
repo (disable the `-d` option for bpftool if too slow).

I am wondering why not adopting the general solution introduced in this RFC=
[2].
What are the concerns and (potential) confusions? With this design, those
false rejections can be solved in a unified way (e.g., 1226/1588 are loaded=
,
the rest can be improved with a bit more refinement, except for the ones
requiring better loop handling).

[1] Progs: https://github.com/SunHao-0/BCF/tree/main/bpf-progs
[2] RFC: https://lore.kernel.org/bpf/20251106125255.1969938-1-hao.sun@inf.e=
thz.ch

[...]
> +static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_i=
nsn *insn,
> +                             struct bpf_reg_state *dst_reg)
> +{
> +       struct bpf_verifier_state *branch;
> +       struct bpf_reg_state *regs;
> +       bool alu32;
> +
> +       if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D 0=
)
> +               alu32 =3D false;
> +       else if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_val=
ue =3D=3D 0)
> +               alu32 =3D true;
> +       else
> +               return 0;
> +
> +       branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, fals=
e);
> +       if (IS_ERR(branch))
> +               return PTR_ERR(branch);
> +
> +       regs =3D branch->frame[branch->curframe]->regs;
> +       __mark_reg_known(&regs[insn->dst_reg], 0);

Here, the hidden assumption is: smax=3Ds32_max=3D0, which is true if it's c=
alled
by ALU32 ops or some ALU64 (e.g., ARSH), but not for all ALU64. Should
we add some comments for this in maybe_fork_scalars(), in case it's used
in other locations?

[...]

