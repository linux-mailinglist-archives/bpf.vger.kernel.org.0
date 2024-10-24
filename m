Return-Path: <bpf+bounces-43106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17B9AF51C
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780701F22A54
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C93021733C;
	Thu, 24 Oct 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qos2/UF3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A91C4A32
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807814; cv=none; b=XzKAftrVF5O2ZeKdEPqpQio/vQRujO36UZr57bY/CFp5lOH1ysWrlEVSiKdpRefjQ6xkRo0KwYdYjWSw0F++ZBbRCXwwAZUBpft6t37jVZ/eCkc/se7HGvnuG71yfV3HPS03kdecWSloZEed4ztGFvrOzj25KL7OOVU0Ju0fc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807814; c=relaxed/simple;
	bh=mIqPd/qYvC2YX78Z1ecH4gTxSHaJqJ8AycpSaiJ3JfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDGDoHoFW33/6Hz7mzcA0Kwuf7LFtxDTDNyxdzSULbkxsPy9xkRwrvRf0LWWOaiNF46Bi9V69VMfAQDPUA44CJsF07U0eZjPxJaPY7QxwKZk2grDP4cYMVxniCzUfMwl72qXKWScrnkgpnc7lix/Cw7Jb9sZ/hhdlvkB8hnbfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qos2/UF3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314b316495so13391525e9.2
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729807811; x=1730412611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYFaIuTa0H2qk6M2rZLl5kpyXu54inZIhHI5s6iup+I=;
        b=Qos2/UF3j7h/PzBBtyRuyP/M8vBX1oNJmr15OwCFHArcUhgyj1F2Ff69ZiIKlij7FM
         IB8HrlvC6VfIaAGm909AyrBLfzbUajMALlBEVR+s5gumssP7L98dyg+54Jk+M+CNaLeA
         2mUjmCrW6dgcTyNOmwTEU9Zgt+kfXMqQgp493Wiwcr9+1zqkpoYe96uszeDclE8i/fuD
         ioErYAH66spOXRa/2f6FZVaSLu5Amy9jaxYrF3TJFm9h85Kek8FFivxhMfABuXAkLzxR
         RMx+ESJ8NZAVUnbEP0UDuf5d5wWkn2RuUYieUDCcboYzg9ulibImnTgkAKPIsxzcFUYv
         Ut4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729807811; x=1730412611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYFaIuTa0H2qk6M2rZLl5kpyXu54inZIhHI5s6iup+I=;
        b=WaoG6V7h4iYJkrWuR7uR+cp3DBgwOQntT3Dyys8AR1QxG89COnCqgKyHVdrIDBV7xk
         +x7KZtt7SZXafGFYhV32crZPxeqLp7EOHhHxUPd+hH/Kz0q6W5PGiYLM4kILVC5ozOlY
         QvUtjolLJCO34EFz9Wn/8tCToKLFgM1F1Y7mCVMjjyfrHPOK3ovlWamhvxv7T3V56iP/
         b5b/T6xvRMSulTmK7n2QYs/dcqoVBtTRwLaI8ucmoPzZzLxJ4tZ/XWj62923EP/4PeE3
         Kj4ID6dZNxooDb2UB6UjCMUO37+RkILWMxPT6tXESSJJTZsuMOPcrJZCoZVtA9l/Gi3m
         Mqcg==
X-Gm-Message-State: AOJu0YyD4z9Ivju+qCVLbcNRuRfW589wz9NtdtrFLIsOqpagNkDLZMOw
	nOTr2idirXOhqSjoYZcSHY8IAG2nvE98EJJc2lMdc+eL79CyLqBg5R9nB7chC3ufuaZvgCW9oMQ
	6YWcvSZsh5C/R0TDmoGDnDE6T+0o=
X-Google-Smtp-Source: AGHT+IFbg07Kw16EOwmZmNsa2cfk0AjGLRMj33HBK6zka9qMQFMosAxb4w3Z5sk4onm/tizmMm0cJRLjKtnn4AsPoGw=
X-Received: by 2002:a05:600c:19d4:b0:42c:c401:6d67 with SMTP id
 5b1f17b1804b1-431841306a9mr60512285e9.6.1729807810438; Thu, 24 Oct 2024
 15:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021133929.67782-1-leon.hwang@linux.dev> <20241021133929.67782-2-leon.hwang@linux.dev>
In-Reply-To: <20241021133929.67782-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Oct 2024 15:09:59 -0700
Message-ID: <CAADnVQKO3rdaVrNOcLbm=kmue4orurcRTuskgrdze_=ExS2A7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x64: Propagate tailcall info only for
 tail_call_reachable subprogs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Eddy Z <eddyz87@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:39=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> In the x86_64 JIT, when calling a function, tailcall info is propagated i=
f
> the program is tail_call_reachable, regardless of whether the function is=
 a
> subprog, helper, or kfunc. However, this propagation is unnecessary for
> not-tail_call_reachable subprogs, helpers, or kfuncs.
>
> The verifier can determine if a subprog is tail_call_reachable. Therefore=
,
> it can be optimized to only propagate tailcall info when the callee is
> subprog and the subprog is actually tail_call_reachable.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 4 +++-
>  kernel/bpf/verifier.c       | 6 ++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa57..6ad6886ecfc88 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2124,10 +2124,12 @@ st:                     if (is_imm8(insn->off))
>
>                         /* call */
>                 case BPF_JMP | BPF_CALL: {
> +                       bool pseudo_call =3D src_reg =3D=3D BPF_PSEUDO_CA=
LL;
> +                       bool subprog_tail_call_reachable =3D dst_reg;
>                         u8 *ip =3D image + addrs[i - 1];
>
>                         func =3D (u8 *) __bpf_call_base + imm32;
> -                       if (tail_call_reachable) {
> +                       if (pseudo_call && subprog_tail_call_reachable) {
>                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->sta=
ck_depth);
>                                 ip +=3D 7;
>                         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f514247ba8ba8..6e7e42c7bc7b1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19990,6 +19990,12 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
>                         insn[0].imm =3D (u32)addr;
>                         insn[1].imm =3D addr >> 32;
>                 }
> +
> +               if (bpf_pseudo_call(insn))
> +                       /* In the x86_64 JIT, tailcall information can on=
ly be
> +                        * propagated if the subprog is tail_call_reachab=
le.
> +                        */
> +                       insn->dst_reg =3D env->subprog_info[subprog].tail=
_call_reachable;

I really don't like hacking flags into dst_reg.
We already abuse insn->off which is ugly too,
but at least we clean insns later after JIT.

I'd rather live with this tail call inefficiency than abuse insns
fields further.

pw-bot: cr

