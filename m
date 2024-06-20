Return-Path: <bpf+bounces-32629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB79111CB
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F081F21DEC
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1489A1B47BA;
	Thu, 20 Jun 2024 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvRLtKjV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58224B26;
	Thu, 20 Jun 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910475; cv=none; b=OMGiHd08BwBJz6bePKq373DU29VJ+UJIP7TRnpL6e1sqPy0pudj9vcvHhoSL7UR0ZnEhA0CV8wIn/vUHsiSRzbxn5ra4W4mW5A+0HPqIMWUwwd9HSn3RgsOjb9Af1SPYVEDovUowj83AH2ysYIlBY6Y8gsmomWK03ZuVaN/DIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910475; c=relaxed/simple;
	bh=Zl0MQ5F//vIShhSwK7QizUMKa3AiR9kDJsaVghB82ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peu4+Lyt1OI9WturjT+pAdrml/CjFMfwsWYwPffmNPOTDGY2SAULkPXRXgMrIBJ6gyECUDDzXKzlL+WIhQ0TlGNztX/MVqcFG+dZ+vrta8EZHZ79HivswedQ57qMZi6lFeB+Hd8x83yTK4TJ0q1b/DjDrfm0U5Tk2fCBFK8cJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvRLtKjV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c5362c7c0bso1000161a91.1;
        Thu, 20 Jun 2024 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718910473; x=1719515273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGt2JRQtALM/RnCbKiAn8IbKGgOrqkH34/o6+11hJug=;
        b=VvRLtKjV6olBnFt5R+jmoR+MmEQLRTiVFkxDdJQT8SG2lzjZtTiP9mTFscs/Sg7nk5
         u6BtVcwWaCDeJ/DSnF6Ku4c5tmqjDlxUKywouIiJneEODtmZkBAWuqYf1ZDeSzREzr8U
         beW3/9LMUsMWOZXUmOdpNJl05JccgMzX+lPrLkvT8x7PSowpEnzvBTBxeLKstIkuykD9
         z5iiaDEKGzWVPQoPA6CcQM1Eudkgittw3o+64PHDqSYW6x+bpkBNwyiOeCFxWVjiWoY5
         ZEKgzGLJz92GTi1rJA+NrJ/4+jAsdyF2oiBrBhmqnGSn6h4kvqS6MqqT5wDKJhlITsa0
         BWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718910473; x=1719515273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGt2JRQtALM/RnCbKiAn8IbKGgOrqkH34/o6+11hJug=;
        b=Wr+jByOOeSEJ5WlJ5/6Qr6yAIlG2j1oGlwpPWuUA7O1UzEMpmTvOJ0nHJ3VzXSEMm6
         cQeOuUeHPdABKPQl0AVQTt/B2MgjuxA4+ROEQCQ3vqEmObf3BPauaJzhZ1NwPqE77ekg
         novSD1dxj5/DyZ0U6sWLvbgF+ijyg2SfbQlcXfQ7liswU0US+AS3yGW3FUvlaKV2RVck
         a4eEWknuoTZZ4PNamA2U/qrv3T0eiV7qV2oRTtDIkmwQkqH2QEA1n0jNOmzE7Bs3JFWL
         vz4nyFXV3Zy4aF3DVnZt8QrJtKs64k82yMp2NPkBDV8Znma7ie3XOborLWxxNWGpwbuU
         vpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5SEXXyaQ68r9C21mYh2WdDWtQBJhXE0/t8GvjN6N0tYvJArcG4DAKaNZoMvZXtqDVwrzplIZzus+wVGFnYCGvEkGDXhuqbKBImJfsWjAuqxGp6HbbQ7pasUBtGoXQMZQe
X-Gm-Message-State: AOJu0Yx6nvDOpIO+lC2f41lmCF9QdFU8LS123OdjuPhWhRHi18g1Iu/l
	Z9zB3ADVHR+tLd7b6dqDGzOEQpxSbS9Qwo/ttzkBmkpunf0TX5G0tzDypPqriWk3aobnm52QPqB
	M/c2FO9KvsFIQybqM6T4b5T/k/II=
X-Google-Smtp-Source: AGHT+IH3+l/1TctVl4RaW5vfCW2ILpyk394ab5MKog62jG405QbQzQjqmZaz+Ul3oQXiS6ZZQFbFC+ZyytpJ8u/MTTM=
X-Received: by 2002:a17:90a:f983:b0:2b1:b1a1:1310 with SMTP id
 98e67ed59e1d1-2c7ce37f599mr4490922a91.29.1718910473575; Thu, 20 Jun 2024
 12:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619131334.4297-1-puranjay@kernel.org>
In-Reply-To: <20240619131334.4297-1-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Jun 2024 12:07:40 -0700
Message-ID: <CAEf4BzY+zO5Eu6i3KUoWRhhXbKA3zsKFxAhL5txNMkrgzCL-hQ@mail.gmail.com>
Subject: Re: [PATCH] bpf, arm64: inline bpf_get_current_task/_btf() helpers
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 6:25=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> On ARM64, the pointer to task_struct is always available in the sp_el0
> register and therefore the calls to bpf_get_current_task() and
> bpf_get_current_task_btf() can be inlined into a single MRS instruction.
>
> Here is the difference before and after this change:
>
> Before:
>
> ; struct task_struct *task =3D bpf_get_current_task_btf();
>   54:   mov     x10, #0xffffffffffff7978        // #-34440
>   58:   movk    x10, #0x802b, lsl #16
>   5c:   movk    x10, #0x8000, lsl #32
>   60:   blr     x10          -------------->    0xffff8000802b7978 <+0>: =
    mrs     x0, sp_el0
>   64:   add     x7, x0, #0x0 <--------------    0xffff8000802b797c <+4>: =
    ret
>
> After:
>
> ; struct task_struct *task =3D bpf_get_current_task_btf();
>   54:   mrs     x7, sp_el0
>
> This shows around 1% performance improvement in artificial microbenchmark=
.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

These are frequently used helpers, similarly to
get_smp_processor_id(), so I think it makes sense to optimize them.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 720336d28856..b838dab3bd26 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1244,6 +1244,13 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx,
>                         break;
>                 }
>
> +               /* Implement helper call to bpf_get_current_task/_btf() i=
nline */
> +               if (insn->src_reg =3D=3D 0 && (insn->imm =3D=3D BPF_FUNC_=
get_current_task ||
> +                                          insn->imm =3D=3D BPF_FUNC_get_=
current_task_btf)) {
> +                       emit(A64_MRS_SP_EL0(r0), ctx);
> +                       break;
> +               }
> +
>                 ret =3D bpf_jit_get_func_addr(ctx->prog, insn, extra_pass=
,
>                                             &func_addr, &func_addr_fixed)=
;
>                 if (ret < 0)
> @@ -2581,6 +2588,8 @@ bool bpf_jit_inlines_helper_call(s32 imm)
>  {
>         switch (imm) {
>         case BPF_FUNC_get_smp_processor_id:
> +       case BPF_FUNC_get_current_task:
> +       case BPF_FUNC_get_current_task_btf:
>                 return true;
>         default:
>                 return false;
> --
> 2.40.1
>

