Return-Path: <bpf+bounces-75516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28589C87877
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F583B6C0D
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45F2F3613;
	Tue, 25 Nov 2025 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkLPNuWf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C52F28F5
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114866; cv=none; b=g1xAdSohoAWiLM2bn1hZ6vsy/34BHfkasXOk4DV+LnlAjegY9iVFqwn5ebJX8pMDdnDBanY+eyyySgctSnbGFk27wIPHqpFi1RQcaWCpf8/DEI79T3r2mS2sfE+pN5XTR0UAwGArayIsQasM9a04A5E1Qo1tSHNKhDzhW08Z3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114866; c=relaxed/simple;
	bh=Yxo4Q8U8CB66tNAZTCyDHr3G+ojSS21kJmzLVc9a3RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkBMMvv4Ow4hsHzsVWzenb3eYlKU3rrSRykbsfQcsrg03MPsvSa2tY1AIxvmcyW7eZOBGVnV9nZgd9A5z71fzv0taUijCYgKbM33IM1uS9FfpED+8uNfjXWbevb2kimn563tCxqYIZjwu+K5GhB6NeZSO6sJUMTOxQhf68Jl/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkLPNuWf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34585428e33so6097103a91.3
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114864; x=1764719664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ub5NXz4tKTpMfCSCAc35Ls7StVYcCBWiwJnuFgdL1o=;
        b=SkLPNuWfavlH/Nfe3DqKUGDzZbdO/95+nST1PZQ1d6O2fVP9ns+3bkca5yZveMjgsD
         grp+A/1ZuO9n9GSYjml9C4mRQk9pkz9LVCWRURxIQ+lgL7C8W3zAuww4eFQvEZ0x0nnI
         d9JhJm2bw1a5ohV5smX93BdRG8HlWeCyVKl1/XrgkckE9f5bTagcF0xLexJFUBFbxE0B
         cteQpKgBOIfeasI1zIgf6OEUNGKlndFCOHXKQd/mf7EM2Kpaof8MfgN46BFmjuceHz9Q
         HBxmAmbIb76dg0W4t2xMsmj14jbJJGKCibSW/8XVE+no7r2ITqPMspACOytOrBMSebjV
         MSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114864; x=1764719664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ub5NXz4tKTpMfCSCAc35Ls7StVYcCBWiwJnuFgdL1o=;
        b=mBbf5rHdc9VhalTD08Q2HpoZi9AUtnP0jyp29h2J/62ZzW+J8Jv0uV+tkZVguQO4R0
         7kOPeCtm+CFowEcNwJZaFoX402P85aC/4XK120ads1t8Q4l3Ncmoi1f7SBQnOc7yZIFb
         //wl392I3CPFwSstUPvLp/KVdUu1iPfnnaDVmQPLPUoaI913TTdJNEvaPe5+T/HVCl+r
         Cst2OsDIWfmKiwp02utfOEY+JdvLz6Uu9nLX6ALi75abCwD3vt0RvoXrsGLD3hqLiuiu
         7UcX9UTEdU6f7bN5+n4gf5vkLeWDyWAcx+wTPPFOg2F3jU3d1mewJ8s2PJqjxy6azjnz
         O2rQ==
X-Gm-Message-State: AOJu0YxRRaES6i54d4mw5VfX2eNTw32z2YznbJkQO8Bi0OA+kXK1wSTx
	9Ew2Q5D4dQiRTRomMqfd/HOkhj7BcXNEjPNn0P4Ux92/63Vr2u972gdQ8V8Io1TicmYgkpyAtI4
	CDCKs3iQXcsDqdAefI8DQjo3k132Hbkk=
X-Gm-Gg: ASbGncva2xw37HuPi89hCAPUPPg5EsRgI3ppPyEYGoUMaDh0++gS2tz8lTaG5caZfMN
	fp9SfO63kyEXw0et2bZfREzgj3EtMDaNCLSDYUe5Qbhs3mPASvAf65V3OQRHYvUEGQXkW5cJIj1
	orpjz907BfeMRhFbs8tDR7M51q66VtOD+j68nZA86lr4YfcreIFN5W5SAsyJ6rD3lRUsY2IeKRB
	QGCGQQLhLI0Lcs6zp81MkJ9crbXZeV8C3vuSQVYd+u3ySebQk8iLHx5yn6c+J1T1AFqGT+n3u5e
	o5n0gfz0WeU=
X-Google-Smtp-Source: AGHT+IELkqhqry6Z/52lrL//3DYrXcqoP7fp0/kLkRKF2TJoYZUA8gy1J0iFcRdfYgJswNInYx6pY3J1ScLxk48ZYCY=
X-Received: by 2002:a17:90b:2f90:b0:32d:e780:e9d5 with SMTP id
 98e67ed59e1d1-34733ef6dc8mr17410848a91.22.1764114864261; Tue, 25 Nov 2025
 15:54:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-2-ameryhung@gmail.com>
In-Reply-To: <20251121231352.4032020-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 15:54:12 -0800
X-Gm-Features: AWmQ_bnDrUEZ8qY2C4FaiB5LNFT0_GXH_9giSsWQGV3uKEbtRvntqkMYficcPgs
Message-ID: <CAEf4BzaOM2GL+ieYyvTr9Gp6YC7e1GDfjHb42X7zb5Gs3ChtiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/6] bpf: Allow verifier to fixup kernel
 module kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Allow verifier to fixup kfuncs in kernel module to support kfuncs with
> __prog arguments. Currently, special kfuncs and kfuncs with __prog
> arguments are kernel kfuncs. Allowing kernel module kfuncs should not
> affect existing kfunc fixup as kernel module kfuncs have BTF IDs greater
> than kernel kfuncs' BTF IDs.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 098dd7f21c89..182d63b075af 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22432,8 +22432,7 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>
>         if (!bpf_jit_supports_far_kfunc_call())
>                 insn->imm =3D BPF_CALL_IMM(desc->addr);
> -       if (insn->off)
> -               return 0;
> +
>         if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] =
||
>             desc->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new=
_impl]) {
>                 struct btf_struct_meta *kptr_struct_meta =3D env->insn_au=
x_data[insn_idx].kptr_struct_meta;
> --
> 2.47.3
>

