Return-Path: <bpf+bounces-73481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4C2C3283E
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64E218919DC
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F833E35A;
	Tue,  4 Nov 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT35av2h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D233E340
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279567; cv=none; b=giVpjDguojAM/ATOS0UdX7x1TEdK0MC2GdJhWU+9GE/FTiQTTuikgagNk7Ch5wOhn7ig9JZn2J3BvuW//FBAS/gMRDsfrB4V8+qkun8BJwaJU8cF3Xi9TbKdfZksFosQuxjGPxPRrCmsU6QsLoaxm2yDkLk6aErTOsBT9o4aIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279567; c=relaxed/simple;
	bh=H8ZLlmKkIwndxxldMhbidqOECMLkh9ZyAv5XpnMBfZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/Kx07YhzFGNR/ZaV0XaKqtt1PklkSLo6nDmLGXijF5NF3wV3KZX5/TYUUaNxs3rrY8oEc21mBr13uWL38h2Y1VWXzayL+82lpgXeBpZIIUTLAeNHGkAmcl7l5VuYPhP531gjtCLqpGxoWqO9cMCd2yN/ftYqdJh8PTT2kxRkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT35av2h; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42421b1514fso3437592f8f.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279564; x=1762884364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+/Wwmhe4gMRlxnfZ9iBQlyHM5zdtf/Tn2dn5Yb0d1M=;
        b=VT35av2hgQlduzyVHp5Xmk2ejVK/ps93A6K9Xdp/gWGsY4OD6eE9ankbPiRMbnGGyR
         wC1G6Xz8u8O3Soh9/C27mFXvvDbbACU/AK1z0E+VQ3xH0v9nnwhIbAfmt3/p5JKoahrI
         w4bNuahryzy97FbTUN6q4AvEI6Gt5NEyTVLTzUF4ocmsrHA3Zg8P2035aVM9QLr3EuNH
         1QYhfdCqaUFi2RI1fyFflWMhoOp5Co4CPI6G14yATUbLn1a5BafWtO237Jlnqd9hGNZs
         kpJGKKbfqNh5MRDMx8n4NHWqsHiT/4xSrRsxHZy4W5BobIkAG5ctUwKsw6fjes5LNnWh
         kh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279564; x=1762884364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+/Wwmhe4gMRlxnfZ9iBQlyHM5zdtf/Tn2dn5Yb0d1M=;
        b=wDXN/IkE0G19KLQcjymbUkayxjDCn7Tqq+oa1NjAaVkjJFE3meteJNdsmfC/KoZxiC
         /D1kdVi/B9qqu+MPrkt6maqttJ4nnTEICePFGMFTwXmi9KWaKVQKK0TSdnhO/hkwxXWd
         M0bYfMdGp0/xBrYbw3IOqJ6qS7iDaK19eX2lV3vgzkEsAMl0oDfr23+wnbxPADKjPHrQ
         d2RbEEwaDwKZEXax8EOoVgY4tVDmS6TZIiX9Nn7Po2KA8Msv0EmyeTRiV1lrNTWyrIhK
         x1AGL6Ma9V3ev6xl+GmzAwQBzrIEmSbM8p8FXq1WnT51Rnxfs7uh+kNvmarPbrUt6txo
         vlpA==
X-Forwarded-Encrypted: i=1; AJvYcCVFTeUakJnV175QcjS3PJS9RCWu0HkblggdbWqlxIreEDirpVbO9+d25SsiD0TKMHuqbVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRFWRH0bXFymLfUfgSZIImRVVWc8mHqr26a6as1CkBeGR5pMA
	tGzC605fcgWE5J7U7maFoZOCidtSEiFTktfUSa9c/BVQhTQkSQJFMlgRaH1RKt03HLNj/RaRzdy
	fCv6NiFCbDWD6qULEQfK6sSLTSZbG1OE=
X-Gm-Gg: ASbGncsnsYPuudA8VsQDmv2BPCkZ2chKjid9PoB0ZHEtk/HjsU7to5rEF8yvtFmwrCh
	AxWigjgGQDm7tmOM8om5Jo9dYFGLKE3b3QSlCOTAC06DfhvGcUUi5nWo1gVP1KW9l71RW3PFLdo
	OCw2i5+8BJjseekCKdhOr8KUptYJpnPntzxUfhBTKjS/snCVW8KSaAVz44fakvujANmHYKmF2zj
	7JmYX0uB7KSa+298iVE6FAU1a4PC5npqsx69ygyHdHdM8LGqG4gTHI6D4BnWW24DIhxJkr3Xpcn
X-Google-Smtp-Source: AGHT+IF8H9oH0nkEuOTElGDe+MYYkeR6f6lN06d+QNuHQiJgkUEmSAkc/vBW6z2J2SwHJz6GDZCPTULxAFWi65X4kdo=
X-Received: by 2002:a5d:5d09:0:b0:429:c54d:8bd3 with SMTP id
 ffacd0b85a97d-429e331287bmr142157f8f.53.1762279564101; Tue, 04 Nov 2025
 10:06:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104133004.2559222-1-martin.teichmann@xfel.eu> <866547a682b6a159bcbd46a58068c723654e1fcf72b2a09b24d19d927c4f1415@mail.kernel.org>
In-Reply-To: <866547a682b6a159bcbd46a58068c723654e1fcf72b2a09b24d19d927c4f1415@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 10:05:50 -0800
X-Gm-Features: AWmQ_bmGKKFKd_xvv-QeHExL-gNS8D3kjmf-7AngORWzK9mKt7Wz7E8-hA7-INo
Message-ID: <CAADnVQ+VQ-dE2LK1Lqv19g7GN4C7wP8bcwQu8NC_0CBKkhUnKg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: properly verify tail call behavior
To: bot+bpf-ci@kernel.org
Cc: martin.teichmann@xfel.eu, bpf <bpf@vger.kernel.org>, 
	Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:58=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index ff40e5e65..4b7439a48 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -11884,6 +11888,24 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >               env->prog->call_get_func_ip =3D true;
> >       }
> >
> > +     if (func_id =3D=3D BPF_FUNC_tail_call) {
> > +             if (env->cur_state->curframe) {
> > +                     struct bpf_verifier_state *branch;

add empty line.

> > +                     mark_reg_scratched(env, BPF_REG_0);
> > +                     branch =3D push_stack(env, env->insn_idx + 1, env=
->insn_idx, false);
> > +                     if (IS_ERR(branch))
> > +                             return PTR_ERR(branch);
>
> Can push_stack() return an ERR_PTR? Looking at the push_stack()
> function in verifier.c, it returns NULL on all error paths (allocation
> failure at line 2095, copy failure at line 2105, and stack overflow at
> line 2110). Every other call site in the verifier checks for NULL:
>
>   - cluster_alloc_swap_entry() at line 9017: if (!queued_st)
>   - push_callback_call() at line 10608: if (!callback_state)
>   - check_reference_leaks_function() at line 13852: if (!branch)
>   - check_cond_jmp_op() at line 14314: if (branch && insn)
>   - check_iter_next_call() at line 16739: if (!queued_st)
>   - do_check() at line 16858: if (!other_branch)
>
> If push_stack() returns NULL due to memory pressure, IS_ERR(NULL)
> evaluates to false, so the error check won't trigger and the code will
> continue with a NULL branch pointer.

AI is correct, since it reviewed the patch against bpf tree
where push_stack() returns NULL.

This is a non-trivial change. If we land it it will go to bpf-next.
So pls respin with bpf-next tag, so CI can process it properly.

Overall it's an interesting idea!

pw-bot: cr

