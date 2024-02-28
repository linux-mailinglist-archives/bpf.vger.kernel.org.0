Return-Path: <bpf+bounces-22929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FAD86B9CD
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386C81C2349C
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D043FB9E;
	Wed, 28 Feb 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxl5bQE9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B631486257
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155443; cv=none; b=ebhSGB8Il4QZwR4glyL7jGHKB4RbSWn+mCyTUtZQ2UkDp+Jocst2UDKfGtwyAsaY3CqMoqcQ1WwZZZt3Jc5oXgpKNiaIFcv6EYtSblJs5AhFVQCiDKpnKUbHrBRxmYCgkoc20MLXyv4H4sMYKhLdUKyyiJnLqmAm4E1xl4InR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155443; c=relaxed/simple;
	bh=4EAF1IF6qKJAueK9GqkrKYeasFn0U/y2+jdofrlcIVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DkGq2z6V3HOYVAOGKa4qQvIsihquXHWnHvLTHP1EQ9SZcFufSZod+5cxaRDct9ZqCsyoIdg1VlzWT4X2SzPGAN5ovlGUo1fMC25dl92LJjM2XPP97jjtEWdQK3TiV+Gc6hxew0hEC20aFeoIaH1ad7vRPZdBdpTKtJCdLgMc7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxl5bQE9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131316693cso184537e87.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 13:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709155440; x=1709760240; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsqeRVFuSjmfGD4G1Lr0QdZmfg3BaymxWs3SmKnVh7Y=;
        b=fxl5bQE9KWnE9N7b2SFdKENUD0CtgG/UG2DlyZEiaqxK6CUh/sPi8WUu4pmX0aPcxy
         43D2wDh9EmM27XkHtm1KQLvb1yRud8GeFOKSx7wCJPfnzJpS6RZkOJ+VdmQmIfnEVM21
         /URWv6jd1ucmtZOHpkcBUY5GpiRBJre9yLt7AOnBXj3PbAeqYLoLa0nwH29Qwy2MIi3P
         CCeSup5VfKDa3iGYIW/8e4QP1+HoNOJVq6i14LMC9ckMqslf3hO/DHXGVLIFIsUNqHwV
         ExyMpF2eQ2GL0kuwJ6eKJ2W318mr2pF8KxKyQnSoC9DF46t6p27suSFy2b9PO4Ks48HL
         KndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155440; x=1709760240;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsqeRVFuSjmfGD4G1Lr0QdZmfg3BaymxWs3SmKnVh7Y=;
        b=eUSncJfBjtXdQKw8NZl5H51bu6bm3q12LsWsQIXnnE9Hi9TCnPD+1pt2+v2fgjOAu9
         TBXqfLZe9CDHDPwxa0RdiqeHRJG7aKJ7/xxLoFZDD4P0IgHj5Qn1/iqQVxaHcGQrjV0b
         TbIZknM6GGJJg5jJSSf8sO9tmrMshiDHqXqBfpwigcvr6RYKZcoVZnu35B4xB/614T+1
         3BVaqKhR6ULceyvkFQpKVARDAVn1GrBVDaS0eoe1Ad11zGO4UKN+kKjwkD0IzBjbCW2N
         Wz4SLnjCYXrX9seAMk/HWQyn+Oey3eCvoqZxEkk0nWlko6TYHeaX+s9GzFCR2FIJvI0R
         hWhA==
X-Gm-Message-State: AOJu0YwFSLUt2HemAJQhaKk96hFina9WHOH120kdzpBJ7MexQ2YuQaFT
	03VV7/eYv8vD3Vn9pXO6hpXktzLsc5+KUZVFiqu4BTyrzxTXRBSb
X-Google-Smtp-Source: AGHT+IHjvB0huIkKGxpQobKeP/k0chMWsXxolaKV3bIsuFd4pk0mGL3IWDABpBXszJJnocF5I05l2g==
X-Received: by 2002:a19:8c14:0:b0:513:21a9:79a8 with SMTP id o20-20020a198c14000000b0051321a979a8mr83259lfd.62.1709155439521;
        Wed, 28 Feb 2024 13:23:59 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t22-20020ac24c16000000b005130ff68b87sm44851lfq.109.2024.02.28.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:23:59 -0800 (PST)
Message-ID: <b68297add3d07f3beb08fdaf7d7208d52e47976c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: replace env->cur_hist_ent with a
 getter function
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  sunhao.th@gmail.com
Date: Wed, 28 Feb 2024 23:23:57 +0200
In-Reply-To: <CAEf4BzYDtaLU6qXdfVz5gw-Z8Dug35PFDqzBzsbnVXDnP=6X6g@mail.gmail.com>
References: <20240222005005.31784-1-eddyz87@gmail.com>
	 <20240222005005.31784-2-eddyz87@gmail.com>
	 <CAEf4BzYDtaLU6qXdfVz5gw-Z8Dug35PFDqzBzsbnVXDnP=6X6g@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 11:46 -0800, Andrii Nakryiko wrote:
[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 011d54a1dc53..759ef089b33c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3304,24 +3304,34 @@ static bool is_jmp_point(struct bpf_verifier_en=
v *env, int insn_idx)
> >         return env->insn_aux_data[insn_idx].jmp_point;
> >  }
> >=20
> > +static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_ver=
ifier_state *st,
> > +                                                       u32 hist_end, i=
nt insn_idx)
> > +{
> > +       if (hist_end > 0 && st->jmp_history[hist_end - 1].idx =3D=3D in=
sn_idx)
> > +               return &st->jmp_history[hist_end - 1];
> > +       return NULL;
> > +}
> > +
> >  /* for any branch, call, exit record the history of jmps in the given =
state */
> >  static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_v=
erifier_state *cur,
> >                             int insn_flags)
> >  {
> > +       struct bpf_jmp_history_entry *p, *cur_hist_ent;
> >         u32 cnt =3D cur->jmp_history_cnt;
> > -       struct bpf_jmp_history_entry *p;
> >         size_t alloc_size;
> >=20
> > +       cur_hist_ent =3D get_jmp_hist_entry(cur, cnt, env->insn_idx);
> > +
>=20
> This is, generally speaking, not correct to do. You can have a tight
> loop where the instruction with the same insn_idx is executed multiple
> times and so we'll get multiple consecutive entries in jmp_history
> with the same insn_idx. We shouldn't reuse hist_ent for all of them,
> each simulated instruction execution should have its own entry in jump
> history.

You are correct.

> It's fine to use get_jmp_hist_entry() in backtracking, though.
>=20
> I'll look through the rest of patches more closely first before
> suggesting any alternatives. But what you do in this patch is not 100%
> correct.

No need, the patch-set does not rely on capability to push entry for
several states simultaneously. I'll just drop this patch from v2.

[...]

