Return-Path: <bpf+bounces-15681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454AD7F4F1C
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21882814C3
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCCB4F5EC;
	Wed, 22 Nov 2023 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaaJ4YH3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FCDB2
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:16:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so287235e9.1
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700676967; x=1701281767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ziyj9RxO/Gi+z/D/gx21VY2iMmQR+es/iZFGxe8ouSY=;
        b=YaaJ4YH3FuAZYqQ8ORBasXImYRkAbX9yAApVwI6NSEWvlVvB+wP+JuVBi/gLMqE9Xg
         aVxTQBLdqVsIzqvCU3P9MTOlQnOExjbtIauYeznWMr9alWm0lrL9RgmzdrEDT+R7TPP1
         BJCqG/rbpHzFdUmikvOnORH9IOAOnX8XEGgNbfxUshf2lEaEhSnQdOVwK7BTnE/a2zEq
         yOyJNmvHTjQjOER8kxEq2uD2jAMaSrjnVDNWLVbytwmRZGjYjVnBaKznq/ZqQ1Yv9ANF
         olEn3awpBrm6hlbgbxRqs0YgWksH1UIXfQZDCU2b4DVRKzlVrFS6uhcMEJv+OQzSbaE5
         NDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676967; x=1701281767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ziyj9RxO/Gi+z/D/gx21VY2iMmQR+es/iZFGxe8ouSY=;
        b=Y9iXKoKXWw9PVtNzIj2o0ok9VIsbL41i9j41tZtWnx57c/+8bf5fERI91Fnd/+mDbT
         UQ92Dm26dTU4BT4MbGKkZbZq442sOqQa5vGTgWfn+nChKo/Ft7N8fClB8fkqdsZaRQiO
         SZst91eanV8T6lRbzqpQOeFtVLvYIMiISr6uuL073O5pmkfx5cCCMwzpkxpv9HnNrE5f
         GMPdwQ8ZYW5S4zLHSITPxFZygQh/AAFV4C2iNrPYr3dEOJclQTXp0MEBaEDzXYMHAeqK
         JtI7ULyQrDOlB/ZER6HsH/0vFssOYGIbEL/vZeiaW5Z20FjxbY7ecXS1SiEN/sEPhZ4J
         vGuA==
X-Gm-Message-State: AOJu0YyZdWhKAw7cmh11q8IL2It4TQAChWHhdp5soHS3TVY9Ul3kZR7T
	TpEchLXK6S1VwuWp+CwSnTE0t2StZNd/MiqxQJE=
X-Google-Smtp-Source: AGHT+IFSl8VR9SN1X59d67J/vHjTifCw1sIWZ/+Vj1ls3TXI21XZ+Gswq9NqA9kXcvItaTru5IqpjNbxd7lgUltdcx0=
X-Received: by 2002:a05:6000:400e:b0:331:3425:b84d with SMTP id
 cp14-20020a056000400e00b003313425b84dmr979693wrb.12.1700676967148; Wed, 22
 Nov 2023 10:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3a518de-ada3-45e8-be3e-df942c2208b5@linux.dev>
 <20231122144018.4047232-1-tao.lyu@epfl.ch> <2e8a1584-a289-4b2e-800c-8b463e734bcb@linux.dev>
In-Reply-To: <2e8a1584-a289-4b2e-800c-8b463e734bcb@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Nov 2023 10:15:55 -0800
Message-ID: <CAADnVQJqmpSoABqd-dCQBU2ExiPda1mHz2pKHv2jzpSMYFMeqQ@mail.gmail.com>
Subject: Re: [PATCH] C inlined assembly for reproducing max<min
To: Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	Eddy Z <eddyz87@gmail.com>
Cc: Tao Lyu <tao.lyu@epfl.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, mathias.payer@nebelwelt.net, meng.xu.cs@uwaterloo.ca, 
	sanidhya.kashyap@epfl.ch, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:08=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> > +SEC("?tc")
