Return-Path: <bpf+bounces-21672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1A850168
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 02:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3125F1F24441
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 01:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC71FB5;
	Sat, 10 Feb 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC3HM404"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC663C
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527268; cv=none; b=n9B3LPZihhcufs2rtViBmmPxvI1j4vf4vrVenvP/H6BFMNGgf1MnzWJgYKYZNtGNeQLfTF3V3Qm00PAzYgiJ1VoYovO8LAIdkII6IPXkO+qFnVFURwSeL2VxyrG7GbC4fn7FS4jncnYR+RK3sWNZqkWzibfQQ2rS8AT9TbnnYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527268; c=relaxed/simple;
	bh=d6Vsqe4hIr+w2MVJqPFi3p2Lw7Al3UugVF7P3Vd+Gts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evVd3w/6G3gwPM9ixTWNLlZ31mnb49IFfy42SoUG+RJVM4Dhdf284tgt5RZExY04POey9MomjX4yU+E0rGS2gPOIb9o0sgrYUKk0UdKL9YI4Oud/WK63y7wgzrW0zluA33R+LfK4iM7KNg8YKmeLW8+r3Jk2Z/4S9CWOeEgSygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC3HM404; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e096229192so944758b3a.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 17:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707527265; x=1708132065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd0SiK4IgIfyG+ebZKNSXxYFdhok533l4j+oq6ZHbWU=;
        b=DC3HM404Qy24Di8IwEC/dt0N/9tj8CKaiodzfD2jBSSNshJMq0pk++CK+nuwtZmwdN
         qz+SrmSDVOwse877jSasZFK7KZUamKSxCr1aE2Xul6oegPSSi/OEohjwD7ZYbsC3m94V
         PAA34Cfj4cgMLBSEbdkbom/eFw+CLvTHZ3a4PYYijBdSwzX/pRCaVn2IVsF0YkcwV2jE
         bUx0MZ40ZD3ty/hvXgoHOCjqYqh2saroTA5QPlGVV0iFGQNNgLpyVRgmWNdgk6FF/IeQ
         cRN9uP0zk/gcITzrDgdUzITxD3wASyMBDbLQkJsN2U+Yr8aQU3FEGCliW17Uq5amEWqJ
         S5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707527265; x=1708132065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd0SiK4IgIfyG+ebZKNSXxYFdhok533l4j+oq6ZHbWU=;
        b=AwaRaHRZsx7e79t1XPhythcCf1beX9VwAgqpAR8SfOdbH3prvT8PSDBgREO7FzII+q
         O/FmDB0FaAqaXK3B+GI6O8Y/sOyHNHc6v4ouIcfDSlIVKJu8VueKSzaRnFVlC41mWYx9
         Nl0F/ZQZSg88BYZ/YhGhiXer4+FxiH6J6Dz2I9+kF7T0nZBcFWJLmi65wMwAD1b6Dlt9
         yg8FjHeYFyXVyQ/jYDodCC9WkPzyyaPaex5u8zXSxrkk7F4WaxXlK409NXbDHpLRcxrt
         Cpguvb/Zmq0X3C7/kTsv9PO2lQtHu1HMpu72Guz3vpTvRR1wZqxrRLNvIkaWTzDqTDxQ
         hQ0g==
X-Gm-Message-State: AOJu0YwS7+mRYl7FFP9kx15LQOD6AuQXjrR3QpaNTqXDQf9ayz1ISF/i
	wj2isVmbnhWqonta0ToQ/0UZsNtV4495LPWXz6/H/i+UMs91ZxFIfPNmaZXhxLq6kBuOFk31YSV
	g1fcvW+GxGdRC2sotJ+CCO4tSIOA=
X-Google-Smtp-Source: AGHT+IGnkhei2wbi27BDU0tX/FAp0sxg3hbwT6ebMgl/478G+84esJIwCunDH4oZrY614APdMs5S7m62zxu19aU4UYc=
X-Received: by 2002:a05:6a20:c6cb:b0:19e:bf18:61fe with SMTP id
 gw11-20020a056a20c6cb00b0019ebf1861femr1121894pzb.11.1707527265537; Fri, 09
 Feb 2024 17:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209230908.2380782-1-andrii@kernel.org>
In-Reply-To: <20240209230908.2380782-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Feb 2024 17:07:33 -0800
Message-ID: <CAEf4Bzbjr=8YE=yj0mr=C3vEK+in6TXNFkVVMuFFWhj+Vhg6AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: don't infer PTR_TO_CTX for programs
 with unnamed context type
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:09=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> For program types that don't have named context type name (e.g., BPF
> iterator programs or tracepoint programs), ctx_tname will be a non-NULL
> empty string. For such programs it shouldn't be possible to have
> PTR_TO_CTX argument for global subprogs based on type name alone.
> arg:ctx tag is the only way to have PTR_TO_CTX passed into global
> subprog for such program types.
>
> Fix this loop hole, which currently would assume PTR_TO_CTX whenever
> user uses a pointer to anonymous struct as an argument to their global
> subprogs. This happens in practice with the following (quite common, in
> practice) approach:
>
> typedef struct { /* anonymous */
>     int x;
> } my_type_t;
>
> int my_subprog(my_type_t *arg) { ... }
>
> User's intent is to have PTR_TO_MEM argument for `arg`, but verifier
> will complain about expecting PTR_TO_CTX.
>
> Fixes: 91cc1a99740e ("bpf: Annotate context types")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/btf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8e06d29961f1..d6021290caba 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5725,6 +5725,9 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log,=
 const struct btf *btf,
>                 bpf_log(log, "Please fix kernel include/linux/bpf_types.h=
\n");
>                 return NULL;
>         }
> +       /* program types without named context types work only with arg:c=
tx tag */
> +       if (ctx_tname[0] =3D=3D '\0')
> +               return NULL;

this break s390 because there `bpf_user_pt_regs_t *ctx` was supported
not based on `bpf_user_pt_regs_t` name, but because bpf_user_pt_regs_t
is actually a typedef to anonymous struct... (i.e., by accident). I'll
think about how to fix s390 and will post v2 next week.

>         /* only compare that prog's ctx type name is the same as
>          * kernel expects. No need to compare field by field.
>          * It's ok for bpf prog to do:
> --
> 2.39.3
>

