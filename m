Return-Path: <bpf+bounces-39636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7242975927
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A8C1C23074
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D571AC8B7;
	Wed, 11 Sep 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDKNj/FV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A275FB8D
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075041; cv=none; b=tDIw1WdEHQp9sB3keWwAZ3o8g1xr4ycG9YN7k/1k9AxiZ1jwUgqNeshIgArrXdyavMUwVw3O2jTn5o6mWnbHhEZ+fWW0CptSsGYc6KYqhQFKcPb/HtyUs4zHXjr9zMflZHqYB958M9b2uCzzSfnSlYQLnZVgABRkdpQAiI3rSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075041; c=relaxed/simple;
	bh=7bgu7IDhlx4kYuUFNAzx1zCLFkyciQLhIazfPAte0+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ab4FVVgnC6DaLdWDhomfFKmoTklZrRuFtQdZa5zpOiEX8EkOktFJ62xAX1NF4nLSDMLduIl0lWga5ARzl2P3J797+5mqByT4qXeaHLrumuCbCS4qGC0vCZrLCoHB3BvDWmdhVDuz5bXbKans1MBlq9GGADBDfh37LMr9HQiqXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDKNj/FV; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so30300a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726075040; x=1726679840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxNwNHkPZNZvdV/Gx7CVzXPyc1s8I0/Mxrc9V3Wdx00=;
        b=YDKNj/FVINLX6r+2ssX1hvYWVYjiWtdS+9cmDtq9e7Qx1CkTf2QeORJaDPaF6TvvwG
         21Vpo6LDKQIjqAubRTw5iTDi70SIeiAsdSE7p0DFLP1j/dDKwi9U3k5fJL1+1llpZRPR
         IrbDMVFKabf3IBYhsj5lXj+PbDzqhOAVUBr2aJeWiOVkX4I00yCGhMkum8aGSphJyLde
         mAm0MKRsxFXl+CDHv3RurYZM72OKdrd2TDUT851Y5OKjFmGClRzS3mY/za06zKPzg5k8
         jWKWtUgcOiVAv7XrTKJWliXaP9v+3nKOZfH16lrki4QB5SSgzLTiUD1VAHQFOhXdnpCE
         OaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075040; x=1726679840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxNwNHkPZNZvdV/Gx7CVzXPyc1s8I0/Mxrc9V3Wdx00=;
        b=T/DDfeS60cNNNIvR39RNDwFEnXnHgeAbA2nS8m6iK+yYeRLeS4+dLs/TLxWRrUF9EE
         SuxlEr5tMa6DHklC2HOzmcMsrFJ0PenT1CRSAiDvfy9qEv9KDPzTlW/KuxmfXxq8+lse
         EltWD27P+8F3P1yNrk2XRozdvw8MFbUC5clOa5A255nuAa2GQZyRJWr0FNJJsLxcIBho
         aLSzPp7doHgOegMVHaVC00Scgc4Jw1AxbNg2snWgQ3KfpYKZdfww1CRPadgm8aK7T5ot
         nhd1RIPkK2unz5Tz6iJmaSgVP4a01oZoSklf5aks9PT8VIXDsCkSld4gNv9WkMG7VQbD
         as7Q==
X-Gm-Message-State: AOJu0Yzy2Rx4mqFvbVqTEwhMqvzrjFmoKSmefbI8ZMNoE2qJCgI5c0Sg
	a3gGMbuTnkC3JzwyS9gg7SoHy0RH8gOpDyIjgDtqp/K2gKc8W+TueZO6XNoQhPfviRR8FpI68Mo
	kzJ0+njvoZyqFDtvgOZLnFIur/w6bWw==
X-Google-Smtp-Source: AGHT+IHjF8yWxPsrsAlpRp688R9Wui6ZciPAWfVy2EcXoIC7X+e9p2vTJuGvsFYt/F9n6XrNuU3Z2ey1qWTrgR8Otdg=
X-Received: by 2002:a17:90b:681:b0:2d8:8bfd:d10b with SMTP id
 98e67ed59e1d1-2dad50cbe2dmr21651434a91.26.1726075039550; Wed, 11 Sep 2024
 10:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911044017.2261738-1-yonghong.song@linux.dev>
In-Reply-To: <20240911044017.2261738-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 10:17:07 -0700
Message-ID: <CAEf4Bzb26NF9=+k_+=pC8wwojsK_Y5kBwLMFVGC34oGQRXy25w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Zac Ecob <zacecob@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 9:40=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Zac Ecob reported a problem where a bpf program may cause kernel crash du=
e
> to the following error:
>   Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
>
> The failure is due to the below signed divide:
>   LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
> LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,=
808,
> but it is impossible since for 64-bit system, the maximum positive
> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
> LLONG_MIN.
>
> So for 64-bit signed divide (sdiv), some additional insns are patched
> to check LLONG_MIN/-1 pattern. If such a pattern does exist, the result
> will be LLONG_MIN. Otherwise, it follows normal sdiv operation.
>
>   [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZp=
AaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=3D@pro=
tonmail.com/
>
> Reported-by: Zac Ecob <zacecob@protonmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f35b80c16cda..d77f1a05a065 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20506,6 +20506,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                     insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_X)) {
>                         bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_AL=
U64;
>                         bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
> +                       bool is_sdiv64 =3D is64 && isdiv && insn->off =3D=
=3D 1;
>                         struct bpf_insn *patchlet;
>                         struct bpf_insn chk_and_div[] =3D {
>                                 /* [R,W]x div 0 -> 0 */
> @@ -20525,10 +20526,32 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                                 BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>                                 BPF_MOV32_REG(insn->dst_reg, insn->dst_re=
g),
>                         };
> +                       struct bpf_insn chk_and_sdiv64[] =3D {
> +                               /* Rx sdiv 0 -> 0 */
> +                               BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, i=
nsn->src_reg,
> +                                            0, 2, 0),
> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, ins=
n->dst_reg),
> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 8),
> +                               /* LLONG_MIN sdiv -1 -> LLONG_MIN */
> +                               BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, i=
nsn->src_reg,
> +                                            0, 6, -1),
> +                               BPF_LD_IMM64(insn->src_reg, LLONG_MIN),

wouldn't it be simpler and faster to just check if insn->dst_reg =3D=3D
-1, and if yes, just negate src_reg? Regardless of src_reg value this
should be correct because by definition division by -1 is a negation.
WDYT?

> +                               BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_X, i=
nsn->dst_reg,
> +                                            insn->src_reg, 2, 0),
> +                               BPF_MOV64_IMM(insn->src_reg, -1),
> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 2),
> +                               BPF_MOV64_IMM(insn->src_reg, -1),
> +                               *insn,
> +                       };
>
> -                       patchlet =3D isdiv ? chk_and_div : chk_and_mod;
> -                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
> -                                     ARRAY_SIZE(chk_and_mod) - (is64 ? 2=
 : 0);
> +                       if (is_sdiv64) {
> +                               patchlet =3D chk_and_sdiv64;
> +                               cnt =3D ARRAY_SIZE(chk_and_sdiv64);
> +                       } else {
> +                               patchlet =3D isdiv ? chk_and_div : chk_an=
d_mod;
> +                               cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
> +                                             ARRAY_SIZE(chk_and_mod) - (=
is64 ? 2 : 0);
> +                       }
>
>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
patchlet, cnt);
>                         if (!new_prog)
> --
> 2.43.5
>

