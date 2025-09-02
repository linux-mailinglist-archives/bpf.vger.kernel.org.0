Return-Path: <bpf+bounces-67135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD35B3F244
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 04:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD693AB6D5
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 02:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C922E0411;
	Tue,  2 Sep 2025 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUyfCdKJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A51D5CC6
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756779945; cv=none; b=BHlywBQC6nHeeNMchAjOmLJauU/rwIgcskFGjZ5nDwjGLjt+D0J/PNiQfALw7qXM3qyR53etiHZr+KTypsQI0Vy1TXcyOVqYXhjJuq7atMSHU1WAz6f3NBrxy9XMZr2T9UBKshwTWqmrUP5IklKABXsqUv5ZUye5Yj0XjhJxKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756779945; c=relaxed/simple;
	bh=GVw5fDnZHn2chePhARiclhoIBpLRZ16IVMg6N6WIPlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1oxyy54g2e9rWRB0M2wUnIePNivmL7obaM9lQvEHt2XNyg9y8gjWGK5uocfDFduW86p9PEvrNIgAa/WX4XzSHmurEHaxuZcO+hM2ttIlhX2EWqmhOoXPblau0wEx21OOBSmsnWL9J+yHkFdJ5q5m6ncPaNqxMaGN1Kuq/VhZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUyfCdKJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d1bf79d6afso1840925f8f.3
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 19:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756779942; x=1757384742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kse105xkps0LF67+zbRZyhDzMl/4oQqM+OahoxAEFsA=;
        b=mUyfCdKJMCuyfAnms7KyH/NRRSOdHOK1F2HRxpJFbOpSe8azJcWdxYGTmATZkugN9g
         jxI8goPsWOqbZypcLPVJZD1Tmn+HL9o6ipkzH/oY/xm+uMVuDtmZV2hewOCBWN+WVJsA
         rSsT77DH0SSHwmPmIDFMfjs73PkgDi6VSVYZylZK2y0WVFa8wqXp+eUgR1yOgKBnKvtH
         c0WwnEzQ3xkhMvMfvyQN0jJUNUC2OE90MbTB5RlCXcbSLgl2SmH4lKMnqr26OJeMFdB6
         aaCv3CMUgcQJHo8+ebDr85FRoNKu/cf3bvDehQ2NU46N1bRBzRkR335tf1kQxoySXi6q
         dKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756779942; x=1757384742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kse105xkps0LF67+zbRZyhDzMl/4oQqM+OahoxAEFsA=;
        b=I+o1EWAmlDujtgq2Zagz6GxTv+/RIe+c4J1paBPazG/rgwlzsNU3IEapfDuaVsaUKI
         CggVqjJ3m6wM6AtisG6AJQYIepb6ncdaORti+mgVj/efpHNSiudWx8eWxsAMqJG9Vt/h
         KigyRj8s/Yo7GjJnma7MWXLZXU7C5KpLHc+N0sw6/VpbPrg+UYKQT559zrOL/1UyCAIB
         Xm7DVm7YDaW3m8CU8/Kc9hPoIk98/zBFmfIV8jXVjWYVyCpk+HEk3mIlCtVNOjnnn48E
         g3MC2/YzljfxDdL4uhAX4jNJB4XVULKgmmuJaYr4Zm+6KF/Rog0UJxGI2gsTFuZE89QG
         QqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAOUMOZ9MwrYxu87vuh2/dA+fDdYgs2zzqKi+DLO3CBBxiUwI/1b81EtrjggpQA0PFXLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk3yij/rxQbG+HIC8mnKpL6shA6SiFDPgSTOO38jCWOEtMoLHF
	yvzaFx3jkTI7vJ/2g9lNngCn3k/UTZm5skTf5BYiuI7j2g5j4NBPp7/b+kuOc5QKusxhSfLAYJ+
	jOlYJueN5oxfXEW5Any3/K8KQfFmFSkI=
X-Gm-Gg: ASbGnculJGpaevGNGz5E3GaUhTXtHjqn77Ztr/ifTPwzziZHI9dIq2IYM2coI+Fz7tc
	otdQbWf3CmTW9wy0ZA9WfjHyN3FXd6SlZfA/Rx/k3iKND6J53H7plmY30E9YudTv26iSvN+Z5be
	4IIv9C9rcfuquAlVkCMQ8eNNSL/8lvprvMQWCZzqmQC1bfubsnkZR3sX7e0BBWR05L3D1i8InYE
	9+IlHsKqIWycC+oLGRxz9GVfEswn8LGpDQA
X-Google-Smtp-Source: AGHT+IEvZGvr7T6YCVCnoMRV2NQERN8Rxwhvym2XNq9Ze3FF7XtKKKpCK7gaGXrATC88kpAI0RSfL5gz4sG3zvaXs9c=
X-Received: by 2002:a05:6000:2306:b0:3da:6fd3:bc41 with SMTP id
 ffacd0b85a97d-3da6fd3c2a5mr196766f8f.1.1756779941714; Mon, 01 Sep 2025
 19:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901193730.43543-1-puranjay@kernel.org> <20250901193730.43543-3-puranjay@kernel.org>
In-Reply-To: <20250901193730.43543-3-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Sep 2025 19:25:29 -0700
X-Gm-Features: Ac12FXyp6cMrZdWFYQ8xcELemLOfAII4GQzWY38h9eRmmeCAu-phtp9gmZ7t1Qk
Message-ID: <CAADnVQLgcZyUgB2Uq7z8Vc0f=nTWLw8hNPZ2xzVCbWUJxuheQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/4] bpf: core: introduce main_prog_aux for
 stream access
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:37=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> BPF streams are only valid for the main programs, to make it easier to
> access streams from subprogs, introduce main_prog_aux in struct
> bpf_prog_aux.
>
> prog->aux->main_prog_aux =3D prog->aux, for main programs and
> prog->aux->main_prog_aux =3D main_prog->aux, for subprograms.
>
> This makes it easy to access streams like:
> stream =3D bpf_stream_get(stream_id, prog->main_prog_aux);
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/bpf.h   | 1 +
>  kernel/bpf/core.c     | 3 +--
>  kernel/bpf/stream.c   | 6 +++---
>  kernel/bpf/verifier.c | 1 +
>  4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8f6e87f0f3a89..d133171c4d2a9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1633,6 +1633,7 @@ struct bpf_prog_aux {
>         /* function name for valid attach_btf_id */
>         const char *attach_func_name;
>         struct bpf_prog **func;
> +       struct bpf_prog_aux *main_prog_aux;
>         void *jit_data; /* JIT specific data. arch dependent */
>         struct bpf_jit_poke_descriptor *poke_tab;
>         struct bpf_kfunc_desc_tab *kfunc_tab;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ef01cc644a965..dbbf8e4b6e4c2 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -120,6 +120,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int=
 size, gfp_t gfp_extra_flag
>
>         fp->pages =3D size / PAGE_SIZE;
>         fp->aux =3D aux;
> +       fp->aux->main_prog_aux =3D aux;

Though I agree that it's not strictly necessary, this approach
is so much easier to reason about.

Kumar, wdyt?

