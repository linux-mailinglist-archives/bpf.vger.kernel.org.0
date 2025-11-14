Return-Path: <bpf+bounces-74559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0817DC5F404
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A325435A4AB
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F734678E;
	Fri, 14 Nov 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMn9qFWZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A222F6926
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152427; cv=none; b=Ljl/a0ob92KTaE8cwVFmx82gERWg0gwjmZH5+nBuIjtKW0ON46dgMPpw0LGGWBFZxvfdKPRHhNYQjAx+dM7MgG77XzczrfmeKfZLVF+2gHQAigk8coog8gz9bGt53iGQwxTm1rR6F5TvaIfNkXKXRO2F8NH4uE5uUNp7jeOtpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152427; c=relaxed/simple;
	bh=9kfm8M92j+rRKrDGYq6tIsJjpA3uV5Xfu6DwwcoiX8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0ffsYC0uJDFsnnqbeyAdnRL/HER4CT6wFworxvy9drUqXttquB2irToZk4SdrNVddeCjZFfNuhJmtN6Iq107AYhtYXBfWX+FQ8OtTXmC2dh9aHV2e2uxOE119Km2mTaEXRW10im1H5FSe1cO/WTq87qbWWMQ99qzZ3PRCe7L1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMn9qFWZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so27155545e9.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 12:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763152424; x=1763757224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ESgW7nTNdkcnPF/xdJJlNyxkEEhguzWkspsjp4IVyk=;
        b=aMn9qFWZ+oQeLAmXns8q4gzpdfoUfWuZ05BtnwNfJ4UpFiXARq8uv0kHRKi3ApBkkH
         d3e+JLzc8yhChwKME6mGk2+6kAMsImDI3q3AgUWU/wuu497yE22geVdFxBKRQ9XPS6Xe
         rZ7NhlBNujFqL920H20bx+rdOAnCztwL4YQ76mrAxkEpPIqPp177DmehN4v/hGe15Pyz
         GunBE2vzPVfmdAzvjFGLMnnJYIIgwHi4XO8EjXMGqUImWnf5W5aVxumGH1NmtbA8isBX
         r/7IIIE5HanyAbNuPOA/TNOhy7aJlRl8tEiTlisnN+FPoOqwAinjwdQEXJbHhCuAhtZL
         GNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763152424; x=1763757224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ESgW7nTNdkcnPF/xdJJlNyxkEEhguzWkspsjp4IVyk=;
        b=Dr/wkpfpN0jE+XRFYewYFJCKbr28nj/8RuQlr5PlXutcvByjw3hDYDIPuKmIaMCa2B
         yMSNluOBcH9IQapqcYgoBm8/OjVisLyx87rhpyKBUSW4BdJsotWyfy75FD2E8pqT0vaZ
         Q8pw7drlll9teCTuPl7zq+b1QR9Oie8zFifCv6UHOGDkt4Ljhc0zZpOna/8cZ8SawWN4
         OELMPfwOOzInVTKw09JT10ijphBa8MD9SyuiWieyK5Fk24fmH2xXnPo2kh0GNGghk7On
         a4NLXV/V2Y483lXHuW2PJoI/xrlN/ooLOTpshdm6ozJCLVjCOAzKrXVxjeJiCkob8jK7
         2G1g==
X-Gm-Message-State: AOJu0Yylh09SE6F36sZQw0giE/0wlOor9+cUS/wVCGCy8UZN/krWXtwV
	zDQje3D8XAK+wST+RkDkQO3oLkLpEOp35r4EBYSPkxuhiE1UqECp1a+chIir+aFwKppXiNHFe+a
	P6lM5lYAYfTMzudkv9bwbSxQ0tCyUhql4j1im
X-Gm-Gg: ASbGncvtcQKm+5plhEna5uAyiwffRZgWhqbrLPnmMJYJOCYV/A/tgrnoSx8/aDDBH31
	RnJKQmDNOZBAmRdJ8e3JNKv1aHQEaw6QRzI/RjuL4PuIYZOOs154aR5RxRKefVCD+/mfcEWHS+h
	cyENAtlfP/qj+e4xmcbj9WdDCy1B/oeWb/RfZjkU0sk48riQt7+wjllFWxX0r/9flKNRfNLrgoM
	MAhv78i0N4t+s6NgBtqnFGvCOxiQoKw3nRhG5D9D+xDYqjflPjwz3tkPMgUlpWfXKf1kiJb8Fdb
	0tZmxYlel8PBG9OoRUtYgBVu3q2c
