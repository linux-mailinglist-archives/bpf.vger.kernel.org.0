Return-Path: <bpf+bounces-33316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9C991B438
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 02:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE27FB21AF3
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 00:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C391C20;
	Fri, 28 Jun 2024 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLw2Wb+g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C763C7
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535438; cv=none; b=asXk2iIBUMlfp7J1GyXmSYPFhCHlhjx+whymN72+zvn7EDg1tBGYqO7V0Vqa8O2RY6ZTG9ubVmJ9WcIZsy7NlpOaUVoeXlCx8+o4QKYLj9nL1YyUPgnZ+i+2CGesQWNA8x/9pHr7Dkk/4AeglyzBJt1sLYgISyZA+XzxYH0oUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535438; c=relaxed/simple;
	bh=SNjUrvlTe9dDQN5h5cjZmGrpKn/roxehNkitHd7vvd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXoSHWZC5BI3N2j81zqB4pZpzcAiPZNYpDw2G8otqs8AFHI/rp2YeJMzkBKCO5J9ABRnuNYcW1TL9ZDXtIGYRNFWKn2aJ9L8MEJCMyZJsJcyEzvBzpoQJ7RFH46x1M+nbEp5AwdPRS6MOu6P/Ld8qtiGEM5BHF8uso6hB9NVOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLw2Wb+g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424adaa6ceeso353725e9.1
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719535435; x=1720140235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4UoH0dJBK6beB2iOZqN2iQB8uCkMuA0NxLFPL2PdL0=;
        b=mLw2Wb+gPO7eEmwtgMmjoKEXH9ho6uNrwHOADJO5jxSlPpWjRmao2z3qiMx21m8BDg
         5LqnHNBLwNuhFwHJJMY5bgmOeEzrJ3Xq0N2aZHRLnczvfRDIlJLlFaUKT+wpDehiCxiP
         t2Gv2ot+5RZ7EZ1p+vDG8iBH/9OivvmG7rYY6nD4COpwYzF4aDhJMACHzB7Owpn3Gzkl
         O+66Plpm6YpxgG0piJjP5nqi8HZZYttiGGrjRr8oZmfKE0Sif/Wp+Pz9KMzzMZNalGj/
         wOOTsL1q5mYQlMpkgR7iEmGwmhIToC+DwOrFNtobK6aYrjHvrWXZA6m+y5Iu9uziwfGf
         r2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535435; x=1720140235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4UoH0dJBK6beB2iOZqN2iQB8uCkMuA0NxLFPL2PdL0=;
        b=kN2KvpIrDmzOyZ78+lSCIqn3fyr3Ss++96Ij0/fgZQMiZF0I+RqJJeydKHVdNDWWd4
         d21Fh1Wct6yjY813M0/8TkjsGUC8QuW1xt3x1dXgECAHywWpknHbzTn8eJF7+bja7GI5
         WSm8BmSjyycC0cKaqa519kurwYVLGIo7JQlaA8R0X1ySyjLlrFkA1cOJVcDcwYpbj+kl
         20iJnw2Lk0KpbgnH/32547e50BKzjo5ttXzihiNQwJzm64hyFdjY+yXFdCt1KDf2XdQd
         W9ZQJSo4ribfLDENGlwe+wAqpYFenHXZ/iGp/Ipmy8ISTKJSWCJt3KhQVf4LZxgC5TCb
         x/iw==
X-Forwarded-Encrypted: i=1; AJvYcCVuRsmedj8asGCGLFfTvAV8svDocGPwZj7zdp6WftKoZW8yNYCw4Nc/r3d2wV45alejZ3nRVALqLEZmOEoa5tKiz5hn
X-Gm-Message-State: AOJu0Yxj+LJBC85wRooLnpSEM1rjMjse1oRsatVR5VVRdFLtWgQQYel+
	XChj7YtXw+bcp9fRBDFzJVi/22kDHmQUaAaiwJIrrw8dOHr/Vgesp0jiBstU/sZ8hVwc4bUIdkQ
	TRxdyvStzn+HOT1pCB24CIlqldbU=
X-Google-Smtp-Source: AGHT+IF1IfLldhysoAGL1SAOiYspCFATfSTn9pZiKdERxLztZuCSuMxUMS6keLrZmtn6aSpcrqDtUfPwuGlEO5cm2Ko=
X-Received: by 2002:a05:600c:32b0:b0:424:ac65:d8df with SMTP id
 5b1f17b1804b1-424ac65d97cmr50376195e9.17.1719535434965; Thu, 27 Jun 2024
 17:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627090900.20017-1-iii@linux.ibm.com> <20240627090900.20017-9-iii@linux.ibm.com>
