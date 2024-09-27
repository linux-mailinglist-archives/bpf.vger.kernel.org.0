Return-Path: <bpf+bounces-40408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA2F98841F
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 14:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772391F22932
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AAE18BC0E;
	Fri, 27 Sep 2024 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXyuXyqc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194261779BD
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439815; cv=none; b=WKF+goSoFOn2hl6CkM66XQXM9SHOR9k8GN6uDBXLYP3omz0N8M7S7th4P6tknxD/ETJoZ9IFYPd9qCnVX+6J3ajY98fM4NOcAXdiVJOlQH9TPAzlr1KRhAXZtNTQZpPvUZZXmHRs210hSb+YrzxrVAmAsXxifWxAY0rnI0Gx36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439815; c=relaxed/simple;
	bh=6vZ66p/Av8uwjclA1qbUiQCQA8uZtpE1wGMhiG1Y+1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AkX7vED6LjiT9aC83FAcuoLR1dX5TD+WrSBzwNwJk21iMfKuAtuMjUMItmy8MIVi/RlvWcsl5swkMVJY42Bo9ii7TIYsa2eKLMP6kRiIm9XBI+jrEUb11DMmPsQb8ntJnxvjyvNmidA4k5QuRYb0NAtLyhgEvQ2Z9KHUrN82GM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXyuXyqc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2068acc8b98so22063895ad.3
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727439813; x=1728044613; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6v+Q1bpqUPp20GNNeS2ZMtD4sleGRc8Jollrm9JXrH4=;
        b=RXyuXyqcHB+SLBJnyKMQ69tYTENCCQ3svAJY/fPFGuF5cmBW8mu9UvZ41LJiQeku8B
         n1uUwjb7Jc8ltb/ANc/xy96LUCt3oxnOBhsy1tdnI0rNTGyq5lLhSIiHzgHmm9/ITD16
         PDM4b709GiD9+SXVr/N+xNiLIk6L9QdOJOjNJ+QPqSKWmdfx/zE9KzFP9W544DCxU0Kz
         g/2x0GKc404ZfPaDtntRR/Xd3nusHpg1KzkTU6WX+P7Db/byvwMCWfA68WjndjIOmRci
         5VSuKnOo+TYY7OI/+yeZd6evIuoh4k4Au1x0BSw25EGHghj4aCWc4fLL/kTTEgphlgYn
         TT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727439813; x=1728044613;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6v+Q1bpqUPp20GNNeS2ZMtD4sleGRc8Jollrm9JXrH4=;
        b=ZBT2GCIhBbt2AGlPCQi/tmcjUPNW4HmqZgps23Y/2AcHV5QkjJNZ1lp9s0SRsy4Ayd
         h/HItIw/NqrtTt7BiaIb3Se9BnNBD8r9Jnho8YZJgfZmtmQXr4NsGr2AwChijh7tLDGl
         fInnTgpEbU2X9Md7VAsXV4vsXiGwVL0YbteWfwyLSNN8FwqCukCf6sZku3sXkO3vZk4I
         r69S08hPw9WrlwdYyN+xL0sKNz6OKBXKd+GrjZ4VJeOIqP8dnj6BDOjjIxsQjnKN1gPL
         oLLsSowMoXU9LiZmD/FrpS9ay1ewFoGWMHJEJbtfoFcABCmKEE9/SXj+BSLXJXILtVR+
         +70g==
X-Forwarded-Encrypted: i=1; AJvYcCVbx4+pjlJelhJ1ozTUNMPcrimnMzPoqU68C07qv+drwio45AMG6ndZ8p3FkrxqRaHr2tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ye8htt4Wzd4ezQzcDSMbn/IZF3lhauCebsYYOFOTnGx6ou0h
	5/gcVbmFC5Pu/oED5C2g+F06fLl+okNHG97rrLwZRV7YXmakJW9W
X-Google-Smtp-Source: AGHT+IGniYZUTonv+PPaIuaroy8f2C2rVFD/p3LCTM/MmYPFsFI5tSIK7eYOkhrefPH7m9bS7H92FA==
X-Received: by 2002:a17:903:1c4:b0:207:ded:9cbd with SMTP id d9443c01a7336-20b3729c1b2mr44319515ad.24.1727439813423;
        Fri, 27 Sep 2024 05:23:33 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d633sm12819305ad.156.2024.09.27.05.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 05:23:32 -0700 (PDT)
