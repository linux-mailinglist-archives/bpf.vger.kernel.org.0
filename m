Return-Path: <bpf+bounces-37306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15D953C90
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697331F2743E
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CAD14F10F;
	Thu, 15 Aug 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OM45Do7Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830C14E2F5
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757076; cv=none; b=nTnWDh/OCWsqDEgqZo7ojqgfArCD7o4m/u92qXybBCWQjJ7oMTCq88jk037ErIkcRfwctEW5zhSdDsBLVG+uEltUc6NOGmqsbbCu16m5cAbutnTvQ+7snWfCDOFc8/A5a4j/kIbvqznIXa38/JEe+j4l7YgWjntw01YFjQIxGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757076; c=relaxed/simple;
	bh=YuH+ybWoN/PQbRLkdtDI9fOQ9KwjoMas99Q8hKjz0fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mImWGds4utCLwtDH0qnsIKd5IQx3bY1D/jLwujRSlQ4DLL/I07M+WCpT46McrDEblgdTLX01Yg/tPMALCCplmY+TWetyMcNwfaVEj4ls7PDgwLctwFP960WDHfCsOzwjMA+yONYafl6XUiCBMhJkX4gCUbXPec8Z6Oe0ySq2MCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OM45Do7Q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso1107667a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723757074; x=1724361874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4jNHXpiYyFbciktWC8aaUPNQ0vWZDTwoJX5bYitb9w=;
        b=OM45Do7QKkkj83wy6okNtvBxXJrv9RkGr7lOnaEyjTHBR0blogE8wS6QMzAZjU1KDE
         wEcrc3jhVIeseweRmfuMO6KD0NRUsZJk2Eu5CD1rVLllpTbOlxJ2HRPx6Cwp8wzYb0TE
         y3keV+pasYCwZtHi9MT2xD0jGH1TY1hf+sv/sD0n8tI5d+cYORKYxZUU5gz7DAXJl5MB
         vLhrBpMxQTIM78Bb+SZVNUQDE/LU06jMq9Ooyrs7lqkSN5I5y12CAzBlH8DxWHNv2a2d
         nGXo7I3lQnO64Z6D0AR6QtLCtUUNc6Vza0VFkNLDwysmMXehC6bLRs+NY9Bk9hODS7+Q
         DQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723757074; x=1724361874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4jNHXpiYyFbciktWC8aaUPNQ0vWZDTwoJX5bYitb9w=;
        b=RP8OTxbxsYqi5MyqBq2AbZPcxwUWMXj6AHL69Phpcku0jHZpuCKcjV6rVp4HQ1zBDT
         lJqOlgTDHZCez/PV5zpq88X+dREkCbbBZUU9MrIHuHDEzMRODrUe3ccvkQ2sCKIw1B59
         lACje4nTcTIb50dAlzNNlFHynGW9i1adt+OvE88JgUrGE5xa2zu64mzOSUtH/0dZfhxh
         ZrAFL9QUW/dPpLzV/WREXztGAFRpN3y4AMHBR6vMZB6LF24iWnjcEnkExpQgrhCES9N6
         TiwV914kLOPo6xueF7SjdfeZsGt6O2WtzFeW5woB4QEm+x4TDt21c9TTwFjdyyzsiVDr
         qZJA==
X-Gm-Message-State: AOJu0Yx3V/46U8BVsFlpEiwZUKtEumGq4j7H7EO8nN+kivrfWZWMCJz9
	8G7D93sx5BnoCV7MtqQA1hijZkT33xsIh6ioWcaXq3jdkPxKq3ZsJEqHjzWIdyaPGDDT8ih0xBi
	PlcqreSHUtZLkyleuVIfZfijdR+w=
X-Google-Smtp-Source: AGHT+IFRECTUgKPanlE/uuSZKSeFN7zHW3yi5JfutvCo32FW+0qX9cB3H2r9yKSs48DvhS8xVCz3htN0PuQOPbtCUnQ=
X-Received: by 2002:a05:6a20:e687:b0:1c8:edad:64d3 with SMTP id
 adf61e73a8af0-1c904f7ee3dmr1066750637.3.1723757074188; Thu, 15 Aug 2024
 14:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812234356.2089263-1-eddyz87@gmail.com> <20240812234356.2089263-2-eddyz87@gmail.com>