In-Reply-To: <20240627090900.20017-9-iii@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jun 2024 17:43:42 -0700
Message-ID: <CAADnVQJu6Aci=MGZ2P18=6fydDP+QMiu++PxJ+2aHrnxksg1ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/10] s390/bpf: Support arena atomics
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:09=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> s390x supports most BPF atomics using single instructions, which
> makes implementing arena support a matter of adding arena address to
> the base register (unfortunately atomics do not support index
> registers), and wrapping the respective native instruction in probing
> sequences.
>
> An exception is BPF_XCHG, which is implemented using two different
> memory accesses and a loop. Make sure there is enough extable entries
> for both instructions. Compute the base address once for both memory
> accesses. Since on exception we need to land after the loop, emit the
> nops manually.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/net/bpf_jit_comp.c | 100 +++++++++++++++++++++++++++++++----
>  1 file changed, 91 insertions(+), 9 deletions(-)
>
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 1dd359c25ada..12293689ad60 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -704,6 +704,10 @@ static void bpf_jit_probe_init(struct bpf_jit_probe =
*probe)
>  static void bpf_jit_probe_emit_nop(struct bpf_jit *jit,
>                                    struct bpf_jit_probe *probe)
>  {
> +       if (probe->prg =3D=3D -1 || probe->nop_prg !=3D -1)
> +               /* The probe is not armed or nop is already emitted. */
> +               return;
> +
>         probe->nop_prg =3D jit->prg;
>         /* bcr 0,%0 */
>         _EMIT2(0x0700);
> @@ -738,6 +742,21 @@ static void bpf_jit_probe_store_pre(struct bpf_jit *=
jit, struct bpf_insn *insn,
>         probe->prg =3D jit->prg;
>  }
>
> +static void bpf_jit_probe_atomic_pre(struct bpf_jit *jit,
> +                                    struct bpf_insn *insn,
> +                                    struct bpf_jit_probe *probe)
> +{
> +       if (BPF_MODE(insn->code) !=3D BPF_PROBE_ATOMIC)
> +               return;
> +
> +       /* lgrl %r1,kern_arena */
> +       EMIT6_PCREL_RILB(0xc4080000, REG_W1, jit->kern_arena);
> +       /* agr %r1,%dst */
> +       EMIT4(0xb9080000, REG_W1, insn->dst_reg);
> +       probe->arena_reg =3D REG_W1;
> +       probe->prg =3D jit->prg;
> +}
> +
>  static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
>                               struct bpf_jit_probe *probe)
>  {
> @@ -1523,15 +1542,30 @@ static noinline int bpf_jit_insn(struct bpf_jit *=
jit, struct bpf_prog *fp,
>          */
>         case BPF_STX | BPF_ATOMIC | BPF_DW:
>         case BPF_STX | BPF_ATOMIC | BPF_W:
> +       case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
> +       case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
>         {
>                 bool is32 =3D BPF_SIZE(insn->code) =3D=3D BPF_W;
>
> +               /*
> +                * Unlike loads and stores, atomics have only a base regi=
ster,
> +                * but no index register. For the non-arena case, simply =
use
> +                * %dst as a base. For the arena case, use the work regis=
ter
> +                * %r1: first, load the arena base into it, and then add =
%dst
> +                * to it.
> +                */
> +               probe.arena_reg =3D dst_reg;
> +
>                 switch (insn->imm) {
> -/* {op32|op64} {%w0|%src},%src,off(%dst) */
>  #define EMIT_ATOMIC(op32, op64) do {                                   \
> +       bpf_jit_probe_atomic_pre(jit, insn, &probe);                    \
> +       /* {op32|op64} {%w0|%src},%src,off(%arena) */                   \
>         EMIT6_DISP_LH(0xeb000000, is32 ? (op32) : (op64),               \
>                       (insn->imm & BPF_FETCH) ? src_reg : REG_W0,       \
> -                     src_reg, dst_reg, off);                           \
> +                     src_reg, probe.arena_reg, off);                   \
> +       err =3D bpf_jit_probe_post(jit, fp, &probe);                     =
 \
> +       if (err < 0)                                                    \
> +               return err;                                             \
>         if (insn->imm & BPF_FETCH) {                                    \
>                 /* bcr 14,0 - see atomic_fetch_{add,and,or,xor}() */    \
>                 _EMIT2(0x07e0);                                         \
> @@ -1560,25 +1594,48 @@ static noinline int bpf_jit_insn(struct bpf_jit *=
jit, struct bpf_prog *fp,
>                         EMIT_ATOMIC(0x00f7, 0x00e7);
>                         break;
>  #undef EMIT_ATOMIC
> -               case BPF_XCHG:
> -                       /* {ly|lg} %w0,off(%dst) */
> +               case BPF_XCHG: {
> +                       struct bpf_jit_probe load_probe =3D probe;
> +
> +                       bpf_jit_probe_atomic_pre(jit, insn, &load_probe);
> +                       /* {ly|lg} %w0,off(%arena) */
>                         EMIT6_DISP_LH(0xe3000000,
>                                       is32 ? 0x0058 : 0x0004, REG_W0, REG=
_0,
> -                                     dst_reg, off);
> -                       /* 0: {csy|csg} %w0,%src,off(%dst) */
> +                                     load_probe.arena_reg, off);
> +                       bpf_jit_probe_emit_nop(jit, &load_probe);
> +                       /* Reuse {ly|lg}'s arena_reg for {csy|csg}. */
> +                       if (load_probe.prg !=3D -1) {
> +                               probe.prg =3D jit->prg;
> +                               probe.arena_reg =3D load_probe.arena_reg;
> +                       }
> +                       /* 0: {csy|csg} %w0,%src,off(%arena) */
>                         EMIT6_DISP_LH(0xeb000000, is32 ? 0x0014 : 0x0030,
> -                                     REG_W0, src_reg, dst_reg, off);
> +                                     REG_W0, src_reg, probe.arena_reg, o=
ff);
> +                       bpf_jit_probe_emit_nop(jit, &probe);
>                         /* brc 4,0b */
>                         EMIT4_PCREL_RIC(0xa7040000, 4, jit->prg - 6);
>                         /* {llgfr|lgr} %src,%w0 */
>                         EMIT4(is32 ? 0xb9160000 : 0xb9040000, src_reg, RE=
G_W0);
> +                       /* Both probes should land here on exception. */
> +                       err =3D bpf_jit_probe_post(jit, fp, &load_probe);
> +                       if (err < 0)
> +                               return err;
> +                       err =3D bpf_jit_probe_post(jit, fp, &probe);
> +                       if (err < 0)
> +                               return err;
>                         if (is32 && insn_is_zext(&insn[1]))
>                                 insn_count =3D 2;
>                         break;
> +               }
>                 case BPF_CMPXCHG:
> -                       /* 0: {csy|csg} %b0,%src,off(%dst) */
> +                       bpf_jit_probe_atomic_pre(jit, insn, &probe);
> +                       /* 0: {csy|csg} %b0,%src,off(%arena) */
>                         EMIT6_DISP_LH(0xeb000000, is32 ? 0x0014 : 0x0030,
> -                                     BPF_REG_0, src_reg, dst_reg, off);
> +                                     BPF_REG_0, src_reg,
> +                                     probe.arena_reg, off);
> +                       err =3D bpf_jit_probe_post(jit, fp, &probe);
> +                       if (err < 0)
> +                               return err;
>                         break;
>                 default:
>                         pr_err("Unknown atomic operation %02x\n", insn->i=
mm);
> @@ -2142,9 +2199,25 @@ static struct bpf_binary_header *bpf_jit_alloc(str=
uct bpf_jit *jit,
>                                                struct bpf_prog *fp)
>  {
>         struct bpf_binary_header *header;
> +       struct bpf_insn *insn;
>         u32 extable_size;
>         u32 code_size;
> +       int i;
>
> +       for (i =3D 0; i < fp->len; i++) {
> +               insn =3D &fp->insnsi[i];
> +
> +               if (BPF_CLASS(insn->code) =3D=3D BPF_STX &&
> +                   BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC &&
> +                   (BPF_SIZE(insn->code) =3D=3D BPF_DW ||
> +                    BPF_SIZE(insn->code) =3D=3D BPF_W) &&
> +                   insn->imm =3D=3D BPF_XCHG)
> +                       /*
> +                        * bpf_jit_insn() emits a load and a compare-and-=
swap,
> +                        * both of which need to be probed.
> +                        */
> +                       fp->aux->num_exentries +=3D 1;
> +       }
>         /* We need two entries per insn. */
>         fp->aux->num_exentries *=3D 2;
>
> @@ -2825,3 +2898,12 @@ bool bpf_jit_supports_arena(void)
>  {
>         return true;
>  }
> +
> +bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
> +{
> +       /*
> +        * Currently the verifier uses this function only to check which
> +        * atomic stores to arena are supported, and they all are.
> +        */
> +       return true;

Including all the multi insn instructions that are implemented as loops?
On x86 I left out atomic+fetch+[and|or|xor],
because they're tricky with looping.
Just checking that when an exception happens
the loop is not going to become infinite ?
If I'm reading the code correctly the exception handling will not only
skip one insn, but will skip the whole loop?