X-Google-Smtp-Source: AGHT+IHUuRF9RQsrIgVr4ZNkxU/WJmFYkNeUAvAe4CMYCgFhr3N9Iglgbocp5+21m9jvYLC+JjAuCKDaIXUgxnh10o4=
X-Received: by 2002:a05:600c:c494:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-4778fe4ec42mr45353965e9.1.1763152423705; Fri, 14 Nov 2025
 12:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com> <CACkBjsa+J9iW+HoBfWh5V1P6raQGeoL2Ax6=V1HKA-kmWP54+w@mail.gmail.com>
In-Reply-To: <CACkBjsa+J9iW+HoBfWh5V1P6raQGeoL2Ax6=V1HKA-kmWP54+w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 12:33:32 -0800
X-Gm-Features: AWmQ_bkd-rFHhZKD5QPG8yXZqwgUG6nLQ5MwRohffZ51ZQnjdOWIjRHHuYJgwSw
Message-ID: <CAADnVQJRqNm-v-Q5ix5h2eULx3xEzhf47fY6KF=sX0Rj0OF4oA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Recognize special arithmetic shift in
 the verifier
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:10=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> On Fri, Nov 14, 2025 at 4:10=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> [...]
>
> > The conditional branch in dsr_set_ipip6() and its return values
> > are optimized into BPF_ARSH plus BPF_AND:
> >
> > 227: (85) call bpf_skb_store_bytes#9
> > 228: (bc) w2 =3D w0
> > 229: (c4) w2 s>>=3D 31   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xfffffff=
f,smin32=3D-1,smax32=3D0,var_off=3D(0x0; 0xffffffff))
> > 230: (54) w2 &=3D -134   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3Dumax32=3D=
0xffffff7a,smax32=3D0x7fffff7a,var_off=3D(0x0; 0xffffff7a))
> >
> > after insn 230 the register w2 can only be 0 or -134,
> > but the verifier approximates it, since there is no way to
> > represent two scalars in bpf_reg_state.
> > After fallthough at insn 232 the w2 can only be -134,
> > hence the branch at insn
> > 239: (56) if w2 !=3D -136 goto pc+210
> > should be always taken, and trapping insn 258 should never execute.
> > LLVM generated correct code, but the verifier follows impossible
> > path and rejects valid program. To fix this issue recognize this
> > special LLVM optimization and fork the verifier state.
> > So after insn 229: (c4) w2 s>>=3D 31
> > the verifier has two states to explore:
> > one with w2 =3D 0 and another with w2 =3D 0xffffffff
> > which makes the verifier accept bpf_wiregard.bpf.c
> >
>
> Tested on my local setup, it solves the Cilium cases as expected.
>
> However, this feels ad hoc: spitting states on very specific ranges.
> For 1588 false rejections collected here[1], after this patch, 1561/1588

1588, but the paper said 503 ? ;)
Yeah. I did look at them.

> are still rejected. One can confirm this with the `load_progs.py` in my
> repo (disable the `-d` option for bpftool if too slow).
>
> I am wondering why not adopting the general solution introduced in this R=
FC[2].
> What are the concerns and (potential) confusions? With this design, those

yeah. Will reply in that thread.

> false rejections can be solved in a unified way (e.g., 1226/1588 are load=
ed,
> the rest can be improved with a bit more refinement, except for the ones
> requiring better loop handling).
>
> [1] Progs: https://github.com/SunHao-0/BCF/tree/main/bpf-progs
> [2] RFC: https://lore.kernel.org/bpf/20251106125255.1969938-1-hao.sun@inf=
.ethz.ch
>
> [...]
> > +static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf=
_insn *insn,
> > +                             struct bpf_reg_state *dst_reg)
> > +{
> > +       struct bpf_verifier_state *branch;
> > +       struct bpf_reg_state *regs;
> > +       bool alu32;
> > +
> > +       if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D=
 0)
> > +               alu32 =3D false;
> > +       else if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_v=
alue =3D=3D 0)
> > +               alu32 =3D true;
> > +       else
> > +               return 0;
> > +
> > +       branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, fa=
lse);
> > +       if (IS_ERR(branch))
> > +               return PTR_ERR(branch);
> > +
> > +       regs =3D branch->frame[branch->curframe]->regs;
> > +       __mark_reg_known(&regs[insn->dst_reg], 0);
>
> Here, the hidden assumption is: smax=3Ds32_max=3D0, which is true if it's=
 called
> by ALU32 ops or some ALU64 (e.g., ARSH), but not for all ALU64. Should
> we add some comments for this in maybe_fork_scalars(), in case it's used
> in other locations?

Well, it's done specifically for ARSH. We won't be calling it blindly
for all operations. Forking for 3 distinct scalars likely doesn't
make sense either.
Here it's targeting a specific compiler optimization.
I was thinking of doing it at AND instead when it sees [-1, 0] in dst_reg,
but doing it in ARSH is more generic, since compiler can do:
// and (not (sra X, size(X)-1))
and we'd need to special case both AND and XOR.

