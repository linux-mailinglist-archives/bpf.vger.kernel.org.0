Return-Path: <bpf+bounces-33580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC55591EBE0
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87A0283478
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82BD6FCB;
	Tue,  2 Jul 2024 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvgCMRp+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B679DF
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880921; cv=none; b=HSBPOECahDjDXNhL2vpLw94jHveckWN4lg9B1fGKOTn2L3XXGGl25oOIUWvbzG2TC+RRgCoBxPdcK22XVTmrkAwIZ7YBbuiJEUYZ5W47HRn1Synkcd8Db5w7JeyhU/vHpqMqSSxvNB7zHqFPRn2lPftmipIeG3/NU4BwplCLu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880921; c=relaxed/simple;
	bh=obdV3ABnd7BdVj5NJvDs6HqQxLcmW/j6mwcq2jFFWR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ2gYPoxKzuOgOeSg8QASO1hFWApLvdMvrssOLojleLjqX5DMU4CJZYk741j7O3CMBVugrJscEEq3UXKJRF9nmY6molQNUHKAAqMdBA1EH5dODXT2NivB1kzOmyfPhW3pAG2xyJ4+sAmxfb5MgapxTuwU50+mVt7VFZf+Lf+7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvgCMRp+; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f8ef63714cso1947541a34.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719880919; x=1720485719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKvzXxByV35vNT7L5HOGwyp74cikjBwQ07R339MFJv8=;
        b=RvgCMRp+CxCLJAORay54J5A6hQpVEFKMey9NT0qEu0IMBkbSy4EDPvmyFwL7fUekPq
         rHNOon0zAssap6uHv2IagqBaWoqnkeN3o2uzlP04xc03euK60re8ag11vKAO5eVzz+3z
         2jb4QQuQ1wK3PHKxHRjHV8494xhFJh7ryYi7AvgrXS8kzMRsCzvZjYbQlBJ1izO69T/H
         JwutXqT8+BSvRm18MiCUnjhqAIkz0TNO04BVedzZSni6AwXEaZO1UjiOJGdE5CFK6MjJ
         PdOa47CEBYCH0TMjO1fkv8GLmy1F6Z8JDko2BKBQhVOfnraxjHB8Kso0fwIPiL1xDY0r
         4hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880919; x=1720485719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKvzXxByV35vNT7L5HOGwyp74cikjBwQ07R339MFJv8=;
        b=WuxoJup69J9z56cUhykAj2bgDqcWKqWvFkzKUkYHcs40r+0bBOkCvOGfAlfaR7ASof
         YCFMOZw9lIIokJTWEbHYnXNzU9cdDWWTL6hCFFV22BOPVpSFvMm2qz7s18/hKE6PE6N/
         DY9Jrq2NE8+Xai3Zwa4AuKKqfYCtVWlXmStRMsr7so2exTlvmGEwfa8eDnvddMPKoJge
         UsrefNyKeMKPkmUT99TM7rlGNXCJfV0jkev/zvt5P4ZK98+/ER8gAS3Lxaemt1mgqe+i
         crqItseV/iLHkRJfW/soytmj86o5RZR57U/0ulxvgdB2pUhVjbE3lolX4uUPJLLA4KNs
         XSJw==
X-Gm-Message-State: AOJu0YwW5dIkITsB4hHOv6aj948533nGGO2hFtzRhovWvsU6LNnFQvWn
	PWaxX/huXfxxM50oB9qF9lJkS+/kV23SqRBP79yOZvBl4Otg7JS6YJYASuc+IsACzsxAhzNj5UU
	b34Jq6iy0cbRhnfXiAoliQwzLtN5gVQ==
X-Google-Smtp-Source: AGHT+IEzPmRdZ5YIglvKrEPZ/S0+8qqhg1r2xk9pJagzUh3GXrlWLaLUJCs76pU/04cEppEorw/8qXZ9XUliyW/oXf8=
X-Received: by 2002:a05:6808:2288:b0:3d5:64d6:9f12 with SMTP id
 5614622812f47-3d6b2b25c7amr10989586b6e.3.1719880918970; Mon, 01 Jul 2024
 17:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-4-eddyz87@gmail.com>
In-Reply-To: <20240629094733.3863850-4-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:41:44 -0700
Message-ID: <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for bpf_get_smp_processor_id()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On x86 verifier replaces call to bpf_get_smp_processor_id() with a
> sequence of instructions that modify only R0.
> This satisfies attribute no_caller_saved_registers contract.
> Allow rewrite of no_caller_saved_registers patterns for
> bpf_get_smp_processor_id() in order to use this function
> as a canary for no_caller_saved_registers tests.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/helpers.c  |  1 +
>  kernel/bpf/verifier.c | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 229396172026..1df01f454590 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -158,6 +158,7 @@ const struct bpf_func_proto bpf_get_smp_processor_id_=
proto =3D {
>         .func           =3D bpf_get_smp_processor_id,
>         .gpl_only       =3D false,
>         .ret_type       =3D RET_INTEGER,
> +       .nocsr          =3D true,

I'm wondering if we should call this flag in such a way that it's
clear that this is more of an request, while the actual nocsr cleanup
and stuff is done only if BPF verifier/BPF JIT support that for
specific architecture/config/etc?

>  };
>
>  BPF_CALL_0(bpf_get_numa_node_id)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1340d3e60d30..d68ed70186c8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16030,7 +16030,14 @@ static u8 get_helper_reg_mask(const struct bpf_f=
unc_proto *fn)
>   */
>  static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s=
32 imm)
>  {
> -       return false;
> +       switch (imm) {
> +#ifdef CONFIG_X86_64
> +       case BPF_FUNC_get_smp_processor_id:
> +               return env->prog->jit_requested && bpf_jit_supports_percp=
u_insn();
> +#endif

please see bpf_jit_inlines_helper_call(), arm64 and risc-v inline it
in JIT, so we need to validate they don't assume any of R1-R5 register
to be a scratch register


> +       default:
> +               return false;
> +       }
>  }
>
>  /* If 'insn' is a call that follows no_caller_saved_registers contract
> @@ -20666,7 +20673,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>  #ifdef CONFIG_X86_64
>                 /* Implement bpf_get_smp_processor_id() inline. */
>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
> -                   prog->jit_requested && bpf_jit_supports_percpu_insn()=
) {
> +                   verifier_inlines_helper_call(env, insn->imm)) {
>                         /* BPF_FUNC_get_smp_processor_id inlining is an
>                          * optimization, so if pcpu_hot.cpu_number is eve=
r
>                          * changed in some incompatible and hard to suppo=
rt
> --
> 2.45.2
>

