Return-Path: <bpf+bounces-58674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87FABFDAE
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030053B213E
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB428FA82;
	Wed, 21 May 2025 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQps1h7K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98E1A5B86;
	Wed, 21 May 2025 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747857902; cv=none; b=H0scb6AU4X+sBhLGWxb1sVrNyZWnwcXpizaG6g6a4nOmJ51Qn9Wf0uT3JYdO1UOrAYCxFy90mnSKKZ1t//3/BmflZIXrKWSm2S/9GJI0T71pIGJqghT0IV/wmEnv4MZFJ3mETpW2EnDeu6iwpb6nEs+3wxTqnG3Sf6sL1QwTHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747857902; c=relaxed/simple;
	bh=wMqRVwT/Nyu/9c14xlcNNOnLCeR9/ETKJ25YybtF3l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWdrgNgS5ciXA+SFSXGV18SyYRkBXpcpTl916A8qrv7PLz6U4DHue4ovTncaeofi9qTjIHojpIpMzJITDJaqErTbAMj5IQ1/1M8JbKiDP9sr3wfYwUEtiLJgUmzIsO8RGIqJXyIuhUqYApJAZp5STyby+bqyJ3BNuNfqu/go74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQps1h7K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a36ab95a13so2740663f8f.3;
        Wed, 21 May 2025 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747857899; x=1748462699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9enirY0SQGAYYvH7urd3jEIBdZ8xYI4Y7D4a+GFsDSI=;
        b=BQps1h7K4izv+jOTkOt6dRaXVOI9smtDLtlXsNXSlwpGh5pJhKnkm3RAFvCSuib5+I
         h4lrh1H2f6FAom/6gjfM7QO2NVcs/aEJFaI99vLOGQ/YF7MOemomNu/H7q4vqrJUuhvR
         NeEs5MJKNuBVGaU70qK5MSF4K9c+t4OqjbviZM7sVUw9DZp6++C0Nnxq0dERe8Eo/uBG
         8fa0xJlqFcVLlruE2MoxOLtF8RJSx5MHK0WtxeAlOFguzI2zleM+7kQMj+lUkcV0C64Z
         k1qqlYQoMa4p2eHSXkWdEdCqv9kU0488VBI6av2N1n/M3Py0bNmVIyqlImzsK7DSpIij
         Xdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747857899; x=1748462699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9enirY0SQGAYYvH7urd3jEIBdZ8xYI4Y7D4a+GFsDSI=;
        b=WOnCu937hZFvBzeu+I4w4JImWtqrsz40WIn39PMxJH8hJIU41vgwR67zwkFrVjvUUS
         fUTu+1gQstWp19j1Ox/t7JSbmT4ZHo3fSaIuQtjf4lVVkPqsNcQZolBXe8JvvWaf1B/O
         XysqtFiXXQ50aw0C+h6Gy2tEex88yMjpRtlWEOhLZdkBBUqnJoEmBxZKZfhyXeu4zVym
         0w5kuR8TX8zWYGSXGhwSgTdYN+y1s/p88SY2bvLyGUFDcTVdtGEbQAZgdjblqRfBhVNc
         9Z2VYnVG0A4bAgfLl+HYKYxb1N7qXceaU2eUymGUXmgv8vatK33iy9PK+FOe27CLX3Cv
         +FYw==
X-Forwarded-Encrypted: i=1; AJvYcCUQtDjyTm1eu7R8xL1o0vAqlFtU42equVql3pfomuFxI73QeKmVnHmlximg0aQ8t+/nfiDDMENezy/PiYul@vger.kernel.org, AJvYcCXPeAxYy0uFXZihGOqx/p2OrCJAzzPUKWTLLPZw9+qdG4RciIRceLX+di/zxcO8YQ/jp1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhDjWcvHKeDubWitBEgLiyNLdHwWhIh13e3SCvImSRALCABbV
	fIbuIuJnn3HlW1Qk+/WBJFNFd4BLo3/xzjYi0i1gg39hKZNZj/J1Tcy4QY68H2g3sf6HHif1+4o
	n9p7Oi5ecWHiesGLVbfhoRXpxfDKZs3k=
X-Gm-Gg: ASbGncvkkNMMqK3AswqGL39efV6bwo33b+dYChHcn4nawzr9WU+ORffKPsRsohipmDc
	JgPLgSiWmDSmEcb1vdk6uWU3tn9DboRSWmmo1mNC81+HD3pqBySqaIB3O2R+cUDUIFyNEBZfOnY
	HaSBgGKd1Loi7DksSJoBEtCSB3Da31VghLaZ0yNAYlO+wckW4xjqLmk6azVjeZcA==
X-Google-Smtp-Source: AGHT+IH6ZeaOWdlt8xat0t3dm+8LQC6if6IHF+lydOJLJMjJKR2mjaMSP490EsNnacwJILG2meGu/YiDkY4eGa8xga4=
X-Received: by 2002:a05:6000:2507:b0:3a3:7031:59da with SMTP id
 ffacd0b85a97d-3a370315bcamr11376204f8f.59.1747857898663; Wed, 21 May 2025
 13:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521183911.21781-1-puranjay@kernel.org> <80ef5e2e-c2d9-45b7-9a48-f8c1a4767eae@gmail.com>
In-Reply-To: <80ef5e2e-c2d9-45b7-9a48-f8c1a4767eae@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 May 2025 13:04:47 -0700
X-Gm-Features: AX0GCFsYH19tcZ41YWJ6fA48uv2fJA3v_n94P_mad8cuG-omsVdikNasd3Hmoho
Message-ID: <CAADnVQLgPBcRAqKfCXQwZae2jKDfp=xSFZCgzHgg-jcBTYp-yw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: verifier: support BPF_LOAD_ACQ in insn_def_regno()
To: Eduard Zingerman <eddyz87@gmail.com>, Peilin Ye <yepeilin@google.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 12:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
>
> On 2025-05-21 11:39, Puranjay Mohan wrote:
> [...]
> > @@ -3643,6 +3643,9 @@ static bool is_reg64(struct bpf_verifier_env *env=
, struct bpf_insn *insn,
> >   /* Return the regno defined by the insn, or -1. */
> >   static int insn_def_regno(const struct bpf_insn *insn)
> >   {
> > +     if (is_atomic_load_insn(insn))
> > +             return insn->dst_reg;
> > +
> >       switch (BPF_CLASS(insn->code)) {
> >       case BPF_JMP:
> >       case BPF_JMP32:
>
> I'm confused, is_atomic_load_insn() is defined as:
>
>           return BPF_CLASS(insn->code) =3D=3D BPF_STX &&
>                  BPF_MODE(insn->code) =3D=3D BPF_ATOMIC &&
>                  insn->imm =3D=3D BPF_LOAD_ACQ;
>
> And insn_def_regno() has the following case:
>
>           case BPF_STX:
>                   if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC ||
>                       BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC) {
>                           if (insn->imm =3D=3D BPF_CMPXCHG)
>                                   return BPF_REG_0;
>                           else if (insn->imm =3D=3D BPF_LOAD_ACQ)
>                                   return insn->dst_reg;
>                           else if (insn->imm & BPF_FETCH)
>                                   return insn->src_reg;
>                   }
>                   return -1;
>
> Why is it not triggering?
>
> Also, can this be tested with a BPF_F_TEST_RND_HI32 flag?
> E.g. see verifier_scalar_ids.c:linked_regs_and_subreg_def() test case.

I suspect it was already fixed by commit
fce7bd8e385a ("bpf/verifier: Handle BPF_LOAD_ACQ instructions in
insn_def_regno()")

