Return-Path: <bpf+bounces-46302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51229E77EB
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5111A1883B22
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15791F3D46;
	Fri,  6 Dec 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ceo0BnZ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48312206A1
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508928; cv=none; b=BIRtp/IqJTNQbjBl4IFHlnQ0bm8ZqpI4ZQfRQrt4P62k3Howd9XwYz+QlA/9Xc3VjSmf5M/KaLe8vqJlHls4DcJiLuoGPm0YbwdbXeW+VeyL4myzM/rq+RoeM50zPnE56+lVkDFiOXN+VCYWF+vHUovnOTAGHueLnPZxVmOBY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508928; c=relaxed/simple;
	bh=skMkYCAphyr7Nvw4BzHNkrL9SyfFDZht6NbYUxnMvzw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WVUDMzt2sSvExTilE0lf0cglMOUpkN9+7KQ42KO64M3jNSh9IPwHvnj9klH7GPJzhS2EUNU4B9wbf+3mX4AVbClZUV37DQCtOWavumgUXISUi/uU7iH8eolQzGAuEWFGSc5v9Fc74+dVrFRyko2tS8ZKGZS+mouxqZwkoKBtQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ceo0BnZ6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fd17f231a7so1585806a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733508926; x=1734113726; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0H9dBh5VKNo7bPJrD/L4ryrGnpQ5cLpt2RhExbmmTCQ=;
        b=Ceo0BnZ69eEYg7LKY5RH7BrAnx1eIzCRJd8MNrDBCJl2GgUfs2+O7nnMuUrzDVqnMT
         71s0S3wPj+Q4g9w4fCuczBq8XRHdfNWcPYQ1Avu7lAf7Kl7fXVFkjzhTaOXszlgDLoOM
         wfFB+j8WtBlgDj3vmfUxVYzylT0CVNKGLyLXBai51m811E+0HnZ8IMBdEIiXEd8tdckf
         TW6G2kioeXm52+1Os3Rek3sXNEUSH4fU3AQVPUbNVi1waDY3Nqe4Nav3cY3GDbwzyVmD
         JHgp92wRCqI11cnf+9l5ndG8xjY11xSHpYcfRDxHxQr57HNJTV59OHIMzMA+p6ApVrNs
         tCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733508926; x=1734113726;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0H9dBh5VKNo7bPJrD/L4ryrGnpQ5cLpt2RhExbmmTCQ=;
        b=MS8tkUlfJCMS/ntNhzx2t2ZVkmoR3CTICiRF+yB/sQCIu96/oCjVJMLk6zvZsHB/hb
         ugOw4uzRIXQQEGcBJsK6ew1beGuZsMjXw013YExI9xN06QvEI9vs1rMeDz2yT3oWEnht
         Vuh8gXzAiE0nEU2RuwzNEQpEa1S1fuRcyIzcWK1YywTh5GyEecW0ikCGE88pW0HFAzAI
         hBwW1GbLu5hltTbwOYWG9Q9DH917/iYZmjy7gizKIeP+1LMSWDDQ44YRGCJKcT2pkDZ0
         MOZwQqa4uUAPPJedySatfWbddMfgaQkXj/Q+taY30LNZPleMiS/cimuiUyKbjqj0poBH
         Ut5Q==
X-Gm-Message-State: AOJu0YwGGNpL7KEW/D6nZ0Ur3BCiDCtbEpdw73Wg+EX/YJdYJUYoDJbm
	SlZdOGWAInV/qsYIJxsqSHuTjfKTPSgFo/uZwRYjBkUdZyYILxXr
X-Gm-Gg: ASbGncvm5gICWiZTnAYswKIxppcUzd6dnULAAFs6GYUj9kNlNdmAD4icFAspbEbR/t+
	cGL/W/r0UmnoR8MR0e1CirXTXCkpoqgoTjxq7WGIbbQG2PKKx2XjANgDdYRdTKmhCEywqlsjyM9
	/5v3/OtES8JRM9VKJxCv+UAO/P6OtFVoFWOeTBPOQikCv3xFnCXaTr8IbxqebhK6da44fo66DCK
	h8C3ruk+qyZd2C5xTtwkjBEKKcBP1UVzvpZvuoMdFlAPgA=
X-Google-Smtp-Source: AGHT+IHH/bAxjG104Wp7/uSJBj1wIadm6kFjbOJUiqk4WKJzwq1y0WCorUmO8dl3wyV6fAfNdOCwLw==
X-Received: by 2002:a17:90b:2b4d:b0:2ee:e158:125b with SMTP id 98e67ed59e1d1-2ef6aadb89bmr5959178a91.26.1733508926113;
        Fri, 06 Dec 2024 10:15:26 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffc948sm5374543a91.3.2024.12.06.10.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 10:15:25 -0800 (PST)
Message-ID: <6ef10614dfdf281663f62315247c4bb33c2609bc.camel@gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as
 scalar
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Manu Bretelle
 <chantra@meta.com>,  Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann	 <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Kernel Team	 <kernel-team@fb.com>
Date: Fri, 06 Dec 2024 10:15:20 -0800
In-Reply-To: <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
References: <20241206161053.809580-1-memxor@gmail.com>
	 <20241206161053.809580-3-memxor@gmail.com>
	 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 09:59 -0800, Alexei Starovoitov wrote:
> On Fri, Dec 6, 2024 at 8:11=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >=20
> > An implication of this fix, which follows from the way the raw_tp fixes
> > were implemented, is that all PTR_MAYBE_NULL trusted PTR_TO_BTF_ID are
> > engulfed by these checks, and PROBE_MEM will apply to all of them, incl=
.
> > those coming from helpers with KF_ACQUIRE returning maybe null trusted
> > pointers. This NULL tagging after this commit will be sticky. Compared
> > to a solution which only specially tagged raw_tp args with a different
> > special maybe null tag (like PTR_SOFT_NULL), it's a consequence of
> > overloading PTR_MAYBE_NULL with this meaning.
> >=20
> > Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> > Reported-by: Manu Bretelle <chantra@meta.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 82f40d63ad7b..556fb609d4a4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15365,6 +15365,12 @@ static void mark_ptr_or_null_reg(struct bpf_ve=
rifier_env *env,
> >                         return;
> >=20
> >                 if (is_null) {
> > +                       /* We never mark a raw_tp trusted pointer as sc=
alar, to
> > +                        * preserve backwards compatibility, instead ju=
st leave
> > +                        * it as is.
> > +                        */
> > +                       if (mask_raw_tp_reg_cond(env, reg))
> > +                               return;
>=20
> The blast radius is getting too big.
> Patch 1 is ok, but here we're doubling down on
> the hack in commit
> cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
>=20
> I think we need to revert the raw_tp masking hack and
> go with denylist the way Jiri proposed:
> https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/
>=20
> denylist is certainly less safer and it's a whack-a-mole
> comparing to allowlist, but it's much much shorter
> according to Jiri's analysis:
> https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava/
>=20
> Eduard had an idea how to auto generate such allow/denylist
> during the build.
> That could be a follow up.

If the sole goal is to avoid dead code elimination for tracepoint
parameter null check, there might be another hack. Not sure if it was
discussed:
- don't add PTR_MAYBE_NULL (but maybe add a new tag, PTR_SOFT_NULL
  from Kumar's original RFC);
- in is_branch_taken() don't predict anything when tracepoint
  parameters are compared;
- in mark_ptr_or_null_regs() don't propagate null for pointers to
  tracepoint parameters (as in this patch).

Seems pretty confined but can't catch nullable tracepoint parameters
being passed to kfuncs.


