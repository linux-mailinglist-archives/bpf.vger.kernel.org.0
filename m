Return-Path: <bpf+bounces-41636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF3C999399
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A790B1F24C79
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36431D0F52;
	Thu, 10 Oct 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lypza7uO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868918C03D
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591718; cv=none; b=QV9gCv96gJqWwkNbVaKaf7CoCz3iMMES/RRjvF5xXJePpBReE9UTJeas9xI4iVFS6W6TlObsD/R4yaYS2W+C9rNWQJoKZsC1koQKGLaXSfIPiQ8Ai2kTy+MbJqWb5IHDb1Hqp/BT8VBVItzadzu9i5gE3lcT9zeP4R3kCkm0U6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591718; c=relaxed/simple;
	bh=EJDUcm9oHRGK4KS/bQSY+nAVG60U+dbZEDqryFUCvhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkoqfrUWsaXGMQwwy2kAZnDFao5iHC3/EGI3POyfYEyHzFxetNX2o05Mc8qF1khnc8F1M6xSXLP7DTSEeh/4Tn9nmOn/SNQHLQ7k4pd8zQPGAmTcBHQP81JU1bWY8lUDgeDkZQq2fzi1LXRulqqEXj2fLYDSNZX0yCC6gWEFfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lypza7uO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d462c91a9so789644f8f.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728591715; x=1729196515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V3zJxjC7+WDbhvxYAO0e8m3kzqLhsx1ohM62yhQJeA=;
        b=Lypza7uOJDDLpuR0sAGJQyiidHFkHYQQ61aZ7C/JHgNU3xd8lkKBYcUxoSlT8qsQmS
         1QXmI0cnfBpVJYwNwt3nylVNQkLxiKqsWxYWV3F2fFKs3lmFOjxVekamGUcJ9PgQcnfi
         vNjH72Y2Buf/06marMrYG2XFbrzVDenmTvqYoFydMRw/0zpQSdpFrJAMvds2SafWbPXA
         fi1aqX0b94ftcvHdc3UJzvDtwdYRw/o00q66ln2X6P6zzwsw5/5VzEa/OVrxfPp3znYn
         QAheogPn7RFObzEoH1W88BrMdkz2zH0JMJhXFJO4VAPaMO1UCTtgohnUK2+0CVKax9oE
         qQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728591715; x=1729196515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V3zJxjC7+WDbhvxYAO0e8m3kzqLhsx1ohM62yhQJeA=;
        b=qTaj3ra7cjCmwg8dzsHGtFlOBRyG8oYtjkdjtqaOT2wSdzOdRthCpiXynHkN0KNRQv
         eXSRYm6PBJyKEqeLaKG9OAlK0MKq8sNUzJt7YXYnD2aoN+RvmdgK39OTc4tVvROc7ecz
         kVMmyAs0h6oh6gdFHSofLAe23a9wS+rjcxKtLP/kc6XTxAwiBJQgMOjlv4GuBaetoYr4
         tRD2tnCUAhogl/8+1+3L6uhQ4Hv5IJB4eaCcODyfRaJrp0C2udBqndwv/52rYFHmZFni
         62PoRnsBONWmME+3cDhdK7GmfQviO8RBKXBj2YtEsxkFxCGT3KwLUOtC71OVPnVnMXhl
         x7EA==
X-Gm-Message-State: AOJu0YznaanUgDenXzBCNavpzSFvgWqIIbFiXC8pBlagBDSEkZzAs7Xe
	8YPfHd72KaesOLD6viWd1U5Q5KXSSGl3o2RmSid/d7pyzzg0OxeK26SJ46nH0zXO3d9htfmkREI
	mFEZzay6P3x/YRzY4D9Jx5JKfzHQ=
X-Google-Smtp-Source: AGHT+IGtJgJeZOHtbBo6k9zvjwMolbItyG9cXCCHpeCFvuq84gZ8HmckEGbFPK0LvlLuz+fQUZi44d8Gwwrg64UUuho=
X-Received: by 2002:adf:f98a:0:b0:37d:39aa:b9f4 with SMTP id
 ffacd0b85a97d-37d551d416emr227080f8f.26.1728591714938; Thu, 10 Oct 2024
 13:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010175552.1895980-1-yonghong.song@linux.dev> <20241010175633.1898994-1-yonghong.song@linux.dev>
In-Reply-To: <20241010175633.1898994-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 13:21:43 -0700
Message-ID: <CAADnVQJvLWYiEZqEG3SfBf4BvoCvHfXYJ4avCrcXWGNzRunBOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/10] bpf, x86: Create two helpers for some
 arith operations
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:56=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Two helpers are extracted from bpf/x86 jit:
>   - a helper to handle 'reg1 <op>=3D reg2' where <op> is add/sub/and/or/x=
or
>   - a helper to handle 'reg *=3D imm'
>
> Both helpers will be used in the subsequent patch.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 51 ++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a6ba85cec49a..297dd64f4b6a 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1475,6 +1475,37 @@ static void emit_alu_helper_1(u8 **pprog, u8 insn_=
code, u32 dst_reg, s32 imm32)
>         *pprog =3D prog;
>  }
>
> +/* emit ADD/SUB/AND/OR/XOR 'reg1 <op>=3D reg2' operations */
> +static void emit_alu_helper_2(u8 **pprog, u8 insn_code, u32 dst_reg, u32=
 src_reg)
> +{
> +       u8 b2 =3D 0;
> +       u8 *prog =3D *pprog;
> +
> +       maybe_emit_mod(&prog, dst_reg, src_reg,
> +                      BPF_CLASS(insn_code) =3D=3D BPF_ALU64);
> +       b2 =3D simple_alu_opcodes[BPF_OP(insn_code)];
> +       EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
> +
> +       *pprog =3D prog;
> +}
> +
> +/* emit 'reg *=3D imm' operations */
> +static void emit_alu_helper_3(u8 **pprog, u8 insn_code, u32 dst_reg, s32=
 imm32)

_1, _2, _3 ?!

There must be a better way to name the helpers. Like:

_1 -> emit_alu_imm
_2 -> emit_alu_reg
_3 -> emit_mul_imm