> > +__log_level(2)
> > +int test_verifier_range(void)
> > +{
> > +    asm volatile (
> > +        "r5 =3D 100; \
> > +        r5 /=3D 3; \
> > +        w5 >>=3D 7; \
> > +        r5 &=3D -386969681; \
> > +        r5 -=3D -884670597; \
> > +        w0 =3D w5; \
> > +        if w0 & 0x894b6a55 goto +2; \
>
> So actually it is 'if w0 & 0x894b6a55 goto +2' failed
> the compilation.
>
> Indeed, the above operation is not supported in llvm.
> See
>    https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/BPF/BPF=
InstrFormats.td#L62-L74
> the missing BPFJumpOp<0x4> which corresponds to JSET.
>
> The following llvm patch (on top of llvm-project main branch):
>
> diff --git a/llvm/lib/Target/BPF/BPFInstrFormats.td b/llvm/lib/Target/BPF=
/BPFInstrFormats.td
> index 841d97efc01c..6ed83d877ac0 100644
> --- a/llvm/lib/Target/BPF/BPFInstrFormats.td
> +++ b/llvm/lib/Target/BPF/BPFInstrFormats.td
> @@ -63,6 +63,7 @@ def BPF_JA   : BPFJumpOp<0x0>;
>   def BPF_JEQ  : BPFJumpOp<0x1>;
>   def BPF_JGT  : BPFJumpOp<0x2>;
>   def BPF_JGE  : BPFJumpOp<0x3>;
> +def BPF_JSET : BPFJumpOp<0x4>;
>   def BPF_JNE  : BPFJumpOp<0x5>;
>   def BPF_JSGT : BPFJumpOp<0x6>;
>   def BPF_JSGE : BPFJumpOp<0x7>;
> diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td b/llvm/lib/Target/BPF/BP=
FInstrInfo.td
> index 305cbbd34d27..9e75f35efe70 100644
> --- a/llvm/lib/Target/BPF/BPFInstrInfo.td
> +++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
> @@ -246,6 +246,70 @@ class JMP_RI_32<BPFJumpOp Opc, string OpcodeStr, Pat=
Leaf Cond>
>     let BPFClass =3D BPF_JMP32;
>   }
>
> +class JSET_RR<string OpcodeStr>
> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_X.Value,
> +                   (outs),
> +                   (ins GPR:$dst, GPR:$src, brtarget:$BrDst),
> +                   "if $dst "#OpcodeStr#" $src goto $BrDst",
> +                   []> {
> +  bits<4> dst;
> +  bits<4> src;
> +  bits<16> BrDst;
> +
> +  let Inst{55-52} =3D src;
> +  let Inst{51-48} =3D dst;
> +  let Inst{47-32} =3D BrDst;
> +  let BPFClass =3D BPF_JMP;
> +}
> +
> +class JSET_RI<string OpcodeStr>
> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_K.Value,
> +                   (outs),
> +                   (ins GPR:$dst, i64imm:$imm, brtarget:$BrDst),
> +                   "if $dst "#OpcodeStr#" $imm goto $BrDst",
> +                   []> {
> +  bits<4> dst;
> +  bits<16> BrDst;
> +  bits<32> imm;
> +
> +  let Inst{51-48} =3D dst;
> +  let Inst{47-32} =3D BrDst;
> +  let Inst{31-0} =3D imm;
> +  let BPFClass =3D BPF_JMP;
> +}
> +
> +class JSET_RR_32<string OpcodeStr>
> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_X.Value,
> +                   (outs),
> +                   (ins GPR32:$dst, GPR32:$src, brtarget:$BrDst),
> +                   "if $dst "#OpcodeStr#" $src goto $BrDst",
> +                   []> {
> +  bits<4> dst;
> +  bits<4> src;
> +  bits<16> BrDst;
> +
> +  let Inst{55-52} =3D src;
> +  let Inst{51-48} =3D dst;
> +  let Inst{47-32} =3D BrDst;
> +  let BPFClass =3D BPF_JMP32;
> +}
> +
> +class JSET_RI_32<string OpcodeStr>
> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_K.Value,
> +                   (outs),
> +                   (ins GPR32:$dst, i32imm:$imm, brtarget:$BrDst),
> +                   "if $dst "#OpcodeStr#" $imm goto $BrDst",
> +                   []> {
> +  bits<4> dst;
> +  bits<16> BrDst;
> +  bits<32> imm;
> +
> +  let Inst{51-48} =3D dst;
> +  let Inst{47-32} =3D BrDst;
> +  let Inst{31-0} =3D imm;
> +  let BPFClass =3D BPF_JMP32;
> +}
> +
>   multiclass J<BPFJumpOp Opc, string OpcodeStr, PatLeaf Cond, PatLeaf Con=
d32> {
>     def _rr : JMP_RR<Opc, OpcodeStr, Cond>;
>     def _ri : JMP_RI<Opc, OpcodeStr, Cond>;
> @@ -265,6 +329,10 @@ defm JULT : J<BPF_JLT, "<", BPF_CC_LTU, BPF_CC_LTU_3=
2>;
>   defm JULE : J<BPF_JLE, "<=3D", BPF_CC_LEU, BPF_CC_LEU_32>;
>   defm JSLT : J<BPF_JSLT, "s<", BPF_CC_LT, BPF_CC_LT_32>;
>   defm JSLE : J<BPF_JSLE, "s<=3D", BPF_CC_LE, BPF_CC_LE_32>;
> +def JSET_RR    : JSET_RR<"&">;
> +def JSET_RI    : JSET_RI<"&">;
> +def JSET_RR_32 : JSET_RR_32<"&">;
> +def JSET_RI_32 : JSET_RI_32<"&">;
>   }
>
>   // ALU instructions
>
> can solve your inline asm issue. We will discuss whether llvm compiler
> should be implementing this instruction from source or not.

I'd say 'yes'. clang/llvm should support such asm syntax.

Jose, Eduard,
Thoughts?

