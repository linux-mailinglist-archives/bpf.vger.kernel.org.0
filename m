Return-Path: <bpf+bounces-52838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD0EA48EAB
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 03:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395A616EC14
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0770814;
	Fri, 28 Feb 2025 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpuBWD59"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152B276D38;
	Fri, 28 Feb 2025 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710091; cv=none; b=eI+QrG0rZU6zQ8SfrLe5dohPoRO//t+midxP6f5vvOpzwCauwkCZtmkWR57zkAxR//p+EkMOlOiIj3TfvbDz4an0D4NvdLw1+/cHML1JTtioCS2LvBNLmnKaZMBy3E69UxZBDDrJEvXX9f9DR7Ne4Ob4EbXAYWnl97nWboiGI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710091; c=relaxed/simple;
	bh=Nwbk18fFundri4srjQgDAjVz5XdQUmMBVH2JLot1S14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgvboaelOByzTCFt1xytHynfVkXKx0PLoHN/UjFLXKyWTLidk9PbS7KX03OeVpeDIVC1jq5Dol7QIIgTgeGdsHu+7UoY61IvRHCg01zQH1W0Vxt2pDwCFDj4VXCnDZgHwujx0eaI5NILvjDbbvVuSYbN//1UBK5ydzKx38qIZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpuBWD59; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so10382505e9.1;
        Thu, 27 Feb 2025 18:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740710088; x=1741314888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz5+zIl8AagGesbEPzIBdJPgWyVXVv9NAUNPVVIqzBg=;
        b=EpuBWD59BVZSNPUeuAeJTZRQI+h+ceKYlYvisRjU/Ormp+OyHHrZB/FotL1+GIiL+7
         w5FFBUps0NdIp7/JTsNjUiujGLkqZ74IqR+wlWxhItFVEY1+em4xwkQtHXa2kNeCOkpC
         dKp9hg88IyXzz2x5q2WywN7mtLXHvcG36M5/lHfLWYVOHb8AgwoL3/EV9Wb5tnwd11rt
         j4sm1RuMn4/0kZQ+xvIJdUxHH03hLqYCl9HJvw4K2oMgbeFAmeSUs2L0UsqCpoAFNWmX
         kC7GsQrlQb79IlzfrXKW5m89ETvXZPxyvtrGbbODrctmYEPrNyZlqJItPBIQVtGYnXz0
         SnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710088; x=1741314888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz5+zIl8AagGesbEPzIBdJPgWyVXVv9NAUNPVVIqzBg=;
        b=vtBsJyskMt9u9WSuD3t3sI17LU2yTbOMapnaHwaH0gtqZLjsLp7dcSCY4H7u5pHr/P
         62vcAGyiOJMuOW/T1E3hatr+hIwy8TY/AOmW7PTZ0tDUue5VWcgxppWU8I644lks86cp
         bHfoyu5xn9DkmadmrU2R0dmeBdSGvR/tj5Y6FuGBX1c0NfcYkYkEtFoCt8TqnGPEMvFr
         m6o6dZriVn5wWjMDq08qGcWCVoFJPqJxxQLTp7Y2dc7WKWp/LFB7yA3uj8LNYCoedYtE
         j2ugdrutk2R100eV83Qvlo3dKbQnns7XWUlBS9xxiOeT4Di4V9wFhGgRFvVAkzCOXAbb
         ATHw==
X-Forwarded-Encrypted: i=1; AJvYcCUFjiAQiTa5vdpMLXTWIla1xNnlAmyzW8En3LULRgeUes0HrWn/omI0mzZpnX6Qb4CHYuKTxtNY/rNaX7vt@vger.kernel.org, AJvYcCWN98L40imjLmWcA/ZG1FVGDNdjxtYV0C6pg4u7E2fABPbBQJUkDKJFqAu4o0d/84EuKz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwA48Lr7fX6Cm+IBZFdBeL59sSwt0nI0+A5h/xgFw+07ObF92
	2Q5QYDKN5rOJXJ7qTk2DQ4H5wCKcLquD30cbQR7Owpb+ktLo7cYMws3lf5EeGkxgPV9pzrZiv8a
	ptrqFwhR998ZPrqz5r6veFBIcS54=
X-Gm-Gg: ASbGncvgSVHAXnJn2C+ZBejWGWSpHmIO2Y44oXJ69zOQ5fs/Y31Horp7/OJ16Lzn9P4
	WrY9i465Sm2mopU1gcpiuIboT2SPxCvHGich+s9zlNCLwQCj7LlPa4yKcOOigCpMN7DMt14a6yW
	x90KYjT6gznfRb6T/HBGuzJbuTb5e3soYGZyRx8IM=
X-Google-Smtp-Source: AGHT+IH6Baum4hAFK40x7IO0UNos6RLQrjWmh/OkapqL0YPg8EroF3zxdfOukYitnN2XdNDOHCEWGhrYwXOHEv5Yj3Q=
X-Received: by 2002:a05:6000:1883:b0:38d:c55e:ebcf with SMTP id
 ffacd0b85a97d-390eca3871fmr1043619f8f.52.1740710088129; Thu, 27 Feb 2025
 18:34:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DKSgzZB5HZgYN8@slm.duckdns.org> <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DZ9pqlWim8EIwk@slm.duckdns.org>
In-Reply-To: <Z8DZ9pqlWim8EIwk@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Feb 2025 18:34:37 -0800
X-Gm-Features: AQ5f1JqDFWw1KvrEYoFisqNKaf9pVjsuYONBiDdIai_fqNNvX654iPKhRztOKnw
Message-ID: <CAADnVQ+bXk3qTekjVZ7NU0TpCh4zNg1GNFL-zdW++f2=t_BT8Q@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context_sensitive for unified filtering of
 context-sensitive SCX kfuncs
To: Tejun Heo <tj@kernel.org>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:32=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Feb 27, 2025 at 09:23:20PM +0000, Juntong Deng wrote:
> > > > + if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> > > > +     prog->aux->st_ops !=3D &bpf_sched_ext_ops)
> > > > +         return 0;
> > >
> > > Why can't other struct_ops progs call scx_kfunc_ids_unlocked kfuncs?
> > >
> >
> > Return 0 means allowed. So kfuncs in scx_kfunc_ids_unlocked can be
> > called by other struct_ops programs.
>
> Hmm... would that mean a non-sched_ext bpf prog would be able to call e.g=
.
> scx_bpf_dsq_insert()?

Not as far as I can tell.
scx_kfunc_ids_unlocked[] doesn't include scx_bpf_dsq_insert.
It's part of scx_kfunc_ids_enqueue_dispatch[].

So this bit in patch 3 enables it:
+       if ((flags & SCX_OPS_KF_ENQUEUE) &&
+           btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id)=
)

and in patch 2:
+       [SCX_OP_IDX(enqueue)]                   =3D SCX_OPS_KF_ENQUEUE,

So scx_bpf_dsq_insert() kfunc can only be called out
of enqueue() sched-ext hook.

So the restriction is still the same. afaict.

