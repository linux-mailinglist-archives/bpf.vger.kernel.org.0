Return-Path: <bpf+bounces-11915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35967C5595
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A50282647
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FAE1F94A;
	Wed, 11 Oct 2023 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUlOCVow"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E01F928
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 13:39:12 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559B492;
	Wed, 11 Oct 2023 06:39:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so67659545e9.0;
        Wed, 11 Oct 2023 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697031549; x=1697636349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tmnQJ3/yLVXIA0TYO+2dSZFdLwAsuDmPJu6pajLomU=;
        b=iUlOCVowWHM+fnWmHCibnN8899e5i5rMwWMTWiPRJa2pS8QfU83pF0RNWerJ4kwfHD
         iIftsR4JwSzh6iMJ9yH906aS4f76w9FPw4W32sAUnIfif3gu2HA4s7iL/z1KNZbus7O4
         EkiZw8/68CF58SeubnFKRHd69dmIQoYZlh3z4m8kRVuwnTLMI3+MzAUcNSkgH45L593R
         b0kCq73ZUSTQrK57NMmomv29fB6+Kd7zX1t1TP26rL3W546VyWRmhAd4iHCI7halTTAa
         tyzra2W/sNSEfXxmjYOlCtl7d+TQ+V7c9hRJIFLl+8oE/Q8prqmftUg9/MoyTM34tBgb
         lytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697031549; x=1697636349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tmnQJ3/yLVXIA0TYO+2dSZFdLwAsuDmPJu6pajLomU=;
        b=IMzC4I5oP+tbSe8dzkE/H2WW8U+CONnGawn4tnvtXoDjvWE81265UdNUiJuobCaEdk
         Mp2WElE7FBP8UUWhMV7S4js0NogxaYKPByEhBSxyQx2mawQwBs/E5mIB6s4lrPVU2l1h
         5sdGkyfo3rphgDncA2EhM7OGLw0F7Hw6Ke3o9Bccpu3irTAiBrYPcJA/+O+lYC76bdYe
         6JpbYWAJo5z2rf5N5nwMhmnaGrIyCSUUNGVCBP/po6+lL5OIXkwZTZRUiTLJKcgc9u/N
         DdVN/9Q4bY0i9COIFn9j0kMIYpHvfy5desknJDxAYp3wUOjgT1U94AgNCE5IweD4dxHw
         UABw==
X-Gm-Message-State: AOJu0YwRcGngFp4XywUA7j7sDyZO2VSIz1+r6/urnNVufRaLUrioPAnc
	FGxS5z/1VceffclyH3P6LjcQPCwaG4YFwQCv/kk=
X-Google-Smtp-Source: AGHT+IG5FP7vLcyas7ANzXVKmKR1vpNpQKUGn8e38ubfUHCflqnqGx7/NUsNZXmOgmL+G3WyRD5irigi4XrtoSenvmE=
X-Received: by 2002:a05:600c:2189:b0:405:7400:1e4c with SMTP id
 e9-20020a05600c218900b0040574001e4cmr18975906wme.35.1697031548519; Wed, 11
 Oct 2023 06:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com> <20231011-jmp-into-reserved-fields-v3-1-97d2aa979788@gmail.com>
In-Reply-To: <20231011-jmp-into-reserved-fields-v3-1-97d2aa979788@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Oct 2023 06:38:56 -0700
Message-ID: <CAADnVQJnhfbALtNkCauS_ZwRfybcb_mryEvZW7Uu1uOSshQ9Ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Detect jumping to reserved code
 during check_cfg()
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 2:01=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> Currently, we don't check if the branch-taken of a jump is reserved code =
of
> ld_imm64. Instead, such a issue is captured in check_ld_imm(). The verifi=
er
> gives the following log in such case:
>
> func#0 @0
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> 0: (18) r4 =3D 0xffff888103436000       ; R4_w=3Dmap_ptr(off=3D0,ks=3D4,v=
s=3D128,imm=3D0)
> 2: (18) r1 =3D 0x1d                     ; R1_w=3D29
> 4: (55) if r4 !=3D 0x0 goto pc+4        ; R4_w=3Dmap_ptr(off=3D0,ks=3D4,v=
s=3D128,imm=3D0)
> 5: (1c) w1 -=3D w1                      ; R1_w=3D0
> 6: (18) r5 =3D 0x32                     ; R5_w=3D50
> 8: (56) if w5 !=3D 0xfffffff4 goto pc-2
> mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=3Dr5 stack=3D before 6: (18) r5 =3D 0x32
> 7: R5_w=3D50
> 7: BUG_ld_00
> invalid BPF_LD_IMM insn
>
> Here the verifier rejects the program because it thinks insn at 7 is an
> invalid BPF_LD_IMM, but such a error log is not accurate since the issue
> is jumping to reserved code not because the program contains invalid insn=
.
> Therefore, make the verifier check the jump target during check_cfg(). Fo=
r
> the same program, the verifier reports the following log:
>
> func#0 @0
> jump to reserved code from insn 8 to 7
>
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---
>  kernel/bpf/verifier.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eed7350e15f4..725ac0b464cf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struct =
bpf_verifier_env *env,
>  {
>         int *insn_stack =3D env->cfg.insn_stack;
>         int *insn_state =3D env->cfg.insn_state;
> +       struct bpf_insn *insns =3D env->prog->insnsi;
>
>         if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | FALL=
THROUGH))
>                 return DONE_EXPLORING;
> @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, struct=
 bpf_verifier_env *env,
>                 return -EINVAL;
>         }
>
> +       if (e =3D=3D BRANCH && insns[w].code =3D=3D 0) {
> +               verbose_linfo(env, t, "%d", t);
> +               verbose(env, "jump to reserved code from insn %d to %d\n"=
, t, w);
> +               return -EINVAL;
> +       }

I don't think we should be changing the verifier to make
fuzzer logs more readable.

Same with patch 2. The code is fine as-is.