In-Reply-To: <20240812234356.2089263-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 14:24:21 -0700
Message-ID: <CAEf4BzZXyq8Y85v6UQo+xZZCyxSndsnHpPQnxfR-_FOfVqMseg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 4:44=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Recognize nocsr patterns around kfunc calls.
> For example, suppose bpf_cast_to_kern_ctx() follows nocsr contract
> (which it does, it is rewritten by verifier as "r0 =3D r1" insn),
> in such a case, rewrite BPF program below:
>
>   r2 =3D 1;
>   *(u64 *)(r10 - 32) =3D r2;
>   call %[bpf_cast_to_kern_ctx];
>   r2 =3D *(u64 *)(r10 - 32);
>   r0 =3D r2;
>
> Removing the spill/fill pair:
>
>   r2 =3D 1;
>   call %[bpf_cast_to_kern_ctx];
>   r0 =3D r2;
>
> Add a KF_NOCSR flag to mark kfuncs that follow nocsr contract.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/btf.h   |  1 +
>  kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index cffb43133c68..59ca37300423 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -75,6 +75,7 @@
>  #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next metho=
d */
>  #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructo=
r */
>  #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu c=
s when they are invoked */
> +#define KF_NOCSR        (1 << 12) /* kfunc follows nocsr calling contrac=
t */
>
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize t=
he
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3be12096cf..c579f74be3f9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(struct =
bpf_verifier_env *env, s32 imm)
>         }
>  }
>
> +/* Same as helper_nocsr_clobber_mask() but for kfuncs, see comment above=
 */
> +static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta *meta=
)
> +{
> +       const struct btf_param *params;
> +       u32 vlen, i, mask;
> +
> +       params =3D btf_params(meta->func_proto);
> +       vlen =3D btf_type_vlen(meta->func_proto);
> +       mask =3D 0;
> +       if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto-=
>type)))
> +               mask |=3D BIT(BPF_REG_0);
> +       for (i =3D 0; i < vlen; ++i)
> +               mask |=3D BIT(BPF_REG_1 + i);

Somewhere deep in btf_dump implementation of libbpf, there is a
special handling of `<whatever> func(void)` (no args) function as
having vlen =3D=3D 1 and type being VOID (i.e., zero). I don't know if
that still can happen, but I believe at some point we could get this
vlen=3D=3D1 and type=3DVOID for no-args functions. So I wonder if we should
handle that here as well, or is it some compiler atavism we can forget
about?

> +       return mask;
> +}
> +
> +/* Same as verifier_inlines_helper_call() but for kfuncs, see comment ab=
ove */
> +static bool verifier_inlines_kfunc_call(struct bpf_kfunc_call_arg_meta *=
meta)
> +{
> +       return false;
> +}
> +
>  /* GCC and LLVM define a no_caller_saved_registers function attribute.
>   * This attribute means that function scratches only some of
>   * the caller saved registers defined by ABI.
> @@ -16238,6 +16260,20 @@ static void mark_nocsr_pattern_for_call(struct b=
pf_verifier_env *env,
>                                   bpf_jit_inlines_helper_call(call->imm))=
;
>         }
>
> +       if (bpf_pseudo_kfunc_call(call)) {
> +               struct bpf_kfunc_call_arg_meta meta;
> +               int err;
> +
> +               err =3D fetch_kfunc_meta(env, call, &meta, NULL);
> +               if (err < 0)
> +                       /* error would be reported later */
> +                       return;
> +
> +               clobbered_regs_mask =3D kfunc_nocsr_clobber_mask(&meta);
> +               can_be_inlined =3D (meta.kfunc_flags & KF_NOCSR) &&
> +                                verifier_inlines_kfunc_call(&meta);
> +       }
> +
>         if (clobbered_regs_mask =3D=3D ALL_CALLER_SAVED_REGS)
>                 return;
>
> --
> 2.45.2
>

