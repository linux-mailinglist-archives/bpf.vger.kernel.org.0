Return-Path: <bpf+bounces-12923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EEB7D210B
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 07:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E649028177A
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8ED10EC;
	Sun, 22 Oct 2023 05:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOY2lPkk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B536A
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 05:03:33 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A44DA
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso322803566b.2
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697951010; x=1698555810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpK/D3qHGN/KTfq3sFAcY+mgAtc1aRzrXFXQnZ/Xbp0=;
        b=SOY2lPkkD+CQQYhSiVCNVrv6gncfpJ4W2M7QD0vCHjlP78ohEholh/7uZ4Ww82EEn+
         3eXp32C+7q845hvtx8et7XHn2NAeZV0wh+vOMJO+3aevtiVQ4+m+Bb7Y0JjquS+MWNNw
         uKZknHMlve+0J85ecsxLWecpLRKyCnn1LCg9OKuAV2MHYNbX+xoYN0mw5YTogHHxyiZI
         x4tX1KqdPbJumlSg+i2Dn+Ung5WxGKdQ1/veDbTZyoSa9SJjk+RKOUjzVZiCMurbK9td
         uHaf5qgYLTFfcdXBFUyeTU7+XVkz2AiOxU+aohx6B+YYfAUDIfUIdWtMna1P4wTsJaNe
         FCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697951010; x=1698555810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpK/D3qHGN/KTfq3sFAcY+mgAtc1aRzrXFXQnZ/Xbp0=;
        b=Y/UMzpfSbOjzmxgb1WwSeLrZZET68OoXhc8sOXNBpFHIc9MeF2BjDnLoml7ViLVvNU
         Mg0n1fzwHt69f49zclxsZ7k7cnQiVL5ghcftFszBaBVBT6BgOhqYygILfR3CEdwvNZL/
         UYr4ZQD2Zf26xYBsnwN4AWBEKDbDOdnmvauhOspFtjDI1V77klm0buANMkoAQiZYtWzL
         UP0VH+CtJdc6dFuO+6Pjt3H2+Hak9fBV0o8xAaFhpOvAOJirMjbl+Ig7V9HdZMwUPUab
         /EWKz5vAbEMzIRB4QiSSuURGoy+Jxj62J1cTsH7jizOyn4Xw5AdHn5mbKdOA/qG4PGHa
         MakQ==
X-Gm-Message-State: AOJu0YzHIoaCfsIdm/RiLoFUWnGpzOwIabuJkj10alAS4LY7IZVHci50
	2Oa4G5qFuzxBZdhDjSmTcSkgM9/5XkzS9bYfrMcyoYYW
X-Google-Smtp-Source: AGHT+IE8EZv1Tfb6YmcLa/JGvPVgECuv1zU4Nk39fQS1Wui52YaLW+wlm6i5zqpEW2tKPTj6J12d3SdoKE6ajP1GWzw=
X-Received: by 2002:a17:907:788:b0:9be:2be:e6f5 with SMTP id
 xd8-20020a170907078800b009be02bee6f5mr4564529ejb.76.1697951010196; Sat, 21
 Oct 2023 22:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020220216.263948-1-tao.lyu@epfl.ch>
In-Reply-To: <20231020220216.263948-1-tao.lyu@epfl.ch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 21 Oct 2023 22:03:18 -0700
Message-ID: <CAEf4Bzb6uXiKK4=1++9Lu=GyfU1Co6VcqRwNO8PsQL=TzGzs-A@mail.gmail.com>
Subject: Re: [PATCH] Accept program in priv mode when returning from subprog
 with r10 marked as precise
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	sanidhya.kashyap@epfl.ch, mathias.payer@nebelwelt.net, 
	meng.xu.cs@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 3:02=E2=80=AFPM Tao Lyu <tao.lyu@epfl.ch> wrote:
>
> There is another issue about the backtracking.
> When uploading the following program under privilege mode,
> the verifier reports a "verifier backtracking bug".
>
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> 0: (85) call pc+2
> caller:
>  R10=3Dfp0
> callee:
>  frame1: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> 3: frame1:
> 3: (bf) r3 =3D r10                      ; frame1: R3_w=3Dfp0 R10=3Dfp0
> 4: (bc) w0 =3D w10                      ; frame1: R0_w=3Dscalar(umax=3D42=
94967295,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
> 5: (0f) r3 +=3D r0
> mark_precise: frame1: last_idx 5 first_idx 0 subseq_idx -1
> mark_precise: frame1: regs=3Dr0 stack=3D before 4: (bc) w0 =3D w10
> mark_precise: frame1: regs=3Dr10 stack=3D before 3: (bf) r3 =3D r10
> mark_precise: frame1: regs=3Dr10 stack=3D before 0: (85) call pc+2
> BUG regs 400
>
> This bug is manifested by the following check:
>
> if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
>     verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
>     WARN_ONCE(1, "verifier backtracking bug");
>     return -EFAULT;
> }
>
> Since the verifier allows add operation on stack pointers,
> it shouldn't show this WARNING and reject the program.
>
> I fixed it by skipping the warning if it's privilege mode and only r10 is=
 marked as precise.
>

See my reply to your other email. It would be nice if you can rewrite
your tests in inline assembly, it would be easier to follow and debug.

I think your fix is papering over the fact that we don't recognize
non-r10 stack access. Once we fix that, we shouldn't need extra hacks.
So let's solve the underlying problem first.

> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---
>  kernel/bpf/verifier.c                            |  4 +++-
>  .../bpf/verifier/ret-without-checing-r10.c       | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/verifier/ret-without-chec=
ing-r10.c
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e777f50401b6..1ce80cdc4f1d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3495,6 +3495,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>         u32 dreg =3D insn->dst_reg;
>         u32 sreg =3D insn->src_reg;
>         u32 spi, i;
> +       u32 reg_mask;
>
>         if (insn->code =3D=3D 0)
>                 return 0;
> @@ -3621,7 +3622,8 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>                                  * precise, r0 and r6-r10 or any stack sl=
ot in
>                                  * the current frame should be zero by no=
w
>                                  */
> -                               if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) =
{
> +                               reg_mask =3D bt_reg_mask(bt) & ~BPF_REGMA=
SK_ARGS;
> +                               if (reg_mask && !((reg_mask =3D=3D 1 << B=
PF_REG_10) && env->allow_ptr_leaks)) {
>                                         verbose(env, "BUG regs %x\n", bt_=
reg_mask(bt));
>                                         WARN_ONCE(1, "verifier backtracki=
ng bug");
>                                         return -EFAULT;
> diff --git a/tools/testing/selftests/bpf/verifier/ret-without-checing-r10=
.c b/tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c
> new file mode 100644
> index 000000000000..56e529cf922b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c
> @@ -0,0 +1,16 @@
> +{
> +  "pointer arithmetic: when returning from subprog in priv, do not check=
ing r10",
> +  .insns =3D {
> +       BPF_CALL_REL(2),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
> +       BPF_MOV32_REG(BPF_REG_0, BPF_REG_10),
> +       BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_0),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +  },
> +  .result  =3D ACCEPT,
> +  .result_unpriv =3D REJECT,
> +  .errstr_unpriv =3D "loading/calling other bpf or kernel functions are =
allowed for CAP_BPF and CAP_SYS_ADMIN",
> +},
> --
> 2.25.1
>