Message-ID: <1b718d0893bc51ddfa4982aa45894b78cee8858b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Prevent updating extended prog to
 prog_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
Date: Fri, 27 Sep 2024 05:23:28 -0700
In-Reply-To: <aac4921a-3f09-4c62-af92-df9f8412dcf6@linux.dev>
References: <20240923134044.22388-1-leon.hwang@linux.dev>
	 <20240923134044.22388-2-leon.hwang@linux.dev>
	 <b879d9cf7eebd1e38492c76d7878a767b0245923.camel@gmail.com>
	 <aac4921a-3f09-4c62-af92-df9f8412dcf6@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 15:16 +0800, Leon Hwang wrote:

[...]

> There's no protection against concurrent update.
>=20
> > Sequence of actions in bpf_tracing_prog_attach():
> > a. call bpf_trampoline_link_prog(&link->link, tr)
> >    this returns success if `tr->extension_prog` is NULL,
> >    meaning trampoline is "free";
> > b. update tgt_prog->aux->is_extended =3D true.
> >=20
> > Sequence of actions in bpf_tracing_link_release():
> > c. call bpf_trampoline_unlink_prog(&tr_link->link, tr_link->trampoline)
> >    this sets `tr->extension_prog` to NULL;
> > d. update tr_link->tgt_prog->aux->is_extended =3D false.
> >=20
> > In a concurrent environment, is it possible to have actions ordered as:
> > - thread #1: does bpf_tracing_link_release(link pointing to tgt_prog)
> > - thread #2: does bpf_tracing_prog_attach(some_prog, tgt_prog)
> > - thread #1: (c) tr->extension_prog is set to NULL
> > - thread #2: (a) tr->extension_prog is set to some_prog
> > - thread #2: (b) tgt_prog->aux->is_extended =3D true
> > - thread #1: (d) tgt_prog->aux->is_extended =3D false
> >=20
> > Thus, loosing the is_extended mark?
>=20
> Yes, you are correct.
>=20
> >=20
> > (As far as I understand bpf_trampoline_compute_key() call in
> >  bpf_tracing_prog_attach() it is possible for threads #1 and #2 to
> >  operate on a same trampoline object).
> >=20
>=20
> In order to avoid the above case:
>=20
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6988e432fc3d..1f19b754623c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3281,6 +3281,9 @@ static void bpf_tracing_link_release(struct
> bpf_link *link)
>         struct bpf_tracing_link *tr_link =3D
>                 container_of(link, struct bpf_tracing_link, link.link);
>=20
> +       if (link->prog->type =3D=3D BPF_PROG_TYPE_EXT)
> +               tr_link->tgt_prog->aux->is_extended =3D false;
> +

Isn't this too early to reset 'is_extended'?
E.g. consider scenario:
- thread #1 enters bpf_tracing_link_release() and sets is_extended =3D=3D f=
alse
- thread #2 enters prog_fd_array_get_ptr(), is_extended is false,
            and it proceeds putting tgt_prog to an array;
- execution of tgt_prog is triggered and freplace patch is still in effect,
  because thread #1 had not finished bpf_tracing_link_release() yet.
  Here same bug we are trying to protect against (circular tailcall)
  is still potentially visible, isn't it?

>         WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
>                                                 tr_link->trampoline));
>=20
> @@ -3518,6 +3521,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog
> *prog,
>         if (prog->aux->dst_trampoline && tr !=3D prog->aux->dst_trampolin=
e)
>                 /* we allocated a new trampoline, so free the old one */
>                 bpf_trampoline_put(prog->aux->dst_trampoline);
> +       if (prog->type =3D=3D BPF_PROG_TYPE_EXT)
> +               tgt_prog->aux->is_extended =3D true;
>
>         prog->aux->dst_prog =3D NULL;
>         prog->aux->dst_trampoline =3D NULL;
>=20
> In bpf_tracing_link_release():
> 1. update tr_link->tgt_prog->aux->is_extended =3D false.
> 2. bpf_trampoline_unlink_prog().
>=20
> In bpf_tracing_prog_attach():
> 1. bpf_trampoline_link_prog().
> 2. update tgt_prog->aux->is_extended =3D true.
>=20
> Then, it is able to avoid losing the is_extended mark.
>=20
> Thanks,
> Leon
>=20



